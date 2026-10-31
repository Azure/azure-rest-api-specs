import { describe, expect, it } from "vitest";
import {
  isSafeRelativePosixPath,
  SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE,
  SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE,
  SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE,
  SDK_REVIEW_MAX_TOTAL_CHANGED_FILES,
  SDK_REVIEW_MAX_TOTAL_SNAPSHOT_BYTES,
  SDK_REVIEW_MAX_TOTAL_SNAPSHOT_FILES,
  sdkLabels,
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

  it("accepts legacy APIView entries and enriched naming review entries", () => {
    const baseArtifact = {
      language: "azure-sdk-for-net",
      result: "succeeded",
      headSha: "38865cd3b650b3510e2a5b8bf9f990d0668a8810",
      prNumber: "47607",
      isSpecGenSdkCheckRequired: true,
      apiViewRequestData: [
        {
          packageName: "Azure.ResourceManager.PrivateTrafficManager",
          filePath: "Azure.ResourceManager.PrivateTrafficManager.1.0.0.nupkg",
        },
      ],
    };

    expect(SpecGenSdkArtifactInfoSchema.parse(baseArtifact)).toEqual(baseArtifact);

    const enrichedArtifact = structuredClone(baseArtifact);
    Object.assign(enrichedArtifact.apiViewRequestData[0], {
      packageRootPath: "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager",
      changedFiles: [
        "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager/api/Azure.ResourceManager.PrivateTrafficManager.netstandard2.0.cs",
      ],
      sdkBaseCommitSha: "0123456789abcdef0123456789abcdef01234567",
      reviewInputPath: "Azure.ResourceManager.PrivateTrafficManager/review-input",
      reviewInputFileCount: 42,
      reviewInputBytes: 12_345,
    });
    expect(SpecGenSdkArtifactInfoSchema.parse(enrichedArtifact)).toEqual(enrichedArtifact);

    expect(() =>
      SpecGenSdkArtifactInfoSchema.parse({
        ...baseArtifact,
        apiViewRequestData: [
          {
            ...baseArtifact.apiViewRequestData[0],
            packageRootPath:
              "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager",
          },
        ],
      }),
    ).toThrow("SDK review input fields must be provided together");

    expect(() =>
      SpecGenSdkArtifactInfoSchema.parse({
        ...baseArtifact,
        apiViewRequestData: [
          {
            ...baseArtifact.apiViewRequestData[0],
            packageRootPath:
              "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager",
            changedFiles: ["sdk/other/Azure.Other/Foo.cs"],
            sdkBaseCommitSha: "0123456789abcdef0123456789abcdef01234567",
            reviewInputPath: "Azure.ResourceManager.PrivateTrafficManager/review-input",
            reviewInputFileCount: 42,
            reviewInputBytes: 12_345,
          },
        ],
      }),
    ).toThrow("inside packageRootPath");

    const tooManyChangedFiles = Array.from(
      { length: SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE + 1 },
      (_, index) =>
        `sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager/src/Generated/${index}.cs`,
    );
    expect(() =>
      SpecGenSdkArtifactInfoSchema.parse({
        ...baseArtifact,
        apiViewRequestData: [
          {
            ...baseArtifact.apiViewRequestData[0],
            packageRootPath:
              "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager",
            changedFiles: tooManyChangedFiles,
            sdkBaseCommitSha: "0123456789abcdef0123456789abcdef01234567",
            reviewInputPath: "Azure.ResourceManager.PrivateTrafficManager/review-input",
            reviewInputFileCount: 42,
            reviewInputBytes: 12_345,
          },
        ],
      }),
    ).toThrow();

    expect(() =>
      SpecGenSdkArtifactInfoSchema.parse({
        ...baseArtifact,
        apiViewRequestData: [
          {
            ...baseArtifact.apiViewRequestData[0],
            packageRootPath:
              "sdk/privatetrafficmanager/Azure.ResourceManager.PrivateTrafficManager",
            changedFiles: [],
            sdkBaseCommitSha: "0123456789abcdef0123456789abcdef01234567",
            reviewInputPath: "Azure.ResourceManager.PrivateTrafficManager/review-input",
            reviewInputFileCount: 42,
            reviewInputBytes: SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE + 1,
          },
        ],
      }),
    ).toThrow();
  });

  it("rejects duplicate changed files and aggregate review input limits", () => {
    const artifact = {
      language: "azure-sdk-for-net",
      result: "succeeded",
      headSha: "38865cd3b650b3510e2a5b8bf9f990d0668a8810",
      isSpecGenSdkCheckRequired: true,
      apiViewRequestData: [],
    };
    const createReviewRequest = (index: number, overrides: Record<string, unknown> = {}) => {
      const packageName = `Azure.Widget${index}`;
      const packageRootPath = `sdk/widget${index}/${packageName}`;
      return {
        packageName,
        filePath: `${packageName}.1.0.0.nupkg`,
        packageRootPath,
        changedFiles: [],
        sdkBaseCommitSha: "0123456789abcdef0123456789abcdef01234567",
        reviewInputPath: `${packageName}/review-input`,
        reviewInputFileCount: 1,
        reviewInputBytes: 1,
        ...overrides,
      };
    };
    const createChangedFiles = (index: number, count: number) =>
      Array.from(
        { length: count },
        (_, fileIndex) => `sdk/widget${index}/Azure.Widget${index}/src/${fileIndex}.cs`,
      );

    const duplicatePath = "sdk/widget0/Azure.Widget0/src/Widget.cs";
    expect(() =>
      SpecGenSdkArtifactInfoSchema.parse({
        ...artifact,
        apiViewRequestData: [
          createReviewRequest(0, { changedFiles: [duplicatePath, duplicatePath] }),
        ],
      }),
    ).toThrow("changedFiles must not contain duplicates");

    expect(() =>
      SpecGenSdkArtifactInfoSchema.parse({
        ...artifact,
        apiViewRequestData: [
          createReviewRequest(0, {
            changedFiles: createChangedFiles(0, SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE),
          }),
          createReviewRequest(1, {
            changedFiles: createChangedFiles(1, SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE),
          }),
          createReviewRequest(2, { changedFiles: createChangedFiles(2, 1) }),
        ],
      }),
    ).toThrow(`maximum is ${SDK_REVIEW_MAX_TOTAL_CHANGED_FILES}`);

    expect(() =>
      SpecGenSdkArtifactInfoSchema.parse({
        ...artifact,
        apiViewRequestData: [
          createReviewRequest(0, {
            reviewInputBytes: SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE,
          }),
          createReviewRequest(1, {
            reviewInputBytes: SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE,
          }),
          createReviewRequest(2),
        ],
      }),
    ).toThrow(`maximum is ${SDK_REVIEW_MAX_TOTAL_SNAPSHOT_BYTES}`);

    expect(() =>
      SpecGenSdkArtifactInfoSchema.parse({
        ...artifact,
        apiViewRequestData: [
          createReviewRequest(0, {
            reviewInputFileCount: SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE,
          }),
          createReviewRequest(1, {
            reviewInputFileCount: SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE,
          }),
          createReviewRequest(2),
        ],
      }),
    ).toThrow(`maximum is ${SDK_REVIEW_MAX_TOTAL_SNAPSHOT_FILES}`);
  });
});
