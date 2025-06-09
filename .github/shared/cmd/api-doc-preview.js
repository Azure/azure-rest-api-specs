#!/usr/bin/env node
import { join, resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { parseArgs } from "util";
import { mkdir, writeFile } from "fs/promises";

import { swagger, getChangedFiles, pathExists } from "../src/changed-files.js";
import { filterAsync } from "../src/array.js";

import {
  mappingJSONTemplate,
  repoJSONTemplate,
  indexMd,
  getSwaggersToProcess,
} from "../src/doc-preview.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

function usage() {
  console.log(`Usage:
npx api-doc-preview --output <output-dir>

parameters:
  --output <output-dir>       Directory to write documentation artifacts to.
  --build-id <build-id>       Build ID, used in the documentation index. Defaults to BUILD_BUILDID environment variable.
  --spec-repo-name <name>     Name of the repository containing the swagger files of the form <org>/<repo-name>. Defaults to BUILD_REPOSITORY_NAME environment variable.
  --spec-repo-pr-number <pr-number>  PR number of the repository containing the swagger files. Defaults to SYSTEM_PULLREQUEST_PULLREQUESTNUMBER environment variable.
  --spec-repo-root <path>     Root path of the repository containing the swagger files. Defaults to the root of the repository containing this script.`);
}

export async function main() {
  const {
    values: {
      output: outputDir,
      "build-id": buildId,
      "spec-repo-name": specRepoName,
      "spec-repo-pr-number": specRepoPrNumber,
      "spec-repo-root": specRepoRoot,
    },
  } = parseArgs({
    options: {
      output: { type: "string" },
      "build-id": {
        type: "string",
        default: process.env.BUILD_BUILDID || "",
      },
      "spec-repo-name": {
        type: "string",
        default: process.env.BUILD_REPOSITORY_NAME || "",
      },
      "spec-repo-pr-number": {
        type: "string",
        default: process.env.SYSTEM_PULLREQUEST_PULLREQUESTNUMBER || "",
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

  if (!outputDir) {
    console.log(`Missing required parameter --output. Value given: ${outputDir || '<empty>'}`);
    validArgs = false;
  }

  if (!validArgs) {
    usage();
    process.exitCode = 1;
    return;
  }

  // Get selected version and swaggers to process

  const changedFiles = await getChangedFiles({ cwd: specRepoRoot });
  console.log(`Found ${changedFiles.length} changed files in ${specRepoRoot}`);
  console.log("Changed files:");
  changedFiles.forEach((file) => console.log(`  - ${file}`));
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
    repoName: specRepoName,
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

await main();