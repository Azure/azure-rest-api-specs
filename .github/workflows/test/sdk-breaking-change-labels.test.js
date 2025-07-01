import { beforeEach, describe, expect, it, vi } from "vitest";
import { sdkLabels } from "../../shared/src/sdk-types.js";
import { LabelAction } from "../src/label.js";
import { getLabelAndAction, getLabelAndActionImpl } from "../src/sdk-breaking-change-labels.js";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.js";

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
        details_url: "https://dev.azure.com/project/_build/results?buildId=12345",
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
            prNumber: "123",
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
    });
    it("should correctly set labelAction to Remove", async () => {
      // Setup inputs
      const inputs = {
        details_url: "https://dev.azure.com/project/_build/results?buildId=12345",
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
            prNumber: "123",
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
        details_url: "",
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
        details_url: "https://dev.azure.com/project/_build/results?buildId=12345",
        head_sha: "abc123",
      };

      // Mock fetch failure
      global.fetch.mockResolvedValue({
        ok: false,
        status: 500,
        statusText: "Server Error",
        text: vi.fn().mockResolvedValue("Artifact not found"),
      });

      // Call function
      const result = await getLabelAndActionImpl({
        details_url: inputs.details_url,
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
        details_url: "https://dev.azure.com/project/_build/results?buildId=12345",
        head_sha: "abc123",
      };

      // Mock fetch to handle the artifact URL with 404 error and fallback behavior
      global.fetch.mockImplementation((url) => {
        if (url.includes("artifacts?artifactName=spec-gen-sdk-artifact")) {
          // Initial fetch for the specific artifact returns 404
          return Promise.resolve({
            ok: false,
            status: 404,
            statusText: "Not Found",
            text: vi.fn().mockResolvedValue("Artifact not found"),
          });
        } else if (url.includes("artifacts?api-version=7.0") && !url.includes("artifactName=")) {
          // List artifacts API call (used by fetchFailedArtifact)
          return Promise.resolve({
            ok: true,
            json: vi.fn().mockResolvedValue({
              value: [
                {
                  name: "spec-gen-sdk-artifact-failed",
                  id: "12345",
                  resource: {
                    downloadUrl: "https://dev.azure.com/download-failed?format=zip",
                  },
                },
              ],
            }),
          });
        } else if (url.includes("artifactName=spec-gen-sdk-artifact-failed")) {
          // Fetch for the failed artifact version returns 404 too
          return Promise.resolve({
            ok: false,
            status: 404,
            statusText: "Not Found",
            text: vi.fn().mockResolvedValue("Failed artifact not found either"),
          });
        }
        // Default response for other URLs
        return Promise.resolve({
          ok: true,
          text: vi.fn().mockResolvedValue("{}"),
        });
      });

      // Call function
      const result = await getLabelAndActionImpl({
        details_url: inputs.details_url,
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
        details_url: "https://dev.azure.com/project/_build/results?buildId=12345",
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
          details_url: inputs.details_url,
          head_sha: inputs.head_sha,
          github: mockGithub,
          core: mockCore,
        }),
      ).rejects.toThrow();
    });

    it("should throw error if missing download url from the artifact api response", async () => {
      // Setup inputs
      const inputs = {
        details_url: "https://dev.azure.com/project/_build/results?buildId=12345",
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
          details_url: inputs.details_url,
          head_sha: inputs.head_sha,
          github: mockGithub,
          core: mockCore,
        }),
      ).rejects.toThrow();
    });

    it("should throw error when fail to fetch artifact content", async () => {
      // Setup inputs
      const inputs = {
        details_url: "https://dev.azure.com/project/_build/results?buildId=12345",
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
          details_url: inputs.details_url,
          head_sha: inputs.head_sha,
          github: mockGithub,
          core: mockCore,
        }),
      ).rejects.toThrow();
    });

    it("should handle exception during processing", async () => {
      // Setup inputs
      const inputs = {
        details_url: "https://dev.azure.com/project/_build/results?buildId=12345",
        head_sha: "abc123",
      };

      // Mock fetch to throw an error
      global.fetch.mockImplementation(() => {
        throw new Error("Network error");
      });

      // Start the async operation that will retry
      const promise = getLabelAndActionImpl({
        details_url: inputs.details_url,
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
