import { strToU8, zipSync } from "fflate";
import { describe, expect, it } from "vitest";
import { getCheckRunTuple } from "../../src/summarize-checks/summarize-checks.ts";
import { getSummaryData } from "../../src/summarize-checks/summary-data.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";
import { checkRun, page, statusContext, summaryResponse } from "./summary-data-fixtures.ts";

describe("getSummaryData", () => {
  it("restarts the snapshot for the current head when an event was queued for an older commit", async () => {
    const github = createMockGithub();
    github.graphql
      .mockResolvedValueOnce(
        summaryResponse({
          headSha: "current",
          labels: [{ name: "old-label" }],
          contexts: [checkRun({ name: "old-check" })],
        }),
      )
      .mockResolvedValueOnce(
        summaryResponse({
          headSha: "current",
          targetBranch: "release",
          labels: [{ name: "current-label" }],
          contexts: [checkRun({ name: "current-check" })],
        }),
      );

    const data = await getSummaryData(github, "owner", "repo", 123, "old");

    expect(data.headSha).toBe("current");
    expect(data.targetBranch).toBe("release");
    expect(data.labels).toEqual(["current-label"]);
    expect(data.checkRuns.map((check) => check.name)).toEqual(["current-check"]);
    expect(github.graphql).toHaveBeenCalledTimes(2);
    expect(github.graphql).toHaveBeenNthCalledWith(
      2,
      expect.any(String),
      expect.objectContaining({
        sha: "current",
        labelsCursor: null,
        commentsCursor: null,
        checksCursor: null,
      }),
    );
  });

  it("discards already collected pages if the head changes during pagination", async () => {
    const github = createMockGithub();
    const first = summaryResponse({ labels: [{ name: "old-label" }], contexts: [checkRun()] });
    first.repository.pullRequest.labels.pageInfo = { hasNextPage: true, endCursor: "old-cursor" };
    const current = summaryResponse({ headSha: "current", labels: [{ name: "current-label" }] });
    github.graphql
      .mockResolvedValueOnce(first)
      .mockResolvedValueOnce(current)
      .mockResolvedValueOnce(current);

    const data = await getSummaryData(github, "owner", "repo", 123, "sha");

    expect(data.labels).toEqual(["current-label"]);
    expect(data.checkRuns).toEqual([]);
    expect(github.graphql).toHaveBeenNthCalledWith(
      3,
      expect.any(String),
      expect.objectContaining({
        sha: "current",
        includeLabels: true,
        includeComments: true,
        includeChecks: true,
        labelsCursor: null,
        commentsCursor: null,
        checksCursor: null,
      }),
    );
  });

  it("fails rather than publishing mixed heads if the PR keeps changing", async () => {
    const github = createMockGithub();
    github.graphql
      .mockResolvedValueOnce(summaryResponse({ headSha: "new" }))
      .mockResolvedValueOnce(summaryResponse({ headSha: "newer" }));
    await expect(getSummaryData(github, "owner", "repo", 123, "old")).rejects.toThrow(
      "PR head changed while reading",
    );
    expect(github.graphql).toHaveBeenCalledTimes(2);
  });

  it("loads labels, comments, checks, latest statuses and workflow identity in one query", async () => {
    const github = createMockGithub();
    github.graphql.mockResolvedValue(
      summaryResponse({
        labels: [{ name: "ARMReview" }],
        comments: [{ databaseId: 42, body: "Existing comment" }],
        contexts: [checkRun(), statusContext()],
      }),
    );

    await expect(getSummaryData(github, "owner", "repo", 123, "sha")).resolves.toEqual({
      headSha: "sha",
      targetBranch: "main",
      labels: ["ARMReview"],
      comments: [{ id: 42, body: "Existing comment" }],
      checkRuns: [
        {
          name: "TypeSpec Validation",
          status: "completed",
          conclusion: "success",
          started_at: "2026-09-30T00:00:00Z",
          completed_at: "2026-09-30T00:01:00Z",
          workflowRunId: 91001,
        },
      ],
      statuses: [
        {
          context: "SDK Validation Status",
          state: "pending",
          description: "Waiting",
          target_url: null,
          updated_at: "2026-09-30T00:00:00Z",
        },
      ],
    });
    expect(github.graphql).toHaveBeenCalledExactlyOnceWith(expect.any(String), {
      owner: "owner",
      repo: "repo",
      number: 123,
      sha: "sha",
      pageSize: 100,
      labelsCursor: null,
      commentsCursor: null,
      checksCursor: null,
      includeLabels: true,
      includeComments: true,
      includeChecks: true,
    });
    expect(github.rest.checks.listForRef).not.toHaveBeenCalled();
    expect(github.rest.issues.listLabelsOnIssue).not.toHaveBeenCalled();
    expect(github.rest.issues.listComments).not.toHaveBeenCalled();
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
    expect(github.rest.actions.listWorkflowRunsForRepo).not.toHaveBeenCalled();
  });

  it("paginates each connection independently without dropping or duplicating results", async () => {
    const github = createMockGithub();
    const first = summaryResponse({ labels: [{ name: "ARMReview" }] });
    first.repository.pullRequest.labels.pageInfo = { hasNextPage: true, endCursor: "labels-1" };
    first.repository.pullRequest.comments = page(
      [{ databaseId: 1, body: "first" }],
      true,
      "comments-1",
    );
    first.repository.object.statusCheckRollup.contexts = page([checkRun()], true, "checks-1");
    const second = summaryResponse({
      labels: [{ name: "Approved-Suppression" }],
      comments: [{ databaseId: 2, body: "second" }],
    });
    second.repository.object.statusCheckRollup.contexts = page([statusContext()], true, "checks-2");
    const third = summaryResponse({
      // Completed connections must not be collected again.
      labels: [{ name: "duplicate" }],
      comments: [{ databaseId: 2, body: "duplicate" }],
      contexts: [
        checkRun({ name: "external", status: "IN_PROGRESS", conclusion: null, checkSuite: null }),
      ],
    });
    github.graphql
      .mockResolvedValueOnce(first)
      .mockResolvedValueOnce(second)
      .mockResolvedValueOnce(third);

    const result = await getSummaryData(github, "owner", "repo", 123, "sha");

    expect(result.labels).toEqual(["ARMReview", "Approved-Suppression"]);
    expect(result.comments.map((c) => c.id)).toEqual([1, 2]);
    expect(result.checkRuns.map((c) => c.name)).toEqual(["TypeSpec Validation", "external"]);
    expect(result.checkRuns[1]).toMatchObject({
      status: "in_progress",
      conclusion: null,
      workflowRunId: undefined,
    });
    expect(result.statuses).toHaveLength(1);
    expect(github.graphql).toHaveBeenCalledTimes(3);
    expect(github.graphql).toHaveBeenNthCalledWith(
      2,
      expect.any(String),
      expect.objectContaining({
        labelsCursor: "labels-1",
        commentsCursor: "comments-1",
        checksCursor: "checks-1",
        includeLabels: true,
        includeComments: true,
        includeChecks: true,
      }),
    );
    expect(github.graphql).toHaveBeenNthCalledWith(
      3,
      expect.any(String),
      expect.objectContaining({
        checksCursor: "checks-2",
        includeLabels: false,
        includeComments: false,
        includeChecks: true,
      }),
    );
  });

  it("supports a commit with no checks or statuses", async () => {
    const response = summaryResponse();
    const github = createMockGithub();
    github.graphql.mockResolvedValue({
      repository: {
        ...response.repository,
        object: { __typename: "Commit", statusCheckRollup: null },
      },
    });
    await expect(getSummaryData(github, "owner", "repo", 123, "sha")).resolves.toEqual({
      headSha: "sha",
      targetBranch: "main",
      labels: [],
      comments: [],
      checkRuns: [],
      statuses: [],
    });
    expect(github.graphql).toHaveBeenCalledTimes(1);
  });

  it.each([
    { repository: null },
    { repository: { pullRequest: null, object: { __typename: "Commit" } } },
    { repository: { pullRequest: {}, object: null } },
    { repository: { pullRequest: {}, object: { __typename: "Tag" } } },
  ])("rejects unavailable PR or commit data (%j)", async (response) => {
    const github = createMockGithub();
    github.graphql.mockResolvedValue(response);
    await expect(getSummaryData(github, "owner", "repo", 123, "sha")).rejects.toThrow(
      "Unable to load check summary",
    );
  });

  it.each([null, page([null])])("rejects incomplete connections (%j)", async (labels) => {
    const response = summaryResponse();
    const github = createMockGithub();
    github.graphql.mockResolvedValue({
      repository: {
        ...response.repository,
        pullRequest: { ...response.repository.pullRequest, labels },
      },
    });
    await expect(getSummaryData(github, "owner", "repo", 123, "sha")).rejects.toThrow(
      /check-summary connection/,
    );
  });

  it("rejects pagination that does not advance", async () => {
    const response = summaryResponse({ labels: [{ name: "ARMReview" }] });
    response.repository.pullRequest.labels.pageInfo = { hasNextPage: true, endCursor: "same" };
    const github = createMockGithub();
    github.graphql.mockResolvedValue(response);
    await expect(getSummaryData(github, "owner", "repo", 123, "sha")).rejects.toThrow(
      "pagination did not advance",
    );
    expect(github.graphql).toHaveBeenCalledTimes(2);
  });

  it("does not treat GraphQL errors as empty results", async () => {
    const github = createMockGithub();
    github.graphql.mockRejectedValue(new Error("Resource not accessible by integration"));
    await expect(getSummaryData(github, "owner", "repo", 123, "sha")).rejects.toThrow(
      "Resource not accessible by integration",
    );
  });

  it("rejects comments without an ID usable by REST writes", async () => {
    const github = createMockGithub();
    github.graphql.mockResolvedValue(
      summaryResponse({ comments: [{ databaseId: null, body: "comment" }] }),
    );
    await expect(getSummaryData(github, "owner", "repo", 123, "sha")).rejects.toThrow(
      "no REST database ID",
    );
  });
});

