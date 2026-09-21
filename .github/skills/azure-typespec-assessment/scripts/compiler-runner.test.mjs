import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { resolveTsp } from "./compiler-runner.mjs";

test("runs the Windows TypeSpec shim through its JavaScript CLI without a shell", () => {
  const worktree = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-compiler-runner-"));
  const packageRoot = path.join(worktree, "node_modules", "@typespec", "compiler");
  const shim = path.join(worktree, "node_modules", ".bin", "tsp.cmd");
  const cli = path.join(packageRoot, "cmd", "tsp.js");
  fs.mkdirSync(path.dirname(shim), { recursive: true });
  fs.mkdirSync(path.dirname(cli), { recursive: true });
  fs.writeFileSync(shim, "@echo off\n");
  fs.writeFileSync(cli, "");
  fs.writeFileSync(
    path.join(packageRoot, "package.json"),
    JSON.stringify({ name: "@typespec/compiler", bin: { tsp: "./cmd/tsp.js" } }),
  );

  assert.deepEqual(resolveTsp(worktree, { platform: "win32", execPath: "node.exe" }), {
    executable: "node.exe",
    args: [cli],
    displayExecutable: shim,
  });
});
