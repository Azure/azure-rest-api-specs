import type { ILogger } from "@azure-tools/specs-shared/logger";
import type { generateTypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { readFile } from "node:fs/promises";
import { join, resolve } from "pathe";
import { describe, expect, it, vi } from "vitest";
import { validatePr } from "../src/index.ts";
import { writeBrownfield } from "../src/cli.ts";
import { metadata, pythonEmitter, serviceYaml } from "./api-version-fixtures.ts";
import { createRepo } from "./repo.ts";

const project = "specification/foo/Project";
const config = `${project}/tspconfig.yaml`;
const manifest = `${project}/service.yaml`;
const logger: ILogger = {
  debug: () => {},
  error: () => {},
  info: () => {},
  warning: () => {},
  isDebug: () => false,
};

describe("PR policy runner", () => {
  it("has no all-project fallback and ignores uncommitted selection changes", async () => {
    const { root, git, write } = await createRepo(
      { [config]: "{}", [manifest]: serviceYaml("2025-01-01") },
      { "eng/changed.ts": "" },
    );
    const generate = vi.fn<typeof generateTypeSpecMetadata>();
    await write({ [manifest]: serviceYaml("2025-01-01", "2026-01-01") });
    const before = (await git("status", "--porcelain")).stdout;
    const result = await validatePr({ cwd: root, base: "HEAD^", logger, metadata: generate });
    expect(result.success).toBe(true);
    expect(result.summary).toBe("No applicable spec PR policies.");
    expect(result.brownfield).toBe(false);
    expect(generate).not.toHaveBeenCalled();
    expect((await git("status", "--porcelain")).stdout).toBe(before);
  });

  it.each([
    { versions: ["2026-01-01"], pin: "2025-01-01", code: "stale-api-version-pin" },
    {
      versions: ["2026-01-01", "2026-02-01"],
      pin: "2026-02-01",
      code: "multiple-new-api-versions",
    },
  ])("evaluates $code with one metadata invocation", async ({ versions, pin, code }) => {
    const { root, git } = await createRepo(
      { [config]: "{}", [manifest]: serviceYaml("2025-01-01") },
      { [manifest]: serviceYaml("2025-01-01", ...versions), "eng/core.ts": "" },
    );
    const generate = vi
      .fn<typeof generateTypeSpecMetadata>()
      .mockResolvedValue(metadata({ [pythonEmitter]: pin }));
    const result = await validatePr({ cwd: root, base: "HEAD^", logger, metadata: generate });
    expect(result.success).toBe(false);
    expect(result.diagnostics).toHaveLength(1);
    expect(result.diagnostics[0].code).toBe(code);
    expect(result.diagnostics[0].path).toBe(join(root, project, "tspconfig.yaml"));
    expect(result.diagnostics[0].help).toContain("pnpm spec-pr-validation --base=");
    expect(generate).toHaveBeenCalledOnce();
    expect(resolve(generate.mock.calls[0][0])).toBe(join(root, project));
    expect(generate.mock.calls[0][1]).toEqual({ logger });
    expect((await git("status", "--porcelain")).stdout).toBe("");
  });

  it.each([
    { versions: [] },
    { versions: ["2026-01-01"] },
    { versions: ["2026-01-01", "2026-02-01"] },
  ])("passes compatible pins for added versions $versions", async ({ versions }) => {
    const { root } = await createRepo(
      { [config]: "{}", [manifest]: serviceYaml("2025-01-01") },
      { [manifest]: serviceYaml("2025-01-01", ...versions) },
    );
    const generate = vi
      .fn<typeof generateTypeSpecMetadata>()
      .mockResolvedValue(metadata({ [pythonEmitter]: "2026-01-01" }));
    const result = await validatePr({ cwd: root, base: "HEAD^", logger, metadata: generate });
    expect(result.success).toBe(true);
    expect(result.diagnostics).toEqual([]);
    expect(generate).toHaveBeenCalledTimes(versions.length === 0 ? 0 : 1);
  });

  it.each([
    { tool: "TypeSpecValidation", rule: "StaleApiVersionPin" },
    { tool: "SpecPrValidation", rule: "StaleApiVersionPin" },
    { tool: "TypeSpecValidation", rule: undefined },
  ])("honors $tool suppressions without metadata", async ({ tool, rule }) => {
    const { root } = await createRepo(
      { [config]: "{}", [manifest]: serviceYaml("2025-01-01") },
      {
        [manifest]: serviceYaml("2025-01-01", "2026-01-01"),
        "specification/foo/suppressions.yaml":
          `- tool: ${tool}\n  path: Project\n  reason: Approved\n  if: checkingAllSpecs === false\n` +
          (rule ? `  rules: [${rule}]\n` : ""),
      },
    );
    const generate = vi.fn<typeof generateTypeSpecMetadata>();
    const result = await validatePr({ cwd: root, base: "HEAD^", logger, metadata: generate });
    expect(result.success).toBe(true);
    expect(result.summary).toContain(rule ? "1 suppressed" : "2 suppressed");
    expect(generate).not.toHaveBeenCalled();
  });

  it.each(["TypeSpecValidationAll", "TypeSpecValidation"])(
    "does not let %s suppress Requirement",
    async (tool) => {
      const swagger = "specification/foo/data-plane/Foo/stable/2026-01-01/openapi.json";
      const { root } = await createRepo(
        {},
        {
          [swagger]: "{}",
          "specification/foo/suppressions.yaml": `- tool: ${tool}\n  path: "**"\n  reason: Project exemption\n`,
        },
      );
      const result = await validatePr({
        cwd: root,
        base: "HEAD^",
        logger,
        checkUpstream: () => Promise.resolve(404),
      });
      expect(result.success).toBe(false);
      expect(
        result.diagnostics.some((diagnostic) => diagnostic.code === "typespec-requirement"),
      ).toBe(true);
    },
  );

  it.each(["TypeSpecRequirement", "SpecPrValidation"])(
    "keeps migration safeguards for Requirement suppressions under %s",
    async (tool) => {
      const service = "specification/foo/data-plane/Foo";
      const { root } = await createRepo(
        {
          [`${service}/stable/2025-01-01/generated.json`]: '{"info":{"x-typespec-generated":true}}',
          [config]: "{}",
        },
        {
          [`${service}/stable/2026-01-01/handwritten.json`]: "{}",
          [`${service}/suppressions.yaml`]: `- tool: ${tool}\n  path: stable/2026-01-01/*.json\n  rules: [TypeSpecRequirement]\n  reason: Cannot bypass migration\n`,
        },
      );
      const result = await validatePr({
        cwd: root,
        base: "HEAD^",
        logger,
        checkUpstream: () => Promise.resolve(404),
      });
      expect(result.success).toBe(false);
      expect(
        result.diagnostics.some(
          (diagnostic) =>
            diagnostic.code === "typespec-requirement" && diagnostic.severity === "error",
        ),
      ).toBe(true);
    },
  );

  it("reports independent files and projects after policy and prerequisite failures", async () => {
    const other = "specification/bar/Other";
    const { root } = await createRepo(
      {
        [config]: "{}",
        [manifest]: serviceYaml("2025-01-01"),
        [`${other}/tspconfig.yaml`]: "{}",
        [`${other}/service.yaml`]: serviceYaml("2025-01-01"),
      },
      {
        [manifest]: serviceYaml("2025-01-01", "2026-01-01"),
        [`${other}/service.yaml`]: "versions: invalid",
        "specification/baz/data-plane/Baz/stable/2026-01-01/openapi.json": "{}",
        "specification/qux/data-plane/Qux/stable/2026-01-01/openapi.json": "{}",
      },
    );
    const generate = vi
      .fn<typeof generateTypeSpecMetadata>()
      .mockResolvedValue(metadata({ [pythonEmitter]: "2025-01-01" }));
    const result = await validatePr({
      cwd: root,
      base: "HEAD^",
      logger,
      metadata: generate,
      checkUpstream: () => Promise.resolve(404),
    });
    expect(result.success).toBe(false);
    expect(result.diagnostics.map((diagnostic) => diagnostic.code).sort()).toEqual([
      "sdk-api-version",
      "stale-api-version-pin",
      "typespec-requirement",
      "typespec-requirement",
    ]);
    expect(generate).toHaveBeenCalledTimes(1);
  });

  it("preserves native metadata failures and the known brownfield result", async () => {
    const { root } = await createRepo(
      { [config]: "{}", [manifest]: serviceYaml("2025-01-01") },
      {
        [manifest]: serviceYaml("2025-01-01", "2026-01-01"),
        "specification/foo/data-plane/Foo/stable/2025-01-01/openapi.json": "{}",
      },
    );
    const generate = vi
      .fn<typeof generateTypeSpecMetadata>()
      .mockRejectedValue(
        new Error("Failed to generate TypeSpec metadata:\ncompiler/native-error: Broken import"),
      );
    const result = await validatePr({
      cwd: root,
      base: "HEAD^",
      logger,
      metadata: generate,
      checkUpstream: () => Promise.resolve(200),
    });
    expect(result.success).toBe(false);
    const errors = result.diagnostics.filter((diagnostic) => diagnostic.code === "sdk-metadata");
    expect(errors).toHaveLength(1);
    expect(errors[0].message).toContain("compiler/native-error: Broken import");
    const output = join(root, "output");
    await writeBrownfield(result.brownfield, output);
    expect(await readFile(output, "utf8")).toBe("brownfield=true\n");
  });

  it("leaves classification unset on upstream operational failure", async () => {
    const { root } = await createRepo(
      {},
      {
        "specification/foo/data-plane/Foo/stable/2026-01-01/openapi.json": "{}",
      },
    );
    const result = await validatePr({
      cwd: root,
      base: "HEAD^",
      logger,
      checkUpstream: () => Promise.reject(new Error("Network unavailable")),
    });
    expect(result.success).toBe(false);
    expect(result.brownfield).toBeUndefined();
    expect(result.diagnostics[0].message).toContain("Network unavailable");
    const output = join(root, "output");
    await writeBrownfield(result.brownfield, output);
    await expect(readFile(output)).rejects.toMatchObject({ code: "ENOENT" });
  });

  it("writes false despite an independent SDK policy failure to clear stale labels", async () => {
    const { root } = await createRepo(
      { [config]: "{}", [manifest]: serviceYaml("2025-01-01") },
      { [manifest]: serviceYaml("2025-01-01", "2026-01-01") },
    );
    const result = await validatePr({
      cwd: root,
      base: "HEAD^",
      logger,
      metadata: () => Promise.resolve(metadata({ [pythonEmitter]: "2025-01-01" })),
    });
    const output = join(root, "output");
    await writeBrownfield(result.brownfield, output);
    expect(result.success).toBe(false);
    expect(await readFile(output, "utf8")).toBe("brownfield=false\n");
  });
});
