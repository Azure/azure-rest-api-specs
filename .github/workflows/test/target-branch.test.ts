import { describe, expect, it, vi } from "vitest";
import type { RestEndpointMethodTypes } from "../src/github.ts";
import { checkTargetBranch } from "../src/target-branch.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

type CheckParameters = RestEndpointMethodTypes["checks"]["create"]["parameters"];

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
  Object.assign(github.rest.checks, { create: createCheck });
  github.rest.pulls.get.mockResolvedValue({
    data: { number: 1, state: "open", base: { ref: base }, head: { sha: "b".repeat(40) } },
  });
  const run = () => checkTargetBranch({ github, context, core });
  return { github, context, core, createCheck, run };
}

describe("target branch", () => {
  it("fails private-main PRs on the live head with actionable check details and no comment", async () => {
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
    expect(github.rest.issues.listComments).not.toHaveBeenCalled();
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it.each(["RPSaaSMaster", "release-widget"])(
    "passes after retargeting to %s, even when the event still targets main",
    async (base) => {
      const { core, createCheck, run } = setup(base);
      await run();
      expect(createCheck).toHaveBeenCalledWith(
        expect.objectContaining({ conclusion: "success", head_sha: "b".repeat(40) }),
      );
      expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining("does not target"));
    },
  );

  it("does not warn or make API calls for public-main PRs", async () => {
    const { github, context, createCheck, run } = setup();
    context.repo.repo = "azure-rest-api-specs";
    await run();
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(github.rest.issues.listComments).not.toHaveBeenCalled();
    expect(createCheck).not.toHaveBeenCalled();
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
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });
});
