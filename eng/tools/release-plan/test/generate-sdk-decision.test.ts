import { describe, expect, it, vi } from "vitest";
import { checkIfSdkNeedsToBeGenerated } from "../src/generate-sdk.ts";
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
});
