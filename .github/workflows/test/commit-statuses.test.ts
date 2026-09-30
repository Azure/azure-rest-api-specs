import { describe, expect, it } from "vitest";
import { getLatestCommitStatuses } from "../src/commit-statuses.ts";
import { createMockGithub } from "./mocks.ts";

describe("getLatestCommitStatuses", () => {
  it("reads every page of latest contexts without loading status history", async () => {
    const github = createMockGithub();
    const firstPage = Array.from({ length: 100 }, (_, i) => ({
      context: `other-${i}`,
      state: "failure",
    }));
    const lastPage = [{ context: "Swagger Avocado", state: "success" }];
    github.rest.repos.getCombinedStatusForRef
      .mockResolvedValueOnce({ data: { statuses: firstPage, total_count: 101 } })
      .mockResolvedValueOnce({ data: { statuses: lastPage, total_count: 101 } });

    await expect(getLatestCommitStatuses(github, "owner", "repo", "sha")).resolves.toEqual([
      ...firstPage,
      ...lastPage,
    ]);
    expect(github.rest.repos.getCombinedStatusForRef).toHaveBeenCalledTimes(2);
    expect(github.rest.repos.getCombinedStatusForRef).toHaveBeenNthCalledWith(2, {
      owner: "owner",
      repo: "repo",
      ref: "sha",
      per_page: 100,
      page: 2,
    });
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
  });

  it("does not request another page when exactly 100 contexts are returned", async () => {
    const github = createMockGithub();
    const statuses = Array.from({ length: 100 }, (_, i) => ({
      context: `context-${i}`,
      state: "success",
    }));
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: { statuses, total_count: 100 },
    });
    await expect(getLatestCommitStatuses(github, "owner", "repo", "sha")).resolves.toEqual(
      statuses,
    );
    expect(github.rest.repos.getCombinedStatusForRef).toHaveBeenCalledTimes(1);
  });

  it("returns an empty list when no statuses exist", async () => {
    await expect(
      getLatestCommitStatuses(createMockGithub(), "owner", "repo", "sha"),
    ).resolves.toEqual([]);
  });

  it("does not treat incomplete results as missing checks", async () => {
    const github = createMockGithub();
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: { statuses: [], total_count: 1 },
    });
    await expect(getLatestCommitStatuses(github, "owner", "repo", "sha")).rejects.toThrow(
      "Incomplete commit statuses",
    );
  });

  it("propagates lookup failures", async () => {
    const github = createMockGithub();
    github.rest.repos.getCombinedStatusForRef.mockRejectedValue(new Error("rate limited"));
    await expect(getLatestCommitStatuses(github, "owner", "repo", "sha")).rejects.toThrow(
      "rate limited",
    );
  });
});
