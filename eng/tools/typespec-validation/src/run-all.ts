import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import { getSuppressions } from "@azure-tools/suppressions";
import { spawn } from "node:child_process";
import { stat } from "node:fs/promises";
import { dirname, relative, resolve, sep } from "node:path";
import { fileURLToPath } from "node:url";
import { simpleGit } from "simple-git";
import { globFiles } from "./glob.ts";

export async function runAll(
  folder: string,
  options: { gitClean?: boolean; shard?: string } = {},
): Promise<boolean> {
  const root = resolve(folder);
  if (!(await stat(root)).isDirectory()) {
    throw new Error(`Please run TypeSpec Validation on a directory path: ${root}`);
  }

  const configs = await globFiles("**/tspconfig.*", {
    cwd: root,
    exclude: ["**/node_modules/**"],
  });
  // Sort relative POSIX paths so shard membership is the same on every OS.
  const projectFolders = [
    ...new Set(configs.map((config) => dirname(config).split(sep).join("/"))),
  ].sort();
  let projects = projectFolders.map((project) => resolve(root, project));
  if (projects.length === 0) {
    console.error(`No TypeSpec projects found in ${root}`);
    return false;
  }

  if (options.shard !== undefined) {
    projects = selectShard(projects, options.shard);
    console.log(
      `Shard ${options.shard}: ${projects.length} of ${projectFolders.length} TypeSpec projects`,
    );
  }

  const git = simpleGit(root);
  const displayRoot =
    options.gitClean || (await git.checkIsRepo()) ? await getRootFolder(root) : process.cwd();
  const displayPath = (project: string) =>
    relative(displayRoot, project).split(sep).join("/") || ".";
  if (options.gitClean) {
    await git.cwd(displayRoot);
    await git.revparse(["--verify", "HEAD"]);
    if (!(await git.status(["--untracked-files=all"])).isClean()) {
      throw new Error("--git-clean requires a clean checkout, including untracked files");
    }
  }

  console.log(
    `Checking ${projects.length} TypeSpec folders:\n${projects.map(displayPath).join("\n")}`,
  );
  const failed: string[] = [];
  const githubActions = process.env.GITHUB_ACTIONS === "true";

  for (const project of projects) {
    const name = displayPath(project);
    console.log(githubActions ? `::group::Validating ${name}` : `\nValidating ${name}`);
    try {
      const suppressions = await getSuppressions("TypeSpecValidationAll", project, {
        checkingAllSpecs: true,
      });
      const suppression = suppressions.find((s) => !s.rules?.length && !s.subRules?.length);
      if (suppression) {
        console.log(`Suppressed: ${suppression.reason}`);
        continue;
      }

      try {
        if (!(await validateProject(project))) {
          failed.push(name);
        }
      } finally {
        if (options.gitClean) {
          await git.raw(["restore", "--worktree", "--", "."]);
          await git.clean("f", ["-d"]);
        }
      }
    } finally {
      if (githubActions) {
        console.log("::endgroup::");
      }
    }
  }

  if (failed.length > 0) {
    console.error(`TypeSpec Validation failed for:\n${failed.join("\n")}`);
  }
  return failed.length === 0;
}

/** Select a one-based shard, distributing extra projects to the first shards. */
function selectShard(projects: string[], shard: string): string[] {
  const match = /^(\d+)\/(\d+)$/.exec(shard);
  const index = Number(match?.[1]);
  const count = Number(match?.[2]);
  if (
    match?.[0] !== shard ||
    !Number.isSafeInteger(index) ||
    !Number.isSafeInteger(count) ||
    index < 1 ||
    index > count
  ) {
    throw new Error(
      `Invalid --shard "${shard}". Expected positive safe integers <index>/<count> ` +
        "with index <= count (for example, 1/3).",
    );
  }
  if (count > projects.length) {
    throw new Error(
      `Shard count (${count}) exceeds the number of TypeSpec projects (${projects.length})`,
    );
  }

  const size = Math.floor(projects.length / count);
  const remainder = projects.length % count;
  const start = (index - 1) * size + Math.min(index - 1, remainder);
  const end = start + size + (index <= remainder ? 1 : 0);
  return projects.slice(start, end);
}

function validateProject(folder: string): Promise<boolean> {
  return new Promise((resolve, reject) => {
    // A child process keeps each project's context and exit status independent.
    const child = spawn(
      process.execPath,
      [
        fileURLToPath(new URL("../cmd/tsv.js", import.meta.url)),
        folder,
        JSON.stringify({ checkingAllSpecs: true }),
      ],
      { stdio: "inherit" },
    );
    child.once("error", reject);
    child.once("close", (code, signal) => {
      if (signal) {
        reject(new Error(`TypeSpec Validation for ${folder} terminated by ${signal}`));
      } else {
        resolve(code === 0);
      }
    });
  });
}
