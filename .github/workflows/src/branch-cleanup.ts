import type { GitHubScriptArgs } from "./github.ts";

const DAY_MS = 24 * 60 * 60 * 1000;
const DEFAULT_RETENTION = { copilotDays: 90, otherDays: 2 * 365 };
const PRESERVED_NAMES =
  /^(main|master|develop|gh-pages|typespec-next|RPSaas|RPSaaSMaster|RPSaaSCanary|ARMCoreRPDev)$/i;
const PRESERVED_PREFIXES = /^(release[-/]|feature[-/]|archive\/|hotfix\/)/i;

interface Branch {
  name: string;
  target: { oid: string; committedDate: string };
}

interface BranchPage {
  repository: {
    refs: {
      nodes: Branch[];
      pageInfo: { hasNextPage: boolean; endCursor: string | null };
    };
  };
}

export function isStale(branch: Branch, now: number, retention = DEFAULT_RETENTION): boolean {
  const date = Date.parse(branch.target.committedDate);
  if (!Number.isFinite(date)) throw new Error(`Invalid commit date for ${branch.name}`);
  const days = branch.name.startsWith("copilot/") ? retention.copilotDays : retention.otherDays;
  return now - date > days * DAY_MS;
}

export async function cleanupBranches(
  { github, context, core }: GitHubScriptArgs,
  dryRun: boolean,
  git: (args: string[]) => Promise<number>,
  retention = DEFAULT_RETENTION,
  now = Date.now(),
): Promise<void> {
  for (const [name, days] of Object.entries(retention)) {
    if (!Number.isSafeInteger(days) || days <= 0) {
      throw new Error(`${name} must be a positive whole number of days`);
    }
  }
  core.info(`Retention: Copilot ${retention.copilotDays} days; others ${retention.otherDays} days`);
  const { data: repository } = await github.rest.repos.get(context.repo);
  const prs = await github.paginate(github.rest.pulls.list, {
    ...context.repo,
    state: "open",
    per_page: 100,
  });
  const openPrBranches = new Set(prs.flatMap((pr) => [pr.head.ref, pr.base.ref]));
  const branches = await github.paginate(github.rest.repos.listBranches, {
    ...context.repo,
    per_page: 100,
  });
  const remoteBranches = new Map(branches.map((branch) => [branch.name, branch]));
  const candidates: Branch[] = [];
  let cursor: string | null = null;
  // Fetch commit dates in pages instead of making a separate request for every branch.
  for (;;) {
    const response: BranchPage = await github.graphql<BranchPage>(
      `query($owner: String!, $repo: String!, $cursor: String) {
        repository(owner: $owner, name: $repo) {
          refs(refPrefix: "refs/heads/", first: 100, after: $cursor,
               orderBy: { field: ALPHABETICAL, direction: ASC }) {
            nodes { name target { oid ... on Commit { committedDate } } }
            pageInfo { hasNextPage endCursor }
          }
        }
      }`,
      { ...context.repo, cursor },
    );
    for (const branch of response.repository.refs.nodes) {
      const remote = remoteBranches.get(branch.name);
      if (
        !remote ||
        remote.commit.sha !== branch.target.oid ||
        remote.protected ||
        branch.name === repository.default_branch ||
        PRESERVED_NAMES.test(branch.name) ||
        PRESERVED_PREFIXES.test(branch.name) ||
        openPrBranches.has(branch.name)
      ) {
        continue;
      }
      if (isStale(branch, now, retention)) candidates.push(branch);
    }
    const { hasNextPage, endCursor } = response.repository.refs.pageInfo;
    if (!hasNextPage) break;
    if (!endCursor || endCursor === cursor) throw new Error("Invalid branch pagination cursor");
    cursor = endCursor;
  }
  core.info(`${dryRun ? "Dry run" : "Cleanup"}: ${candidates.length} stale branches`);
  for (const branch of candidates) core.info(`${branch.name} ${branch.target.oid}`);
  if (dryRun) return;
  for (let offset = 0; offset < candidates.length; offset += 50) {
    const batch = candidates.slice(offset, offset + 50);
    await git([
      "push",
      "--atomic",
      "--no-follow-tags",
      ...batch.map((b) => `--force-with-lease=refs/heads/${b.name}:${b.target.oid}`),
      repository.clone_url,
      ...batch.map((b) => `:refs/heads/${b.name}`),
    ]);
    core.info(`Deleted ${batch.length} branches`);
  }
}
