import {
  isSafeRelativePosixPath,
  SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE,
  SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE,
  SdkName,
} from "@azure-tools/specs-shared/sdk-types";
import { execFile } from "node:child_process";
import fs from "node:fs";
import path from "node:path";
import { promisify } from "node:util";
import { LogLevel, logMessage } from "./log.ts";
import type { ExecutionReport, SpecGenSdkCmdInput } from "./types.ts";

const execFileAsync = promisify(execFile);

const GIT_MAX_BUFFER_BYTES = 64 * 1024 * 1024;
const EXCLUDED_PACKAGE_DIR_SEGMENTS = new Set([
  ".git",
  ".vs",
  "bin",
  "coverage",
  "node_modules",
  "obj",
  "testresults",
]);
const EXCLUDED_PACKAGE_FILE_NAMES = new Set(["log.txt"]);

export type SdkReviewPackageChanges = {
    packageRootPath: string;
    changedFiles: string[];
  sdkBaseCommitSha: string;
  reviewInputPath: string;
  reviewInputFileCount: number;
  reviewInputBytes: number;
};

/**
 * Normalizes a path to a relative POSIX path inside `repoRootPath` and verifies
 * it stays within `repoRootPath` without traversal segments.
 */
export function normalizePackageRootPath(
    repoRootPath: string,
    rawPackageRootPath: string,
): string | undefined {
    const trimmed = rawPackageRootPath.trim();
    if (!trimmed) {
        return undefined;
    }

    const resolvedRepoRoot = path.resolve(repoRootPath);
    const candidateAbsolute = path.isAbsolute(trimmed)
        ? path.resolve(trimmed)
        : path.resolve(resolvedRepoRoot, trimmed);
    const relativePath = path.relative(resolvedRepoRoot, candidateAbsolute).replaceAll("\\", "/");

    return isSafeRelativePosixPath(relativePath) ? relativePath : undefined;
}

/**
 * Returns true when a repo-relative path inside a generated package directory
 * is a build intermediate or scratch log that should not be reviewed.
 */
export function isExcludedGeneratedPackagePath(
    packageRootPath: string,
    repoRelativePosixPath: string,
): boolean {
    const prefix = `${packageRootPath}/`;
    const relativeToPackage = repoRelativePosixPath.startsWith(prefix)
        ? repoRelativePosixPath.slice(prefix.length)
        : repoRelativePosixPath;
    const segments = relativeToPackage.split("/");
  if (segments.some((segment) => EXCLUDED_PACKAGE_DIR_SEGMENTS.has(segment.toLowerCase()))) {
        return true;
    }
  return EXCLUDED_PACKAGE_FILE_NAMES.has((segments.at(-1) ?? "").toLowerCase());
}

function isStrictPackageDescendant(packageRootPath: string, filePath: string): boolean {
    return filePath.startsWith(`${packageRootPath}/`);
}

async function runGitStdout(repoPath: string, args: string[]): Promise<string> {
    const { stdout } = await execFileAsync("git", args, {
        cwd: repoPath,
        maxBuffer: GIT_MAX_BUFFER_BYTES,
        windowsHide: true,
    });
    return stdout;
}

function parseGitPathList(output: string, packageRootPath: string): string[] {
    return output
        .split("\0")
        .map((entry) => entry.trim().replaceAll("\\", "/"))
        .filter(
            (entry) =>
                entry.length > 0 &&
                isSafeRelativePosixPath(entry) &&
                !isExcludedGeneratedPackagePath(packageRootPath, entry),
        );
}

async function listChangedPackageFiles(
    sdkRepoPath: string,
    packageRootPath: string,
): Promise<string[]> {
    const [trackedOutput, untrackedOutput] = await Promise.all([
        runGitStdout(sdkRepoPath, [
            "-c",
            "core.quotepath=false",
            "diff",
            "--no-renames",
            "--name-only",
            "-z",
            "HEAD",
            "--",
            packageRootPath,
        ]),
        runGitStdout(sdkRepoPath, [
            "ls-files",
            "--others",
            "--exclude-standard",
            "-z",
            "--",
            packageRootPath,
        ]),
    ]);

    return [
        ...new Set([
            ...parseGitPathList(trackedOutput, packageRootPath),
            ...parseGitPathList(untrackedOutput, packageRootPath),
        ]),
    ].sort();
}

