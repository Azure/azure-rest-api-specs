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
  TYPESPEC_SUPPRESSIONS_SECTION_TITLE:
    "TypeSpec suppressions requiring review (testing, non-blocking)",
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
    vi.mocked(buildSuppressionsComment).mockResolvedValue("BODY: suppressions requiring review");

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

  it("passes the current PR labels through for approval state", async () => {
    const github = githubWithLabels(["Approved-TypeSpecSuppression", "other"]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue("BODY");

    await postSuppressionsResults(args(github));

    expect(buildSuppressionsComment).toHaveBeenCalledWith(
      github,
      mockCore,
      "test-owner",
      "test-repo",
      "abc123",
      42,
      ["Approved-TypeSpecSuppression", "other"],
    );
  });

  it("resolves an existing comment when nothing requires review", async () => {
    const github = githubWithLabels([]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue(undefined);
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
    vi.mocked(buildSuppressionsComment).mockResolvedValue(undefined);
    vi.mocked(parseExistingComments).mockReturnValue([undefined, undefined]);

    await postSuppressionsResults(args(github));

    expect(commentOrUpdate).not.toHaveBeenCalled();
  });
});
