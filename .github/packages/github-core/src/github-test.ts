import type { Core } from "./github.ts";
import { readdir } from "node:fs/promises";
import { basename, join, normalize, sep } from "node:path";
import { pathToFileURL } from "node:url";
import { inspect } from "node:util";

export default async function importAllModules({
  core,
  directories = ["."],
}: {
  core: Core;
  directories?: string[];
}) {
  const workspace = process.env.GITHUB_WORKSPACE;
  if (!workspace) {
    throw new Error("Env var GITHUB_WORKSPACE must be set");
  }

  const githubDir = join(workspace, ".github");
  const scriptFiles: string[] = [];

  for (const directory of directories) {
    const searchRoot = join(githubDir, directory);
    // Find source modules, excluding dependencies that Node cannot type-strip.
    const found = (await readdir(searchRoot, { recursive: true }))
      .filter(
        (f) =>
          normalize(f).split(sep).includes("src") &&
          !normalize(f).split(sep).includes("node_modules") &&
          /\.(?:js|ts)$/.test(basename(f)),
      )
      .map((f) => join(directory, f))
      .sort();

    if (found.length === 0) {
      throw new Error(`No source modules found under .github/${directory}`);
    }
    scriptFiles.push(...found);
  }

  core.info("Script Files:");
  scriptFiles.map((file) => core.info(file));
  core.info("");

  for (const file of scriptFiles) {
    core.info(`Importing ${file}`);

    const fullPath = join(githubDir, file);
    const fileUrl = pathToFileURL(fullPath).href;

    // if import fails, throws error which causes step to fail
    const module = (await import(fileUrl)) as unknown;

    core.info(inspect(module));
    core.info("");
  }

  core.info("All script files are importable");
}
