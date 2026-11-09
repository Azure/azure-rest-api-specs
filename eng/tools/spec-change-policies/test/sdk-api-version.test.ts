import { diagnosticText } from "./diagnostics.ts";
import { defaultLogger } from "@azure-tools/specs-shared/logger";
import { resolve } from "pathe";
import type { PrContext } from "../src/context.ts";
import { afterEach, describe, expect, it, vi } from "vitest";
import {
  compareApiVersionsAsc,
  resolveNewApiVersions,
  resolveSdkEmitters,
} from "../src/rules/sdk-api-version.ts";
import * as utils from "../src/context.ts";
import { metadata, pythonEmitter, serviceYaml } from "./api-version-fixtures.ts";

const context: PrContext = {
  root: process.cwd(),
  baseCommitish: "base",
  headCommitish: "head",
  logger: defaultLogger,
  changes: { additions: [], modifications: [], deletions: [], renames: [], total: 0 },
};

describe("resolveNewApiVersions", function () {
  afterEach(() => vi.restoreAllMocks());

  it("skips projects without service.yaml at head", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockResolvedValue(undefined);

    const resolved = await resolveNewApiVersions(resolve("specification/foo/Foo"), context);

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && diagnosticText(resolved.result)).toContain(
      "service.yaml does not exist at head",
    );
  });

  it("skips when no TypeSpec API version was added", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockResolvedValue(serviceYaml("2025-01-01"));

    const resolved = await resolveNewApiVersions(resolve("specification/foo/Foo"), context);

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && resolved.result.skipped).toContain(
      "No new TypeSpec API versions",
    );
  });

  it("ignores swagger-sourced versions when finding newly added versions", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(
        `${serviceYaml("2025-01-01")}  - version: 2026-01-01\n    source: swagger\n`,
      );

    const resolved = await resolveNewApiVersions(resolve("specification/foo/Foo"), context);

    expect(resolved.kind).toBe("skip");
  });

  it("returns newly added versions", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));

    const resolved = await resolveNewApiVersions(resolve("specification/foo/Foo"), context);

    expect(resolved.kind === "versions" && resolved.newApiVersions).toEqual(["2026-01-01"]);
  });

  it("treats all head TypeSpec versions as new when service.yaml is absent at base", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(undefined)
      .mockResolvedValueOnce(serviceYaml("2026-01-01"));

    const resolved = await resolveNewApiVersions(resolve("specification/foo/Foo"), context);

    expect(resolved.kind === "versions" && resolved.newApiVersions).toEqual(["2026-01-01"]);
  });

  it("fails when service.yaml cannot be read", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockRejectedValue(new Error("bad revision"));

    const resolved = await resolveNewApiVersions(resolve("specification/foo/Foo"), context);

    expect(resolved.kind === "skip" && resolved.result.success).toBe(false);
    expect(resolved.kind === "skip" && diagnosticText(resolved.result)).toContain(
      "Unable to compare service.yaml",
    );
  });

  it("fails when service.yaml is malformed at head", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockResolvedValue("versions: not-a-list\n");

    const resolved = await resolveNewApiVersions(resolve("specification/foo/Foo"), context);

    expect(resolved.kind === "skip" && resolved.result.success).toBe(false);
    expect(resolved.kind === "skip" && diagnosticText(resolved.result)).toContain("head:");
  });

  it("fails when service.yaml is malformed at base", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce("versions: not-a-list\n")
      .mockResolvedValueOnce(serviceYaml("2026-01-01"));

    const resolved = await resolveNewApiVersions(resolve("specification/foo/Foo"), context);

    expect(resolved.kind === "skip" && resolved.result.success).toBe(false);
    expect(resolved.kind === "skip" && diagnosticText(resolved.result)).toContain("base:");
  });
});

describe("resolveSdkEmitters", function () {
  it("skips when no SDK language emitters are configured", function () {
    const resolved = resolveSdkEmitters(metadata({}));

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && diagnosticText(resolved.result)).toBe(
      "No SDK language emitters are configured; skipping API-version validation.",
    );
  });

  it("skips multiple-service projects", function () {
    const resolved = resolveSdkEmitters(metadata({ [pythonEmitter]: "multiple-versions" }));

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && diagnosticText(resolved.result)).toBe(
      "This rule does not support multiple-service project scenarios.",
    );
  });

  it("ignores emitters that are not SDK language emitters", function () {
    const resolved = resolveSdkEmitters(
      metadata({ "@azure-tools/typespec-autorest": "2026-01-01" }),
    );

    expect(resolved.kind).toBe("skip");
  });

  it("returns the configured SDK emitters", function () {
    const resolved = resolveSdkEmitters(metadata({ [pythonEmitter]: "2026-01-01" }));

    expect(resolved.kind === "emitters" && resolved.emitters).toHaveLength(1);
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

  it("falls back to string comparison for non-date values", function () {
    expect(compareApiVersionsAsc("all", "2026-01-01")).toBeGreaterThan(0);
  });
});