function resolveReviewInputPath(
  stagedArtifactsFolder: string,
  apiViewArtifact: string,
  packageName: string,
): { absolutePath: string; relativePath: string } {
  const resolvedStagedFolder = path.resolve(stagedArtifactsFolder);
  const resolvedApiViewArtifact = path.resolve(apiViewArtifact);
  const apiViewRelativePath = path
    .relative(resolvedStagedFolder, resolvedApiViewArtifact)
    .replaceAll("\\", "/");
  if (!isSafeRelativePosixPath(apiViewRelativePath)) {
    throw new Error(
      `APIView artifact '${apiViewArtifact}' is outside stagedArtifactsFolder '${stagedArtifactsFolder}'`,
    );
  }

  if (!/^[A-Za-z0-9._-]+$/.test(packageName)) {
    throw new Error(`Cannot create SDK review input path for package '${packageName}'`);
  }
  const relativePath = path.posix.join(packageName, "review-input");
  if (!isSafeRelativePosixPath(relativePath)) {
    throw new Error(`Unsafe SDK review input path '${relativePath}'`);
  }

  return {
    relativePath,
    absolutePath: path.resolve(resolvedStagedFolder, ...relativePath.split("/")),
  };
}

async function copyPackageSnapshot(
  packageRootAbsolutePath: string,
  packageRootPath: string,
  reviewInputAbsolutePath: string,
): Promise<{ fileCount: number; bytes: number }> {
  const relativeDestination = path.relative(packageRootAbsolutePath, reviewInputAbsolutePath);
  if (
    relativeDestination === "" ||
    (!relativeDestination.startsWith("..") && !path.isAbsolute(relativeDestination))
  ) {
    throw new Error("SDK review input destination must be outside the generated package");
  }

  fs.rmSync(reviewInputAbsolutePath, { recursive: true, force: true });
  let fileCount = 0;
  let bytes = 0;

  const copyDirectory = async (
    sourceDirectory: string,
    relativeDirectory: string,
  ): Promise<void> => {
    const entries = await fs.promises.readdir(sourceDirectory, { withFileTypes: true });
    for (const entry of entries) {
      const relativeFilePath = relativeDirectory
        ? path.posix.join(relativeDirectory, entry.name)
        : entry.name;
      const repoRelativePath = path.posix.join(packageRootPath, relativeFilePath);
      if (isExcludedGeneratedPackagePath(packageRootPath, repoRelativePath)) {
        continue;
      }

      const sourcePath = path.join(sourceDirectory, entry.name);
      if (entry.isSymbolicLink()) {
        throw new Error(`SDK review input does not support symbolic link '${repoRelativePath}'`);
      }
      if (entry.isDirectory()) {
        await copyDirectory(sourcePath, relativeFilePath);
        continue;
      }
      if (!entry.isFile()) {
        continue;
      }

      const fileSize = (await fs.promises.stat(sourcePath)).size;
      fileCount += 1;
      bytes += fileSize;
      if (fileCount > SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE) {
        throw new Error(
          `SDK review input for '${packageRootPath}' exceeds ${SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE} files`,
        );
      }
      if (bytes > SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE) {
        throw new Error(
          `SDK review input for '${packageRootPath}' exceeds ${SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE} bytes`,
        );
      }

      const destinationPath = path.resolve(reviewInputAbsolutePath, ...relativeFilePath.split("/"));
      fs.mkdirSync(path.dirname(destinationPath), { recursive: true });
      await fs.promises.copyFile(sourcePath, destinationPath);
    }
  };

  try {
    await copyDirectory(packageRootAbsolutePath, "");
  } catch (error) {
    fs.rmSync(reviewInputAbsolutePath, { recursive: true, force: true });
    throw error;
  }
  if (fileCount === 0 || bytes === 0) {
    fs.rmSync(reviewInputAbsolutePath, { recursive: true, force: true });
    throw new Error(`SDK review input for '${packageRootPath}' is empty`);
  }
  return { fileCount, bytes };
}

