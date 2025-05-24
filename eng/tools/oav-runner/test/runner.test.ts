import { describe, it, expect } from "vitest";
import { processFilesToSpecificationList } from "../src/runner.js";
import path from "path";

const ROOT = path.resolve(__dirname, "../../../../");

describe("file processing", () => {
  it("should process a basic set of files and return a list of swagger files only", async () => {
    const changedFiles = [
      "specification/machinelearningservices/resource-manager/Microsoft.MachineLearningServices/stable/2022-05-01/mfe.json",
      "specification/machinelearningservices/resource-manager/readme.md",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    const expected = [
      "specification/machinelearningservices/resource-manager/Microsoft.MachineLearningServices/stable/2022-05-01/mfe.json",
    ];

    expect(result).toEqual(expected);
  });

  it("should process a large set of files and return a list of swagger files only", () => {});

  it("should process the correct swagger file given only changed example files", () => {});

  it("should process the correct swagger file given only changed readme file", () => {});

  it("should handle deleted files without error", () => {});
});
