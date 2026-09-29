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

afterEach(() => vi.restoreAllMocks());

describe("runRules", function () {
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
