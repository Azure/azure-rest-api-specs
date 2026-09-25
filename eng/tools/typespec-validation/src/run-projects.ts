import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import { getSuppressions } from "@azure-tools/suppressions";
import { spawn } from "node:child_process";
import { stat } from "node:fs/promises";
import { relative, resolve, sep } from "node:path";
import { fileURLToPath } from "node:url";
import { simpleGit } from "simple-git";
import { findChangedProjects, findProjects, type ChangedProjectsOptions } from "./find-projects.ts";

interface RunOptions {
  gitClean?: boolean;
  dryRun?: boolean;
}

interface RunContext {
  checkingAllSpecs: boolean;
  baseCommitish?: string;
  headCommitish?: string;
}

export async function runAll(
  folder: string,
  options: RunOptions & { shard?: string } = {},
): Promise<boolean> {
  const root = resolve(folder);
  if (!(await stat(root)).isDirectory()) {
    throw new Error(`Please run TypeSpec Validation on a directory path: ${root}`);
  }

  let projects = await findProjects(root);
  if (projects.length === 0) {
    console.error(`No TypeSpec projects found in ${root}`);
    return false;
  }

  if (options.shard !== undefined) {
    const total = projects.length;
    projects = selectShard(projects, options.shard);
    console.log(`Shard ${options.shard}: ${projects.length} of ${total} TypeSpec projects`);
  }

  return runProjects(root, projects, { checkingAllSpecs: true }, options);
}

export async function runChanged(
  folder: string,
  options: RunOptions & Partial<ChangedProjectsOptions> = {},
): Promise<boolean> {
  const root = await getRootFolder(folder);
  const { baseCommitish = "HEAD^", headCommitish = "HEAD", ignoreCoreFiles } = options;
  const { projects, checkingAllSpecs } = await findChangedProjects(root, {
    baseCommitish,
    headCommitish,
    ignoreCoreFiles,
  });
  if (projects.length === 0) {
    if (checkingAllSpecs) {
      console.error("TypeSpec Validation - All did not validate any specs");
      return false;
    }
    console.log("No impacted TypeSpec projects found");
    return true;
  }
  return runProjects(root, projects, { checkingAllSpecs, baseCommitish, headCommitish }, options);
}

async function runProjects(
  root: string,
  projects: string[],
  context: RunContext,
  options: RunOptions,
): Promise<boolean> {
  const git = simpleGit(root);
  const gitClean = options.gitClean && !options.dryRun;
  const displayRoot =
    gitClean || (await git.checkIsRepo()) ? await getRootFolder(root) : process.cwd();
  const displayPath = (project: string) =>
    relative(displayRoot, project).split(sep).join("/") || ".";
  if (gitClean) {
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
      if (context.checkingAllSpecs) {
        const suppressions = await getSuppressions("TypeSpecValidationAll", project, {
          ...context,
        });
        const suppression = suppressions.find((s) => !s.rules?.length && !s.subRules?.length);
        if (suppression) {
          console.log(`Suppressed: ${suppression.reason}`);
          continue;
        }
      }
      if (options.dryRun) {
        console.log(`Dry run: would validate ${name} with context ${JSON.stringify(context)}`);
        continue;
      }

      try {
        if (!(await validateProject(project, context))) {
          failed.push(name);
        }
      } finally {
        if (gitClean) {
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

function validateProject(folder: string, context: RunContext): Promise<boolean> {
  return new Promise((resolve, reject) => {
    // A child process keeps each project's context and exit status independent.
    const child = spawn(
      process.execPath,
      [fileURLToPath(new URL("../cmd/tsv.js", import.meta.url)), folder, JSON.stringify(context)],
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
