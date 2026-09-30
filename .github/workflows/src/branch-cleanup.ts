import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join, matchesGlob } from "node:path";
import { z } from "zod";
import { execFile } from "../../shared/src/exec.ts";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { Core, GitHub, GitHubScriptArgs } from "./github.ts";

const DAY_MS = 24 * 60 * 60 * 1000;
const BATCH_SIZE = 50;
const PRESERVED_NAMES = new Set([
  "main",
  "master",
  "develop",
  "gh-pages",
  "typespec-next",
  "rpsaas",
  "rpsaasmaster",
  "rpsaascanary",
  "armcorerpdev",
]);
const PRESERVED_PREFIXES = [
  "dev-",
  "dev/",
  "release-",
  "release/",
  "feature-",
  "feature/",
  "published/",
  "archive/",
  "hotfix/",
];

export interface Branch {
  name: string;
  target: { oid: string; committedDate: string };
  branchProtectionRule: { pattern: string } | null;
  openPullRequests: { totalCount: number };
  associatedPullRequests: { nodes: { updatedAt: string }[] };
}

export interface Protection {
  defaultBranch: string;
  rules: { include: string[]; exclude: string[] }[];
}

interface Page<T> {
  nodes: T[];
  pageInfo: { hasNextPage: boolean; endCursor: string | null };
}

const decisionSchema = z.object({
  branch: z.string().min(1),
  sha: z.string().regex(/^[0-9a-f]{40}$/),
  retention: z.enum(["90 days", "3 years"]),
  lastCommitAt: z.iso.datetime({ offset: true }),
  lastPrActivityAt: z.iso.datetime({ offset: true }).nullable(),
  reason: z.enum(["eligible", "preserved", "protected", "open-pr", "recent-activity"]),
});
type Decision = z.infer<typeof decisionSchema>;

const planSchema = z.object({
  repository: z.string(),
  createdAt: z.iso.datetime({ offset: true }),
  branches: z.array(decisionSchema),
});
type Plan = z.infer<typeof planSchema>;

const BRANCH_FIELDS = `
  name
  target { oid ... on Commit { committedDate } }
  branchProtectionRule { pattern }
  openPullRequests: associatedPullRequests(states: OPEN, first: 1) { totalCount }
  associatedPullRequests(first: 1, orderBy: { field: UPDATED_AT, direction: DESC }) {
    nodes { updatedAt }
  }
`;

function timestamp(value: string): number {
  const result = Date.parse(value);
  if (!Number.isFinite(result)) throw new Error(`Invalid activity timestamp: ${value}`);
  return result;
}

