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

  it("should pass when no package-name-review-required label", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: { labels: [{ name: "other-label" }], head: { sha: "abc123" } },
    });

    await statusCheck(args());

    expect(core.info).toHaveBeenCalledWith("No package name review required, passing");
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "success", context: "Package Name Approval" }),
    );
  });

  it("should fail when pending labels remain", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { sha: "abc123" },
        labels: [
          { name: "package-name-review-required" },
          { name: "package-name-java-pending" },
          { name: "package-name-dotnet-pending" },
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
      expect.objectContaining({ state: "pending", context: "Package Name Approval" }),
    );
  });

  it("should pass when all package names approved", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { sha: "abc123" },
        labels: [
          { name: "package-name-review-required" },
          { name: "package-name-approved" },
          { name: "package-name-java-approved" },
        ],
      },
    });

    await statusCheck(args());

    expect(core.info).toHaveBeenCalledWith("All package names approved - merge allowed");
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "success", context: "Package Name Approval" }),
    );
  });

  it("should set pending when package-name-review-required but no pending or approved labels", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { sha: "abc123" },
        labels: [{ name: "package-name-review-required" }],
      },
    });

    await statusCheck(args());

    expect(core.warning).toHaveBeenCalledWith(
      "package-name-review-required is set but no pending or approved labels found",
    );
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: "pending",
        context: "Package Name Approval",
        description: "Package name review in progress",
      }),
    );
  });
});
