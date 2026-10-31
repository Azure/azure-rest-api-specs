import { SdkName } from "@azure-tools/specs-shared/sdk-types";
import { execFileSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { afterEach, beforeEach, describe, expect, test, vi } from "vitest";
import * as log from "../src/log.ts";
import {
  captureSdkReviewMetadata,
  isExcludedGeneratedPackagePath,
  normalizePackageRootPath,
  shouldCaptureSdkReviewMetadata,
} from "../src/sdk-review-metadata.ts";
import type { ExecutionReport, SpecGenSdkCmdInput } from "../src/types.ts";

const temporaryDirectories: string[] = [];

function createTempSdkGitRepo(): {
  rootDir: string;
  sdkRepoPath: string;
  workingFolder: string;
  stagedArtifactsFolder: string;
  apiViewArtifact: string;
} {
  const rootDir = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-review-metadata-test-"));
  temporaryDirectories.push(rootDir);

  const sdkRepoPath = path.join(rootDir, "azure-sdk-for-net");
  const workingFolder = path.join(rootDir, "work");
  const stagedArtifactsFolder = path.join(rootDir, "artifacts");
  const apiViewArtifact = path.join(
    stagedArtifactsFolder,
    "Azure.Widget",
    "Azure.Widget.1.0.0.nupkg",
  );
  const packageDir = path.join(sdkRepoPath, "sdk", "widget", "Azure.Widget");
  fs.mkdirSync(path.join(packageDir, "src"), { recursive: true });
  fs.mkdirSync(workingFolder, { recursive: true });
  fs.mkdirSync(path.dirname(apiViewArtifact), { recursive: true });
  fs.writeFileSync(apiViewArtifact, "package");

  execFileSync("git", ["init", sdkRepoPath], { stdio: "ignore" });
  execFileSync("git", ["-C", sdkRepoPath, "config", "user.email", "test@example.com"]);
  execFileSync("git", ["-C", sdkRepoPath, "config", "user.name", "SDK Review Test"]);
  fs.writeFileSync(
    path.join(packageDir, "src", "WidgetClient.cs"),
    "namespace Azure.Widget;\npublic class WidgetClient {}\n",
  );
  fs.mkdirSync(path.join(packageDir, "src", "Models"), { recursive: true });
  fs.writeFileSync(
    path.join(packageDir, "src", "Models", "WidgetModel.cs"),
    "namespace Azure.Widget;\npublic class WidgetModel {}\n",
  );
  execFileSync("git", ["-C", sdkRepoPath, "add", "."]);
  execFileSync("git", ["-C", sdkRepoPath, "commit", "-m", "Initial baseline"], {
    stdio: "ignore",
  });

  return { rootDir, sdkRepoPath, workingFolder, stagedArtifactsFolder, apiViewArtifact };
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

describe("sdk-review-metadata", () => {
  beforeEach(() => {
    vi.restoreAllMocks();
    vi.spyOn(log, "logMessage").mockImplementation(() => {});
  });

  afterEach(() => {
    for (const directory of temporaryDirectories.splice(0)) {
      fs.rmSync(directory, { recursive: true, force: true });
    }
  });

  test("only captures metadata for .NET spec pull request runs", () => {
    const input = createNetSpecPrInput("/sdk", "/work");
    expect(shouldCaptureSdkReviewMetadata(input)).toBe(true);
    expect(shouldCaptureSdkReviewMetadata({ ...input, sdkLanguage: SdkName.Js })).toBe(false);
    expect(shouldCaptureSdkReviewMetadata({ ...input, runMode: "batch" })).toBe(false);
    expect(shouldCaptureSdkReviewMetadata({ ...input, prNumber: "invalid" })).toBe(false);
  });

  test("normalizes package roots and filters generated build noise", () => {
    const repoRoot = path.resolve("/tmp/azure-sdk-for-net");
    expect(normalizePackageRootPath(repoRoot, "./sdk/widget/Azure.Widget")).toBe(
      "sdk/widget/Azure.Widget",
    );
    expect(normalizePackageRootPath(repoRoot, "../outside")).toBeUndefined();

    const packageRoot = "sdk/widget/Azure.Widget";
    expect(
      isExcludedGeneratedPackagePath(
        packageRoot,
        "sdk/widget/Azure.Widget/src/obj/project.assets.json",
      ),
    ).toBe(true);
    expect(
      isExcludedGeneratedPackagePath(
        packageRoot,
        "sdk/widget/Azure.Widget/api/Azure.Widget.net8.0.cs",
      ),
    ).toBe(false);
  });

  test("captures tracked and untracked changed files without creating patches", async () => {
    const { sdkRepoPath, workingFolder, stagedArtifactsFolder, apiViewArtifact } =
      createTempSdkGitRepo();
    const packageDir = path.join(sdkRepoPath, "sdk", "widget", "Azure.Widget");
    fs.writeFileSync(
      path.join(packageDir, "src", "WidgetClient.cs"),
      "namespace Azure.Widget;\npublic class WidgetClient { public int Version => 2; }\n",
    );
    fs.mkdirSync(path.join(packageDir, "api"), { recursive: true });
    fs.writeFileSync(
      path.join(packageDir, "api", "Azure.Widget.net8.0.cs"),
      "namespace Azure.Widget { public partial class WidgetClient {} }\n",
    );
    fs.mkdirSync(path.join(packageDir, "src", "obj"), { recursive: true });
    fs.writeFileSync(path.join(packageDir, "src", "obj", "project.assets.json"), "{}");
    fs.writeFileSync(path.join(packageDir, "Azure.Widget.csproj"), "<Project />");
    fs.writeFileSync(path.join(packageDir, "README.md"), "# Azure Widget");

    const report: ExecutionReport = {
      executionResult: "succeeded",
      stagedArtifactsFolder,
      packages: [
        {
          packageName: "Azure.Widget",
          packageRootPath: "./sdk/widget/Azure.Widget",
          apiViewArtifact,
          result: "succeeded",
        },
      ],
    };

    const captured = await captureSdkReviewMetadata(
      createNetSpecPrInput(sdkRepoPath, workingFolder),
      report,
    );

    const baselineSha = execFileSync("git", ["-C", sdkRepoPath, "rev-parse", "HEAD"], {
      encoding: "utf8",
    }).trim();
    expect(captured.get("Azure.Widget")).toMatchObject({
      packageRootPath: "sdk/widget/Azure.Widget",
      changedFiles: [
        "sdk/widget/Azure.Widget/Azure.Widget.csproj",
        "sdk/widget/Azure.Widget/README.md",
        "sdk/widget/Azure.Widget/api/Azure.Widget.net8.0.cs",
        "sdk/widget/Azure.Widget/src/WidgetClient.cs",
      ],
      sdkBaseCommitSha: baselineSha,
      reviewInputPath: "Azure.Widget/review-input",
      reviewInputFileCount: 5,
    });
    expect(captured.get("Azure.Widget")?.reviewInputBytes).toBeGreaterThan(0);

    const reviewInputFolder = path.join(stagedArtifactsFolder, "Azure.Widget", "review-input");
    expect(fs.existsSync(path.join(reviewInputFolder, "src", "WidgetClient.cs"))).toBe(true);
    expect(fs.existsSync(path.join(reviewInputFolder, "src", "Models", "WidgetModel.cs"))).toBe(
      true,
    );
    expect(fs.existsSync(path.join(reviewInputFolder, "api", "Azure.Widget.net8.0.cs"))).toBe(true);
    expect(fs.existsSync(path.join(reviewInputFolder, "Azure.Widget.csproj"))).toBe(true);
    expect(fs.existsSync(path.join(reviewInputFolder, "README.md"))).toBe(true);
    expect(fs.existsSync(path.join(reviewInputFolder, "src", "obj"))).toBe(false);
  });

  test.each([
    [
      "missing packageName",
      { packageRootPath: "./sdk/widget/Azure.Widget", result: "succeeded" },
      "missing packageName, packageRootPath, or apiViewArtifact",
    ],
    [
      "missing packageRootPath",
      { packageName: "Azure.Widget", result: "succeeded" },
      "missing packageName, packageRootPath, or apiViewArtifact",
    ],
    [
      "unsafe packageRootPath",
      {
        packageName: "Azure.Widget",
        packageRootPath: "../outside",
        result: "succeeded",
      },
      "unsafe packageRootPath",
    ],
  ])("rejects %s", async (_label, packageInfo, message) => {
    const { sdkRepoPath, workingFolder, stagedArtifactsFolder, apiViewArtifact } =
      createTempSdkGitRepo();
    const completePackageInfo = {
      apiViewArtifact,
      ...packageInfo,
    } as ExecutionReport["packages"][number];
    await expect(
      captureSdkReviewMetadata(createNetSpecPrInput(sdkRepoPath, workingFolder), {
        executionResult: "succeeded",
        stagedArtifactsFolder,
        packages: [completePackageInfo],
      }),
    ).rejects.toThrow(message);
  });
});
