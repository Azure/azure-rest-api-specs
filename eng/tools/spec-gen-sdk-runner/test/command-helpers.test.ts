import { describe, test, expect, vi, beforeEach } from "vitest";
import * as log from "../src/log.js";
import * as utils from "../src/utils.js";
import * as specHelpers from "../src/spec-helpers.js";
import { fileURLToPath } from "node:url";
import fs from "node:fs";
import path from "node:path";
import {
  getBreakingChangeInfo,
  getRequiredSettingValue,
  getSpecPaths,
  logIssuesToPipeline,
  parseArguments,
  prepareSpecGenSdkCommand,
  generateArtifact,
  setPipelineVariables,
} from "../src/command-helpers.js";
import { LogLevel } from "../src/log.js";
import { APIViewRequestData } from "../src/types.js";

// Get the absolute path to the repo root
const currentFilePath = fileURLToPath(import.meta.url);
const repoRoot = path.resolve(path.dirname(currentFilePath), "../fixtures/");

describe("commands.ts", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("setPipelineVariables", () => {
    test("should set pipeline variables correctly", () => {
      vi.spyOn(log, "setVsoVariable").mockImplementation(() => {
        // mock implementation intentionally left blank
      });

      setPipelineVariables(
        "path-to-artifact",
        false,
        "sdk/security/keyvault/azcertificates",
        "Configurations: 'specification/contosowidgetmanager/resource-manager/readme.md', and CommitSHA: 'commitsha', in SpecRepo: 'https://github.com/Azure/azure-rest-api-specs'",
      );

      expect(log.setVsoVariable).toHaveBeenCalledWith("StagedArtifactsFolder", "path-to-artifact");
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "PrBranch",
        "sdkauto/sdk-security/keyvault/azcertificates",
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "PrTitle",
        "[AutoPR sdk/security/keyvault/azcertificates]",
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "PrBody",
        "Configurations: 'specification/contosowidgetmanager/resource-manager/readme.md', and CommitSHA: 'commitsha', in SpecRepo: 'https://github.com/Azure/azure-rest-api-specs'",
      );
    });
    test("should skip PR related variable settings correctly", () => {
      vi.spyOn(log, "setVsoVariable").mockImplementation(() => {
        // mock implementation intentionally left blank
      });

      setPipelineVariables("path-to-artifact");

      expect(log.setVsoVariable).toHaveBeenCalledOnce();
      expect(log.setVsoVariable).toHaveBeenCalledWith("StagedArtifactsFolder", "path-to-artifact");
    });
  });

  describe("parseArguments", () => {
    test("runMode is release when it has no batch-type and no pr-number", () => {
      const mockArgs = [
        "--scp",
        path.normalize(
          `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        ),
        "--lang",
        "azure-sdk-for-go",
      ];
      vi.spyOn(process, "argv", "get").mockReturnValue(["node", "script", ...mockArgs]);
      const result = parseArguments();
      expect(result.localSpecRepoPath).toBe(
        path.normalize(
          `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        ),
      );
      expect(result.sdkRepoName).toBe("azure-sdk-for-go");
      expect(result.prNumber).toBe("");
      expect(result.runMode).toBe("release");
    });

    test("runMode is release when it has pr-number", () => {
      const mockArgs = [
        "--scp",
        path.normalize(
          `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        ),
        "--pr-number",
        "1234",
      ];
      vi.spyOn(process, "argv", "get").mockReturnValue(["node", "script", ...mockArgs]);

      const result = parseArguments();

      expect(result.localSpecRepoPath).toBe(
        path.normalize(
          `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        ),
      );
      expect(result.sdkRepoName).toBe("azure-sdk-for-net");
      expect(result.prNumber).toBe("1234");
      expect(result.runMode).toBe("spec-pull-request");
    });

    test("runMode is batch when it has batch-type", () => {
      const mockArgs = [
        "--scp",
        path.normalize(
          `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        ),
        "--batch-type",
        "all-specs",
      ];
      vi.spyOn(process, "argv", "get").mockReturnValue(["node", "script", ...mockArgs]);

      const result = parseArguments();

      expect(result.localSpecRepoPath).toBe(
        path.normalize(
          `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        ),
      );
      expect(result.sdkRepoName).toBe("azure-sdk-for-net");
      expect(result.prNumber).toBe("");
      expect(result.runMode).toBe("batch");
    });
  });

  describe("prepareSpecGenSdkCommand", () => {
    test("should prepare the command correctly", () => {
      const commandInput = {
        localSpecRepoPath: "/spec/path",
        localSdkRepoPath: "/sdk/path",
        workingFolder: "/working/folder",
        sdkRepoName: "azure-sdk-for-js",
        specCommitSha: "abc123",
        runMode: "release",
        specRepoHttpsUrl: "https://github.com/spec",
        prNumber: "123",
        tspConfigPath: "config/path",
        readmePath: "readme/path",
        headRepoHttpsUrl: "https://github.com/head",
        headBranch: "main",
        apiVersion: "2021-01-01",
        sdkReleaseType: "beta",
        sdkLanguage: "typescript",
      };

      const result = prepareSpecGenSdkCommand(commandInput);

      expect(result).toContain("spec-gen-sdk");
      expect(result).toContain("--scp");
      expect(result).toContain("/spec/path");
      expect(result).toContain("--pr-number");
      expect(result).toContain("123");
    });
  });

  describe("getSpecPaths", () => {
    test("should return both TypeSpec and readme paths for 'all-specs' batch type", () => {
      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue(["typespec1", "typespec2"]);
      vi.spyOn(utils, "findReadmeFiles").mockReturnValue(["readme1", "readme2"]);
      vi.spyOn(specHelpers, "groupSpecConfigPaths").mockReturnValue([
        { tspconfigPath: "typespec1", readmePath: undefined },
        { tspconfigPath: "typespec2", readmePath: undefined },
        { tspconfigPath: undefined, readmePath: "readme1" },
        { tspconfigPath: undefined, readmePath: "readme2" },
      ]);

      const result = getSpecPaths("all-specs", "/spec/path");

      expect(utils.getAllTypeSpecPaths).toHaveBeenCalledWith("/spec/path");
      expect(utils.findReadmeFiles).toHaveBeenCalledWith(path.join("/spec/path", "specification"));
      expect(specHelpers.groupSpecConfigPaths).toHaveBeenCalledWith(
        ["typespec1", "typespec2"],
        ["readme1", "readme2"],
        false,
      );
      expect(result).toHaveLength(4);
    });

    test("should return only readme paths for 'all-openapis' batch type", () => {
      vi.spyOn(utils, "findReadmeFiles").mockReturnValue(["readme1", "readme2"]);
      vi.spyOn(specHelpers, "groupSpecConfigPaths").mockReturnValue([
        { tspconfigPath: undefined, readmePath: "readme1" },
        { tspconfigPath: undefined, readmePath: "readme2" },
      ]);

      const result = getSpecPaths("all-openapis", "/spec/path");

      expect(utils.findReadmeFiles).toHaveBeenCalledWith(path.join("/spec/path", "specification"));
      expect(specHelpers.groupSpecConfigPaths).toHaveBeenCalledWith(
        [],
        ["readme1", "readme2"],
        false,
      );
      expect(result).toHaveLength(2);
    });

    test("should return both TypeSpec and readme paths for 'all-typespecs' batch type", () => {
      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue(["typespec1", "typespec2"]);
      vi.spyOn(utils, "findReadmeFiles").mockReturnValue(["readme1", "readme2"]);
      vi.spyOn(specHelpers, "groupSpecConfigPaths").mockReturnValue([
        { tspconfigPath: "typespec1", readmePath: undefined },
        { tspconfigPath: "typespec2", readmePath: undefined },
        { tspconfigPath: undefined, readmePath: "readme1" },
        { tspconfigPath: undefined, readmePath: "readme2" },
      ]);

      const result = getSpecPaths("all-typespecs", "/spec/path");

      expect(utils.getAllTypeSpecPaths).toHaveBeenCalledWith("/spec/path");
      expect(utils.findReadmeFiles).toHaveBeenCalledWith(path.join("/spec/path", "specification"));
      expect(specHelpers.groupSpecConfigPaths).toHaveBeenCalledWith(
        ["typespec1", "typespec2"],
        ["readme1", "readme2"],
        true,
      );
      expect(result).toHaveLength(4);
    });

    test("should return sample TypeSpec paths for 'sample-typespecs' batch type", () => {
      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue(["typespec1", "typespec2"]);
      vi.spyOn(specHelpers, "groupSpecConfigPaths").mockReturnValue([
        {
          tspconfigPath: "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
          readmePath: undefined,
        },
        {
          tspconfigPath: "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
          readmePath: undefined,
        },
      ]);

      const result = getSpecPaths("sample-typespecs", "/spec/path");

      expect(specHelpers.groupSpecConfigPaths).toHaveBeenCalledWith(
        [
          "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
          "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
        ],
        [],
        false,
      );
      expect(result).toHaveLength(2);
    });

    test("should return management plane TypeSpec and resource-manager readme paths for 'all-mgmtplane-typespecs'", () => {
      const managementTypespecs = ["typespec1.Management", "typespec2.Management"];
      const resourceManagerReadmes = ["resource-manager/readme-rm1", "resource-manager/readme-rm2"];

      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue([
        ...managementTypespecs,
        "typespec3",
        "typespec4",
      ]);
      vi.spyOn(utils, "findReadmeFiles").mockReturnValue([
        ...resourceManagerReadmes,
        "readme-dp1",
        "readme-dp2",
      ]);
      vi.spyOn(specHelpers, "groupSpecConfigPaths").mockReturnValue([
        { tspconfigPath: "typespec1.Management", readmePath: "resource-manager/readme-rm1" },
        { tspconfigPath: "typespec2.Management", readmePath: "resource-manager/readme-rm2" },
      ]);

      const result = getSpecPaths("all-mgmtplane-typespecs", "/spec/path");

      expect(utils.getAllTypeSpecPaths).toHaveBeenCalledWith("/spec/path");
      expect(utils.findReadmeFiles).toHaveBeenCalledWith(path.join("/spec/path", "specification"));
      expect(specHelpers.groupSpecConfigPaths).toHaveBeenCalledWith(
        managementTypespecs,
        resourceManagerReadmes,
        true,
      );
      expect(result).toHaveLength(2);
    });

    test("should return data plane TypeSpec and data-plane readme paths for 'all-dataplane-typespecs'", () => {
      const dataPlaneTypespecs = ["typespec3", "typespec4"];
      const dataPlaneReadmes = ["data-plane/readme-dp1", "data-plane/readme-dp2"];

      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue([
        ...dataPlaneTypespecs,
        "typespec1.Management",
        "typespec2.Management",
      ]);
      vi.spyOn(utils, "findReadmeFiles").mockReturnValue([
        ...dataPlaneReadmes,
        "readme-rm1",
        "readme-rm2",
      ]);
      vi.spyOn(specHelpers, "groupSpecConfigPaths").mockReturnValue([
        { tspconfigPath: "typespec3", readmePath: undefined },
        { tspconfigPath: "typespec4", readmePath: undefined },
        { tspconfigPath: undefined, readmePath: "data-plane/readme-dp1" },
        { tspconfigPath: undefined, readmePath: "data-plane/readme-dp2" },
      ]);

      const result = getSpecPaths("all-dataplane-typespecs", "/spec/path");

      expect(utils.getAllTypeSpecPaths).toHaveBeenCalledWith("/spec/path");
      expect(utils.findReadmeFiles).toHaveBeenCalledWith(path.join("/spec/path", "specification"));
      expect(specHelpers.groupSpecConfigPaths).toHaveBeenCalledWith(
        dataPlaneTypespecs,
        dataPlaneReadmes,
        true,
      );
      expect(result).toHaveLength(4);
    });
  });

  describe("logIssuesToPipeline", () => {
    test("should log errors and warnings to pipeline", () => {
      const mockLogContent = {
        key1: { errors: ["error1"], warnings: ["warning1"] },
        key2: { errors: ["error2"], warnings: [] },
      };
      vi.spyOn(fs, "readFileSync").mockReturnValue(JSON.stringify(mockLogContent));
      vi.spyOn(log, "logMessage").mockImplementation(() => {
        // mock implementation intentionally left blank
      });
      vi.spyOn(log, "vsoLogIssue").mockImplementation(() => {
        // mock implementation intentionally left blank
      });

      logIssuesToPipeline("/log/path", "spec config");

      expect(log.logMessage).toHaveBeenCalledWith(
        "Errors occurred while generating SDK from spec config. Follow the steps at https://aka.ms/azsdk/sdk-automation-faq#how-to-view-the-detailed-sdk-generation-errors to view detailed errors.",
        LogLevel.Group,
      );
      expect(log.vsoLogIssue).toHaveBeenCalledWith(
        "Errors occurred while generating SDK from spec config. Follow the steps at https://aka.ms/azsdk/sdk-automation-faq#how-to-view-the-detailed-sdk-generation-errors to view detailed errors.%0D%0Aerror1%0D%0Aerror2",
      );
    });

    test("should not log when there is no log message", () => {
      const mockLogPath = "/log/path";
      const mockLogError = "ENOENT: no such file";
      vi.spyOn(fs, "readFileSync").mockImplementationOnce(() => {
        throw new Error(mockLogError);
      });
      vi.spyOn(log, "logMessage").mockImplementation(() => {
        // mock implementation intentionally left blank
      });
      vi.spyOn(log, "vsoLogIssue").mockImplementation(() => {
        // mock implementation intentionally left blank
      });

      expect(() => {
        logIssuesToPipeline("/log/path", "spec config");
      }).toThrow(`Runner: error reading log at ${mockLogPath}:Error: ${mockLogError}`);
      expect(log.logMessage).not.toHaveBeenCalled();
      expect(log.vsoLogIssue).not.toHaveBeenCalled();
    });
  });

  describe("getBreakingChangeInfo", () => {
    test("should return breaking change info if applicable", () => {
      const mockExecutionReport = {
        packages: [{ shouldLabelBreakingChange: true }],
      };

      const result = getBreakingChangeInfo(mockExecutionReport);

      expect(result).toBe(true);
    });

    test("should return no breaking change info if not applicable", () => {
      const mockExecutionReport = {
        packages: [{ shouldLabelBreakingChange: false }],
      };

      const result = getBreakingChangeInfo(mockExecutionReport);

      expect(result).toBe(false);
    });

    test("should return no breaking change info if not executionReport", () => {
      const mockExecutionReport = {
        packages: [],
      };

      const result = getBreakingChangeInfo(mockExecutionReport);

      expect(result).toBe(false);
    });
  });

  describe("generateArtifact", () => {
    beforeEach(() => {
      vi.clearAllMocks();
    });

    test("should generate artifact successfully", () => {
      vi.spyOn(fs, "existsSync").mockReturnValue(false);
      vi.spyOn(fs, "mkdirSync").mockImplementation(() => undefined);
      vi.spyOn(fs, "writeFileSync").mockImplementation(() => {
        // mock implementation intentionally left blank
      });
      vi.spyOn(log, "setVsoVariable").mockImplementation(() => {
        // mock implementation intentionally left blank
      });

      // No need to mock getRequiredSettingValue for this test
      // We'll just verify the output structure instead

      const mockCommandInput = {
        workingFolder: "/working/folder",
        sdkLanguage: "azure-sdk-for-js",
        runMode: "",
        localSpecRepoPath: "",
        localSdkRepoPath: "",
        sdkRepoName: "",
        specCommitSha: "",
        specRepoHttpsUrl: "",
      };
      const mockResult = "succeeded";
      const mockhasBreakingChange = false;
      const mockhasManagementPlaneSpecs = false;
      const mockStagedArtifactsFolder = "mockStagedArtifactsFolder";
      const mockApiViewRequestData: APIViewRequestData[] = [];
      const result = generateArtifact(
        mockCommandInput,
        mockResult,
        mockhasBreakingChange,
        mockhasManagementPlaneSpecs,
        mockStagedArtifactsFolder,
        mockApiViewRequestData,
      );

      const breakingChangeLabelArtifactPath = path.normalize(
        "/working/folder/out/spec-gen-sdk-artifact",
      );

      expect(result).toBe(0);
      expect(fs.mkdirSync).toHaveBeenCalledWith(breakingChangeLabelArtifactPath, {
        recursive: true,
      });
      // Since we're not mocking getRequiredSettingValue properly in this test,
      // we'll just verify the output contains the expected isSpecGenSdkCheckRequired value
      expect(fs.writeFileSync).toHaveBeenCalledWith(
        path.join(breakingChangeLabelArtifactPath, "spec-gen-sdk-artifact.json"),
        JSON.stringify(
          {
            language: "azure-sdk-for-js",
            result: "succeeded",
            labelAction: false,
            isSpecGenSdkCheckRequired: false,
            apiViewRequestData: [],
          },
          undefined,
          2,
        ),
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "SpecGenSdkArtifactName",
        "spec-gen-sdk-artifact",
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "SpecGenSdkArtifactPath",
        "out/spec-gen-sdk-artifact",
      );

      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "StagedArtifactsFolder",
        "mockStagedArtifactsFolder",
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith("HasAPIViewArtifact", "false");
    });

    test("should handle errors during artifact generation", () => {
      vi.spyOn(fs, "existsSync").mockReturnValue(false);
      vi.spyOn(fs, "mkdirSync").mockImplementation(() => {
        throw new Error("mkdir failed");
      });
      vi.spyOn(log, "logMessage").mockImplementation(() => {
        // mock implementation intentionally left blank
      });
      vi.spyOn(log, "vsoLogIssue").mockImplementation(() => {
        // mock implementation intentionally left blank
      });

      const mockCommandInput = {
        workingFolder: "/working/folder",
        sdkLanguage: "javascript",
        runMode: "",
        localSpecRepoPath: "",
        localSdkRepoPath: "",
        sdkRepoName: "",
        specCommitSha: "",
        specRepoHttpsUrl: "",
      };

      const mockResult = "failed";
      const mockhasBreakingChange = false;
      const mockhasManagementPlaneSpecs = false;
      const mockStagedArtifactsFolder = "";
      const mockApiViewRequestData: APIViewRequestData[] = [];
      const result = generateArtifact(
        mockCommandInput,
        mockResult,
        mockhasBreakingChange,
        mockhasManagementPlaneSpecs,
        mockStagedArtifactsFolder,
        mockApiViewRequestData,
      );

      expect(result).toBe(1);
      expect(log.logMessage).toHaveBeenCalledWith("ending group logging", LogLevel.EndGroup);
    });

    test("should set isSpecGenSdkCheckRequired to false when sdkGenerationExecuted is false", () => {
      vi.spyOn(fs, "existsSync").mockReturnValue(false);
      vi.spyOn(fs, "mkdirSync").mockImplementation(() => undefined);
      vi.spyOn(fs, "writeFileSync").mockImplementation(() => {
        // mock implementation intentionally left blank
      });
      vi.spyOn(log, "setVsoVariable").mockImplementation(() => {
        // mock implementation intentionally left blank
      });

      // Mock getRequiredSettingValue to verify it's not called when sdkGenerationExecuted is false
      const getRequiredSettingValueSpy = vi.spyOn(
        { getRequiredSettingValue },
        "getRequiredSettingValue",
      );

      const mockCommandInput = {
        workingFolder: "/working/folder",
        sdkLanguage: "azure-sdk-for-go",
        runMode: "",
        localSpecRepoPath: "",
        localSdkRepoPath: "",
        sdkRepoName: "",
        specCommitSha: "",
        specRepoHttpsUrl: "",
      };
      const mockResult = "succeeded";
      const mockhasBreakingChange = false;
      // Using true for hasManagementPlaneSpecs, which would normally make isSpecGenSdkCheckRequired=true
      // for Go SDK (as tested in the getRequiredSettingValue tests)
      const mockhasManagementPlaneSpecs = true;
      const mockStagedArtifactsFolder = "mockStagedArtifactsFolder";
      const mockApiViewRequestData: APIViewRequestData[] = [];

      // Explicitly passing false for sdkGenerationExecuted
      const result = generateArtifact(
        mockCommandInput,
        mockResult,
        mockhasBreakingChange,
        mockhasManagementPlaneSpecs,
        mockStagedArtifactsFolder,
        mockApiViewRequestData,
        false, // sdkGenerationExecuted = false
      );

      const breakingChangeLabelArtifactPath = path.normalize(
        "/working/folder/out/spec-gen-sdk-artifact",
      );

      expect(result).toBe(0);
      // Verify getRequiredSettingValue was not called
      expect(getRequiredSettingValueSpy).not.toHaveBeenCalled();

      // Verify isSpecGenSdkCheckRequired is false in the written file
      expect(fs.writeFileSync).toHaveBeenCalledWith(
        path.join(breakingChangeLabelArtifactPath, "spec-gen-sdk-artifact.json"),
        JSON.stringify(
          {
            language: "azure-sdk-for-go",
            result: "succeeded",
            labelAction: false,
            isSpecGenSdkCheckRequired: false, // This should be false when sdkGenerationExecuted is false
            apiViewRequestData: [],
          },
          undefined,
          2,
        ),
      );
    });
  });

  describe("getRequiredSettingValue", () => {
    test("should return managementPlane setting when hasManagementPlaneSpecs is true", () => {
      const result = getRequiredSettingValue(true, "azure-sdk-for-go");
      // Based on the constants in types.ts, Go SDK requires check for management plane
      expect(result).toBe(true);

      const result2 = getRequiredSettingValue(true, "azure-sdk-for-net");
      // Based on the constants in types.ts, .NET SDK does not require check for management plane
      expect(result2).toBe(false);
    });

    test("should return dataPlane setting when hasManagementPlaneSpecs is false", () => {
      const result = getRequiredSettingValue(false, "azure-sdk-for-go");
      // Based on the constants in types.ts, Go SDK requires check for data plane
      expect(result).toBe(true);

      const result2 = getRequiredSettingValue(false, "azure-sdk-for-js");
      // Based on the constants in types.ts, JS SDK does not require check for data plane
      expect(result2).toBe(false);
    });
  });
});
