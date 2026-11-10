import { describe, expect, it, vi } from "vitest";
import { labelExternalContributor } from "../src/pr-contribution.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

function setup() {
  const github = createMockGithub();
  const context = createMockContext();
  const core = createMockCore();
  const pr = {
    number: 123,
    user: { login: "external-contributor", type: "User" },
    author_association: "CONTRIBUTOR",
    labels: [] as { name: string }[],
  };
  context.payload = {
    pull_request: pr,
    sender: { login: "automation[bot]", type: "Bot" },
  };
  const permission = vi.fn().mockResolvedValue({ data: { permission: "read" } });
  Object.assign(github.rest.repos, { getCollaboratorPermissionLevel: permission });
  return {
    github,
    context,
    pr,
    permission,
    run: () => labelExternalContributor({ github, context, core }),
  };
}

describe("PR contribution labeling", () => {
  it("labels external humans using the author, not the event sender, without commenting", async () => {
    const f = setup();
    await f.run();
    expect(f.permission).toHaveBeenCalledExactlyOnceWith({
      owner: "owner",
      repo: "repo",
      username: "external-contributor",
    });
    expect(f.github.rest.issues.addLabels).toHaveBeenCalledExactlyOnceWith({
      owner: "owner",
      repo: "repo",
      issue_number: 123,
      labels: ["customer-reported"],
    });
    expect(f.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("skips bot authors without a bot-name allowlist, even with a human sender", async () => {
    const f = setup();
    f.pr.user = { login: "new-automation[bot]", type: "Bot" };
    f.context.payload.sender = { login: "maintainer", type: "User" };
    await f.run();
    expect(f.permission).not.toHaveBeenCalled();
    expect(f.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(f.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it.each(["MEMBER", "COLLABORATOR", "OWNER"])(
    "skips repository %s authors",
    async (association) => {
      const f = setup();
      f.pr.author_association = association;
      await f.run();
      expect(f.permission).not.toHaveBeenCalled();
      expect(f.github.rest.issues.addLabels).not.toHaveBeenCalled();
    },
  );

  it.each(["write", "admin"])("skips authors with %s access", async (permission) => {
    const f = setup();
    f.permission.mockResolvedValue({ data: { permission } });
    await f.run();
    expect(f.github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it("avoids a redundant write when already labeled", async () => {
    const f = setup();
    f.pr.labels = [{ name: "customer-reported" }];
    await f.run();
    expect(f.permission).not.toHaveBeenCalled();
    expect(f.github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it("does not label when the author's permissions cannot be verified", async () => {
    const f = setup();
    f.permission.mockRejectedValue(new Error("Permission lookup failed"));
    await expect(f.run()).rejects.toThrow("Permission lookup failed");
    expect(f.github.rest.issues.addLabels).not.toHaveBeenCalled();
  });
});