/**
 * Returns true when the runner should add generated changed-file metadata to
 * `.NET` APIView request entries.
 */
export function shouldCaptureSdkReviewMetadata(commandInput: SpecGenSdkCmdInput): boolean {
    return (
        commandInput.runMode === "spec-pull-request" &&
        commandInput.sdkLanguage === SdkName.Net &&
        typeof commandInput.prNumber === "string" &&
        /^[1-9]\d*$/.test(commandInput.prNumber) &&
        /^[0-9a-f]{40}$/i.test(commandInput.specCommitSha)
    );
}

/**
 * Captures package roots and generated changed-file paths before the next SDK
 * checkout reset. APIView/package artifacts remain the source of review content.
 */
export async function captureSdkReviewMetadata(
    commandInput: SpecGenSdkCmdInput,
    executionReport: ExecutionReport,
): Promise<Map<string, SdkReviewPackageChanges>> {
    const captured = new Map<string, SdkReviewPackageChanges>();
    if (!shouldCaptureSdkReviewMetadata(commandInput)) {
        return captured;
    }
  if (!executionReport.stagedArtifactsFolder) {
    throw new Error("Cannot capture SDK review input: missing stagedArtifactsFolder");
  }

  const sdkBaseCommitSha = (
    await runGitStdout(commandInput.localSdkRepoPath, ["rev-parse", "HEAD"])
  ).trim();
  if (!/^[0-9a-f]{40}$/i.test(sdkBaseCommitSha)) {
    throw new Error(`Cannot capture SDK review input: invalid SDK commit '${sdkBaseCommitSha}'`);
  }

    for (const [packageIndex, pkg] of executionReport.packages.entries()) {
        const packageName = pkg.packageName?.trim();
    if (!packageName || !pkg.packageRootPath || !pkg.apiViewArtifact) {
            throw new Error(
        `Cannot capture SDK review input for package #${packageIndex + 1}: missing packageName, packageRootPath, or apiViewArtifact`,
            );
        }
        if (captured.has(packageName)) {
      throw new Error(`Cannot capture SDK review metadata: duplicate package '${packageName}'`);
        }

        const packageRootPath = normalizePackageRootPath(
            commandInput.localSdkRepoPath,
            pkg.packageRootPath,
        );
        if (!packageRootPath) {
            throw new Error(
                `Cannot capture SDK review metadata for '${packageName}': unsafe packageRootPath '${pkg.packageRootPath}'`,
            );
        }

        const changedFiles = await listChangedPackageFiles(
            commandInput.localSdkRepoPath,
            packageRootPath,
        );
    if (changedFiles.some((filePath) => !isStrictPackageDescendant(packageRootPath, filePath))) {
            throw new Error(
                `Cannot capture SDK review metadata for '${packageName}': changed file outside packageRootPath '${packageRootPath}'`,
            );
        }

    const { absolutePath: reviewInputAbsolutePath, relativePath: reviewInputPath } =
      resolveReviewInputPath(
        executionReport.stagedArtifactsFolder,
        pkg.apiViewArtifact,
        packageName,
      );
    const packageRootAbsolutePath = path.resolve(
      commandInput.localSdkRepoPath,
      ...packageRootPath.split("/"),
    );
    const snapshot = await copyPackageSnapshot(
      packageRootAbsolutePath,
      packageRootPath,
      reviewInputAbsolutePath,
    );

    captured.set(packageName, {
      packageRootPath,
      changedFiles,
      sdkBaseCommitSha,
      reviewInputPath,
      reviewInputFileCount: snapshot.fileCount,
      reviewInputBytes: snapshot.bytes,
    });
        logMessage(
      `Captured SDK review input for '${packageName}' (${changedFiles.length} changed files, ${snapshot.fileCount} snapshot files, ${snapshot.bytes} bytes)`,
            LogLevel.Info,
        );
    }

    return captured;
}