function matchesRule(pattern: string, branch: string, defaultBranch: string): boolean {
  if (pattern === "~ALL") return true;
  if (pattern === "~DEFAULT_BRANCH") return branch === defaultBranch;
  // Node supports glob extensions that GitHub's fnmatch treats literally.
  if (/[{}\\]|[?*+@!]\(/.test(pattern)) {
    throw new Error(`Cannot safely evaluate branch ruleset pattern: ${pattern}`);
  }
  return matchesGlob(`refs/heads/${branch}`, pattern);
}

export function classifyBranch(
  branch: Branch,
  protection: Protection,
  openPrBases: ReadonlySet<string>,
  now: Date,
): Decision {
  const copilot = branch.name.startsWith("copilot/");
  const cutoff = new Date(now);
  if (copilot) {
    cutoff.setTime(cutoff.getTime() - 90 * DAY_MS);
  } else {
    // Clamp leap day to February 28 when the target year is not a leap year.
    const month = cutoff.getUTCMonth();
    cutoff.setUTCFullYear(cutoff.getUTCFullYear() - 3);
    if (cutoff.getUTCMonth() !== month) cutoff.setUTCDate(0);
  }
  const lastPrActivityAt = branch.associatedPullRequests.nodes[0]?.updatedAt ?? null;
  const lastActivity = Math.max(
    timestamp(branch.target.committedDate),
    lastPrActivityAt === null ? 0 : timestamp(lastPrActivityAt),
  );
  const normalized = branch.name.toLowerCase();
  let reason: Decision["reason"];
  if (
    branch.name === protection.defaultBranch ||
    PRESERVED_NAMES.has(normalized) ||
    PRESERVED_PREFIXES.some((prefix) => normalized.startsWith(prefix))
  ) {
    reason = "preserved";
  } else if (
    branch.branchProtectionRule ||
    protection.rules.some(
      (rule) =>
        rule.include.some((p) => matchesRule(p, branch.name, protection.defaultBranch)) &&
        !rule.exclude.some((p) => matchesRule(p, branch.name, protection.defaultBranch)),
    )
  ) {
    reason = "protected";
  } else if (branch.openPullRequests.totalCount > 0 || openPrBases.has(branch.name)) {
    reason = "open-pr";
  } else if (lastActivity >= cutoff.getTime()) {
    reason = "recent-activity";
  } else {
    reason = "eligible";
  }
  return decisionSchema.parse({
    branch: branch.name,
    sha: branch.target.oid,
    retention: copilot ? "90 days" : "3 years",
    lastCommitAt: branch.target.committedDate,
    lastPrActivityAt,
    reason,
  });
}

async function collectPages<T>(
  fetchPage: (cursor: string | null) => Promise<Page<T>>,
): Promise<T[]> {
  const nodes: T[] = [];
  let cursor: string | null = null;
  for (;;) {
    const page = await fetchPage(cursor);
    nodes.push(...page.nodes);
    if (!page.pageInfo.hasNextPage) return nodes;
    const next = page.pageInfo.endCursor;
    if (!next || next === cursor) throw new Error("GitHub returned an invalid pagination cursor");
    cursor = next;
  }
}

async function getProtection({ github, context }: GitHubScriptArgs): Promise<Protection> {
  const { data: repository } = await github.rest.repos.get(context.repo);
  const rulesets = await github.paginate("GET /repos/{owner}/{repo}/rulesets", {
    ...context.repo,
    includes_parents: true,
    per_page: PER_PAGE_MAX,
  });
  const rules: Protection["rules"] = [];
  for (const ruleset of rulesets) {
    if (ruleset.target !== "branch" || ruleset.enforcement !== "active") continue;
    const { data: detail } = await github.request(
      "GET /repos/{owner}/{repo}/rulesets/{ruleset_id}",
      { ...context.repo, ruleset_id: ruleset.id },
    );
    if (detail.enforcement !== "active") continue;
    const condition = detail.conditions?.ref_name;
    if (!condition?.include || !condition.exclude) {
      throw new Error(`Cannot determine branch targets for ruleset ${detail.id}`);
    }
    rules.push({ include: condition.include, exclude: condition.exclude });
  }
  return { defaultBranch: repository.default_branch, rules };
}

async function getBranches(github: GitHub, repo: GitHubScriptArgs["context"]["repo"]) {
  return collectPages(async (cursor) => {
    const data = await github.graphql<{ repository: { refs: Page<Branch> } }>(
      `query($owner: String!, $repo: String!, $cursor: String) {
        repository(owner: $owner, name: $repo) {
          refs(refPrefix: "refs/heads/", first: ${PER_PAGE_MAX}, after: $cursor,
               orderBy: { field: ALPHABETICAL, direction: ASC }) {
            nodes { ${BRANCH_FIELDS} }
            pageInfo { hasNextPage endCursor }
          }
        }
      }`,
      { ...repo, cursor },
    );
    return data.repository.refs;
  });
}

async function getOpenPrBases(github: GitHub, repo: GitHubScriptArgs["context"]["repo"]) {
  const prs = await collectPages(async (cursor) => {
    const data = await github.graphql<{
      repository: { pullRequests: Page<{ baseRefName: string }> };
    }>(
      `query($owner: String!, $repo: String!, $cursor: String) {
        repository(owner: $owner, name: $repo) {
          pullRequests(states: OPEN, first: ${PER_PAGE_MAX}, after: $cursor) {
            nodes { baseRefName }
            pageInfo { hasNextPage endCursor }
          }
        }
      }`,
      { ...repo, cursor },
    );
    return data.repository.pullRequests;
  });
  return new Set(prs.map((pr) => pr.baseRefName));
}

export async function planCleanup(
  args: GitHubScriptArgs,
  directory: string,
  now = new Date(),
): Promise<Plan> {
  const protection = await getProtection(args);
  const branches = await getBranches(args.github, args.context.repo);
  const openPrBases = await getOpenPrBases(args.github, args.context.repo);
  const plan: Plan = {
    repository: `${args.context.repo.owner}/${args.context.repo.repo}`,
    createdAt: now.toISOString(),
    branches: branches.map((branch) => classifyBranch(branch, protection, openPrBases, now)),
  };
  await mkdir(directory, { recursive: true });
  await writeFile(join(directory, "plan.json"), JSON.stringify(plan, null, 2));
  const eligible = plan.branches.filter((branch) => branch.reason === "eligible");
  args.core.info(`Found ${eligible.length} eligible branches out of ${plan.branches.length}`);
  await args.core.summary
    .addRaw(
      `## Branch cleanup plan\n\n` +
        `Scanned ${plan.branches.length} branches; ${eligible.length} are eligible.\n\n` +
        `Retention: \`copilot/*\` 90 days; other non-preserved branches 3 calendar years. ` +
        `Unmerged and no-PR branches can be eligible. See the plan artifact for names, SHAs, and reasons.\n`,
    )
    .write();
  return plan;
}

async function recheckBatch(args: GitHubScriptArgs, candidates: Decision[]) {
  const definitions = ["$owner: String!", "$repo: String!"];
  const fields: string[] = [];
  const variables: Record<string, string> = { ...args.context.repo };
  for (const [index, candidate] of candidates.entries()) {
    definitions.push(`$name${index}: String!`, `$ref${index}: String!`);
    variables[`name${index}`] = candidate.branch;
    variables[`ref${index}`] = `refs/heads/${candidate.branch}`;
    fields.push(`
      branch${index}: ref(qualifiedName: $ref${index}) { ${BRANCH_FIELDS} }
      base${index}: pullRequests(states: OPEN, baseRefName: $name${index}, first: 1) { totalCount }
    `);
  }
  type Result = Record<`branch${number}`, Branch | null> &
    Record<`base${number}`, { totalCount: number }>;
  const data = await args.github.graphql<{ repository: Result }>(
    `query(${definitions.join(", ")}) {
      repository(owner: $owner, name: $repo) { ${fields.join("\n")} }
    }`,
    variables,
  );
  return candidates.map((_, index) => ({
    branch: data.repository[`branch${index}`],
    isOpenPrBase: data.repository[`base${index}`].totalCount > 0,
  }));
}

export async function deleteBranchBatch(
  candidates: Pick<Decision, "branch" | "sha">[],
  remote: string,
  core: Core,
): Promise<void> {
  if (candidates.length === 0) return;
  const refs = candidates.map(({ branch }) => `refs/heads/${branch}`);
  await execFile(
    "git",
    [
      "push",
      "--atomic",
      "--porcelain",
      "--no-follow-tags",
      ...candidates.map(({ branch, sha }) => `--force-with-lease=refs/heads/${branch}:${sha}`),
      remote,
      ...refs.map((ref) => `:${ref}`),
    ],
    { logger: core },
  );
  const { stdout } = await execFile("git", ["ls-remote", "--heads", remote, ...refs], {
    logger: core,
  });
  if (stdout.trim()) throw new Error(`Branches still exist after cleanup:\n${stdout}`);
}

export async function applyCleanup(
  args: GitHubScriptArgs,
  directory: string,
  now = new Date(),
): Promise<void> {
  const plan = planSchema.parse(JSON.parse(await readFile(join(directory, "plan.json"), "utf8")));
  const repository = `${args.context.repo.owner}/${args.context.repo.repo}`;
  if (plan.repository !== repository) throw new Error("Cleanup plan belongs to another repository");
  const age = now.getTime() - timestamp(plan.createdAt);
  if (age < 0 || age > DAY_MS) throw new Error("Cleanup plan must be less than 24 hours old");
  const results = plan.branches
    .filter((branch) => branch.reason === "eligible")
    .map((branch) => ({ ...branch, outcome: "pending" }));
  try {
    for (let offset = 0; offset < results.length; offset += BATCH_SIZE) {
      const batch = results.slice(offset, offset + BATCH_SIZE);
      const protection = await getProtection(args);
      const current = await recheckBatch(args, batch);
      const deletions: typeof batch = [];
      for (const [index, result] of batch.entries()) {
        const { branch, isOpenPrBase } = current[index];
        if (branch === null) {
          result.outcome = "already-deleted";
        } else if (branch.name !== result.branch || branch.target.oid !== result.sha) {
          result.outcome = "kept-tip-changed";
        } else {
          const decision = classifyBranch(
            branch,
            protection,
            new Set(isOpenPrBase ? [branch.name] : []),
            now,
          );
          if (decision.reason !== "eligible") {
            result.outcome = `kept-${decision.reason}`;
          } else {
            deletions.push(result);
          }
        }
      }
      for (const result of deletions) {
        args.core.info(`Deleting ${JSON.stringify(result.branch)} at ${result.sha}`);
        // A failed push or verification can leave the remote outcome unknown.
        result.outcome = "unconfirmed";
      }
      await deleteBranchBatch(deletions, `${args.context.serverUrl}/${repository}.git`, args.core);
      for (const result of deletions) result.outcome = "deleted";
      await writeFile(join(directory, "results.json"), JSON.stringify(results, null, 2));
    }
  } finally {
    await writeFile(join(directory, "results.json"), JSON.stringify(results, null, 2));
    const deleted = results.filter((r) => r.outcome === "deleted").length;
    const unresolved = results.filter((r) => ["pending", "unconfirmed"].includes(r.outcome)).length;
    await args.core.summary
      .addRaw(
        `## Branch cleanup results\n\nDeleted ${deleted}; ` +
          `skipped ${results.length - deleted - unresolved}; unresolved ${unresolved}.\n\n` +
          `See the results artifact for each branch's outcome.\n`,
      )
      .write();
  }
}
