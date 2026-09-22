import { execFile } from "@azure-tools/specs-shared/exec";
import { lstat } from "node:fs/promises";
import { basename, join } from "node:path";

/** Restore the worktree from the index without changing staged or ignored files. */
export async function cleanWorktree(repoRoot: string): Promise<void> {
  async function git(command: string, args: string[]): Promise<string> {
    const start = performance.now();
    let success = false;
    try {
      const { stdout } = await execFile("git", ["--literal-pathspecs", command, ...args], {
        cwd: repoRoot,
      });
      success = true;
      return stdout;
    } finally {
      console.log(
        `TSV cleanup ${JSON.stringify({
          command,
          durationMs: Math.round(performance.now() - start),
          success,
        })}`,
      );
    }
  }

  const status = await git("status", [
    "--porcelain=v2",
    "-z",
    "--untracked-files=normal",
    "--no-renames",
    "--ignore-submodules=none",
  ]);
  const tracked: string[] = [];
  const untracked: string[] = [];

  // Parse the complete result before modifying anything. V2 exposes submodule state;
  // disabling renames leaves only ordinary, unmerged, and untracked records.
  for (const record of status.split("\0").filter(Boolean)) {
    if (record.startsWith("? ")) {
      untracked.push(record.slice(2));
      continue;
    }
    const match = /^1 ([.MADT][.MDT]) (N\.\.\.) \d{6} \d{6} \d{6} [a-f0-9]+ [a-f0-9]+ (.+)$/s.exec(
      record,
    );
    if (!match) {
      throw new Error(
        `Unsafe Git cleanup state (conflict, submodule, or unsupported status): ${JSON.stringify(record)}`,
      );
    }
    if (match[1][1] !== ".") {
      tracked.push(match[3]);
    }
  }

  for (const path of tracked) {
    const entry = await lstat(join(repoRoot, path)).catch((error: NodeJS.ErrnoException) => {
      if (error.code !== "ENOENT" && error.code !== "ENOTDIR") throw error;
      return undefined;
    });
    // Restoring a file over a directory can recursively delete its contents,
    // bypassing git clean's protection of ignored files and nested repositories.
    if (entry?.isDirectory()) {
      throw new Error(`Refusing to restore tracked file replaced by a directory: ${path}`);
    }
  }
  // Restoring/removing an ignore file could reveal paths hidden from the initial
  // scan. Fail rather than let those outputs contaminate the next project.
  if ([...tracked, ...untracked].some((path) => basename(path).toLowerCase() === ".gitignore")) {
    throw new Error("Refusing Git cleanup with changed .gitignore files");
  }

  for (const paths of pathBatches(tracked)) {
    await git("restore", ["--worktree", "--", ...paths]);
  }
  for (const paths of pathBatches(untracked)) {
    await git("clean", ["-df", "--", ...paths]);
    // git clean exits successfully when it skips a nested repository. Verify only
    // these paths, excluding ignored files and empty directories as Git normally does.
    const remaining = await git("ls-files", [
      "--others",
      "--exclude-standard",
      "--directory",
      "--no-empty-directory",
      "-z",
      "--",
      ...paths,
    ]);
    if (remaining) {
      throw new Error(
        `Git cleanup left untracked paths (possibly a nested repository): ${JSON.stringify(remaining.split("\0").filter(Boolean))}`,
      );
    }
  }
}

function* pathBatches(paths: string[]): Generator<string[]> {
  let batch: string[] = [];
  let size = 0;
  for (const path of paths) {
    // Leave room for executable/flags and Windows argument quoting.
    const length = Buffer.byteLength(path) * 2 + 3;
    if (size + length > 16_000 && batch.length > 0) {
      yield batch;
      batch = [];
      size = 0;
    }
    batch.push(path);
    size += length;
  }
  if (batch.length > 0) yield batch;
}

if (import.meta.main) {
  const repoRoot = process.argv[2];
  if (!repoRoot) throw new Error("Usage: node git-cleanup.ts <repository-root>");
  await cleanWorktree(repoRoot);
}
