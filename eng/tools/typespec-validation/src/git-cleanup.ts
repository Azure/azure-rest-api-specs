import type { ILogger } from "@azure-tools/specs-shared/logger";
import { simpleGit } from "simple-git";

/** Clean a disposable checkout after validation, skipping cleanup when unchanged. */
export async function cleanWorktree(repoRoot: string, logger: ILogger): Promise<void> {
  const git = simpleGit(repoRoot);
  const statusOptions = ["--untracked-files=normal", "--ignore-submodules=none"];

  if ((await timed("status", () => git.status(statusOptions))).isClean()) return;

  await timed("restore", () => git.raw(["restore", "--worktree", "--", "."]));
  await timed("clean", () => git.clean("fd"));

  if (!(await timed("status", () => git.status(statusOptions))).isClean()) {
    throw new Error("Git cleanup left a dirty checkout; stopping validation");
  }

  async function timed<T>(command: string, action: () => Promise<T>): Promise<T> {
    const start = performance.now();
    let success = false;
    try {
      const result = await action();
      success = true;
      return result;
    } finally {
      logger.debug(
        `TSV cleanup ${JSON.stringify({
          command,
          durationMs: Math.round(performance.now() - start),
          success,
        })}`,
      );
    }
  }
}
