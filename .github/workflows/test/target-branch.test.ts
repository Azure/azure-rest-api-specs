import { describe, expect, it, vi } from "vitest";
import type { RestEndpointMethodTypes } from "../src/github.ts";
import { checkTargetBranch } from "../src/target-branch.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const marker = "<!-- target-branch -->";
type CheckParameters = RestEndpointMethodTypes["checks"]["create"]["parameters"];
type CommentParameters = RestEndpointMethodTypes["issues"]["createComment"]["parameters"];

function setup(base = "main") {
  const github = createMockGithub();
  const context = createMockContext();
  context.eventName = "pull_request_target";
  context.repo = { owner: "Azure", repo: "azure-rest-api-specs-pr" };
  context.payload = {
    pull_request: { number: 1, base: { ref: "main" }, head: { sha: "a".repeat(40) } },
  };
  const core = createMockCore();
  const createCheck = vi
    .fn<(params: CheckParameters) => Promise<void>>()
    .mockResolvedValue(undefined);
  const createComment = vi
    .fn<(params: CommentParameters) => Promise<void>>()
    .mockResolvedValue(undefined);
  Object.assign(github.rest.checks, { create: createCheck });
  Object.assign(github.rest.issues, { createComment });
  github.rest.pulls.get.mockResolvedValue({
    data: { number: 1, state: "open", base: { ref: base }, head: { sha: "b".repeat(40) } },
  });
  const run = () => checkTargetBranch({ github, context, core });
  return { github, context, core, createCheck, createComment, run };
}

describe("target branch", () => {
  it("fails private-main PRs on the live head with actionable check, summary and comment", async () => {
    const { github, core, createCheck, run } = setup();
    await run();

    expect(createCheck).toHaveBeenCalledWith(
      expect.objectContaining({
        name: "Target branch",
        head_sha: "b".repeat(40),
        conclusion: "failure",
      }),
    );
    const summary = createCheck.mock.calls[0][0].output?.summary ?? "";
    expect(summary).toContain("https://aka.ms/azsdk/move-pr");
    expect(summary).toContain("`RPSaaSMaster`");
    expect(summary).toContain("Do not move private API specifications to the public repository.");
    expect(core.summary.addRaw).toHaveBeenCalledWith(summary);
    expect(core.summary.write).toHaveBeenCalledOnce();
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({ issue_number: 1, body: `${summary}\n${marker}` }),
    );
  });

  it("does not duplicate an unchanged warning", async () => {
    const { github, createComment, run } = setup();
    await run();
    const body = createComment.mock.calls[0][0].body;
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ id: 5, body, user: { login: "github-actions[bot]", type: "Bot" } }],
    });
    github.rest.issues.createComment.mockClear();
    await run();
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it("clears the failure and resolves the existing comment after retargeting, even for a stale event", async () => {
    const { github, core, createCheck, run } = setup("RPSaaSMaster");
    github.rest.issues.listComments.mockResolvedValue({
      data: [
        {
          id: 5,
          body: `Old warning\n${marker}`,
          user: { login: "github-actions[bot]", type: "Bot" },
        },
      ],
    });
    await run();
    expect(createCheck).toHaveBeenCalledWith(
      expect.objectContaining({ conclusion: "success", head_sha: "b".repeat(40) }),
    );
    expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining("does not target"));
    expect(github.rest.issues.updateComment).toHaveBeenCalledWith(
      expect.objectContaining({ comment_id: 5 }),
    );
    expect(github.rest.issues.updateComment.mock.calls[0][0]).toHaveProperty(
      "body",
      expect.stringContaining("Target branch warning resolved"),
    );
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("passes other private targets without posting a clean-state comment", async () => {
    const { github, createCheck, run } = setup("release-widget");
    await run();
    expect(createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "success" }));
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it("does not warn or make API calls for public-main PRs", async () => {
    const { github, context, createCheck, run } = setup();
    context.repo.repo = "azure-rest-api-specs";
    await run();
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(github.rest.issues.listComments).not.toHaveBeenCalled();
    expect(createCheck).not.toHaveBeenCalled();
  });

  it("ignores contributor comments that copy the warning marker", async () => {
    const { github, run } = setup();
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ id: 5, body: marker, user: { login: "spec-author", type: "User" } }],
    });
    await run();
    expect(github.rest.issues.createComment).toHaveBeenCalledOnce();
    expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it("does not publish a warning after the PR closes", async () => {
    const { github, createCheck, run } = setup();
    github.rest.pulls.get.mockResolvedValue({ data: { state: "closed" } });
    await run();
    expect(createCheck).not.toHaveBeenCalled();
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it("rejects missing PR context without API calls", async () => {
    const { github, context, run } = setup();
    context.payload = {};
    await expect(run()).rejects.toThrow("requires a pull request number");
    expect(github.rest.issues.listComments).not.toHaveBeenCalled();
  });
});
