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

async function checkChanges(initial: Record<string, string>, changes: Record<string, string>) {
  const repoRoot = await mkdtemp(join(tmpdir(), "typespec-migration-"));
  const responseCache: Record<string, number> = {};
  async function writeFiles(files: Record<string, string>, responseStatus: number) {
    for (const [path, content] of Object.entries(files)) {
      const fullPath = join(repoRoot, path);
      await mkdir(dirname(fullPath), { recursive: true });
      await writeFile(fullPath, content);
      responseCache[
        `https://github.com/Azure/azure-rest-api-specs/tree/main/${path.slice(0, path.lastIndexOf("/"))}`
      ] ??= responseStatus;
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
    await writeFiles(initial, 200);
    await commit();
    await writeFiles(changes, 404);
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

describe("New API versions in migrated services", () => {
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

  it.each([false, true])(
    "Allows new handwritten files in an existing API version (suppressed=%s)",
    async (suppressed) => {
      const version = "2025-01-01";
      const result = await checkChanges(
        {
          ...migratedFiles,
          [`${service}/stable/${version}/existing.json`]: "{}",
          ...(suppressed
            ? {
                [`${service}/suppressions.yaml`]: `- tool: TypeSpecRequirement\n  path: ./stable/${version}/*.json\n  reason: Legacy exemption\n`,
              }
            : {}),
        },
        { [`${service}/stable/${version}/new.json`]: "{}" },
      );
      expect(result).toEqual({
        brownfield: !suppressed,
        exitCode: 0,
        githubOutput: suppressed ? "" : "brownfield=true\n",
      });
    },
  );

  it.each([
    { first: "stable/2026-01-01", target: "stable/2025-01-01" },
    { first: "preview/2026-01-01-preview", target: "stable/2027-01-01" },
    { first: "stable/2026-01-01", target: "preview/2027-01-01-preview" },
  ])(
    "Rejects suppressed new API version $target when $first uses TypeSpec",
    async ({ first, target }) => {
      const result = await checkChanges(
        {
          [`${service}/${first}/generated.json`]: generated,
          [`${service}/suppressions.yaml`]: `- tool: TypeSpecRequirement\n  path: ./${target}/*.json\n  reason: Legacy exemption\n`,
        },
        { [`${service}/${target}/new.json`]: "{}" },
      );
      expect(result).toEqual({ brownfield: false, exitCode: 1, githubOutput: "" });
      expect(console.error).toHaveBeenCalledWith(
        expect.stringContaining("API version appears to be new"),
      );
      expect(console.log).not.toHaveBeenCalledWith(expect.stringContaining("Suppressed:"));
    },
  );

  it("Preserves brownfield output when a new API version's suppression is rejected", async () => {
    const existingFile = `${service}/stable/2025-01-01/existing.json`;
    const newFile = `${service}/preview/2027-01-01-preview/new.json`;
    const result = await checkChanges(
      {
        ...migratedFiles,
        [existingFile]: "{}",
        [`${service}/suppressions.yaml`]:
          "- tool: TypeSpecRequirement\n  path: ./preview/2027-01-01-preview/*.json\n  reason: Legacy exemption\n",
      },
      { [existingFile]: '{"description":"patch"}', [newFile]: "{}" },
    );
    expect(result).toEqual({ brownfield: true, exitCode: 1, githubOutput: "brownfield=true\n" });
    expect(console.error).toHaveBeenCalledWith(expect.stringContaining(newFile));
  });

  it.each([false, true])(
    "Allows new API versions generated from TypeSpec (suppressed=%s)",
    async (suppressed) => {
      const result = await checkChanges(
        {
          ...migratedFiles,
          ...(suppressed
            ? {
                [`${service}/suppressions.yaml`]:
                  "- tool: TypeSpecRequirement\n  path: ./stable/2027-01-01/*.json\n  reason: Legacy exemption\n",
              }
            : {}),
        },
        { [`${service}/stable/2027-01-01/new.json`]: generated },
      );
      expect(result).toEqual({ brownfield: false, exitCode: 0, githubOutput: "" });
    },
  );

  it("Detects migration introduced in the same PR", async () => {
    const result = await checkChanges(
      {},
      {
        ...migratedFiles,
        [`${service}/stable/2025-01-01/new.json`]: "{}",
        [`${service}/suppressions.yaml`]:
          "- tool: TypeSpecRequirement\n  path: ./stable/2025-01-01/*.json\n  reason: Legacy exemption\n",
      },
    );
    expect(result.exitCode).toBe(1);
    expect(console.error).toHaveBeenCalledWith(
      expect.stringContaining("API version appears to be new"),
    );
  });

  it("Allows suppressions for new handwritten API versions in a service without TypeSpec", async () => {
    const result = await checkChanges(
      {
        [`${service}/suppressions.yaml`]:
          "- tool: TypeSpecRequirement\n  path: ./stable/2027-01-01/*.json\n  reason: Legacy exemption\n",
      },
      {
        [`${service}/stable/2027-01-01/new.json`]: "{}",
      },
    );
    expect(result).toEqual({ brownfield: false, exitCode: 0, githubOutput: "" });
    expect(console.log).not.toHaveBeenCalledWith(expect.stringContaining("Checking github.com"));
    expect(fetch).not.toHaveBeenCalled();
  });

  it.each([
    "specification/foo/resource-manager/Microsoft.Foo/OtherService",
    "specification/foo/data-plane/Microsoft.Foo/Service",
    "specification/foo/resource-manager/Microsoft.Other/Service",
  ])("Does not share migration state with %s", async (otherService) => {
    const result = await checkChanges(
      {
        [`${otherService}/stable/2026-01-01/generated.json`]: generated,
        [`${service}/suppressions.yaml`]:
          "- tool: TypeSpecRequirement\n  path: ./stable/2027-01-01/*.json\n  reason: Legacy exemption\n",
      },
      { [`${service}/stable/2027-01-01/new.json`]: "{}" },
    );
    expect(result).toEqual({ brownfield: false, exitCode: 0, githubOutput: "" });
  });

  it("Does not infer migration from examples, common types, or tspconfig alone", async () => {
    const result = await checkChanges(
      {
        [`${service}/tspconfig.yaml`]: "{}",
        [`${service}/stable/2026-01-01/examples/generated.json`]: generated,
        [`${service}/stable/2026-01-01/common/generated.json`]: generated,
        [`${service}/suppressions.yaml`]:
          "- tool: TypeSpecRequirement\n  path: ./stable/2027-01-01/*.json\n  reason: Legacy exemption\n",
      },
      { [`${service}/stable/2027-01-01/new.json`]: "{}" },
    );
    expect(result).toEqual({ brownfield: false, exitCode: 0, githubOutput: "" });
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
