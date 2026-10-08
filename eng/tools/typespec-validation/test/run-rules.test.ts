import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";
import { d } from "@azure-tools/specs-shared/testing";
import { afterEach, describe, expect, it, vi } from "vitest";
import { verbatim } from "../src/diagnostic-content.ts";
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
  it("prints compact verbose statuses, accurately distinguishing skips and suppressions", async () => {
    vi.stubEnv("NO_COLOR", "1");
    const stdout = vi.spyOn(console, "log").mockImplementation(() => {});
    const debug = vi.spyOn(console, "debug").mockImplementation(() => {});
    const suppressed = createRule("Suppressed", { success: false }, { suppressable: true });
    const rules = [
      createRule("Passed", { success: true }),
      createRule("Skipped", { success: true, skipped: "Not applicable" }),
      suppressed,
      createRule("InternallySuppressed", { success: true, suppressed: "Config exemption" }),
      createRule("Warning", {
        success: true,
        diagnostics: [{ severity: "warning", code: "test", message: "Limited validation" }],
      }),
    ];
    vi.spyOn(console, "warn").mockImplementation(() => {});
    const result = await runRules(
      rules,
      "/test",
      [
        {
          tool: "TypeSpecValidation",
          paths: ["."],
          rules: ["Suppressed"],
          reason: "Known exemption",
        },
      ],
      new ConsoleLogger(true),
    );
    expect(result.success).toBe(true);
    expect(suppressed.executeFn).not.toHaveBeenCalled();
    expect(stdout.mock.calls.flat()).toEqual([
      "",
      "1 passed | 1 with warnings | 1 skipped | 2 suppressed",
    ]);
    expect(
      debug.mock.calls.flat().filter((line) => /^[\u2714\u00d7!-] /.test(String(line))),
    ).toEqual([
      "\u2714 Passed",
      "- Skipped (skipped)",
      "- Suppressed (suppressed)",
      "- InternallySuppressed (suppressed)",
      "! Warning (warnings)",
    ]);
  });

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
      expect(stdout.mock.calls.flat()).toEqual(["", "1 failed | 1 with warnings | 1 not run"]);
      expect(stdout.mock.invocationCallOrder[0]).toBeGreaterThan(error.mock.invocationCallOrder[0]);
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
    "reports native command diagnostics once with logger=%j",
    async (logger) => {
      vi.stubEnv("NO_COLOR", "1");
      const log = vi.spyOn(console, "log").mockImplementation(() => {});
      const error = vi.spyOn(console, "error").mockImplementation(() => {});
      const rule = createRule("Rule", {
        success: false,
        diagnostics: [
          {
            severity: "error",
            code: "compile",
            message: "TypeSpec compilation failed.",
            details: verbatim(d`
              main.tsp:1:1 - error invalid-ref: Unknown identifier.
              > 1 | invalid
                  | ^
            `),
          },
        ],
      });
      const result = await runRules([rule], "/test", [], logger);
      expect(result.success).toBe(false);
      expect(rule.executeFn).toHaveBeenCalledWith("/test", logger);
      expect(log.mock.calls.flat()).toEqual(["", "1 failed"]);
      expect(log.mock.invocationCallOrder[0]).toBeGreaterThan(error.mock.invocationCallOrder[0]);
      expect(error).toHaveBeenCalledExactlyOnceWith(d`
        error tsv/compile: TypeSpec compilation failed.
        main.tsp:1:1 - error invalid-ref: Unknown identifier.
        > 1 | invalid
            | ^
      `);
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
    const rule1 = createRule("Rule1", {
      success: false,
      diagnostics: [{ severity: "error", code: "test", message: "error" }],
    });
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
