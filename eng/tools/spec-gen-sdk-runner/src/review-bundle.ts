import {
  isSafeRelativePosixPath,
  SDK_REVIEW_BUNDLE_ARTIFACT_NAME,
  SDK_REVIEW_BUNDLE_MAX_CAPTURE_ERROR_LENGTH,
  SDK_REVIEW_BUNDLE_MAX_CAPTURE_ERRORS,
  SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME,
  SDK_REVIEW_BUNDLE_SCHEMA_VERSION,
  SdkName,
  SdkReviewBundleEntrySchema,
  SdkReviewBundleManifestSchema,
  type SdkReviewBundleEntry,
  type SdkReviewBundleManifest,
} from "@azure-tools/specs-shared/sdk-types";
import { execFile } from "node:child_process";
import { createHash } from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { inspect, promisify } from "node:util";
import { LogLevel, logMessage, setVsoVariable } from "./log.ts";
import type { ExecutionReport, SpecGenSdkCmdInput } from "./types.ts";

const execFileAsync = promisify(execFile);

const GIT_MAX_BUFFER_BYTES = 64 * 1024 * 1024;
const EXCLUDED_PACKAGE_DIR_SEGMENTS = new Set(["bin", "obj", "node_modules"]);
const EXCLUDED_PACKAGE_FILE_NAMES = new Set(["log.txt"]);

export type CaptureSpecReviewEntriesOptions = {
  commandInput: SpecGenSdkCmdInput;
  executionReport: ExecutionReport;
  tspConfigPath?: string;
  readmePath?: string;
  existingEntriesCount: number;
};

export type SdkReviewBundleCaptureResult =
  | {
      captureStatus: "complete";
      expectedEntryCount: number;
      entries: SdkReviewBundleEntry[];
    }
  | {
      captureStatus: "failed";
      expectedEntryCount: number;
      captureErrors: string[];
      entries: [];
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

  if (!isSafeRelativePosixPath(relativePath)) {
    return undefined;
  }
  return relativePath;
}

/**
 * Normalizes a relative spec config path (such as `tspconfig.yaml` or `readme.md`)
 * to a safe POSIX relative path if valid.
 */
export function normalizeOptionalSpecPath(rawSpecPath: string | undefined): string | undefined {
  if (!rawSpecPath) {
    return undefined;
  }
  const normalized = rawSpecPath
    .trim()
    .replaceAll("\\", "/")
    .replace(/^(?:\.\/)+/, "")
    .replace(/\/+$/, "");
  return isSafeRelativePosixPath(normalized) ? normalized : undefined;
}

/**
 * Returns true when a repo-relative POSIX path inside a generated package directory
 * is a build intermediate or scratch log that should not be included in the review diff.
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
  if (segments.some((segment) => EXCLUDED_PACKAGE_DIR_SEGMENTS.has(segment))) {
    return true;
  }
  const fileName = segments.at(-1) ?? "";
  return EXCLUDED_PACKAGE_FILE_NAMES.has(fileName);
}

function isStrictPackageDescendant(packageRootPath: string, filePath: string): boolean {
  return filePath.startsWith(`${packageRootPath}/`);
}

function sanitizeSlugSegment(value: string): string {
  const sanitized = value
    .replace(/[^A-Za-z0-9._-]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 80);
  return sanitized || "package";
}

async function runGitStdout(repoPath: string, args: string[]): Promise<string> {
  const { stdout } = await execFileAsync("git", args, {
    cwd: repoPath,
    maxBuffer: GIT_MAX_BUFFER_BYTES,
    windowsHide: true,
  });
  return stdout;
}

async function listUntrackedPackageFiles(
  sdkRepoPath: string,
  packageRootPath: string,
): Promise<string[]> {
  const output = await runGitStdout(sdkRepoPath, [
    "ls-files",
    "--others",
    "--exclude-standard",
    "-z",
    "--",
    packageRootPath,
  ]);
  return output
    .split("\0")
    .map((entry) => entry.trim().replaceAll("\\", "/"))
    .filter(
      (entry) =>
        entry.length > 0 &&
        isSafeRelativePosixPath(entry) &&
        !isExcludedGeneratedPackagePath(packageRootPath, entry),
    )
    .sort();
}

async function listChangedPackageFiles(
  sdkRepoPath: string,
  packageRootPath: string,
): Promise<string[]> {
  const output = await runGitStdout(sdkRepoPath, [
    "-c",
    "core.quotepath=false",
    "diff",
    "--no-renames",
    "--name-only",
    "-z",
    "HEAD",
    "--",
    packageRootPath,
  ]);
  return output
    .split("\0")
    .map((entry) => entry.trim().replaceAll("\\", "/"))
    .filter(
      (entry) =>
        entry.length > 0 &&
        isSafeRelativePosixPath(entry) &&
        !isExcludedGeneratedPackagePath(packageRootPath, entry),
    )
    .sort();
}

/**
 * Returns true when the current runner invocation should capture a `.NET` SDK
 * review bundle (spec-pull-request mode on `azure-sdk-for-net` with valid PR and SHA).
 */
