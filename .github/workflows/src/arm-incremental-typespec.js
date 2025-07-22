// @ts-check

// For now, treat all paths as posix, since this is the format returned from git commands
import debug from "debug";
import { dirname, join, relative, resolve } from "path";
import { simpleGit } from "simple-git";
import {
  example,
  getChangedFiles,
  readme,
  resourceManager,
  swagger,
} from "../../shared/src/changed-files.js";
import { Readme } from "../../shared/src/readme.js";
import { CoreLogger } from "./core-logger.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<boolean>}
 */
export default async function incrementalTypeSpec({ core }) {
  const options = {
    cwd: process.env.GITHUB_WORKSPACE,
    logger: new CoreLogger(core),
  };

  const changedFiles = await getChangedFiles(options);

  // Includes swaggers, readmes, and examples
  const changedRmFiles = changedFiles.filter(resourceManager);

  if (changedRmFiles.length == 0) {
    core.info("No changes to files containing path '/resource-manager/'");
    return false;
  }

  const git = simpleGit(options.cwd);

  // If any changed swagger file is not typespec-generated, return false
  for (const file of changedRmFiles.filter(swagger)) {
    /** @type string */
    let swaggerText;
    try {
      swaggerText = await git.show([`HEAD:${file}`]);
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

  /** @type Set<string> */
  const changedReadmeInputFiles = new Set();

  for (const readmeFile of changedRmFiles.filter(readme)) {
    core.info(`Extracting input files from '${readmeFile}'`);

    let readmeText;
    try {
      readmeText = await git.show([`HEAD:${readmeFile}`]);
    } catch (e) {
      if (e instanceof Error && e.message.includes("does not exist")) {
        // To simplify logic, if PR deletes a readme file, it's not "incremental typespec"
        core.info(`File "${readmeFile}" has been deleted`);
        return false;
      } else {
        // Unknown error
        throw e;
      }
    }

    // If a readme is changed, to be conservative, handle as if every input file in the readme were changed
    const readme = new Readme(resolve(options.cwd ?? "", readmeFile), {
      content: readmeText,
      logger: options.logger,
    });
    const tags = await readme.getTags();
    const inputFiles = [...tags.values()].flatMap((t) =>
      [...t.inputFiles.keys()].map((p) => relative(dirname(readme.path), p)),
    );

    inputFiles.forEach((f) => {
      changedReadmeInputFiles.add(join(dirname(readmeFile), f));
    });
  }

  const changedSpecDirs = new Set([
    ...changedRmFiles.filter(swagger).map((f) => dirname(dirname(dirname(f)))),
    ...changedRmFiles.filter(example).map((f) => dirname(dirname(dirname(dirname(f))))),
    // Readme input files should use the same path format as changed swagger files
    ...[...changedReadmeInputFiles].map((f) => dirname(dirname(dirname(f)))),
  ]);

  if (changedSpecDirs.size === 0) {
    core.info("Could not map changed files to any spec directories");
    return false;
  }

  // Ensure that each changed spec dir contained at least one typespec-generated swagger in the base commitish
  for (const changedSpecDir of changedSpecDirs) {
    const specFilesBaseBranch = await git.raw([
      "ls-tree",
      "-r",
      "--name-only",
      "HEAD^",
      changedSpecDir,
    ]);

    // Filter files to only include RM swagger files
    const specRmSwaggerFilesBaseBranch = specFilesBaseBranch
      .split("\n")
      .filter((file) => resourceManager(file) && swagger(file));

    if (specRmSwaggerFilesBaseBranch.length === 0) {
      core.info(
        `Spec folder '${changedSpecDir}' in base branch does not exist or contains no swagger files`,
      );
      return false;
    }

    let containsTypeSpecGeneratedSwagger = false;
    // TODO: Add lint rule to prevent using "for...in" instead of "for...of"
    for (const file of specRmSwaggerFilesBaseBranch) {
      const baseSwagger = await git.show([`HEAD^:${file}`]);
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

  core.info("Appears to contain only incremental changes to existing TypeSpec RP(s)");
  return true;
}
