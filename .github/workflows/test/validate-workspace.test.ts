import { dump } from "js-yaml";
import { spawnSync } from "node:child_process";
import { cpSync, mkdirSync, mkdtempSync, rmSync, symlinkSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { checkCatalogUsage, checkLockfile } from "../src/validate-workspace.ts";

describe("workspace validation", () => {
  let repoRoot: string;

  function writeManifest(path: string, manifest: object) {
    const fullPath = join(repoRoot, path, "package.json");
    mkdirSync(dirname(fullPath), { recursive: true });
    writeFileSync(fullPath, JSON.stringify(manifest));
  }

  function runCli() {
    const destination = join(repoRoot, ".github/workflows/src/validate-workspace.ts");
    mkdirSync(dirname(destination), { recursive: true });
    cpSync(join(import.meta.dirname, "../src/validate-workspace.ts"), destination);
    symlinkSync(
      resolve(import.meta.dirname, "../../node_modules"),
      join(repoRoot, ".github/node_modules"),
      "junction",
    );
    return spawnSync(process.execPath, [destination], {
      cwd: tmpdir(),
      encoding: "utf8",
    });
  }

  function writeWorkspace(config: object = {}) {
    writeFileSync(
      join(repoRoot, "pnpm-workspace.yaml"),
      dump({ packages: [".github", "packages/*", "!packages/excluded"], ...config }),
    );
  }

  function writeLockfile(packages: object = {}) {
    writeFileSync(join(repoRoot, "pnpm-lock.yaml"), dump({ lockfileVersion: "9.0", packages }));
  }

  beforeEach(() => {
    repoRoot = mkdtempSync(join(tmpdir(), "validate-workspace-"));
    writeWorkspace();
    writeLockfile();
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

    expect(checkCatalogUsage(repoRoot)).toEqual({ errors: [], warnings: [] });
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

    expect(checkCatalogUsage(repoRoot).errors.sort()).toEqual([
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

    expect(checkCatalogUsage(repoRoot).errors).toEqual([
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

    expect(checkCatalogUsage(repoRoot)).toEqual({ errors: [], warnings: [] });
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

    expect(checkCatalogUsage(link).errors).toEqual([
      'package.json: dependencies.external uses "1.0.0" instead of "catalog:".',
    ]);
  });

  it("runs the CLI independently of the working directory", () => {
    const result = runCli();

    expect(result.status, result.stderr).toBe(0);
    expect(result.stdout).toContain("Workspace dependency and lockfile checks passed.");
  });

  it("fails the CLI with actionable diagnostics when dependencies do not use catalogs", () => {
    writeManifest(".", { name: "root", dependencies: { external: "1.0.0" } });

    const result = runCli();

    expect(result.status).toBe(1);
    expect(result.stderr).toContain(
      'package.json: dependencies.external uses "1.0.0" instead of "catalog:".',
    );
    expect(result.stderr).toContain("Add their versions to pnpm-workspace.yaml");
    expect(result.stdout).not.toContain("checks passed");
  });

  it("fails the CLI explicitly if workspace discovery fails", () => {
    writeFileSync(join(repoRoot, "pnpm-workspace.yaml"), "packages: [");

    const result = runCli();

    expect(result.status).toBe(1);
    expect(result.stderr).toContain("Failed to validate workspace:");
    expect(result.stdout).not.toContain("checks passed");
  });

  it("warns for unused entries in default and named catalogs", () => {
    writeWorkspace({
      catalog: { shared: "1.0.0", unused: "1.0.0" },
      catalogs: { legacy: { shared: "0.1.0" } },
    });
    writeManifest(".", { name: "root", dependencies: { shared: "catalog:" } });
    writeManifest("packages/excluded", { name: "excluded", dependencies: { unused: "catalog:" } });

    expect(checkCatalogUsage(repoRoot)).toEqual({
      errors: [],
      warnings: [
        'pnpm-workspace.yaml: catalog "legacy" entry "shared" is not used by any workspace package.',
        'pnpm-workspace.yaml: catalog "default" entry "unused" is not used by any workspace package.',
      ],
    });
  });

  it("tracks default aliases, named catalogs and all dependency sections", () => {
    writeWorkspace({
      catalog: { runtime: "1.0.0", dev: "1.0.0", peer: "1.0.0", optional: "1.0.0" },
      catalogs: { legacy: { runtime: "0.1.0" } },
    });
    writeManifest(".", {
      name: "root",
      dependencies: { runtime: "catalog:" },
      devDependencies: { dev: "catalog:default" },
      peerDependencies: { peer: "catalog:" },
      optionalDependencies: { optional: "catalog:" },
    });
    writeManifest("packages/legacy", {
      name: "legacy",
      dependencies: { runtime: "catalog:legacy" },
    });

    expect(checkCatalogUsage(repoRoot)).toEqual({ errors: [], warnings: [] });
  });

  it("supports a default catalog declared under catalogs", () => {
    writeWorkspace({ catalogs: { default: { external: "1.0.0", unused: "1.0.0" } } });
    writeManifest(".", { name: "root", dependencies: { external: "catalog:" } });

    expect(checkCatalogUsage(repoRoot)).toEqual({
      errors: [],
      warnings: [
        'pnpm-workspace.yaml: catalog "default" entry "unused" is not used by any workspace package.',
      ],
    });
  });

  it("does not count direct versions or workspace references as catalog usage", () => {
    writeWorkspace({ catalog: { direct: "1.0.0", local: "1.0.0" } });
    writeManifest(".", {
      name: "root",
      dependencies: { direct: "1.0.0", local: "workspace:*" },
    });

    expect(checkCatalogUsage(repoRoot)).toEqual({
      errors: ['package.json: dependencies.direct uses "1.0.0" instead of "catalog:".'],
      warnings: [
        'pnpm-workspace.yaml: catalog "default" entry "direct" is not used by any workspace package.',
        'pnpm-workspace.yaml: catalog "default" entry "local" is not used by any workspace package.',
      ],
    });
  });

  it("does not fail the CLI for unused catalog entries", () => {
    writeWorkspace({ catalog: { unused: "1.0.0" } });

    const result = runCli();

    expect(result.status, result.stderr).toBe(0);
    expect(result.stderr).toContain(
      'Warning: pnpm-workspace.yaml: catalog "default" entry "unused" is not used by any workspace package.',
    );
    expect(result.stdout).toContain("checks passed");
  });

  it("accepts integrity-only resolutions, Git-hosted tarballs and local dependencies", () => {
    writeLockfile({
      "registry@1.0.0": { resolution: { integrity: "sha512-example" } },
      git: {
        resolution: {
          gitHosted: true,
          integrity: "sha512-example",
          tarball: "https://codeload.github.com/actions/github-script/tar.gz/commit",
        },
      },
      "local@file:../local": { resolution: { directory: "../local", type: "directory" } },
    });

    expect(checkLockfile(repoRoot)).toEqual([]);
  });

  it("rejects all non-Git-hosted tarballs, including resolutions with integrity", () => {
    writeLockfile({
      "registry@1.0.0": {
        resolution: { integrity: "sha512-example", tarball: "https://proxy.example/registry.tgz" },
      },
      "other@1.0.0": {
        resolution: { gitHosted: false, tarball: "https://registry.example/other.tgz" },
      },
    });

    expect(checkLockfile(repoRoot)).toEqual([
      'pnpm-lock.yaml: "registry@1.0.0" has a non-Git-hosted tarball resolution: https://proxy.example/registry.tgz. Regenerate the lockfile against the configured registry.',
      'pnpm-lock.yaml: "other@1.0.0" has a non-Git-hosted tarball resolution: https://registry.example/other.tgz. Regenerate the lockfile against the configured registry.',
    ]);
  });

  it("parses multiline resolutions without mistaking comments for tarball entries", () => {
    writeFileSync(
      join(repoRoot, "pnpm-lock.yaml"),
      `lockfileVersion: '9.0'
# tarball: comments are not resolutions
packages:
  git:
    resolution:
      tarball: https://codeload.github.com/actions/github-script/tar.gz/commit
      gitHosted: true
  registry@1.0.0:
    resolution:
      integrity: sha512-example
      tarball: https://proxy.example/registry.tgz
`,
    );

    expect(checkLockfile(repoRoot)).toEqual([
      'pnpm-lock.yaml: "registry@1.0.0" has a non-Git-hosted tarball resolution: https://proxy.example/registry.tgz. Regenerate the lockfile against the configured registry.',
    ]);
  });

  it("reports both dependency and lockfile errors in the CLI", () => {
    writeManifest(".", { name: "root", dependencies: { external: "1.0.0" } });
    writeLockfile({
      "external@1.0.0": { resolution: { tarball: "https://proxy.example/external.tgz" } },
    });

    const result = runCli();

    expect(result.status).toBe(1);
    expect(result.stderr).toContain("package.json: dependencies.external");
    expect(result.stderr).toContain('pnpm-lock.yaml: "external@1.0.0"');
    expect(result.stdout).not.toContain("checks passed");
  });

  it("checks every document in a pnpm 11 lockfile", () => {
    const documents = ["tool@1.0.0", "workspace-dependency@1.0.0"].map((name) =>
      dump({
        lockfileVersion: "9.0",
        packages: { [name]: { resolution: { tarball: "https://proxy.example/package.tgz" } } },
      }),
    );
    writeFileSync(join(repoRoot, "pnpm-lock.yaml"), documents.join("---\n"));

    expect(checkLockfile(repoRoot)).toEqual([
      'pnpm-lock.yaml: "tool@1.0.0" has a non-Git-hosted tarball resolution: https://proxy.example/package.tgz. Regenerate the lockfile against the configured registry.',
      'pnpm-lock.yaml: "workspace-dependency@1.0.0" has a non-Git-hosted tarball resolution: https://proxy.example/package.tgz. Regenerate the lockfile against the configured registry.',
    ]);
  });

  it("fails the CLI explicitly for a missing or malformed lockfile", () => {
    writeFileSync(join(repoRoot, "pnpm-lock.yaml"), "packages: [");
    expect(() => checkLockfile(repoRoot)).toThrow();
    rmSync(join(repoRoot, "pnpm-lock.yaml"));

    const result = runCli();

    expect(result.status).toBe(1);
    expect(result.stderr).toContain("Failed to validate workspace:");
    expect(result.stderr).toContain("pnpm-lock.yaml");
    expect(result.stdout).not.toContain("checks passed");
  });
});
