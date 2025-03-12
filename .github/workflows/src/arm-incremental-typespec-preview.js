// @ts-check

import { dirname } from "path";
import {
  example,
  getChangedFiles,
  resourceManager,
  swagger,
} from "../../src/changed-files.js";
import { lsTree, show } from "../../src/git.js";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<boolean>}
 */
export default async function incrementalTypeSpec({ github, context, core }) {
  const changedFiles = await getChangedFiles(core);

  // Includes swaggers, readmes, and examples
  const changedRmFiles = changedFiles.filter(resourceManager);

  if (changedRmFiles.length == 0) {
    core.info("No changes to files containing path '/resource-manager/'");
    return false;
  }

  // If any changed swagger file is not typespec-generated, return false
  for (const file of changedRmFiles.filter(swagger)) {
    /** @type string */
    let swaggerText;
    try {
      swaggerText = await show("HEAD", file, core);
    } catch (e) {
      if (e instanceof Error && e.message.includes("does not exist")) {
        // To simplify logic, if PR deletes a swagger file, it's not "incremental typespec"
        core.info(`File "${file}" has been deleted`);
        return false;
      } else {
        // Unknown error
        throw e;
      }
    }

    let swaggerObj;
    try {
      swaggerObj = JSON.parse(swaggerText);
    } catch {
      // If swagger cannot be parsed as JSON, it's not "incremental typespec"
      core.info(`File "${file}" cannot be parsed as JSON`);
      return false;
    }

    if (!swaggerObj["info"]?.["x-typespec-generated"]) {
      core.info(`File "${file}" does not contain "info.x-typespec-generated"`);
      return false;
    }
  }

  const changedSpecDirs = new Set(
    // TODO: Find spec dir differently based on each file type (swagger, example, readme)
    // swagger -> dirname(dirname(dirname(f)))
    // example -> dirname(dirname(dirname(dirname(f))))
    // readme -> If parent is "resource-manager", return all dirs under "resource-manager".
    //           Else, walk up until you are 1 below "resource-manager", then stop.
    //           TODO: Verify works for all current readme.md in repo
    [
      ...changedRmFiles
        .filter(swagger)
        .map((f) => dirname(dirname(dirname(f)))),
      ...changedRmFiles
        .filter(example)
        .map((f) => dirname(dirname(dirname(dirname(f))))),
    ],
  );

  if (changedSpecDirs.size === 0) {
    core.info("Could not map changed files to any spec directories");
    return false;
  }

  // Ensure that each changed spec dir contained at least one typespec-generated swagger in the base commitish
  for (const changedSpecDir of changedSpecDirs) {
    // TODO: Create helper to list RM specs in a given commitish
    const specFilesBaseBranch = await lsTree(
      "HEAD^",
      changedSpecDir,
      core,
      "-r --name-only",
    );

    // Filter files to only include RM *.json files
    const specRmSwaggerFilesBaseBranch = specFilesBaseBranch.split("\n").filter(
      // TODO: Replace with shared filters in changed-files.js
      (file) =>
        file.includes("/resource-manager/") &&
        !file.includes("/examples/") &&
        file.endsWith(".json"),
    );

    if (specRmSwaggerFilesBaseBranch.length === 0) {
      core.info(
        `Spec folder '${changedSpecDir}' in base branch does not exist or contains no swagger files`,
      );
      return false;
    }

    let containsTypeSpecGeneratedSwagger = false;
    // TODO: Add lint rule to prevent using "for...in" instead of "for...of"
    for (const file of specRmSwaggerFilesBaseBranch) {
      const baseSwagger = await show("HEAD^", file, core);
      const baseSwaggerObj = JSON.parse(baseSwagger);
      if (baseSwaggerObj["info"]?.["x-typespec-generated"]) {
        core.info(
          `Spec folder '${changedSpecDir}' in base branch contains typespec-generated swagger: '${file}'`,
        );
        containsTypeSpecGeneratedSwagger = true;
        break;
      }
    }

    if (!containsTypeSpecGeneratedSwagger) {
      core.info(
        `Spec folder '${changedSpecDir}' in base branch does not contain any typespec-generated swagger.  PR may be a TypeSpec conversion.`,
      );
      return false;
    }
  }

  core.info(
    "Appears to contain only incremental changes to existing TypeSpec RP(s)",
  );
  return true;
}
