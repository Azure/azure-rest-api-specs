import {
  SDK_REVIEW_BUNDLE_ARTIFACT_NAME,
  SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME,
  SdkName,
  SdkReviewBundleManifestSchema,
} from "@azure-tools/specs-shared/sdk-types";
import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { afterEach, beforeEach, describe, expect, test, vi } from "vitest";
import * as log from "../src/log.ts";
import {
  captureSdkReviewBundleEntriesForSpec,
  isExcludedGeneratedPackagePath,
  normalizeOptionalSpecPath,
  normalizePackageRootPath,
  shouldCaptureSdkReviewBundle,
  writeSdkReviewBundleManifest,
} from "../src/review-bundle.ts";
import type { ExecutionReport, SpecGenSdkCmdInput } from "../src/types.ts";
import { resetGitRepo } from "../src/utils.ts";

const temporaryDirectories: string[] = [];

function createTempSdkGitRepo(): {
  rootDir: string;
  sdkRepoPath: string;
  workingFolder: string;
  baseCommitSha: string;
} {
  const rootDir = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-review-bundle-test-"));
  temporaryDirectories.push(rootDir);

  const sdkRepoPath = path.join(rootDir, "azure-sdk-for-net");
  const workingFolder = path.join(rootDir, "work");
  fs.mkdirSync(sdkRepoPath, { recursive: true });
  fs.mkdirSync(workingFolder, { recursive: true });

  execFileSync("git", ["init", sdkRepoPath], { stdio: "ignore" });
  execFileSync("git", ["-C", sdkRepoPath, "config", "user.email", "test@example.com"]);
  execFileSync("git", ["-C", sdkRepoPath, "config", "user.name", "SDK Review Bundle Test"]);

  const pkg1Dir = path.join(sdkRepoPath, "sdk", "widget", "Azure.Widget");
  const pkg2Dir = path.join(sdkRepoPath, "sdk", "gadget", "Azure.ResourceManager.Gadget");
  fs.mkdirSync(path.join(pkg1Dir, "src"), { recursive: true });
  fs.mkdirSync(path.join(pkg2Dir, "src"), { recursive: true });

  fs.writeFileSync(
    path.join(pkg1Dir, "src", "WidgetClient.cs"),
    "namespace Azure.Widget;\npublic class WidgetClient { public int Version => 1; }\n",
  );
  fs.writeFileSync(
    path.join(pkg2Dir, "src", "GadgetResource.cs"),
    "namespace Azure.ResourceManager.Gadget;\npublic class GadgetResource {}\n",
  );

  execFileSync("git", ["-C", sdkRepoPath, "add", "."]);
  execFileSync("git", ["-C", sdkRepoPath, "commit", "-m", "Initial baseline"], {
    stdio: "ignore",
  });
  const baseCommitSha = execFileSync("git", ["-C", sdkRepoPath, "rev-parse", "HEAD"], {
    encoding: "utf8",
  }).trim();

  return { rootDir, sdkRepoPath, workingFolder, baseCommitSha };
}

function createNetSpecPrInput(sdkRepoPath: string, workingFolder: string): SpecGenSdkCmdInput {
  return {
    localSpecRepoPath: "/spec/repo",
    localSdkRepoPath: sdkRepoPath,
    workingFolder,
    sdkRepoName: "azure-sdk-for-net",
    sdkLanguage: SdkName.Net,
    specCommitSha: "38865cd3b650b3510e2a5b8bf9f990d0668a8810",
    specRepoHttpsUrl: "https://github.com/Azure/azure-rest-api-specs",
    prNumber: "47607",
    runMode: "spec-pull-request",
  };
}

