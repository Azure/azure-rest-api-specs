import { afterEach, describe, expect, it, vi } from "vitest";
import { getPrStatus, parseCliArguments } from "../src/generate-sdk.ts";
import type { OctokitLike } from "../src/types.ts";

function createOctokitMock(getImpl: ReturnType<typeof vi.fn>): OctokitLike {
  return {
    rest: {
      pulls: {
        get: getImpl,
        listFiles: vi.fn(),
      },
    },
  } as unknown as OctokitLike;
}

afterEach(() => {
  vi.unstubAllEnvs();
});

describe("parseCliArguments", () => {
  it("parses required artifact file without azsdk-path option", () => {
    const result = parseCliArguments(["--artifact-file", "artifact.json"]);

    expect(result.artifactFile).toMatch(/artifact\.json$/);
  });

  it("rejects the removed --azsdk-path option", () => {
    expect(() =>
      parseCliArguments(["--artifact-file", "artifact.json", "--azsdk-path", "/tools/azsdk"]),
    ).toThrow(/Unknown option '--azsdk-path'/);
  });
});

describe("getPrStatus", () => {
  it("returns invalid for non-GitHub PR URL", async () => {
    const octokit = createOctokitMock(vi.fn());

    const result = await getPrStatus("https://example.com/not-a-pr", octokit);

    expect(result).toEqual({
      isValid: false,
      isMerged: false,
      isOpen: false,
      state: "Unknown",
    });
  });

  it("returns open status for open PR", async () => {
    const get = vi.fn().mockResolvedValue({
      data: {
        state: "open",
        merged_at: null,
      },
    });
    const octokit = createOctokitMock(get);

    const result = await getPrStatus(
      "https://github.com/Azure/azure-rest-api-specs/pull/12345",
      octokit,
    );

    expect(get).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      pull_number: 12345,
    });
    expect(result).toEqual({
      isValid: true,
      isMerged: false,
      isOpen: true,
      state: "OPEN",
    });
  });

  it("returns merged status when merged_at is present", async () => {
    const get = vi.fn().mockResolvedValue({
      data: {
        state: "closed",
        merged_at: "2026-07-10T00:00:00Z",
      },
    });
    const octokit = createOctokitMock(get);

    const result = await getPrStatus(
      "https://github.com/Azure/azure-rest-api-specs/pull/67890",
      octokit,
    );

    expect(result).toEqual({
      isValid: true,
      isMerged: true,
      isOpen: false,
      state: "CLOSED",
    });
  });

  it("returns invalid when Octokit call throws", async () => {
    const get = vi.fn().mockRejectedValue(new Error("API failure"));
    const octokit = createOctokitMock(get);

    const result = await getPrStatus(
      "https://github.com/Azure/azure-rest-api-specs/pull/42",
      octokit,
    );

    expect(result).toEqual({
      isValid: false,
      isMerged: false,
      isOpen: false,
      state: "Unknown",
    });
  });
});
