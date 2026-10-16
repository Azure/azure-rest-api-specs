import { describe, expect, it } from "vitest";
import { publishResultInComment } from "../../src/sdk-breaking-change/publish-result-in-comment.ts";
import {
  createMockContext,
  createMockCore,
  createMockGithub,
  createMockRequestError,
} from "../mocks.ts";

describe("publishResultInComment", () => {
  it("records the report commit for the Next Steps to Merge summary", async () => {
    const github = createMockGithub();
    const headSha = "a".repeat(40);
    await publishResultInComment(
      { github, context: createMockContext(), core: createMockCore() },
      42,
      "/azsdk sdk-breaking-analysis Go",
      "analysis report",
      headSha,
    );

    const { body } = github.rest.issues.createComment.mock.calls[0][0] as { body: string };
    expect(body).toContain(`<!-- sdk-breaking-change-head-sha: ${headSha} -->`);
  });

  it("rejects invalid report commit identifiers", async () => {
    const github = createMockGithub();
    await expect(
      publishResultInComment(
        { github, context: createMockContext(), core: createMockCore() },
        42,
        "/azsdk sdk-breaking-analysis Go",
        "analysis report",
        "invalid",
      ),
    ).rejects.toThrow("Invalid SDK breaking-change head SHA");
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("creates a comment with the command as the first line", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    github.rest.issues.createComment.mockResolvedValue({ data: { id: 10 } });

    await publishResultInComment(
      { github, context, core },
      42,
      "/azsdk sdk-breaking-analysis Go",
      "analysis report",
    );

    expect(github.rest.issues.createComment).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      issue_number: 42,
      body: [
        "/azsdk sdk-breaking-analysis Go",
        "",
        "analysis report",
        "<!-- /azsdk sdk-breaking-analysis Go -->",
      ].join("\n"),
    });
  });

  it("updates the newest matching comment", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    github.rest.issues.listComments.mockResolvedValue({
      data: [
        { id: 10, body: "/azsdk sdk-breaking-analysis go\n\nold" },
        { id: 20, body: "  /azsdk sdk-breaking-analysis Go\n\nnewer" },
        { id: 30, body: "/azsdk sdk-breaking-analysis Python" },
      ],
    });

    await publishResultInComment(
      { github, context, core },
      42,
      "/azsdk sdk-breaking-analysis Go",
      "analysis report",
    );

    expect(github.rest.issues.updateComment).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      comment_id: 20,
      body: [
        "/azsdk sdk-breaking-analysis Go",
        "",
        "analysis report",
        "<!-- /azsdk sdk-breaking-analysis Go -->",
      ].join("\n"),
    });
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("propagates an error when the matching comment cannot be edited", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ id: 10, body: "/azsdk sdk-breaking-analysis Go" }],
    });
    github.rest.issues.updateComment.mockRejectedValue(createMockRequestError(403));

    await expect(
      publishResultInComment(
        { github, context, core },
        42,
        "/azsdk sdk-breaking-analysis Go",
        "analysis report",
      ),
    ).rejects.toMatchObject({ status: 403 });

    expect(core.warning).not.toHaveBeenCalled();
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });
});
