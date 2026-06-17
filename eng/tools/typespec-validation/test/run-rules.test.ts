import { describe, expect, it, vi } from "vitest";
import { runRules, runRulesParallel } from "../src/index.ts";
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

describe("runRules", function () {
  it("should execute all rules when no suppressions", async function () {
    const rule1 = createRule("Rule1", { success: true }, { suppressable: true });
    const rule2 = createRule("Rule2", { success: true });

    const result = await runRules([rule1, rule2], "/test", []);

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

    const result = await runRules([rule1, rule2], "/test", suppressions);

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

    const result = await runRules([rule1], "/test", suppressions);

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

    const result = await runRules([rule1], "/test", suppressions);

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

    const result = await runRules([rule1], "/test", suppressions);

    expect(result.suppressed).toEqual([]);
    expect(result.executed).toEqual(["Rule1"]);
  });

  it("should stop executing rules after a failure", async function () {
    const rule1 = createRule("Rule1", { success: false, errorOutput: "error" });
    const rule2 = createRule("Rule2", { success: true });

    const result = await runRules([rule1, rule2], "/test", []);

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

    const result = await runRules([rule1, rule2, rule3], "/test", suppressions);

    expect(result.success).toBe(true);
    expect(result.suppressed).toEqual(["Rule2"]);
    expect(result.executed).toEqual(["Rule1", "Rule3"]);
  });
});

describe("runRulesParallel", function () {
  it("should execute all rules concurrently and collect results", async function () {
    const rule1 = createRule("Rule1", { success: true });
    const rule2 = createRule("Rule2", { success: true });

    const result = await runRulesParallel([rule1, rule2], "/test", []);

    expect(result.success).toBe(true);
    expect(result.executed).toEqual(["Rule1", "Rule2"]);
    expect(result.suppressed).toEqual([]);
    expect(result.failed).toEqual([]);
    expect(rule1.executeFn).toHaveBeenCalledOnce();
    expect(rule2.executeFn).toHaveBeenCalledOnce();
  });

  it("should continue executing all rules even when one fails", async function () {
    const rule1 = createRule("Rule1", { success: false, errorOutput: "error1" });
    const rule2 = createRule("Rule2", { success: true });

    const result = await runRulesParallel([rule1, rule2], "/test", []);

    expect(result.success).toBe(false);
    expect(result.executed).toEqual(["Rule1", "Rule2"]);
    expect(result.failed).toEqual(["Rule1"]);
    // Both rules were executed (unlike runRules which stops on first failure)
    expect(rule2.executeFn).toHaveBeenCalledOnce();
  });

  it("should collect all failures when multiple rules fail", async function () {
    const rule1 = createRule("Rule1", { success: false, errorOutput: "error1" });
    const rule2 = createRule("Rule2", { success: false, errorOutput: "error2" });
    const rule3 = createRule("Rule3", { success: true });

    const result = await runRulesParallel([rule1, rule2, rule3], "/test", []);

    expect(result.success).toBe(false);
    expect(result.failed).toEqual(["Rule1", "Rule2"]);
    expect(result.executed).toEqual(["Rule1", "Rule2", "Rule3"]);
  });

  it("should suppress a suppressable rule when a matching suppression exists", async function () {
    const rule1 = createRule("Rule1", { success: false }, { suppressable: true });
    const rule2 = createRule("Rule2", { success: true });

    const suppressions = [
      { tool: "TypeSpecValidation", paths: ["."], reason: "test reason", rules: ["Rule1"] },
    ];

    const result = await runRulesParallel([rule1, rule2], "/test", suppressions);

    expect(result.success).toBe(true);
    expect(result.suppressed).toEqual(["Rule1"]);
    expect(result.executed).toEqual(["Rule2"]);
    expect(rule1.executeFn).not.toHaveBeenCalled();
  });

  it("should return results in deterministic rule order", async function () {
    const rule1 = createRule("Rule1", { success: true });
    const rule2 = createRule("Rule2", { success: true });
    const rule3 = createRule("Rule3", { success: true });

    const result = await runRulesParallel([rule1, rule2, rule3], "/test", []);

    // Results must be in the original rule order, regardless of execution timing
    expect(result.executed).toEqual(["Rule1", "Rule2", "Rule3"]);
    expect(result.success).toBe(true);
  });
});
