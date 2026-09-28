import { generateTypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { context } from "../src/index.ts";
import {
  evaluateMultipleNewApiVersions,
  MultipleNewApiVersionsRule,
} from "../src/rules/multiple-new-api-versions.ts";
import * as utils from "../src/utils.ts";
import { javaEmitter, metadata, pythonEmitter, serviceYaml } from "./api-version-fixtures.ts";

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn(),
}));

describe("MultipleNewApiVersionsRule", function () {
  beforeEach(() => {
    context.baseCommitish = "base";
    context.headCommitish = "head";
    context.checkingAllSpecs = false;
  });

  afterEach(() => {
    vi.restoreAllMocks();
    vi.mocked(generateTypeSpecMetadata).mockReset();
  });

  it("skips when only one API version was added", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("Only one new API version was added");
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("passes when every emitter targets the oldest new version", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01", "2026-02-01"));
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
      metadata({ [pythonEmitter]: "2026-01-01" }),
    );

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toBe("All SDK language emitters target 2026-01-01.");
    expect(generateTypeSpecMetadata).toHaveBeenCalledOnce();
  });

  it("fails and includes the reproduce hint when an emitter is not pinned", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01", "2026-02-01"));
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
      metadata({ [pythonEmitter]: "2026-02-01" }),
    );

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("To reproduce locally:");
  });

  it("fails when metadata generation fails", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01", "2026-02-01"));
    vi.mocked(generateTypeSpecMetadata).mockRejectedValue(new Error("metadata failed"));

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("metadata failed");
  });

  it("is suppressable", function () {
    expect(new MultipleNewApiVersionsRule().suppressable).toBe(true);
  });
});

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
    expect(result.errorOutput).toContain("ERROR: This pull request adds multiple API versions");
    expect(result.errorOutput).toContain(
      "the SDKs will be generated from API version 2026-02-01-preview",
    );
    expect(result.errorOutput).toContain(
      'To generate and release the SDKs from 2026-01-01 first, every SDK language emitter must set "api-version" to 2026-01-01',
    );
    expect(result.errorOutput).toContain(`${javaEmitter}: 2026-02-01-preview`);
    expect(result.errorOutput).toContain("expected 2026-01-01");
    expect(result.errorOutput).toContain(
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
    expect(result.errorOutput).toContain(`${pythonEmitter}: <not set> (expected 2026-01-01)`);
  });

  it("skips validation when no SDK language emitters are configured", function () {
    const result = evaluateMultipleNewApiVersions(metadata({}), [
      "2026-02-01-preview",
      "2026-01-01",
    ]);

    expect(result.success).toBe(true);
    expect(result.stdOutput).toBe(
      "Warning: No SDK language emitters are configured; skipping API-version validation.",
    );
  });
});
