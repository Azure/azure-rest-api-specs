import { beforeEach, describe, expect, it, vi } from "vitest";
import { REVIEW_REQUIRED_LABELS } from "../../shared/src/breaking-change.js";
import { PER_PAGE_MAX } from "../../shared/src/github.js";
import getLabelActions, {
  CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME,
  SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME,
} from "../src/breaking-change-add-label-artifacts.js";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.js";

// Mock dependencies
vi.mock("../src/context.js", () => ({
  extractInputs: vi.fn(),
}));

describe("breaking-change-add-label-artifacts", () => {
  let mockGithub;
  let mockContext;
  let mockCore;

  beforeEach(() => {
    // Reset all mocks before each test
    vi.clearAllMocks();

    // Create fresh mock instances for each test
    mockGithub = createMockGithub();
    mockContext = createMockContext();
    mockCore = createMockCore();
  });

  const mockInputs = {
    owner: "Azure",
    repo: "azure-rest-api-specs",
    head_sha: "abc123def456",
    issue_number: 12345,
  };

  const createMockWorkflowRun = (
    name,
    status = "completed",
    conclusion = "success",
    id = 1,
    updated_at = "2024-01-01T12:00:00Z",
  ) => ({
    id,
    name,
    status,
    conclusion,
    updated_at,
  });

  const createMockArtifact = (name) => ({ name });

  // Shared setup helpers
  const setupMockInputs = async () => {
    const { extractInputs } = await import("../src/context.js");
    extractInputs.mockResolvedValue(mockInputs);
  };

  const setupWorkflowRunsMock = (workflowRuns) => {
    mockGithub.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: { workflow_runs: workflowRuns },
    });
  };

  const setupArtifactsMock = (breakingChangeArtifacts, crossVersionArtifacts) => {
    mockGithub.rest.actions.listWorkflowRunArtifacts
      .mockResolvedValueOnce({ data: { artifacts: breakingChangeArtifacts } })
      .mockResolvedValueOnce({ data: { artifacts: crossVersionArtifacts } });
  };

  const createStandardWorkflowRuns = () => [
    createMockWorkflowRun(SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME, "completed", "success", 1),
    createMockWorkflowRun(CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME, "completed", "success", 2),
  ];

  const expectStandardOutputs = (breakingChangeValue, versioningValue) => {
    expect(mockCore.setOutput).toHaveBeenCalledWith("issue_number", mockInputs.issue_number);
    expect(mockCore.setOutput).toHaveBeenCalledWith(
      "breakingChangeReviewLabelName",
      REVIEW_REQUIRED_LABELS.BREAKING_CHANGE,
    );
    expect(mockCore.setOutput).toHaveBeenCalledWith(
      "breakingChangeReviewLabelValue",
      breakingChangeValue,
    );
    expect(mockCore.setOutput).toHaveBeenCalledWith(
      "versioningReviewLabelName",
      REVIEW_REQUIRED_LABELS.VERSIONING,
    );
    expect(mockCore.setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", versioningValue);
  };

  const expectEarlyReturn = (infoMessage) => {
    expect(mockCore.info).toHaveBeenCalledWith(infoMessage);
    expect(mockGithub.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
    expect(mockCore.setOutput).not.toHaveBeenCalled();
  };

  describe("successful execution with both workflows completed", () => {
    it("should process breaking change and versioning labels correctly", async () => {
      // Setup mocks
      await setupMockInputs();

      const mockWorkflowRuns = [
        createMockWorkflowRun(
          SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME,
          "completed",
          "success",
          1,
          "2024-01-01T12:00:00Z",
        ),
        createMockWorkflowRun(
          CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME,
          "completed",
          "success",
          2,
          "2024-01-01T11:30:00Z",
        ),
        createMockWorkflowRun("Other Workflow", "completed", "success", 3, "2024-01-01T11:00:00Z"),
      ];

      const breakingChangeArtifacts = [
        createMockArtifact(`${REVIEW_REQUIRED_LABELS.BREAKING_CHANGE}=true`),
        createMockArtifact("other-artifact"),
      ];

      const crossVersionArtifacts = [
        createMockArtifact(`${REVIEW_REQUIRED_LABELS.VERSIONING}=true`),
        createMockArtifact("another-artifact"),
      ];

      setupWorkflowRunsMock(mockWorkflowRuns);
      setupArtifactsMock(breakingChangeArtifacts, crossVersionArtifacts);

      // Execute the function
      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      // Verify API calls
      expect(mockGithub.rest.actions.listWorkflowRunsForRepo).toHaveBeenCalledWith({
        owner: "Azure",
        repo: "azure-rest-api-specs",
        event: "pull_request",
        head_sha: "abc123def456",
        per_page: PER_PAGE_MAX,
      });

      expect(mockGithub.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledTimes(2);
      expect(mockGithub.rest.actions.listWorkflowRunArtifacts).toHaveBeenNthCalledWith(1, {
        owner: "Azure",
        repo: "azure-rest-api-specs",
        run_id: 1,
        per_page: PER_PAGE_MAX,
      });

      expect(mockGithub.rest.actions.listWorkflowRunArtifacts).toHaveBeenNthCalledWith(2, {
        owner: "Azure",
        repo: "azure-rest-api-specs",
        run_id: 2,
        per_page: PER_PAGE_MAX,
      });

      // Verify outputs - breaking change takes precedence over versioning
      expectStandardOutputs(true, false); // breaking change takes precedence
    });

    it("should set versioning label when only versioning artifacts are present", async () => {
      await setupMockInputs();

      const breakingChangeArtifacts = [createMockArtifact("other-artifact")];
      const crossVersionArtifacts = [
        createMockArtifact(`${REVIEW_REQUIRED_LABELS.VERSIONING}=true`),
      ];

      setupWorkflowRunsMock(createStandardWorkflowRuns());
      setupArtifactsMock(breakingChangeArtifacts, crossVersionArtifacts);

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      expectStandardOutputs(false, true); // only versioning label should be true
    });

    it("should set no labels when no relevant artifacts are present", async () => {
      await setupMockInputs();

      const breakingChangeArtifacts = [createMockArtifact("other-artifact")];
      const crossVersionArtifacts = [createMockArtifact("another-artifact")];

      setupWorkflowRunsMock(createStandardWorkflowRuns());
      setupArtifactsMock(breakingChangeArtifacts, crossVersionArtifacts);

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      expectStandardOutputs(false, false); // no labels should be true
    });
  });

  describe("workflow run status handling", () => {
    it("should return early when breaking changes workflow is not completed", async () => {
      await setupMockInputs();

      const mockWorkflowRuns = [
        createMockWorkflowRun(SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME, "in_progress", null, 1),
        createMockWorkflowRun(
          CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME,
          "completed",
          "success",
          2,
        ),
      ];

      setupWorkflowRunsMock(mockWorkflowRuns);

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      expectEarlyReturn("No completed breaking changes workflow run found");
    });

    it("should return early when cross-version workflow is not completed", async () => {
      await setupMockInputs();

      const mockWorkflowRuns = [
        createMockWorkflowRun(SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME, "completed", "success", 1),
        createMockWorkflowRun(CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME, "queued", null, 2),
      ];

      setupWorkflowRunsMock(mockWorkflowRuns);

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      expectEarlyReturn("No completed cross-version breaking changes workflow run found");
    });

    it("should return early when breaking changes workflow is not found", async () => {
      await setupMockInputs();

      const mockWorkflowRuns = [
        createMockWorkflowRun(
          CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME,
          "completed",
          "success",
          2,
        ),
        createMockWorkflowRun("Other Workflow", "completed", "success", 3),
      ];

      setupWorkflowRunsMock(mockWorkflowRuns);

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      expect(mockCore.info).toHaveBeenCalledWith(
        "No completed breaking changes workflow run found",
      );
    });

    it("should return early when cross-version workflow is not found", async () => {
      await setupMockInputs();

      const mockWorkflowRuns = [
        createMockWorkflowRun(SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME, "completed", "success", 1),
        createMockWorkflowRun("Other Workflow", "completed", "success", 3),
      ];

      setupWorkflowRunsMock(mockWorkflowRuns);

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      expect(mockCore.info).toHaveBeenCalledWith(
        "No completed cross-version breaking changes workflow run found",
      );
    });
  });

  describe("artifact processing", () => {
    it("should find labels in cross-version artifacts when not in breaking change artifacts", async () => {
      await setupMockInputs();
      const mockWorkflowRuns = createStandardWorkflowRuns();

      const breakingChangeArtifacts = [createMockArtifact("other-artifact")];
      const crossVersionArtifacts = [
        createMockArtifact(`${REVIEW_REQUIRED_LABELS.BREAKING_CHANGE}=true`),
      ];

      setupWorkflowRunsMock(mockWorkflowRuns);

      mockGithub.rest.actions.listWorkflowRunArtifacts
        .mockResolvedValueOnce({ data: { artifacts: breakingChangeArtifacts } })
        .mockResolvedValueOnce({ data: { artifacts: crossVersionArtifacts } });

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      expect(mockCore.setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", true);
      expect(mockCore.setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", false);
    });

    it("should handle both labels present in different artifact collections", async () => {
      await setupMockInputs();
      const mockWorkflowRuns = createStandardWorkflowRuns();

      const breakingChangeArtifacts = [
        createMockArtifact(`${REVIEW_REQUIRED_LABELS.VERSIONING}=true`),
      ];
      const crossVersionArtifacts = [
        createMockArtifact(`${REVIEW_REQUIRED_LABELS.BREAKING_CHANGE}=true`),
      ];

      setupWorkflowRunsMock(mockWorkflowRuns);

      mockGithub.rest.actions.listWorkflowRunArtifacts
        .mockResolvedValueOnce({ data: { artifacts: breakingChangeArtifacts } })
        .mockResolvedValueOnce({ data: { artifacts: crossVersionArtifacts } });

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      // Breaking change should take precedence
      expect(mockCore.setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", true);
      expect(mockCore.setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", false);
    });
  });

  describe("edge cases", () => {
    it("should handle empty workflow runs list", async () => {
      await setupMockInputs();

      mockGithub.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
        data: { workflow_runs: [] },
      });

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      expect(mockCore.info).toHaveBeenCalledWith(
        "No completed breaking changes workflow run found",
      );
      expect(mockGithub.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
    });

    it("should return early when both artifact lists are empty", async () => {
      await setupMockInputs();
      const mockWorkflowRuns = createStandardWorkflowRuns();

      setupWorkflowRunsMock(mockWorkflowRuns);

      mockGithub.rest.actions.listWorkflowRunArtifacts
        .mockResolvedValueOnce({ data: { artifacts: [] } }) // Empty breaking change artifacts
        .mockResolvedValueOnce({ data: { artifacts: [] } }); // Empty cross-version artifacts

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      // Should log the info message about no artifacts found
      expect(mockCore.info).toHaveBeenCalledWith(
        "No artifacts found for breaking changes or cross-version breaking changes",
      );

      // Should only set issue_number output, but not the label outputs since it returns early
      expect(mockCore.setOutput).toHaveBeenCalledWith("issue_number", mockInputs.issue_number);
      expect(mockCore.setOutput).not.toHaveBeenCalledWith(
        "breakingChangeReviewLabelValue",
        expect.anything(),
      );
      expect(mockCore.setOutput).not.toHaveBeenCalledWith(
        "versioningReviewLabelValue",
        expect.anything(),
      );
    });

    it("should return early when one workflow has empty artifacts and other has only non-label artifacts", async () => {
      await setupMockInputs();
      const mockWorkflowRuns = createStandardWorkflowRuns();

      setupWorkflowRunsMock(mockWorkflowRuns);

      mockGithub.rest.actions.listWorkflowRunArtifacts
        .mockResolvedValueOnce({ data: { artifacts: [] } }) // Empty breaking change artifacts
        .mockResolvedValueOnce({
          data: { artifacts: [createMockArtifact("some-other-artifact")] },
        }); // Non-label artifacts

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      // Should NOT return early because there are artifacts (even though they're not label artifacts)
      // The function should continue and set outputs with false values
      expect(mockCore.info).not.toHaveBeenCalledWith(
        "No artifacts found for breaking changes or cross-version breaking changes",
      );

      // Should set all outputs including the label values
      expect(mockCore.setOutput).toHaveBeenCalledWith("issue_number", mockInputs.issue_number);
      expect(mockCore.setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", false);
      expect(mockCore.setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", false);
    });

    it("should handle workflow runs with status conclusion pairs", async () => {
      await setupMockInputs();

      const mockWorkflowRuns = [
        {
          ...createMockWorkflowRun(
            SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME,
            "completed",
            "failure",
            1,
          ),
        },
        {
          ...createMockWorkflowRun(
            CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME,
            "in_progress",
            null,
            2,
          ),
        },
      ];

      mockGithub.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
        data: { workflow_runs: mockWorkflowRuns },
      });

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      // Should log status for in_progress and conclusion for completed
      expect(mockCore.info).toHaveBeenCalledWith(
        `- ${SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME}: failure`,
      );
      expect(mockCore.info).toHaveBeenCalledWith(
        `- ${CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME}: in_progress`,
      );
    });
  });

  describe("output validation", () => {
    it("should always set all required outputs", async () => {
      await setupMockInputs();
      const mockWorkflowRuns = createStandardWorkflowRuns();

      const artifacts = [createMockArtifact("test-artifact")];

      setupWorkflowRunsMock(mockWorkflowRuns);

      mockGithub.rest.actions.listWorkflowRunArtifacts
        .mockResolvedValueOnce({ data: { artifacts } })
        .mockResolvedValueOnce({ data: { artifacts } });

      await getLabelActions({ github: mockGithub, context: mockContext, core: mockCore });

      // Verify all required outputs are set
      expect(mockCore.setOutput).toHaveBeenCalledWith("issue_number", mockInputs.issue_number);
      expect(mockCore.setOutput).toHaveBeenCalledWith(
        "breakingChangeReviewLabelName",
        REVIEW_REQUIRED_LABELS.BREAKING_CHANGE,
      );
      expect(mockCore.setOutput).toHaveBeenCalledWith(
        "breakingChangeReviewLabelValue",
        expect.any(Boolean),
      );
      expect(mockCore.setOutput).toHaveBeenCalledWith(
        "versioningReviewLabelName",
        REVIEW_REQUIRED_LABELS.VERSIONING,
      );
      expect(mockCore.setOutput).toHaveBeenCalledWith(
        "versioningReviewLabelValue",
        expect.any(Boolean),
      );
    });
  });
});
