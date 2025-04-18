import { describe, test, expect, vi, beforeEach } from "vitest";
import * as log from "../../src/log.js";
import * as utils from "../../src/utils.js";
import * as changeFiles from "../../src/change-files.js";
import { fileURLToPath } from "node:url";
import path from "node:path";
import fs from "node:fs";
import {
  setPipelineVariables,
  parseArguments,
  prepareSpecGenSdkCommand,
  getSpecPaths,
  logIssuesToPipeline,
  getBreakingChangeInfo,
  processBreakingChangeLabelArtifacts,
  generateSdkForSingleSpec,
  generateSdkForSpecPr,
  //   generateSdkForBatchSpecs,
} from "../../src/commands.js";
import * as commands from "../../src/commands.js";

// Get the absolute path to the repo root
const currentFilePath = fileURLToPath(import.meta.url);
const repoRoot = path.resolve(path.dirname(currentFilePath), "../fixtures/");

describe("commands.ts", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("setPipelineVariables", () => {
    test("should set pipeline variables correctly", () => {
      vi.spyOn(log, "setVsoVariable").mockImplementation(() => {});

      setPipelineVariables(
        "sdk/security/keyvault/azcertificates",
        "Configurations: 'specification/contosowidgetmanager/resource-manager/readme.md', and CommitSHA: 'aaabbb', in SpecRepo: 'https://github.com/Azure/azure-rest-api-specs'",
      );

      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "PrBranch",
        "sdkauto/sdk_security/keyvault/azcertificates",
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "PrTitle",
        "[AutoPR sdk/security/keyvault/azcertificates]",
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "PrBody",
        "Configurations: 'specification/contosowidgetmanager/resource-manager/readme.md', and CommitSHA: 'aaabbb', in SpecRepo: 'https://github.com/Azure/azure-rest-api-specs'",
      );
    });
  });

  describe("parseArguments", () => {
    test("runMode is release when it has no batch-type and no pr-number", () => {
      const mockArgs = [
        "--scp",
        `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        "--lang",
        "azure-sdk-for-go",
      ];
      vi.spyOn(process, "argv", "get").mockReturnValue(["node", "script", ...mockArgs]);
      const result = parseArguments();
      expect(result.localSpecRepoPath).toBe(
        `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
      );
      expect(result.sdkRepoName).toBe("azure-sdk-for-go");
      expect(result.prNumber).toBe("");
      expect(result.runMode).toBe("release");
    });

    test("runMode is release when it has pr-number", () => {
      const mockArgs = [
        "--scp",
        `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        "--pr-number",
        "1234",
      ];
      vi.spyOn(process, "argv", "get").mockReturnValue(["node", "script", ...mockArgs]);

      const result = parseArguments();

      expect(result.localSpecRepoPath).toBe(
        `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
      );
      expect(result.sdkRepoName).toBe("azure-sdk-for-net");
      expect(result.prNumber).toBe("1234");
      expect(result.runMode).toBe("spec-pull-request");
    });

    test("runMode is batch when it has batch-type", () => {
      const mockArgs = [
        "--scp",
        `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
        "--batch-type",
        "all-specs",
      ];
      vi.spyOn(process, "argv", "get").mockReturnValue(["node", "script", ...mockArgs]);

      const result = parseArguments();

      expect(result.localSpecRepoPath).toBe(
        `${repoRoot}specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json"`,
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

    test("should return only TypeSpec paths for 'all-typespecs' batch type", () => {
      vi.spyOn(utils, "getAllTypeSpecPaths").mockReturnValue(["typespec1", "typespec2"]);

      const result = getSpecPaths("all-typespecs", "/spec/path");

      expect(result).toEqual(["typespec1", "typespec2"]);
    });
  });

  describe("logIssuesToPipeline", () => {
    test("should log errors and warnings to pipeline", () => {
      const mockLogContent = {
        key1: { errors: ["error1"], warnings: ["warning1"] },
        key2: { errors: ["error2"], warnings: [] },
      };
      vi.spyOn(fs, "readFileSync").mockReturnValue(JSON.stringify(mockLogContent));
      vi.spyOn(log, "logMessage").mockImplementation(() => {});
      vi.spyOn(log, "vsoLogIssue").mockImplementation(() => {});

      logIssuesToPipeline("/log/path", "spec config");

      expect(log.logMessage).toHaveBeenCalledWith(
        "Errors occurred while generating SDK from spec config",
        "group",
      );
      expect(log.vsoLogIssue).toHaveBeenCalledWith(
        "Errors occurred while generating SDK from spec config%0D%0Aerror1%0D%0Aerror2",
      );
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
  });

  describe("processBreakingChangeLabelArtifacts", () => {
    beforeEach(() => {
      vi.clearAllMocks();
    });
    test("should process breaking change label artifacts successfully", () => {
      vi.spyOn(fs, "existsSync").mockReturnValue(false);
      vi.spyOn(fs, "mkdirSync").mockImplementation(() => undefined);
      vi.spyOn(fs, "writeFileSync").mockImplementation(() => {});
      vi.spyOn(log, "setVsoVariable").mockImplementation(() => {});

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

      const result = processBreakingChangeLabelArtifacts(mockCommandInput, true, "breaking-change");

      const breakingChangeLabelArtifactPath = "/working/folder/out/breaking-change-label-artifact";
      expect(result).toBe(0);
      expect(fs.mkdirSync).toHaveBeenCalledWith(breakingChangeLabelArtifactPath, {
        recursive: true,
      });
      expect(fs.writeFileSync).toHaveBeenCalledWith(
        path.join(breakingChangeLabelArtifactPath, "spec-gen-sdk-breaking-change-artifact.json"),
        JSON.stringify({
          language: "javascript",
          labelAction: true,
        }),
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "BreakingChangeLabelArtifactName",
        "spec-gen-sdk-breaking-change-artifact",
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith(
        "BreakingChangeLabelArtifactPath",
        "out/breaking-change-label-artifact",
      );
      expect(log.setVsoVariable).toHaveBeenCalledWith("BreakingChangeLabelAction", "add");
      expect(log.setVsoVariable).toHaveBeenCalledWith("BreakingChangeLabel", "breaking-change");
    });

    test("should handle errors during artifact processing", () => {
      vi.spyOn(fs, "existsSync").mockReturnValue(false);
      vi.spyOn(fs, "mkdirSync").mockImplementation(() => {
        throw new Error("mkdir failed");
      });
      vi.spyOn(log, "logMessage").mockImplementation(() => {});
      vi.spyOn(log, "vsoLogIssue").mockImplementation(() => {});

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
      const result = processBreakingChangeLabelArtifacts(mockCommandInput, true, "breaking-change");

      expect(result).toBe(1);
      expect(log.logMessage).toHaveBeenCalledWith("ending group logging", "endgroup");
    });
  });

  describe("generateSdkForSingleSpec", () => {
    beforeEach(() => {
      vi.clearAllMocks();
    });

    test("should generate SDK successfully", async () => {
      vi.spyOn(fs, "readFileSync").mockReturnValue(
        JSON.stringify({
          executionResult: "succeeded",
          packages: [{ packageName: "test-package", installationInstructions: "install" }],
        }),
      );
      vi.spyOn(log, "setVsoVariable").mockImplementation(() => {});
      vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValueOnce(undefined);
      const result = await generateSdkForSingleSpec();

      expect(result).toBe(0);
      expect(utils.runSpecGenSdkCommand).toHaveBeenCalled();
      expect(log.setVsoVariable).toHaveBeenCalledWith("PrBranch", "sdkauto/test-package");
    });

    test("should handle errors during SDK generation", async () => {
      vi.spyOn(utils, "runSpecGenSdkCommand").mockRejectedValueOnce(new Error("Command failed"));
      const result = await generateSdkForSingleSpec();

      expect(result).toBe(1);
      expect(utils.runSpecGenSdkCommand).toHaveBeenCalled();
    });
  });

  describe("generateSdkForSpecPr", () => {
    beforeEach(() => {
      vi.clearAllMocks();
    });

    test("should process changed specs and generate SDKs", async () => {
      vi.spyOn(changeFiles, "detectChangedSpecConfigFiles").mockReturnValueOnce([
        {
          specs: [
            "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/widgets.json",
            "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
            "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp",
          ],
          readmeMd: "specification/contosowidgetmanager/data-plane/readme.md",
          typespecProject:
            "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
        },
      ]);
      vi.spyOn(utils, "resetGitRepo").mockResolvedValueOnce(undefined);
      vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValueOnce(undefined);
      vi.spyOn(fs, "readFileSync").mockReturnValue(
        JSON.stringify({
          executionResult: "succeeded",
          packages: [{ shouldLabelBreakingChange: true, breakingChangeLabel: "breaking-change" }],
        }),
      );

      vi.spyOn(fs, "existsSync").mockReturnValue(false);
      vi.spyOn(fs, "mkdirSync").mockImplementation(() => undefined);
      vi.spyOn(fs, "writeFileSync").mockImplementation(() => {});

      const result = await generateSdkForSpecPr();
      expect(utils.runSpecGenSdkCommand).toHaveBeenCalled();
      expect(result).toBe(0);
    });

    test("should handle errors during spec processing", async () => {
      vi.spyOn(changeFiles, "detectChangedSpecConfigFiles").mockReturnValueOnce([
        {
          specs: [
            "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/widgets.json",
            "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
            "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp",
          ],
          readmeMd: "specification/contosowidgetmanager/data-plane/readme.md",
          typespecProject:
            "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
        },
      ]);
      vi.spyOn(utils, "runSpecGenSdkCommand").mockRejectedValueOnce(new Error("Command failed"));

      const result = await generateSdkForSpecPr();

      expect(result).toBe(1);
    });
  });

  describe("generateSdkForBatchSpecs", () => {
    beforeEach(() => {
      vi.clearAllMocks();
    });

    test("should generate SDKs for batch specs successfully", async () => {
      // Mock getSpecPaths to return a list of specs
      vi.spyOn(commands, "getSpecPaths").mockReturnValueOnce(["spec1", "spec2"]);

      // Mock other dependencies
      vi.spyOn(utils, "resetGitRepo").mockResolvedValueOnce(undefined);
      vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValue(undefined);
      vi.spyOn(fs, "readFileSync").mockReturnValue(
        JSON.stringify({
          executionResult: "succeeded",
        }),
      );

      vi.spyOn(log, "logMessage").mockImplementation(() => {});

      // Call the function
      const result = await commands.generateSdkForBatchSpecs("all-specs");

      // Assertions
      expect(result).toBe(0);
      expect(commands.getSpecPaths).toHaveBeenCalledWith("all-specs", expect.any(String));
      expect(utils.runSpecGenSdkCommand).toHaveBeenCalledTimes(2); // Called for each spec
      expect(log.logMessage).toHaveBeenCalledWith("Runner command executed successfully");
    });

    /**
    test("should handle errors during batch spec generation", async () => {
      // Mock getSpecPaths to return a list of specs
      vi.spyOn(commands, "getSpecPaths").mockReturnValueOnce(["spec1", "spec2"]);
  
      // Mock runSpecGenSdkCommand to throw an error for the first spec
      vi.spyOn(utils, "runSpecGenSdkCommand")
        .mockRejectedValueOnce(new Error("Command failed"))
        .mockResolvedValueOnce(undefined); // Second spec succeeds
  
      // Mock other dependencies
      vi.spyOn(utils, "resetGitRepo").mockResolvedValueOnce(undefined);
      vi.spyOn(commands, "getExecutionReport").mockReturnValue({
        executionResult: "succeeded",
      });
      vi.spyOn(log, "logMessage").mockImplementation(() => {});
  
      // Call the function
      const result = await commands.generateSdkForBatchSpecs("all-specs");
  
      // Assertions
      expect(result).toBe(1); // Overall result should indicate failure
      expect(commands.getSpecPaths).toHaveBeenCalledWith("all-specs", expect.any(String));
      expect(utils.runSpecGenSdkCommand).toHaveBeenCalledTimes(2); // Called for each spec
      expect(log.logMessage).toHaveBeenCalledWith(
        "Runner: error executing command:Error: Command failed",
        "error"
      );
    });
    test("should handle empty spec paths gracefully", async () => {
      vi.spyOn(commands, "getSpecPaths").mockReturnValueOnce([]);
  
      vi.spyOn(log, "logMessage").mockImplementation(() => {});
  
      const result = await commands.generateSdkForBatchSpecs("all-specs");
  
      expect(result).toBe(0); // No specs to process, so result should be success
      expect(commands.getSpecPaths).toHaveBeenCalledWith("all-specs", expect.any(String));
      expect(utils.runSpecGenSdkCommand).not.toHaveBeenCalled(); // No specs, so no commands run
      expect(log.logMessage).toHaveBeenCalledWith("No specs to process for batch type: all-specs");
    });

     */
  });
});
