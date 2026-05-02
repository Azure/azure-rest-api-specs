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

  for (const swaggerPath of changedSwaggers) {
    core.debug(swaggerPath);

    const swaggerText = await git.show([`HEAD:${swaggerPath}`]);
    core.debug(`  swaggerText length: ${swaggerText.length}`);

    // TODO: exit fast once we know a file is safe, to avoid redundant checks

    const swagger = new Swagger(swaggerPath, { content: swaggerText });
    const typespecGenerated = await swagger.getTypeSpecGenerated();
    core.debug(`  typespecGenerated: ${inspect(typespecGenerated)}`);

    // TODO: extract method, consider caching
    const isNewApiVersion = await git
      .catFile(["-e", `HEAD^:${dirname(swaggerPath)}`])
      .then(() => false)
      .catch(() => true);

    core.debug(`  isNewApiVersion: ${isNewApiVersion}`);

    const allowed = typespecGenerated || !isNewApiVersion;
    core.debug(`  allowed: ${allowed}`);
  }

  return true;
}
