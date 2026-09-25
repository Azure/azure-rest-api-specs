import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

vi.mock("../../src/context.ts", () => ({
  extractInputs: vi.fn(),
}));

vi.mock("../../src/comment.ts", () => ({
  commentOrUpdate: vi.fn(),
  parseExistingComments: vi.fn().mockReturnValue([undefined, undefined]),
}));

vi.mock("../../src/typespec-suppressions/suppressions-comment.ts", () => ({
  buildSuppressionsComment: vi.fn(),
  TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER: "TypeSpecSuppressionsReview",
  TYPESPEC_SUPPRESSIONS_SECTION_TITLE: "TypeSpec suppressions requiring review",
}));

const { extractInputs } = await import("../../src/context.ts");
const { commentOrUpdate, parseExistingComments } = await import("../../src/comment.ts");
const { buildSuppressionsComment } =
  await import("../../src/typespec-suppressions/suppressions-comment.ts");
const { default: postSuppressionsResults } =
  await import("../../src/typespec-suppressions/post-results.ts");

describe("post-results", () => {
  const mockCore = createMockCore();
  const context = createMockContext();

  function args(
    github: import("../mocks.ts").GitHub,
  ): import("@actions/github-script").AsyncFunctionArguments {
    return {
      github,
      context,
      core: mockCore,
    } as unknown as import("@actions/github-script").AsyncFunctionArguments;
  }

  beforeEach(() => {
    context.eventName = "";
    vi.mocked(extractInputs).mockReset();
    vi.mocked(commentOrUpdate).mockReset();
    vi.mocked(parseExistingComments).mockReset();
    vi.mocked(buildSuppressionsComment).mockReset();

    vi.mocked(extractInputs).mockResolvedValue({
      owner: "test-owner",
      repo: "test-repo",
      issue_number: 42,
      head_sha: "abc123",
      run_id: 1,
    });
    vi.mocked(parseExistingComments).mockReturnValue([undefined, undefined]);
  });

  function githubWithLabels(labels: string[]): import("../mocks.ts").GitHub {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: { labels: labels.map((name) => ({ name })) },
    });
    return github;
  }

  it("posts the sticky comment when suppressions require review", async () => {
    const github = githubWithLabels([]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({
      body: "BODY: suppressions requiring review",
      requiresApproval: true,
    });

    await postSuppressionsResults(args(github));

    expect(buildSuppressionsComment).toHaveBeenCalledWith(
      github,
      mockCore,
      "test-owner",
      "test-repo",
      "abc123",
      42,
      [],
    );
    expect(commentOrUpdate).toHaveBeenCalledWith(
      github,
      mockCore,
      "test-owner",
      "test-repo",
      42,
      "BODY: suppressions requiring review",
      "TypeSpecSuppressionsReview",
    );
  });

  it("applies the typespec-suppressions-review-required label when requiresApproval is true and label is absent", async () => {
    const github = githubWithLabels([]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({
      body: "BODY",
      requiresApproval: true,
    });

    await postSuppressionsResults(args(github));

    expect(github.rest.issues.addLabels).toHaveBeenCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      issue_number: 42,
      labels: ["typespec-suppressions-review-required"],
    });
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("does not re-apply the typespec-suppressions-review-required label when already present", async () => {
    const github = githubWithLabels(["typespec-suppressions-review-required"]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({
      body: "BODY",
      requiresApproval: true,
    });

    await postSuppressionsResults(args(github));

    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("removes the typespec-suppressions-review-required label when requiresApproval becomes false", async () => {
    const github = githubWithLabels(["typespec-suppressions-review-required"]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({
      body: undefined,
      requiresApproval: false,
    });

    await postSuppressionsResults(args(github));

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      issue_number: 42,
      name: "typespec-suppressions-review-required",
    });
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it("does not touch labels when the analysis result is unavailable", async () => {
    context.eventName = "workflow_run";
    const github = githubWithLabels(["typespec-suppressions-approved"]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue(undefined);

    await postSuppressionsResults(args(github));

    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    expect(commentOrUpdate).not.toHaveBeenCalled();
  });

  it("passes the current PR labels through for approval state", async () => {
    const github = githubWithLabels(["typespec-suppressions-approved", "other"]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({ body: "BODY", requiresApproval: true });

    await postSuppressionsResults(args(github));

    expect(buildSuppressionsComment).toHaveBeenCalledWith(
      github,
      mockCore,
      "test-owner",
      "test-repo",
      "abc123",
      42,
      ["typespec-suppressions-approved", "other"],
    );
  });

  it("clears approval and renders a new analysis result as pending", async () => {
    context.eventName = "workflow_run";
    const github = githubWithLabels(["typespec-suppressions-approved", "other"]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({ body: "BODY", requiresApproval: true });

    await postSuppressionsResults(args(github));

    expect(buildSuppressionsComment).toHaveBeenCalledWith(
      github,
      mockCore,
      "test-owner",
      "test-repo",
      "abc123",
      42,
      ["other"],
    );
    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      issue_number: 42,
      name: "typespec-suppressions-approved",
    });
  });

  it("preserves approval when refreshing after a label event", async () => {
    context.eventName = "pull_request_target";
    const github = githubWithLabels(["typespec-suppressions-approved"]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({ body: "BODY", requiresApproval: true });

    await postSuppressionsResults(args(github));

    expect(buildSuppressionsComment).toHaveBeenCalledWith(
      github,
      mockCore,
      "test-owner",
      "test-repo",
      "abc123",
      42,
      ["typespec-suppressions-approved"],
    );
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("resolves an existing comment when nothing requires review", async () => {
    const github = githubWithLabels([]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({
      body: undefined,
      requiresApproval: false,
    });
    vi.mocked(parseExistingComments).mockReturnValue([99, "previous body"]);

    await postSuppressionsResults(args(github));

    expect(commentOrUpdate).toHaveBeenCalledTimes(1);
    const call = vi.mocked(commentOrUpdate).mock.calls[0];
    expect(call[4]).toBe(42);
    expect(call[5]).toContain("No TypeSpec suppressions require review");
    expect(call[6]).toBe("TypeSpecSuppressionsReview");
  });

  it("does nothing when nothing requires review and no prior comment exists", async () => {
    const github = githubWithLabels([]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue({
      body: undefined,
      requiresApproval: false,
    });
    vi.mocked(parseExistingComments).mockReturnValue([undefined, undefined]);

    await postSuppressionsResults(args(github));

    expect(commentOrUpdate).not.toHaveBeenCalled();
  });
});