describe("review-bundle", () => {
  beforeEach(() => {
    vi.restoreAllMocks();
    vi.spyOn(log, "logMessage").mockImplementation(() => {});
    vi.spyOn(log, "setVsoVariable").mockImplementation(() => {});
  });

  afterEach(() => {
    for (const dir of temporaryDirectories.splice(0)) {
      fs.rmSync(dir, { recursive: true, force: true });
    }
  });

  test("shouldCaptureSdkReviewBundle only enables for .NET spec-pull-request runs with valid PR and SHA", () => {
    const baseInput = createNetSpecPrInput("/sdk", "/work");
    expect(shouldCaptureSdkReviewBundle(baseInput)).toBe(true);
    expect(shouldCaptureSdkReviewBundle({ ...baseInput, sdkLanguage: SdkName.Js })).toBe(false);
    expect(shouldCaptureSdkReviewBundle({ ...baseInput, runMode: "batch" })).toBe(false);
    expect(shouldCaptureSdkReviewBundle({ ...baseInput, prNumber: "abc" })).toBe(false);
    expect(shouldCaptureSdkReviewBundle({ ...baseInput, specCommitSha: "not-a-sha" })).toBe(false);
  });

  test("normalizePackageRootPath resolves relative and in-repo absolute paths and rejects traversal", () => {
    const repoRoot = path.resolve("/tmp/azure-sdk-for-net");
    expect(normalizePackageRootPath(repoRoot, "./sdk/widget/Azure.Widget")).toBe(
      "sdk/widget/Azure.Widget",
    );
    expect(
      normalizePackageRootPath(repoRoot, path.join(repoRoot, "sdk", "widget", "Azure.Widget")),
    ).toBe("sdk/widget/Azure.Widget");
    expect(normalizePackageRootPath(repoRoot, "../outside-repo")).toBeUndefined();
    expect(normalizePackageRootPath(repoRoot, "")).toBeUndefined();
    expect(normalizeOptionalSpecPath("./specification/foo/tspconfig.yaml")).toBe(
      "specification/foo/tspconfig.yaml",
    );
    expect(normalizeOptionalSpecPath("../escape/tspconfig.yaml")).toBeUndefined();
  });

  test("isExcludedGeneratedPackagePath filters bin, obj, node_modules, and log.txt", () => {
    const pkgRoot = "sdk/widget/Azure.Widget";
    expect(
      isExcludedGeneratedPackagePath(pkgRoot, "sdk/widget/Azure.Widget/src/obj/Debug/foo.dll"),
    ).toBe(true);
    expect(
      isExcludedGeneratedPackagePath(pkgRoot, "sdk/widget/Azure.Widget/src/bin/Release/foo.dll"),
    ).toBe(true);
    expect(isExcludedGeneratedPackagePath(pkgRoot, "sdk/widget/Azure.Widget/src/log.txt")).toBe(
      true,
    );
    expect(
      isExcludedGeneratedPackagePath(pkgRoot, "sdk/widget/Azure.Widget/src/Generated/Widget.cs"),
    ).toBe(false);
    expect(
      isExcludedGeneratedPackagePath(pkgRoot, "sdk/widget/Azure.Widget/api/Azure.Widget.net8.0.cs"),
    ).toBe(false);
  });

  test("captures tracked + untracked changes across multiple specs before resetGitRepo wipes the repo", async () => {
    const { sdkRepoPath, workingFolder, baseCommitSha } = createTempSdkGitRepo();
    const commandInput = createNetSpecPrInput(sdkRepoPath, workingFolder);

    // Spec 1: modify tracked file, add untracked generated file and API listing, plus build noise (obj/ and log.txt)
    const pkg1Dir = path.join(sdkRepoPath, "sdk", "widget", "Azure.Widget");
    fs.writeFileSync(
      path.join(pkg1Dir, "src", "WidgetClient.cs"),
      "namespace Azure.Widget;\npublic class WidgetClient { public int Version => 2; }\n",
    );
    fs.mkdirSync(path.join(pkg1Dir, "src", "Generated"), { recursive: true });
    fs.writeFileSync(
      path.join(pkg1Dir, "src", "Generated", "WidgetModel.cs"),
      "namespace Azure.Widget.Models;\npublic partial class WidgetModel {}\n",
    );
    fs.mkdirSync(path.join(pkg1Dir, "api"), { recursive: true });
    fs.writeFileSync(
      path.join(pkg1Dir, "api", "Azure.Widget.net8.0.cs"),
      "namespace Azure.Widget { public partial class WidgetClient {} }\n",
    );
    // Noise that must be excluded
    fs.mkdirSync(path.join(pkg1Dir, "src", "obj"), { recursive: true });
    fs.writeFileSync(path.join(pkg1Dir, "src", "obj", "project.assets.json"), "{}");
    fs.writeFileSync(path.join(pkg1Dir, "src", "log.txt"), "build log");
    // Unrelated repo noise outside packageRootPath
    fs.mkdirSync(path.join(sdkRepoPath, "eng", "common", "tsp-client", "node_modules"), {
      recursive: true,
    });
    fs.writeFileSync(
      path.join(sdkRepoPath, "eng", "common", "tsp-client", "node_modules", "foo.js"),
      "module.exports = {};",
    );

    const report1: ExecutionReport = {
      executionResult: "succeeded",
      packages: [
        {
          serviceName: "widget",
          packageName: "Azure.Widget",
          packageRootPath: "./sdk/widget/Azure.Widget",
          result: "succeeded",
          hasBreakingChange: false,
        },
      ],
    };

    const entries1 = await captureSdkReviewBundleEntriesForSpec({
      commandInput,
      executionReport: report1,
      tspConfigPath: "specification/widget/Widget/tspconfig.yaml",
      existingEntriesCount: 0,
    });

    expect(entries1).toHaveLength(1);
    expect(entries1[0].entryId).toBe("01-Azure.Widget");
    expect(entries1[0].sdkBaseCommitSha).toBe(baseCommitSha);
    expect(entries1[0].changedFileCount).toBe(3);
    expect(entries1[0].changedFiles).toEqual([
      "sdk/widget/Azure.Widget/api/Azure.Widget.net8.0.cs",
      "sdk/widget/Azure.Widget/src/Generated/WidgetModel.cs",
      "sdk/widget/Azure.Widget/src/WidgetClient.cs",
    ]);

    // Simulate the runner resetting the SDK repo before the second changed spec
    await resetGitRepo(sdkRepoPath);

    // Confirm Spec 1's untracked files are gone from the SDK repo after reset,
    // proving the bundle preserved them before reset!
    expect(fs.existsSync(path.join(pkg1Dir, "src", "Generated", "WidgetModel.cs"))).toBe(false);

    // Spec 2: generate changes in the second package
    const pkg2Dir = path.join(sdkRepoPath, "sdk", "gadget", "Azure.ResourceManager.Gadget");
    fs.mkdirSync(path.join(pkg2Dir, "src", "Generated"), { recursive: true });
    fs.writeFileSync(
      path.join(pkg2Dir, "src", "Generated", "GadgetData.cs"),
      "namespace Azure.ResourceManager.Gadget;\npublic partial class GadgetData {}\n",
    );

    const report2: ExecutionReport = {
      executionResult: "succeeded",
      packages: [
        {
          serviceName: "gadget",
          packageName: "Azure.ResourceManager.Gadget",
          packageRootPath: "./sdk/gadget/Azure.ResourceManager.Gadget",
          result: "succeeded",
          shouldLabelBreakingChange: true,
        },
      ],
    };

    const entries2 = await captureSdkReviewBundleEntriesForSpec({
      commandInput,
      executionReport: report2,
      tspConfigPath: "specification/gadget/Gadget.Management/tspconfig.yaml",
      readmePath: "specification/gadget/resource-manager/readme.md",
      existingEntriesCount: entries1.length,
    });

    expect(entries2).toHaveLength(1);
    expect(entries2[0].entryId).toBe("02-Azure.ResourceManager.Gadget");
    expect(entries2[0].hasBreakingChange).toBe(true);
    expect(entries2[0].changedFiles).toEqual([
      "sdk/gadget/Azure.ResourceManager.Gadget/src/Generated/GadgetData.cs",
    ]);

    const allEntries = [...entries1, ...entries2];
    const manifest = writeSdkReviewBundleManifest(commandInput, allEntries, "6999663");

    expect(manifest).toBeDefined();
    expect(manifest?.entries).toHaveLength(2);
    expect(manifest?.buildId).toBe("6999663");

    const bundleDir = path.join(workingFolder, "out", SDK_REVIEW_BUNDLE_ARTIFACT_NAME);
    const manifestOnDisk = SdkReviewBundleManifestSchema.parse(
      JSON.parse(
        fs.readFileSync(path.join(bundleDir, SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME), "utf8"),
      ),
    );
    expect(manifestOnDisk).toEqual(manifest);

    // Verify both patch files exist on disk, match declared SHA-256 and byte length, and contain the diffs
    for (const entry of manifestOnDisk.entries) {
      const patchBytes = fs.readFileSync(path.join(bundleDir, entry.patchFile));
      expect(patchBytes.byteLength).toBe(entry.patchBytes);
      expect(createHash("sha256").update(patchBytes).digest("hex")).toBe(entry.patchSha256);
    }

    const patch1Text = fs.readFileSync(path.join(bundleDir, entries1[0].patchFile), "utf8");
    expect(patch1Text).toContain("public class WidgetClient { public int Version => 2; }");
    expect(patch1Text).toContain("public partial class WidgetModel {}");
    expect(patch1Text).not.toContain("project.assets.json");
    expect(patch1Text).not.toContain("node_modules");

    const patch2Text = fs.readFileSync(path.join(bundleDir, entries2[0].patchFile), "utf8");
    expect(patch2Text).toContain("public partial class GadgetData {}");

    expect(log.setVsoVariable).toHaveBeenCalledWith(
      "SdkReviewBundlePath",
      path.join("out", SDK_REVIEW_BUNDLE_ARTIFACT_NAME),
    );
    expect(log.setVsoVariable).toHaveBeenCalledWith(
      "SdkReviewBundleName",
      SDK_REVIEW_BUNDLE_ARTIFACT_NAME,
    );
  });
});
