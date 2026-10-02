import { execa } from "execa";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { checkFiles } from "../src/index.ts";
import { isTypeSpecGenerated } from "../src/migration.ts";

const generated =
  '{"info":{"x-typespec-generated":[{"emitter":"@azure-tools/typespec-autorest"}]}}';
const service = "specification/foo/resource-manager/Microsoft.Foo/Service";
const generatedFile = `${service}/stable/2026-01-01/generated.json`;
const migratedFiles = {
  [generatedFile]: generated,
  "specification/foo/tspconfig.yaml": "{}",
};

async function checkChanges(
  initial: Record<string, string>,
  changes: Record<string, string | null>,
) {
  const repoRoot = await mkdtemp(join(tmpdir(), "typespec-migration-"));
  const responseCache: Record<string, number> = {};
  async function writeFiles(files: Record<string, string | null>) {
    for (const [path, content] of Object.entries(files)) {
      const fullPath = join(repoRoot, path);
      if (content === null) {
        await rm(fullPath);
      } else {
        await mkdir(dirname(fullPath), { recursive: true });
        await writeFile(fullPath, content);
      }
      responseCache[
        `https://github.com/Azure/azure-rest-api-specs/tree/main/${path.slice(0, path.lastIndexOf("/"))}`
      ] = 200;
    }
  }
  async function commit() {
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
        "--allow-empty",
        "-m",
        "Fixture",
      ],
      { cwd: repoRoot },
    );
  }
  try {
    await execa("git", ["init", "--quiet"], { cwd: repoRoot });
    await writeFiles(initial);
    await commit();
    await writeFiles(changes);
    await commit();
    return await checkFiles(
      { baseCommitish: "HEAD^", headCommitish: "HEAD", responseCache },
      repoRoot,
    );
  } finally {
    await rm(repoRoot, { recursive: true, force: true });
  }
}

describe("New Swagger in migrated services", () => {
  beforeEach(() => {
    vi.stubEnv("GITHUB_OUTPUT", "");
    vi.spyOn(console, "log").mockImplementation(() => {});
    vi.spyOn(console, "error").mockImplementation(() => {});
  });
  afterEach(() => {
    vi.restoreAllMocks();
    vi.unstubAllEnvs();
  });

  it.each(["2025-01-01", "2026-01-01", "2027-01-01"])(
    "Allows patches to existing handwritten files at %s with or without suppression",
    async (version) => {
      const file = `${service}/stable/${version}/handwritten.json`;
      const initial = { ...migratedFiles, [file]: "{}" };
      expect(await checkChanges(initial, { [file]: '{"description":"patch"}' })).toEqual({
        brownfield: true,
        exitCode: 0,
      });
      expect(
        await checkChanges(
          {
            ...initial,
            [`${service}/suppressions.yaml`]: `- tool: TypeSpecRequirement\n  path: ./stable/${version}/*.json\n  reason: Patch\n`,
          },
          { [file]: '{"description":"patch"}' },
        ),
      ).toEqual({
        brownfield: false,
        exitCode: 0,
      });
    },
  );

  it.each(["2025-01-01", "2026-01-01", "2027-01-01"])(
    "Rejects a new handwritten file at %s even in an existing version with a suppression",
    async (version) => {
      const result = await checkChanges(
        {
          ...migratedFiles,
          [`${service}/stable/${version}/existing.json`]: "{}",
          [`${service}/suppressions.yaml`]: `- tool: TypeSpecRequirement\n  path: ./stable/${version}/*.json\n  reason: Legacy exemption\n`,
        },
        { [`${service}/stable/${version}/new.json`]: "{}" },
      );
      expect(result.exitCode).toBe(1);
      expect(console.error).toHaveBeenCalledWith(
        expect.stringContaining("suppressions cannot bypass"),
      );
    },
  );

  it.each([null, "{}"])(
    "Still rejects additions when generated Swagger is deleted or rewritten: %s",
    async (replacement) => {
      const result = await checkChanges(migratedFiles, {
        [generatedFile]: replacement,
        [`${service}/stable/2025-01-01/new.json`]: "{}",
      });
      expect(result.exitCode).toBe(1);
      expect(console.error).toHaveBeenCalledWith(expect.stringContaining("HEAD^:"));
    },
  );

  it("Does not exempt a new path classified by Git as a rename", async () => {
    const oldFile = `${service}/stable/2025-01-01/old.json`;
    const result = await checkChanges(
      { ...migratedFiles, [oldFile]: "{}" },
      {
        [oldFile]: null,
        [`${service}/stable/2025-01-01/renamed.json`]: "{}",
      },
    );
    expect(result.exitCode).toBe(1);
    expect(console.error).toHaveBeenCalledWith(expect.stringContaining("renamed.json"));
  });

  it("Allows patches to generated Swagger", async () => {
    const result = await checkChanges(migratedFiles, {
      [generatedFile]: generated.replace('"info":', '"description":"patch","info":'),
    });
    expect(result.exitCode).toBe(0);
  });

  it("Allows newly added generated Swagger", async () => {
    const result = await checkChanges(migratedFiles, {
      [`${service}/stable/2025-01-01/new.json`]: generated,
    });
    expect(result.exitCode).toBe(0);
  });

  it("Does not check deleted Swagger files", async () => {
    const result = await checkChanges(migratedFiles, { [generatedFile]: null });
    expect(result.exitCode).toBe(0);
  });

  it("Detects migration introduced in the same PR", async () => {
    const result = await checkChanges(
      {},
      {
        ...migratedFiles,
        [`${service}/stable/2025-01-01/new.json`]: "{}",
      },
    );
    expect(result.exitCode).toBe(1);
    expect(console.error).toHaveBeenCalledWith(
      expect.stringContaining("suppressions cannot bypass"),
    );
  });

  it("Preserves existing-version behavior for a service without TypeSpec", async () => {
    const result = await checkChanges(
      {
        [`${service}/stable/2026-01-01/existing.json`]: "{}",
      },
      {
        [`${service}/stable/2026-01-01/new.json`]: "{}",
      },
    );
    expect(result).toEqual({ brownfield: true, exitCode: 0 });
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
