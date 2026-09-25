import { mkdir, mkdtemp, readFile, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import {
  exportArmApiReviewer,
  GENERATED_MANIFEST_NAME,
  type ArmApiReviewerExportDefinition,
} from "../src/arm-api-reviewer-export.ts";

const SOURCE_COMMIT = "a".repeat(40);
const REAL_REPO_ROOT = resolve(import.meta.dirname, "../../..");

function createDefinition(): ArmApiReviewerExportDefinition {
  return {
    schemaVersion: 1,
    packageName: "test-reviewer",
    compatibilityVersion: 1,
    sourceRepository: "example/repository",
    entrypoints: {
      reviewer: "runtime/reviewer.md",
      critic: "runtime/critic.md",
      skill: "runtime/SKILL.md",
    },
    files: ["runtime/reviewer.md", "runtime/critic.md", "runtime/SKILL.md"],
    directories: [],
    runtimeReferenceRoots: ["runtime"],
    validation: {
      vallyVersion: "0.14.0",
      releaseSmokeSuite: "release-smoke",
      reviewerModel: "gpt-5.6-sol?effort=high",
      judgeModel: "gpt-5.4",
    },
  };
}

describe("ARM API Reviewer export", () => {
  let workspace: string;
  let repoRoot: string;
  let definitionPath: string;

  async function writeRepositoryFile(path: string, content: string | Buffer): Promise<void> {
    const absolutePath = join(repoRoot, ...path.split("/"));
    await mkdir(dirname(absolutePath), { recursive: true });
    await writeFile(absolutePath, content);
  }

  async function writeDefinition(
    definition: ArmApiReviewerExportDefinition = createDefinition(),
  ): Promise<void> {
    await writeRepositoryFile(
      ".github/agents/arm-api-reviewer.export.json",
      `${JSON.stringify(definition, null, 2)}\n`,
    );
  }

  async function writeBaseRepository(): Promise<void> {
    await writeRepositoryFile("runtime/reviewer.md", "[Critic](./critic.md)\n");
    await writeRepositoryFile("runtime/critic.md", "[Skill](./SKILL.md)\n");
    await writeRepositoryFile("runtime/SKILL.md", "# Test skill\n");
    await writeDefinition();
  }

  async function runExport(outputDir?: string) {
    return exportArmApiReviewer({
      repoRoot,
      sourceCommit: SOURCE_COMMIT,
      outputDir,
      definitionPath,
    });
  }

  beforeEach(async () => {
    workspace = await mkdtemp(join(tmpdir(), "arm-api-reviewer-export-"));
    repoRoot = join(workspace, "source");
    definitionPath = join(repoRoot, ".github", "agents", "arm-api-reviewer.export.json");
    await mkdir(repoRoot, { recursive: true });
    await writeBaseRepository();
  });

  afterEach(async () => {
    await rm(workspace, { recursive: true, force: true, maxRetries: 5, retryDelay: 100 });
  });

  it("exports the real reviewer package and matches the pinned Vally version", async () => {
    const manifest = await exportArmApiReviewer({
      repoRoot: REAL_REPO_ROOT,
      sourceCommit: SOURCE_COMMIT,
    });
    const evalPackage = JSON.parse(
      await readFile(join(REAL_REPO_ROOT, "eng/common/scripts/eval/package.json"), "utf8"),
    ) as { devDependencies: Record<string, string> };

    expect(manifest.packageName).toBe("arm-api-reviewer");
    expect(manifest.files).toHaveLength(45);
    expect(manifest.files.map((file) => file.path)).toEqual(
      [...manifest.files.map((file) => file.path)].sort((left, right) =>
        left.localeCompare(right, "en"),
      ),
    );
    expect(manifest.files).toEqual(
      expect.arrayContaining([
        expect.objectContaining({ path: manifest.entrypoints.reviewer }),
        expect.objectContaining({ path: manifest.entrypoints.critic }),
        expect.objectContaining({ path: manifest.entrypoints.skill }),
      ]),
    );
    expect(manifest.contentDigest).toMatch(/^[0-9a-f]{64}$/);
    expect(manifest.files.every((file) => /^[0-9a-f]{64}$/.test(file.sha256))).toBe(true);
    expect(manifest.validation.vallyVersion).toBe(
      evalPackage.devDependencies["@microsoft/vally-cli"],
    );
    expect(manifest.validation.reviewerModel).toBe("gpt-5.6-sol?effort=high");
    expect(manifest.validation.judgeModel).toBe("gpt-5.4");
  });

  it("writes a deterministic package and generated manifest", async () => {
    const firstOutput = join(workspace, "first");
    const secondOutput = join(workspace, "second");

    const first = await runExport(firstOutput);
    const second = await runExport(secondOutput);

    expect(second).toEqual(first);
    expect(await readFile(join(firstOutput, GENERATED_MANIFEST_NAME), "utf8")).toBe(
      await readFile(join(secondOutput, GENERATED_MANIFEST_NAME), "utf8"),
    );
    expect(await readFile(join(firstOutput, "runtime/reviewer.md"), "utf8")).toBe(
      "[Critic](./critic.md)\n",
    );
  });

  it("changes the content digest when an exported file changes", async () => {
    const before = await runExport();
    await writeRepositoryFile("runtime/critic.md", "# Changed critic\n");

    const after = await runExport();

    expect(after.contentDigest).not.toBe(before.contentDigest);
  });

  it("changes the content digest when validation metadata changes", async () => {
    const before = await runExport();
    const definition = createDefinition();
    definition.validation.judgeModel = "gpt-5.5";
    await writeDefinition(definition);

    const after = await runExport();

    expect(after.contentDigest).not.toBe(before.contentDigest);
  });

  it("rejects a missing runtime reference", async () => {
    await writeRepositoryFile("runtime/reviewer.md", "[Missing](./missing.md)\n");

    await expect(runExport()).rejects.toThrow(
      "runtime/reviewer.md -> runtime/missing.md (missing)",
    );
  });

  it("rejects duplicate export paths", async () => {
    const definition = createDefinition();
    definition.directories = ["runtime"];
    await writeDefinition(definition);

    await expect(runExport()).rejects.toThrow("Duplicate export path: runtime/critic.md");
  });

  it("rejects parent traversal in the export definition", async () => {
    const definition = createDefinition();
    definition.files[0] = "../outside.md";
    await writeDefinition(definition);

    await expect(runExport()).rejects.toThrow(
      "files[0] contains an empty, current-directory, or parent segment",
    );
  });

  it("rejects symbolic links in an exported directory", async () => {
    const externalDirectory = join(workspace, "external");
    const linkedDirectory = join(repoRoot, "runtime", "linked");
    await mkdir(externalDirectory, { recursive: true });
    await writeFile(join(externalDirectory, "file.md"), "# External\n");
    await symlink(
      externalDirectory,
      linkedDirectory,
      process.platform === "win32" ? "junction" : "dir",
    );
    const definition = createDefinition();
    definition.directories = ["runtime/linked"];
    await writeDefinition(definition);

    await expect(runExport()).rejects.toThrow("Symbolic links are not allowed in the export");
  });

  it("refuses to write into a non-empty output directory", async () => {
    const outputDir = join(workspace, "output");
    await mkdir(outputDir);
    await writeFile(join(outputDir, "unrelated.txt"), "keep");

    await expect(runExport(outputDir)).rejects.toThrow(
      `The export output directory must be empty: ${outputDir}`,
    );
    expect(await readFile(join(outputDir, "unrelated.txt"), "utf8")).toBe("keep");
  });
});
