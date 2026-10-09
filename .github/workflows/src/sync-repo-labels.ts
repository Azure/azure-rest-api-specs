import { createHash } from "node:crypto";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { z } from "zod";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { GitHub, GitHubScriptArgs } from "./github.ts";
import {
  ARCHIVE_DESCRIPTION,
  ARCHIVE_PREFIX,
  existingLabelSchema,
  isArchivedLabelExpired,
  labelCatalogSchema,
  labelPlanSchema,
  originalLabelName,
  planLabels,
  sameLabel,
} from "./label-catalog.ts";
import type { ExistingLabel } from "./label-catalog.ts";
import {
  catalogSourcesSchema,
  LABEL_CATALOG_PATH,
  loadLabelCatalog,
  resolveLabelCatalog,
} from "./label-catalog-loader.ts";

const CATALOG_PATH = LABEL_CATALOG_PATH;
const LABEL_API_HEADERS = { "X-GitHub-Api-Version": "2026-03-10" };
const itemSchema = z.strictObject({
  number: z.number().int().positive(),
  url: z.string().url(),
  kind: z.enum(["issue", "pull_request"]),
  state: z.enum(["OPEN", "CLOSED", "MERGED"]),
});
const auditSchema = z.strictObject({
  version: z.literal(1),
  repository: z.string(),
  defaultBranch: z.string().min(1),
  sourceSha: z.string().regex(/^[0-9a-f]{40}$/),
  catalogHash: z.string(),
  catalogSources: catalogSourcesSchema,
  runId: z.number().int().positive(),
  runAttempt: z.number().int().positive(),
  dryRun: z.boolean(),
  catalog: labelCatalogSchema,
  plan: labelPlanSchema,
  deletions: z.array(
    z.strictObject({
      label: existingLabelSchema,
      items: z.array(itemSchema),
    }),
  ),
  migrations: z.array(
    z.strictObject({
      before: existingLabelSchema,
      target: z.string(),
      items: z.array(itemSchema),
    }),
  ),
});
type Audit = z.infer<typeof auditSchema>;
type AffectedItem = z.infer<typeof itemSchema>;

export function catalogHash(content: string): string {
  return createHash("sha256").update(content).digest("hex");
}

export async function listRepositoryLabels(
  github: GitHub,
  repo: { owner: string; repo: string },
): Promise<ExistingLabel[]> {
  const labels = await github.paginate(github.rest.issues.listLabelsForRepo, {
    ...repo,
    per_page: PER_PAGE_MAX,
  });
  return labels.map((label) => existingLabelSchema.parse(label));
}

function trustedRepository({ context }: GitHubScriptArgs): string {
  const branch: unknown = context.payload.repository?.default_branch;
  if (
    context.repo.owner !== "Azure" ||
    context.repo.repo !== "azure-rest-api-specs" ||
    typeof branch !== "string" ||
    !branch ||
    context.ref !== `refs/heads/${branch}` ||
    !["push", "label", "schedule", "workflow_dispatch"].includes(context.eventName)
  ) {
    throw new Error("Label synchronization may only run on the upstream default branch");
  }
  return branch;
}

async function verifyCatalog(
  { github, context }: GitHubScriptArgs,
  branch: string,
  expectedHash: string,
) {
  const { data: head } = await github.rest.repos.getCommit({
    ...context.repo,
    ref: branch,
  });
  const resolved = await resolveLabelCatalog(async (path) => {
    const { data } = await github.rest.repos.getContent({
      ...context.repo,
      path,
      ref: head.sha,
    });
    if (
      Array.isArray(data) ||
      data.type !== "file" ||
      data.encoding !== "base64" ||
      "target" in data ||
      "submodule_git_url" in data
    ) {
      throw new Error(`Cannot read default-branch label catalog file: ${path}`);
    }
    return Buffer.from(data.content, "base64").toString("utf8");
  });
  if (resolved.hash !== expectedHash) {
    throw new Error("The default-branch catalog changed; rerun label synchronization");
  }
}

