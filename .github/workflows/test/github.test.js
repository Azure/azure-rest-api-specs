import { describe, expect, it } from "vitest";
import { writeToActionsSummary } from "../src/github.js";
import { createMockCore } from "./mocks.js";

const mockCore = createMockCore();

describe("writeToActionsSummary function", () => {
  it("should add content to the summary and write it", async () => {
    // Call function
    const result = await writeToActionsSummary("Test content", mockCore);

    // Verify result
    expect(result).undefined;

    // Verify summary methods were called
    expect(mockCore.summary.addRaw).toHaveBeenCalledWith("Test content");
    expect(mockCore.summary.write).toHaveBeenCalled();
  });

  it("should handle exception", async () => {
    // Create a mock with a write method that throws an error
    const mockCoreWithError = createMockCore();
    mockCoreWithError.summary.write.mockRejectedValue(
      new Error("Mock write error"),
    );

    // Call function and validate it throws
    await expect(
      writeToActionsSummary("Test content", mockCoreWithError),
    ).rejects.toThrow("Failed to write to the GitHub Actions summary");
  });
});
