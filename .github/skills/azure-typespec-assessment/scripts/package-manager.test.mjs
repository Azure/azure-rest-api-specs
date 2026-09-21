import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import {
  REQUIRED_TOOLCHAIN_PACKAGES,
  dependencyFingerprint,
  dependencyInstallCommand,
  dependencyProcessCommand,
  detectPackageManager,
  preflightToolchain,
} from "./package-manager.mjs";

function fixture() {
  return fs.mkdtempSync(path.join(os.tmpdir(), "assessment-package-manager-"));
}

function write(root, file, content) {
  const target = path.join(root, file);
  fs.mkdirSync(path.dirname(target), { recursive: true });
  fs.writeFileSync(target, content);
}

function packageManifest(packageManager) {
  return JSON.stringify({
    name: "fixture",
    private: true,
    ...(packageManager ? { packageManager } : {}),
  });
}

test("detects npm without changing the existing undeclared-manager contract", () => {
  const root = fixture();
  write(root, "package.json", packageManifest());
  write(root, "package-lock.json", JSON.stringify({ lockfileVersion: 3, packages: {} }));
  assert.deepEqual(
    detectPackageManager(root),
    {
      name: "npm",
      version: null,
      lockFile: "package-lock.json",
      lockPath: path.join(root, "package-lock.json"),
      packagePath: path.join(root, "package.json"),
    },
  );
});

test("detects an exact pnpm declaration and lockfile", () => {
  const root = fixture();
  write(root, "package.json", packageManifest("pnpm@11.8.0"));
  write(root, "pnpm-lock.yaml", "lockfileVersion: '9.0'\nimporters:\n  .: {}\n");
  assert.equal(detectPackageManager(root).name, "pnpm");
  assert.equal(detectPackageManager(root).version, "11.8.0");
});

test("rejects ambiguous and unsupported package-manager inputs", () => {
  const ambiguous = fixture();
  write(ambiguous, "package.json", packageManifest());
  write(ambiguous, "package-lock.json", "{}");
  write(ambiguous, "pnpm-lock.yaml", "lockfileVersion: '9.0'\n");
  assert.throws(() => detectPackageManager(ambiguous), /Multiple package-manager lockfiles/);

  const unsupported = fixture();
  write(unsupported, "package.json", packageManifest("yarn@4.0.0"));
  write(unsupported, "yarn.lock", "");
  assert.throws(() => detectPackageManager(unsupported), /Unsupported packageManager/);

  const undeclaredPnpm = fixture();
  write(undeclaredPnpm, "package.json", packageManifest());
  write(undeclaredPnpm, "pnpm-lock.yaml", "lockfileVersion: '9.0'\n");
  assert.throws(() => detectPackageManager(undeclaredPnpm), /exact packageManager declaration/);
});

test("dependency fingerprints include pnpm workspace configuration", () => {
  const root = fixture();
  write(root, "package.json", packageManifest("pnpm@11.8.0"));
  write(root, "pnpm-lock.yaml", "lockfileVersion: '9.0'\nimporters:\n  .: {}\n");
  write(root, "pnpm-workspace.yaml", "packages: []\n");
  const manager = detectPackageManager(root);
  const before = dependencyFingerprint(root, manager);
  write(root, "pnpm-workspace.yaml", "packages:\n  - tools/*\n");
  assert.notEqual(dependencyFingerprint(root, manager), before);
});

test("builds frozen installs with lifecycle scripts disabled", () => {
  const npm = dependencyInstallCommand({ name: "npm" });
  assert.deepEqual(npm.args, ["ci", "--ignore-scripts", "--no-audit", "--no-fund"]);

  const pnpm = dependencyInstallCommand(
    { name: "pnpm", version: "11.8.0" },
    { storeDir: "store" },
  );
  assert.deepEqual(pnpm.args, [
    "--yes",
    "pnpm@11.8.0",
    "install",
    "--frozen-lockfile",
    "--ignore-scripts",
    "--store-dir",
    "store",
  ]);
});

test("runs Windows npm shims through the npm JavaScript CLI without a shell", () => {
  const root = fixture();
  const npmBin = path.join(root, "node_modules", "npm", "bin");
  write(root, "npx.cmd", "@echo off\n");
  write(root, path.join("node_modules", "npm", "bin", "npx-cli.js"), "");
  const command = dependencyProcessCommand(
    { executable: "npx.cmd", args: ["--yes", "pnpm@11.8.0", "--version"] },
    { platform: "win32", env: { PATH: root }, execPath: "node.exe" },
  );
  assert.deepEqual(command, {
    executable: "node.exe",
    args: [path.join(npmBin, "npx-cli.js"), "--yes", "pnpm@11.8.0", "--version"],
  });
});

test("preflights required pnpm packages against the root importer", () => {
  const root = fixture();
  write(root, "package.json", packageManifest("pnpm@11.8.0"));
  const dependencies = Object.fromEntries(
    REQUIRED_TOOLCHAIN_PACKAGES.map((name, index) => [
      name,
      { specifier: "catalog:", version: `1.${index}.0(peer@1.0.0)` },
    ]),
  );
  write(
    root,
    "pnpm-lock.yaml",
    `lockfileVersion: '9.0'\nimporters:\n  .:\n    devDependencies:\n${Object.entries(dependencies)
      .map(
        ([name, value]) =>
          `      '${name}':\n        specifier: '${value.specifier}'\n        version: ${value.version}`,
      )
      .join("\n")}\n`,
  );
  for (const [index, packageName] of REQUIRED_TOOLCHAIN_PACKAGES.entries()) {
    write(
      root,
      path.join("node_modules", ...packageName.split("/"), "package.json"),
      JSON.stringify({ name: packageName, version: `1.${index}.0` }),
    );
  }
  const result = preflightToolchain(root);
  assert.equal(result.manager, "pnpm");
  assert.equal(result.packages["@typespec/compiler"], "1.0.0");
});

test("preflights a multi-document pnpm lockfile", () => {
  const root = fixture();
  write(root, "package.json", packageManifest("pnpm@11.8.0"));
  const dependencies = Object.fromEntries(
    REQUIRED_TOOLCHAIN_PACKAGES.map((name, index) => [
      name,
      { specifier: "catalog:", version: `2.${index}.0` },
    ]),
  );
  write(
    root,
    "pnpm-lock.yaml",
    `lockfileVersion: '9.0'\nimporters:\n  .: {}\n---\nlockfileVersion: '9.0'\nimporters:\n  .:\n    devDependencies:\n${Object.entries(dependencies)
      .map(
        ([name, value]) =>
          `      '${name}':\n        specifier: '${value.specifier}'\n        version: ${value.version}`,
      )
      .join("\n")}\n`,
  );
  for (const [index, packageName] of REQUIRED_TOOLCHAIN_PACKAGES.entries()) {
    write(
      root,
      path.join("node_modules", ...packageName.split("/"), "package.json"),
      JSON.stringify({ name: packageName, version: `2.${index}.0` }),
    );
  }
  assert.equal(preflightToolchain(root).packages["@typespec/compiler"], "2.0.0");
});
