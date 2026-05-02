import { getChangedFilesStatuses, swagger } from "../../shared/src/changed-files.js";
import { CoreLogger } from "./core-logger.js";

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

  // for (const swagger of changedSwaggers) {
  //   const swaggerText = await git.show([`HEAD:${file}`]);
  // }

  return true;
}
