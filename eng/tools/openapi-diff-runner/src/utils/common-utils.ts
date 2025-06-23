import { existsSync, readFileSync } from "node:fs";
import { FilePosition } from "../types/message.js";

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
  console.log(
    `@@@@@ process.env['GITHUB_BASE_REF'] - ${githubBaseRef}, process.env['GITHUB_REF_NAME'] - ${githubRefName}`,
  );

  // For pull requests, use GITHUB_BASE_REF (target branch)
  // For direct pushes, use GITHUB_REF_NAME (current branch) or fallback to "main"
  let result = githubBaseRef || githubRefName || "main";
  result = result.trim();
  console.log(`>>>>> The target branch is: "${result}".`);
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
  return index !== -1 && args[index + 1] ? args[index + 1] : defaultValue;
}

export function cutoffMsg(msg: string | undefined, size: number = 1024): string {
  if (!msg || msg.length <= size) {
    return msg ? msg : "";
  }
  return msg.substring(0, size);
}
