import * as core from "@actions/core";
import { getOctokit } from "@actions/github";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { createWorkflowArguments, runWorkflow } from "../src/workflow-runtime.ts";

vi.mock("@actions/core", () => ({
  isDebug: vi.fn(() => false),
  setOutput: vi.fn(),
  setFailed: vi.fn(),
}));
vi.mock("@actions/github", () => ({
  context: { eventName: "workflow_run", payload: { action: "completed" } },
  getOctokit: vi.fn(() => ({ rest: {}, paginate: vi.fn() })),
}));

beforeEach(() => {
  vi.clearAllMocks();
  vi.unstubAllEnvs();
});

describe("workflow runtime", () => {
  it("constructs a client with the explicit token and preserves Actions context", () => {
    vi.stubEnv("GITHUB_TOKEN", "fixture-token");
    const args = createWorkflowArguments();
    expect(getOctokit).toHaveBeenCalledWith("fixture-token", { log: undefined });
    expect(args.context.eventName).toBe("workflow_run");
    expect(args.core).toBe(core);
    expect(args.github).toBe(vi.mocked(getOctokit).mock.results[0].value);
  });

  it("preserves debug request logging", () => {
    vi.stubEnv("GITHUB_TOKEN", "fixture-token");
    vi.mocked(core.isDebug).mockReturnValueOnce(true);
    createWorkflowArguments();
    expect(getOctokit).toHaveBeenCalledWith("fixture-token", { log: console });
  });

  it("fails explicitly when an API command has no token", () => {
    vi.stubEnv("GITHUB_TOKEN", "");
    expect(createWorkflowArguments).toThrow("GITHUB_TOKEN must be set");
    expect(getOctokit).not.toHaveBeenCalled();
  });

  it.each([
    [
      { labelActions: { ARMReview: "add" }, headSha: "abc", issueNumber: 12 },
      '{"labelActions":{"ARMReview":"add"},"headSha":"abc","issueNumber":12}',
    ],
    ["text", '"text"'],
    [false, "false"],
    [null, "null"],
    [undefined, undefined],
  ])("preserves JSON result encoding for %j", async (result, encoded) => {
    vi.stubEnv("GITHUB_TOKEN", "");
    await runWorkflow(() => result);
    expect(core.setOutput).toHaveBeenCalledWith("result", encoded);
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(getOctokit).not.toHaveBeenCalled();
  });

  it("preserves explicit string encoding", async () => {
    await runWorkflow(() => undefined, "string");
    expect(core.setOutput).toHaveBeenCalledWith("result", "undefined");
  });

  it("awaits the command and retains named outputs", async () => {
    await runWorkflow(async () => {
      await Promise.resolve();
      core.setOutput("head_sha", "abc");
      return { issueNumber: 12 };
    });
    expect(vi.mocked(core.setOutput).mock.calls).toEqual([
      ["head_sha", "abc"],
      ["result", '{"issueNumber":12}'],
    ]);
  });

  it("reports failures without overwriting previously emitted outputs", async () => {
    const log = vi.spyOn(console, "error").mockImplementation(() => {});
    try {
      await runWorkflow(() => {
        core.setOutput("head_sha", "abc");
        throw new Error("API unavailable");
      });
      expect(core.setFailed).toHaveBeenCalledWith("Unhandled error: Error: API unavailable");
      expect(core.setOutput).toHaveBeenCalledExactlyOnceWith("head_sha", "abc");
      expect(log).toHaveBeenCalledOnce();
    } finally {
      log.mockRestore();
    }
  });
});
