// cspell:ignoreRegExp /\\x1b\[[0-9;]*m/g

import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { d } from "@azure-tools/specs-shared/testing";
import { stripVTControlCharacters } from "node:util";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { blocks, filePath, indent, lines, text, verbatim } from "../src/diagnostic-content.ts";
import {
  formatDiagnostic as format,
  formatRuleStatus,
  formatRuleSummary,
  reportDiagnostics as report,
  supportsColor,
} from "../src/diagnostics.ts";
import type { Diagnostic } from "../src/rule-result.ts";

const formatDiagnostic = (
  diagnostic: Diagnostic,
  options: { cwd?: string; color?: boolean } = {},
) => format(diagnostic, "test", options);
const reportDiagnostics = (diagnostics: readonly Diagnostic[], logger: ConsoleLogger) =>
  report(diagnostics, logger, "test");

beforeEach(() => vi.stubEnv("NO_COLOR", "1"));
afterEach(() => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
});

const diagnostic: Diagnostic = {
  severity: "error",
  code: "invalid-option",
  message: "Invalid option.",
  path: "/repo/service/tspconfig.yaml",
  location: { line: 2, column: 3, text: "options:\r\n  invalid: true\r\n" },
  help: "Remove the option.",
};

describe("diagnostic formatting", () => {
  it("keeps skipped counts and separators muted while emphasizing failures", () => {
    const counts = { PASS: 2, FAIL: 1, WARN: 1, SKIP: 3, SUPPRESSED: 1 };
    const plain = formatRuleSummary(counts, 4, false);
    const colored = formatRuleSummary(counts, 4, true);
    expect(colored).not.toContain("Rules:");
    expect(colored).toContain("\x1b[32m2 passed\x1b[39m");
    expect(colored).toContain("\x1b[1m\x1b[31m1 failed\x1b[39m\x1b[22m");
    expect(colored).toContain("\x1b[33m1 with warnings\x1b[39m");
    for (const text of ["3 skipped", "1 suppressed", "4 not run"]) {
      expect(colored).toContain(`\x1b[90m${text}\x1b[39m`);
    }
    expect(colored).toContain("\x1b[2m | \x1b[22m");
    expect(stripVTControlCharacters(colored)).toBe(plain);
    expect(plain).toBe(
      "2 passed | 1 failed | 1 with warnings | 3 skipped | 1 suppressed | 4 not run",
    );
    expect(plain).not.toContain("\x1b");
    expect(
      formatRuleSummary({ PASS: 0, FAIL: 0, WARN: 0, SKIP: 0, SUPPRESSED: 0 }, 0, true),
    ).toContain("\x1b[90m0 run\x1b[39m");
  });

  it("renders concise colored rule statuses and an honest incomplete-run summary", () => {
    expect(formatRuleStatus("Compile", "PASS", false)).toBe("\u2714 Compile");
    expect(formatRuleStatus("Compile", "PASS", true)).toBe("\x1b[32m\u2714\x1b[39m Compile");
    expect(formatRuleStatus("Compile", "FAIL", true)).toBe("\x1b[31m\u00d7\x1b[39m Compile");
    expect(formatRuleStatus("Compile", "WARN", true)).toBe("\x1b[33m!\x1b[39m Compile (warnings)");
    expect(formatRuleStatus("Compile", "SKIP", false)).toBe("- Compile (skipped)");
    expect(formatRuleStatus("Compile", "SUPPRESSED", false)).toBe("- Compile (suppressed)");
    expect(formatRuleSummary({ PASS: 2, FAIL: 1, WARN: 0, SKIP: 1, SUPPRESSED: 1 }, 3, false)).toBe(
      "2 passed | 1 failed | 1 skipped | 1 suppressed | 3 not run",
    );
    expect(formatRuleSummary({ PASS: 0, FAIL: 0, WARN: 0, SKIP: 0, SUPPRESSED: 0 }, 0, false)).toBe(
      "0 run",
    );
  });

  it("uses TypeSpec-style locations, severity, codes and a real source excerpt", () => {
    expect(formatDiagnostic(diagnostic, { cwd: "/repo" })).toBe(d`
      service/tspconfig.yaml:2:3 - error test/invalid-option: Invalid option.
        2 |   invalid: true
          |   ^
        help: Remove the option.
    `);
    expect(formatDiagnostic({ ...diagnostic, location: undefined }, { cwd: "/repo" })).toBe(d`
      service/tspconfig.yaml - error test/invalid-option: Invalid option.
        help: Remove the option.
    `);
    expect(
      formatDiagnostic({ severity: "warning", code: "skipped", message: "Comparison skipped." }),
    ).toBe("warning test/skipped: Comparison skipped.");
  });

  it("normalizes Windows paths and preserves the plain meaning when colors are enabled", () => {
    const windows = { ...diagnostic, path: "C:\\repo\\service\\tspconfig.yaml" };
    const plain = formatDiagnostic(windows, { cwd: "C:\\repo", color: false });
    const colored = formatDiagnostic(windows, { cwd: "C:\\repo", color: true });
    expect(colored).toContain("\x1b[31merror\x1b[39m");
    expect(colored).toContain("\x1b[36mservice/tspconfig.yaml\x1b[39m");
    expect(stripVTControlCharacters(colored)).toBe(plain);
    expect(plain).not.toContain("\x1b");
  });

  it.each([
    ["/repo", ["/repo/service/first.json", "service/second.json"]],
    ["C:\\repo", ["C:\\repo\\service\\first.json", "service\\second.json"]],
  ])("indents affected files and colors each path cyan with cwd=%s", (cwd, files) => {
    const changedFiles: Diagnostic = {
      severity: "error",
      code: "generated-files-changed",
      message: "Files have been changed after `tsp compile`.",
      details: indent(lines(files.map(filePath))),
      help: "Run `tsp compile` and include the changes.",
    };
    const plain = formatDiagnostic(changedFiles, { cwd, color: false });
    const colored = formatDiagnostic(changedFiles, { cwd, color: true });
    expect(plain).toBe(d`
      error test/generated-files-changed: Files have been changed after \`tsp compile\`.
        service/first.json
        service/second.json
        help: Run \`tsp compile\` and include the changes.
    `);
    expect(colored).toContain("\n  \x1b[36mservice/first.json\x1b[39m\n");
    expect(colored).toContain("\n  \x1b[36mservice/second.json\x1b[39m\n");
    expect(stripVTControlCharacters(colored)).toBe(plain);
  });

  it("colors labeled file paths cyan while preserving their version labels", () => {
    const missingFile: Diagnostic = {
      severity: "error",
      code: "service-yaml",
      message: "Manifest references swagger files that do not exist:",
      details: indent(
        text`- version "2024-06-01": ${filePath("../stable/2024-06-01/contoso.json")}`,
      ),
      help: "Regenerate the swagger.",
    };
    const colored = formatDiagnostic(missingFile, { color: true });
    const plain = formatDiagnostic(missingFile, { color: false });
    expect(colored).toContain(
      '\n  - version "2024-06-01": \x1b[36m../stable/2024-06-01/contoso.json\x1b[39m\n',
    );
    expect(stripVTControlCharacters(colored)).toBe(plain);
    expect(plain).toBe(d`
      error test/service-yaml: Manifest references swagger files that do not exist:
        - version "2024-06-01": ../stable/2024-06-01/contoso.json
        help: Regenerate the swagger.
    `);
  });

  it("shows a diff after the file list, preserving Git colors and separating fix guidance", () => {
    const diff = "diff --git a/file.json b/file.json\n\x1b[31m-old\x1b[m\n\x1b[32m+new\x1b[m\n";
    const changedFiles: Diagnostic = {
      severity: "error",
      code: "generated-files-changed",
      message: "Files changed after TypeSpec compilation:",
      details: blocks(indent(filePath("file.json")), verbatim(diff)),
      help: "Include the generated files.",
    };
    const colored = formatDiagnostic(changedFiles, { color: true });
    expect(colored).toContain(`  \x1b[36mfile.json\x1b[39m\n\n${diff.trimEnd()}\n\n`);
    const plain = formatDiagnostic(changedFiles, { color: false });
    expect(stripVTControlCharacters(colored)).toBe(plain);
    expect(plain).toBe(d`
      error test/generated-files-changed: Files changed after TypeSpec compilation:
        file.json

      diff --git a/file.json b/file.json
      -old
      +new

        help: Include the generated files.
    `);
  });

  it("does not add blank lines for empty details", () => {
    expect(formatDiagnostic({ ...diagnostic, details: blocks(lines([]), "") })).toBe(
      formatDiagnostic(diagnostic),
    );
  });

  it.each([
    { line: 20, column: 1 },
    { line: 2, column: 0 },
    { line: 2, column: 100 },
  ])("does not invent a source excerpt for invalid location %j", (location) => {
    const output = formatDiagnostic({
      ...diagnostic,
      location: { ...location, text: diagnostic.location?.text },
    });
    expect(output).toContain(`:${location.line}:${location.column} - error test/invalid-option:`);
    expect(output).not.toContain("^");
    expect(output).not.toContain(" | ");
  });

  it("respects the default color setting for rule progress", () => {
    expect(formatRuleStatus("Rule", "PASS")).toBe("\u2714 Rule");
    expect(formatRuleSummary({ PASS: 1, FAIL: 0, WARN: 0, SKIP: 0, SUPPRESSED: 0 }, 0)).toBe(
      "1 passed",
    );
  });

  it.each([
    [{}, false, false],
    [{}, true, true],
    [{ TERM: "dumb" }, true, false],
    [{ GITHUB_ACTIONS: "true" }, false, true],
    [{ FORCE_COLOR: "1" }, false, true],
    [{ FORCE_COLOR: "0" }, true, false],
    [{ NO_COLOR: "", FORCE_COLOR: "1" }, true, false],
  ] as const)("selects color for env=%j tty=%s", (env, tty, expected) => {
    expect(supportsColor(env, tty)).toBe(expected);
  });

  it("reports errors and warnings without debug, deduplicating warnings and shared links", () => {
    const logger = new ConsoleLogger(false);
    const error = vi.spyOn(logger, "error").mockImplementation(() => {});
    const warning = vi.spyOn(logger, "warning").mockImplementation(() => {});
    const warningDiagnostic: Diagnostic = {
      severity: "warning",
      code: "skip",
      message: "Not compared.",
    };
    reportDiagnostics(
      [
        warningDiagnostic,
        warningDiagnostic,
        { ...diagnostic, url: "https://example.com/help" },
        { ...diagnostic, message: "Another invalid option.", url: "https://example.com/help" },
      ],
      logger,
    );
    expect(warning).toHaveBeenCalledExactlyOnceWith("warning test/skip: Not compared.");
    expect(error).toHaveBeenCalledTimes(2);
    expect(
      error.mock.calls
        .flat()
        .join("\n")
        .match(/https:\/\/example.com\/help/g),
    ).toHaveLength(1);
  });

  it("deduplicates by plain rendered content rather than document structure or color", () => {
    const logger = new ConsoleLogger(false);
    const error = vi.spyOn(logger, "error").mockImplementation(() => {});
    reportDiagnostics(
      [
        { ...diagnostic, details: filePath("service/file.json") },
        { ...diagnostic, details: "service/file.json" },
        { ...diagnostic, details: verbatim("\x1b[36mservice/file.json\x1b[39m") },
        { ...diagnostic, details: filePath("service/other.json") },
      ],
      logger,
    );
    expect(error).toHaveBeenCalledTimes(2);
    expect(error.mock.calls[0][0]).toContain("\nservice/file.json\n");
    expect(error.mock.calls[1][0]).toContain("\nservice/other.json\n");
  });
});
