import { basename, join, sep } from "path";
import { readFile, writeFile } from "node:fs/promises";
import { kebabCase } from "change-case";
import { getDefaultTag, getRelatedArmRpcFromDoc } from "./markdown-utils.js";
import {
  AutorestRunResult,
  pathExists,
  getPathToDependency,
  getDependencyVersion,
} from "./util.js";

// TODO: Name
export type BeforeAfter = {
  // TODO: This is nullable
  before: AutorestRunResult | null;
  after: AutorestRunResult;
};

export type Source = {
  document: string;
  position: {
    line: number;
    // TODO: this is misspelled in momentOfTruthUtils.ts. Is this value ever
    // properly populated?
    colomn: number;
  };
};

export type LintingResultMessage = {
  level: string;
  code: string;
  message: string;
  source: Source[];
  validationCategory?: string;
  details: {
    jsonpath: (string | number)[];
    validationCategory?: string;
  };
};

export type LintDiffViolation = LintingResultMessage & {
  groupName?: string;
  filePath?: string;
  lineNumber?: number;
  armRpcs?: string[];
};

export async function generateReport(
  beforePath: string, // TODO: is beforePath required?
  reportMap: Map<string, AutorestRunResult[]>,
  outFile: string,
  baseBranch: string,
  compareSha: string,
) {
  // Build map of compared readmes and tags from autorest runs. This can be
  // removed when "before" state is removed.
  const runCorrelations = new Map<string, BeforeAfter>();
  for (const results of reportMap.get("after")!) {
    const { readme, tag } = results;
    const key = tag ? `${readme}#${tag}` : readme;
    if (runCorrelations.has(key)) {
      throw new Error(`Duplicate key found correlating autorest runs: ${key}`);
    }

    const beforeCandidates = reportMap
      .get("before")!
      .filter((r) => r.readme === readme && r.tag === tag);
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
    const beforeReadmePath = join(beforePath, readme);
    if (await pathExists(beforeReadmePath)) {
      const readmeContent = await readFile(beforeReadmePath, { encoding: "utf-8" });
      const defaultTag = getDefaultTag(readmeContent);
      if (!defaultTag) {
        throw new Error(`No default tag found for readme ${readme} in before state`);
      }
      const beforeDefaultTagCandidates = reportMap
        .get("before")!
        .filter((r) => r.readme === readme && r.tag === defaultTag);

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

      const beforeReadmeCandidate = reportMap.get("before")!.filter((r) => r.readme === readme);
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

  // See unifiedPipelineHelper.ts:386
  // Compared specs (link to npm package: @microsoft.azure/openapi-validator/v/<version>)
  const dependencyVersion = await getDependencyVersion(
    await getPathToDependency("@microsoft.azure/openapi-validator"),
  );
  let outputMarkdown = `| Compared specs ([v${dependencyVersion}](https://www.npmjs.com/package/@microsoft.azure/openapi-validator/v/${dependencyVersion})) | new version | base version |\n`;
  outputMarkdown += `| --- | --- | --- |\n`;

  // Compared Specs | New Version | Base Version
  // <tag name> | link: readme.md#tag-<tag-name> | link: readme.md#tag-<tag-name>
  // ... | ... | ...
  for (const [_, { before, after }] of runCorrelations.entries()) {
    // TODO: DRY
    const afterName = after.tag ? after.tag : "default";
    const beforeName = before?.tag ? before?.tag : "default";
    const afterPath = after.tag ? `${after.readme}#tag-${after.tag}` : after.readme;
    // TODO: Clean this up
    const beforePath = before
      ? before?.tag
        ? `${before?.readme}#tag-${before?.tag}`
        : before?.readme
      : "";

    outputMarkdown += `| ${afterName} | link: [${afterName}](${getFileLink(compareSha, `/${afterPath}`)}) | link: [${beforeName}](${getFileLink(baseBranch, `/${beforePath}`)}) |\n`;
  }

  outputMarkdown += `\n\n`;

  const newViolations: LintDiffViolation[] = [];
  const existingViolations: LintDiffViolation[] = [];

  for (const [_, { before, after }] of runCorrelations.entries()) {
    // TODO: May need to do some filtering of unrelated swaggers, see
    // momentOfTruthPostProcessing.ts:421
    // TODO: Trinary, should this happen?
    const beforeViolations = before
      ? getLintDiffViolations(before).filter((v) => isFailure(v.level) || isWarning(v.level))
      : [];
    const afterViolations = getLintDiffViolations(after).filter(
      (v) => isFailure(v.level) || isWarning(v.level),
    );

    const [newitems, existingItems] = getNewItems(beforeViolations, afterViolations);
    console.log(`New violations: ${newitems.length}`);
    console.log(`Existing violations: ${existingItems.length}`);

    newViolations.push(...newitems);
    existingViolations.push(...existingItems);
  }

  for (const newItem of newViolations) {
    // TODO: Potential performance issue, make parallel
    newItem.armRpcs = await getRelatedArmRpcFromDoc(newItem.code);
  }

  newViolations.sort(compareLintDiffViolations);
  existingViolations.sort(compareLintDiffViolations);

  // MUST FIX Following errors/warnings are introduced by the current PR
  // Rule | Message | Related RPC [For API reviewers]
  if (newViolations.length > 0) {
    outputMarkdown += "**[must fix]The following errors/warnings are intorduced by current PR:**\n";
    if (newViolations.length > 50) {
      // TODO: Const
      outputMarkdown += "Only 50 items are listed, please refer to log for more details.\n";
    }
    outputMarkdown += "\n";

    outputMarkdown += "| Rule | Message | Related RPC [For API reviewers] |\n";
    outputMarkdown += "| ---- | ------- | ------------------------------- |\n";

    for (const violation of newViolations.slice(0, 50)) {
      const { level, code, message } = violation;
      outputMarkdown += `| ${iconFor(level)} [${code}](${getDocUrl(code)}) | ${message}<br />Location: [${getPathSegment(relativizePath(getFile(violation)))}#L${getLine(violation)}](${getFileLink(compareSha, relativizePath(getFile(violation)), getLine(violation))}) | ${violation.armRpcs?.join(", ")} |\n`;
    }

    outputMarkdown += "\n";
  }

  // The following errors/warnings exist before current PR submission
  // Rule | Message | Location (link to file, line # at SHA)
  if (existingViolations.length > 0) {
    outputMarkdown += "**The following errors/warnings exist before current PR submission:**\n";
    if (existingViolations.length > 50) {
      // TODO: Const
      outputMarkdown += "Only 50 items are listed, please refer to log for more details.\n";
    }
    outputMarkdown += "\n";

    // TODO: ensure columns are correct
    outputMarkdown += "| Rule | Message |\n";
    outputMarkdown += "| ---- | ------- |\n";

    for (const violation of existingViolations.slice(0, 50)) {
      const { level, code, message } = violation;
      outputMarkdown += `| ${iconFor(level)} [${code}](${getDocUrl(code)}) | ${message}<br />Location: [${getPathSegment(relativizePath(getFile(violation)))}#L${getLine(violation)}](${getFileLink(compareSha, relativizePath(getFile(violation)), getLine(violation))}) |\n`;
    }

    outputMarkdown += `\n`;
  }

  console.log(`Writing output to ${outFile}`);
  await writeFile(outFile, outputMarkdown);
}

/**
 * Compare two LintDiffViolation objects for sorting. First sort by level with
 * error being higher than warning. Then sort by file name and line number.
 * @param a
 * @param b
 */
export function compareLintDiffViolations(a: LintDiffViolation, b: LintDiffViolation): number {
  // Sort by level
  if (isFailure(a.level) && isWarning(b.level)) {
    return -1;
  } else if (isWarning(a.level) && isFailure(b.level)) {
    return 1;
  }

  // Sort by file name
  if (getFile(a) !== getFile(b)) {
    return getFile(a)!.localeCompare(getFile(b)!);
  }

  // Sort by line number
  const lineA = getLine(a) || 0;
  const lineB = getLine(b) || 0;

  if (lineA < lineB) {
    return -1;
  } else if (lineA > lineB) {
    return 1;
  }

  return 0;
}

/**
 * Returns relevant parts of a longer file path
 * Input: /specification/recoveryservicessiterecovery/resource-manager/Microsoft.RecoveryServices/stable/2025-01-01/service.json
 * Output: Microsoft.RecoveryServices/stable/2025-01-01/service.json
 * @param path path to a file in the repo
 * @returns
 */
export function getPathSegment(path: string): string {
  return path.split("/").slice(-4).join("/");
}

export function getFileLink(sha: string, path: string, line: number | null = null) {
  // Paths can sometimes contain a preceeding slash if coming from a nomralized
  // filesystem path. In this case, remove it so the link doesn't contain two
  // forward slashes.
  const urlPath = path.startsWith("/") ? path.slice(1) : path;
  if (line === null) {
    return `https://github.com/Azure/azure-rest-api-specs/blob/${sha}/${urlPath}`;
  }

  return `https://github.com/Azure/azure-rest-api-specs/blob/${sha}/${urlPath}#L${line}`;
}

export function getDocUrl(id: string) {
  if (id == "FATAL") {
    return `N/A`;
  }

  return `https://github.com/Azure/azure-openapi-validator/blob/main/docs/${kebabCase(id)}.md`;
}

/**
 * Normalize a path to be relative to a given directory.
 * @param path File path with separators from the current system
 * @param from A directory name to treat as the root (e.g. /specification/)
 */
// TODO: Review use of sep
export function relativizePath(path: string, from: string = `${sep}specification${sep}`): string {
  const indexOfBy = path.lastIndexOf(from);
  if (indexOfBy === -1) {
    return path;
  }

  return path.substring(indexOfBy);
}

export function getFile(lintDiffViolation: LintDiffViolation): string {
  return lintDiffViolation.source?.[0]?.document || "";
}

export function getLine(lintDiffViolation: LintDiffViolation): number | undefined {
  const result = lintDiffViolation.source?.[0]?.position?.line;
  if (typeof result === "number" && Number.isFinite(result)) {
    return result;
  }

  return undefined;
}

export function iconFor(type: string) {
  if (type.toLowerCase().includes("error")) {
    return ":x:";
  } else {
    return ":warning:";
  }
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
    if (!line.includes('"extensionName":"@microsoft.azure/openapi-validator"')) {
      continue;
    }

    // Ignore all lines that are "diagnostic" output from autorest
    if (diagnosticLevelStrings.some((level) => line.includes(level))) {
      continue;
    }

    const result = JSON.parse(line.trim());
    if (result.code == undefined) {
      // Here we are assuming that lack of code denotes fatal error. For example [1].
      // We must set this to some value because if it would stay undefined, the downstream code would blow up in several places.
      result.code = "FATAL";
    }
    violations.push(result as LintDiffViolation);
  }

  return violations;
}

export function isFailure(level: string) {
  return ["error", "fatal"].includes(level.toLowerCase());
}

export function isWarning(level: string) {
  return level.toLowerCase() === "warning";
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
        // TODO: this is a direct copy, see if there is a better way
        basename(beforeViolation.source?.[0]?.document) ==
          basename(afterViolation.source?.[0]?.document) &&
        // TODO: details?
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
