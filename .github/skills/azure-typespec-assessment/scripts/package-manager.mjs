import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import YAML from "yaml";
import { dependencyProcessCommand } from "./npm-command.mjs";

export { dependencyProcessCommand } from "./npm-command.mjs";

export const REQUIRED_TOOLCHAIN_PACKAGES = [
  "@typespec/compiler",
  "@typespec/openapi3",
  "@azure-tools/typespec-autorest",
  "@azure-tools/typespec-azure-resource-manager",
  "@azure-tools/typespec-client-generator-core",
];

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, "utf8"));
}

function sha256(parts) {
  const hash = crypto.createHash("sha256");
  for (const part of parts) hash.update(part);
  return hash.digest("hex");
}

function declaredManager(value) {
  if (!value) return null;
  const match = /^(npm|pnpm)@(\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?)(?:\+sha\d+\..+)?$/.exec(value);
  if (!match) {
    throw new Error(
      `Unsupported packageManager declaration ${JSON.stringify(value)}; expected npm@<exact-version> or pnpm@<exact-version>.`,
    );
  }
  return { name: match[1], version: match[2] };
}

export function detectPackageManager(root) {
  const packagePath = path.join(root, "package.json");
  if (!fs.existsSync(packagePath)) {
    throw new Error(`Root package.json is unavailable in ${root}.`);
  }
  const manifest = readJson(packagePath);
  const declared = declaredManager(manifest.packageManager);
  const lockFiles = {
    npm: path.join(root, "package-lock.json"),
    pnpm: path.join(root, "pnpm-lock.yaml"),
  };
  const available = Object.entries(lockFiles)
    .filter(([, file]) => fs.existsSync(file))
    .map(([name]) => name);
  if (declared) {
    if (!available.includes(declared.name)) {
      throw new Error(
        `${declared.name} is declared in package.json but ${path.basename(lockFiles[declared.name])} is unavailable in ${root}.`,
      );
    }
    return {
      ...declared,
      lockFile: path.basename(lockFiles[declared.name]),
      lockPath: lockFiles[declared.name],
      packagePath,
    };
  }
  if (available.length !== 1) {
    throw new Error(
      available.length
        ? `Multiple package-manager lockfiles are present in ${root}; add an exact packageManager declaration.`
        : `No supported package-manager lockfile is available in ${root}.`,
    );
  }
  if (available[0] === "pnpm") {
    throw new Error(
      `pnpm-lock.yaml requires an exact packageManager declaration in ${packagePath}.`,
    );
  }
  return {
    name: "npm",
    version: null,
    lockFile: "package-lock.json",
    lockPath: lockFiles.npm,
    packagePath,
  };
}

export function dependencyFingerprint(root, manager = detectPackageManager(root)) {
  const files = [
    manager.packagePath,
    manager.lockPath,
    path.join(root, "pnpm-workspace.yaml"),
    path.join(root, ".npmrc"),
  ].filter(fs.existsSync);
  return sha256([
    `${manager.name}@${manager.version ?? "host"}\0${process.platform}\0${process.arch}\0`,
    ...files.flatMap((file) => [path.basename(file), "\0", fs.readFileSync(file), "\0"]),
  ]);
}

function resolvedVersion(value) {
  const raw = typeof value === "string" ? value : value?.version;
  return /^(\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?)/.exec(raw ?? "")?.[1];
}

function expectedVersions(manager) {
  if (manager.name === "npm") {
    const lock = readJson(manager.lockPath);
    return new Map(
      REQUIRED_TOOLCHAIN_PACKAGES.map((packageName) => [
        packageName,
        lock.packages?.[`node_modules/${packageName}`]?.version,
      ]),
    );
  }
  const documents = YAML.parseAllDocuments(fs.readFileSync(manager.lockPath, "utf8"));
  const dependencies = documents.reduce((all, document) => {
    if (document.errors.length) throw document.errors[0];
    const importer = document.toJS()?.importers?.["."] ?? {};
    return {
      ...all,
      ...importer.dependencies,
      ...importer.devDependencies,
      ...importer.optionalDependencies,
    };
  }, {});
  return new Map(
    REQUIRED_TOOLCHAIN_PACKAGES.map((packageName) => [
      packageName,
      resolvedVersion(dependencies[packageName]),
    ]),
  );
}

