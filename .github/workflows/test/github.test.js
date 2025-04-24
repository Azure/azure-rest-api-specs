import { describe, expect, vi, it } from "vitest";
import { writeToActionsSummary } from "../src/github.js";
import { createMockCore } from "./mocks.js";
import fs from "fs";

const mockCore = createMockCore();
// Mock the entire fs module
vi.mock("fs", async () => {
  const actual = await vi.importActual("fs");
  return {
    ...actual,
    appendFileSync: vi.fn(),
  };
});

describe("writeToActionsSummary function", () => {
  it("should warn when GITHUB_STEP_SUMMARY isn't set", async () => {
    // Mock value
    const originalEnvValue = process.env.GITHUB_STEP_SUMMARY;
    process.env.GITHUB_STEP_SUMMARY = "";

    // Call function
    const result = await writeToActionsSummary("Test content", mockCore);

    // Verify result
    expect(result).undefined;

    // Verify warning was logged
    expect(mockCore.warning).toHaveBeenCalled();
    process.env.GITHUB_STEP_SUMMARY = originalEnvValue;
  });
  it("should return without error", async () => {
    const originalEnvValue = process.env.GITHUB_STEP_SUMMARY;
    process.env.GITHUB_STEP_SUMMARY = "/tmp/test-summary.md";

    // Call function
    const result = await writeToActionsSummary("Test content", mockCore);

    // Verify result
    expect(result).undefined;
    expect(mockCore.info).toHaveBeenCalled();
    process.env.GITHUB_STEP_SUMMARY = originalEnvValue;
  });
  it("should handle exception", async () => {
    // Mock
    const originalEnvValue = process.env.GITHUB_STEP_SUMMARY;
    process.env.GITHUB_STEP_SUMMARY = "/tmp/test-summary.md";

    // Create spy on appendFileSync before each test
    const appendFileSyncMock = vi
      .spyOn(fs, "appendFileSync")
      .mockImplementation(vi.fn());

    // Make appendFileSync throw an error
    appendFileSyncMock.mockImplementation(() => {
      throw new Error("Mock file write error");
    });

    // Call function and validate
    await expect(
      writeToActionsSummary("Test content", mockCore),
    ).rejects.toThrow();

    // Restore original implementation after each test
    appendFileSyncMock.mockRestore();
    process.env.GITHUB_STEP_SUMMARY = originalEnvValue;
  });
});
