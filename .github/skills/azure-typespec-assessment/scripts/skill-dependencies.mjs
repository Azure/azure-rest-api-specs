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
 * @returns {string}
 */
function expectedVersion(root) {
  const lockPath = path.join(root, "package-lock.json");
  if (!fs.existsSync(lockPath)) {
    throw new Error(`Assessment skill package-lock.json is unavailable in ${root}.`);
  }
  const lock = readJsonObject(lockPath);
  const packages = lock.packages;
  const dependency = isRecord(packages) ? packages[`node_modules/${REQUIRED_PACKAGE}`] : undefined;
  const version = isRecord(dependency) ? dependency.version : undefined;
  if (typeof version !== "string" || !version) {
    throw new Error(`${REQUIRED_PACKAGE} is absent from ${lockPath}.`);
  }
  return version;
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
 * @param {{platform?: NodeJS.Platform}} [options]
 * @returns {{executable: string, args: string[]}}
 */
export function skillDependencyInstallCommand({ platform = process.platform } = {}) {
  return {
    executable: platform === "win32" ? "npm.cmd" : "npm",
    args: ["ci", "--ignore-scripts", "--no-audit", "--no-fund"],
  };
}

/**
 * @param {string} root
 * @returns {void}
 */
function installSkillDependencies(root) {
  const command = skillDependencyInstallCommand();
  const processCommand = dependencyProcessCommand(command);
  const result = spawnSync(processCommand.executable, processCommand.args, {
    cwd: root,
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
  const expected = expectedVersion(root);
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
