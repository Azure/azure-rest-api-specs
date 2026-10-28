import { execFileSync } from "node:child_process";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import { afterEach, describe, expect, it } from "vitest";
import { analyzeTypeSpecSuppressions } from "../src/index.ts";

async function initTempRepo(): Promise<string> {
  const repoRoot = await mkdtemp(path.join(os.tmpdir(), "typespec-suppressions-"));
  execFileSync("git", ["init"], { cwd: repoRoot });
  execFileSync("git", ["config", "user.name", "Test"], { cwd: repoRoot });
  execFileSync("git", ["config", "user.email", "test@example.com"], { cwd: repoRoot });
  return repoRoot;
}

function git(repoRoot: string, args: string[]): string {
  return execFileSync("git", ["-c", "commit.gpgsign=false", ...args], {
    cwd: repoRoot,
    encoding: "utf8",
  }).trim();
}

/**
 * Creates a base + head commit with a known set of new/changed suppressions:
 * - new:       @azure-tools/rule-new-inline, @azure-tools/rule-new-config
 * - changed:   @azure-tools/rule-config (justification updated)
 * - unchanged: @azure-tools/rule-inline
 */
async function setupBaseAndHead(
  repoRoot: string,
): Promise<{ specPath: string; baseRevision: string; headRevision: string }> {
  const specPath = "specification/demo/resource-manager/Microsoft.Demo/Demo";
  const specFolder = path.join(repoRoot, specPath);
  await mkdir(specFolder, { recursive: true });

  await writeFile(
    path.join(specFolder, "tspconfig.yaml"),
    `linter:
  disable:
    "@azure-tools/rule-config": "base reason"
`,
  );
  await writeFile(
    path.join(specFolder, "main.tsp"),
    `namespace Demo;

model Widget {
  #suppress "@azure-tools/rule-inline" "base inline reason"
  name: string;
}
`,
  );

  git(repoRoot, ["add", "."]);
  git(repoRoot, ["commit", "-m", "base"]);
  const baseRevision = git(repoRoot, ["rev-parse", "HEAD"]);

  await writeFile(
    path.join(specFolder, "tspconfig.yaml"),
    `linter:
  disable:
    "@azure-tools/rule-config": "updated reason"
    "@azure-tools/rule-new-config": "new reason"
`,
  );
  await writeFile(
    path.join(specFolder, "main.tsp"),
    `namespace Demo;

model Widget {
  #suppress "@azure-tools/rule-inline" "base inline reason"
  name: string;
}

interface Widgets {
  #suppress "@azure-tools/rule-new-inline" "new inline reason"
  read(): Widget;
}
`,
  );

  git(repoRoot, ["add", "."]);
  git(repoRoot, ["commit", "-m", "head"]);
  const headRevision = git(repoRoot, ["rev-parse", "HEAD"]);

  return { specPath, baseRevision, headRevision };
}