export function shouldCaptureSdkReviewBundle(commandInput: SpecGenSdkCmdInput): boolean {
  return (
    commandInput.runMode === "spec-pull-request" &&
    commandInput.sdkLanguage === SdkName.Net &&
    typeof commandInput.prNumber === "string" &&
    /^[1-9]\d*$/.test(commandInput.prNumber) &&
    /^[0-9a-f]{40}$/i.test(commandInput.specCommitSha)
  );
}

/**
 * Returns the relative and absolute output folder paths for the review bundle artifact.
 */
export function getSdkReviewBundleOutputPaths(workingFolder: string): {
  relativeFolderPath: string;
  absoluteFolderPath: string;
  manifestFilePath: string;
} {
  const relativeFolderPath = path.join("out", SDK_REVIEW_BUNDLE_ARTIFACT_NAME);
  const absoluteFolderPath = path.join(workingFolder, relativeFolderPath);
  const manifestFilePath = path.join(absoluteFolderPath, SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME);
  return { relativeFolderPath, absoluteFolderPath, manifestFilePath };
}

/**
 * Captures generated tracked and untracked changes for each package in `executionReport`
 * before the next `resetGitRepo(localSdkRepoPath)` call wipes the SDK checkout.
 */
export async function captureSdkReviewBundleEntriesForSpec(
  options: CaptureSpecReviewEntriesOptions,
): Promise<SdkReviewBundleEntry[]> {
  const { commandInput, executionReport, tspConfigPath, readmePath, existingEntriesCount } =
    options;
  if (!shouldCaptureSdkReviewBundle(commandInput) || executionReport.packages.length === 0) {
    return [];
  }

  const { absoluteFolderPath } = getSdkReviewBundleOutputPaths(commandInput.workingFolder);
  fs.mkdirSync(absoluteFolderPath, { recursive: true });

  const sdkBaseCommitSha = (
    await runGitStdout(commandInput.localSdkRepoPath, ["rev-parse", "HEAD"])
  ).trim();
  const normalizedTspConfigPath = normalizeOptionalSpecPath(tspConfigPath);
  const normalizedReadmePath = normalizeOptionalSpecPath(readmePath);

  const capturedEntries: SdkReviewBundleEntry[] = [];
  for (const [pkgOffset, pkg] of executionReport.packages.entries()) {
    const packageName = pkg.packageName?.trim();
    if (!packageName || !pkg.packageRootPath) {
      throw new Error(
        `Cannot capture SDK review bundle package #${pkgOffset + 1}: missing packageName or packageRootPath`,
      );
    }

    const packageRootPath = normalizePackageRootPath(
      commandInput.localSdkRepoPath,
      pkg.packageRootPath,
    );
    if (!packageRootPath) {
      throw new Error(
        `Cannot capture SDK review bundle package '${packageName}': unsafe packageRootPath '${pkg.packageRootPath}'`,
      );
    }

    const untrackedFiles = await listUntrackedPackageFiles(
      commandInput.localSdkRepoPath,
      packageRootPath,
    );
    if (untrackedFiles.length > 0) {
      await runGitStdout(commandInput.localSdkRepoPath, ["add", "-N", "--", ...untrackedFiles]);
    }

    const changedFiles = await listChangedPackageFiles(
      commandInput.localSdkRepoPath,
      packageRootPath,
    );
    if (
      new Set(changedFiles).size !== changedFiles.length ||
      changedFiles.some((filePath) => !isStrictPackageDescendant(packageRootPath, filePath))
    ) {
      throw new Error(
        `Cannot capture SDK review bundle package '${packageName}': changed files are duplicated or outside packageRootPath '${packageRootPath}'`,
      );
    }
    const patchContent =
      changedFiles.length > 0
        ? await runGitStdout(commandInput.localSdkRepoPath, [
            "-c",
            "core.quotepath=false",
            "diff",
            "--no-renames",
            "--no-ext-diff",
            "--binary",
            "--full-index",
            "HEAD",
            "--",
            ...changedFiles,
          ])
        : "";

    const sequenceNumber = String(existingEntriesCount + capturedEntries.length + 1).padStart(
      2,
      "0",
    );
    const entryId = `${sequenceNumber}-${sanitizeSlugSegment(packageName)}`;
    const patchFile = `${entryId}.patch`;
    const patchFilePath = path.join(absoluteFolderPath, patchFile);
    const patchBuffer = Buffer.from(patchContent, "utf8");
    fs.writeFileSync(patchFilePath, patchBuffer);

    const patchSha256 = createHash("sha256").update(patchBuffer).digest("hex");
    const entry: SdkReviewBundleEntry = {
      entryId,
      ...(normalizedTspConfigPath ? { tspConfigPath: normalizedTspConfigPath } : {}),
      ...(normalizedReadmePath ? { readmePath: normalizedReadmePath } : {}),
      ...(pkg.serviceName ? { serviceName: pkg.serviceName } : {}),
      packageName,
      packageRootPath,
      sdkBaseCommitSha,
      executionResult: pkg.result ?? executionReport.executionResult,
      ...(typeof pkg.shouldLabelBreakingChange === "boolean"
        ? { hasBreakingChange: pkg.shouldLabelBreakingChange }
        : typeof pkg.hasBreakingChange === "boolean"
          ? { hasBreakingChange: pkg.hasBreakingChange }
          : {}),
      patchFile,
      patchSha256,
      patchBytes: patchBuffer.byteLength,
      changedFileCount: changedFiles.length,
      changedFiles,
    };

    SdkReviewBundleEntrySchema.parse(entry);
    capturedEntries.push(entry);
    logMessage(
      `Captured SDK review bundle entry '${entryId}' (${changedFiles.length} changed files, ${patchBuffer.byteLength} bytes, package #${pkgOffset + 1})`,
      LogLevel.Info,
    );
  }

  return capturedEntries;
}

