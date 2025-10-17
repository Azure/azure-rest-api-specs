import path from "path";
import { describe, expect, it } from "vitest";
import { processFilesToSpecificationList } from "../src/runner.js";

const ROOT = path.resolve(__dirname, "..", "test", "fixtures");

describe("file processing", () => {
  it("should process a basic set of files and return a list of swagger files only", async () => {
    const changedFiles = [
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
      "specification/serviceB/data-plane/service.B/readme.md",
    ];
    const expected = [
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });

  it("should process a larger set of files and return a list of expected resolved swagger files", async () => {
    const changedFiles = [
      "specification/serviceA/resource-manager/service.A/stable/2025-06-01/serviceAspec.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/CreateResource.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/DeleteResource.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/GetResource.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/GetRoot.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/ListResources.json",
    ];
    const expected = [
      "specification/serviceA/resource-manager/service.A/stable/2025-06-01/serviceAspec.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });

  it("should process the correct swagger file given only changed example files", async () => {
    const changedFiles = [
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/CreateResource.json",
    ];
    const expected = [
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });

  it("should process the correct swagger file given only changed readme file", async () => {
    const changedFiles = ["specification/serviceB/data-plane/service.B/readme.md"];
    const expected: string[] = [];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });

  it("should handle deleted files without error", async () => {
    const changedFiles = [
      // existing spec
      "specification/serviceA/resource-manager/service.A/stable/2025-06-01/serviceAspec.json",
      // existing example
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/CreateResource.json",
      // non-existent spec. Should not throw and quietly omit
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspecDeleted.json",
      // non-existent example. Should not throw and quietly omit
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/CreateResourceDeleted.json",
      // non-existent example and containing version folder. Should not throw and quietly omit
      "specification/serviceB/data-plane/service.B/stable/2025-06-01-deleted/examples/CreateResource.json",
    ];
    const expected = [
      "specification/serviceA/resource-manager/service.A/stable/2025-06-01/serviceAspec.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });
});
