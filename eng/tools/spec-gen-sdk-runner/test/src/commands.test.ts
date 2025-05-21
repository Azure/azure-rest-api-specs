import { describe, test, expect, vi, beforeEach, type Mock } from "vitest";
import * as utils from "../../src/utils.js";
import {
  generateSdkForBatchSpecs,
  generateSdkForSingleSpec,
  generateSdkForSpecPr,
} from "../../src/commands.js";
import * as commandHelpers from "../../src/command-helpers.js";
import * as log from "../../src/log.js";
import * as changeFiles from "../../src/change-files.js";
import fs from "node:fs";
import path from "node:path";
import { LogLevel } from "../../src/log.js";

function getNormalizedFsCalls(mockFn: Mock): unknown[][] {
  return mockFn.mock.calls.map((args: unknown[]) => {
    const [filePath, ...rest] = args;
    return [String(filePath).replaceAll("\\", "/"), ...rest];
  });
}

describe("generateSdkForSingleSpec", () => {
  beforeEach(() => {
    vi.resetAllMocks();
  });

  test("should execute the SDK generation command successfully", async () => {
    const mockCommandInput = {
      tspConfigPath: "path/to/tspconfig.yaml",
      readmePath: "path/to/readme.md",
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      localSdkRepoPath: "/sdk/path",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };

    const mockExecutionReport = {
      executionResult: "succeeded",
      packages: [
        {
          packageName: "test-package",
          installationInstructions: "npm install test-package",
        },
      ],
      vsoLogPath: "path/to/log",
    };

    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockCommandInput);
    vi.spyOn(commandHelpers, "prepareSpecGenSdkCommand").mockReturnValue(["mock-command"]);
    vi.spyOn(commandHelpers, "getExecutionReport").mockReturnValue(mockExecutionReport);
    vi.spyOn(commandHelpers, "setPipelineVariables").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(commandHelpers, "logIssuesToPipeline").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValue(undefined);
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    vi.spyOn(fs, "readFileSync").mockReturnValue(
      JSON.stringify({
        executionResult: "succeeded",
        packages: [{ packageName: "test-package", installationInstructions: "install" }],
      }),
    );
    vi.spyOn(log, "setVsoVariable").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValueOnce(undefined);

    const result = await generateSdkForSingleSpec();
    expect(result).toBe(0);
    expect(log.logMessage).toHaveBeenCalledWith(
      `Generating SDK from ${mockCommandInput.tspConfigPath} ${mockCommandInput.readmePath}`,
      LogLevel.Group,
    );
    expect(log.logMessage).toHaveBeenCalledWith("Runner command executed successfully");
    expect(commandHelpers.setPipelineVariables).toHaveBeenCalledWith(
      "test-package",
      "npm install test-package",
    );
    expect(commandHelpers.logIssuesToPipeline).toHaveBeenCalledWith(
      mockExecutionReport.vsoLogPath,
      `${mockCommandInput.tspConfigPath} ${mockCommandInput.readmePath}`,
    );
  });

  test("should handle errors during SDK generation", async () => {
    const mockCommandInput = {
      tspConfigPath: "path/to/tspconfig.yaml",
      readmePath: "path/to/readme.md",
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      localSdkRepoPath: "/sdk/path",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };

    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockCommandInput);
    vi.spyOn(commandHelpers, "prepareSpecGenSdkCommand").mockReturnValue(["mock-command"]);
    vi.spyOn(commandHelpers, "logIssuesToPipeline").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(commandHelpers, "setPipelineVariables").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(utils, "runSpecGenSdkCommand").mockRejectedValue(new Error("Command failed"));
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const result = await generateSdkForSingleSpec();

    expect(result).toBe(1);
    expect(utils.runSpecGenSdkCommand).toHaveBeenCalled();
    expect(utils.runSpecGenSdkCommand).toHaveBeenCalledWith(["mock-command"]);
    expect(log.logMessage).toHaveBeenCalledWith(
      `Runner: error executing command:Error: Command failed`,
      LogLevel.Error,
    );
    expect(commandHelpers.setPipelineVariables).not.toHaveBeenCalled();
  });

  test("should handle errors during execution report reading", async () => {
    const mockCommandInput = {
      tspConfigPath: "path/to/tspconfig.yaml",
      readmePath: "path/to/readme.md",
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      localSdkRepoPath: "/sdk/path",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };

    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockCommandInput);
    vi.spyOn(commandHelpers, "prepareSpecGenSdkCommand").mockReturnValue(["mock-command"]);
    vi.spyOn(commandHelpers, "logIssuesToPipeline").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(commandHelpers, "setPipelineVariables").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(commandHelpers, "getExecutionReport").mockImplementation(() => {
      throw new Error("Failed to read execution report");
    });
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const statusCode = await generateSdkForSingleSpec();

    expect(statusCode).toBe(1);
    expect(log.logMessage).toHaveBeenCalledWith(
      "Runner: error reading execution-report.json:Error: Failed to read execution report",
      LogLevel.Error,
    );
  });
});

