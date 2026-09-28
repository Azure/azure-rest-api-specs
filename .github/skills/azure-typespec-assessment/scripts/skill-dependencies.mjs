import { spawnSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { isRecord, readJsonObject } from "./cli.mjs";
import { dependencyProcessCommand } from "./npm-command.mjs";

const SKILL_ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const INSTALL_LOCK = ".dependency-install.lock";
const REQUIRED_PACKAGE = "yaml";

/**
 * @param {string} root
 * @returns {{root: string, managerVersion: string, importer: string}}
 */
function resolveWorkspace(root) {
  let current = path.resolve(root);
  while (true) {
    const manifestPath = path.join(current, "package.json");
    const workspacePath = path.join(current, "pnpm-workspace.yaml");
    const lockPath = path.join(current, "pnpm-lock.yaml");
    if (fs.existsSync(manifestPath) && fs.existsSync(workspacePath) && fs.existsSync(lockPath)) {
      const packageManager = readJsonObject(manifestPath).packageManager;
      const match =
        typeof packageManager === "string"
          ? /^pnpm@(\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?)(?:\+sha\d+\..+)?$/.exec(packageManager)
          : null;
      if (!match) {
        throw new Error(`Expected an exact pnpm packageManager declaration in ${manifestPath}.`);
      }
      return {
        root: current,
        managerVersion: match[1],
        importer: path.relative(current, root).split(path.sep).join("/"),
      };
    }
    const parent = path.dirname(current);
    if (parent === current) {
      throw new Error(`Assessment skill pnpm workspace is unavailable above ${root}.`);
    }
    current = parent;
  }
}

/**
 * @param {string} value
 * @returns {string}
 */
function unquoteYamlScalar(value) {
  const trimmed = value.trim();
  if (
    trimmed.length >= 2 &&
    ((trimmed.startsWith("'") && trimmed.endsWith("'")) ||
      (trimmed.startsWith('"') && trimmed.endsWith('"')))
  ) {
    return trimmed.slice(1, -1);
  }
  return trimmed;
}

/**
 * Read the exact dependency version from the skill's pnpm lockfile importer
 * without importing yaml before that dependency has been bootstrapped.
 *
 * @param {{root: string, importer: string}} workspace
 * @returns {string}
 */
function expectedVersion(workspace) {
  const lockPath = path.join(workspace.root, "pnpm-lock.yaml");
  const lines = fs.readFileSync(lockPath, "utf8").split(/\r?\n/);
  let currentImporter = "";
  let inDependencies = false;
  let currentDependency = "";
  for (const line of lines) {
    const importerMatch = /^ {2}(\S.*):\s*$/.exec(line);
    if (importerMatch) {
      currentImporter = unquoteYamlScalar(importerMatch[1]);
      inDependencies = false;
      currentDependency = "";
      continue;
    }
    if (currentImporter !== workspace.importer) continue;
    if (line === "    dependencies:") {
      inDependencies = true;
      currentDependency = "";
      continue;
    }
    if (/^ {4}\S/.test(line)) {
      inDependencies = false;
      currentDependency = "";
      continue;
    }
    if (!inDependencies) continue;
    const dependencyMatch = /^ {6}(\S.*):\s*$/.exec(line);
    if (dependencyMatch) {
      currentDependency = unquoteYamlScalar(dependencyMatch[1]);
      continue;
    }
    if (currentDependency === REQUIRED_PACKAGE) {
      const versionMatch = /^ {8}version:\s*(\S.*)\s*$/.exec(line);
      if (versionMatch) return unquoteYamlScalar(versionMatch[1]);
    }
  }
  throw new Error(
    `${REQUIRED_PACKAGE} is absent from pnpm importer ${workspace.importer} in ${lockPath}.`,
  );
}

/**
 * @param {string} root
 * @returns {string | undefined}
 */
function installedVersion(root) {
  const manifest = path.join(root, "node_modules", REQUIRED_PACKAGE, "package.json");
  if (!fs.existsSync(manifest)) return undefined;
  try {
    const version = readJsonObject(manifest).version;
    return typeof version === "string" ? version : undefined;
  } catch {
    return undefined;
  }
}

/**
 * @param {{platform?: NodeJS.Platform, managerVersion: string}} options
 * @returns {{executable: string, args: string[]}}
 */
export function skillDependencyInstallCommand({ platform = process.platform, managerVersion }) {
  return {
    executable: platform === "win32" ? "npx.cmd" : "npx",
    args: ["--yes", `pnpm@${managerVersion}`, "install", "--frozen-lockfile", "--ignore-scripts"],
  };
}

/**
 * @param {string} root
 * @returns {void}
 */
function installSkillDependencies(root) {
  const workspace = resolveWorkspace(root);
  const command = skillDependencyInstallCommand({
    managerVersion: workspace.managerVersion,
  });
  const processCommand = dependencyProcessCommand(command);
  const result = spawnSync(processCommand.executable, processCommand.args, {
    cwd: workspace.root,
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
    env: process.env,
  });
  if (result.status !== 0) {
    const detail = [result.stdout, result.stderr, result.error?.message]
      .filter(Boolean)
      .join("\n")
      .split(/\r?\n/)
      .filter(Boolean)
      .slice(-20)
      .join("\n");
    throw new Error(
      `Assessment skill dependency installation failed with exit code ${result.status ?? "unknown"}.` +
        (detail ? `\n${detail}` : ""),
    );
  }
}

/**
 * @param {number} milliseconds
 * @returns {Promise<void>}
 */
function delay(milliseconds) {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
}

/**
 * @typedef {{
 *   root?: string,
 *   runInstall?: (root: string) => void | Promise<void>,
 *   wait?: (milliseconds: number) => Promise<void>,
 *   timeoutMs?: number,
 *   log?: (message: string) => void
 * }} EnsureSkillDependencyOptions
 */

/**
 * @param {EnsureSkillDependencyOptions} [options]
 * @returns {Promise<{installed: boolean, packages: Record<string, string>, durationMs: number}>}
 */
export async function ensureSkillDependencies({
  root = SKILL_ROOT,
  runInstall = installSkillDependencies,
  wait = delay,
  timeoutMs = 5 * 60 * 1000,
  log = console.error,
} = {}) {
  const started = performance.now();
  const workspace = resolveWorkspace(root);
  const expected = expectedVersion(workspace);
  if (installedVersion(root) === expected) {
    return {
      installed: false,
      packages: { [REQUIRED_PACKAGE]: expected },
      durationMs: Math.round(performance.now() - started),
    };
  }

  const lockPath = path.join(root, INSTALL_LOCK);
  const waitStarted = Date.now();
  /** @type {number | undefined} */
  let lock;
  while (lock === undefined) {
    try {
      lock = fs.openSync(lockPath, "wx");
    } catch (error) {
      const code = isRecord(error) ? error.code : undefined;
      if (code !== "EEXIST") throw error;
      if (Date.now() - waitStarted >= timeoutMs) {
        throw new Error(
          `Timed out waiting for assessment skill dependency installation; remove stale lock ${lockPath} if no installation is running.`,
          { cause: error },
        );
      }
      await wait(100);
    }
  }

  try {
    let installedNow = false;
    if (installedVersion(root) !== expected) {
      log("Installing Azure TypeSpec assessment skill dependencies...");
      await Promise.resolve(runInstall(root));
      installedNow = true;
    }
    const installed = installedVersion(root);
    if (installed !== expected) {
      throw new Error(
        `${REQUIRED_PACKAGE} installed version ${installed ?? "missing"} does not match lock version ${expected}.`,
      );
    }
    return {
      installed: installedNow,
      packages: { [REQUIRED_PACKAGE]: expected },
      durationMs: Math.round(performance.now() - started),
    };
  } finally {
    try {
      fs.closeSync(lock);
    } finally {
      fs.rmSync(lockPath, { force: true });
    }
  }
}
