import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { exceptionDiagnostic, formatDiagnostic } from "../src/diagnostics.ts";
import { parse, parseYaml } from "../src/tsp-config.ts";

beforeEach(() => vi.stubEnv("NO_COLOR", "1"));
afterEach(() => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
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
