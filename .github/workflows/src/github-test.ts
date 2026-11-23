import type { GitHubScriptArgs } from "./github.ts";
import { readdir } from "node:fs/promises";
import { basename, join, relative, sep } from "node:path";
import { pathToFileURL } from "node:url";
import { inspect } from "node:util";

export default async function importAllModules(
  { core }: Pick<GitHubScriptArgs, "core">,
  sourceDirectories = [".github/shared/src", ".github/workflows/src"],
) {
  const workspace = process.env.GITHUB_WORKSPACE;
  if (!workspace) {
    throw new Error("Env var GITHUB_WORKSPACE must be set");
  }

  // Find source modules, excluding dependencies that Node cannot type-strip.
  const scriptFiles = (
    await Promise.all(
      sourceDirectories.map(async (directory) => {
        const sourceDir = join(workspace, directory);
        return (await readdir(sourceDir, { recursive: true }))
          .filter(
            (file) =>
              !file.split(sep).includes("node_modules") && /\.(?:js|ts)$/.test(basename(file)),
          )
          .map((file) => join(sourceDir, file));
      }),
    )
  )
    .flat()
    .sort();

  core.info("Script Files:");
  scriptFiles.map(core.info);
  core.info("");

  for (const file of scriptFiles) {
    core.info(`Importing ${relative(workspace, file)}`);

    const fileUrl = pathToFileURL(file).href;

    // if import fails, throws error which causes step to fail
    const module = (await import(fileUrl)) as unknown;

    core.info(inspect(module));
    core.info("");
  }

  core.info("All script files are importable");
}
