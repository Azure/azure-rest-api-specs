/*
 * Ensure a local `node_modules/.bin/folder-structure` shim exists.
 *
 * In this repo, `folder-structure` is a bin from the internal package
 * `@azure-tools/spec-validation` (installed via file: dependencies).
 *
 * Some installs have been observed to link `tsv` but not `folder-structure`,
 * which breaks `npx folder-structure` (it falls back to the npm registry).
 *
 * This script is intentionally small and safe:
 * - If the shim already exists, it does nothing.
 * - If the target command doesn't exist, it does nothing.
 */

const fs = require("fs");
const path = require("path");

function ensureDir(dirPath) {
  fs.mkdirSync(dirPath, { recursive: true });
}

function writeFileIfMissing(filePath, content, mode) {
  if (fs.existsSync(filePath)) return;
  fs.writeFileSync(filePath, content, { encoding: "utf8" });
  if (mode !== undefined) {
    try {
      fs.chmodSync(filePath, mode);
    } catch {
      // ignore
    }
  }
}

(function main() {
  const repoRoot = process.cwd();
  const binDir = path.join(repoRoot, "node_modules", ".bin");

  const target = path.join(
    repoRoot,
    "node_modules",
    "@azure-tools",
    "spec-validation",
    "cmd",
    "folder-structure.js",
  );

  if (!fs.existsSync(target)) {
    return;
  }

  ensureDir(binDir);

  const shimPath = path.join(binDir, "folder-structure");
  const shimCmdPath = path.join(binDir, "folder-structure.cmd");
  const shimPs1Path = path.join(binDir, "folder-structure.ps1");

  // POSIX shim
  writeFileIfMissing(
    shimPath,
    `#!/usr/bin/env bash\nnode "$(cd "$(dirname \"$0\")" && pwd)/../@azure-tools/spec-validation/cmd/folder-structure.js" "$@"\n`,
    0o755,
  );

  // Windows cmd shim
  writeFileIfMissing(
    shimCmdPath,
    `@ECHO OFF\r\nnode "%~dp0\\..\\@azure-tools\\spec-validation\\cmd\\folder-structure.js" %*\r\n`,
  );

  // Windows PowerShell shim
  writeFileIfMissing(
    shimPs1Path,
    `#!/usr/bin/env pwsh\r\nnode "$PSScriptRoot/../@azure-tools/spec-validation/cmd/folder-structure.js" @args\r\n`,
  );
})();
