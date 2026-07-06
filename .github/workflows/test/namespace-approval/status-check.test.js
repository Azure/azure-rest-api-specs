import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.js";

vi.mock("../../src/context.js", () => ({
  extractInputs: vi.fn(),
}));

import { extractInputs } from "../../src/context.js";
import statusCheck from "../../src/namespace-approval/status-check.js";

describe("status-check", () => {
  /** @type {ReturnType<typeof createMockGithub>} */
  let github;
  /** @type {ReturnType<typeof createMockContext>} */
  let context;
  /** @type {ReturnType<typeof createMockCore>} */
  let core;

  /** @returns {import("@actions/github-script").AsyncFunctionArguments} */
  function args() {
    return /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (
      /** @type {unknown} */ ({ github, context, core })
    );
  }

  beforeEach(() => {
    vi.clearAllMocks();
    github = createMockGithub();
    context = createMockContext();
    core = createMockCore();
    vi.mocked(extractInputs).mockResolvedValue({
      owner: "owner",
      repo: "repo",
      issue_number: 42,
      head_sha: "head",
      run_id: Number.NaN,
    });
  });

  it("should pass when no namespace-review-required label", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: { labels: [{ name: "other-label" }], head: { sha: "abc123" } },
    });

    await statusCheck(args());

    expect(core.info).toHaveBeenCalledWith("No namespace review required, passing");
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "success", context: "Namespace Approval" }),
    );
  });

  it("should fail when pending labels remain", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { sha: "abc123" },
        labels: [
          { name: "namespace-review-required" },
          { name: "namespace-java-pending" },
          { name: "namespace-dotnet-pending" },
        ],
      },
    });

    await statusCheck(args());

    const infoMsg = String(
      core.info.mock.calls.find((/** @type {unknown[]} */ c) =>
        String(c[0]).includes("pending"),
      )?.[0],
    );
    expect(infoMsg).toContain("java");
    expect(infoMsg).toContain("dotnet");
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "pending", context: "Namespace Approval" }),
    );
  });

  it("should pass when all namespaces approved", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { sha: "abc123" },
        labels: [
          { name: "namespace-review-required" },
          { name: "namespace-approved" },
          { name: "namespace-java-approved" },
        ],
      },
    });

    await statusCheck(args());

    expect(core.info).toHaveBeenCalledWith("All namespaces approved - merge allowed");
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "success", context: "Namespace Approval" }),
    );
  });

  it("should set pending when namespace-review-required but no pending or approved labels", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { sha: "abc123" },
        labels: [{ name: "namespace-review-required" }],
      },
    });

    await statusCheck(args());

    expect(core.warning).toHaveBeenCalledWith(
      "namespace-review-required is set but no pending or approved labels found",
    );
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: "pending",
        context: "Namespace Approval",
        description: "Namespace review in progress",
      }),
    );
  });
});