export function preflightToolchain(root, manager = detectPackageManager(root)) {
  const expected = expectedVersions(manager);
  const failures = [];
  for (const packageName of REQUIRED_TOOLCHAIN_PACKAGES) {
    const expectedVersion = expected.get(packageName);
    const packagePath = path.join(root, "node_modules", ...packageName.split("/"), "package.json");
    if (!expectedVersion) {
      failures.push(`${packageName} is absent from ${manager.lockFile}`);
      continue;
    }
    if (!fs.existsSync(packagePath)) {
      failures.push(`${packageName} is not installed`);
      continue;
    }
    const installed = readJson(packagePath).version;
    if (installed !== expectedVersion) {
      failures.push(
        `${packageName} installed version ${installed} does not match lock version ${expectedVersion}`,
      );
    }
  }
  if (failures.length) throw new Error(failures.join("\n"));
  return {
    manager: manager.name,
    managerVersion: manager.version,
    packages: Object.fromEntries(expected),
  };
}

export function dependencyInstallCommand(manager, { storeDir } = {}) {
  if (manager.name === "npm") {
    return {
      executable: process.platform === "win32" ? "npm.cmd" : "npm",
      args: ["ci", "--ignore-scripts", "--no-audit", "--no-fund"],
    };
  }
  return {
    executable: process.platform === "win32" ? "npx.cmd" : "npx",
    args: [
      "--yes",
      `pnpm@${manager.version}`,
      "install",
      "--frozen-lockfile",
      "--ignore-scripts",
      "--store-dir",
      storeDir,
    ],
  };
}

function runInstall(command, { cwd, log, env }) {
  const processCommand = dependencyProcessCommand(command, { env });
  const result = spawnSync(processCommand.executable, processCommand.args, {
    cwd,
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
    env,
  });
  fs.writeFileSync(
    log,
    [result.stdout, result.stderr, result.error?.message].filter(Boolean).join("\n"),
  );
  if (result.status !== 0) {
    throw new Error(
      `${path.basename(command.executable)} dependency install failed with exit code ${result.status ?? "unknown"}; see ${log}.`,
    );
  }
}

function ensureNpmDependencies({ worktree, work, reuseRoot, manager, fingerprint }) {
  const cache = path.join(work, "cache", "toolchains", `npm-${fingerprint}`);
  const source = path.join(cache, "node_modules");
  const target = path.join(worktree, "node_modules");
  if (fs.existsSync(target)) {
    preflightToolchain(worktree, manager);
    return { reused: true };
  }
  let reused = fs.existsSync(source);
  if (!fs.existsSync(source)) {
    fs.mkdirSync(cache, { recursive: true });
    fs.copyFileSync(manager.packagePath, path.join(cache, "package.json"));
    fs.copyFileSync(manager.lockPath, path.join(cache, manager.lockFile));
    reused = false;
    if (reuseRoot && fs.existsSync(path.join(reuseRoot, "node_modules"))) {
      try {
        const reuseManager = detectPackageManager(reuseRoot);
        if (reuseManager.name !== "npm") throw new Error("package manager mismatch");
        if (dependencyFingerprint(reuseRoot, reuseManager) !== fingerprint) {
          throw new Error("dependency fingerprint mismatch");
        }
        preflightToolchain(reuseRoot, reuseManager);
        fs.symlinkSync(
          path.join(reuseRoot, "node_modules"),
          source,
          process.platform === "win32" ? "junction" : "dir",
        );
        reused = true;
      } catch {
        reused = false;
      }
    }
    if (!reused) {
      runInstall(dependencyInstallCommand(manager), {
        cwd: cache,
        log: path.join(cache, "npm-ci.log"),
        env: process.env,
      });
    }
  }
  fs.symlinkSync(source, target, process.platform === "win32" ? "junction" : "dir");
  preflightToolchain(worktree, manager);
  return { reused };
}

function ensurePnpmDependencies({ worktree, work, manager }) {
  const target = path.join(worktree, "node_modules");
  if (fs.existsSync(target)) {
    preflightToolchain(worktree, manager);
    return { reused: true };
  }
  const cache = path.join(work, "cache", "toolchains", `pnpm-${manager.version}`);
  const storeDir = path.join(cache, "store");
  const npmCache = path.join(cache, "npm-exec");
  fs.mkdirSync(cache, { recursive: true });
  runInstall(dependencyInstallCommand(manager, { storeDir }), {
    cwd: worktree,
    log: path.join(cache, `pnpm-install-${path.basename(worktree)}.log`),
    env: { ...process.env, npm_config_cache: npmCache },
  });
  preflightToolchain(worktree, manager);
  return { reused: false };
}

export function ensureDependencies({ worktree, work, reuseRoot }) {
  const started = performance.now();
  const manager = detectPackageManager(worktree);
  const fingerprint = dependencyFingerprint(worktree, manager);
  const result = manager.name === "npm"
    ? ensureNpmDependencies({ worktree, work, reuseRoot, manager, fingerprint })
    : ensurePnpmDependencies({ worktree, work, manager });
  return {
    manager: manager.name,
    managerVersion: manager.version,
    lockFile: manager.lockFile,
    fingerprint,
    reused: result.reused,
    durationMs: Math.round(performance.now() - started),
  };
}
