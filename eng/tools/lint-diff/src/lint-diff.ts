import { parseArgs, ParseArgsConfig } from "node:util";
import { pathExists } from "./util.js";
import { getRunList } from "./processChanges.js";
import { runChecks, getAutorestErrors } from "./runChecks.js";
import { correlateRuns } from "./correlateResults.js";
import { generateAutoRestErrorReport, generateLintDiffReport } from "./generateReport.js";

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

  // const versionResult = await executeCommand("npm exec -- autorest --version");
  // if (versionResult.error) {
  //   console.error("Error running autorest --version", versionResult.error);
  //   process.exit(1);
  // }

  // console.log("Autorest version:");
  // console.log(versionResult.stdout);

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
  const [beforeList, afterList, affectedSwaggers] = await getRunList(
    beforePath,
    afterPath,
    changedFilesPath,
  );

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
}
