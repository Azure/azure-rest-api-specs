import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import * as helpers from "../src/command-helpers.ts";
import { generateSdkForSpecPr } from "../src/commands.ts";
import * as metadata from "../src/sdk-review-metadata.ts";
import * as specs from "../src/spec-helpers.ts";
import * as utils from "../src/utils.ts";
import { completeBreakingChangeSignal, nativeCheckExitCode } from "../src/native-check.ts";
import type { CommandResult, ExecutionReport, SpecGenSdkCmdInput } from "../src/types.ts";

describe("native SDK predicates", () => {
  const report: ExecutionReport = {
    executionResult: "succeeded",
    packages: [{ packageRootPath: "/sdk/one" }],
  };

  it("requires complete analysis, never default false or partial package coverage", () => {
    expect(completeBreakingChangeSignal([report, report], [false, false], 0)).toBe(false);
    expect(completeBreakingChangeSignal([report, report], [false, true], 0)).toBe(true);
    expect(completeBreakingChangeSignal([report, report], [true, undefined], 0)).toBeUndefined();
    expect(completeBreakingChangeSignal([report, report], [false], 0)).toBeUndefined();
    expect(completeBreakingChangeSignal([], [], 0)).toBeUndefined();
    expect(completeBreakingChangeSignal([{ ...report, packages: [] }], [false], 0)).toBeUndefined();
    expect(completeBreakingChangeSignal([undefined], [false], 0)).toBeUndefined();
    expect(
      completeBreakingChangeSignal([{ ...report, executionResult: "failed" }], [true], 0),
    ).toBeUndefined();
    expect(completeBreakingChangeSignal([report], [false], 1)).toBeUndefined();
  });

  describe("native predicates from SDK execution", () => {
    let input: SpecGenSdkCmdInput;
    let report: ExecutionReport;

    beforeEach(() => {
      input = {
        localSdkRepoPath: "/sdk",
        localSpecRepoPath: "/spec",
        workingFolder: "/work",
        runMode: "spec-pull-request",
        sdkRepoName: "azure-sdk-for-js-pr",
        sdkLanguage: "azure-sdk-for-js",
        specCommitSha: "a".repeat(40),
        specRepoHttpsUrl: "https://github.com/Azure/azure-rest-api-specs-pr",
        prNumber: "42",
        nativeCheckSignal: "breaking-absent",
      };
      report = {
        executionResult: "succeeded",
        generateFromTypeSpec: true,
        packages: [
          { packageRootPath: "sdk/widget/one", shouldLabelBreakingChange: false },
          { packageRootPath: "/sdk/two", shouldLabelBreakingChange: false },
        ],
      };
      vi.spyOn(helpers, "parseArguments").mockImplementation(() => input);
      vi.spyOn(helpers, "prepareSpecGenSdkCommand").mockReturnValue(["mock-command"]);
      vi.spyOn(helpers, "selectGenerationTool").mockReturnValue("spec-gen-sdk");
      vi.spyOn(helpers, "installLanguageToolchain").mockResolvedValue(undefined);
      vi.spyOn(helpers, "isBreakingChangeDetectionEnabled").mockReturnValue(false);
      vi.spyOn(helpers, "getExecutionReport").mockImplementation(() => report);
      vi.spyOn(helpers, "generateArtifact").mockReturnValue(0);
      vi.spyOn(specs, "detectChangedSpecConfigFiles").mockResolvedValue([
        {
          specs: ["specification/widget/client.tsp"],
          typespecProject: "specification/widget/tspconfig.yaml",
        },
      ]);
      vi.spyOn(utils, "resetGitRepo").mockResolvedValue(undefined);
      vi.spyOn(utils, "runSpecGenSdkCommand").mockResolvedValue(undefined);
      vi.spyOn(metadata, "captureSdkReviewMetadata").mockResolvedValue(new Map());
    });
    afterEach(() => vi.restoreAllMocks());

    it("proves clean analysis only after analyzing every generated package", async () => {
      const analyze = vi
        .spyOn(utils, "runCommandWithOutput")
        .mockResolvedValue(JSON.stringify({ result: { hasBreakingChange: false } }));
      const result = await generateSdkForSpecPr();
      expect(analyze).toHaveBeenCalledTimes(2);
      expect(analyze).toHaveBeenNthCalledWith(
        1,
        expect.any(String),
        expect.arrayContaining(["--package-path", path.resolve("/sdk/sdk/widget/one")]),
      );
      expect(analyze).toHaveBeenNthCalledWith(
        2,
        expect.any(String),
        expect.arrayContaining(["--package-path", path.resolve("/sdk/two")]),
      );
      expect(result.nativeCheck).toEqual({ required: true, breakingChange: false });
      expect(nativeCheckExitCode("breaking-absent", result)).toBe(0);
    });

    it("emits positive evidence from an actual finding, not the SDK check failure", async () => {
      vi.spyOn(utils, "runCommandWithOutput")
        .mockResolvedValueOnce(JSON.stringify({ result: { hasBreakingChange: false } }))
        .mockResolvedValueOnce(JSON.stringify({ result: { hasBreakingChange: true } }));
      const result = await generateSdkForSpecPr();
      expect(nativeCheckExitCode("breaking-present", result)).toBe(0);
      expect(nativeCheckExitCode("breaking-absent", result)).toBe(1);
    });

    it("does not turn a partial analyzer crash and legacy false values into clean evidence", async () => {
      vi.spyOn(utils, "runCommandWithOutput")
        .mockResolvedValueOnce(JSON.stringify({ result: { hasBreakingChange: false } }))
        .mockRejectedValueOnce(new Error("analyzer crashed"));
      const result = await generateSdkForSpecPr();
      expect(report.packages.every((pkg) => pkg.shouldLabelBreakingChange === false)).toBe(true);
      expect(result.nativeCheck?.breakingChange).toBeUndefined();
      expect(nativeCheckExitCode("breaking-absent", result)).toBe(1);
    });

    it("rejects escaping package paths instead of analyzing outside the SDK checkout", async () => {
      report.packages[0].packageRootPath = "../../outside-sdk";
      const analyze = vi
        .spyOn(utils, "runCommandWithOutput")
        .mockResolvedValue(JSON.stringify({ result: { hasBreakingChange: false } }));
      const result = await generateSdkForSpecPr();
      expect(analyze).toHaveBeenCalledTimes(1);
      expect(nativeCheckExitCode("breaking-absent", result)).toBe(1);
    });

    it("rejects label evidence after generation failure even if an analyzer returns false", async () => {
      vi.mocked(utils.runSpecGenSdkCommand).mockRejectedValue(new Error("generation failed"));
      vi.spyOn(utils, "runCommandWithOutput").mockResolvedValue(
        JSON.stringify({ result: { hasBreakingChange: false } }),
      );
      const result = await generateSdkForSpecPr();
      expect(nativeCheckExitCode("breaking-absent", result)).toBe(1);
      expect(nativeCheckExitCode("validation", result)).toBe(1);
    });

    it("preserves the .NET actual-generation exemption without treating skipped analysis as clean", async () => {
      input.sdkLanguage = "azure-sdk-for-net";
      input.sdkRepoName = "azure-sdk-for-net-pr";
      report.executionResult = "notEnabled";
      report.packages = [];
      const result = await generateSdkForSpecPr();
      expect(result.nativeCheck?.required).toBe(false);
      expect(nativeCheckExitCode("validation", result)).toBe(0);
      expect(nativeCheckExitCode("breaking-absent", result)).toBe(1);
    });

    it("does not force an analyzer dependency onto validation-only execution", async () => {
      input.nativeCheckSignal = "validation";
      const analyze = vi.spyOn(utils, "runCommandWithOutput");
      const result = await generateSdkForSpecPr();
      expect(analyze).not.toHaveBeenCalled();
      expect(nativeCheckExitCode("validation", result)).toBe(0);
    });
  });

  it("succeeds only for the independently proven label predicate", () => {
    const result: CommandResult = {
      statusCode: 0,
      executionResult: "succeeded",
      nativeCheck: { required: true, breakingChange: true },
    };
    expect(nativeCheckExitCode("breaking-present", result)).toBe(0);
    expect(nativeCheckExitCode("breaking-absent", result)).toBe(1);
    result.nativeCheck = { required: true, breakingChange: false };
    expect(nativeCheckExitCode("breaking-present", result)).toBe(1);
    expect(nativeCheckExitCode("breaking-absent", result)).toBe(0);
    result.nativeCheck.breakingChange = undefined;
    expect(nativeCheckExitCode("breaking-present", result)).toBe(1);
    expect(nativeCheckExitCode("breaking-absent", result)).toBe(1);
  });

  it("uses runtime requiredness but fails closed when runner evidence is missing", () => {
    const failed: CommandResult = {
      statusCode: 1,
      executionResult: "failed",
      nativeCheck: { required: true, breakingChange: undefined },
    };
    expect(nativeCheckExitCode("validation", failed)).toBe(1);
    failed.nativeCheck = { required: false, breakingChange: undefined };
    expect(nativeCheckExitCode("validation", failed)).toBe(0);
    expect(nativeCheckExitCode("validation", { statusCode: 0, executionResult: "succeeded" })).toBe(
      1,
    );
  });
});
import path from "node:path";
