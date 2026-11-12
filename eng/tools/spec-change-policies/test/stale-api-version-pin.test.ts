import { diagnosticText } from "./diagnostics.ts";
import { describe, expect, it } from "vitest";
import { evaluateStaleApiVersionPin } from "../src/rules/stale-api-version-pin.ts";
import { javaEmitter, metadata, pythonEmitter } from "./api-version-fixtures.ts";

describe("evaluateStaleApiVersionPin", function () {
  it("reports every emitter pinned to an older version", function () {
    const result = evaluateStaleApiVersionPin(
      metadata({ [pythonEmitter]: "2025-01-01", [javaEmitter]: "2025-06-01" }),
      "2026-01-01",
    );

    expect(result.success).toBe(false);
    expect(diagnosticText(result)).toContain(
      "This pull request adds API version 2026-01-01, but the SDK language emitters " +
        "below are pinned to an older API version, so their SDKs will be generated from the " +
        "pinned version instead.",
    );
    expect(diagnosticText(result)).toContain(
      'To generate and release the SDKs from 2026-01-01, remove the "api-version" setting from ' +
        "these emitters in tspconfig.yaml:",
    );
    expect(diagnosticText(result)).toContain(`  - ${pythonEmitter}: 2025-01-01`);
    expect(diagnosticText(result)).toContain(`  - ${javaEmitter}: 2025-06-01`);
    expect(diagnosticText(result)).toContain(
      "https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation#staleapiversionpin",
    );
  });

  it("ignores emitters targeting the new version", function () {
    const result = evaluateStaleApiVersionPin(
      metadata({ [pythonEmitter]: "2025-01-01", [javaEmitter]: "2026-01-01" }),
      "2026-01-01",
    );

    expect(result.success).toBe(false);
    expect(diagnosticText(result)).toContain(pythonEmitter);
    expect(diagnosticText(result)).not.toContain(javaEmitter);
  });

  it("does not compare non-date API-version values", function () {
    const result = evaluateStaleApiVersionPin(metadata({ [pythonEmitter]: "all" }), "2026-01-01");

    expect(result.success).toBe(true);
    expect(result.diagnostics).toBeUndefined();
  });

  it("does not compare when an emitter reports no API version", function () {
    const result = evaluateStaleApiVersionPin(
      metadata({ [pythonEmitter]: undefined }),
      "2026-01-01",
    );

    expect(result.success).toBe(true);
  });

  it("skips multiple-service projects", function () {
    const result = evaluateStaleApiVersionPin(
      metadata({ [pythonEmitter]: "multiple-versions" }),
      "2026-01-01",
    );

    expect(result.success).toBe(true);
    expect(diagnosticText(result)).toContain("does not support multiple-service project");
  });
});
