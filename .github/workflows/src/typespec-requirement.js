import { getChangedFiles, swagger } from "../../shared/src/changed-files.js";
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

  const changedFiles = await getChangedFiles(options);
  const changedSwaggers = changedFiles.filter(swagger);

  core.info(`changed files count: ${changedFiles.length}`);
  core.info(`changed swaggers count: ${changedSwaggers.length}`);

  return true;
}