export function discardSdkReviewBundleOutput(workingFolder: string): void {
  const { absoluteFolderPath } = getSdkReviewBundleOutputPaths(workingFolder);
  try {
    fs.rmSync(absoluteFolderPath, { recursive: true, force: true });
  } catch (error) {
    logMessage(
      `Runner: failed discarding partial SDK review bundle at ${absoluteFolderPath}: ${inspect(error)}`,
      LogLevel.Warn,
    );
  }
}

export function createSdkReviewCaptureErrorSummary(error: unknown): string {
  const summary =
    (error instanceof Error ? error.message : inspect(error)).trim() ||
    "Unknown SDK review bundle capture error";
  return summary.replace(/[\r\n\t]+/g, " ").slice(0, SDK_REVIEW_BUNDLE_MAX_CAPTURE_ERROR_LENGTH);
}

/**
 * Writes the validated `sdk-review-bundle.json` manifest and emits the Azure Pipelines
 * variables (`SdkReviewBundlePath` and `SdkReviewBundleName`) used by `publish-artifact.yml`.
 */
export function writeSdkReviewBundleManifest(
  commandInput: SpecGenSdkCmdInput,
  captureResult: SdkReviewBundleCaptureResult,
  buildId: string | undefined = process.env.BUILD_BUILDID,
): SdkReviewBundleManifest | undefined {
  if (
    !shouldCaptureSdkReviewBundle(commandInput) ||
    (captureResult.captureStatus === "complete" && captureResult.entries.length === 0)
  ) {
    return undefined;
  }

  const { relativeFolderPath, absoluteFolderPath, manifestFilePath } =
    getSdkReviewBundleOutputPaths(commandInput.workingFolder);
  fs.mkdirSync(absoluteFolderPath, { recursive: true });

  const trimmedBuildId = buildId?.trim();
  try {
    const manifest: SdkReviewBundleManifest = SdkReviewBundleManifestSchema.parse({
      schemaVersion: SDK_REVIEW_BUNDLE_SCHEMA_VERSION,
      ...(trimmedBuildId && /^[1-9]\d*$/.test(trimmedBuildId) ? { buildId: trimmedBuildId } : {}),
      specPrNumber: commandInput.prNumber!,
      specHeadSha: commandInput.specCommitSha,
      specRepoUrl: commandInput.specRepoHttpsUrl,
      sdkLanguage: commandInput.sdkLanguage,
      sdkRepoName: commandInput.sdkRepoName,
      ...captureResult,
      ...(captureResult.captureStatus === "failed"
        ? {
            captureErrors: captureResult.captureErrors.slice(
              0,
              SDK_REVIEW_BUNDLE_MAX_CAPTURE_ERRORS,
            ),
          }
        : {}),
    });
    fs.writeFileSync(manifestFilePath, JSON.stringify(manifest, undefined, 2));
    setVsoVariable("SdkReviewBundlePath", relativeFolderPath);
    setVsoVariable("SdkReviewBundleName", SDK_REVIEW_BUNDLE_ARTIFACT_NAME);
    logMessage(`SDK review bundle manifest written to ${manifestFilePath}`, LogLevel.Info);
    return manifest;
  } catch (error) {
    logMessage(
      `Runner: failed writing SDK review bundle manifest at ${manifestFilePath}: ${inspect(error)}`,
      LogLevel.Warn,
    );
    return undefined;
  }
}
