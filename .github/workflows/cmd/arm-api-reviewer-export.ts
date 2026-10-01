#!/usr/bin/env node

import { execFileSync } from "node:child_process";
import { resolve } from "node:path";
import { parseArgs } from "node:util";

import { exportArmApiReviewer, GENERATED_MANIFEST_NAME } from "../src/arm-api-reviewer-export.ts";

function usage() {
  console.log(`Usage:
node .github/workflows/cmd/arm-api-reviewer-export.ts [options]

Options:
  --repo-root <path>       Source repository root. Defaults to this repository.
  --source-commit <sha>    Full source commit. Defaults to the checked-out HEAD.
  --output <path>          Empty directory to receive the package and generated manifest.
  --definition <path>      Alternate in-repository export definition for testing.
  --help                   Show this help.

When --output is omitted, the command validates the package and prints the
generated manifest without copying files.`);
}

const defaultRepoRoot = resolve(import.meta.dirname, "../../..");
const {
  values: {
    "repo-root": repoRoot,
    "source-commit": requestedSourceCommit,
    output,
    definition,
    help,
  },
} = parseArgs({
  options: {
    "repo-root": { type: "string", default: defaultRepoRoot },
    "source-commit": { type: "string" },
    output: { type: "string" },
    definition: { type: "string" },
    help: { type: "boolean", default: false },
  },
  allowPositionals: false,
});

if (help) {
  usage();
  process.exit(0);
}

try {
  const sourceCommit = execFileSync("git", ["-C", repoRoot, "rev-parse", "HEAD"], {
    encoding: "utf8",
  })
    .trim()
    .toLowerCase();
  if (requestedSourceCommit && requestedSourceCommit.toLowerCase() !== sourceCommit) {
    throw new Error(
      `Requested source commit ${requestedSourceCommit} does not match checked-out HEAD ${sourceCommit}.`,
    );
  }

  const manifest = await exportArmApiReviewer({
    repoRoot,
    sourceCommit,
    outputDir: output,
    definitionPath: definition,
  });

  if (output) {
    console.log(`Exported ${manifest.files.length} ARM API Reviewer files to ${resolve(output)}.`);
    console.log(`Manifest: ${resolve(output, GENERATED_MANIFEST_NAME)}`);
    console.log(`Content digest: ${manifest.contentDigest}`);
  } else {
    console.log(JSON.stringify(manifest, null, 2));
  }
} catch (error) {
  console.error("ARM API Reviewer export failed:", error);
  process.exitCode = 1;
}
