import { generateTypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { context } from "../src/index.ts";
import {
  StaleApiVersionPinRule,
  evaluateStaleApiVersionPin,
} from "../src/rules/stale-api-version-pin.ts";
import * as utils from "../src/utils.ts";
import { javaEmitter, metadata, pythonEmitter, serviceYaml } from "./api-version-fixtures.ts";

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn(),
}));

describe("StaleApiVersionPinRule", function () {
  beforeEach(() => {
    context.baseCommitish = "base";
    context.headCommitish = "head";
    context.checkingAllSpecs = false;
  });

  afterEach(() => {
    vi.restoreAllMocks();
    vi.mocked(generateTypeSpecMetadata).mockReset();
  });

  it("skips when multiple API versions were added", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01", "2026-02-01"));

    const result = await new StaleApiVersionPinRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("Multiple new API versions were added");
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("passes when no emitter is pinned to an older version", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
      metadata({ [pythonEmitter]: "2026-01-01" }),
    );

    const result = await new StaleApiVersionPinRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(generateTypeSpecMetadata).toHaveBeenCalledOnce();
  });

  it("fails and includes the reproduce hint when an emitter is stale", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
      metadata({ [pythonEmitter]: "2025-01-01" }),
    );

    const result = await new StaleApiVersionPinRule().execute("specification/foo/Foo");

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain(`  - ${pythonEmitter}: 2025-01-01`);
    expect(result.errorOutput).toContain("To reproduce locally:");
  });

  it("fails when metadata generation fails", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));
    vi.mocked(generateTypeSpecMetadata).mockRejectedValue(new Error("metadata failed"));

    const result = await new StaleApiVersionPinRule().execute("specification/foo/Foo");

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("metadata failed");
  });

  it("is suppressable", function () {
    expect(new StaleApiVersionPinRule().suppressable).toBe(true);
  });
});

describe("evaluateStaleApiVersionPin", function () {
  it("reports every emitter pinned to an older version", function () {
    const result = evaluateStaleApiVersionPin(
      metadata({ [pythonEmitter]: "2025-01-01", [javaEmitter]: "2025-06-01" }),
      "2026-01-01",
    );

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain(
      "ERROR: This pull request adds API version 2026-01-01, but the SDK language emitters " +
        "below are pinned to an older API version, so their SDKs will be generated from the " +
        "pinned version instead.",
    );
    expect(result.errorOutput).toContain(
      'To generate and release the SDKs from 2026-01-01, remove the "api-version" setting from ' +
        "these emitters in tspconfig.yaml:",
    );
    expect(result.errorOutput).toContain(`  - ${pythonEmitter}: 2025-01-01`);
    expect(result.errorOutput).toContain(`  - ${javaEmitter}: 2025-06-01`);
    expect(result.errorOutput).toContain(
      "https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation#staleapiversionpin",
    );
  });

  it("ignores emitters targeting the new version", function () {
    const result = evaluateStaleApiVersionPin(
      metadata({ [pythonEmitter]: "2025-01-01", [javaEmitter]: "2026-01-01" }),
      "2026-01-01",
    );

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain(pythonEmitter);
    expect(result.errorOutput).not.toContain(javaEmitter);
  });

  it("does not compare non-date API-version values", function () {
    const result = evaluateStaleApiVersionPin(metadata({ [pythonEmitter]: "all" }), "2026-01-01");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toBe("No SDK emitter targets an API version older than 2026-01-01.");
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
    expect(result.stdOutput).toContain("does not support multiple-service project");
  });
});