describe("analyzeTypeSpecSuppressions", () => {
  const tempRepos: string[] = [];

  afterEach(async () => {
    await Promise.all(
      tempRepos.splice(0).map((repoRoot) => rm(repoRoot, { recursive: true, force: true })),
    );
  });

  it("classifies new and changed suppressions from git revisions", async () => {
    const repoRoot = await initTempRepo();
    tempRepos.push(repoRoot);

    const specPath = "specification/demo/resource-manager/Microsoft.Demo/Demo";
    const specFolder = path.join(repoRoot, specPath);
    await mkdir(specFolder, { recursive: true });

    await writeFile(
      path.join(specFolder, "tspconfig.yaml"),
      `linter:
  disable:
    "@azure-tools/rule-config": "base reason"
`,
    );
    await writeFile(
      path.join(specFolder, "main.tsp"),
      `namespace Demo;

model Widget {
  #suppress "@azure-tools/rule-inline" "base inline reason"
  name: string;
}
`,
    );

    git(repoRoot, ["add", "."]);
    git(repoRoot, ["commit", "-m", "base"]);
    const baseRevision = git(repoRoot, ["rev-parse", "HEAD"]);

    await writeFile(
      path.join(specFolder, "tspconfig.yaml"),
      `linter:
  disable:
    "@azure-tools/rule-config": "updated reason"
    "@azure-tools/rule-new-config": "new reason"
`,
    );
    await writeFile(
      path.join(specFolder, "main.tsp"),
      `namespace Demo;

model Widget {
  #suppress "@azure-tools/rule-inline" "base inline reason"
  name: string;
}

interface Widgets {
  #suppress "@azure-tools/rule-new-inline" "new inline reason"
  read(): Widget;
}
`,
    );

    git(repoRoot, ["add", "."]);
    git(repoRoot, ["commit", "-m", "head"]);
    const headRevision = git(repoRoot, ["rev-parse", "HEAD"]);

    const report = await analyzeTypeSpecSuppressions({
      cwd: repoRoot,
      baseRevision,
      headRevision,
      specPaths: [specPath],
    });

    expect(report.requiresApproval).toBe(true);
    expect(report.counts).toEqual({
      specs: 1,
      base: 2,
      head: 4,
      new: 2,
      removed: 0,
      changed: 1,
      unchanged: 1,
    });
    expect(report.newSuppressions.map((suppression) => suppression.ruleName)).toEqual([
      "@azure-tools/rule-new-inline",
      "@azure-tools/rule-new-config",
    ]);
    expect(report.changedSuppressions).toHaveLength(1);
    expect(report.changedSuppressions[0].before.justification).toBe("base reason");
    expect(report.changedSuppressions[0].after.justification).toBe("updated reason");
  });

  it("omits checkedSuppressions in legacy mode (no checkRules)", async () => {
    const repoRoot = await initTempRepo();
    tempRepos.push(repoRoot);
    const { specPath, baseRevision, headRevision } = await setupBaseAndHead(repoRoot);

    const report = await analyzeTypeSpecSuppressions({
      cwd: repoRoot,
      baseRevision,
      headRevision,
      specPaths: [specPath],
    });

    expect(report.checkRules).toBeUndefined();
    expect(report.checkedSuppressions).toBeUndefined();
    expect(report.requiresApproval).toBe(true);
  });

  it("scopes checkedSuppressions to the provided rules while keeping the full diff", async () => {
    const repoRoot = await initTempRepo();
    tempRepos.push(repoRoot);
    const { specPath, baseRevision, headRevision } = await setupBaseAndHead(repoRoot);

    const report = await analyzeTypeSpecSuppressions({
      cwd: repoRoot,
      baseRevision,
      headRevision,
      specPaths: [specPath],
      checkRules: ["@azure-tools/rule-new-config", "@azure-tools/rule-config"],
    });

    // Full diff is preserved at the top level.
    expect(report.requiresApproval).toBe(true);
    expect(report.newSuppressions).toHaveLength(2);
    expect(report.changedSuppressions).toHaveLength(1);

    // Checked block only contains the listed rules (exact full-name match).
    expect(report.checkRules).toEqual(["@azure-tools/rule-config", "@azure-tools/rule-new-config"]);
    expect(report.checkedSuppressions).toBeDefined();
    expect(report.checkedSuppressions?.requiresApproval).toBe(true);
    expect(report.checkedSuppressions?.counts).toEqual({ new: 1, removed: 0, changed: 1 });
    expect(report.checkedSuppressions?.newSuppressions.map((s) => s.ruleName)).toEqual([
      "@azure-tools/rule-new-config",
    ]);
    expect(report.checkedSuppressions?.changedSuppressions).toHaveLength(1);
    expect(report.checkedSuppressions?.changedSuppressions[0].after.ruleName).toBe(
      "@azure-tools/rule-config",
    );
  });

  it("emits an empty checkedSuppressions block (no approval) for an empty rule list", async () => {
    const repoRoot = await initTempRepo();
    tempRepos.push(repoRoot);
    const { specPath, baseRevision, headRevision } = await setupBaseAndHead(repoRoot);

    const report = await analyzeTypeSpecSuppressions({
      cwd: repoRoot,
      baseRevision,
      headRevision,
      specPaths: [specPath],
      checkRules: [],
    });

    // Checked-only mode is active even with zero rules, but nothing is gated.
    expect(report.checkRules).toEqual([]);
    expect(report.checkedSuppressions).toBeDefined();
    expect(report.checkedSuppressions?.requiresApproval).toBe(false);
    expect(report.checkedSuppressions?.newSuppressions).toHaveLength(0);
    expect(report.checkedSuppressions?.changedSuppressions).toHaveLength(0);
    expect(report.checkedSuppressions?.counts).toEqual({ new: 0, removed: 0, changed: 0 });
  });

  it("enriches known TypeSpec Azure rules with documentation metadata", async () => {
    const repoRoot = await initTempRepo();
    tempRepos.push(repoRoot);

    const specPath = "specification/demo/resource-manager/Microsoft.Demo/Demo";
    const specFolder = path.join(repoRoot, specPath);
    await mkdir(specFolder, { recursive: true });

    await writeFile(
      path.join(specFolder, "tspconfig.yaml"),
      `linter:
  disable:
    "@azure-tools/typespec-azure-core/no-rpc-path-params": "approved for demo"
`,
    );
    await writeFile(path.join(specFolder, "main.tsp"), "namespace Demo;\n");

    git(repoRoot, ["add", "."]);
    git(repoRoot, ["commit", "-m", "base"]);
    const baseRevision = git(repoRoot, ["rev-parse", "HEAD"]);

    await writeFile(
      path.join(specFolder, "main.tsp"),
      `namespace Demo;

interface Widgets {
  #suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "approved for demo"
  read(): void;
}
`,
    );

    git(repoRoot, ["add", "."]);
    git(repoRoot, ["commit", "-m", "head"]);
    const headRevision = git(repoRoot, ["rev-parse", "HEAD"]);

    const report = await analyzeTypeSpecSuppressions({
      cwd: repoRoot,
      baseRevision,
      headRevision,
      specPaths: [specPath],
    });

    expect(report.newSuppressions[0].ruleMetadata).toMatchObject({
      packageName: "@azure-tools/typespec-azure-core",
      localRuleName: "rpc-operation-request-body",
      documentationUrl:
        "https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/rpc-operation-request-body",
    });
  });
});
