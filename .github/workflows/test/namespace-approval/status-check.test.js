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
      data: { labels: [{ name: "other-label" }] },
    });

    await statusCheck(args());

    expect(core.info).toHaveBeenCalledWith("No namespace review required, passing");
    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it("should fail when pending labels remain", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        labels: [
          { name: "namespace-review-required" },
          { name: "java-namespace-pending" },
          { name: "dotnet-namespace-pending" },
        ],
      },
    });

    await statusCheck(args());

    const failMsg = String(core.setFailed.mock.calls[0][0]);
    expect(failMsg).toContain("java");
    expect(failMsg).toContain("dotnet");
  });

  it("should pass when all namespaces approved", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        labels: [
          { name: "namespace-review-required" },
          { name: "namespace-approved" },
          { name: "java-namespace-approved" },
        ],
      },
    });

    await statusCheck(args());

    expect(core.info).toHaveBeenCalledWith("All namespaces approved - merge allowed");
    expect(core.setFailed).not.toHaveBeenCalled();
  });
});
