// @ts-check

import { readFile } from "fs/promises";
import { dirname, join } from "path";
import { getChangedResourceManagerSwaggerFiles } from "./changed-files.js";
import { lsTree, show } from "./git.js";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<boolean>}
 */
export default async function incrementalTypeSpec({ github, context, core }) {
  const changedRmSwaggerFiles = await getChangedResourceManagerSwaggerFiles(
    core,
    "HEAD^",
    "HEAD",
    "",
  );

  if (changedRmSwaggerFiles.length == 0) {
    core.info(
      "No changes to swagger files containing path '/resource-manager/'",
    );
    return false;
  }

  // If any changed file is not typespec-generated, return false
  for (const file of changedRmSwaggerFiles) {
    const swagger = await readFile(
      join(process.env.GITHUB_WORKSPACE || "", file),
      { encoding: "utf8" },
    );

    const swaggerObj = JSON.parse(swagger);

    if (!swaggerObj["info"]?.["x-typespec-generated"]) {
      core.info(`File "${file}" does not contain "info.x-typespec-generated"`);
      return false;
    }
  }

  const changedSpecDirs = new Set(
    changedRmSwaggerFiles.map((f) => dirname(dirname(dirname(f)))),
  );

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
    const specRmSwaggerFilesBaseBranch = specFilesBaseBranch
      .split("\n")
      .filter(
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
