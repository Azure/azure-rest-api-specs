import { randomUUID } from "node:crypto";
import fs from "node:fs/promises";
import path from "node:path";
import {
  isSafeRelativePosixPath,
  SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME,
  SdkReviewBundleManifestSchema,
  type SdkReviewBundleEntry,
} from "../../shared/src/sdk-types.ts";
import { execFile } from "../../shared/src/exec.ts";
import type { Core } from "./github.ts";

export type PatchApplicabilityCommand = (
  file: string,
  args: string[],
  options: { cwd?: string },
) => Promise<unknown>;

export type PatchApplicabilityGroup = {
  sdkBaseCommitSha: string;
  packageRoots: string[];
  entries: SdkReviewBundleEntry[];
};

const validateSdkRepositoryName = (repositoryName: string): void => {
  if (
    !/^[A-Za-z0-9][A-Za-z0-9._-]{0,99}$/.test(repositoryName) ||
    repositoryName.endsWith(".git")
  ) {
    throw new Error(`Unsafe SDK repository name '${repositoryName}'`);
  }
};

const validatePackageRoot = (packageRoot: string): void => {
  if (!isSafeRelativePosixPath(packageRoot) || !packageRoot.startsWith("sdk/")) {
    throw new Error(`Unsafe SDK package root '${packageRoot}'`);
  }
};

export const groupPatchEntriesByBaseCommit = (
  entries: SdkReviewBundleEntry[],
): PatchApplicabilityGroup[] => {
  const groups = new Map<string, PatchApplicabilityGroup>();
  for (const entry of entries) {
    validatePackageRoot(entry.packageRootPath);
    if (!/^[0-9a-f]{40}$/i.test(entry.sdkBaseCommitSha)) {
      throw new Error(`Unsafe SDK base commit '${entry.sdkBaseCommitSha}'`);
    }
    if (
      !isSafeRelativePosixPath(entry.patchFile) ||
      entry.patchFile.includes("/") ||
      !entry.patchFile.endsWith(".patch")
    ) {
      throw new Error(`Unsafe patch file '${entry.patchFile}'`);
    }
    const group = groups.get(entry.sdkBaseCommitSha) ?? {
      sdkBaseCommitSha: entry.sdkBaseCommitSha,
      packageRoots: [],
      entries: [],
    };
    if (!group.packageRoots.includes(entry.packageRootPath)) {
      group.packageRoots.push(entry.packageRootPath);
    }
    group.entries.push(entry);
    groups.set(entry.sdkBaseCommitSha, group);
  }
  return [...groups.values()];
};

const runGit = async (
  runCommand: PatchApplicabilityCommand,
  args: string[],
  cwd?: string,
): Promise<void> => {
  await runCommand("git", args, cwd ? { cwd } : {});
};

export async function validateSdkReviewPatchApplicability(params: {
  sdkRepoName: string;
  entries: SdkReviewBundleEntry[];
  bundleDirectory: string;
  workingRoot?: string;
  runCommand?: PatchApplicabilityCommand;
  core?: Pick<Core, "info">;
}): Promise<void> {
  const {
    sdkRepoName,
    entries,
    bundleDirectory,
    workingRoot = path.join(process.cwd(), "out", "sdk-review-patch-validation"),
    runCommand = execFile,
    core,
  } = params;
  validateSdkRepositoryName(sdkRepoName);
  const groups = groupPatchEntriesByBaseCommit(entries);
  const validationDirectory = path.join(workingRoot, `validation-${randomUUID()}`);
  await fs.mkdir(validationDirectory, { recursive: true });

  try {
    for (const [index, group] of groups.entries()) {
      const cloneDirectory = path.join(validationDirectory, `base-${index + 1}`);
      const combinedPatchPath = path.join(validationDirectory, `base-${index + 1}.patch`);
      const patchParts: string[] = [];
      for (const entry of group.entries) {
        const patchPath = path.resolve(bundleDirectory, entry.patchFile);
        const relativePatchPath = path.relative(path.resolve(bundleDirectory), patchPath);
        if (
          !relativePatchPath ||
          relativePatchPath.startsWith("..") ||
          path.isAbsolute(relativePatchPath)
        ) {
          throw new Error(`Unsafe patch file '${entry.patchFile}'`);
        }
        patchParts.push(await fs.readFile(patchPath, "utf8"));
      }
      const combinedPatch = patchParts.join("\n");
      if (combinedPatch.length === 0) {
        core?.info(
          `Skipping applicability check for ${sdkRepoName}@${group.sdkBaseCommitSha}; all patches are empty`,
        );
        continue;
      }
      await fs.writeFile(combinedPatchPath, combinedPatch, "utf8");

      core?.info(
        `Checking ${group.entries.length} patch(es) against ${sdkRepoName}@${group.sdkBaseCommitSha}`,
      );
      await runGit(runCommand, ["init", cloneDirectory]);
      await runGit(
        runCommand,
        ["remote", "add", "origin", `https://github.com/Azure/${sdkRepoName}.git`],
        cloneDirectory,
      );
      await runGit(
        runCommand,
        ["fetch", "--depth=1", "--filter=blob:none", "origin", group.sdkBaseCommitSha],
        cloneDirectory,
      );
      await runGit(runCommand, ["sparse-checkout", "init", "--cone"], cloneDirectory);
      await runGit(
        runCommand,
        ["sparse-checkout", "set", "--", ...group.packageRoots],
        cloneDirectory,
      );
      await runGit(runCommand, ["checkout", "--detach", "FETCH_HEAD"], cloneDirectory);
      await runGit(runCommand, ["apply", "--check", "--binary", combinedPatchPath], cloneDirectory);
    }
  } finally {
    await fs.rm(validationDirectory, { recursive: true, force: true });
  }
}

export default async function runSdkReviewPatchApplicabilityValidation(params: {
  core: Core;
  bundleDirectory: string;
}): Promise<void> {
  const manifestPath = path.join(params.bundleDirectory, SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME);
  const manifest = SdkReviewBundleManifestSchema.parse(
    JSON.parse(await fs.readFile(manifestPath, "utf8")),
  );
  if (manifest.captureStatus !== "complete") {
    throw new Error("Cannot validate patch applicability for an incomplete review bundle");
  }
  await validateSdkReviewPatchApplicability({
    sdkRepoName: manifest.sdkRepoName,
    entries: manifest.entries,
    bundleDirectory: params.bundleDirectory,
    core: params.core,
  });
}