describe("generateSdkForSpecPr", () => {
  beforeEach(() => {
    vi.resetAllMocks();
  });

  test("should execute the SDK generation command for changed specs successfully", async () => {
    const mockCommandInput = {
      localSdkRepoPath: "path/to/local/repo",
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };
    const mockChangedSpecs = [
      {
        specs: [
          "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
        ],
        typespecProject: "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
        readmeMd: "specification/contosowidgetmanager/resource-manager/readme.md",
      },
    ];
    const mockExecutionReport = {
      executionResult: "succeeded",
      packages: [],
      vsoLogPath: "path/to/log",
    };

    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockCommandInput);
    vi.spyOn(commandHelpers, "prepareSpecGenSdkCommand").mockReturnValue(["mock-command"]);
    vi.spyOn(changeFiles, "detectChangedSpecConfigFiles").mockReturnValue(mockChangedSpecs);
    vi.spyOn(utils, "resetGitRepo").mockResolvedValue(undefined);
    vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValue(undefined);
    vi.spyOn(commandHelpers, "getExecutionReport").mockReturnValue(mockExecutionReport);
    vi.spyOn(commandHelpers, "getBreakingChangeInfo").mockReturnValue([false, ""]);
    vi.spyOn(commandHelpers, "generateArtifact").mockReturnValue(0);
    vi.spyOn(commandHelpers, "logIssuesToPipeline").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const statusCode = await generateSdkForSpecPr();

    expect(statusCode).toBe(0);
    expect(log.logMessage).toHaveBeenCalledWith(
      `Generating SDK from ${mockChangedSpecs[0].typespecProject} ${mockChangedSpecs[0].readmeMd}`,
      LogLevel.Group,
    );
    expect(log.logMessage).toHaveBeenCalledWith(`Runner command executed successfully`);
    expect(log.logMessage).toHaveBeenCalledWith(
      `Runner command execution result:${mockExecutionReport.executionResult}`,
    );
    expect(log.logMessage).toHaveBeenCalledWith("ending group logging", LogLevel.EndGroup);
    expect(commandHelpers.logIssuesToPipeline).toHaveBeenCalledWith(
      mockExecutionReport.vsoLogPath,
      `${mockChangedSpecs[0].typespecProject} ${mockChangedSpecs[0].readmeMd}`,
    );
  });

  test("should skip specs with no valid config files", async () => {
    const mockCommandInput = {
      localSdkRepoPath: "path/to/local/repo",
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };
    const mockChangedSpecs = [{ specs: [] }];

    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockCommandInput);
    vi.spyOn(changeFiles, "detectChangedSpecConfigFiles").mockReturnValue(mockChangedSpecs);
    vi.spyOn(commandHelpers, "generateArtifact").mockReturnValue(0);
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const statusCode = await generateSdkForSpecPr();

    expect(statusCode).toBe(0);
    expect(log.logMessage).toHaveBeenCalledWith(
      "Runner: no spec config file found in the changed files",
      LogLevel.Warn,
    );
  });

  test("should handle errors during fail run runSpecGenSdkCommand for a changed spec", async () => {
    const mockCommandInput = {
      localSdkRepoPath: "path/to/local/repo",
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };
    const mockChangedSpecs = [
      {
        specs: [
          "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
        ],
        typespecProject: "path/to/tspconfig.yaml",
        readmeMd: "path/to/readme.md",
      },
    ];

    const mockExecutionReport = {
      executionResult: "succeeded",
      vsoLogPath: "path/to/log",
    };
    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockCommandInput);
    vi.spyOn(commandHelpers, "prepareSpecGenSdkCommand").mockReturnValue(["mock-command"]);
    vi.spyOn(changeFiles, "detectChangedSpecConfigFiles").mockReturnValue(mockChangedSpecs);
    vi.spyOn(utils, "runSpecGenSdkCommand").mockRejectedValue(new Error("Command failed"));
    vi.spyOn(utils, "resetGitRepo").mockImplementation(() => Promise.resolve());
    vi.spyOn(commandHelpers, "getExecutionReport").mockReturnValue(mockExecutionReport);
    vi.spyOn(commandHelpers, "logIssuesToPipeline").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const statusCode = await generateSdkForSpecPr();

    expect(statusCode).toBe(1);
    expect(log.logMessage).toHaveBeenCalledWith(
      "Runner: error executing command:Error: Command failed",
      LogLevel.Error,
    );
  });

  test("should handle errors during execution report reading for a changed spec", async () => {
    const mockCommandInput = {
      localSdkRepoPath: "path/to/local/repo",
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };
    const mockChangedSpecs = [
      {
        specs: [
          "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
        ],
        typespecProject: "path/to/tspconfig.yaml",
        readmeMd: "path/to/readme.md",
      },
    ];

    vi.spyOn(commandHelpers, "logIssuesToPipeline").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockCommandInput);
    vi.spyOn(commandHelpers, "prepareSpecGenSdkCommand").mockReturnValue(["mock-command"]);
    vi.spyOn(changeFiles, "detectChangedSpecConfigFiles").mockReturnValue(mockChangedSpecs);
    vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValue(undefined);
    vi.spyOn(utils, "resetGitRepo").mockImplementation(() => Promise.resolve());
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(commandHelpers, "getExecutionReport").mockImplementation(() => {
      throw new Error("Failed to read execution report");
    });

    const statusCode = await generateSdkForSpecPr();

    expect(statusCode).toBe(1);
    expect(log.logMessage).toHaveBeenCalledWith(
      "Runner: error reading execution-report.json:Error: Failed to read execution report",
      LogLevel.Error,
    );
  });
});

