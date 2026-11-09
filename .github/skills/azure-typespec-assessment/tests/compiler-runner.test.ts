import { assert, test } from "vitest";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { resolveTsp, runProjectCompilers } from "../scripts/compiler-runner.ts";
import { normalizeTcgcContract } from "../scripts/tcgc-contract.ts";

void test("runs the Windows TypeSpec shim through its JavaScript CLI without a shell", () => {
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

void test("collects revision-local generic provenance in the existing TCGC compiler pass", (context) => {
  const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../../..");
  const workRoot = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-compiler-provenance-"));
  context.onTestFinished(() => fs.rmSync(workRoot, { recursive: true, force: true }));
  const project =
    "eng/tools/spec-gen-sdk-runner/test/fixtures/specification/service2/data-plane/widget2";
  const result = runProjectCompilers({
    worktree: repoRoot,
    project,
    projectId: "fixture",
    comparisonRole: "target",
    sourceRevision: "current",
    sourceCommit: "head",
    workRoot,
    apiVersion: "2022-12-01",
  });

  for (const emitter of ["autorest", "tcgc"] as const) {
    assert.equal(result[emitter].sourceRevision, "current");
    assert.equal(result[emitter].sourceCommit, "head");
    assert.equal(result[emitter].selectedApiVersion, "2022-12-01");
  }
  assert.ok(
    result.autorest.command.args.includes(
      "--option=@azure-tools/typespec-autorest.version=2022-12-01",
    ),
  );
  assert.ok(
    result.tcgc.command.args.includes(
      "--option=@azure-tools/assessment-tcgc-provenance.api-version=2022-12-01",
    ),
  );
  assert.equal(result.tcgc.status, "succeeded");
  assert.equal(result.tcgc.files.length, 1);
  assert.ok(result.tcgc.provenanceFile);
  const provenance = JSON.parse(
    fs.readFileSync(path.join(workRoot, result.tcgc.provenanceFile.path), "utf8"),
  ) as { models: { templateArguments: unknown[] }[] };
  assert.ok(provenance.models.some((model) => model.templateArguments.length > 0));
  const contract = normalizeTcgcContract({ workRoot, artifact: result.tcgc });
  assert.ok(contract.models.some((model) => model.genericInstanceIdentity));
});
