import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { stripVTControlCharacters } from "node:util";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  exceptionDiagnostic,
  formatDiagnostic,
  reportDiagnostics,
  supportsColor,
} from "../src/diagnostics.ts";
import type { Diagnostic } from "../src/rule-result.ts";
import { parse, parseYaml } from "../src/tsp-config.ts";

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
  it("uses TypeSpec-style locations, severity, codes and a real source excerpt", () => {
    expect(formatDiagnostic(diagnostic, { cwd: "/repo" })).toBe(
      "service/tspconfig.yaml:2:3 - error tsv/invalid-option: Invalid option.\n" +
        "  2 |   invalid: true\n    |   ^\n  help: Remove the option.",
    );
    expect(formatDiagnostic({ ...diagnostic, location: undefined }, { cwd: "/repo" })).toBe(
      "service/tspconfig.yaml - error tsv/invalid-option: Invalid option.\n  help: Remove the option.",
    );
    expect(
      formatDiagnostic({ severity: "warning", code: "skipped", message: "Comparison skipped." }),
    ).toBe("warning tsv/skipped: Comparison skipped.");
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
    expect(warning).toHaveBeenCalledExactlyOnceWith("warning tsv/skip: Not compared.");
    expect(error).toHaveBeenCalledTimes(2);
    expect(
      error.mock.calls
        .flat()
        .join("\n")
        .match(/https:\/\/example.com\/help/g),
    ).toHaveLength(1);
  });
});

describe("configuration errors", () => {
  it("reports parser locations without duplicate YAML source excerpts", () => {
    try {
      parseYaml("a: true\na: false\n", "/repo/tspconfig.yaml");
      expect.fail("Expected malformed YAML");
    } catch (error) {
      const result = exceptionDiagnostic(error);
      expect(result).toMatchObject({
        code: "invalid-yaml",
        path: "/repo/tspconfig.yaml",
        location: { line: 2, column: 1 },
      });
      const output = formatDiagnostic(result, { cwd: "/repo" });
      expect(output).toContain("tspconfig.yaml:2:1 - error tsv/invalid-yaml:");
      expect(output.match(/a: false/g)).toHaveLength(1);
    }
  });

  it("reports invalid config keys without dumping Zod's internal object or guessing a location", () => {
    try {
      parse("emit: false", "/repo/tspconfig.yaml");
      expect.fail("Expected invalid config");
    } catch (error) {
      const result = exceptionDiagnostic(error);
      expect(result.code).toBe("invalid-config");
      expect(result.message).toContain("emit:");
      expect(result.message).not.toContain('"expected"');
      expect(result.location).toBeUndefined();
    }
  });
});