const connectionSchema = z.object({
  node: z.object({
    name: z.string(),
    items: z.object({
      totalCount: z.number().int().nonnegative(),
      nodes: z.array(itemSchema.omit({ kind: true })),
      pageInfo: z.object({ hasNextPage: z.boolean(), endCursor: z.string().nullable() }),
    }),
  }),
});

export async function findLabelAssignments(
  github: GitHub,
  label: ExistingLabel,
): Promise<AffectedItem[]> {
  const result: AffectedItem[] = [];
  for (const kind of ["issue", "pull_request"] as const) {
    const connection = kind === "issue" ? "issues" : "pullRequests";
    const states = kind === "issue" ? "[OPEN, CLOSED]" : "[OPEN, CLOSED, MERGED]";
    let cursor: string | null = null;
    const cursors = new Set<string>();
    const items = new Map<number, AffectedItem>();
    let expectedCount: number | undefined;
    do {
      const response: unknown = await github.graphql(
        `query LabelAssignments($id: ID!, $cursor: String, $count: Int!) {
          node(id: $id) {
            ... on Label {
              name
              items: ${connection}(first: $count, after: $cursor, states: ${states}) {
                totalCount
                nodes { number url state }
                pageInfo { hasNextPage endCursor }
              }
            }
          }
        }`,
        { id: label.node_id, cursor, count: PER_PAGE_MAX },
      );
      const { node } = connectionSchema.parse(response);
      if (node.name !== label.name) {
        throw new Error(`Label identity changed during discovery: ${label.name}`);
      }
      if (expectedCount !== undefined && expectedCount !== node.items.totalCount) {
        throw new Error(`Assignments changed during discovery: ${label.name}; rerun`);
      }
      expectedCount = node.items.totalCount;
      for (const item of node.items.nodes) {
        if (items.has(item.number)) {
          throw new Error(`Duplicate assignment during discovery: ${label.name}`);
        }
        items.set(item.number, { ...item, kind });
      }
      cursor = node.items.pageInfo.hasNextPage ? node.items.pageInfo.endCursor : null;
      if (node.items.pageInfo.hasNextPage && (!cursor || cursors.has(cursor))) {
        throw new Error(`Incomplete assignment pagination: ${label.name}`);
      }
      if (cursor) cursors.add(cursor);
    } while (cursor);
    if (items.size !== expectedCount) {
      throw new Error(`Incomplete assignments for ${label.name}`);
    }
    result.push(...items.values());
  }
  return result.sort((a, b) => a.number - b.number);
}

export async function prepareLabelSync(
  args: GitHubScriptArgs,
  options: { catalogPath: string; auditDirectory: string; sourceSha: string; dryRun: boolean },
): Promise<Audit> {
  const defaultBranch = trustedRepository(args);
  const { catalog, hash, sources } = await loadLabelCatalog(options.catalogPath);
  await verifyCatalog(args, defaultBranch, hash);
  const plan = planLabels(catalog, await listRepositoryLabels(args.github, args.context.repo));
  const deletions: Audit["deletions"] = [];
  const migrations: Audit["migrations"] = [];
  for (const label of plan.unconfigured) {
    args.core.warning(
      `Label not in ${CATALOG_PATH}: ${JSON.stringify(label.name)} (${catalog.unconfiguredLabels})`,
    );
  }
  for (const label of plan.delete) {
    deletions.push({ label, items: await findLabelAssignments(args.github, label) });
  }
  for (const migration of plan.migrate) {
    migrations.push({
      ...migration,
      items:
        deletions.find(({ label }) => label.id === migration.before.id)?.items ??
        (await findLabelAssignments(args.github, migration.before)),
    });
  }
  const audit = auditSchema.parse({
    version: 1,
    repository: `${args.context.repo.owner}/${args.context.repo.repo}`,
    defaultBranch,
    sourceSha: options.sourceSha,
    catalogHash: hash,
    catalogSources: sources,
    runId: args.context.runId,
    runAttempt: args.context.runAttempt,
    dryRun: options.dryRun,
    catalog,
    plan,
    deletions,
    migrations,
  });
  const serialized = JSON.stringify(audit, null, 2);
  await mkdir(options.auditDirectory, { recursive: true });
  await writeFile(join(options.auditDirectory, "before.json"), serialized);
  args.core.setOutput("audit-hash", catalogHash(serialized));
  args.core.info(JSON.stringify(plan, null, 2));
  await args.core.summary
    .addRaw(
      `## Repository labels\n\nPolicy: **${catalog.unconfiguredLabels}**; dry-run: **${options.dryRun}**.\n\n` +
        `Create: ${plan.create.length}; update: ${plan.update.length}; ` +
        `archive: ${plan.archive.length}; delete after grace period: ${plan.delete.length}; ` +
        `alias migrations: ${plan.migrate.length}; ` +
        `unconfigured: ${plan.unconfigured.length}; unchanged: ${plan.unchanged}.\n\n` +
        "Full definitions and proposed changes are in the pre-change audit artifact.\n",
    )
    .write();
  return audit;
}

