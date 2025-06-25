import { existsSync, readFileSync } from "node:fs";
import { FilePosition } from "../types/message.js";
import { logMessage } from "../log.js";

export function blobHref(file: unknown): string {
  // GitHub Actions scenario
  if (process.env.GITHUB_ACTIONS) {
    const repoName = process.env.GITHUB_HEAD_REPOSITORY || process.env.GITHUB_REPOSITORY;
    const sha = process.env.GITHUB_SHA || process.env.GITHUB_EVENT_PULL_REQUEST_HEAD_SHA;
    return `https://github.com/${repoName}/blob/${sha}/${file}`;
  }

  // Local development scenario
  return `${file}`;
}

/**
 * Get the Github url of targeted swagger file.
 * @param file Swagger file starts with "specification"
 */
export function targetHref(file: string) {
  return file
    ? `https://github.com/${process.env.GITHUB_REPOSITORY}/blob/${getTargetBranch()}/${file}`
    : "";
}

export function branchHref(file: string, branch: string = "main") {
  return file ? `https://github.com/${process.env.GITHUB_REPOSITORY}/blob/${branch}/${file}` : "";
}

/**
 * Gets the name of the target branch to which the PR is sent.
 * If the environment variable is undefined then the method returns 'main' as the default value.
 * @returns {string} branchName The target branch name.
 */
export function getTargetBranch(): string {
  // For GitHub Actions, use GITHUB_BASE_REF for pull requests, fallback to GITHUB_REF_NAME for direct pushes
  const githubBaseRef = process.env["GITHUB_BASE_REF"]; // Target branch for PR
  const githubRefName = process.env["GITHUB_REF_NAME"]; // Current branch name
  logMessage(
    `@@@@@ process.env['GITHUB_BASE_REF'] - ${githubBaseRef}, process.env['GITHUB_REF_NAME'] - ${githubRefName}`,
  );

  // For pull requests, use GITHUB_BASE_REF (target branch)
  // For direct pushes, use GITHUB_REF_NAME (current branch) or fallback to "main"
  let result = githubBaseRef || githubRefName || "main";
  result = result.trim();
  logMessage(`>>>>> The target branch is: "${result}".`);
  return result;
}

/**
 * For breaking change. Trim file path pattern to github style.
 * E.g. Input: specification/redis/resource-manager/Microsoft.Cache/preview/2019-07-01/redis.json:191:5
 *      Output: specification/redis/resource-manager/Microsoft.Cache/preview/2019-07-01/redis.json#L191:5
 * @param filePath
 *
 */
export function getGithubStyleFilePath(filePath: string, filePos?: FilePosition): string {
  if (filePos) {
    return `${filePath}#L${filePos.line}:${filePos.column}`;
  }
  const regex = /(:)/;
  return filePath.replace(regex, "#L");
}

export function getRelativeSwaggerPathToRepo(
  filePath: string,
  specDirPatterns: string[] = ["specification"],
): string {
  const pattern = specDirPatterns.find((f) => filePath.indexOf(f) !== -1);
  if (!pattern) {
    return filePath.substring(process.env.BUILD_SOURCEDIRECTORY?.length || 1 - 1);
  }
  const position = filePath.search(pattern);
  return filePath.substring(position, filePath.length);
}

export function sourceBranchHref(file: string, filePos?: FilePosition): string {
  return blobHref(getGithubStyleFilePath(getRelativeSwaggerPathToRepo(file), filePos));
}

export function targetBranchHref(file: string, filePos?: FilePosition): string {
  return targetHref(getGithubStyleFilePath(getRelativeSwaggerPathToRepo(file), filePos));
}

export function specificBranchHref(
  file: string,
  branchName: string,
  filePos?: FilePosition,
): string {
  return branchHref(
    getGithubStyleFilePath(getRelativeSwaggerPathToRepo(file), filePos),
    branchName,
  );
}

export function getVersionFromInputFile(filePath: string, withPreview = false): string | undefined {
  const apiVersionRegex = /^\d{4}-\d{2}-\d{2}(|-preview|-privatepreview|-alpha|-beta|-rc)$/;
  const segments = filePath.split("/");
  if (filePath.indexOf("data-plane") !== -1) {
    if (segments && segments.length > 1) {
      for (const s of segments.entries()) {
        if (["stable", "preview"].some((v) => v === s[1])) {
          const version = segments[s[0] + 1];
          if (version) {
            return apiVersionRegex.test(version) && !withPreview
              ? version.substring(0, 10)
              : version;
          }
        }
      }
    }
  } else {
    if (segments && segments.length > 1) {
      for (const s of segments) {
        if (apiVersionRegex.test(s)) {
          return withPreview ? s : s.substring(0, 10);
        }
      }
    }
  }
  if (existsSync(filePath)) {
    return JSON.parse(readFileSync(filePath).toString())?.info?.version;
  }
  return undefined;
}

