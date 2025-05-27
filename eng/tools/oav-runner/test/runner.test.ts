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
    const expected = [
      "specification/machinelearningservices/resource-manager/Microsoft.MachineLearningServices/stable/2022-05-01/mfe.json",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });

  it("should process a large set of files and return a list of swagger files only", () => {});

  it("should process the correct swagger file given only changed example files", async () => {
    const changedFiles = [
      "specification/network/resource-manager/Microsoft.Network/stable/2024-07-01/examples/PublicIpPrefixDelete.json",
    ];
    const expected = [
      "azure-rest-api-specs/specification/network/resource-manager/Microsoft.Network/stable/2024-07-01/publicIpPrefix.json",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });

  it("should process the correct swagger file given only changed readme file", async () => {
    const changedFiles = ["specification/network/resource-manager/readme.md"];
    const expected: string[] = [];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });

  it("should handle deleted files without error", async () => {
    const changedFiles = [
      "specification/machinelearningservices/resource-manager/Microsoft.MachineLearningServices/stable/2022-05-01/mfe.json",
      // non-existent file. Should not throw and quietly omit
      "specification/machinelearningservices/resource-manager/Microsoft.MachineLearningServices/stable/2022-05-01/mfe1.json",
    ];
    const expected = [
      "specification/machinelearningservices/resource-manager/Microsoft.MachineLearningServices/stable/2022-05-01/mfe.json",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result).toEqual(expected);
  });
});
