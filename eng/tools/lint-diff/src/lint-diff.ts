import { SpecModelError } from "@azure-tools/specs-shared/spec-model-error";
import { SWAGGER_SUPPRESSION_TOOLS } from "@azure-tools/specs-shared/swagger-suppressions";
import { getSuppressionsForTools } from "@azure-tools/suppressions";
import { writeFile } from "node:fs/promises";
import { relative, resolve } from "node:path";
import { inspect, parseArgs, type ParseArgsConfig } from "node:util";
import { correlateRuns } from "./correlateResults.ts";
import { generateAutoRestErrorReport, generateLintDiffReport } from "./generateReport.ts";
import { type ReadmeAffectedTags } from "./lintdiff-types.ts";
import { getDefaultTag } from "./markdown-utils.ts";
import { getRunList } from "./processChanges.ts";
import { getAutorestErrors, runChecks } from "./runChecks.ts";
import { getDependencyVersion, getPathToDependency, pathExists } from "./util.ts";

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
      before: beforeArg,
      after: afterArg,
      "changed-files-path": changedFilesPath,
      "out-file": outFile,
      "base-branch": baseBranch,
      "compare-sha": compareSha,
      "github-repo-path": githubRepoPath,
    },
  } = parseArgs(config);

  // TODO: Handle trailing slashes properly
  if (!beforeArg || !(await pathExists(beforeArg as string))) {
    validArgs = false;
    console.log(`--before must be a valid path. Value passed: ${inspect(beforeArg) || "<empty>"}`);
  }

  // TODO: Handle trailing slashes properly
  if (!afterArg || !(await pathExists(afterArg as string))) {
    validArgs = false;
    console.log(`--after must be a valid path. Value passed: ${inspect(afterArg) || "<empty>"}`);
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
    githubRepoPath as string,
  );
}

async function runLintDiff(
  beforePath: string,
  afterPath: string,
  changedFilesPath: string,
  outFile: string,
  baseBranch: string,
  compareSha: string,
  githubRepoPath: string,
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
      console.log("\n❌ Error building Spec Model from changed file list:");
      console.log(`${inspect(error)}`);

      process.exitCode = 1;
      return;
    }

    throw error;
  }

  const originalAffectedSwaggers = affectedSwaggers;
  affectedSwaggers = await getUnsuppressedSwaggers(afterPath, affectedSwaggers);

  if (originalAffectedSwaggers.size > 0) {
    afterList = await filterRunList(
      afterPath,
      afterList,
      originalAffectedSwaggers,
      affectedSwaggers,
    );
    beforeList = filterBeforeRunList(beforeList, afterList);
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
    await generateAutoRestErrorReport(autoRestErrors, outFile);
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

export async function getUnsuppressedSwaggers(
  afterPath: string,
  affectedSwaggers: Set<string>,
): Promise<Set<string>> {
  const result = new Set<string>();

  for (const swaggerPath of affectedSwaggers) {
    const suppressions = await getSuppressionsForTools(
      [SWAGGER_SUPPRESSION_TOOLS.lintDiff, SWAGGER_SUPPRESSION_TOOLS.all],
      resolve(afterPath, swaggerPath),
    );
    const isSuppressed = suppressions.some(
      (suppression) => !suppression.rules?.length && !suppression.subRules?.length,
    );

    if (isSuppressed) {
      console.log(`Skipping suppressed Swagger file: ${swaggerPath}`);
    } else {
      result.add(swaggerPath);
    }
  }

  return result;
}

export async function filterRunList(
  rootPath: string,
  runList: Map<string, ReadmeAffectedTags>,
  affectedSwaggers: Set<string>,
  unsuppressedSwaggers: Set<string>,
): Promise<Map<string, ReadmeAffectedTags>> {
  const result = new Map<string, ReadmeAffectedTags>();
  const normalizedAffectedSwaggers = new Set(
    [...affectedSwaggers].map((swaggerPath) => swaggerPath.replaceAll("\\", "/")),
  );
  const normalizedUnsuppressedSwaggers = new Set(
    [...unsuppressedSwaggers].map((swaggerPath) => swaggerPath.replaceAll("\\", "/")),
  );

  for (const [readmePath, affectedTags] of runList) {
    const allTags = await affectedTags.readme.getTags();
    const retainedTags = new Set<string>();

    for (const changedTag of affectedTags.changedTags) {
      const effectiveTag = changedTag || (await getDefaultTag(affectedTags.readme));
      const tag = allTags.get(effectiveTag);

      if (!tag) {
        retainedTags.add(changedTag);
        continue;
      }

      const inputFiles = [...tag.inputFiles.keys()].map((inputFile) =>
        relative(rootPath, inputFile).replaceAll("\\", "/"),
      );
      const hasAffectedSwagger = inputFiles.some((inputFile) =>
        normalizedAffectedSwaggers.has(inputFile),
      );
      const hasUnsuppressedSwagger = inputFiles.some((inputFile) =>
        normalizedUnsuppressedSwaggers.has(inputFile),
      );

      if (!hasAffectedSwagger || hasUnsuppressedSwagger) {
        retainedTags.add(changedTag);
      } else {
        console.log(`Skipping fully suppressed LintDiff tag: ${readmePath}#${effectiveTag}`);
      }
    }

    if (retainedTags.size > 0) {
      result.set(readmePath, {
        readme: affectedTags.readme,
        changedTags: retainedTags,
      });
    }
  }

  return result;
}

export function filterBeforeRunList(
  beforeList: Map<string, ReadmeAffectedTags>,
  afterList: Map<string, ReadmeAffectedTags>,
): Map<string, ReadmeAffectedTags> {
  return new Map([...beforeList].filter(([readmePath]) => afterList.has(readmePath)));
}
