import { parseArgs, ParseArgsConfig } from "node:util";
import { pathExists, getDependencyVersion, getPathToDependency } from "./util.js";
import { getRunList } from "./processChanges.js";
import { runChecks, getAutorestErrors } from "./runChecks.js";
import { correlateRuns } from "./correlateResults.js";
import { generateAutoRestErrorReport, generateLintDiffReport } from "./generateReport.js";
import { writeFile } from "node:fs/promises";
import { SpecModelError } from "@azure-tools/specs-shared/spec-model-error";

function usage() {
  console.log("TODO: Write up usage");
}

export async function main() {
  let validArgs = true;
  const config: ParseArgsConfig = {
    options: {
      before: {
        type: "string",
        short: "b",
      },
      after: {
        type: "string",
        short: "a",
      },
      "changed-files-path": {
        type: "string",
        short: "c",
      },
      "out-file": {
        type: "string",
        short: "o",
        default: "lint-diff.md",
      },
      // TODO: Consider using git commands to determine this information
      "base-branch": {
        type: "string",
        short: "b",
        default: "main",
      },
      "compare-sha": {
        type: "string",
        short: "m",
        default: "main",
      },
    },
    strict: true,
  };

  const {
    values: {
      before: beforeArg,
      after: afterArg,
      "changed-files-path": changedFilesPath,
      "out-file": outFile,
      "base-branch": baseBranch,
      "compare-sha": compareSha,
    },
  } = parseArgs(config);

  // TODO: Handle trailing slashes properly
  if (!beforeArg || !(await pathExists(beforeArg as string))) {
    validArgs = false;
    console.log(`--before must be a valid path. Value passed: ${beforeArg || "<empty>"}`);
  }

  // TODO: Handle trailing slashes properly
  if (!afterArg || !(await pathExists(afterArg as string))) {
    validArgs = false;
    console.log(`--after must be a valid path. Value passed: ${afterArg || "<empty>"}`);
  }

  if (!changedFilesPath || !(await pathExists(changedFilesPath as string))) {
    validArgs = false;
    console.log("--changed-files-path missing");
  }

  if (!validArgs) {
    usage();
    process.exit(1);
  }

  const validatorVersion = await getDependencyVersion(
    await getPathToDependency("@microsoft.azure/openapi-validator"),
  );
  console.log(`Using @microsoft.azure/openapi-validator version: ${validatorVersion}\n`);

  await runLintDiff(
    beforeArg as string,
    afterArg as string,
    changedFilesPath as string,
    outFile as string,
    baseBranch as string,
    compareSha as string,
  );
}

async function runLintDiff(
  beforePath: string,
  afterPath: string,
  changedFilesPath: string,
  outFile: string,
  baseBranch: string,
  compareSha: string,
) {
  let beforeList, afterList, affectedSwaggers;
  try {
    [beforeList, afterList, affectedSwaggers] = await getRunList(
      beforePath,
      afterPath,
      changedFilesPath,
    );
  } catch (error) {
    if (error instanceof SpecModelError) { 
      console.log("\n\n");
      console.log("❌ Error building Spec Model from changed file list:");
      console.log(`${error}`);
      console.log("Ensure input files and references are valid.");

      process.exitCode = 1;
      return;
    }

    throw error;
  }

  if (beforeList.size === 0 && afterList.size === 0) {
    await writeFile(outFile, "No changes found. Exiting.");
    console.log("No changes found. Exiting.");
    return;
  }

  if (afterList.size === 0) { 
    await writeFile(outFile, "No applicable files found in after. Exiting.");
    console.log("No applicable files found in after. Exiting.");
    return;
  }

  // It may be possible to run these in parallel as they're running against
  // different directories.
  const beforeChecks = await runChecks(beforePath, beforeList);
  const afterChecks = await runChecks(afterPath, afterList);


  // If afterChecks has AutoRest errors, fail the run.
  const autoRestErrors = afterChecks
    .map((result) => {
      return { result, errors: getAutorestErrors(result) };
    })
    .filter((result) => result.errors.length > 0);
  if (autoRestErrors.length > 0) {
    generateAutoRestErrorReport(autoRestErrors, outFile);
    console.log("AutoRest errors found. See workflow summary for details.");

    process.exitCode = 1;
    console.error(`AutoRest errors found. See workflow summary report in ${outFile} for details.`);
    return;
  }

  const runCorrelations = await correlateRuns(beforePath, beforeChecks, afterChecks);

  const pass = await generateLintDiffReport(
    runCorrelations,
    affectedSwaggers,
    outFile,
    baseBranch,
    compareSha,
  );

  if (!pass) {
    process.exitCode = 1;
    console.error(`Lint-diff failed. See workflow summary report in ${outFile} for details.`);
  }

  if (process.env.GITHUB_SERVER_URL && process.env.GITHUB_REPOSITORY && process.env.GITHUB_RUN_ID) {
    console.log(
      `See workflow summary at: ${process.env.GITHUB_SERVER_URL}/${process.env.GITHUB_REPOSITORY}/actions/runs/${process.env.GITHUB_RUN_ID}`,
    );
  }
}
