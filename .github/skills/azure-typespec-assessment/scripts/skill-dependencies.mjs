import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { dependencyProcessCommand } from "./npm-command.mjs";

const SKILL_ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const INSTALL_LOCK = ".dependency-install.lock";
const REQUIRED_PACKAGE = "yaml";

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, "utf8"));
}

function expectedVersion(root) {
  const lockPath = path.join(root, "package-lock.json");
  if (!fs.existsSync(lockPath)) {
    throw new Error(`Assessment skill package-lock.json is unavailable in ${root}.`);
  }
  const lock = readJson(lockPath);
  const version = lock.packages?.[`node_modules/${REQUIRED_PACKAGE}`]?.version;
  if (!version) {
    throw new Error(`${REQUIRED_PACKAGE} is absent from ${lockPath}.`);
  }
  return version;
}

function installedVersion(root) {
  const manifest = path.join(root, "node_modules", REQUIRED_PACKAGE, "package.json");
  if (!fs.existsSync(manifest)) return undefined;
  try {
    return readJson(manifest).version;
  } catch {
    return undefined;
  }
}

export function skillDependencyInstallCommand(
  { platform = process.platform } = {},
) {
  return {
    executable: platform === "win32" ? "npm.cmd" : "npm",
    args: ["ci", "--ignore-scripts", "--no-audit", "--no-fund"],
  };
}

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
      `Assessment skill dependency installation failed with exit code ${result.status ?? "unknown"}.`
      + (detail ? `\n${detail}` : ""),
    );
  }
}

function delay(milliseconds) {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
}

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
  let lock;
  while (lock === undefined) {
    try {
      lock = fs.openSync(lockPath, "wx");
    } catch (error) {
      if (error.code !== "EEXIST") throw error;
      if (Date.now() - waitStarted >= timeoutMs) {
        throw new Error(
          `Timed out waiting for assessment skill dependency installation; remove stale lock ${lockPath} if no installation is running.`,
        );
      }
      await wait(100);
    }
  }

  try {
    let installedNow = false;
    if (installedVersion(root) !== expected) {
      log("Installing Azure TypeSpec assessment skill dependencies...");
      await runInstall(root);
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
