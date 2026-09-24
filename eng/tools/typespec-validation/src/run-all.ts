import { getSuppressions } from "@azure-tools/suppressions";
import { spawn } from "node:child_process";
import { stat } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { simpleGit } from "simple-git";
import { globFiles } from "./glob.ts";

export async function runAll(
  folder: string,
  options: { gitClean?: boolean } = {},
): Promise<boolean> {
  const root = resolve(folder);
  if (!(await stat(root)).isDirectory()) {
    throw new Error(`Please run TypeSpec Validation on a directory path: ${root}`);
  }

  const configs = await globFiles("**/tspconfig.*", {
    cwd: root,
    exclude: ["**/node_modules/**"],
  });
  const projects = [...new Set(configs.map((config) => dirname(resolve(root, config))))].sort();
  if (projects.length === 0) {
    console.error(`No TypeSpec projects found in ${root}`);
    return false;
  }

  const git = options.gitClean ? simpleGit(root) : undefined;
  if (git) {
    await git.cwd((await git.revparse("--show-toplevel")).trim());
    await git.revparse(["--verify", "HEAD"]);
    if (!(await git.status(["--untracked-files=all"])).isClean()) {
      throw new Error("--git-clean requires a clean checkout, including untracked files");
    }
  }

  console.log(`Checking ${projects.length} TypeSpec folders:\n${projects.join("\n")}`);
  const failed: string[] = [];

  for (const project of projects) {
    console.log(`\nValidating ${project}`);
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
        failed.push(project);
      }
    } finally {
      if (git) {
        await git.raw(["restore", "--worktree", "--", "."]);
        await git.clean("f", ["-d"]);
      }
    }
  }

  if (failed.length > 0) {
    console.error(`TypeSpec Validation failed for:\n${failed.join("\n")}`);
  }
  return failed.length === 0;
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