export function getArgumentValue(args: string[], flag: string, defaultValue: string): string {
  const index = args.indexOf(flag);
  return index !== -1 && index + 1 < args.length && args[index + 1]
    ? args[index + 1]
    : defaultValue;
}

/**
 * Truncates the input message to a specified maximum size.
 * @param msg The message to be truncated.
 * @param size The maximum length of the returned string. Defaults to 1024.
 * @returns The truncated message, or an empty string if msg is undefined.
 */
export function cutoffMsg(msg: string | undefined, size: number = 1024): string {
  if (!msg || msg.length <= size) {
    return msg ? msg : "";
  }
  return msg.substring(0, size);
}

/**
 * Post-processes the message of an error coming from OAD.
 * Notably, the kind of errors that need post-processing is when OAD
 * throws a runtime error because it has invoked AutoRest, it threw,
 * and OAD has re-thrown it.
 * We want to make such errors more readable, which we do here.
 * Issue capturing this work and providing more context:
 * https://github.com/Azure/azure-sdk-tools/issues/6998
 */
export function processOadRuntimeErrorMessage(
  message: string,
  stackTraceMaxLength: number,
): string {
  let outputMsg: string = "";

  // Example "message" string, truncated with cutoffMsg():
  //
  //   Command failed: node "/mnt/vss/_work/_tasks/AzureApiValidation_5654d05d-82c1-48da-ad8f-161b817f6d41/0.0.59/common/temp/node_modules/.pnpm/https://github.com/Azure+oad@0.10.4/node_modules/autorest/dist/app.js" --v2 --input-file=specification/servicebus/resource-manager/Microsoft.ServiceBus/preview/2023-01-01-preview/namespace-preview.json --output-artifact=swagger-document.json --output-artifact=swagger-document.map --output-file=new --output-folder=/tmp\nERROR: Schema violation: Data does not match any schemas from 'oneOf'\n - file:///mnt/vss/_work/1/azure-rest-api-specs/specification/servicebus/resource-manager/Microsoft.ServiceBus/preview/2023-01-01-preview/namespace-preview.json:347:10 ($.paths["/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.ServiceBus/namespaces/namespaceName/failover"].post["x-ms-examples"].NamespaceFailOver)\nFATAL: swagger-document/individual/schema-validator - FAILED\nFATAL: Error: [OperationAbortedException] Error occurred. Exiting.\nProcess() cancelled due to e
  //
  const oadAutorestInvocationRuntimeError =
    message.startsWith("Command failed: node") && message.includes("autorest/dist/app.js");

  if (oadAutorestInvocationRuntimeError) {
    let lines: string[] = message.split(/[\r\n]+/);

    const introLine: string =
      `Breaking change detector (OAD) invoked AutoRest. AutoRest threw a runtime error. ` +
      `First ${stackTraceMaxLength} lines of stack trace follow, indexed. ` +
      `First line should contain AutoRest command line invocation details. ` +
      `Remaining lines should contain the main message reported by AutoRest.`;

    const stackTraceLines: string[] = lines
      .filter((line) => line.length > 0)
      .slice(0, Math.min(stackTraceMaxLength, lines.length))
      .map((line, i) => `${i + 1}: ${line}`);

    outputMsg = [introLine, "===================="]
      .concat(stackTraceLines)
      // We join with '<br/>' as this will display correctly as a line break inside
      // a cell of a table generated in given GitHub check description.
      // This '<br/>' will be interpreted downstream by
      // 'msgInterfaceUtils.ts / commonHelper.renderExtra',
      // as called by the 'checker.handlebars' template.
      .join("<br/>");
  } else {
    outputMsg = cutoffMsg(message) || "";
  }
  return outputMsg;
}

/**
 * Check if a spec path is a preview version
 * @param specPath The specification file path to check.
 * @returns {boolean} True if the spec path is a preview version, false otherwise.
 */
export function specIsPreview(specPath: string): boolean {
  // Example input value: specification/maps/data-plane/Creator/preview/2022-09-01-preview/wayfind.json
  return specPath.includes("/preview/") && !specPath.includes("/stable/");
}
