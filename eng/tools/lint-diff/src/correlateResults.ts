import { basename, join, relative } from "path";
import { relativizePath, pathExists, isFailure, isWarning } from "./util.js";
import { AutorestRunResult, BeforeAfter, LintDiffViolation, Source } from "./lintdiff-types.js";
import { getDefaultTag } from "./markdown-utils.js";
import { Readme } from "@azure-tools/specs-shared/readme";

export async function correlateRuns(
  beforePath: string,
  beforeChecks: AutorestRunResult[],
  afterChecks: AutorestRunResult[],
): Promise<Map<string, BeforeAfter>> {
  const runCorrelations = new Map<string, BeforeAfter>();
  console.log("\nCorrelating runs...");
  for (const results of afterChecks) {
    const { rootPath, readme, tag } = results;
    const readmePathRelative = relative(rootPath, readme.path);

    const key = tag ? `${readmePathRelative}#${tag}` : readmePathRelative;
    if (runCorrelations.has(key)) {
      throw new Error(`Duplicate key found correlating autorest runs: ${key}`);
    }

    // Look for candidates matching readme and tag
    const beforeCandidates = beforeChecks.filter((r) => {
      return relative(beforePath, r.readme.path) === readmePathRelative && r.tag === tag;
    });
    if (beforeCandidates.length === 1) {
      runCorrelations.set(key, {
        before: beforeCandidates[0],
        after: results,
      });
      continue;
    } else if (beforeCandidates.length > 1) {
      throw new Error(`Multiple before candidates found for key ${key}`);
    }

    // Look for candidates with a matching default tag from the baseline
    const beforeReadmePath = join(beforePath, readmePathRelative);
    if (await pathExists(beforeReadmePath)) {
      const beforeReadme = new Readme(beforeReadmePath);
      const defaultTag = await getDefaultTag(beforeReadme);
      if (!defaultTag) {
        throw new Error(`No default tag found for readme ${readme} in before state`);
      }
      const beforeDefaultTagCandidates = beforeChecks.filter(
        (r) => relative(beforePath, r.readme.path) === readmePathRelative && r.tag === defaultTag,
      );

      if (beforeDefaultTagCandidates.length === 1) {
        runCorrelations.set(key, {
          before: beforeDefaultTagCandidates[0],
          after: results,
        });
        continue;
      } else if (beforeDefaultTagCandidates.length > 1) {
        throw new Error(
          `Multiple before candidates found for key ${key} using default tag ${defaultTag}`,
        );
      }

      // Look for candidates matching just the readme file
      const beforeReadmeCandidate = beforeChecks.filter(
        (r) => relative(beforePath, r.readme.path) === readmePathRelative,
      );
      if (beforeReadmeCandidate.length === 1) {
        runCorrelations.set(key, {
          before: beforeReadmeCandidate[0],
          after: results,
        });
        continue;
      } else if (beforeReadmeCandidate.length > 1) {
        throw new Error(`Multiple before candidates found for key ${key} using readme ${readme}`);
      }
    }

    console.log(`No before candidates found for key ${key}, using no baseline`);
    runCorrelations.set(key, {
      before: null,
      after: results,
    });
  }

  return runCorrelations;
}

export function getViolations(
  runCorrelations: Map<string, BeforeAfter>,
  affectedSwaggers: Set<string>,
) {
  const newViolations: LintDiffViolation[] = [];
  const existingViolations: LintDiffViolation[] = [];

  for (const [, { before, after }] of runCorrelations.entries()) {
    const beforeViolations = before
      ? getLintDiffViolations(before).filter(
          (v) => (isFailure(v.level) || isWarning(v.level)) && v.source?.length > 0,
        )
      : [];
    const afterViolations = getLintDiffViolations(after).filter(
      (v) =>
        // Fatal errors are always new
        v.level.toLowerCase() === "fatal" ||
        ((isFailure(v.level) || isWarning(v.level)) &&
          v.source?.length > 0 &&
          affectedSwaggers.has(relativizePath(v.source[0].document).slice(1))),
    );

    const [newItems, existingItems] = getNewItems(beforeViolations, afterViolations);

    const beforeReadmePath = before ? relative(before?.rootPath, before?.readme.path) : "";
    const afterReadmePath = relative(after.rootPath, after.readme.path);

    console.log("Correlation:");
    console.log(`\tBefore: Readme: ${beforeReadmePath} Tag: ${before?.tag}`);
    console.log(`\tAfter: Readme : ${afterReadmePath} Tag: ${after.tag}`);

    newViolations.push(...newItems);
    existingViolations.push(...existingItems);
  }

  return [newViolations, existingViolations];
}

// Ensure that diagnostic information emitted by azure-openapi-validator
// to stdout is not interpreted as a diff occurrence.
// Assume that all messages emitted as "information" or "debug" or "verbose" are
// diagnostic output and hence can be excluded, and that all diagnostic output
// is emitted as "information" or "debug" or "verbose", so we don't have to
// exclude anything beyond these levels.
const diagnosticLevelStrings: string[] = [
  '"level":"information"',
  '"level":"debug"',
  '"level":"verbose"',
];

export function getLintDiffViolations(runResult: AutorestRunResult): LintDiffViolation[] {
  const violations: LintDiffViolation[] = [];

  for (const line of (runResult.stderr + runResult.stdout).split("\n")) {
    // TODO: Check for fatal autorest run errors and surface those

    if (!line.includes('"extensionName":"@microsoft.azure/openapi-validator"')) {
      continue;
    }

    // Ignore all lines that are "diagnostic" output from autorest
    if (diagnosticLevelStrings.some((level) => line.includes(level))) {
      continue;
    }

    const result = JSON.parse(line.trim());
    if (result.code == undefined) {
      // Results without a code can be assumed to be fatal errors. Set the code 
      // to "FATAL"
      result.code = "FATAL";
    }
    violations.push(result as LintDiffViolation);
  }

  return violations;
}

// This logic is duplicated from momentOfTruthPostProcessing.ts:140
export function getNewItems(
  before: LintDiffViolation[],
  after: LintDiffViolation[],
): [LintDiffViolation[], LintDiffViolation[]] {
  const newItems = [];
  const existingItems = [];

  for (const afterViolation of after) {
    let errorIsNew = true;

    // Always treat fatal errors as new
    if (afterViolation.level.toLowerCase() === "fatal") {
      newItems.push(afterViolation);
      continue;
    }

    // Search through "before" to find a matching violation
    for (const beforeViolation of before) {
      if (
        beforeViolation.level == afterViolation.level &&
        beforeViolation.code == afterViolation.code &&
        beforeViolation.message == afterViolation.message &&
        beforeViolation.source?.length == afterViolation.source?.length &&
        beforeViolation.source?.length &&
        afterViolation.source?.length &&
        isSameSources(beforeViolation.source, afterViolation.source) &&
        arrayIsEqual(beforeViolation.details?.jsonpath, afterViolation.details?.jsonpath)
      ) {
        errorIsNew = false;
        existingItems.push(afterViolation);

        // Only need to find one match
        break;
      }
    }

    // If no match is found, add to new
    if (errorIsNew) {
      newItems.push(afterViolation);
    }
  }

  return [newItems, existingItems];
}

export function isSameSources(a: Source[], b: Source[]) {
  if (a?.length && b?.length) {
    return basename(a?.[0]?.document) === basename(b?.[0]?.document);
  }
  return true;
}

export function arrayIsEqual(a: any[], b: any[]) {
  if (a.length !== b.length) {
    return false;
  }
  for (let i = 0; i < a.length; i++) {
    if (a[i] !== b[i]) {
      return false;
    }
  }
  return true;
}
