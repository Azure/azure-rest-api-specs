import { join, resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { parseArgs } from "util";
import { mkdir, writeFile } from "fs/promises";

import { swagger, readFileList, pathExists } from "@azure-tools/specs-shared/changed-files";
import { filterAsync } from "@azure-tools/specs-shared/array";

import {
  mappingJSONTemplate,
  repoJSONTemplate,
  indexMd,
  getSwaggersToProcess,
} from "./util.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

/**
 * Displays usage information for the CLI tool
 */
function usage() {
  console.log(
    "Usage: api-doc-preview --changed-files-path <path> --output <output-dir> [--spec-root <spec-root>] [--build-id <build-id>] [--spec-repo-owner <owner>] [--spec-repo-name <name>] [--spec-repo-pr-number <pr-number>]",
  );
  console.log("TODO");
}

/**
 * Main entry point for the CLI tool. Parses arguments, processes changed files, and writes doc preview artifacts.
 * @returns {Promise<void>}
 */
export async function main() {
  const {
    values: {
      "changed-files-path": changedFilesPath,
      output: outputDir,
      "build-id": buildId,
      "spec-repo-owner": specRepoOwner,
      "spec-repo-name": specRepoName,
      "spec-repo-pr-number": specRepoPrNumber,
      "spec-repo-root": specRepoRoot,
    },
  } = parseArgs({
    options: {
      "changed-files-path": { type: "string" },
      output: { type: "string" },
      "build-id": {
        type: "string",
        default: process.env.UNIFIED_PIPELINE_BUILD_ID || "",
      },
      "spec-repo-owner": {
        type: "string",
        default: process.env.SPEC_REPO_OWNER || "",
      },
      "spec-repo-name": {
        type: "string",
        default: process.env.SPEC_REPO_NAME || "",
      },
      "spec-repo-pr-number": {
        type: "string",
        default: process.env.SPEC_REPO_PULL_REQUEST_NUMBER || "",
      },
      "spec-repo-root": {
        type: "string",
        default: resolve(__dirname, "../../../../"),
      },
    },
    allowPositionals: false,
  });

  // TODO: Better validation
  let validArgs = true;
  if (!changedFilesPath) {
    console.log("Missing required parameter --changed-files-path");
    validArgs = false;
  }

  if (!outputDir) {
    console.log("Missing required parameter --output");
    validArgs = false;
  }

  if (!validArgs) {
    usage();
    process.exitCode = 1;
    return;
  }

  // Get selected version and swaggers to process

  const changedFiles = await readFileList(changedFilesPath);
  // TODO: `swagger` filter doesn't perfectly overlap with existing process. Determine if additional changes are needed to `swagger` check.
  const swaggerPaths = changedFiles.filter(swagger);
  const existingSwaggerFiles = await filterAsync(
    swaggerPaths,
    async (p) => await pathExists(resolve(specRepoRoot, p)),
  );

  if (existingSwaggerFiles.length === 0) {
    console.log(
      "No eligible swagger files found. No documentation artifacts will be written.",
    );
    return;
  }

  const { selectedVersion, swaggersToProcess } =
    getSwaggersToProcess(existingSwaggerFiles);

  const key = {
    owner: specRepoOwner,
    repo: specRepoName,
    prNumber: specRepoPrNumber,
  };

  await mkdir(outputDir, { recursive: true });
  await writeFile(
    join(outputDir, "repo.json"),
    JSON.stringify(repoJSONTemplate(key), null, 2),
  );
  await writeFile(
    join(outputDir, "mapping.json"),
    JSON.stringify(mappingJSONTemplate(swaggersToProcess), null, 2),
  );
  await writeFile(join(outputDir, "index.md"), indexMd(buildId, key));
  console.log(`Documentation preview artifacts written to ${outputDir}`);

  console.log(`Doc preview for API version ${selectedVersion} includes:`);
  swaggersToProcess.forEach((swagger) => console.log(`  - ${swagger}`));
  console.log(`Artifacts written to: ${outputDir}`);
}
