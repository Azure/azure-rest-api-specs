import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { basename, resolve } from "node:path";
import { readFileSync, readdirSync } from "node:fs";
import test from "node:test";
import contract from "./october-contract.mjs";
import {
  hashBytes,
  hashJson,
  loadVersion,
  project,
  sourceContractSwagger,
  versions,
} from "./helpers.mjs";

const api = loadVersion(versions[0]);
const normalized = sourceContractSwagger(api.swagger);

test("TypeSpec source independently compiles without emission and with warnings as errors", () => {
  const compiler = resolve(
    project,
    "..",
    "..",
    "..",
    "..",
    "..",
    "node_modules",
    "@typespec",
    "compiler",
    "cmd",
    "tsp.js",
  );
  execFileSync(
    process.execPath,
    [compiler, "compile", project, "--no-emit", "--warn-as-error"],
    {
      encoding: "utf8",
      timeout: 120000,
      stdio: "pipe",
    },
  );
});

test("full October Swagger equals the authoritative contract including provider Operations", () => {
  assert.equal(hashJson(normalized), contract.swaggerCanonicalSha256);
  assert.equal(api.operations.length, contract.operationCount);
  assert.equal(
    Object.keys(api.swagger.definitions).length,
    contract.definitionCount,
  );
  assert.equal(
    Object.keys(api.swagger.parameters).length,
    contract.parameterCount,
  );
  for (const [name, expected] of Object.entries(contract.definitionHashes)) {
    assert.equal(hashJson(api.swagger.definitions[name]), expected, name);
  }
  for (const [name, expected] of Object.entries(contract.parameterHashes)) {
    assert.equal(hashJson(api.swagger.parameters[name]), expected, name);
  }
  assert.deepEqual(
    api.operations.map((op) => op.operationId).sort(),
    Object.keys(contract.operations).sort(),
  );
  for (const [id, expected] of Object.entries(contract.operations)) {
    const operation = normalized.paths[expected.path][expected.method];
    assert.equal(operation.operationId, id);
    assert.equal(hashJson(operation), expected.operationSha256, id);
  }
});

test("one standard provider Operations GET preserves both original and approved public examples", () => {
  const path =
    api.swagger.paths["/providers/Microsoft.NetworkSecurity/operations"];
  assert.deepEqual(Object.keys(path), ["get"]);
  assert.equal(path.get.operationId, "Operations_List");
  assert.deepEqual(path.get["x-ms-pageable"], { nextLinkName: "nextLink" });
  assert.equal(Object.keys(path.get["x-ms-examples"]).length, 2);
  assert.ok(
    path.get.responses["200"].schema.$ref.endsWith(
      "/definitions/OperationListResult",
    ),
  );
  for (const name of [
    "Operations_List",
    contract.publicOperationsExample.name.slice(0, -5),
  ]) {
    const example = api.example(name);
    assert.equal(example.operationId, "Operations_List");
    assert.equal(example.parameters["api-version"], contract.version);
    const entry = example.responses["200"].body.value[0];
    assert.equal(entry.name, "Microsoft.NetworkSecurity/neuroShields/read");
    assert.equal(entry.isDataAction, false);
  }
});

