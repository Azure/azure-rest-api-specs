// @ts-check

import { readdir } from "fs/promises";
import { basename, join, normalize, sep } from "path";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
export default async function importAllModules({ core }) {
  core.info("importAllModules()");

  const workspace = process.env.GITHUB_WORKSPACE;
  if (!workspace) {
    throw new Error("Env var GITHUB_WORKSPACE must be set");
  }

  const githubPath = join(workspace, ".github");
  const scripts = (await readdir(githubPath, { recursive: true }))
    .filter(
      (f) =>
        normalize(f).split(sep).includes("src") &&
        basename(f).toLowerCase().endsWith(".js"),
    )
    .sort();

  core.info(JSON.stringify(scripts));
}
