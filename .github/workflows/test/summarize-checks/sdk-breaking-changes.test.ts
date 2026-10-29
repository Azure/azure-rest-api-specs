import { describe, expect, it, vi } from "vitest";
import type { IssueComment } from "../../src/comment.ts";
import {
  buildSdkBreakingChangesSummary,
  hasSdkBreakingChanges,
} from "../../src/summarize-checks/sdk-breaking-changes.ts";
import {
  createNextStepsComment,
  summarizeChecksImpl,
} from "../../src/summarize-checks/summarize-checks.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";

const headSha = "a".repeat(40);
const prUrl = "https://github.com/owner/repo/pull/42";
const workflowUrl = "https://github.com/owner/repo/actions/runs/123";

function report(
  id: number,
  stage: "analysis" | "mitigate",
  language: string,
  sha = headSha,
): IssueComment {
  const command = `/azsdk sdk-breaking-${stage} ${language}`;
  return {
    id,
    user: { login: "github-actions[bot]" },
    body: `${command}\n\nReport\n<!-- sdk-breaking-change-head-sha: ${sha} -->\n<!-- ${command} -->`,
  };
}

describe("SDK breaking-change summary", () => {
  it("omits the table when no SDK breaking-change labels are present", () => {
    const labels = ["BreakingChangeReviewRequired", "BreakingChange-Go-Sdk-Approved"];
    expect(hasSdkBreakingChanges(labels)).toBe(false);
    expect(
      buildSdkBreakingChangesSummary(labels, [report(1, "analysis", "Go")], headSha, prUrl),
    ).toBe("");
  });

  it("requires a breaking-change label without its matching approval label", () => {
    expect(hasSdkBreakingChanges(["BreakingChange-Go-Sdk"])).toBe(true);
    expect(hasSdkBreakingChanges(["BreakingChange-Go-Sdk", "BreakingChange-Go-Sdk-Approved"])).toBe(
      false,
    );
  });

  it.each([
    "BreakingChange-Go-Sdk",
    "BreakingChange-Java-Sdk",
    "BreakingChange-JavaScript-Sdk",
    "BreakingChange-Python-Sdk",
  ])("omits approved breaking changes for %s", (label) => {
    expect(buildSdkBreakingChangesSummary([label, `${label}-Approved`], [], headSha, prUrl)).toBe(
      "",
    );
  });

  it("renders only languages with unapproved breaking changes", () => {
    const labels = [
      "BreakingChange-Go-Sdk",
      "BreakingChange-Go-Sdk-Approved",
      "BreakingChange-Python-Sdk",
    ];
    const summary = buildSdkBreakingChangesSummary(
      labels,
      [report(1, "analysis", "Go"), report(2, "mitigate", "Go"), report(3, "analysis", "Python")],
      headSha,
      prUrl,
    );

    expect(hasSdkBreakingChanges(labels)).toBe(true);
    expect(summary.split("\n").filter((line) => line.startsWith("| "))).toHaveLength(3);
    expect(summary).not.toContain("| Go |");
    expect(summary).toContain("| Python | Breaking changes detected |");
    expect(summary).not.toContain(`href="${prUrl}#issuecomment-1"`);
    expect(summary).not.toContain(`href="${prUrl}#issuecomment-2"`);
    expect(summary).toContain(`href="${prUrl}#issuecomment-3"`);
    expect(summary).toContain(
      "[suppression process](https://github.com/Azure/azure-rest-api-specs/wiki/SDK-Breaking-Changes#how-to-suppress-the-sdk-breaking-changes)",
    );
    expect(summary).toContain("Review the analysis and mitigation guidance.");
    expect(summary).not.toContain("| Java |");
  });

  it.each([
    ["BreakingChange-Go-Sdk", "Go"],
    ["BreakingChange-Java-Sdk", "Java"],
    ["BreakingChange-JavaScript-Sdk", "JavaScript"],
    ["BreakingChange-Python-Sdk", "Python"],
  ])("links reports for %s", (label, language) => {
    const summary = buildSdkBreakingChangesSummary(
      [label],
      [report(1, "analysis", language)],
      headSha,
      prUrl,
    );
    expect(hasSdkBreakingChanges([label])).toBe(true);
    expect(summary).toContain(`| ${language} |`);
    expect(summary).toContain(`href="${prUrl}#issuecomment-1"`);
  });

  it.each(["BreakingChange-.Net-Sdk", "BreakingChange-Rust-Sdk"])(
    "omits %s when it is not configured in the workflow SDK labels",
    (label) => {
      expect(hasSdkBreakingChanges([label])).toBe(false);
      expect(buildSdkBreakingChangesSummary([label], [], headSha, prUrl)).toBe("");
    },
  );

  it("does not present stale, unversioned or user-authored reports as current", () => {
    const unversioned = report(2, "analysis", "Go");
    unversioned.body = "/azsdk sdk-breaking-analysis Go\n\nold report";
    const untrusted = report(3, "mitigate", "Go");
    untrusted.user = { login: "contributor" };
    const summary = buildSdkBreakingChangesSummary(
      ["BreakingChange-Go-Sdk"],
      [report(1, "analysis", "Go", "b".repeat(40)), unversioned, untrusted],
      headSha,
      prUrl,
    );
    expect(summary).not.toContain("#issuecomment-");
    expect(summary).toContain("| Not available for this commit | Not available for this commit |");
    expect(summary).toContain("analysis is not yet available for this commit");
  });

  it("selects the latest matching report and never treats mitigation as approval", () => {
    const summary = buildSdkBreakingChangesSummary(
      ["BreakingChange-Go-Sdk"],
      [report(1, "mitigate", "Go"), report(2, "mitigate", "Go")],
      headSha,
      prUrl,
    );
    expect(summary).not.toContain("#issuecomment-1");
    expect(summary).toContain("#issuecomment-2");
    expect(summary).toContain("| Go | Breaking changes detected |");
    expect(summary).toContain(
      "For accepted breaking changes, follow the [suppression process](https://github.com/Azure/azure-rest-api-specs/wiki/SDK-Breaking-Changes#how-to-suppress-the-sdk-breaking-changes) to suppress them.",
    );
    expect(summary).toContain("apply any proposed customizations, then rerun SDK validation");
    expect(summary).toContain(
      "<p>💡 Mitigation reports contain proposed changes; they do not mean those changes have been applied or validated.</p>",
    );
    expect(summary).toContain(
      "<p>💡 When suppressing breaking changes, ensure to use the original breaking changes.</p>",
    );
  });

  it("includes the table even when higher-priority blockers are displayed, without changing merge gates", () => {
    const core = createMockCore();
    const labels = ["BreakingChange-Go-Sdk", "package-name-review-required"];
    const summary = buildSdkBreakingChangesSummary(labels, [], headSha, prUrl);
    const args: Parameters<typeof createNextStepsComment> = [
      core,
      "repo",
      labels,
      "main",
      [],
      [],
      true,
      workflowUrl,
    ];
    const [withoutTable, originalStatus] = createNextStepsComment(...args);
    const [withTable, status] = createNextStepsComment(
      core,
      "repo",
      labels,
      "main",
      [],
      [],
      true,
      workflowUrl,
      summary,
    );
    const tableHeader = "| Language | Status | Analysis | Mitigation | Next action |";
    expect(withoutTable).not.toContain(tableHeader);
    expect(withTable).toContain(summary);
    expect(withTable).toContain(`</h3>\n\n${tableHeader}\n| --- | --- | --- | --- | --- |\n`);
    expect(withTable).toContain("</p>\n\n<br /><br />Comment generated by");
    expect(withTable).toContain("Package Name Review Required");
    expect(status).toEqual(originalStatus);
    expect(status.result).toBe("FAILURE");
  });

  it.each([false, true])(
    "publishes the summary with existing comments (breaking changes: %s)",
    async (detected) => {
      const github = createMockGithub();
      const core = createMockCore();
      core.summary.addLink = vi.fn().mockReturnValue(core.summary);
      core.summary.addHeading = vi.fn().mockReturnValue(core.summary);
      core.summary.addCodeBlock = vi.fn().mockReturnValue(core.summary);
      github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: headSha } } });
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: detected ? [{ name: "BreakingChange-Go-Sdk" }] : [],
      });
      github.rest.issues.listComments.mockResolvedValue({
        data: [
          report(1, "analysis", "Go"),
          {
            id: 99,
            body: "<h2>Next Steps to Merge</h2><table>Old summary</table>\n<!-- NextStepsToMerge -->",
          },
        ],
      });

      await summarizeChecksImpl(
        github,
        core,
        "owner",
        "repo",
        42,
        headSha,
        "workflow_run",
        "main",
        workflowUrl,
      );

      expect(github.rest.issues.listComments).toHaveBeenCalled();
      expect(github.rest.pulls.get).toHaveBeenCalledTimes(detected ? 1 : 0);
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
      const { body, comment_id } = github.rest.issues.updateComment.mock.calls[0][0] as {
        body: string;
        comment_id: number;
      };
      expect(comment_id).toBe(99);
      if (detected) {
        expect(body).toContain("<h3>SDK Breaking Change Detection and Mitigation</h3>");
        expect(body).toContain(`href="${prUrl}#issuecomment-1"`);
      } else {
        expect(body).not.toContain("<table>");
      }
    },
  );

  it("skips the stale SDK summary but continues publishing other checks", async () => {
    const github = createMockGithub();
    const core = createMockCore();
    core.summary.addLink = vi.fn().mockReturnValue(core.summary);
    core.summary.addHeading = vi.fn().mockReturnValue(core.summary);
    core.summary.addCodeBlock = vi.fn().mockReturnValue(core.summary);
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "BreakingChange-Go-Sdk" }],
    });
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "b".repeat(40) } } });
    github.rest.issues.listComments.mockResolvedValue({
      data: [
        report(1, "analysis", "Go"),
        {
          id: 99,
          body: "<h2>Next Steps to Merge</h2><table>Old summary</table>\n<!-- NextStepsToMerge -->",
        },
      ],
    });

    await summarizeChecksImpl(
      github,
      core,
      "owner",
      "repo",
      42,
      headSha,
      "workflow_run",
      "main",
      workflowUrl,
    );

    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining("stale commit"));
    expect(github.rest.issues.listComments).toHaveBeenCalledTimes(1);
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(github.rest.issues.updateComment).toHaveBeenCalledTimes(1);
    expect(github.rest.issues.updateComment.mock.calls[0][0]).toMatchObject({
      owner: "owner",
      repo: "repo",
      comment_id: 99,
    });
    const { body } = github.rest.issues.updateComment.mock.calls[0][0] as { body: string };
    expect(body).toContain("<h2>Next Steps to Merge</h2>");
    expect(body).not.toContain("SDK Breaking Change Detection and Mitigation");
    expect(body).not.toContain("#issuecomment-1");
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ sha: headSha }),
    );
  });
});