async function verifyLabel(
  github: GitHub,
  repo: { owner: string; repo: string },
  label: ExistingLabel,
) {
  const { data } = await github.rest.issues.getLabel({ ...repo, name: label.name });
  const current = existingLabelSchema.parse(data);
  if (
    current.id !== label.id ||
    current.node_id !== label.node_id ||
    current.name !== label.name ||
    current.archived_at !== label.archived_at ||
    !sameLabel(current, label)
  ) {
    throw new Error(`Label changed since the audit: ${label.name}; rerun`);
  }
}

function validateCleanupPlan(audit: Audit) {
  const candidates = [...audit.plan.archive.map(({ before }) => before), ...audit.plan.delete];
  if (
    audit.catalog.unconfiguredLabels === "preserve" &&
    (candidates.length !== 0 || audit.migrations.length !== 0)
  ) {
    throw new Error("Archival and deletion are disabled by the catalog");
  }
  if (
    JSON.stringify(audit.deletions.map(({ label }) => label)) !== JSON.stringify(audit.plan.delete)
  ) {
    throw new Error("Deletion candidates do not match the audited plan");
  }
  if (
    JSON.stringify(audit.migrations.map(({ before, target }) => ({ before, target }))) !==
    JSON.stringify(audit.plan.migrate)
  ) {
    throw new Error("Alias migrations do not match the audited plan");
  }
  for (const { before, target } of audit.migrations) {
    const definition = audit.catalog.labels.find((label) => label.name === target);
    if (
      !definition?.aliases?.some(
        (alias) => alias.toLowerCase() === originalLabelName(before).toLowerCase(),
      )
    ) {
      throw new Error(`Unconfigured alias migration: ${before.name} -> ${target}`);
    }
  }
  const configured = new Set(audit.catalog.labels.map((label) => label.name.toLowerCase()));
  if (candidates.some((label) => configured.has(originalLabelName(label).toLowerCase()))) {
    throw new Error("Cannot archive or delete a configured label");
  }
  const unconfigured = new Map(audit.plan.unconfigured.map((label) => [label.id, label]));
  if (
    candidates.some((label) => JSON.stringify(label) !== JSON.stringify(unconfigured.get(label.id)))
  ) {
    throw new Error("Archive or deletion candidates are not in the audited inventory");
  }
  for (const { before, name } of audit.plan.archive) {
    const expectedName = ARCHIVE_PREFIX + originalLabelName(before);
    if (
      name.toLowerCase() !== expectedName.toLowerCase() ||
      (before.archived_at !== null && before.description !== ARCHIVE_DESCRIPTION)
    ) {
      throw new Error("Invalid archive rename in the audited plan");
    }
  }
  if (audit.plan.delete.some((label) => !isArchivedLabelExpired(label))) {
    throw new Error("Deletion requires an archived label with our warning past its grace period");
  }
}

