import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.js";

vi.mock("../../src/context.js", () => ({
  extractInputs: vi.fn(),
}));

vi.mock("../../src/comment.js", () => ({
  commentOrUpdate: vi.fn(),
  parseExistingComments: vi.fn().mockReturnValue([undefined, undefined]),
}));

vi.mock("../../src/typespec-suppressions/suppressions-comment.js", () => ({
  buildSuppressionsComment: vi.fn(),
  TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER: "TypeSpecSuppressionsReview",
  TYPESPEC_SUPPRESSIONS_SECTION_TITLE: "TypeSpec suppressions requiring review",
}));

const { extractInputs } = await import("../../src/context.js");
const { commentOrUpdate, parseExistingComments } = await import("../../src/comment.js");
const { buildSuppressionsComment } =
  await import("../../src/typespec-suppressions/suppressions-comment.js");
const { default: postSuppressionsResults } =
  await import("../../src/typespec-suppressions/post-results.js");

describe("post-results", () => {
  const mockCore = createMockCore();
  const context = createMockContext();

  /**
   * @param {import("../mocks.js").GitHub} github
   * @returns {import("@actions/github-script").AsyncFunctionArguments}
   */
  function args(github) {
    return /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (
      /** @type {unknown} */ ({ github, context, core: mockCore })
    );
  }

  beforeEach(() => {
    vi.mocked(extractInputs).mockReset();
    vi.mocked(commentOrUpdate).mockReset();
    vi.mocked(parseExistingComments).mockReset();
    vi.mocked(buildSuppressionsComment).mockReset();

    vi.mocked(extractInputs).mockResolvedValue(
      /** @type {any} */ ({
        owner: "test-owner",
        repo: "test-repo",
        issue_number: 42,
        head_sha: "abc123",
        run_id: 1,
      }),
    );
    vi.mocked(parseExistingComments).mockReturnValue([undefined, undefined]);
  });

  /**
   * @param {string[]} labels
   * @returns {import("../mocks.js").GitHub}
   */
  function githubWithLabels(labels) {
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
