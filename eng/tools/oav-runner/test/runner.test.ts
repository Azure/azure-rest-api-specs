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

  it("should process a larger set of files and return a list of expected resolved swagger files", async () => {
    const changedFiles = [
      "specification/appcomplianceautomation/resource-manager/Microsoft.AppComplianceAutomation/stable/2024-06-27/examples/Evidence_CreateOrUpdate.json",
      "specification/appcomplianceautomation/resource-manager/Microsoft.AppComplianceAutomation/stable/2024-06-27/examples/Evidence_Download.json",
      "specification/appcomplianceautomation/resource-manager/Microsoft.AppComplianceAutomation/stable/2024-06-27/examples/ListInUseStorageAccountsWithSubscriptions.json",
      "specification/appcomplianceautomation/resource-manager/Microsoft.AppComplianceAutomation/stable/2024-06-27/examples/Report_GetScopingQuestions.json",
      "specification/apimanagement/resource-manager/Microsoft.ApiManagement/stable/2024-05-01/apimapiversionsets.json",
      "specification/apimanagement/resource-manager/Microsoft.ApiManagement/stable/2024-05-01/examples/ApiManagementListApiVersionSets.json",
      "specification/apimanagement/resource-manager/Microsoft.ApiManagement/stable/2024-05-01/examples/ApiManagementListCaches.json",
    ];
    const expected = [
      "specification/apimanagement/resource-manager/Microsoft.ApiManagement/stable/2024-05-01/apimapiversionsets.json",
      "specification/appcomplianceautomation/resource-manager/Microsoft.AppComplianceAutomation/stable/2024-06-27/appcomplianceautomation.json",
      "specification/apimanagement/resource-manager/Microsoft.ApiManagement/stable/2024-05-01/apimcaches.json",
    ];

    const result = await processFilesToSpecificationList(ROOT, changedFiles);
    expect(result.length).toEqual(expected.length);
    expect(result).toEqual(expected);
  });

  it("should process the correct swagger file given only changed example files", async () => {
    const changedFiles = [
      "specification/network/resource-manager/Microsoft.Network/stable/2024-07-01/examples/PublicIpPrefixDelete.json",
    ];
    const expected = [
      "specification/network/resource-manager/Microsoft.Network/stable/2024-07-01/publicIpPrefix.json",
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
