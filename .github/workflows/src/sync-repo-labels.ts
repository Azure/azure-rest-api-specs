import { createHash } from "node:crypto";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { z } from "zod";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { GitHub, GitHubScriptArgs } from "./github.ts";
import {
  DELETED_LABEL,
  existingLabelSchema,
  labelCatalogSchema,
  labelPlanSchema,
  parseLabelCatalog,
  planLabels,
  sameLabel,
} from "./label-catalog.ts";
import type { ExistingLabel } from "./label-catalog.ts";

const CATALOG_PATH = ".github/labels.yaml";
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
  runId: z.number().int().positive(),
  runAttempt: z.number().int().positive(),
  dryRun: z.boolean(),
  catalog: labelCatalogSchema,
  plan: labelPlanSchema,
  replacements: z.array(
    z.strictObject({
      label: existingLabelSchema,
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
  const { data } = await github.rest.repos.getContent({
    ...context.repo,
    path: CATALOG_PATH,
    ref: branch,
  });
  if (Array.isArray(data) || data.type !== "file" || data.encoding !== "base64") {
    throw new Error("Cannot read the default-branch label catalog");
  }
  const content = Buffer.from(data.content, "base64").toString("utf8");
  if (catalogHash(content) !== expectedHash) {
    throw new Error("The default-branch catalog changed; rerun label synchronization");
  }
  parseLabelCatalog(content);
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
  const content = await readFile(options.catalogPath, "utf8");
  const catalog = parseLabelCatalog(content);
  const hash = catalogHash(content);
  await verifyCatalog(args, defaultBranch, hash);
  const plan = planLabels(catalog, await listRepositoryLabels(args.github, args.context.repo));
  const replacements: Audit["replacements"] = [];
  for (const label of plan.unconfigured) {
    args.core.warning(
      `Label not in ${CATALOG_PATH}: ${JSON.stringify(label.name)} (${catalog.unconfiguredLabels})`,
    );
    if (catalog.unconfiguredLabels === "replace") {
      replacements.push({ label, items: await findLabelAssignments(args.github, label) });
    }
  }
  const audit = auditSchema.parse({
    version: 1,
    repository: `${args.context.repo.owner}/${args.context.repo.repo}`,
    defaultBranch,
    sourceSha: options.sourceSha,
    catalogHash: hash,
    runId: args.context.runId,
    runAttempt: args.context.runAttempt,
    dryRun: options.dryRun,
    catalog,
    plan,
    replacements,
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
    !sameLabel(current, label)
  ) {
    throw new Error(`Label changed since the audit: ${label.name}; rerun`);
  }
}

function validateReplacementPlan(audit: Audit) {
  if (audit.catalog.unconfiguredLabels === "preserve" && audit.replacements.length !== 0) {
    throw new Error("Replacement is disabled by the catalog");
  }
  const expected = audit.catalog.unconfiguredLabels === "replace" ? audit.plan.unconfigured : [];
  if (JSON.stringify(audit.replacements.map(({ label }) => label)) !== JSON.stringify(expected)) {
    throw new Error("Replacement candidates do not match the audited plan");
  }
  const configured = new Set(audit.catalog.labels.map((label) => label.name.toLowerCase()));
  if (audit.replacements.some(({ label }) => configured.has(label.name.toLowerCase()))) {
    throw new Error("Cannot replace a configured label");
  }
}

interface Operation {
  action: "create" | "update" | "mark" | "delete";
  label: string;
  number?: number;
  status: "pending" | "completed" | "failed";
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
    validateReplacementPlan(audit);
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
      await verifyLabel(github, context.repo, before);
      await mutate({ action: "update", label: before.name }, () =>
        github.rest.issues.updateLabel({
          ...context.repo,
          name: before.name,
          color: after.color,
          description: after.description,
        }),
      );
    }
    for (const { label, items } of audit.replacements) {
      await verifyCatalog(args, branch, audit.catalogHash);
      await verifyLabel(github, context.repo, label);
      for (const item of items) {
        const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
          ...context.repo,
          issue_number: item.number,
          per_page: PER_PAGE_MAX,
        });
        if (
          labels.some((entry) => entry.name === label.name) &&
          !labels.some((entry) => entry.name.toLowerCase() === DELETED_LABEL)
        ) {
          await mutate({ action: "mark", label: label.name, number: item.number }, () =>
            github.rest.issues.addLabels({
              ...context.repo,
              issue_number: item.number,
              labels: [DELETED_LABEL],
            }),
          );
        }
      }
      const currentItems = await findLabelAssignments(github, label);
      const auditedItems = new Set(items.map((item) => item.number));
      for (const item of currentItems) {
        if (!auditedItems.has(item.number)) {
          throw new Error(`New unaudited assignment of ${label.name} on #${item.number}; rerun`);
        }
        const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
          ...context.repo,
          issue_number: item.number,
          per_page: PER_PAGE_MAX,
        });
        if (!labels.some((entry) => entry.name.toLowerCase() === DELETED_LABEL)) {
          throw new Error(`Replacement marker missing on #${item.number}; keeping ${label.name}`);
        }
      }
      await verifyCatalog(args, branch, audit.catalogHash);
      await verifyLabel(github, context.repo, label);
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
