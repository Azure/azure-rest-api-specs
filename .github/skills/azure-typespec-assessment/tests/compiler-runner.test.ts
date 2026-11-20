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

void test("distinguishes literal, value, union, anonymous model, tuple, and sub-namespace generic template arguments without cyclic JSON failures", (context) => {
  const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../../..");
  const tempWorktree = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-compiler-generics-"));
  const workRoot = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-compiler-generics-out-"));
  context.onTestFinished(() => {
    fs.rmSync(tempWorktree, { recursive: true, force: true });
    fs.rmSync(workRoot, { recursive: true, force: true });
  });
  fs.symlinkSync(
    path.join(repoRoot, "node_modules"),
    path.join(tempWorktree, "node_modules"),
    "junction",
  );
  const projectDir = path.join(tempWorktree, "specification", "contoso", "Contoso.Generics");
  fs.mkdirSync(projectDir, { recursive: true });
  fs.writeFileSync(
    path.join(projectDir, "tspconfig.yaml"),
    'emit:\n  - "@azure-tools/typespec-autorest"\n',
  );
  fs.writeFileSync(
    path.join(projectDir, "main.tsp"),
    `import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;

@service(#{ title: "Contoso Generics" })
namespace Contoso.Generics;

model Widget {
  id: string;
}

model Gadget {
  id: string;
}

enum PageKind {
  Rows: "rows",
  Items: "items",
}

model CustomPage<TItem, TKey extends valueof string> {
  items: TItem[];
}

model EnumTagged<TTag extends valueof PageKind> {
  kind: string;
}

model MetaEnvelope<TMeta extends valueof { limit: int32; active: boolean; tags: string[] }> {
  value: string;
}

model ShapeHolder<TShape> {
  payload: string;
}

namespace SubA {
  model Entry {
    a: string;
  }
  model SubPage<TItem, TKey extends valueof string> {
    items: TItem[];
  }
  @route("/sub-a") @get op listSubA(): SubPage<Entry, "rows">;
}

namespace SubB {
  model Entry {
    b: string;
  }
  model SubPage<TItem, TKey extends valueof string> {
    items: TItem[];
  }
  @route("/sub-b") @get op listSubB(): SubPage<Entry, "rows">;
}

@route("/rows") @get op listRows(): CustomPage<Widget, "rows">;
@route("/items") @get op listItems(): CustomPage<Widget, "items">;
@route("/enum-rows") @get op getEnumRows(): EnumTagged<PageKind.Rows>;
@route("/enum-items") @get op getEnumItems(): EnumTagged<PageKind.Items>;
@route("/meta-small") @get op getMetaSmall(): MetaEnvelope<#{ limit: 10, active: true, tags: #["a"] }>;
@route("/meta-large") @get op getMetaLarge(): MetaEnvelope<#{ limit: 50, active: false, tags: #["b"] }>;
@route("/union-a") @get op getUnionA(): ShapeHolder<Widget | Gadget>;
@route("/union-b") @get op getUnionB(): ShapeHolder<Widget | string>;
@route("/anon-a") @get op getAnonA(): ShapeHolder<{ code: string }>;
@route("/anon-b") @get op getAnonB(): ShapeHolder<{ code: int32 }>;
@route("/tuple-a") @get op getTupleA(): ShapeHolder<[string, int32]>;
@route("/tuple-b") @get op getTupleB(): ShapeHolder<[string, boolean]>;
`,
  );

  const result = runProjectCompilers({
    worktree: tempWorktree,
    project: "specification/contoso/Contoso.Generics",
    projectId: "generics-fixture",
    comparisonRole: "target",
    sourceRevision: "current",
    sourceCommit: "head",
    workRoot,
  });

  const tcgcLog = fs.existsSync(path.join(workRoot, result.tcgc.logPath))
    ? fs.readFileSync(path.join(workRoot, result.tcgc.logPath), "utf8")
    : "";
  assert.equal(result.tcgc.status, "succeeded", tcgcLog);
  assert.ok(result.tcgc.provenanceFile);
  const provenance = JSON.parse(
    fs.readFileSync(path.join(workRoot, result.tcgc.provenanceFile.path), "utf8"),
  ) as {
    models: {
      crossLanguageDefinitionId: string;
      name: string;
      namespace?: string;
      templateArguments: unknown[];
    }[];
  };

  const contract = normalizeTcgcContract({ workRoot, artifact: result.tcgc });
  const byMethod = (methodName: string) => {
    const method = contract.methods.find((item) => item.name === methodName);
    assert.ok(method?.responseType?.id, `missing responseType for ${methodName}`);
    const model = contract.models.find((item) => item.identity === method.responseType?.id);
    assert.ok(model?.genericInstanceIdentity, `missing genericInstanceIdentity for ${methodName}`);
    return model;
  };

  assert.notEqual(
    byMethod("listRows").genericInstanceIdentity,
    byMethod("listItems").genericInstanceIdentity,
  );
  assert.notEqual(
    byMethod("getEnumRows").genericInstanceIdentity,
    byMethod("getEnumItems").genericInstanceIdentity,
  );
  assert.notEqual(
    byMethod("getMetaSmall").genericInstanceIdentity,
    byMethod("getMetaLarge").genericInstanceIdentity,
  );
  assert.notEqual(
    byMethod("getUnionA").genericInstanceIdentity,
    byMethod("getUnionB").genericInstanceIdentity,
  );
  assert.notEqual(
    byMethod("getAnonA").genericInstanceIdentity,
    byMethod("getAnonB").genericInstanceIdentity,
  );
  assert.notEqual(
    byMethod("getTupleA").genericInstanceIdentity,
    byMethod("getTupleB").genericInstanceIdentity,
  );
  assert.notEqual(
    byMethod("listSubA").genericInstanceIdentity,
    byMethod("listSubB").genericInstanceIdentity,
  );
  assert.ok(provenance.models.some((item) => item.namespace === "Contoso.Generics.SubA"));
  assert.ok(provenance.models.some((item) => item.namespace === "Contoso.Generics.SubB"));
});
