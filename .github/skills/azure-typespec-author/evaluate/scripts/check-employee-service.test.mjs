import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const modules =
  process.env.FIXTURE_NODE_MODULES ??
  fileURLToPath(new URL("../fixtures/Microsoft.Widget/Widget/node_modules", import.meta.url));
const main = fs.readFileSync(
  new URL("../fixtures/002005-ARM-define-the-resource/main.tsp", import.meta.url),
  "utf8",
);
const employee = fs.readFileSync(
  new URL("../fixtures/Microsoft.Widget/Widget/employee.tsp", import.meta.url),
  "utf8",
);

/**
 * @param {import("node:test").TestContext} t
 * @param {"inline" | "imported" | "unreachable" | "missing-operations"} variant
 */
function check(t, variant) {
  assert.ok(
    fs.existsSync(modules),
    "Prepare FIXTURE_NODE_MODULES before running compiler-backed tests.",
  );
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "compiled-employee-"));
  t.after(() => fs.rmSync(root, { recursive: true, force: true }));
  fs.symlinkSync(modules, path.join(root, "node_modules"), "junction");
  fs.copyFileSync(
    new URL("check-employee-service.mjs", import.meta.url),
    path.join(root, "check.mjs"),
  );
  fs.writeFileSync(path.join(root, "package.json"), '{"type":"module"}');
  let entrypoint = main;
  if (variant === "inline") {
    entrypoint += "\n" + employee.replace(/^(import|using|namespace)[^\r\n]*;\r?\n/gm, "");
  } else {
    fs.writeFileSync(
      path.join(root, "employee.tsp"),
      variant === "missing-operations" ? employee.replace(/ {2}delete is [^\r\n]*;/, "") : employee,
    );
    if (variant !== "unreachable") entrypoint = 'import "./employee.tsp";\n' + entrypoint;
  }
  fs.writeFileSync(path.join(root, "main.tsp"), entrypoint);
  return spawnSync(process.execPath, ["check.mjs"], { cwd: root, encoding: "utf8" });
}

/** @type {readonly ["inline", "imported"]} */
const validVariants = ["inline", "imported"];
for (const variant of validVariants) {
  await test(`accepts a compiled ${variant} Employee service`, (t) => {
    const result = check(t, variant);
    assert.equal(result.status, 0, result.stdout + result.stderr);
  });
}

await test("rejects a complete Employee declaration in an unimported file", (t) => {
  const result = check(t, "unreachable");
  assert.notEqual(result.status, 0);
  assert.match(result.stderr, /Employee must be reachable from main\.tsp/);
});

await test("rejects reachable Employee without its standard operations", (t) => {
  const result = check(t, "missing-operations");
  assert.notEqual(result.status, 0);
  assert.match(result.stderr, /Employee must expose delete/);
});
