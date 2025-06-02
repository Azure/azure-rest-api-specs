import { beforeEach, describe, expect, it, vi } from "vitest";
import { sdkLabels } from "../../shared/src/sdk-types.js";
import { LabelAction } from "../src/label.js";
import {
  getLabelAndAction,
  getLabelAndActionImpl,
} from "../src/sdk-breaking-change-labels.js";
import {
  createMockContext,
  createMockCore,
  createMockGithub,
} from "./mocks.js";

// Mock dependencies
vi.mock("../src/context.js", () => ({
  extractInputs: vi.fn(),
}));

// Mock global fetch
global.fetch = vi.fn();

const mockGithub = createMockGithub();
const mockContext = createMockContext();
const mockCore = createMockCore();

describe("sdk-breaking-change-labels", () => {
  beforeEach(() => {
    // Reset mocks
    vi.clearAllMocks();
  });

  describe("getLabelAndAction", () => {
    it("should extract inputs and call getLabelAndActionImpl", async () => {
      // Mock extracted inputs
      const mockInputs = {
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Setup mock implementation for extractInputs
      const { extractInputs } = await import("../src/context.js");
      extractInputs.mockResolvedValue(mockInputs);

      // Mock fetch responses
      // First fetch - artifact metadata
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({
          resource: {
            downloadUrl: "https://dev.azure.com/download?format=zip",
          },
        }),
        text: vi.fn(),
      };

      // Second fetch - artifact content
      const language = "azure-sdk-for-js";
      const mockContentResponse = {
        ok: true,
        text: vi.fn().mockResolvedValue(
          JSON.stringify({
            labelAction: true,
            language,
          }),
        ),
      };

      // Mock PR search results
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: "https://github.com/pr/123" }],
        },
      });

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes("artifacts?artifactName=")) {
          return mockArtifactResponse;
        } else {
          return mockContentResponse;
        }
      });

      // Call the function
      const result = await getLabelAndAction({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
      });

      // Verify result
      expect(result).toEqual({
        labelName: sdkLabels[language].breakingChange,
        labelAction: LabelAction.Add,
        issueNumber: 123,
      });

      // Verify mocks were called correctly
      expect(mockGithub.rest.search.issuesAndPullRequests).toHaveBeenCalledWith(
        {
          q: `sha:abc123 type:pr state:open`,
        },
      );
    });
    it("should correctly set labelAction to Remove", async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Setup mock for extractInputs
      const { extractInputs } = await import("../src/context.js");
      extractInputs.mockResolvedValue(inputs);

      // Mock artifact responses with 'remove' action
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({
          resource: {
            downloadUrl: "https://dev.azure.com/download?format=zip",
          },
        }),
      };

      const language = "azure-sdk-for-js";
      const mockContentResponse = {
        ok: true,
        text: vi.fn().mockResolvedValue(
          JSON.stringify({
            labelAction: false,
            language,
          }),
        ),
      };

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes("artifacts?artifactName=")) {
          return mockArtifactResponse;
        } else {
          return mockContentResponse;
        }
      });

      // Mock PR search
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: "https://github.com/pr/123" }],
        },
      });

      // Call function
      const result = await getLabelAndAction({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
      });

      // Verify result has Remove action
      expect(result).toEqual({
        labelName: sdkLabels[language].breakingChange,
        labelAction: LabelAction.Remove,
        issueNumber: 123,
      });
    });
    it("should throw error with invalid inputs", async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: "",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Setup mock for extractInputs
      const { extractInputs } = await import("../src/context.js");
      extractInputs.mockResolvedValue(inputs);

      // Call function and expect it to throw
      await expect(
        getLabelAndAction({
          github: mockGithub,
          context: mockContext,
          core: mockCore,
        }),
      ).rejects.toThrow();
    });
  });

  describe("getLabelAndActionImpl error handling", () => {
    it("should handle API failure", async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Mock fetch failure
      global.fetch.mockResolvedValue({
        ok: false,
        status: 500,
        statusText: "Server Error",
        text: vi.fn().mockResolvedValue("Artifact not found"),
      });

      // Mock PR search success
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: "https://github.com/pr/123" }],
        },
      });

      // Call function
      const result = await getLabelAndActionImpl({
        ado_build_id: inputs.ado_build_id,
        ado_project_url: inputs.ado_project_url,
        head_sha: inputs.head_sha,
        github: mockGithub,
        core: mockCore,
      });

      // Verify result uses default values when artifact fetch fails
      expect(result).toEqual({
        labelName: "",
        labelAction: LabelAction.None,
        issueNumber: NaN,
      });

      // Verify error was logged
      expect(mockCore.error).toHaveBeenCalledWith(
        expect.stringContaining("Failed to fetch artifacts"),
      );
    });

    it("should complete without op when artifact does not exist", async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Mock fetch failure
      global.fetch.mockResolvedValue({
        ok: false,
        status: 404,
        statusText: "Not Found",
        text: vi.fn().mockResolvedValue("Artifact not found"),
      });

      // Mock PR search success
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: "https://github.com/pr/123" }],
        },
      });

      // Call function
      const result = await getLabelAndActionImpl({
        ado_build_id: inputs.ado_build_id,
        ado_project_url: inputs.ado_project_url,
        head_sha: inputs.head_sha,
        github: mockGithub,
        core: mockCore,
      });

      // Verify result uses default values when artifact fetch fails
      expect(result).toEqual({
        labelName: "",
        labelAction: LabelAction.None,
        issueNumber: NaN,
      });
    });

    it("should throw error if resource is empty from the artifact api response", async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Mock artifact responses with 'remove' action
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({}),
      };

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes("artifacts?artifactName=")) {
          return mockArtifactResponse;
        }
      });

      // Call function and expect it to throw
      await expect(
        getLabelAndActionImpl({
          ado_build_id: inputs.ado_build_id,
          ado_project_url: inputs.ado_project_url,
          head_sha: inputs.head_sha,
          github: mockGithub,
          core: mockCore,
        }),
      ).rejects.toThrow();
    });

    it("should throw error if missing download url from the artifact api response", async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Mock artifact responses with 'remove' action
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({
          resource: {},
        }),
      };

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes("artifacts?artifactName=")) {
          return mockArtifactResponse;
        }
      });

      // Call function and expect it to throw
      await expect(
        getLabelAndActionImpl({
          ado_build_id: inputs.ado_build_id,
          ado_project_url: inputs.ado_project_url,
          head_sha: inputs.head_sha,
          github: mockGithub,
          core: mockCore,
        }),
      ).rejects.toThrow();
    });

    it("should throw error when fail to fetch artifact content", async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Mock fetch responses
      // First fetch - artifact metadata
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({
          resource: {
            downloadUrl: "https://dev.azure.com/download?format=zip",
          },
        }),
        text: vi.fn(),
      };

      // Second fetch - artifact content
      const mockContentResponse = {
        ok: false,
        status: 404,
        statusText: "Not Found",
        text: vi.fn().mockResolvedValue("Artifact not found"),
      };

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes("artifacts?artifactName=")) {
          return mockArtifactResponse;
        } else {
          return mockContentResponse;
        }
      });

      // Call function and expect it to throw
      await expect(
        getLabelAndActionImpl({
          ado_build_id: inputs.ado_build_id,
          ado_project_url: inputs.ado_project_url,
          head_sha: inputs.head_sha,
          github: mockGithub,
          core: mockCore,
        }),
      ).rejects.toThrow();
    });

    it("should handle exception during processing", async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        head_sha: "abc123",
      };

      // Mock fetch to throw an error
      global.fetch.mockImplementation(() => {
        throw new Error("Network error");
      });

      // Mock PR search success
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: "https://github.com/pr/123" }],
        },
      });

      // Start the async operation that will retry
      const promise = getLabelAndActionImpl({
        ado_build_id: inputs.ado_build_id,
        ado_project_url: inputs.ado_project_url,
        head_sha: inputs.head_sha,
        github: mockGithub,
        core: mockCore,
        // Change default retry delay from 1000ms to 1ms to reduce test time
        retryOptions: { initialDelayMs: 1 },
      });

      // Now expect the promise to reject
      await expect(promise).rejects.toThrow("Network error");
    }, 10000);
  });
});
