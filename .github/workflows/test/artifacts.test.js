import { describe, expect, it, vi } from "vitest";
import {
  getAzurePipelineArtifact,
  getAdoBuildInfoFromUrl,
} from "../src/artifacts.js";
import { createMockCore } from "./mocks.js";

// Mock dependencies
vi.mock("../src/context.js", () => ({
  extractInputs: vi.fn(),
}));

// Mock global fetch
global.fetch = vi.fn();
const mockCore = createMockCore();

describe("getAzurePipelineArtifact function", () => {
  const inputs = {
    ado_build_id: "12345",
    ado_project_url: "https://dev.azure.com/project",
    artifactName: "spec-gen-sdk-artifact",
    artifactFileName: "spec-gen-sdk-artifact.json",
    core: mockCore,
  };
  it("should handle API failure", async () => {
    // Mock fetch failure
    global.fetch.mockResolvedValue({
      ok: false,
      status: 500,
      statusText: "Server Error",
      text: vi.fn().mockResolvedValue("Artifact not found"),
    });

    // Call function
    const result = await getAzurePipelineArtifact({
      ado_build_id: inputs.ado_build_id,
      ado_project_url: inputs.ado_project_url,
      artifactName: inputs.artifactName,
      artifactFileName: inputs.artifactFileName,
      core: inputs.core,
    });

    // Verify result uses default values when artifact fetch fails
    expect(result).toEqual({
      artifactData: "",
    });

    // Verify error was logged
    expect(mockCore.error).toHaveBeenCalled();
  });

  it("should complete without op when artifact does not exist", async () => {
    // Mock fetch failure
    global.fetch.mockResolvedValue({
      ok: false,
      status: 404,
      statusText: "Not Found",
      text: vi.fn().mockResolvedValue("Artifact not found"),
    });

    // Call function
    const result = await getAzurePipelineArtifact({
      ado_build_id: inputs.ado_build_id,
      ado_project_url: inputs.ado_project_url,
      artifactName: inputs.artifactName,
      artifactFileName: inputs.artifactFileName,
      core: inputs.core,
    });

    // Verify result uses default values when artifact fetch fails
    expect(result).toEqual({
      artifactData: "",
    });
  });

  it("should throw error if resource is empty from the artifact api response", async () => {
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
      getAzurePipelineArtifact({
        ado_build_id: inputs.ado_build_id,
        ado_project_url: inputs.ado_project_url,
        artifactName: inputs.artifactName,
        artifactFileName: inputs.artifactFileName,
        core: inputs.core,
      }),
    ).rejects.toThrow();
  });

  it("should throw error if missing download url from the artifact api response", async () => {
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
      getAzurePipelineArtifact({
        ado_build_id: inputs.ado_build_id,
        ado_project_url: inputs.ado_project_url,
        artifactName: inputs.artifactName,
        artifactFileName: inputs.artifactFileName,
        core: inputs.core,
      }),
    ).rejects.toThrow();
  });

  it("should throw error when fail to fetch artifact content", async () => {
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
      getAzurePipelineArtifact({
        ado_build_id: inputs.ado_build_id,
        ado_project_url: inputs.ado_project_url,
        artifactName: inputs.artifactName,
        artifactFileName: inputs.artifactFileName,
        core: inputs.core,
      }),
    ).rejects.toThrow();
  });

  it("should handle exception during processing", async () => {
    // Mock fetch to throw an error
    global.fetch.mockImplementation(() => {
      throw new Error("Network error");
    });

    // Start the async operation that will retry
    const promise = getAzurePipelineArtifact({
      ado_build_id: inputs.ado_build_id,
      ado_project_url: inputs.ado_project_url,
      artifactName: inputs.artifactName,
      artifactFileName: inputs.artifactFileName,
      core: inputs.core,
      // Change default retry delay from 1000ms to 1ms to reduce test time
      retryOptions: { initialDelayMs: 1 },
    });

    // Now expect the promise to reject
    await expect(promise).rejects.toThrow("Network error");
  }, 10000);

  it("should return artifact content", async () => {
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
      ok: true,
      text: vi.fn().mockResolvedValue(
        JSON.stringify({
          labelAction: true,
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
    const result = await getAzurePipelineArtifact({
      ado_build_id: inputs.ado_build_id,
      ado_project_url: inputs.ado_project_url,
      artifactName: inputs.artifactName,
      artifactFileName: inputs.artifactFileName,
      core: inputs.core,
    });
    // Verify result
    expect(result).toEqual({
      artifactData: JSON.stringify({
        labelAction: true,
      }),
    });
  });
});

describe("getAdoBuildInfoFromUrl function", () => {
  it("should extract project URL and build ID from a valid URL", () => {
    const buildUrl =
      "https://dev.azure.com/azure-sdk/_build/results?buildId=12345&view=logs";
    const result = getAdoBuildInfoFromUrl(buildUrl);

    expect(result).toEqual({
      projectUrl: "https://dev.azure.com/azure-sdk",
      buildId: "12345",
    });
  });

  it("should extract build ID when it's not the first parameter", () => {
    const buildUrl =
      "https://dev.azure.com/azure-sdk/_build/results?view=logs&buildId=54321";
    const result = getAdoBuildInfoFromUrl(buildUrl);

    expect(result).toEqual({
      projectUrl: "https://dev.azure.com/azure-sdk",
      buildId: "54321",
    });
  });

  it("should throw error when URL format is invalid", () => {
    const invalidUrl = "https://dev.azure.com/azure-sdk/wrong-format";

    expect(() => {
      getAdoBuildInfoFromUrl(invalidUrl);
    }).toThrow("Could not extract build ID or project URL from the URL");
  });

  it("should throw error when buildId is missing", () => {
    const invalidUrl =
      "https://dev.azure.com/azure-sdk/_build/results?view=logs";

    expect(() => {
      getAdoBuildInfoFromUrl(invalidUrl);
    }).toThrow("Could not extract build ID or project URL from the URL");
  });
});
