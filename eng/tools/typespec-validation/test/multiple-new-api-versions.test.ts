import { type TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { describe, expect, it, vi } from "vitest";
import {
  compareApiVersionsAsc,
  evaluateApiVersionPolicy,
  MultipleNewApiVersionsRule,
} from "../src/rules/multiple-new-api-versions.ts";

function serviceYaml(...versions: string[]) {
  return `versions:\n${versions
    .map((version) => `  - version: ${version}\n    source: typespec`)
    .join("\n")}\n`;
}

function metadata(apiVersions: Record<string, string | undefined>): TypeSpecMetadata {
  return {
    emitterVersion: "0.3.0",
    generatedAt: "2026-08-18T00:00:00.000Z",
    typespec: {
      namespace: "Contoso.Management",
      type: "management",
    },
    languages: Object.fromEntries(
      Object.entries(apiVersions).map(([emitterName, apiVersion]) => [
        emitterName,
        [{ emitterName, apiVersion }],
      ]),
    ),
  };
}

const pythonEmitter = "@azure-tools/typespec-python";
const javaEmitter = "@azure-tools/typespec-java";

describe("MultipleNewApiVersionsRule", function () {
  it("does not generate metadata when no TypeSpec API version was added", async function () {
    const generateMetadata = vi.fn();
    const rule = new MultipleNewApiVersionsRule({
      baseCommitish: "base",
      headCommitish: "head",
      readFileAtCommit: vi.fn().mockResolvedValue(serviceYaml("2025-01-01")),
      generateMetadata,
    });

    const result = await rule.execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("No new TypeSpec API versions");
    expect(generateMetadata).not.toHaveBeenCalled();
  });

  it("generates metadata when one TypeSpec API version was added", async function () {
    const generateMetadata = vi.fn().mockResolvedValue(metadata({ [pythonEmitter]: "2026-01-01" }));
    const readFileAtCommit = vi
      .fn()
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));
    const rule = new MultipleNewApiVersionsRule({
      baseCommitish: "base",
      headCommitish: "head",
      readFileAtCommit,
      generateMetadata,
    });

    const result = await rule.execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).not.toContain("Warning:");
    expect(generateMetadata).toHaveBeenCalledOnce();
  });

  it("ignores swagger-sourced versions when finding newly added versions", async function () {
    const generateMetadata = vi.fn();
    const readFileAtCommit = vi
      .fn()
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(
        `${serviceYaml("2025-01-01")}  - version: 2026-01-01\n    source: swagger\n`,
      );
    const rule = new MultipleNewApiVersionsRule({ readFileAtCommit, generateMetadata });

    const result = await rule.execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(generateMetadata).not.toHaveBeenCalled();
  });

  it("treats all head TypeSpec versions as new when service.yaml is absent at base", async function () {
    const generateMetadata = vi.fn().mockResolvedValue(metadata({ [pythonEmitter]: "2026-01-01" }));
    const readFileAtCommit = vi
      .fn()
      .mockResolvedValueOnce(undefined)
      .mockResolvedValueOnce(serviceYaml("2026-01-01"));
    const rule = new MultipleNewApiVersionsRule({ readFileAtCommit, generateMetadata });

    const result = await rule.execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(generateMetadata).toHaveBeenCalledOnce();
  });

  it("skips projects without service.yaml at head", async function () {
    const generateMetadata = vi.fn();
    const rule = new MultipleNewApiVersionsRule({
      readFileAtCommit: vi.fn().mockResolvedValue(undefined),
      generateMetadata,
    });

    const result = await rule.execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("validation skipped");
    expect(generateMetadata).not.toHaveBeenCalled();
  });

  it("fails when metadata generation fails", async function () {
    const readFileAtCommit = vi
      .fn()
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));
    const rule = new MultipleNewApiVersionsRule({
      readFileAtCommit,
      generateMetadata: vi.fn().mockRejectedValue(new Error("metadata failed")),
    });

    const result = await rule.execute("specification/foo/Foo");

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("metadata failed");
  });
});

describe("evaluateApiVersionPolicy", function () {
  it("warns for each emitter targeting an older version when one version is added", function () {
    const result = evaluateApiVersionPolicy(
      metadata({
        [pythonEmitter]: "2025-01-01",
        [javaEmitter]: "2026-01-01",
      }),
      ["2026-01-01"],
    );

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain(`Warning: ${pythonEmitter}`);
    expect(result.stdOutput).not.toContain(`Warning: ${javaEmitter}`);
  });

  it("does not compare special metadata API-version values", function () {
    const result = evaluateApiVersionPolicy(metadata({ [pythonEmitter]: "all" }), ["2026-01-01"]);

    expect(result.success).toBe(true);
    expect(result.stdOutput).not.toContain("Warning:");
  });

  it("skips multiple-service projects when one version is added", function () {
    const result = evaluateApiVersionPolicy(
      metadata({ [pythonEmitter]: "multiple-versions", [javaEmitter]: "multiple-versions" }),
      ["2026-01-01"],
    );

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("does not support multiple-service project");
  });

  it("skips multiple-service projects instead of failing when multiple versions are added", function () {
    const result = evaluateApiVersionPolicy(
      metadata({ [pythonEmitter]: "multiple-versions", [javaEmitter]: "multiple-versions" }),
      ["2026-02-01-preview", "2026-01-01"],
    );

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("does not support multiple-service project");
  });

  it("requires all configured SDK emitters to target the oldest newly added version", function () {
    const result = evaluateApiVersionPolicy(
      metadata({
        [pythonEmitter]: "2026-01-01",
        [javaEmitter]: "2026-02-01-preview",
      }),
      ["2026-02-01-preview", "2026-01-01"],
    );

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain(`${javaEmitter}: 2026-02-01-preview`);
    expect(result.errorOutput).toContain("expected 2026-01-01");
  });

  it("passes when all configured SDK emitters target the oldest new version", function () {
    const result = evaluateApiVersionPolicy(
      metadata({
        [pythonEmitter]: "2026-01-01",
        [javaEmitter]: "2026-01-01",
      }),
      ["2026-02-01-preview", "2026-01-01"],
    );

    expect(result.success).toBe(true);
  });

  it("fails multiple-version validation when no SDK emitters are reported", function () {
    const result = evaluateApiVersionPolicy(metadata({}), ["2026-02-01-preview", "2026-01-01"]);

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("did not report any configured SDK language emitters");
  });
});

describe("compareApiVersionsAsc", function () {
  it("sorts oldest first and treats preview as older than stable on the same date", function () {
    const versions = ["2026-01-01", "2025-01-01", "2026-01-01-preview"];
    expect(versions.sort(compareApiVersionsAsc)).toEqual([
      "2025-01-01",
      "2026-01-01-preview",
      "2026-01-01",
    ]);
  });
});
