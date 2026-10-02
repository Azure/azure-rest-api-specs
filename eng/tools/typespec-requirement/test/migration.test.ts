import { execa } from "execa";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { describe, expect, it, vi } from "vitest";
import { findFirstTypeSpecVersion, isTypeSpecGenerated } from "../src/migration.ts";

const generated =
  '{"info":{"x-typespec-generated":[{"emitter":"@azure-tools/typespec-autorest"}]}}';

describe("TypeSpec migration boundary", () => {
  it.each(["rewrite", "delete"])(
    "Preserves the base version after a %s of generated Swagger",
    async (change) => {
      const repoRoot = await mkdtemp(join(tmpdir(), "typespec-migration-"));
      const service = join(repoRoot, "specification/foo/resource-manager/Microsoft.Foo/Service");
      const swagger = join(service, "preview/2026-01-01-preview/foo.json");
      const warning = vi.fn();
      try {
        await mkdir(dirname(swagger), { recursive: true });
        await writeFile(swagger, generated);
        await execa("git", ["init", "--quiet"], { cwd: repoRoot });
        await execa("git", ["add", "."], { cwd: repoRoot });
        await execa(
          "git",
          [
            "-c",
            "user.name=Test",
            "-c",
            "user.email=test@example.com",
            "-c",
            "commit.gpgsign=false",
            "commit",
            "--quiet",
            "-m",
            "Generated Swagger",
          ],
          { cwd: repoRoot },
        );
        if (change === "rewrite") await writeFile(swagger, "{}");
        else await rm(swagger);
        const newer = join(service, "stable/2026-02-01/foo.json");
        await mkdir(dirname(newer), { recursive: true });
        await writeFile(newer, generated);

        expect(await findFirstTypeSpecVersion(service, warning)).toBe("2026-02-01");
        expect(
          await findFirstTypeSpecVersion(service, warning, { repoRoot, commitish: "HEAD" }),
        ).toBe("2026-01-01-preview");
        expect(warning).not.toHaveBeenCalled();
      } finally {
        await rm(repoRoot, { recursive: true, force: true });
      }
    },
  );

  it("Uses newly migrated versions even when the service does not exist at base", async () => {
    const repoRoot = await mkdtemp(join(tmpdir(), "typespec-migration-"));
    const service = join(repoRoot, "specification/foo/data-plane/Foo");
    try {
      await execa("git", ["init", "--quiet"], { cwd: repoRoot });
      await execa(
        "git",
        [
          "-c",
          "user.name=Test",
          "-c",
          "user.email=test@example.com",
          "-c",
          "commit.gpgsign=false",
          "commit",
          "--quiet",
          "--allow-empty",
          "-m",
          "Empty base",
        ],
        { cwd: repoRoot },
      );
      const swagger = join(service, "stable/2026-01-01/foo.json");
      await mkdir(dirname(swagger), { recursive: true });
      await writeFile(swagger, generated);

      expect(
        await findFirstTypeSpecVersion(service, vi.fn(), { repoRoot, commitish: "HEAD" }),
      ).toBe("2026-01-01");
      await expect(
        findFirstTypeSpecVersion(service, vi.fn(), { repoRoot, commitish: "nonexistent-commit" }),
      ).rejects.toThrow();
    } finally {
      await rm(repoRoot, { recursive: true, force: true });
    }
  });

  it("Does not lose the boundary when the only generated file is rewritten", async () => {
    const repoRoot = await mkdtemp(join(tmpdir(), "typespec-migration-"));
    const service = join(repoRoot, "specification/foo/data-plane/Foo");
    const swagger = join(service, "stable/2026-01-01/foo.json");
    try {
      await mkdir(dirname(swagger), { recursive: true });
      await writeFile(swagger, generated);
      await execa("git", ["init", "--quiet"], { cwd: repoRoot });
      await execa("git", ["add", "."], { cwd: repoRoot });
      await execa(
        "git",
        [
          "-c",
          "user.name=Test",
          "-c",
          "user.email=test@example.com",
          "-c",
          "commit.gpgsign=false",
          "commit",
          "--quiet",
          "-m",
          "Generated Swagger",
        ],
        { cwd: repoRoot },
      );
      await writeFile(swagger, "{}");

      expect(await findFirstTypeSpecVersion(service, vi.fn())).toBeUndefined();
      expect(
        await findFirstTypeSpecVersion(service, vi.fn(), { repoRoot, commitish: "HEAD" }),
      ).toBe("2026-01-01");
    } finally {
      await rm(repoRoot, { recursive: true, force: true });
    }
  });
});

describe("TypeSpec-generated marker", () => {
  it.each([
    [generated, true],
    ['{"info":{"x-typespec-generated":false}}', true],
    ['{"info":{"x-typespec-generated":null}}', false],
    ['{"info":null}', false],
    ['{"info":{}}', false],
    ["null", false],
    ["{}", false],
  ])("Recognizes the marker in %s", (content, expected) => {
    expect(isTypeSpecGenerated(content, "swagger.json", vi.fn())).toBe(expected);
  });

  it("Reports malformed JSON instead of using a marker found in invalid content", () => {
    const warning = vi.fn();
    expect(
      isTypeSpecGenerated('{"info":{"x-typespec-generated":true}', "broken.json", warning),
    ).toBe(false);
    expect(warning).toHaveBeenCalledWith(
      expect.stringContaining("OpenAPI 'broken.json' cannot be parsed"),
    );
  });
});
