import { generateTypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { context } from "../src/index.ts";
import {
  compareApiVersionsAsc,
  resolveNewApiVersions,
  resolveSdkEmitters,
} from "../src/rules/sdk-api-version.ts";
import * as utils from "../src/utils.ts";
import { metadata, pythonEmitter, serviceYaml } from "./api-version-fixtures.ts";

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn(),
}));

describe("resolveNewApiVersions", function () {
  beforeEach(() => {
    context.baseCommitish = "base";
    context.headCommitish = "head";
    context.checkingAllSpecs = false;
  });

  afterEach(() => {
    vi.restoreAllMocks();
    vi.mocked(generateTypeSpecMetadata).mockReset();
  });

  it("skips comparison when validating all specs", async function () {
    context.checkingAllSpecs = true;
    const readFileAtCommit = vi.spyOn(utils, "readFileAtCommit");

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && resolved.result.stdOutput).toContain("Validating all specs");
    expect(readFileAtCommit).not.toHaveBeenCalled();
  });

  it("skips when no commits are provided", async function () {
    delete context.baseCommitish;
    delete context.headCommitish;
    const readFileAtCommit = vi.spyOn(utils, "readFileAtCommit");

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && resolved.result.stdOutput).toContain(
      `npx tsv specification/foo/Foo '{"baseCommitish":"{commitShaOfMain}","headCommitish":"{headShaOfLocalBranch}"}'`,
    );
    expect(readFileAtCommit).not.toHaveBeenCalled();
  });

  it("skips projects without service.yaml at head", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockResolvedValue(undefined);

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && resolved.result.stdOutput).toContain(
      "Warning: service.yaml does not exist at head",
    );
  });

  it("skips when no TypeSpec API version was added", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockResolvedValue(serviceYaml("2025-01-01"));

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && resolved.result.stdOutput).toContain(
      "No new TypeSpec API versions",
    );
  });

  it("ignores swagger-sourced versions when finding newly added versions", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(
        `${serviceYaml("2025-01-01")}  - version: 2026-01-01\n    source: swagger\n`,
      );

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind).toBe("skip");
  });

  it("returns newly added versions", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind === "versions" && resolved.newApiVersions).toEqual(["2026-01-01"]);
  });

  it("treats all head TypeSpec versions as new when service.yaml is absent at base", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(undefined)
      .mockResolvedValueOnce(serviceYaml("2026-01-01"));

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind === "versions" && resolved.newApiVersions).toEqual(["2026-01-01"]);
  });

  it("fails when service.yaml cannot be read", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockRejectedValue(new Error("bad revision"));

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind === "skip" && resolved.result.success).toBe(false);
    expect(resolved.kind === "skip" && resolved.result.errorOutput).toContain(
      "Unable to compare service.yaml",
    );
  });

  it("fails when service.yaml is malformed at head", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockResolvedValue("versions: not-a-list\n");

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind === "skip" && resolved.result.success).toBe(false);
    expect(resolved.kind === "skip" && resolved.result.errorOutput).toContain("ERROR: head:");
  });

  it("fails when service.yaml is malformed at base", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce("versions: not-a-list\n")
      .mockResolvedValueOnce(serviceYaml("2026-01-01"));

    const resolved = await resolveNewApiVersions("specification/foo/Foo");

    expect(resolved.kind === "skip" && resolved.result.success).toBe(false);
    expect(resolved.kind === "skip" && resolved.result.errorOutput).toContain("ERROR: base:");
  });
});

describe("resolveSdkEmitters", function () {
  it("skips when no SDK language emitters are configured", function () {
    const resolved = resolveSdkEmitters(metadata({}));

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && resolved.result.stdOutput).toBe(
      "Warning: No SDK language emitters are configured; skipping API-version validation.",
    );
  });

  it("skips multiple-service projects", function () {
    const resolved = resolveSdkEmitters(metadata({ [pythonEmitter]: "multiple-versions" }));

    expect(resolved.kind).toBe("skip");
    expect(resolved.kind === "skip" && resolved.result.stdOutput).toBe(
      "Warning: This rule does not support multiple-service project scenarios.",
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
