
import { getChangedFiles, getChangedFilesStatuses, swagger } from "../src/changed-files.js";
import { parseArgs } from "node:util";
import { dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { readdir, access, stat } from "node:fs/promises";
import { join } from "node:path";

function usage() {
  console.log(`Usage:
npx api-doc-preview --output <output-dir>

parameters:
  --repoWithChanges <repo directory>                         Directory checked out with PR Changes
  --referenceFolder <azure-rest-api-specs-pr@RPSaaSMAster>   The azure-rest-api-specs-pr directory checked out at RPSaaSMaster branch.`);
}

const {
  values: {
    "repoWithChanges": repoWithChanges,
    "referenceFolder": referenceFolder
  },
} = parseArgs({
  options: {
    "repoWithChanges": {
      type: "string",
      default: process.env.BUILD_SOURCESDIRECTORY || "",
    },
    "referenceFolder": {
      type: "string",
      default: process.env.PRIVATESPECSDIRECTORY || "",
    },
  },
  allowPositionals: false,
});

let validArgs = true;


if (!repoWithChanges) {
  console.log(
    `Missing required parameter --repoWithChanges. Value given: ${repoWithChanges || "<empty>"}`,
  );
  validArgs = false;
}

if (!referenceFolder) {
  console.log(
    `Missing required parameter --referenceFolder. Value given: ${referenceFolder || "<empty>"}`,
  );
  validArgs = false;
}

if (!validArgs) {
  usage();
  process.exit(1);
}

const changedFiles = await getChangedFiles({
  cwd: repoWithChanges,
  paths: ["specification"],
});

// Extract RP folders from changed files
// Files will be in format: specification/<rp>/<rest-of-path>
const changedRpFolders = new Set();

for (const filePath of changedFiles) {
  // Split the path and check if it starts with 'specification'
  const pathParts = filePath.split('/');

  if (pathParts.length >= 2 && pathParts[0] === 'specification') {
    // The second part is the RP folder name
    const rpFolder = pathParts[1];
    changedRpFolders.add(rpFolder);
  }
}

console.log(`Found ${changedRpFolders.size} changed RP folders:`, Array.from(changedRpFolders));

// Get the list of RP folders from the reference directory
const referenceSpecPath = join(referenceFolder, 'specification');

// Check if reference directory exists
try {
  await access(referenceSpecPath);
} catch (error) {
  console.error(`Reference specification directory does not exist: ${referenceSpecPath}`);
  process.exit(1);
}

let referenceRpFolders;
try {
  // Get all items in the reference specification folder
  const items = await readdir(referenceSpecPath);

  // Filter to only directories
  referenceRpFolders = [];
  for (const item of items) {
    const itemPath = join(referenceSpecPath, item);
    try {
      const stats = await stat(itemPath);
      if (stats.isDirectory()) {
        referenceRpFolders.push(item);
      }
    } catch (statError) {
      // Skip items we can't stat (permissions, etc.)
      console.warn(`Warning: Could not stat ${itemPath}:`, statError.message);
    }
  }
} catch (error) {
  console.error(`Error reading reference directory ${referenceSpecPath}:`, error.message);
  process.exit(1);
}

console.log(`Found ${referenceRpFolders.length} RP folders in reference directory`);

// Check if all changed RP folders exist in the reference directory
const missingRpFolders = [];

for (const rpFolder of changedRpFolders) {
  if (!referenceRpFolders.includes(rpFolder)) {
    missingRpFolders.push(rpFolder);
  }
}

if (missingRpFolders.length > 0) {
  console.error(`ERROR: The following RP folders are missing from the reference directory:`);
  for (const missingFolder of missingRpFolders) {
    console.error(`  - ${missingFolder}`);
  }
  console.error(`These folders must exist in the reference directory before changes can be processed.`);
  process.exit(1);
}
process.exit(0);