describe("GraphQL check selection", () => {
  it("uses the selected impact run directly and preserves required/FYI check selection", async () => {
    const github = createMockGithub();
    github.graphql.mockResolvedValue(
      summaryResponse({
        contexts: [
          checkRun({ name: "Summarize PR Impact" }),
          checkRun({ name: "TypeSpec Validation" }),
          statusContext({ context: "Swagger LintDiff", state: "FAILURE" }),
          statusContext({
            context: "Automated merging requirements met",
            state: "PENDING",
          }),
        ],
      }),
    );
    const impact = {
      resourceManagerRequired: false,
      dataPlaneRequired: false,
      suppressionReviewRequired: false,
      isNewApiVersion: false,
      rpaasRpNotInPrivateRepo: false,
      rpaasChange: false,
      newRP: false,
      rpaasRPMissing: false,
      typeSpecChanged: true,
      isDraft: false,
      targetBranch: "main",
    };
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [{ id: 42, name: "job-summary" }] },
    });
    github.rest.actions.downloadArtifact.mockResolvedValue({
      data: Buffer.from(zipSync({ "summary.json": strToU8(JSON.stringify(impact)) })),
    });
    github.rest.repos.getBranchRules.mockResolvedValue({
      data: [
        {
          type: "required_status_checks",
          parameters: {
            required_status_checks: [
              { context: "TypeSpec Validation" },
              { context: "Automated merging requirements met" },
            ],
          },
        },
      ],
    });
    const data = await getSummaryData(github, "owner", "repo", 123, "sha");

    const [required, fyi, assessment, existing] = await getCheckRunTuple(
      github,
      createMockCore(),
      "owner",
      "repo",
      data,
      [],
    );

    expect(required.map((c) => c.name)).toEqual(["TypeSpec Validation"]);
    expect(fyi.map((c) => [c.name, c.conclusion])).toEqual([["Swagger LintDiff", "failure"]]);
    expect(assessment).toEqual(impact);
    expect(existing?.state).toBe("pending");
    expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledWith(
      expect.objectContaining({ run_id: 91001 }),
    );
    expect(github.rest.actions.listWorkflowRunsForRepo).not.toHaveBeenCalled();
  });

  it("does not load an older successful impact when a newer check is pending", async () => {
    const github = createMockGithub();
    github.graphql.mockResolvedValue(
      summaryResponse({
        contexts: [
          checkRun({ name: "Summarize PR Impact" }),
          checkRun({
            name: "Summarize PR Impact",
            status: "IN_PROGRESS",
            conclusion: null,
            startedAt: "2026-09-30T00:02:00Z",
            completedAt: null,
          }),
        ],
      }),
    );
    const data = await getSummaryData(github, "owner", "repo", 123, "sha");
    const [required, , impact] = await getCheckRunTuple(
      github,
      createMockCore(),
      "owner",
      "repo",
      data,
      [],
    );
    expect(required).toMatchObject([{ name: "Summarize PR Impact", status: "in_progress" }]);
    expect(impact).toBeUndefined();
    expect(github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
  });

  it("does not guess a workflow when a successful impact check has no workflow identity", async () => {
    const github = createMockGithub();
    github.graphql.mockResolvedValue(
      summaryResponse({
        contexts: [checkRun({ name: "Summarize PR Impact", checkSuite: null })],
      }),
    );
    const core = createMockCore();
    const data = await getSummaryData(github, "owner", "repo", 123, "sha");
    const [, , impact] = await getCheckRunTuple(github, core, "owner", "repo", data, []);
    expect(impact).toBeUndefined();
    expect(core.warning).toHaveBeenCalledWith(
      "No workflow run found for the completed impact assessment check",
    );
    expect(github.rest.actions.listWorkflowRunsForRepo).not.toHaveBeenCalled();
  });
});