interface Operation {
  action: "create" | "update" | "archive" | "migrate" | "delete";
  label: string;
  newName?: string;
  number?: number;
  status: "pending" | "completed" | "failed";
}

async function verifyRenameTarget(
  github: GitHub,
  repo: { owner: string; repo: string },
  label: ExistingLabel,
  newName: string,
) {
  if (newName.toLowerCase() === label.name.toLowerCase()) return;
  try {
    await github.rest.issues.getLabel({ ...repo, name: newName });
  } catch (error) {
    if (error instanceof Error && "status" in error && error.status === 404) return;
    throw error;
  }
  throw new Error(
    `Label name collision: ${JSON.stringify(newName)} already exists. Rerun after resolving it.`,
  );
}

export async function applyLabelSync(
  args: GitHubScriptArgs,
  options: { auditDirectory: string; auditHash: string; artifactId: string },
) {
  const branch = trustedRepository(args);
  const outcome: {
    auditArtifactId: string;
    dryRun: boolean | null;
    operations: Operation[];
    error?: string;
  } = { auditArtifactId: options.artifactId, dryRun: null, operations: [] };
  const saveOutcome = () =>
    writeFile(join(options.auditDirectory, "outcome.json"), JSON.stringify(outcome, null, 2));
  async function mutate(operation: Omit<Operation, "status">, run: () => Promise<unknown>) {
    const record: Operation = { ...operation, status: "pending" };
    outcome.operations.push(record);
    await saveOutcome();
    args.core.info(JSON.stringify(operation));
    try {
      await run();
      record.status = "completed";
    } catch (error) {
      record.status = "failed";
      throw error;
    } finally {
      await saveOutcome();
    }
  }
  const { github, context, core } = args;
  try {
    if (!/^[1-9][0-9]*$/.test(options.artifactId)) {
      throw new Error("A successfully uploaded pre-change audit artifact is required");
    }
    const serialized = await readFile(join(options.auditDirectory, "before.json"), "utf8");
    if (catalogHash(serialized) !== options.auditHash) {
      throw new Error("The audit changed after preparation");
    }
    const audit = auditSchema.parse(JSON.parse(serialized));
    if (
      audit.repository !== `${context.repo.owner}/${context.repo.repo}` ||
      audit.defaultBranch !== branch ||
      audit.runId !== context.runId ||
      audit.runAttempt !== context.runAttempt
    ) {
      throw new Error("The audit does not belong to this repository and workflow run");
    }
    validateCleanupPlan(audit);
    outcome.dryRun = audit.dryRun;
    await verifyCatalog(args, branch, audit.catalogHash);
    if (audit.dryRun) {
      core.info("Dry-run: no label definitions or assignments were changed");
      return;
    }
    for (const label of audit.plan.create) {
      await mutate({ action: "create", label: label.name }, () =>
        github.rest.issues.createLabel({
          ...context.repo,
          name: label.name,
          color: label.color,
          description: label.description,
        }),
      );
    }
    for (const { before, after } of audit.plan.update) {
      await verifyCatalog(args, branch, audit.catalogHash);
      await verifyLabel(github, context.repo, before);
      const newName = originalLabelName(before) !== before.name ? after.name : before.name;
      await verifyRenameTarget(github, context.repo, before, newName);
      await mutate({ action: "update", label: before.name, newName }, async () => {
        const { data } = await github.rest.issues.updateLabel({
          ...context.repo,
          name: before.name,
          new_name: newName,
          color: after.color,
          description: after.description,
          archived: false,
          headers: LABEL_API_HEADERS,
        });
        const restored = existingLabelSchema.parse(data);
        if (
          restored.id !== before.id ||
          restored.node_id !== before.node_id ||
          restored.name !== newName ||
          restored.archived_at !== null
        ) {
          throw new Error(`GitHub did not unarchive configured label ${before.name}`);
        }
      });
    }
    async function verifyAssignments(label: ExistingLabel, items: AffectedItem[], target?: string) {
      const current = await findLabelAssignments(github, label);
      const recorded = new Set(items.map((item) => item.number));
      for (const item of current) {
        if (!recorded.has(item.number)) {
          throw new Error(`New unaudited assignment of ${label.name} on #${item.number}; rerun`);
        }
        if (target) {
          const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
            ...context.repo,
            issue_number: item.number,
            per_page: PER_PAGE_MAX,
          });
          if (!labels.some((entry) => entry.name.toLowerCase() === target.toLowerCase())) {
            throw new Error(
              `Canonical label ${target} missing on #${item.number}; keeping ${label.name}`,
            );
          }
        }
      }
    }
    for (const { before, target, items } of audit.migrations) {
      await verifyCatalog(args, branch, audit.catalogHash);
      await verifyLabel(github, context.repo, before);
      const { data: targetLabel } = await github.rest.issues.getLabel({
        ...context.repo,
        name: target,
      });
      if (existingLabelSchema.parse(targetLabel).archived_at !== null) {
        throw new Error(`Canonical label is archived: ${target}`);
      }
      for (const item of items) {
        const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
          ...context.repo,
          issue_number: item.number,
          per_page: PER_PAGE_MAX,
        });
        if (
          labels.some((label) => label.name === before.name) &&
          !labels.some((label) => label.name.toLowerCase() === target.toLowerCase())
        ) {
          await mutate(
            { action: "migrate", label: before.name, newName: target, number: item.number },
            () =>
              github.rest.issues.addLabels({
                ...context.repo,
                issue_number: item.number,
                labels: [target],
              }),
          );
        }
      }
      await verifyAssignments(before, items, target);
    }
    for (const { before: label, name } of audit.plan.archive) {
      await verifyCatalog(args, branch, audit.catalogHash);
      await verifyLabel(github, context.repo, label);
      const migration = audit.migrations.find(({ before }) => before.id === label.id);
      if (migration) await verifyAssignments(label, migration.items, migration.target);
      await verifyRenameTarget(github, context.repo, label, name);
      await mutate({ action: "archive", label: label.name, newName: name }, async () => {
        const { data } = await github.rest.issues.updateLabel({
          ...context.repo,
          name: label.name,
          new_name: name,
          ...(label.archived_at === null ? { archived: true } : {}),
          description: ARCHIVE_DESCRIPTION,
          headers: LABEL_API_HEADERS,
        });
        const archived = existingLabelSchema.parse(data);
        if (
          archived.id !== label.id ||
          archived.node_id !== label.node_id ||
          archived.name !== name ||
          archived.archived_at === null ||
          archived.description !== ARCHIVE_DESCRIPTION ||
          (label.archived_at !== null && archived.archived_at !== label.archived_at)
        ) {
          throw new Error(`GitHub did not archive label ${label.name} with the managed warning`);
        }
      });
    }
    for (const { label, items } of audit.deletions) {
      await verifyCatalog(args, branch, audit.catalogHash);
      await verifyLabel(github, context.repo, label);
      const migration = audit.migrations.find(({ before }) => before.id === label.id);
      await verifyAssignments(label, items, migration?.target);
      await verifyCatalog(args, branch, audit.catalogHash);
      await verifyLabel(github, context.repo, label);
      if (!isArchivedLabelExpired(label)) {
        throw new Error(`Archive grace period has not elapsed for ${label.name}`);
      }
      await mutate({ action: "delete", label: label.name }, () =>
        github.rest.issues.deleteLabel({ ...context.repo, name: label.name }),
      );
    }
  } catch (error) {
    outcome.error = error instanceof Error ? error.message : String(error);
    core.error(outcome.error);
    throw error;
  } finally {
    await saveOutcome();
    await core.summary
      .addRaw(
        `\nCompleted operations: ${outcome.operations.filter((op) => op.status === "completed").length}. ` +
          `Result: **${outcome.error ? "failed (see outcome artifact)" : "success"}**.\n`,
      )
      .write();
  }
}
