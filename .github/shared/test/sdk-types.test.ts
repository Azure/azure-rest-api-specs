import { describe, expect, it } from "vitest";
import {
  isSafeRelativePosixPath,
  SDK_REVIEW_BUNDLE_MAX_CHANGED_FILES_PER_ENTRY,
  SDK_REVIEW_BUNDLE_SCHEMA_VERSION,
  sdkLabels,
  SdkName,
  SdkReviewBundleManifestSchema,
  SpecGenSdkArtifactInfoSchema,
} from "../src/sdk-types.ts";
import { createMockSpecGenSdkArtifactInfo } from "./sdk-types.ts";

describe("sdk-types", () => {
  it("defines sdkLabels", () => {
    // Ensures constant "sdkLabels" is considered "covered" by codecov
    expect(sdkLabels).toBeDefined();
  });

  it("parses SpecGetSdkArtifactInfo", () => {
    const artifactInfo = createMockSpecGenSdkArtifactInfo();

    const json = JSON.stringify(artifactInfo);
    expect(json).toMatchInlineSnapshot(
      `"{"apiViewRequestData":[],"headSha":"abc123","isSpecGenSdkCheckRequired":true,"language":"azure-sdk-for-go","result":"test result"}"`,
    );

    const parsed = SpecGenSdkArtifactInfoSchema.parse(JSON.parse(json));
    expect(parsed).toEqual(artifactInfo);
  });

  it("validates safe relative POSIX paths and rejects path traversal", () => {
    expect(isSafeRelativePosixPath("sdk/foo/Azure.Foo")).toBe(true);
    expect(isSafeRelativePosixPath("01-Azure.Foo.patch")).toBe(true);
    expect(isSafeRelativePosixPath("")).toBe(false);
    expect(isSafeRelativePosixPath("/abs/path")).toBe(false);
    expect(isSafeRelativePosixPath("../escape")).toBe(false);
    expect(isSafeRelativePosixPath("sdk/../escape")).toBe(false);
    expect(isSafeRelativePosixPath("sdk/./foo")).toBe(false);
    expect(isSafeRelativePosixPath("sdk\\foo")).toBe(false);
    expect(isSafeRelativePosixPath("C:/sdk/foo")).toBe(false);
    expect(isSafeRelativePosixPath("sdk/foo\nbar")).toBe(false);
  });

  it("validates SdkReviewBundleManifestSchema and rejects unsafe patch filenames", () => {
    const validManifest = {
      schemaVersion: SDK_REVIEW_BUNDLE_SCHEMA_VERSION,
      buildId: "6999663",
      specPrNumber: "47607",
      specHeadSha: "38865cd3b650b3510e2a5b8bf9f990d0668a8810",
      specRepoUrl: "https://github.com/Azure/azure-rest-api-specs",
      sdkLanguage: SdkName.Net,
      sdkRepoName: "azure-sdk-for-net",
      captureStatus: "complete",
      expectedEntryCount: 1,
      entries: [
        {
          entryId: "01-Azure.ResourceManager.PrivateTrafficManager",
          tspConfigPath:
            "specification/privatetrafficmanager/resource-manager/Microsoft.Network/PrivateTrafficManager/tspconfig.yaml",
          packageName: "Azure.ResourceManager.PrivateTrafficManager",
          packageRootPath: "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager",
          sdkBaseCommitSha: "7f2236ba6603779909dd53989ab7fefb3b78a7d6",
          executionResult: "succeeded",
          hasBreakingChange: false,
          patchFile: "01-Azure.ResourceManager.PrivateTrafficManager.patch",
          patchBytes: 128,
          changedFileCount: 1,
          changedFiles: [
            "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager/src/Generated/RestClient.cs",
          ],
        },
      ],
    };

    expect(SdkReviewBundleManifestSchema.parse(validManifest)).toEqual(validManifest);

    const {
      patchFile: _patchFile,
      patchBytes: _patchBytes,
      ...entryWithoutPatch
    } = validManifest.entries[0];
    void [_patchFile, _patchBytes];
    const emptyEntry = {
      ...entryWithoutPatch,
      changedFileCount: 0 as const,
      changedFiles: [],
    };
    expect(
      SdkReviewBundleManifestSchema.parse({
        ...validManifest,
        entries: [emptyEntry],
      }),
    ).toEqual({ ...validManifest, entries: [emptyEntry] });

    for (const partialPatchMetadata of [
      { patchFile: "empty.patch" },
      { patchBytes: 1 },
      { patchFile: "empty.patch", patchBytes: 1 },
    ]) {
      expect(() =>
        SdkReviewBundleManifestSchema.parse({
          ...validManifest,
          entries: [{ ...emptyEntry, ...partialPatchMetadata }],
        }),
      ).toThrow();
    }

    for (const missingPatchMetadata of [{ patchFile: undefined }, { patchBytes: undefined }]) {
      expect(() =>
        SdkReviewBundleManifestSchema.parse({
          ...validManifest,
          entries: [{ ...validManifest.entries[0], ...missingPatchMetadata }],
        }),
      ).toThrow();
    }

    expect(() =>
      SdkReviewBundleManifestSchema.parse({
        ...validManifest,
        entries: [{ ...validManifest.entries[0], patchBytes: 0 }],
      }),
    ).toThrow();
    expect(() =>
      SdkReviewBundleManifestSchema.parse({
        ...validManifest,
        entries: [{ ...validManifest.entries[0], changedFileCount: 2 }],
      }),
    ).toThrow("must match changedFiles length");

    expect(() =>
      SdkReviewBundleManifestSchema.parse({
        ...validManifest,
        entries: [
          {
            ...validManifest.entries[0],
            patchFile: "../evil.patch",
          },
        ],
      }),
    ).toThrow();

    expect(() =>
      SdkReviewBundleManifestSchema.parse({
        ...validManifest,
        expectedEntryCount: 2,
      }),
    ).toThrow("must match expectedEntryCount");

    const failedManifest = {
      ...validManifest,
      captureStatus: "failed",
      expectedEntryCount: 1,
      captureErrors: ["Missing packageRootPath"],
      entries: [],
    };
    expect(SdkReviewBundleManifestSchema.parse(failedManifest)).toEqual(failedManifest);
    expect(() =>
      SdkReviewBundleManifestSchema.parse({
        ...failedManifest,
        entries: validManifest.entries,
      }),
    ).toThrow();

    const entriesOverTotalChangedFilesLimit = [0, 1, 2].map((entryIndex) => {
      const changedFiles = Array.from(
        {
          length: entryIndex < 2 ? SDK_REVIEW_BUNDLE_MAX_CHANGED_FILES_PER_ENTRY : 1,
        },
        (_, fileIndex) =>
          `sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager/src/Generated/${entryIndex}-${fileIndex}.cs`,
      );
      return {
        ...validManifest.entries[0],
        entryId: `entry-${entryIndex}`,
        patchFile: `entry-${entryIndex}.patch`,
        changedFileCount: changedFiles.length,
        changedFiles,
      };
    });
    expect(() =>
      SdkReviewBundleManifestSchema.parse({
        ...validManifest,
        expectedEntryCount: entriesOverTotalChangedFilesLimit.length,
        entries: entriesOverTotalChangedFilesLimit,
      }),
    ).toThrow("maximum");
  });
});
