import { describe, expect, it, vi } from "vitest";
import { greetContributor } from "../src/pr-contribution-greeting.ts";
import {
  createMockContext,
  createMockCore,
  createMockGithub,
  createMockRequestError,
} from "./mocks.ts";

function setup(type = "User", association = "CONTRIBUTOR", login = "contributor") {
  const github = createMockGithub();
  const context = createMockContext();
  context.payload = {
    pull_request: {
      number: 42,
      author_association: association,
      user: { login, type },
    },
  };
  const permission = vi.fn().mockResolvedValue({ data: { permission: "read" } });
  Object.assign(github.rest.repos, { getCollaboratorPermissionLevel: permission });
  const args = { github, context, core: createMockCore() };
  return { args, github, permission };
}

describe("PR contribution greeting", () => {
  it("greets external contributors", async () => {
    const { args, github } = setup();
    await greetContributor(args);
    expect(github.rest.issues.createComment).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      issue_number: 42,
      body: "Thank you for your contribution @contributor! We will review the pull request and get back to you soon.\n<!-- PRContributionGreeting -->",
    });
  });

  it.each(["dependabot[bot]", "another-app[bot]"])("skips bot PRs (%s)", async (login) => {
    const { args, github, permission } = setup("Bot", "CONTRIBUTOR", login);
    await greetContributor(args);
    expect(permission).not.toHaveBeenCalled();
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it.each(["MEMBER", "COLLABORATOR", "OWNER"])("skips %s authors", async (association) => {
    const { args, github, permission } = setup("User", association);
    await greetContributor(args);
    expect(permission).not.toHaveBeenCalled();
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it.each(["write", "maintain", "admin"])("skips authors with %s permission", async (level) => {
    const { args, github, permission } = setup();
    permission.mockResolvedValue({ data: { permission: level } });
    await greetContributor(args);
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("greets a non-collaborator when permission lookup returns 404", async () => {
    const { args, github, permission } = setup();
    permission.mockRejectedValue(createMockRequestError(404));
    await greetContributor(args);
    expect(github.rest.issues.createComment).toHaveBeenCalledOnce();
  });

  it("does not swallow permission lookup failures", async () => {
    const { args, github, permission } = setup();
    permission.mockRejectedValue(createMockRequestError(403));
    await expect(greetContributor(args)).rejects.toMatchObject({ status: 403 });
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("does not repeat the greeting on workflow reruns", async () => {
    const { args, github } = setup();
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ body: "Thank you!\n<!-- PRContributionGreeting -->" }],
    });
    await greetContributor(args);
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });
});
