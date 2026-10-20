import { diagnosticText } from "./diagnostics.ts";
import { describe, expect, it } from "vitest";
import { evaluateMultipleNewApiVersions } from "../src/rules/multiple-new-api-versions.ts";
import { javaEmitter, metadata, pythonEmitter } from "./api-version-fixtures.ts";

describe("evaluateMultipleNewApiVersions", function () {
  it("requires all configured SDK emitters to target the oldest newly added version", function () {
    const result = evaluateMultipleNewApiVersions(
      metadata({
        [pythonEmitter]: "2026-01-01",
        [javaEmitter]: "2026-02-01-preview",
      }),
      ["2026-02-01-preview", "2026-01-01"],
    );

    expect(result.success).toBe(false);
    expect(diagnosticText(result)).toContain("This pull request adds multiple API versions");
    expect(diagnosticText(result)).toContain(
      "the SDKs will be generated from API version 2026-02-01-preview",
    );
    expect(diagnosticText(result)).toContain(
      'To generate and release the SDKs from 2026-01-01 first, every SDK language emitter must set "api-version" to 2026-01-01',
    );
    expect(diagnosticText(result)).toContain(`${javaEmitter}: 2026-02-01-preview`);
    expect(diagnosticText(result)).toContain("expected 2026-01-01");
    expect(diagnosticText(result)).toContain(
      "https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation#multiplenewapiversions",
    );
  });

  it("passes when all configured SDK emitters target the oldest new version", function () {
    const result = evaluateMultipleNewApiVersions(
      metadata({
        [pythonEmitter]: "2026-01-01",
        [javaEmitter]: "2026-01-01",
      }),
      ["2026-02-01-preview", "2026-01-01"],
    );

    expect(result.success).toBe(true);
  });

  it("reports an emitter with no API version as not set", function () {
    const result = evaluateMultipleNewApiVersions(metadata({ [pythonEmitter]: undefined }), [
      "2026-02-01-preview",
      "2026-01-01",
    ]);

    expect(result.success).toBe(false);
    expect(diagnosticText(result)).toContain(`${pythonEmitter}: <not set> (expected 2026-01-01)`);
  });

  it("skips validation when no SDK language emitters are configured", function () {
    const result = evaluateMultipleNewApiVersions(metadata({}), [
      "2026-02-01-preview",
      "2026-01-01",
    ]);

    expect(result.success).toBe(true);
    expect(diagnosticText(result)).toBe(
      "No SDK language emitters are configured; skipping API-version validation.",
    );
  });
});
