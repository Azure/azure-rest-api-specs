import { test, describe, expect } from "vitest";
import { parseSwaggerFilePath, getSwaggersToProcess } from "../src/api-doc-preview-util.js";

describe("parseSwaggerFilePath", () => {
  test("returns null for invalid path", () => {
    const result = parseSwaggerFilePath("invalid/path/to/swagger.json");
    expect(result).toBeNull();
  });

  test("parses valid swagger file path", () => {
    const path =
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json";
    const result = parseSwaggerFilePath(path);

    expect(result).toEqual({
      path: path,
      serviceName: "batch",
      serviceType: "data-plane",
      resourceProvider: "Azure.Batch",
      releaseState: "preview",
      apiVersion: "2024-07-01.20.0",
      fileName: "BatchService.json",
    });
  });
});

describe("getSwaggersToProcess", () => {
  test("returns empty array for no files", () => {
    const { selectedVersion, swaggersToProcess } = getSwaggersToProcess([]);

    expect(selectedVersion).toEqual(null);
    expect(swaggersToProcess).toEqual([]);
  });

  test("returns swaggers to process for valid files", () => {
    const files = [
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json",
    ];

    const { selectedVersion, swaggersToProcess } = getSwaggersToProcess(files);

    expect(selectedVersion).toEqual("2024-07-01.20.0");
    expect(swaggersToProcess).toEqual(files);
  });

  test("selects the latest version from multiple files with multiple versions", () => {
    const files = [
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json",
      "specification/batch/data-plane/Azure.Batch/preview/2025-06-01/BatchService.json",
    ];

    const { selectedVersion, swaggersToProcess } = getSwaggersToProcess(files);

    expect(selectedVersion).toEqual("2025-06-01");
    expect(swaggersToProcess).toEqual([files[1]]);
  });
});
