import { kebabCase } from "change-case";
import { writeFile } from "node:fs/promises";
import { relative } from "node:path";
import { getViolations } from "./correlateResults.js";
import {
  AutoRestMessage,
  AutorestRunResult,
  BeforeAfter,
  LintDiffViolation,
} from "./lintdiff-types.js";
import { getRelatedArmRpcFromDoc } from "./markdown-utils.js";
import {
  getDependencyVersion,
  getPathToDependency,
  isFailure,
  isWarning,
  relativizePath,
} from "./util.js";

const LIMIT_50_MESSAGE = "Only 50 items are listed, please refer to log for more details.";

export async function generateLintDiffReport(
  runCorrelations: Map<string, BeforeAfter>,
  affectedSwaggers: Set<string>,
  outFile: string,
  baseBranch: string,
  compareSha: string,
  githubRepoPath: string,
): Promise<boolean> {
  console.log("Generating LintDiff report...");

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
  for (const [, { before, after }] of runCorrelations.entries()) {
    const afterName = getName(after);
    const beforeName = before ? getName(before) : "default";
    const afterPath = getPath(after);
    const beforePath = before ? getPath(before) : "";

    outputMarkdown += `| ${afterName} | [${afterName}](${getFileLink(githubRepoPath, compareSha, afterPath)}) | [${beforeName}](${getFileLink(githubRepoPath, baseBranch, beforePath)}) ${getAutoRestFailedMessage(before)}|\n`;
  }

  outputMarkdown += `\n\n`;

  for (const [, { before }] of runCorrelations.entries()) {
    if (before && before.error) {
      outputMarkdown += `> [!WARNING]\n`;
      outputMarkdown += `> Autorest failed checking before state of ${relative(before.rootPath, before.readme.path)} ${before.tag}\n\n`;
    }
  }

  const [newViolations, existingViolations] = getViolations(runCorrelations, affectedSwaggers);

  for (const newItem of newViolations) {
    // TODO: Potential performance issue, make parallel
    newItem.armRpcs = await getRelatedArmRpcFromDoc(newItem.code);
  }

  newViolations.sort(compareLintDiffViolations);
  existingViolations.sort(compareLintDiffViolations);

  console.log(`New violations: ${newViolations.length}`);
  if (newViolations.length > 0) {
    outputMarkdown += "**[must fix]The following errors/warnings are intorduced by current PR:**\n";
    if (newViolations.length > 50) {
      outputMarkdown += `${LIMIT_50_MESSAGE}\n`;
    }
    outputMarkdown += "\n";

    outputMarkdown += "| Rule | Message | Related RPC [For API reviewers] |\n";
    outputMarkdown += "| ---- | ------- | ------------------------------- |\n";

    for (const violation of newViolations.slice(0, 50)) {
      outputMarkdown += getNewViolationReportRow(violation, githubRepoPath, compareSha);
    }

    if (newViolations.some((v) => isFailure(v.level))) {
      console.log("\t❌ At least one violation has error or fatal level. LintDiff will fail.");
      // New violations with level error or fatal fail the build. If all new
      // violations are warnings, the build passes.
      pass = false;
    } else {
      console.log("\t✅ No new violations with error or fatal level. LintDiff will pass.");
    }

    LogViolations("New violations list", newViolations);

    outputMarkdown += "\n";
  }

  console.log(`Existing violations: ${existingViolations.length}`);
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
      outputMarkdown += `| ${iconFor(level)} [${code}](${getDocUrl(code)}) | ${message}<br />Location: [${getPathSegment(relativizePath(getFile(violation)))}#L${getLine(violation)}](${getFileLink(githubRepoPath, compareSha, relativizePath(getFile(violation)), getLine(violation))}) |\n`;
    }

    LogViolations("Existing violations list", existingViolations);

    outputMarkdown += `\n`;
  }

  console.log(`Writing output to ${outFile}`);
  await writeFile(outFile, outputMarkdown);

  return pass;
}

function LogViolations(heading: string, violations: LintDiffViolation[]) {
  console.log(`::group::${heading}`);
  for (const violation of violations) {
    const source = getFile(violation);
    const line = getLine(violation);
    console.log(`Violation: ${source}${line ? `:${line}` : ""}`);
    console.log(`  Level: ${violation.level}`);
    console.log(`  Code: ${violation.code}`);
    console.log(`  Message: ${violation.message}`);
  }
  console.log("::endgroup::");
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

    const readmePath = relative(result.rootPath, result.readme.path);

    outputMarkdown += `Readme: \`${readmePath}\`\n`;
    outputMarkdown += `Tag: \`${result.tag}\`\n`;
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
  } else if (a.level === "fatal" && b.level !== "fatal") {
    return -1;
  } else if (a.level !== "fatal" && b.level === "fatal") {
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

export function getFileLink(
  repoPath: string,
  sha: string,
  path: string,
  line: number | null = null,
) {
  // Paths can sometimes contain a preceeding slash if coming from a nomralized
  // filesystem path. In this case, remove it so the link doesn't contain two
  // forward slashes.
  const urlPath = path.startsWith("/") ? path.slice(1) : path;
  if (line === null) {
    return `https://github.com/${repoPath}/blob/${sha}/${urlPath}`;
  }

  return `https://github.com/${repoPath}/blob/${sha}/${urlPath}#L${line}`;
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

function getNewViolationReportRow(
  violation: LintDiffViolation,
  githubRepoPath: string,
  compareSha: string,
): string {
  const { level, code, message } = violation;
  if (level.toLowerCase() == "fatal") {
    // Fatal errors have fewer details and don't need to be formatted
    return `| ${iconFor(level)} ${code} | ${message} | ${violation.armRpcs?.join(", ")} |\n`;
  }

  return `| ${iconFor(level)} [${code}](${getDocUrl(code)}) | ${message}<br />Location: [${getPathSegment(relativizePath(getFile(violation)))}#L${getLine(violation)}](${getFileLink(githubRepoPath, compareSha, relativizePath(getFile(violation)), getLine(violation))}) | ${violation.armRpcs?.join(", ")} |\n`;
}

export function iconFor(type: string) {
  if (type.toLowerCase().includes("error") || type.toLowerCase() === "fatal") {
    return ":x:";
  } else {
    return ":warning:";
  }
}

export function getName(result: AutorestRunResult) {
  return result.tag ? result.tag : "default";
}

export function getPath(result: AutorestRunResult) {
  const { rootPath, readme, tag } = result;
  const readmePathRelative = relative(rootPath, readme.path);
  return tag ? `${readmePathRelative}#tag-${tag}` : readmePathRelative;
}

export function getAutoRestFailedMessage(result: AutorestRunResult | null): string {
  if (result?.error) {
    return "Autorest Failed";
  }
  return "";
}
