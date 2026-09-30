import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";
import { afterEach, describe, expect, it, vi } from "vitest";
import { runRules } from "../src/index.ts";
import { type RuleResult } from "../src/rule-result.ts";
import { type Rule } from "../src/rule.ts";

function createRule(
  name: string,
  result: RuleResult,
  options?: { suppressable?: boolean },
): Rule & { executeFn: ReturnType<typeof vi.fn> } {
  const executeFn = vi.fn().mockResolvedValue(result);
  return {
    name,
    description: `Test rule ${name}`,
    suppressable: options?.suppressable ?? false,
    execute: executeFn,
    executeFn,
  };
}

afterEach(() => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
});

describe("runRules", function () {
  it.each([false, true])(
    "preserves findings and execution semantics with verbose=%s",
    async (verbose) => {
      vi.stubEnv("NO_COLOR", "1");
      const logger = new ConsoleLogger(verbose);
      const stdout = vi.spyOn(console, "log").mockImplementation(() => {});
      const debug = vi.spyOn(console, "debug").mockImplementation(() => {});
      const error = vi.spyOn(console, "error").mockImplementation(() => {});
      const warning = vi.spyOn(console, "warn").mockImplementation(() => {});
      const duplicateWarning = {
        severity: "warning" as const,
        code: "coverage",
        message: "Not compared.",
      };
      const first = createRule("First", {
        success: true,
        diagnostics: [duplicateWarning],
        skipped: "Not applicable",
      });
      const second = createRule("Second", {
        success: false,
        diagnostics: [
          duplicateWarning,
          { severity: "error", code: "bad-value", message: "Invalid value." },
        ],
      });
      const third = createRule("Third", { success: true });
      const result = await runRules([first, second, third], "/test", [], logger);
      expect(result).toEqual({
        success: false,
        suppressed: [],
        executed: ["First", "Second"],
        failed: ["Second"],
      });
      expect(third.executeFn).not.toHaveBeenCalled();
      expect(warning).toHaveBeenCalledExactlyOnceWith("warning tsv/coverage: Not compared.");
      expect(error).toHaveBeenCalledExactlyOnceWith("error tsv/bad-value: Invalid value.");
      expect(stdout).not.toHaveBeenCalledWith(expect.stringContaining("Invalid value."));
      expect(debug.mock.calls.length > 0).toBe(verbose);
    },
  );

  it("turns an unexpected rule exception into a failure, with its stack only in debug output", async () => {
    vi.stubEnv("NO_COLOR", "1");
    const error = vi.spyOn(console, "error").mockImplementation(() => {});
    const debug = vi.spyOn(console, "debug").mockImplementation(() => {});
    const rule = createRule("Throwing", { success: true });
    rule.executeFn.mockRejectedValue(new Error("command could not start"));
    const result = await runRules([rule], "/test", [], defaultLogger);
    expect(result.failed).toEqual(["Throwing"]);
    expect(error).toHaveBeenCalledWith(
      expect.stringContaining("error tsv/rule-execution: command could not start"),
    );
    expect(error.mock.calls.flat().join("\n")).not.toContain("\n    at ");
    expect(debug).not.toHaveBeenCalled();
  });

  it("does not silently lose a failed rule with no diagnostic", async () => {
    const error = vi.spyOn(console, "error").mockImplementation(() => {});
    const result = await runRules(
      [createRule("Broken", { success: false })],
      "/test",
      [],
      defaultLogger,
    );
    expect(result.success).toBe(false);
    expect(error).toHaveBeenCalledWith(
      expect.stringContaining("failed without reporting an error"),
    );
  });

  it.each([new ConsoleLogger(false), new ConsoleLogger(true)])(
    "preserves an unmigrated stdout-only failure with logger=%j",
    async (logger) => {
      const stdout = vi.spyOn(console, "log").mockImplementation(() => {});
      const stderr = vi.spyOn(console, "error").mockImplementation(() => {});
      const rule = createRule("SdkTspConfigValidation", {
        success: false,
        stdOutput: "Invalid SDK configuration: please set the module name.",
      });
      const laterRule = createRule("Later", { success: true });
      const result = await runRules([rule, laterRule], "/test", [], logger);
      expect(result.success).toBe(false);
      expect(result.failed).toEqual(["SdkTspConfigValidation"]);
      expect(stdout).toHaveBeenCalledWith("Invalid SDK configuration: please set the module name.");
      expect(stdout).toHaveBeenCalledWith("Rule SdkTspConfigValidation failed");
      expect(stderr).not.toHaveBeenCalled();
      expect(laterRule.executeFn).not.toHaveBeenCalled();
    },
  );

  it.each([new ConsoleLogger(false), new ConsoleLogger(true)])(
    "keeps rule diagnostics visible with logger=%j",
    async (logger) => {
      const log = vi.spyOn(console, "log").mockImplementation(() => {});
      const rule = createRule("Rule", {
        success: false,
        stdOutput: "diagnostic on stdout",
        errorOutput: "diagnostic on stderr",
      });
      const result = await runRules([rule], "/test", [], logger);
      expect(result.success).toBe(false);
      expect(rule.executeFn).toHaveBeenCalledWith("/test", logger);
      expect(log).toHaveBeenCalledWith("diagnostic on stdout");
      expect(log).toHaveBeenCalledWith("diagnostic on stderr");
    },
  );

  it("should execute all rules when no suppressions", async function () {
    const rule1 = createRule("Rule1", { success: true }, { suppressable: true });
    const rule2 = createRule("Rule2", { success: true });

    const result = await runRules([rule1, rule2], "/test", [], defaultLogger);

    expect(result.success).toBe(true);
    expect(result.executed).toEqual(["Rule1", "Rule2"]);
    expect(result.suppressed).toEqual([]);
    expect(result.failed).toEqual([]);
  });

  it("should skip a suppressable rule when a matching suppression exists", async function () {
    const rule1 = createRule("Rule1", { success: false }, { suppressable: true });
    const rule2 = createRule("Rule2", { success: true });

    const suppressions = [
      { tool: "TypeSpecValidation", paths: ["."], reason: "test reason", rules: ["Rule1"] },
    ];

    const result = await runRules([rule1, rule2], "/test", suppressions, defaultLogger);

    expect(result.success).toBe(true);
    expect(result.suppressed).toEqual(["Rule1"]);
    expect(result.executed).toEqual(["Rule2"]);
    expect(rule1.executeFn).not.toHaveBeenCalled();
  });

  it("should not skip a non-suppressable rule even with a matching suppression", async function () {
    const rule1 = createRule("Rule1", { success: true });

    const suppressions = [
      { tool: "TypeSpecValidation", paths: ["."], reason: "test reason", rules: ["Rule1"] },
    ];

    const result = await runRules([rule1], "/test", suppressions, defaultLogger);

    expect(result.success).toBe(true);
    expect(result.suppressed).toEqual([]);
    expect(result.executed).toEqual(["Rule1"]);
    expect(rule1.executeFn).toHaveBeenCalledOnce();
  });

  it("should not suppress when suppression targets a different rule", async function () {
    const rule1 = createRule("Rule1", { success: true }, { suppressable: true });

    const suppressions = [
      { tool: "TypeSpecValidation", paths: ["."], reason: "test reason", rules: ["OtherRule"] },
    ];

    const result = await runRules([rule1], "/test", suppressions, defaultLogger);

    expect(result.suppressed).toEqual([]);
    expect(result.executed).toEqual(["Rule1"]);
  });

  it("should not suppress when suppression has sub-rules", async function () {
    const rule1 = createRule("Rule1", { success: true }, { suppressable: true });

    const suppressions = [
      {
        tool: "TypeSpecValidation",
        paths: ["."],
        reason: "test reason",
        rules: ["Rule1"],
        subRules: ["SubRule1"],
      },
    ];

    const result = await runRules([rule1], "/test", suppressions, defaultLogger);

    expect(result.suppressed).toEqual([]);
    expect(result.executed).toEqual(["Rule1"]);
  });

  it("should stop executing rules after a failure", async function () {
    const rule1 = createRule("Rule1", { success: false, errorOutput: "error" });
    const rule2 = createRule("Rule2", { success: true });

    const result = await runRules([rule1, rule2], "/test", [], defaultLogger);

    expect(result.success).toBe(false);
    expect(result.executed).toEqual(["Rule1"]);
    expect(result.failed).toEqual(["Rule1"]);
    expect(rule2.executeFn).not.toHaveBeenCalled();
  });

  it("should suppress one rule and still execute others", async function () {
    const rule1 = createRule("Rule1", { success: true }, { suppressable: true });
    const rule2 = createRule("Rule2", { success: true }, { suppressable: true });
    const rule3 = createRule("Rule3", { success: true });

    const suppressions = [
      { tool: "TypeSpecValidation", paths: ["."], reason: "skip rule2", rules: ["Rule2"] },
    ];

    const result = await runRules([rule1, rule2, rule3], "/test", suppressions, defaultLogger);

    expect(result.success).toBe(true);
    expect(result.suppressed).toEqual(["Rule2"]);
    expect(result.executed).toEqual(["Rule1", "Rule3"]);
  });
});
