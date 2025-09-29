import { expect, test, vi } from "vitest";
import { validateSdkSuppressionsFile } from "../src/sdkSuppressions.js";
import {
  filterSuppressionList,
  getSdkNamesWithChangedSuppressions,
  processLabels,
} from "../src/updateSdkSuppressionsLabel.js";

vi.mock("process", () => ({
  exit: vi.fn(),
}));

test("test filterSuppressionList for only resource-manager files", () => {
  const changeFiles = [
    "specification/datafactory/resource-manager/Microsoft.DataFactory/stable/2018-06-01/datafactory.json",
    "specification/datafactory/resource-manager/sdk-suppressions.yaml",
  ];
  const suppressionsFiles: String[] = filterSuppressionList(changeFiles);
  expect(suppressionsFiles).toEqual([
    "specification/datafactory/resource-manager/sdk-suppressions.yaml",
  ]);
});

test("test filterSuppressionList for both tsp files and resource-manager files", () => {
  const changeFiles = [
    "specification/workloads/Workloads.Operations.Management/main.tsp",
    "specification/workloads/Workloads.Operations.Management/sdk-suppressions.yaml",
    "specification/workloads/resource-manager/Microsoft.Workloads/operations/preview/2023-10-01-preview/operations.json",
    "specification/workloads/resource-manager/Microsoft.Workloads/operations/preview/2024-02-01-preview/operations.json",
    "specification/workloads/resource-manager/Microsoft.Workloads/operations/preview/2023-12-01-preview/operations.json",
    "specification/workloads/resource-manager/Microsoft.Workloads/operations/stable/2024-09-01/operations.json",
    "specification/workloads/resource-manager/sdk-suppressions.yaml",
  ];
  const suppressionsFiles: String[] = filterSuppressionList(changeFiles);
  expect(suppressionsFiles).toEqual([
    "specification/workloads/Workloads.Operations.Management/sdk-suppressions.yaml",
  ]);
});

test("test validateSdkSuppressionsFile for sdk-suppression file", () => {
  const suppressionContent = {
    suppressions: {
      "azure-sdk-for-go": [
        {
          package: "sdk/resourcemanager/appcontainers/armappcontainers",
          "breaking-changes": [
            "Field `EndTime`, `StartTime`, `Status`, `Template` of struct `JobExecution` has been removed",
          ],
        },
      ],
      "azure-sdk-for-python": [
        {
          package: "azure-mgmt-appcontainers",
          "breaking-changes": ["Model BillingMeter no longer has parameter system_data"],
        },
      ],
    },
  };

  const validateResult = validateSdkSuppressionsFile(suppressionContent);
  expect(validateResult).toEqual({
    result: true,
    message: "This suppression file is a valid yaml.",
  });
});

test("test validateSdkSuppressionsFile for empty file", () => {
  const consoleSpy = vi.spyOn(console, "error").mockImplementation(() => {});

  expect(validateSdkSuppressionsFile(null)).toEqual({
    result: false,
    message: "This suppression file is a empty file",
  });
  expect(consoleSpy).toHaveBeenCalledWith("Error:", "This suppression file is a empty file");

  consoleSpy.mockRestore();
});

test("test validateSdkSuppressionsFile for undefined file", () => {
  const consoleSpy = vi.spyOn(console, "error").mockImplementation(() => {});

  expect(validateSdkSuppressionsFile(undefined)).toEqual({
    message:
      "This suppression file is not a valid yaml. Refer to https://aka.ms/azsdk/sdk-suppression for more information.",
    result: false,
  });
  expect(consoleSpy).toHaveBeenCalledWith(
    "Error:",
    "This suppression file is not a valid yaml. Refer to https://aka.ms/azsdk/sdk-suppression for more information.",
  );

  consoleSpy.mockRestore();
});

test("test validateSdkSuppressionsFile for error structor file", () => {
  const consoleSpy = vi.spyOn(console, "error").mockImplementation(() => {});

  const suppressionContent = {
    suppressions: {
      "azure-sdk-for-go": [
        {
          package: "sdk/resourcemanager/appcontainers/armappcontainers",
        },
      ],
      "azure-sdk-for-python": [
        {
          package: "azure-mgmt-appcontainers",
          "breaking-changes": ["Model BillingMeter no longer has parameter system_data"],
        },
      ],
    },
  };

  expect(validateSdkSuppressionsFile(suppressionContent)).toEqual({
    message:
      "This suppression file is a valid yaml but the schema is wrong: data/suppressions/azure-sdk-for-go/0 must have required property 'breaking-changes'",
    result: false,
  });
  expect(consoleSpy).toHaveBeenCalledWith(
    "Error:",
    "This suppression file is a valid yaml but the schema is wrong: data/suppressions/azure-sdk-for-go/0 must have required property 'breaking-changes'",
  );

  consoleSpy.mockRestore();
});

test("test getSdkNamesWithChangedSuppressions", () => {
  const headCont = {
    suppressions: {
      "azure-sdk-for-python": [
        {
          package: "azure-mgmt-appcontainers",
          "breaking-changes": ["Model BillingMeter no longer has parameter system_data AAA"],
        },
      ],
      "azure-sdk-for-go": [
        {
          package: "sdk/resourcemanager/appcontainers/armappcontainers",
          "breaking-changes": [
            "Field `EndTime`, `StartTime`, `Status`, `Template` of struct `JobExecution` has been removed",
          ],
        },
      ],
    },
  };
  const baseCont = {
    suppressions: {
      "azure-sdk-for-python": [
        {
          package: "azure-mgmt-appcontainers",
          "breaking-changes": ["Model BillingMeter no longer has parameter system_data"],
        },
      ],
      "azure-sdk-for-go": [
        {
          package: "sdk/resourcemanager/appcontainers/armappcontainers",
          "breaking-changes": [
            "Field `EndTime`, `StartTime`, `Status`, `Template` of struct `JobExecution` has been removed",
          ],
        },
      ],
    },
  };

  const sdkNames = getSdkNamesWithChangedSuppressions(headCont, baseCont);
  expect(sdkNames).toEqual(["azure-sdk-for-python"]);
});

test("test processLabels will add new label when has sdkNames", () => {
  const sdkNames: string[] = ["azure-sdk-for-go", "azure-sdk-for-js"];
  const presentLabels: string[] = ["aa", "BreakingChange-Go-Sdk-Suppression"];
  const result = processLabels(presentLabels, sdkNames);
  expect(result).toEqual({
    labelsToAdd: ["BreakingChange-JavaScript-Sdk-Suppression"],
    labelsToRemove: [],
  });
});

test("test processLabels will remove old label when has the sdkNames not exist", () => {
  const sdkNames: string[] = ["azure-sdk-for-js"];
  const presentLabels: string[] = ["aa", "BreakingChange-Go-Sdk-Suppression"];
  const result = processLabels(presentLabels, sdkNames);
  expect(result).toEqual({
    labelsToAdd: ["BreakingChange-JavaScript-Sdk-Suppression"],
    labelsToRemove: ["BreakingChange-Go-Sdk-Suppression"],
  });
});

test("test processLabels will not remove old label when has the sdkNames not exist & has corresponding suppression approved", () => {
  const sdkNames: string[] = ["azure-sdk-for-go"];
  const presentLabels: string[] = [
    "aa",
    "BreakingChange-Go-Sdk-Suppression",
    "BreakingChange-JavaScript-Sdk-Suppression",
    "BreakingChange-JavaScript-Sdk-Suppression-Approved",
  ];
  const result = processLabels(presentLabels, sdkNames);
  expect(result).toEqual({ labelsToAdd: [], labelsToRemove: [] });
});
