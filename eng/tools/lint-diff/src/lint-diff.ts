import { getChangedFiles } from "@azure-tools/specs-shared/changed-files";
import { getBranchName, getSha } from "@azure-tools/specs-shared/simple-git";
import { SpecModelError } from "@azure-tools/specs-shared/spec-model-error";
import { writeFile } from "node:fs/promises";
import { resolve } from "node:path";
import { parseArgs, ParseArgsConfig } from "node:util";
import { correlateRuns } from "./correlateResults.js";
import { generateAutoRestErrorReport, generateLintDiffReport } from "./generateReport.js";
import { getRunList } from "./processChanges.js";
import { getAutorestErrors, runChecks } from "./runChecks.js";
import { getDependencyVersion, getPathToDependency, pathExists } from "./util.js";

function usage() {
  console.log(`Lint changes between before and after state of repositories
Usage: npm exec --no -- lint-diff --before <path> --after <path> [--out-file <file>] [--github-repo-path <repo>]

  --before <path>           Path to the git repository before the changes.
  --after <path>            Path to the git repository after the changes.
  --out-file <file>         Output file for the lint diff report. Default: lint-diff.md
  --github-repo-path <repo> Path to the GitHub repository. Default: environment variable GITHUB_REPOSITORY or Azure/azure-rest-api-specs
  --help                    Show this help message and exit.
`);
}

export async function main() {
  let validArgs = true;
  const config: ParseArgsConfig = {
    options: {
      help: {
        type: "boolean",
        short: "h",
        default: false,
      },
      before: {
        type: "string",
        short: "b",
      },
      after: {
        type: "string",
        short: "a",
      },
      "out-file": {
        type: "string",
        short: "o",
        default: "lint-diff.md",
      },
      "github-repo-path": {
        type: "string",
        short: "r",
        default: process.env.GITHUB_REPOSITORY || "Azure/azure-rest-api-specs",
      },
    },
    strict: true,
  };

  const {
    values: {
      help: helpArg,
      before: beforeArg,
      after: afterArg,
      "out-file": outFile,
      "github-repo-path": githubRepoPath,
    },
  } = parseArgs(config);

  if (helpArg) {
    usage();
    process.exit(0);
  }

  if (!beforeArg || !(await pathExists(beforeArg as string))) {
    validArgs = false;
    console.log(`--before must be a valid path. Value passed: ${beforeArg || "<empty>"}`);
  }

  if (!afterArg || !(await pathExists(afterArg as string))) {
    validArgs = false;
    console.log(`--after must be a valid path. Value passed: ${afterArg || "<empty>"}`);
  }

  if (!validArgs) {
    usage();
    process.exit(1);
  }

  const validatorVersion = await getDependencyVersion(
    await getPathToDependency("@microsoft.azure/openapi-validator"),
  );
  console.log(`Using @microsoft.azure/openapi-validator version: ${validatorVersion}\n`);

  const beforePath = beforeArg as string;
  const afterPath = afterArg as string;

  await runLintDiff(beforePath, afterPath, outFile as string, githubRepoPath as string);
}

async function runLintDiff(
  beforePath: string,
  afterPath: string,
  outFile: string,
  githubRepoPath: string,
) {
  const baseSha = await getSha(resolve(beforePath));
  const changedFiles = await getChangedFiles({
    cwd: resolve(afterPath),
    baseCommitish: baseSha,
    headCommitish: "",
    paths: ["specification"],
  });

  let beforeList, afterList, affectedSwaggers;
  try {
    [beforeList, afterList, affectedSwaggers] = await getRunList(
      beforePath,
      afterPath,
      changedFiles,
    );
  } catch (error) {
    if (error instanceof SpecModelError) {
      console.log("\n❌ Error building Spec Model from changed file list:");
      console.log(`${error}`);

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
  console.log("Running checks on before state...");
  const beforeChecks = await runChecks(beforePath, beforeList);

  console.log("Running checks on after state...");
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
  const compareSha = await getSha(resolve(afterPath));
  const baseRef = (await getBranchName(resolve(beforePath))) || baseSha;

  const pass = await generateLintDiffReport(
    runCorrelations,
    affectedSwaggers,
    outFile,
    baseRef,
    compareSha,
    githubRepoPath,
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
