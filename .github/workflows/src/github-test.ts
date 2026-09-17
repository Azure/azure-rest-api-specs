import { readdir } from "fs/promises";
import { basename, join, normalize, sep } from "path";
import { pathToFileURL } from "url";
import { inspect } from "util";

export default async function importAllModules({
  core,
}: Pick<import("./github.ts").WorkflowArguments, "core">) {
  const workspace = process.env.GITHUB_WORKSPACE;
  if (!workspace) {
    throw new Error("Env var GITHUB_WORKSPACE must be set");
  }

  const githubDir = join(workspace, ".github");

  // Find source modules, excluding dependencies that Node cannot type-strip.
  const scriptFiles = (await readdir(githubDir, { recursive: true }))
    .filter(
      (f) =>
        normalize(f).split(sep).includes("src") &&
        !normalize(f).split(sep).includes("node_modules") &&
        /\.(?:js|ts)$/.test(basename(f)),
    )
    .sort();

  core.info("Script Files:");
  scriptFiles.map(core.info);
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
