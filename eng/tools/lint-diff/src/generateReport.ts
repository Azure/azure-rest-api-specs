import { writeFile } from "node:fs/promises";
import { kebabCase } from "change-case";
import { getRelatedArmRpcFromDoc } from "./markdown-utils.js";
import { getPathToDependency, getDependencyVersion, relativizePath } from "./util.js";
import { getViolations } from "./correlateResults.js";
import { isFailure, isWarning } from "./util.js";
import {
  AutorestRunResult,
  AutoRestMessage,
  BeforeAfter,
  LintDiffViolation,
} from "./lintdiff-types.js";

const LIMIT_50_MESSAGE = "Only 50 items are listed, please refer to log for more details.";

export async function generateLintDiffReport(
  runCorrelations: Map<string, BeforeAfter>,
  affectedSwaggers: Set<string>,
  outFile: string,
  baseBranch: string,
  compareSha: string,
): Promise<boolean> {
  let pass = true;
  let outputMarkdown = "";

  // See unifiedPipelineHelper.ts:386
  // Compared specs (link to npm package: @microsoft.azure/openapi-validator/v/<version>)
  const dependencyVersion = await getDependencyVersion(
    await getPathToDependency("@microsoft.azure/openapi-validator"),
  );
  outputMarkdown += `| Compared specs ([v${dependencyVersion}](https://www.npmjs.com/package/@microsoft.azure/openapi-validator/v/${dependencyVersion})) | new version | base version |\n`;
  outputMarkdown += `| --- | --- | --- |\n`;

  // Compared Specs | New Version | Base Version
  // <tag name> | link: readme.md#tag-<tag-name> | link: readme.md#tag-<tag-name>
  // ... | ... | ...
  for (const [_, { before, after }] of runCorrelations.entries()) {
    const afterName = getName(after);
    const beforeName = before ? getName(before) : "default";
    const afterPath = getPath(after);
    const beforePath = before ? getPath(before) : "";

    outputMarkdown += `| ${afterName} | [${afterName}](${getFileLink(compareSha, afterPath)}) | [${beforeName}](${getFileLink(baseBranch, beforePath)}) |\n`;
  }

  outputMarkdown += `\n\n`;

  const [newViolations, existingViolations] = getViolations(runCorrelations, affectedSwaggers);

  console.log("Populating armRpcs for new violations");
  for (const newItem of newViolations) {
    // TODO: Potential performance issue, make parallel
    newItem.armRpcs = await getRelatedArmRpcFromDoc(newItem.code);
  }

  newViolations.sort(compareLintDiffViolations);
  existingViolations.sort(compareLintDiffViolations);

  if (newViolations.some((v) => isFailure(v.level))) {
    // New violations with level error or fatal fail the build. If all new
    // violations are warnings, the build passes.
    pass = false;
  }

  if (newViolations.length > 0) {
    outputMarkdown += "**[must fix]The following errors/warnings are intorduced by current PR:**\n";
    if (newViolations.length > 50) {
      outputMarkdown += `${LIMIT_50_MESSAGE}\n`;
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
      outputMarkdown += `${LIMIT_50_MESSAGE}\n`;
    }
    outputMarkdown += "\n";
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

  return pass;
}

export async function generateAutoRestErrorReport(
  autoRestErrors: { result: AutorestRunResult; errors: AutoRestMessage[] }[],
  outFile: string,
) {
  let outputMarkdown = "";

  console.error("LintDiff detected AutoRest errors");
  outputMarkdown += "**AutoRest errors:**\n\n";
  for (const { result, errors } of autoRestErrors) {
    console.log(`AutoRest errors for ${result.readme} (${result.tag})`);

    outputMarkdown += "Readme: " + result.readme + "\n";
    outputMarkdown += "Tag: " + result.tag + "\n";
    outputMarkdown += "Errors:\n";
    outputMarkdown += "| Level | Message |\n";
    outputMarkdown += "| ----- | ------- |\n";
    for (const error of errors) {
      const { level, message } = error;
      console.log(`  ${level}: ${message}`);

      outputMarkdown += `| ${iconFor(level)} ${level} | ${message.replace(/\n/g, "<br />")} |\n`;
    }

    outputMarkdown += "\n\n";
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

  const fileA = getFile(a) || "";
  const fileB = getFile(b) || "";

  // Sort by file name
  if (fileA !== fileB) {
    return fileA.localeCompare(fileB);
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

export function getName(result: AutorestRunResult) {
  return result.tag ? result.tag : "default";
}

export function getPath(result: AutorestRunResult) {
  const { readme, tag } = result;
  return tag ? `${readme}#tag-${tag}` : readme;
}
