#!/usr/bin/env node
// @ts-check

import { mkdir, writeFile } from "fs/promises";
import { dirname, join, resolve } from "path";
import { fileURLToPath } from "url";
import { parseArgs } from "util";

import { getChangedFilesStatuses, swagger } from "../../shared/src/changed-files.js";

import {
  getSwaggersToProcess,
  indexMd,
  mappingJSONTemplate,
  repoJSONTemplate,
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
    output: { type: "string", default: "" },
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
      default: resolve(__dirname, "../../../"),
    },
  },
  allowPositionals: false,
});

let validArgs = true;

if (!outputDir) {
  console.log(`Missing required parameter --output. Value given: ${outputDir || "<empty>"}`);
  validArgs = false;
}

if (!specRepoName) {
  console.log(
    `Missing required parameter --spec-repo-name. Value given: ${specRepoName || "<empty>"}`,
  );
  validArgs = false;
}

if (!specRepoPrNumber) {
  console.log(
    `Missing required parameter --spec-repo-pr-number. Value given: ${specRepoPrNumber || "<empty>"}`,
  );
  validArgs = false;
}

if (!specRepoRoot) {
  console.log(`Invalid parameter --spec-repo-root. Value given: ${specRepoRoot || "<empty>"}`);
  validArgs = false;
}

if (!validArgs) {
  usage();
  process.exit(1);
}

// Get selected version and swaggers to process

const changedFileStatuses = await getChangedFilesStatuses({
  cwd: specRepoRoot,
  paths: ["specification"],
});

// Exclude deleted files as they are not relevant for generating documentation.
const changedFiles = [
  ...changedFileStatuses.additions,
  ...changedFileStatuses.modifications,
  // Current names of renamed files are interesting, previous names are not.
  ...changedFileStatuses.renames.map((r) => r.to),
];
console.log(`Found ${changedFiles.length} relevant changed files in ${specRepoRoot}`);
console.log("Changed files:");
changedFiles.forEach((file) => console.log(`  - ${file}`));
const swaggerPaths = changedFiles.filter(swagger);

if (swaggerPaths.length === 0) {
  console.log("No eligible swagger files found. No documentation artifacts will be written.");
  process.exit(0);
}

const { selectedVersion, swaggersToProcess } = getSwaggersToProcess(swaggerPaths);

if (swaggersToProcess.length === 0) {
  console.log("No swagger files to process. No documentation artifacts will be written.");
  process.exit(0);
}

const repoName = specRepoName;
const prNumber = specRepoPrNumber;

await mkdir(outputDir, { recursive: true });
await writeFile(
  join(outputDir, "repo.json"),
  JSON.stringify(repoJSONTemplate(repoName, prNumber), null, 2),
);
await writeFile(
  join(outputDir, "mapping.json"),
  JSON.stringify(mappingJSONTemplate(swaggersToProcess), null, 2),
);
await writeFile(join(outputDir, "index.md"), indexMd(buildId, repoName, prNumber));
console.log(`Documentation preview artifacts written to ${outputDir}`);

console.log(`Doc preview for API version ${selectedVersion} includes:`);
swaggersToProcess.forEach((swagger) => console.log(`  - ${swagger}`));
console.log(`Artifacts written to: ${outputDir}`);
