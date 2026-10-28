import fs from "node:fs";
import path from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";
import type { SdkReviewBundleEntry } from "../../shared/src/sdk-types.ts";
import {
  groupPatchEntriesByBaseCommit,
  validateSdkReviewPatchApplicability,
  type PatchApplicabilityCommand,
} from "../src/sdk-review-patch-applicability.ts";

const testDirectories: string[] = [];
const BASE_SHA_1 = "1".repeat(40);
const BASE_SHA_2 = "2".repeat(40);

function createTestDirectory(): string {
  const parent = path.join(process.cwd(), "out");
  fs.mkdirSync(parent, { recursive: true });
  const directory = fs.mkdtempSync(path.join(parent, "patch-applicability-test-"));
  testDirectories.push(directory);
  return directory;
}

function createEntry(
  entryId: string,
  packageRootPath: string,
  sdkBaseCommitSha = BASE_SHA_1,
): SdkReviewBundleEntry {
  return {
    entryId,
    packageName: entryId,
    packageRootPath,
    sdkBaseCommitSha,
    executionResult: "succeeded",
    patchFile: `${entryId}.patch`,
    patchSha256: "a".repeat(64),
    patchBytes: 1,
    changedFileCount: 1,
    changedFiles: [`${packageRootPath}/src/Generated.cs`],
  };
}

afterEach(() => {
  for (const directory of testDirectories.splice(0)) {
    fs.rmSync(directory, { recursive: true, force: true });
  }
});

describe("sdk-review-patch-applicability", () => {
  it("groups entries by base commit and deduplicates sparse package roots", () => {
    const groups = groupPatchEntriesByBaseCommit([
      createEntry("one", "sdk/widget/Azure.Widget"),
      createEntry("two", "sdk/widget/Azure.Widget"),
      createEntry("three", "sdk/gadget/Azure.Gadget", BASE_SHA_2),
    ]);

    expect(groups).toHaveLength(2);
    expect(groups[0].entries).toHaveLength(2);
    expect(groups[0].packageRoots).toEqual(["sdk/widget/Azure.Widget"]);
    expect(groups[1].sdkBaseCommitSha).toBe(BASE_SHA_2);
  });

  it("combines every patch for a base and configures all sparse roots", async () => {
    const bundleDirectory = createTestDirectory();
    const workingRoot = createTestDirectory();
    const entries = [
      createEntry("one", "sdk/widget/Azure.Widget"),
      createEntry("two", "sdk/gadget/Azure.Gadget"),
    ];
    fs.writeFileSync(path.join(bundleDirectory, entries[0].patchFile), "patch-one\n");
    fs.writeFileSync(path.join(bundleDirectory, entries[1].patchFile), "patch-two\n");

    let combinedPatch = "";
    const commands: string[][] = [];
    const runCommand: PatchApplicabilityCommand = vi.fn((_file: string, args: string[]) => {
      commands.push(args);
      if (args[0] === "apply") {
        combinedPatch = fs.readFileSync(args[args.length - 1], "utf8");
      }
      return Promise.resolve({});
    });

    await validateSdkReviewPatchApplicability({
      sdkRepoName: "azure-sdk-for-net",
      entries,
      bundleDirectory,
      workingRoot,
      runCommand,
    });

    expect(combinedPatch).toContain("patch-one");
    expect(combinedPatch).toContain("patch-two");
    expect(commands).toContainEqual([
      "sparse-checkout",
      "set",
      "--",
      "sdk/widget/Azure.Widget",
      "sdk/gadget/Azure.Gadget",
    ]);
    expect(commands).toContainEqual(["apply", "--check", "--binary", expect.any(String)]);
    expect(fs.readdirSync(workingRoot)).toEqual([]);
  });

  it("propagates git apply failures and still cleans the validation directory", async () => {
    const bundleDirectory = createTestDirectory();
    const workingRoot = createTestDirectory();
    const entry = createEntry("one", "sdk/widget/Azure.Widget");
    fs.writeFileSync(path.join(bundleDirectory, entry.patchFile), "patch-one\n");
    const runCommand: PatchApplicabilityCommand = vi.fn((_file: string, args: string[]) => {
      if (args[0] === "apply") {
        return Promise.reject(new Error("patch does not apply"));
      }
      return Promise.resolve({});
    });

    await expect(
      validateSdkReviewPatchApplicability({
        sdkRepoName: "azure-sdk-for-net",
        entries: [entry],
        bundleDirectory,
        workingRoot,
        runCommand,
      }),
    ).rejects.toThrow("patch does not apply");
    expect(fs.readdirSync(workingRoot)).toEqual([]);
  });

  it("skips git when every patch for a base commit is empty", async () => {
    const bundleDirectory = createTestDirectory();
    const workingRoot = createTestDirectory();
    const entry = {
      ...createEntry("one", "sdk/widget/Azure.Widget"),
      patchBytes: 0,
      changedFileCount: 0,
      changedFiles: [],
    };
    fs.writeFileSync(path.join(bundleDirectory, entry.patchFile), "");
    const runCommand: PatchApplicabilityCommand = vi.fn();

    await validateSdkReviewPatchApplicability({
      sdkRepoName: "azure-sdk-for-net",
      entries: [entry],
      bundleDirectory,
      workingRoot,
      runCommand,
    });

    expect(runCommand).not.toHaveBeenCalled();
    expect(fs.readdirSync(workingRoot)).toEqual([]);
  });

  it.each([
    ["unsafe repository", "azure-sdk-for-net/evil", createEntry("one", "sdk/widget/Azure.Widget")],
    ["unsafe package root", "azure-sdk-for-net", createEntry("one", "../Azure.Widget")],
    ["non-SDK package root", "azure-sdk-for-net", createEntry("one", "eng/Azure.Widget")],
    [
      "unsafe base commit",
      "azure-sdk-for-net",
      { ...createEntry("one", "sdk/widget/Azure.Widget"), sdkBaseCommitSha: "--help" },
    ],
  ])("rejects %s before running git", async (_label, repository, entry) => {
    const runCommand: PatchApplicabilityCommand = vi.fn();
    await expect(
      validateSdkReviewPatchApplicability({
        sdkRepoName: repository,
        entries: [entry],
        bundleDirectory: createTestDirectory(),
        workingRoot: createTestDirectory(),
        runCommand,
      }),
    ).rejects.toThrow(/Unsafe SDK/);
    expect(runCommand).not.toHaveBeenCalled();
  });
});
