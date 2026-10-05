import { execa } from "execa";
import { mkdir, mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
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
    const outputFile = join(repoRoot, "github-output");
    await writeFile(outputFile, "");
    vi.stubEnv("GITHUB_OUTPUT", outputFile);
    const result = await checkFiles(
      { baseCommitish: "HEAD^", headCommitish: "HEAD", responseCache },
      repoRoot,
    );
    return { ...result, githubOutput: await readFile(outputFile, "utf8") };
  } finally {
    await rm(repoRoot, { recursive: true, force: true });
  }
}

describe("New Swagger in migrated services", () => {
  beforeEach(() => {
    vi.spyOn(console, "log").mockImplementation(() => {});
    vi.spyOn(console, "error").mockImplementation(() => {});
    vi.spyOn(globalThis, "fetch").mockRejectedValue(new Error("Unexpected network request"));
  });
  afterEach(() => {
    vi.restoreAllMocks();
    vi.unstubAllEnvs();
  });

  it.each([false, true])(
    "Allows patches to existing handwritten files (suppressed=%s)",
    async (suppressed) => {
      const version = "2025-01-01";
      const file = `${service}/stable/${version}/handwritten.json`;
      const result = await checkChanges(
        {
          ...migratedFiles,
          [file]: "{}",
          ...(suppressed
            ? {
                [`${service}/suppressions.yaml`]: `- tool: TypeSpecRequirement\n  path: ./stable/${version}/*.json\n  reason: Patch\n`,
              }
            : {}),
        },
        { [file]: '{"description":"patch"}' },
      );
      expect(result).toEqual({
        brownfield: !suppressed,
        exitCode: 0,
        githubOutput: suppressed ? "" : "brownfield=true\n",
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
      expect(result).toEqual({ brownfield: false, exitCode: 1, githubOutput: "" });
      expect(console.error).toHaveBeenCalledWith(
        expect.stringContaining("suppressions cannot bypass"),
      );
      expect(console.log).not.toHaveBeenCalledWith(expect.stringContaining("Checking github.com"));
      expect(fetch).not.toHaveBeenCalled();
    },
  );

  it.each([
    { first: "preview/2026-01-01-preview", target: "stable/2025-01-01", suppressed: true },
    { first: "stable/2026-01-01", target: "preview/2027-01-01-preview", suppressed: false },
  ])(
    "Rejects handwritten $target when $first uses TypeSpec (suppressed=$suppressed)",
    async ({ first, target, suppressed }) => {
      const result = await checkChanges(
        {
          [`${service}/${first}/generated.json`]: generated,
          ...(suppressed
            ? {
                [`${service}/suppressions.yaml`]: `- tool: TypeSpecRequirement\n  path: ./${target}/*.json\n  reason: Historical version\n`,
              }
            : {}),
        },
        { [`${service}/${target}/new.json`]: "{}" },
      );
      expect(result.exitCode).toBe(1);
      expect(console.error).toHaveBeenCalledWith(
        expect.stringContaining("suppressions cannot bypass"),
      );
      expect(console.log).not.toHaveBeenCalledWith(expect.stringContaining("Checking github.com"));
      expect(fetch).not.toHaveBeenCalled();
    },
  );

  it("Preserves brownfield output when another added file is rejected", async () => {
    const existingFile = `${service}/stable/2025-01-01/z-existing.json`;
    const newFile = `${service}/stable/2025-01-01/a-new.json`;
    const result = await checkChanges(
      { ...migratedFiles, [existingFile]: "{}" },
      { [existingFile]: '{"description":"patch"}', [newFile]: "{}" },
    );
    expect(result).toEqual({ brownfield: true, exitCode: 1, githubOutput: "brownfield=true\n" });
    expect(console.error).toHaveBeenCalledWith(expect.stringContaining(newFile));
  });

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
    expect(result).toEqual({ brownfield: true, exitCode: 0, githubOutput: "brownfield=true\n" });
  });

  it.each([
    "specification/foo/resource-manager/Microsoft.Foo/OtherService",
    "specification/foo/data-plane/Microsoft.Foo/Service",
    "specification/foo/resource-manager/Microsoft.Other/Service",
  ])("Does not share migration state with %s", async (otherService) => {
    const result = await checkChanges(
      { [`${otherService}/stable/2026-01-01/generated.json`]: generated },
      { [`${service}/stable/2026-01-01/new.json`]: "{}" },
    );
    expect(result).toEqual({ brownfield: true, exitCode: 0, githubOutput: "brownfield=true\n" });
  });

  it("Does not infer migration from examples, common types, or tspconfig alone", async () => {
    const result = await checkChanges(
      {
        [`${service}/tspconfig.yaml`]: "{}",
        [`${service}/stable/2026-01-01/examples/generated.json`]: generated,
        [`${service}/stable/2026-01-01/common/generated.json`]: generated,
      },
      { [`${service}/stable/2026-01-01/new.json`]: "{}" },
    );
    expect(result).toEqual({ brownfield: true, exitCode: 0, githubOutput: "brownfield=true\n" });
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
