import path from "node:path";
import { describe, expect, it, vi } from "vitest";
import {
  checkIfSdkNeedsToBeGenerated,
  isLanguageExcluded,
  parseSdkInfoItems,
  resolveTypespecProjectPath,
} from "../src/generate-sdk.ts";
import type { OctokitLike } from "../src/types.ts";

function createOctokitMock(getImpl?: ReturnType<typeof vi.fn>): OctokitLike {
  return {
    rest: {
      pulls: {
        get: getImpl ?? vi.fn(),
        listFiles: vi.fn(),
      },
    },
  } as unknown as OctokitLike;
}

const baseSdkInfo = [
  {
    Language: "Python",
    SdkPullRequestUrl: "https://github.com/Azure/azure-rest-api-specs/pull/123",
    PackageName: "azure-mgmt-contoso",
    ReleaseStatus: "",
    GenerationStatus: "Not applicable",
    ReleaseExclusionStatus: "Not applicable",
  },
];

describe("checkIfSdkNeedsToBeGenerated", () => {
  it("returns true for created outcome without consulting GitHub", async () => {
    const octokit = createOctokitMock();

    await expect(
      checkIfSdkNeedsToBeGenerated({
        language: "Python",
        outcomeNormalized: "created",
        sdkInfoItems: baseSdkInfo,
        octokit,
      }),
    ).resolves.toBe(true);
  });

  it("skips generation when release status is Released", async () => {
    const octokit = createOctokitMock();

    await expect(
      checkIfSdkNeedsToBeGenerated({
        language: "Python",
        outcomeNormalized: "existing_by_pr",
        sdkInfoItems: [
          {
            ...baseSdkInfo[0],
            ReleaseStatus: "Released",
          },
        ],
        octokit,
      }),
    ).resolves.toBe(false);
    expect(octokit.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("returns true when no SDK PR URL is present", async () => {
    const octokit = createOctokitMock();

    await expect(
      checkIfSdkNeedsToBeGenerated({
        language: "Python",
        outcomeNormalized: "existing_by_path",
        sdkInfoItems: [
          {
            ...baseSdkInfo[0],
            SdkPullRequestUrl: "",
          },
        ],
        octokit,
      }),
    ).resolves.toBe(true);
    expect(octokit.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("skips generation when GitHub reports the PR as merged", async () => {
    const get = vi.fn().mockResolvedValue({
      data: {
        state: "closed",
        merged_at: "2026-07-10T00:00:00Z",
      },
    });
    const octokit = createOctokitMock(get);

    await expect(
      checkIfSdkNeedsToBeGenerated({
        language: "Python",
        outcomeNormalized: "existing_by_path",
        sdkInfoItems: baseSdkInfo,
        octokit,
      }),
    ).resolves.toBe(false);
    expect(get).toHaveBeenCalledOnce();
  });

  it("regenerates when the SDK PR is still open", async () => {
    const get = vi.fn().mockResolvedValue({
      data: {
        state: "open",
        merged_at: null,
      },
    });
    const octokit = createOctokitMock(get);

    await expect(
      checkIfSdkNeedsToBeGenerated({
        language: "Python",
        outcomeNormalized: "existing_by_path",
        sdkInfoItems: baseSdkInfo,
        octokit,
      }),
    ).resolves.toBe(true);
    expect(get).toHaveBeenCalledOnce();
  });

  it("returns true when no SDKInfo exists for the language", async () => {
    const octokit = createOctokitMock();

    await expect(
      checkIfSdkNeedsToBeGenerated({
        language: "Go",
        outcomeNormalized: "existing_by_path",
        sdkInfoItems: baseSdkInfo,
        octokit,
      }),
    ).resolves.toBe(true);
    expect(octokit.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("skips an excluded language (MissingEmitterConfig) even on the created path", async () => {
    const octokit = createOctokitMock();

    await expect(
      checkIfSdkNeedsToBeGenerated({
        language: "Python",
        outcomeNormalized: "created",
        sdkInfoItems: [{ ...baseSdkInfo[0], ReleaseExclusionStatus: "MissingEmitterConfig" }],
        octokit,
      }),
    ).resolves.toBe(false);
    expect(octokit.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("skips an excluded language on the existing path without consulting GitHub", async () => {
    const octokit = createOctokitMock();

    await expect(
      checkIfSdkNeedsToBeGenerated({
        language: "Python",
        outcomeNormalized: "existing_by_path",
        sdkInfoItems: [{ ...baseSdkInfo[0], ReleaseExclusionStatus: "ServiceTeamExcluded" }],
        octokit,
      }),
    ).resolves.toBe(false);
    expect(octokit.rest.pulls.get).not.toHaveBeenCalled();
  });
});

describe("isLanguageExcluded", () => {
  it.each(["", "Not applicable", "notapplicable", "None", "N/A"])(
    "treats '%s' as not excluded",
    (status) => {
      expect(isLanguageExcluded({ ReleaseExclusionStatus: status })).toBe(false);
    },
  );

  it("treats a missing ReleaseExclusionStatus as not excluded", () => {
    expect(isLanguageExcluded({ Language: "Python" })).toBe(false);
  });

  it.each(["MissingEmitterConfig", "ServiceTeamExcluded", "SomeOtherReason"])(
    "treats '%s' as excluded",
    (status) => {
      expect(isLanguageExcluded({ ReleaseExclusionStatus: status })).toBe(true);
    },
  );
});

describe("parseSdkInfoItems", () => {
  it("returns the array unchanged when given an array", () => {
    expect(parseSdkInfoItems(baseSdkInfo)).toEqual(baseSdkInfo);
  });

  it("parses a JSON-encoded string array", () => {
    expect(parseSdkInfoItems(JSON.stringify(baseSdkInfo))).toEqual(baseSdkInfo);
  });

  it("returns an empty array for malformed JSON", () => {
    expect(parseSdkInfoItems("{not-json")).toEqual([]);
  });

  it("returns an empty array for a non-array JSON payload", () => {
    expect(parseSdkInfoItems(JSON.stringify({ Language: "Python" }))).toEqual([]);
  });

  it("returns an empty array for empty or nullish input", () => {
    expect(parseSdkInfoItems("")).toEqual([]);
    expect(parseSdkInfoItems("   ")).toEqual([]);
    expect(parseSdkInfoItems(undefined)).toEqual([]);
    expect(parseSdkInfoItems(null)).toEqual([]);
  });
});

describe("resolveTypespecProjectPath", () => {
  const workspace = path.resolve("/repo/root");

  it("returns an empty string for empty input", () => {
    expect(resolveTypespecProjectPath("", workspace)).toBe("");
    expect(resolveTypespecProjectPath("   ", workspace)).toBe("");
  });

  it("resolves a relative path against the workspace", () => {
    expect(resolveTypespecProjectPath("specification/contoso/Contoso.Management", workspace)).toBe(
      path.resolve(workspace, "specification/contoso/Contoso.Management"),
    );
  });

  it("returns an absolute path unchanged", () => {
    const absolute = path.resolve("/some/absolute/spec/path");
    expect(resolveTypespecProjectPath(absolute, workspace)).toBe(absolute);
  });
});
