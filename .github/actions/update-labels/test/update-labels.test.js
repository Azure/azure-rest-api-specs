import { describe, expect, it, vi } from "vitest";
import { createMockCore } from "../../../test/mocks.js";
import updateLabels from "../src/update-labels.js";

describe("update-labels", () => {
  it("loads inputs from env (run_id)", async () => {
    try {
      process.env.OWNER = "TestRepoOwnerLoginEnv";
      process.env.REPO = "TestRepoNameEnv";
      process.env.RUN_ID = "123";

      const github = createMockGithub();

      await expect(
        updateLabels({
          github: github,
          context: null,
          core: createMockCore(),
        }),
      ).resolves.toBeUndefined();

      expect(github.rest.issues.addLabels).toBeCalledTimes(0);
      expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
    } finally {
      delete process.env.OWNER;
      delete process.env.REPO;
      delete process.env.RUN_ID;
    }
  });

  it("loads inputs from env (issue_number)", async () => {
    try {
      process.env.OWNER = "TestRepoOwnerLoginEnv";
      process.env.REPO = "TestRepoNameEnv";
      process.env.ISSUE_NUMBER = "123";

      const github = createMockGithub();

      // Listing all artifacts by issue_number is not yet implemented
      await expect(
        updateLabels({
          github: github,
          context: null,
          core: createMockCore(),
        }),
      ).rejects.toThrow();

      expect(github.rest.issues.addLabels).toBeCalledTimes(0);
      expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
    } finally {
      delete process.env.OWNER;
      delete process.env.REPO;
      delete process.env.ISSUE_NUMBER;
    }
  });
});

function createMockGithub() {
  return {
    rest: {
      actions: {
        listWorkflowRunArtifacts: vi
          .fn()
          .mockResolvedValue({ data: { artifacts: [] } }),
      },
      issues: {
        addLabels: vi.fn(),
        removeLabel: vi.fn(),
      },
    },
  };
}
