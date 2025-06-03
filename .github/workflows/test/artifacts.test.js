import { describe, expect, it, vi, beforeEach } from "vitest";
import {
  getAzurePipelineArtifact,
  getAdoBuildInfoFromUrl,
  fetchFailedArtifact,
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

  // Reset mocks before each test
  beforeEach(() => {
    vi.resetAllMocks();
  });

  it("should pass headers to fetchFailedArtifact when using fallback mechanism", async () => {
    const testToken = "test-auth-token";
    const expectedHeaders = {
      "Content-Type": "application/json",
      Authorization: `Bearer ${testToken}`,
    };

    // Mock initial fetch failure with 404
    const mockInitialResponse = {
      ok: false,
      status: 404,
      statusText: "Not Found",
      text: vi.fn().mockResolvedValue("Artifact not found"),
    };

    // Mock list artifacts response
    const mockListResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        value: [
          {
            name: "spec-gen-sdk-artifact-FailedAttempt1",
            resource: { downloadUrl: "https://example.com/download2" },
          },
        ],
      }),
      status: 200,
      statusText: "OK",
    };

    // Mock response for fetching specific failed artifact
    const mockFailedArtifactResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        resource: {
          downloadUrl:
            "https://example.com/failed-artifact-download?format=zip",
        },
      }),
      status: 200,
      statusText: "OK",
    };

    // Mock successful download of artifact content
    const mockContentResponse = {
      ok: true,
      text: vi.fn().mockResolvedValue(JSON.stringify({ failedData: true })),
    };

    // Setup fetch to capture headers and return appropriate responses
    global.fetch.mockImplementation((url, options) => {
      // For all calls, verify the headers include the authorization token
      if (options && options.headers) {
        expect(options.headers).toEqual(expectedHeaders);
      }

      // First attempted artifact request with 404
      if (
        url.includes(
          `artifacts?artifactName=${inputs.artifactName}&api-version=7.0`,
        )
      ) {
        return mockInitialResponse;
      }
      // List all artifacts request
      else if (
        url.includes("artifacts?api-version=7.0") &&
        !url.includes("artifactName=")
      ) {
        return mockListResponse;
      }
      // Request for failed artifact
      else if (
        url.includes("artifactName=spec-gen-sdk-artifact-FailedAttempt1")
      ) {
        return mockFailedArtifactResponse;
      }
      // Content download request
      else if (url.includes("format=file&subPath=")) {
        return mockContentResponse;
      }

      return {
        ok: false,
        status: 404,
        statusText: "URL not matched in test mock",
        text: vi.fn().mockResolvedValue("URL not matched in test mock"),
      };
    });

    // Call function with fallbackToFailedArtifact set to true
    const result = await getAzurePipelineArtifact({
      ...inputs,
      token: testToken,
      fallbackToFailedArtifact: true,
    });

    // Verify result contains the data from the failed artifact
    expect(result).toEqual({
      artifactData: JSON.stringify({
        failedData: true,
      }),
    });

    // Verify fetch was called multiple times with the auth headers
    expect(global.fetch).toHaveBeenCalledWith(
      expect.any(String),
      expect.objectContaining({
        headers: expectedHeaders,
      }),
    );
  });

  it("should include authorization header when token is provided", async () => {
    const testToken = "test-auth-token";

    // Mock fetch responses
    const mockArtifactResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        resource: {
          downloadUrl: "https://dev.azure.com/download?format=zip",
        },
      }),
      text: vi.fn(),
    };

    const mockContentResponse = {
      ok: true,
      text: vi.fn().mockResolvedValue(JSON.stringify({ labelAction: true })),
    };

    // Setup fetch with a spy to capture the headers
    global.fetch.mockImplementation((url, options) => {
      if (url.includes("artifacts?artifactName=")) {
        // Verify headers contain Authorization
        expect(options.headers).toHaveProperty(
          "Authorization",
          `Bearer ${testToken}`,
        );
        return mockArtifactResponse;
      } else {
        // Verify headers contain Authorization for the content download as well
        expect(options.headers).toHaveProperty(
          "Authorization",
          `Bearer ${testToken}`,
        );
        return mockContentResponse;
      }
    });

    // Call function with token
    const result = await getAzurePipelineArtifact({
      ...inputs,
      token: testToken,
    });

    // Verify result
    expect(result).toEqual({
      artifactData: JSON.stringify({ labelAction: true }),
    });

    // Verify fetch was called with the right headers
    expect(global.fetch).toHaveBeenCalledWith(
      expect.any(String),
      expect.objectContaining({
        headers: expect.objectContaining({
          "Content-Type": "application/json",
          Authorization: `Bearer ${testToken}`,
        }),
      }),
    );
  });

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

  it("should fallback to failed artifacts when specified and primary artifact not found", async () => {
    // Mock initial fetch failure with 404
    const mockInitialResponse = {
      ok: false,
      status: 404,
      statusText: "Not Found",
      text: vi.fn().mockResolvedValue("Artifact not found"),
    };

    // Mock list artifacts response
    const mockListResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        value: [
          {
            name: "spec-gen-sdk-artifact-FailedAttempt2",
            resource: { downloadUrl: "https://example.com/download1" },
          },
          {
            name: "spec-gen-sdk-artifact-FailedAttempt1",
            resource: { downloadUrl: "https://example.com/download2" },
          },
        ],
      }),
      status: 200,
      statusText: "OK",
    };

    // Mock response for fetching specific failed artifact
    const mockFailedArtifactResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        resource: {
          downloadUrl:
            "https://example.com/failed-artifact-download?format=zip",
        },
      }),
      status: 200,
      statusText: "OK",
    };

    // Mock successful download of artifact content
    const mockContentResponse = {
      ok: true,
      text: vi.fn().mockResolvedValue(
        JSON.stringify({
          failedData: true,
        }),
      ),
    };

    // Setup fetch to return different responses based on the URL
    global.fetch.mockImplementation((url) => {
      // First attempted artifact request with 404
      if (
        url.includes(
          `artifacts?artifactName=${inputs.artifactName}&api-version=7.0`,
        )
      ) {
        return mockInitialResponse;
      }
      // List all artifacts request
      else if (
        url.includes("artifacts?api-version=7.0") &&
        !url.includes("artifactName=")
      ) {
        return mockListResponse;
      }
      // Request for failed artifact - notice we use the first item from mockListResponse
      else if (
        url.includes("artifactName=spec-gen-sdk-artifact-FailedAttempt2")
      ) {
        return mockFailedArtifactResponse;
      }
      // Content download request
      else if (url.includes("format=file&subPath=")) {
        return mockContentResponse;
      }
      return {
        ok: false,
        status: 404,
        statusText: "URL not matched in test mock",
        text: vi.fn().mockResolvedValue("URL not matched in test mock"),
      };
    });

    // Call function with fallbackToFailedArtifact set to true
    const result = await getAzurePipelineArtifact({
      ado_build_id: inputs.ado_build_id,
      ado_project_url: inputs.ado_project_url,
      artifactName: inputs.artifactName,
      artifactFileName: inputs.artifactFileName,
      core: inputs.core,
      fallbackToFailedArtifact: true,
    });

    // Verify result contains the data from the failed artifact
    expect(result).toEqual({
      artifactData: JSON.stringify({
        failedData: true,
      }),
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
  // Reset mocks before each test
  beforeEach(() => {
    vi.resetAllMocks();
  });

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

describe("fetchFailedArtifact function", () => {
  const defaultParams = {
    ado_build_id: "12345",
    ado_project_url: "https://dev.azure.com/testorg/testproject",
    artifactName: "spec-gen-sdk-artifact",
    core: mockCore,
    retryOptions: {},
  };

  // Reset mocks before each test
  beforeEach(() => {
    vi.resetAllMocks();
  });

  it("should use the provided headers when making requests", async () => {
    const customHeaders = {
      "Content-Type": "application/json",
      Authorization: "Bearer test-token",
      "Custom-Header": "test-value",
    };

    // Setup mock responses
    const mockListResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        value: [
          {
            name: "spec-gen-sdk-artifact-FailedAttempt1",
            resource: { downloadUrl: "https://example.com/download1" },
          },
        ],
      }),
      status: 200,
      statusText: "OK",
    };

    const mockFetchResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        resource: { downloadUrl: "https://example.com/artifact-download" },
      }),
      status: 200,
      statusText: "OK",
    };

    // Setup fetch with a spy to capture the headers
    global.fetch.mockImplementation((url, options) => {
      // Verify that the custom headers are included in all requests
      expect(options.headers).toEqual(customHeaders);

      if (
        url.includes("artifacts?api-version") &&
        !url.includes("artifactName=")
      ) {
        return mockListResponse;
      } else {
        return mockFetchResponse;
      }
    });

    // Call the function with custom headers
    const response = await fetchFailedArtifact({
      ...defaultParams,
      headers: customHeaders,
    });

    // Verify response is correct
    expect(response).toBe(mockFetchResponse);

    // Verify fetch was called with custom headers
    expect(global.fetch).toHaveBeenCalledWith(
      expect.any(String),
      expect.objectContaining({
        headers: customHeaders,
      }),
    );
  });

  it("should fetch the failed artifact successfully", async () => {
    // Setup mock responses
    // First call to list artifacts
    const mockArtifacts = {
      value: [
        {
          name: "spec-gen-sdk-artifact-FailedAttempt2",
          resource: { downloadUrl: "https://example.com/download1" },
        },
        {
          name: "spec-gen-sdk-artifact-FailedAttempt1",
          resource: { downloadUrl: "https://example.com/download2" },
        },
        {
          name: "other-artifact",
          resource: { downloadUrl: "https://example.com/download3" },
        },
      ],
    };

    // Mock responses for API calls
    const mockListResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue(mockArtifacts),
      status: 200,
      statusText: "OK",
    };

    const mockFetchResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        resource: { downloadUrl: "https://example.com/artifact-download" },
      }),
      status: 200,
      statusText: "OK",
    };

    // Setup fetch to return different responses for each call
    global.fetch.mockImplementation((url) => {
      if (url.includes("artifacts?api-version")) {
        return mockListResponse;
      } else if (
        url.includes("artifactName=spec-gen-sdk-artifact-FailedAttempt2")
      ) {
        return mockFetchResponse;
      }
    });

    // Call the function
    const response = await fetchFailedArtifact(defaultParams);

    // Verify response is correct
    expect(response).toBe(mockFetchResponse);
  });

  it("should throw an error when no matching artifacts are found", async () => {
    // Mock response with no matching artifacts
    const mockListResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        value: [
          {
            name: "other-artifact-1",
            resource: { downloadUrl: "https://example.com/download1" },
          },
          {
            name: "other-artifact-2",
            resource: { downloadUrl: "https://example.com/download2" },
          },
        ],
      }),
      status: 200,
      statusText: "OK",
    };

    global.fetch.mockResolvedValue(mockListResponse);

    // Call the function and expect it to throw
    await expect(fetchFailedArtifact(defaultParams)).rejects.toThrow(
      `No artifacts found with name containing ${defaultParams.artifactName}`,
    );
  });

  it("should throw an error when listing artifacts fails", async () => {
    // Mock a failed response
    const mockErrorResponse = {
      ok: false,
      status: 500,
      statusText: "Internal Server Error",
    };

    global.fetch.mockResolvedValue(mockErrorResponse);

    // Call the function and expect it to throw
    await expect(fetchFailedArtifact(defaultParams)).rejects.toThrow(
      `Failed to fetch artifacts: 500, Internal Server Error`,
    );
  });

  it("should sort artifacts in descending order and select the first one", async () => {
    // Mock response with artifacts in unsorted order
    const mockListResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        value: [
          {
            name: "spec-gen-sdk-artifact-FailedAttempt1",
            resource: { downloadUrl: "https://example.com/download1" },
          },
          {
            name: "spec-gen-sdk-artifact-FailedAttempt3",
            resource: { downloadUrl: "https://example.com/download3" },
          },
          {
            name: "spec-gen-sdk-artifact-FailedAttempt2",
            resource: { downloadUrl: "https://example.com/download2" },
          },
        ],
      }),
      status: 200,
      statusText: "OK",
    };

    // Mock response for fetching specific artifact
    const mockFetchResponse = {
      ok: true,
      json: vi.fn().mockResolvedValue({
        resource: { downloadUrl: "https://example.com/artifact-download" },
      }),
      status: 200,
      statusText: "OK",
    };

    // Setup fetch to return different responses for each call
    global.fetch.mockImplementation((url) => {
      if (url.includes("artifacts?api-version")) {
        return mockListResponse;
      } else if (
        url.includes("artifactName=spec-gen-sdk-artifact-FailedAttempt3")
      ) {
        return mockFetchResponse;
      }
    });

    // Call the function
    const response = await fetchFailedArtifact(defaultParams);

    // Verify response is correct
    expect(response).toBe(mockFetchResponse);
  });
});
