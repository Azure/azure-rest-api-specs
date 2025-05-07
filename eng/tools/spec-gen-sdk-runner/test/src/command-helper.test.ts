import { describe, test, expect, vi, beforeEach } from "vitest";
import * as log from "../../src/log.js";
import * as utils from "../../src/utils.js";
import { fileURLToPath } from "node:url";
import fs from "node:fs";
import path from "node:path";
import {
  getBreakingChangeInfo,
  getSpecPaths,
  logIssuesToPipeline,
  parseArguments,
  prepareSpecGenSdkCommand,
  generateArtifact,
  setPipelineVariables,
} from "../../src/command-helpers.js";
import { LogLevel } from "../../src/log.js";

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
        "sdk/security/keyvault/azcertificates",
        "Configurations: 'specification/contosowidgetmanager/resource-manager/readme.md', and CommitSHA: 'commitsha', in SpecRepo: 'https://github.com/Azure/azure-rest-api-specs'",
      );

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
    test("should return all specs for 'all-specs' batch type", () => {
      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue(["typespec1", "typespec2"]);
      vi.spyOn(utils, "findReadmeFiles").mockReturnValue(["readme1", "readme2"]);

      const result = getSpecPaths("all-specs", "/spec/path");
      expect(result).toEqual(["typespec1", "typespec2", "readme1", "readme2"]);
    });

    test("should return only readme paths for 'all-openapis' batch type", () => {
      vi.spyOn(utils, "findReadmeFiles").mockReturnValue(["readme1", "readme2"]);

      const result = getSpecPaths("all-openapis", "/spec/path");
      expect(result).toEqual(["readme1", "readme2"]);
    });

    test("should return only TypeSpec paths for 'all-typespecs' batch type", () => {
      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue(["typespec1", "typespec2"]);

      const result = getSpecPaths("all-typespecs", "/spec/path");
      expect(result).toEqual(["typespec1", "typespec2"]);
    });

    test("should return sample TypeSpec paths for 'sample-typespecs' batch type", () => {
      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue(["typespec1", "typespec2"]);

      const result = getSpecPaths("sample-typespecs", "/spec/path");
      expect(result).toEqual([
        "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
      ]);
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
        "Errors occurred while generating SDK from spec config",
        LogLevel.Group,
      );
      expect(log.vsoLogIssue).toHaveBeenCalledWith(
        "Errors occurred while generating SDK from spec config%0D%0Aerror1%0D%0Aerror2",
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

      expect(() => { logIssuesToPipeline("/log/path", "spec config"); }).toThrow(
        `Runner: error reading log at ${mockLogPath}:Error: ${mockLogError}`,
      );
      expect(log.logMessage).not.toHaveBeenCalled();
      expect(log.vsoLogIssue).not.toHaveBeenCalled();
    });
  });

  describe("getBreakingChangeInfo", () => {
    test("should return breaking change info if applicable", () => {
      const mockExecutionReport = {
        packages: [{ shouldLabelBreakingChange: true, breakingChangeLabel: "breaking-change" }],
      };

      const result = getBreakingChangeInfo(mockExecutionReport);

      expect(result).toEqual([true, "breaking-change"]);
    });

    test("should return no breaking change info if not applicable", () => {
      const mockExecutionReport = {
        packages: [{ shouldLabelBreakingChange: false, breakingChangeLabel: "" }],
      };

      const result = getBreakingChangeInfo(mockExecutionReport);

      expect(result).toEqual([false, ""]);
    });

    test("should return no breaking change info if not executionReport", () => {
      const mockExecutionReport = {
        packages: [],
      };

      const result = getBreakingChangeInfo(mockExecutionReport);

      expect(result).toEqual([false, ""]);
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
      const mockResult = "succeeded";
      const mockBreakingchangeLabel = "breaking-change";
      const mockhasBreakingChange = false;
      const mockhasManagementPlaneSpecs = false;
      const result = generateArtifact(
        mockCommandInput,
        mockResult,
        mockBreakingchangeLabel,
        mockhasBreakingChange,
        mockhasManagementPlaneSpecs,
      );

      const breakingChangeLabelArtifactPath = path.normalize(
        "/working/folder/out/spec-gen-sdk-artifact",
      );

      expect(result).toBe(0);
      expect(fs.mkdirSync).toHaveBeenCalledWith(breakingChangeLabelArtifactPath, {
        recursive: true,
      });
      expect(fs.writeFileSync).toHaveBeenCalledWith(
        path.join(breakingChangeLabelArtifactPath, "spec-gen-sdk-artifact.json"),
        JSON.stringify(
          {
            language: "javascript",
            result: "succeeded",
            labelAction: false,
            isSpecGenSdkCheckRequired: false,
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
      expect(log.setVsoVariable).toHaveBeenCalledWith("BreakingChangeLabelAction", "remove");
      expect(log.setVsoVariable).toHaveBeenCalledWith("BreakingChangeLabel", "breaking-change");
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
      const mockBreakingchangeLabel = "breaking-change";
      const mockhasBreakingChange = false;
      const mockhasManagementPlaneSpecs = false;
      const result = generateArtifact(
        mockCommandInput,
        mockResult,
        mockBreakingchangeLabel,
        mockhasBreakingChange,
        mockhasManagementPlaneSpecs,
      );

      expect(result).toBe(1);
      expect(log.logMessage).toHaveBeenCalledWith("ending group logging", LogLevel.EndGroup);
    });
  });
});
