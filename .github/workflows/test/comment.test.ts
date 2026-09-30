import { describe, expect, it } from "vitest";
import { commentOrUpdate } from "../src/comment.ts";
import { createMockCore, createMockGithub } from "./mocks.ts";

describe("commentOrUpdate", () => {
  it("keeps exact comparison as the default for other callers", async () => {
    const github = createMockGithub();
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ id: 42, body: "Previous body\n<!-- marker -->" }],
    });

    await expect(
      commentOrUpdate(github, createMockCore(), "owner", "repo", 123, "New body", "marker"),
    ).resolves.toBe(42);

    expect(github.rest.issues.updateComment).toHaveBeenCalledExactlyOnceWith({
      owner: "owner",
      repo: "repo",
      comment_id: 42,
      body: "New body\n<!-- marker -->",
    });
  });

  it("does not rewrite identical comments without normalization", async () => {
    const github = createMockGithub();
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ id: 42, body: "Same body\n<!-- marker -->" }],
    });

    await expect(
      commentOrUpdate(github, createMockCore(), "owner", "repo", 123, "Same body", "marker"),
    ).resolves.toBe(42);

    expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it("returns the new comment's ID without another lookup", async () => {
    const github = createMockGithub();
    github.rest.issues.createComment.mockResolvedValue({ data: { id: 43 } });

    await expect(
      commentOrUpdate(github, createMockCore(), "owner", "repo", 123, "New body", "marker"),
    ).resolves.toBe(43);
    expect(github.rest.issues.listComments).toHaveBeenCalledTimes(1);
    expect(github.rest.issues.createComment).toHaveBeenCalledTimes(1);
  });
});
