// @ts-check

import { readdir } from "fs/promises";
import { basename, join, normalize, sep } from "path";
import { pathToFileURL } from "url";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
export default async function importAllModules({ core }) {
  core.info("importAllModules()");

  const workspace = process.env.GITHUB_WORKSPACE;
  if (!workspace) {
    throw new Error("Env var GITHUB_WORKSPACE must be set");
  }

  const githubDir = join(workspace, ".github");
  const scriptFiles = (await readdir(githubDir, { recursive: true }))
    .filter(
      (f) =>
        normalize(f).split(sep).includes("src") &&
        basename(f).toLowerCase().endsWith(".js"),
    )
    .sort();

  core.info("Script Files:");
  scriptFiles.map(core.info);
  core.info("");

  for (const file of scriptFiles) {
    core.info(`Importing ${file}`);
    const fullPath = join(githubDir, file);
    const fileUrl = pathToFileURL(fullPath).href;
    await import(fileUrl);
  }
}
