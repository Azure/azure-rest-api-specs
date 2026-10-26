import { describe, expect, it } from "vitest";
import {
  isSafeRelativePosixPath,
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
          patchSha256: "a".repeat(64),
          patchBytes: 128,
          changedFileCount: 1,
          changedFiles: [
            "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager/src/Generated/RestClient.cs",
          ],
        },
      ],
    };

    expect(SdkReviewBundleManifestSchema.parse(validManifest)).toEqual(validManifest);

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
  });
});