describe("generateSdkForBatchSpecs", () => {
  beforeEach(() => {
    vi.resetAllMocks();
  });

  test("should handle empty spec paths gracefully", async () => {
    const mockBatchType = "all-specs";
    const mockInput = {
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      localSdkRepoPath: "/sdk/path",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };

    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockInput);
    vi.spyOn(commandHelpers, "getSpecPaths").mockReturnValue([]);
    vi.spyOn(utils, "runSpecGenSdkCommand").mockImplementation(() => Promise.resolve());
    vi.spyOn(utils, "resetGitRepo").mockImplementation(() => Promise.resolve());
    vi.spyOn(fs, "existsSync").mockReturnValue(false);
    vi.spyOn(fs, "writeFileSync").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(log, "vsoAddAttachment").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const code = await generateSdkForBatchSpecs(mockBatchType);
    expect(commandHelpers.getSpecPaths).toHaveBeenCalledWith(mockBatchType, "/spec/path");
    expect(code).toBe(0);
    expect(utils.runSpecGenSdkCommand).not.toHaveBeenCalled();
    expect(utils.resetGitRepo).not.toHaveBeenCalled();
    const markdownFilePath = path.normalize(
      path.join(mockInput.workingFolder, "out/logs/generation-summary.md"),
    );
    expect(log.logMessage).toHaveBeenCalledWith(
      `Runner: markdown file written to ${markdownFilePath}`,
    );
    expect(log.vsoAddAttachment).toHaveBeenCalledWith("Generation Summary", markdownFilePath);

    const calls = getNormalizedFsCalls(fs.writeFileSync as Mock);
    expect(calls).toMatchSnapshot();
  });

  test("should generate SDKs for all specs successfully", async () => {
    const mockBatchType = "all-specs";
    const mockSpecPaths = ["typespec1", "typespec2", "readme1", "readme2"];
    const mockExecutionReport = {
      executionResult: "succeeded",
      packages: [],
    };
    const mockInput = {
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      localSdkRepoPath: "/sdk/path",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };

    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockInput);
    vi.spyOn(commandHelpers, "getSpecPaths").mockReturnValue(mockSpecPaths);
    vi.spyOn(utils, "resetGitRepo").mockResolvedValue(undefined);
    vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValue(undefined);
    vi.spyOn(fs, "readFileSync").mockReturnValue(JSON.stringify(mockExecutionReport));
    vi.spyOn(fs, "existsSync").mockReturnValue(false);
    vi.spyOn(fs, "writeFileSync").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    vi.spyOn(log, "vsoAddAttachment").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const result = await generateSdkForBatchSpecs(mockBatchType);
    expect(result).toBe(0);
    expect(commandHelpers.getSpecPaths).toHaveBeenCalledWith(mockBatchType, "/spec/path");
    expect(utils.runSpecGenSdkCommand).toHaveBeenCalledTimes(mockSpecPaths.length);
    const markdownFilePath = path.normalize(
      path.join(mockInput.workingFolder, "out/logs/generation-summary.md"),
    );
    expect(log.logMessage).toHaveBeenCalledWith(
      `Runner: markdown file written to ${markdownFilePath}`,
    );
    expect(log.vsoAddAttachment).toHaveBeenCalledWith("Generation Summary", markdownFilePath);

    const calls = getNormalizedFsCalls(fs.writeFileSync as Mock);
    expect(calls).toMatchSnapshot();
  });

  test("should handle errors during SDK generation", async () => {
    const mockBatchType = "all-specs";
    const mockSpecPaths = ["typespec1", "typespec2"];
    const mockExecutionReport = {
      executionResult: "failed",
      packages: [],
    };
    const mockInput = {
      localSpecRepoPath: "/spec/path",
      workingFolder: "/working/folder",
      runMode: "batch",
      localSdkRepoPath: "/sdk/path",
      sdkRepoName: "azure-sdk-for-js",
      sdkLanguage: "javascript",
      specCommitSha: "",
      specRepoHttpsUrl: "",
    };
    vi.spyOn(commandHelpers, "parseArguments").mockReturnValue(mockInput);

    vi.spyOn(commandHelpers, "getSpecPaths").mockReturnValue(mockSpecPaths);
    vi.spyOn(utils, "resetGitRepo").mockResolvedValue(undefined);
    vi.spyOn(utils, "runSpecGenSdkCommand")
      .mockRejectedValueOnce(new Error("Command failed"))
      .mockResolvedValueOnce(undefined);
    vi.spyOn(fs, "readFileSync").mockReturnValue(JSON.stringify(mockExecutionReport));
    vi.spyOn(fs, "existsSync").mockReturnValue(false);
    vi.spyOn(fs, "writeFileSync").mockImplementation(() => {
      // mock implementation intentionally left blank
    });
    const logSpy = vi.spyOn(log, "logMessage").mockImplementation(() => {
      // mock implementation intentionally left blank
    });

    const result = await generateSdkForBatchSpecs(mockBatchType);

    expect(result).toBe(1);
    expect(utils.runSpecGenSdkCommand).toHaveBeenCalledTimes(mockSpecPaths.length);
    expect(logSpy).toHaveBeenCalledTimes(11);
    const markdownFilePath = path.normalize(
      path.join(mockInput.workingFolder, "out/logs/generation-summary.md"),
    );
    expect(logSpy).toHaveBeenNthCalledWith(1, `Generating SDK from ${mockSpecPaths[0]}`, "group");
    expect(logSpy).toHaveBeenNthCalledWith(
      3,
      "Runner: error executing command:Error: Command failed",
      LogLevel.Error,
    );
    expect(logSpy).toHaveBeenNthCalledWith(5, "ending group logging", "endgroup");
    expect(logSpy).toHaveBeenNthCalledWith(6, `Generating SDK from ${mockSpecPaths[1]}`, "group");
    expect(logSpy).toHaveBeenCalledWith(`Runner: markdown file written to ${markdownFilePath}`);
    expect(log.vsoAddAttachment).toHaveBeenCalledWith("Generation Summary", markdownFilePath);

    const calls = getNormalizedFsCalls(fs.writeFileSync as Mock);
    expect(calls).toMatchSnapshot();
    logSpy.mockRestore();
  });
});