test("all original October example bytes are pinned and all public pairs are linked exactly once", () => {
  const sourceFolder = resolve(project, "examples", contract.version);
  const generatedFolder = resolve(api.generated, "examples");
  const files = readdirSync(sourceFolder).sort();
  const expectedFiles = [
    ...Object.keys(contract.sourceExampleHashes),
    contract.publicOperationsExample.name,
  ].sort();
  assert.equal(Object.keys(contract.sourceExampleHashes).length, 34);
  assert.equal(files.length, 35);
  assert.deepEqual(files, expectedFiles);
  assert.deepEqual(readdirSync(generatedFolder).sort(), files);
  for (const [name, expected] of Object.entries(contract.sourceExampleHashes)) {
    assert.equal(
      hashBytes(readFileSync(resolve(sourceFolder, name))),
      expected,
      name,
    );
  }
  assert.equal(
    hashBytes(
      readFileSync(
        resolve(sourceFolder, contract.publicOperationsExample.name),
      ),
    ),
    contract.publicOperationsExample.sha256,
  );
  const referenced = [];
  for (const operation of api.operations) {
    const examples = Object.values(operation["x-ms-examples"] ?? {});
    assert.ok(examples.length, operation.operationId);
    const parameters = operation.parameters.map(
      (p) => api.dereference(p).schema,
    );
    assert.ok(
      parameters.some(
        (p) => p.name === "api-version" && p.in === "query" && p.required,
      ),
    );
    for (const reference of examples) {
      const name = basename(reference.$ref);
      referenced.push(name);
      const source = readFileSync(resolve(sourceFolder, name));
      assert.deepEqual(readFileSync(resolve(generatedFolder, name)), source);
      const example = JSON.parse(source);
      assert.equal(example.operationId, operation.operationId);
      assert.equal(example.parameters["api-version"], contract.version);
      for (const match of source
        .toString()
        .matchAll(/api-version=([^&"\s]+)/g)) {
        assert.equal(decodeURIComponent(match[1]), contract.version);
      }
    }
  }
  assert.deepEqual(referenced.sort(), files);
});

test("domain paging and name constraints retain exact October limits without invented defaults", () => {
  const lists = api.operations.filter((op) => op["x-ms-pageable"]);
  assert.equal(lists.length, 9);
  for (const operation of lists) {
    if (operation.operationId === "Operations_List") continue;
    const parameters = operation.parameters.map(
      (p) => api.dereference(p).schema,
    );
    const top = parameters.find((p) => p.name === "top");
    assert.equal(top.type, "integer");
    assert.equal(top.format, "int32");
    assert.equal(top.minimum, 1);
    assert.equal(top.maximum, 50);
    assert.equal(top.default, undefined);
    assert.equal(top.required, false);
    const skip = parameters.find((p) => p.name === "skipToken");
    if (operation.operationId === "NeuroShieldSummaries_List") {
      assert.equal(skip, undefined);
    } else {
      assert.equal(skip.type, "string");
      assert.equal(skip.required, false);
    }
  }
  for (const operation of api.operations) {
    for (const parameter of operation.parameters.map(
      (p) => api.dereference(p).schema,
    )) {
      if (
        !["neuroShieldName", "protectedResourceName"].includes(parameter.name)
      )
        continue;
      const pattern = new RegExp(parameter.pattern);
      assert.ok(pattern.test("a".repeat(64)));
      assert.equal(pattern.test("a".repeat(65)), false);
      assert.equal(pattern.test("resource_"), false);
    }
  }
});

test("asynchronous statuses/headers and optional conditional headers remain unchanged", () => {
  const operation = (id) => api.operations.find((op) => op.operationId === id);
  const put = operation("NeuroShieldProtectedResources_CreateOrUpdate");
  const remove = operation("NeuroShieldProtectedResources_Delete");
  assert.deepEqual(Object.keys(put.responses).sort(), [
    "200",
    "201",
    "default",
  ]);
  assert.deepEqual(Object.keys(remove.responses).sort(), [
    "202",
    "204",
    "default",
  ]);
  assert.deepEqual(Object.keys(put.responses["201"].headers).sort(), [
    "Azure-AsyncOperation",
    "Retry-After",
  ]);
  assert.deepEqual(Object.keys(remove.responses["202"].headers).sort(), [
    "Azure-AsyncOperation",
    "Location",
    "Retry-After",
  ]);
  for (const op of [put, remove]) {
    assert.equal(op["x-ms-long-running-operation"], true);
    assert.deepEqual(op["x-ms-long-running-operation-options"], {
      "final-state-via": "azure-async-operation",
    });
    const header = op.parameters.find((p) => p.name === "If-Match");
    assert.equal(header.required, false);
    assert.equal(header.in, "header");
  }
  for (const id of [
    "NeuroShields_CreateOrUpdate",
    "NeuroShields_Update",
    "NeuroShieldFindings_Mitigate",
    "NeuroShieldFindings_Rollback",
    "NeuroShieldMitigations_Execute",
    "NeuroShieldMitigations_Rollback",
    "NeuroShieldProtectedResources_TriggerInventoryUpload",
  ]) {
    assert.equal(operation(id)["x-ms-long-running-operation"], undefined);
  }
});

test("only October exists in the enum, decorators, discovery, tags and example folders", () => {
  assert.deepEqual(versions, [contract.version]);
  assert.deepEqual(readdirSync(resolve(project, "examples")).sort(), versions);
  assert.deepEqual(readdirSync(resolve(project, "preview")).sort(), versions);
  const swaggerFiles = readdirSync(project, { recursive: true })
    .map((file) => file.replaceAll("\\", "/"))
    .filter(
      (file) => file.endsWith(".json") && !file.split("/").includes("examples"),
    )
    .sort();
  assert.deepEqual(swaggerFiles, [
    `preview/${contract.version}/neuroShield.json`,
  ]);
  const main = readFileSync(resolve(project, "main.tsp"), "utf8");
  const declarations = [
    ...main.matchAll(/(v\d{4}_\d{2}_\d{2}_preview): "([^"]+)"/g),
  ];
  assert.deepEqual(
    declarations.map((m) => m[2]),
    versions,
  );
  assert.equal((main.match(/@Azure\.Core\.previewVersion/g) ?? []).length, 1);
  assert.match(
    main,
    /@Azure\.Core\.previewVersion\s+@armCommonTypesVersion\(Azure\.ResourceManager\.CommonTypes\.Versions\.v6\)\s+v2026_10_01_preview/,
  );
  for (const file of readdirSync(project).filter((name) =>
    name.endsWith(".tsp"),
  )) {
    const source = readFileSync(resolve(project, file), "utf8");
    assert.doesNotMatch(
      source,
      /2026-06-01-preview|v2026_06_01_preview|LegacyNeuroShield|legacyIdentity|legacyTop/,
    );
    assert.doesNotMatch(
      source,
      /CommonTypes\.Private|ResourceManager\.Private|armUpdateProviderNamespace|armCommonParameter|no-private-usage/,
    );
    for (const match of source.matchAll(
      /Versions\.(v\d{4}_\d{2}_\d{2}_preview)/g,
    )) {
      assert.equal(match[1], declarations[0][1]);
    }
  }
  const readme = readFileSync(resolve(project, "readme.md"), "utf8");
  const service = readFileSync(resolve(project, "service.yaml"), "utf8");
  const config = readFileSync(resolve(project, "tspconfig.yaml"), "utf8");
  for (const source of [readme, service])
    assert.doesNotMatch(source, /2026-06-01-preview/);
  assert.ok(service.includes(`version: ${contract.version}`));
  assert.equal((service.match(/version:/g) ?? []).length, 1);
  assert.ok(readme.includes(`tag: package-${contract.version}`));
  assert.ok(
    readme.includes(
      `input-file:\n  - preview/${contract.version}/neuroShield.json`,
    ),
  );
  assert.doesNotMatch(readme, /\nsuppressions:/);
  assert.match(config, /omit-unreachable-types: true/);
  assert.match(config, /fix-const-stuttering: true\s+flavor: "azure"/);
  assert.ok(main.includes("alias NeuroShieldOperationStatusParameters"));
  assert.ok(main.includes("get is ArmReadOperation"));
});
