import { describe, expect, it } from "vitest";
import {
  isLatestArmReviewRun,
  parseArmReviewRunUrl,
} from "../../src/arm-auto-signoff/arm-review-run.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";

describe("review run freshness", () => {
  it.each([
    undefined,
    "https://example.com/Azure/specs/actions/runs/1/attempts/1",
    "https://github.com/Azure/other/actions/runs/1/attempts/1",
    "https://github.com/Azure/specs/actions/runs/1",
    "https://github.com/Azure/specs/actions/runs/1/attempts/0",
  ])("does not accept an unbound status URL %s", (url) => {
    expect(parseArmReviewRunUrl(url, "Azure", "specs")).toBeUndefined();
  });

  it("parses only exact repository/run/attempt URLs", () => {
    expect(
      parseArmReviewRunUrl(
        "https://github.com/Azure/specs/actions/runs/123/attempts/2",
        "Azure",
        "specs",
      ),
    ).toEqual({ runId: 123, runAttempt: 2 });
  });

  it("paginates past unrelated PR runs to find a newer same-PR review", async () => {
    const github = createMockGithub();
    github.rest.actions.getWorkflowRun.mockResolvedValue({
      data: {
        path: ".github/workflows/arm-api-review.lock.yml",
        event: "workflow_dispatch",
        run_attempt: 1,
        run_number: 10,
        status: "completed",
        conclusion: "success",
      },
    });
    github.rest.actions.listWorkflowRuns
      .mockResolvedValueOnce({
        data: {
          workflow_runs: Array.from({ length: 100 }, (_, i) => ({
            run_number: 200 - i,
            display_title: "ARM API Review #999 (workflow_dispatch)",
            conclusion: "success",
          })),
        },
      })
      .mockResolvedValueOnce({
        data: {
          workflow_runs: [
            {
              run_number: 11,
              display_title: "ARM API Review #123 (issue_comment)",
              conclusion: null,
            },
          ],
        },
      });
    expect(
      await isLatestArmReviewRun({
        github,
        core: createMockCore(),
        owner: "Azure",
        repo: "specs",
        issueNumber: 123,
        runId: 1,
        runAttempt: 1,
        headSha: "a".repeat(40),
      }),
    ).toBe(false);
    expect(github.rest.actions.listWorkflowRuns).toHaveBeenCalledTimes(2);
    expect(github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
  });
});
