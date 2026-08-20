import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { context } from "../src/index.ts";
import {
  compareApiVersionsAsc,
  evaluateApiVersionPolicy,
  MultipleNewApiVersionsRule,
} from "../src/rules/multiple-new-api-versions.ts";
import * as utils from "../src/utils.ts";

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn(),
}));

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
  beforeEach(() => {
    context.baseCommitish = "base";
    context.headCommitish = "head";
    context.checkingAllSpecs = false;
  });

  afterEach(() => {
    vi.restoreAllMocks();
    vi.mocked(generateTypeSpecMetadata).mockReset();
  });

  it("does not generate metadata when no TypeSpec API version was added", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockResolvedValue(serviceYaml("2025-01-01"));

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("No new TypeSpec API versions");
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("generates metadata when one TypeSpec API version was added", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
      metadata({ [pythonEmitter]: "2026-01-01" }),
    );

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).not.toContain("Warning:");
    expect(generateTypeSpecMetadata).toHaveBeenCalledOnce();
  });

  it("ignores swagger-sourced versions when finding newly added versions", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(
        `${serviceYaml("2025-01-01")}  - version: 2026-01-01\n    source: swagger\n`,
      );

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("treats all head TypeSpec versions as new when service.yaml is absent at base", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(undefined)
      .mockResolvedValueOnce(serviceYaml("2026-01-01"));
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
      metadata({ [pythonEmitter]: "2026-01-01" }),
    );

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(generateTypeSpecMetadata).toHaveBeenCalledOnce();
  });

  it("skips projects without service.yaml at head", async function () {
    vi.spyOn(utils, "readFileAtCommit").mockResolvedValue(undefined);

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("Warning: service.yaml does not exist at head");
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("skips comparison when validating all specs", async function () {
    context.checkingAllSpecs = true;
    const readFileAtCommit = vi.spyOn(utils, "readFileAtCommit");

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("Validating all specs");
    expect(readFileAtCommit).not.toHaveBeenCalled();
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("skips when no commits are provided", async function () {
    delete context.baseCommitish;
    delete context.headCommitish;
    const readFileAtCommit = vi.spyOn(utils, "readFileAtCommit");

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("No commits to compare");
    expect(result.stdOutput).toContain(
      `npx tsv specification/foo/Foo '{"baseCommitish":"{commitShaOfMain}","headCommitish":"{headShaOfLocalBranch}"}'`,
    );
    expect(readFileAtCommit).not.toHaveBeenCalled();
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("fails when metadata generation fails", async function () {
    vi.spyOn(utils, "readFileAtCommit")
      .mockResolvedValueOnce(serviceYaml("2025-01-01"))
      .mockResolvedValueOnce(serviceYaml("2025-01-01", "2026-01-01"));
    vi.mocked(generateTypeSpecMetadata).mockRejectedValue(new Error("metadata failed"));

    const result = await new MultipleNewApiVersionsRule().execute("specification/foo/Foo");

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

  it("does not warn for non-date API-version values", function () {
    const result = evaluateApiVersionPolicy(metadata({ [pythonEmitter]: "all" }), ["2026-01-01"]);

    expect(result.success).toBe(true);
    expect(result.stdOutput).toBe("No SDK emitter targets an API version older than 2026-01-01.");
  });

  it("does not warn when an emitter reports no API version", function () {
    const result = evaluateApiVersionPolicy(metadata({ [pythonEmitter]: undefined }), [
      "2026-01-01",
    ]);

    expect(result.success).toBe(true);
    expect(result.stdOutput).toBe("No SDK emitter targets an API version older than 2026-01-01.");
  });

  it("reports an emitter with no API version as not set", function () {
    const result = evaluateApiVersionPolicy(metadata({ [pythonEmitter]: undefined }), [
      "2026-02-01-preview",
      "2026-01-01",
    ]);

    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain(`${pythonEmitter}: <not set> (expected 2026-01-01)`);
  });

  it("skips multiple-service projects when one version is added", function () {
    const result = evaluateApiVersionPolicy(
      metadata({ [pythonEmitter]: "multiple-versions", [javaEmitter]: "multiple-versions" }),
      ["2026-01-01"],
    );

    expect(result.success).toBe(true);
    expect(result.stdOutput).toBe(
      "Warning: This rule does not support multiple-service project scenarios.",
    );
  });

  it("skips multiple-service projects instead of failing when multiple versions are added", function () {
    const result = evaluateApiVersionPolicy(
      metadata({ [pythonEmitter]: "multiple-versions", [javaEmitter]: "multiple-versions" }),
      ["2026-02-01-preview", "2026-01-01"],
    );

    expect(result.success).toBe(true);
    expect(result.stdOutput).toBe(
      "Warning: This rule does not support multiple-service project scenarios.",
    );
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
    expect(result.errorOutput).toContain("ERROR: This pull request adds multiple API versions");
    expect(result.errorOutput).toContain(`${javaEmitter}: 2026-02-01-preview`);
    expect(result.errorOutput).toContain("expected 2026-01-01");
    expect(result.errorOutput).toContain(
      "https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation#multiplenewapiversions",
    );
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

  it("skips validation when no SDK language emitters are configured", function () {
    const result = evaluateApiVersionPolicy(metadata({}), ["2026-02-01-preview", "2026-01-01"]);

    expect(result.success).toBe(true);
    expect(result.stdOutput).toBe(
      "Warning: No SDK language emitters are configured; skipping API-version validation.",
    );
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
