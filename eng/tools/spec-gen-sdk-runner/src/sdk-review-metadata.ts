import { isSafeRelativePosixPath, SdkName } from "@azure-tools/specs-shared/sdk-types";
import { execFile } from "node:child_process";
import path from "node:path";
import { promisify } from "node:util";
import { LogLevel, logMessage } from "./log.ts";
import type { ExecutionReport, SpecGenSdkCmdInput } from "./types.ts";

const execFileAsync = promisify(execFile);

const GIT_MAX_BUFFER_BYTES = 64 * 1024 * 1024;
const EXCLUDED_PACKAGE_DIR_SEGMENTS = new Set(["bin", "obj", "node_modules"]);
const EXCLUDED_PACKAGE_FILE_NAMES = new Set(["log.txt"]);

export type SdkReviewPackageChanges = {
    packageRootPath: string;
    changedFiles: string[];
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
    if (segments.some((segment) => EXCLUDED_PACKAGE_DIR_SEGMENTS.has(segment))) {
        return true;
    }
    return EXCLUDED_PACKAGE_FILE_NAMES.has(segments.at(-1) ?? "");
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

    for (const [packageIndex, pkg] of executionReport.packages.entries()) {
        const packageName = pkg.packageName?.trim();
        if (!packageName || !pkg.packageRootPath) {
            throw new Error(
                `Cannot capture SDK review metadata for package #${packageIndex + 1}: missing packageName or packageRootPath`,
            );
        }
        if (captured.has(packageName)) {
            throw new Error(
                `Cannot capture SDK review metadata: duplicate package '${packageName}'`,
            );
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
        if (
            changedFiles.some((filePath) => !isStrictPackageDescendant(packageRootPath, filePath))
        ) {
            throw new Error(
                `Cannot capture SDK review metadata for '${packageName}': changed file outside packageRootPath '${packageRootPath}'`,
            );
        }

        captured.set(packageName, { packageRootPath, changedFiles });
        logMessage(
            `Captured SDK review metadata for '${packageName}' (${changedFiles.length} changed files)`,
            LogLevel.Info,
        );
    }

    return captured;
}
