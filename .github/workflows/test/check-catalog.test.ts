import { spawnSync } from "node:child_process";
import { cpSync, mkdirSync, mkdtempSync, rmSync, symlinkSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { checkCatalogUsage } from "../src/check-catalog.ts";

describe("checkCatalogUsage", () => {
  let repoRoot: string;

  function writeManifest(path: string, manifest: object) {
    const fullPath = join(repoRoot, path, "package.json");
    mkdirSync(dirname(fullPath), { recursive: true });
    writeFileSync(fullPath, JSON.stringify(manifest));
  }

  function runCli() {
    for (const path of ["src/check-catalog.ts", "cmd/check-catalog.ts"]) {
      const destination = join(repoRoot, ".github/workflows", path);
      mkdirSync(dirname(destination), { recursive: true });
      cpSync(join(import.meta.dirname, "..", path), destination);
    }
    return spawnSync(process.execPath, [join(repoRoot, ".github/workflows/cmd/check-catalog.ts")], {
      cwd: tmpdir(),
      encoding: "utf8",
    });
  }

  beforeEach(() => {
    repoRoot = mkdtempSync(join(tmpdir(), "check-catalog-"));
    writeFileSync(
      join(repoRoot, "pnpm-workspace.yaml"),
      'packages:\n  - ".github"\n  - "packages/*"\n  - "!packages/excluded"\n',
    );
    writeManifest(".", { name: "root", private: true });
  });

  afterEach(() => {
    rmSync(repoRoot, { recursive: true, force: true });
  });

  it("accepts catalogs and workspace references in every dependency section", () => {
    writeManifest("packages/valid", {
      name: "valid",
      dependencies: { external: "catalog:", local: "workspace:*" },
      devDependencies: { external: "catalog:default", local: "workspace:^" },
      peerDependencies: { external: "catalog:legacy", local: "workspace:~" },
      optionalDependencies: { external: "catalog:", local: "workspace:../local" },
    });
    writeManifest("packages/empty", { name: "empty" });

    expect(checkCatalogUsage(repoRoot)).toEqual([]);
  });

  it("reports all violations across root, hidden and regular workspace packages", () => {
    writeManifest(".", {
      name: "root",
      dependencies: { rootDependency: "^1.0.0" },
    });
    writeManifest(".github", {
      name: "github",
      devDependencies: { devDependency: "latest" },
    });
    writeManifest("packages/invalid", {
      name: "invalid",
      peerDependencies: { peerDependency: "*" },
      optionalDependencies: { optionalDependency: "1.2.3" },
    });

    expect(checkCatalogUsage(repoRoot).sort()).toEqual([
      '.github/package.json: devDependencies.devDependency uses "latest" instead of "catalog:".',
      'package.json: dependencies.rootDependency uses "^1.0.0" instead of "catalog:".',
      'packages/invalid/package.json: optionalDependencies.optionalDependency uses "1.2.3" instead of "catalog:".',
      'packages/invalid/package.json: peerDependencies.peerDependency uses "*" instead of "catalog:".',
    ]);
  });

  it("rejects non-catalog protocols and malformed protocol prefixes", () => {
    writeManifest("packages/invalid", {
      name: "invalid",
      dependencies: {
        file: "file:../local",
        link: "link:../local",
        git: "github:example/package",
        alias: "npm:other@1.0.0",
        catalog: "catalog",
        workspace: "workspace",
      },
    });

    expect(checkCatalogUsage(repoRoot)).toEqual([
      'packages/invalid/package.json: dependencies.file uses "file:../local" instead of "catalog:".',
      'packages/invalid/package.json: dependencies.link uses "link:../local" instead of "catalog:".',
      'packages/invalid/package.json: dependencies.git uses "github:example/package" instead of "catalog:".',
      'packages/invalid/package.json: dependencies.alias uses "npm:other@1.0.0" instead of "catalog:".',
      'packages/invalid/package.json: dependencies.catalog uses "catalog" instead of "catalog:".',
      'packages/invalid/package.json: dependencies.workspace uses "workspace" instead of "catalog:".',
    ]);
  });

  it("ignores manifests outside the workspace and excluded fixtures", () => {
    for (const path of [
      "specification/example",
      "packages/excluded",
      "packages/valid/test/fixture",
    ]) {
      writeManifest(path, { name: path, dependencies: { external: "1.0.0" } });
    }
    writeManifest("packages/valid", { name: "valid" });

    expect(checkCatalogUsage(repoRoot)).toEqual([]);
  });

  it("does not silently skip an invalid manifest", () => {
    writeManifest("packages/invalid", { name: "invalid" });
    writeFileSync(join(repoRoot, "packages/invalid/package.json"), "{");

    expect(() => checkCatalogUsage(repoRoot)).toThrow();
  });

  it("normalizes symlinked root paths without duplicating root diagnostics", () => {
    writeManifest(".", { name: "root", dependencies: { external: "1.0.0" } });
    const link = join(repoRoot, "linked-root");
    symlinkSync(repoRoot, link, "junction");

    expect(checkCatalogUsage(link)).toEqual([
      'package.json: dependencies.external uses "1.0.0" instead of "catalog:".',
    ]);
  });

  it("runs the CLI without installed dependencies and independently of the working directory", () => {
    const result = runCli();

    expect(result.status, result.stderr).toBe(0);
    expect(result.stdout).toContain("All workspace dependencies use catalog: or workspace:");
  });

  it("fails the CLI with actionable diagnostics when dependencies do not use catalogs", () => {
    writeManifest(".", { name: "root", dependencies: { external: "1.0.0" } });

    const result = runCli();

    expect(result.status).toBe(1);
    expect(result.stderr).toContain(
      'package.json: dependencies.external uses "1.0.0" instead of "catalog:".',
    );
    expect(result.stderr).toContain("Add their versions to pnpm-workspace.yaml");
    expect(result.stdout).not.toContain("All workspace dependencies use");
  });

  it("fails the CLI explicitly if workspace discovery fails", () => {
    writeFileSync(join(repoRoot, "pnpm-workspace.yaml"), "packages: [");

    const result = runCli();

    expect(result.status).toBe(1);
    expect(result.stderr).toContain("Failed to validate workspace catalog usage:");
    expect(result.stdout).not.toContain("All workspace dependencies use");
  });
});
