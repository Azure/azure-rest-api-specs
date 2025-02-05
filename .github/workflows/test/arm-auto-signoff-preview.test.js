import { describe, expect, it, vi } from "vitest";
import { createMockCore } from "../../test/mocks.js";
import { armAutoSignoffPreviewImpl } from "../src/arm-auto-signoff-preview.js";

describe("armAutoSignoffPreviewImpl", () => {
  it("rejects if inputs null", async () => {
    await expect(armAutoSignoffPreviewImpl({})).rejects.toThrow();
  });

  it("logs labels", async () => {
    const core = createMockCore();

    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "TestLabel1" }, { name: "TestLabel2" }],
    });

    await expect(
      armAutoSignoffPreviewImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBeUndefined();

    expect(core.info).toBeCalledWith('["TestLabel1","TestLabel2"]');
  });
});

function createMockGithub() {
  return {
    rest: {
      issues: {
        listLabelsOnIssue: vi.fn(),
      },
    },
  };
}
