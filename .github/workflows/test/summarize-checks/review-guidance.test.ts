import { describe, expect, it, vi } from "vitest";
import { getCodeOwnerReviewGuidance } from "../../src/codeowner-review.ts";
import { commentOrUpdate } from "../../src/comment.ts";
import { summarizeChecksImpl } from "../../src/summarize-checks/summarize-checks.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";

vi.mock("../../src/codeowner-review.ts", () => ({ getCodeOwnerReviewGuidance: vi.fn() }));
vi.mock("../../src/comment.ts", () => ({ commentOrUpdate: vi.fn() }));

describe("Next Steps to Merge review guidance", () => {
  it("shows informational ownership guidance without making it an automated approval decision", async () => {
    const github = createMockGithub();
    const core = createMockCore();
    core.summary.addLink = vi.fn().mockReturnValue(core.summary);
    core.summary.addHeading = vi.fn().mockReturnValue(core.summary);
    core.summary.addCodeBlock = vi.fn().mockReturnValue(core.summary);
    vi.mocked(getCodeOwnerReviewGuidance).mockResolvedValue(
      "> [!WARNING]\n> Repository-managed files need review.\n\nEngineering area: `eng/`.",
    );
    await summarizeChecksImpl(
      github,
      core,
      "Azure",
      "azure-rest-api-specs",
      1,
      "head-sha",
      "workflow_run",
      "main",
      "https://github.com/Azure/azure-rest-api-specs/actions/runs/1",
    );
    expect(commentOrUpdate).toHaveBeenCalledWith(
      github,
      core,
      "Azure",
      "azure-rest-api-specs",
      1,
      expect.stringContaining("## Protected files\n\n> [!WARNING]"),
      "NextStepsToMerge",
    );
    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("Engineering area: `eng/`"),
    );
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "pending", sha: "head-sha" }),
    );
  });

  it("does not add an ownership section for specification-only PRs", async () => {
    const github = createMockGithub();
    const core = createMockCore();
    core.summary.addLink = vi.fn().mockReturnValue(core.summary);
    core.summary.addHeading = vi.fn().mockReturnValue(core.summary);
    core.summary.addCodeBlock = vi.fn().mockReturnValue(core.summary);
    vi.mocked(getCodeOwnerReviewGuidance).mockResolvedValue(undefined);
    await summarizeChecksImpl(
      github,
      core,
      "Azure",
      "azure-rest-api-specs",
      1,
      "head-sha",
      "workflow_run",
      "main",
      "https://github.com/Azure/azure-rest-api-specs/actions/runs/1",
    );
    expect(commentOrUpdate).toHaveBeenLastCalledWith(
      github,
      core,
      "Azure",
      "azure-rest-api-specs",
      1,
      expect.not.stringContaining("## Protected files"),
      "NextStepsToMerge",
    );
  });
});
