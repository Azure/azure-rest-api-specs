import debug from "debug";
import { dirname } from "path";
import { simpleGit } from "simple-git";
import { inspect } from "util";
import { getChangedFilesStatuses, swagger } from "../../shared/src/changed-files.js";
import { Swagger } from "../../shared/src/swagger.js";
import { CoreLogger } from "./core-logger.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<boolean>}
 */
export default async function typespecRequirement({ core }) {
  const options = {
    cwd: process.env.GITHUB_WORKSPACE,
    paths: ["specification"],
    logger: new CoreLogger(core),
  };

  const changedFiles = await getChangedFilesStatuses(options);

  const changedSwaggers = [
    ...changedFiles.additions,
    ...changedFiles.modifications,
    ...changedFiles.renames.map((r) => r.to),
  ].filter(swagger);

  core.debug(`changed files count: ${changedFiles.total}`);
  core.debug(`changed swaggers:\n  ${changedSwaggers.join("\n  ")}`);

  const git = simpleGit(options.cwd);

  let result = true;

  for (const swaggerPath of changedSwaggers) {
    core.debug(swaggerPath);

    const swaggerText = await git.show([`HEAD:${swaggerPath}`]);
    core.debug(`  swaggerText length: ${swaggerText.length}`);

    const swagger = new Swagger(swaggerPath, { content: swaggerText });
    const typespecGenerated = await swagger.getTypeSpecGenerated();
    core.debug(`  typespecGenerated: ${inspect(typespecGenerated)}`);

    if (typespecGenerated) {
      continue;
    }

    const existingApiVersion = await git
      .catFile(["-e", `HEAD^:${dirname(swaggerPath)}`])
      .then(() => true)
      .catch(() => false);

    core.debug(`  existingApiVersion: ${existingApiVersion}`);

    if (existingApiVersion) {
      continue;
    }

    core.debug(`  NEW API VERSION MUST USE TYPESPEC`);

    result = false;
  }

  return result;
}
