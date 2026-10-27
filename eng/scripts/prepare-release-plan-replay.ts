/**
 * Restores historical specifications without replacing the checked-out tooling.
 * The release-plan pipeline fetches full history only for an explicit replay.
 */
import { execFileSync } from "node:child_process";
import { resolve } from "node:path";
import { fileURLToPath } from "node:url";

export function prepareReleasePlanReplay(
  workspace: string,
  specCommitSha: string,
  releasePlanId = 0,
): void {
  const commit = specCommitSha.trim();
  if (!/^[a-f\d]{40}$/i.test(commit)) {
    throw new Error("SpecCommitSha must be a full 40-character commit SHA.");
  }
  if (releasePlanId !== 0) {
    throw new Error("SpecCommitSha cannot be combined with ReleasePlanId.");
  }

  const git = (...args: string[]) =>
    execFileSync("git", args, {
      cwd: workspace,
      encoding: "utf8",
      timeout: 30_000,
      stdio: ["ignore", "pipe", "pipe"],
    }).trim();
  const toolingCommit = git("rev-parse", "HEAD");
  if (git("status", "--porcelain", "--untracked-files=all", "--", "specification")) {
    throw new Error("Historical replay requires a clean specification directory.");
  }
  try {
    git("merge-base", "--is-ancestor", commit, "HEAD");
  } catch {
    throw new Error("SpecCommitSha must be in the checked-out branch history. Fetch full history.");
  }

  git("restore", `--source=${commit}`, "--staged", "--worktree", "--", "specification");
  console.log(`Release-plan tooling commit: ${toolingCommit}`);
  console.log(`Restored specification tree from commit: ${commit}`);
}

if (process.argv[1] && fileURLToPath(import.meta.url) === resolve(process.argv[1])) {
  prepareReleasePlanReplay(
    process.cwd(),
    process.env.RELEASE_PLAN_SPEC_COMMIT_SHA ?? "",
    Number(process.env.RELEASE_PLAN_ID ?? "0"),
  );
}
