// Run after tsp compile: node --test specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/CognitiveServices/test/adapter-source-model-id.test.mjs
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { test } from "node:test";
import { compile, getPattern, NodeHost } from "@typespec/compiler";

const project = new URL("../", import.meta.url);
const swagger = JSON.parse(
  readFileSync(
    new URL("preview/2026-09-15-preview/cognitiveservices.json", project),
    "utf8",
  ),
);
const properties = swagger.definitions.AdapterDeploymentProperties;
const pattern = properties.properties.sourceModelId.pattern;
const regex = new RegExp(pattern);
const uri = (
  account = "accountName",
  projectName = "projectName",
  model = "modelName",
  version = "1",
) =>
  `azureai://accounts/${account}/projects/${projectName}/models/${model}/versions/${version}`;

test("source identifier uses a literal scheme and positive segment classes", () => {
  assert(pattern.startsWith("^azureai://accounts/"));
  assert.doesNotMatch(pattern, /\[\^/);
  assert.deepEqual(properties.properties.sourceModelId["x-ms-mutability"], [
    "read",
    "create",
  ]);
  assert(properties.required.includes("sourceModelId"));
});

test("accepts canonical identifiers and the account/project naming alphabet", () => {
  for (const value of [
    uri(),
    uri("Test-Account", "Test-Project", "model_df689e0d", "7"),
    uri("account.name", "project.name", "model.name_v2-1", "v1.2-rc_1"),
    uri("aa", "p1", "m", "v"),
    uri("A".repeat(64), "P".repeat(64)),
    uri("accountName", "projectName", "_model", "-version"),
  ]) {
    assert(regex.test(value), value);
  }
});

test("enforces verified account/project bounds and leading characters", () => {
  for (const segment of [0, 1]) {
    for (const value of ["", "a", "a".repeat(65), "_name", "-name", ".name"]) {
      const values = ["accountName", "projectName", "modelName", "1"];
      values[segment] = value;
      assert.equal(regex.test(uri(...values)), false, JSON.stringify(values));
    }
  }
});

test("rejects whitespace, controls, encoded delimiters and non-ASCII in every segment", () => {
  for (const segment of [0, 1, 2, 3]) {
    for (const forbidden of [
      " ",
      "\t",
      "\r",
      "\n",
      "\0",
      "\u0001",
      "\u007f",
      "?query",
      "#fragment",
      "\\child",
      "/child",
      "%2F",
      "%3F",
      "\u00e9",
      "\u6a21\u578b",
      "\u{1f389}",
    ]) {
      const values = ["accountName", "projectName", "modelName", "1"];
      values[segment] += forbidden;
      assert.equal(regex.test(uri(...values)), false, JSON.stringify(values));
    }
  }
});

test("matches the entire identifier and requires model/version segments", () => {
  for (const suffix of ["\n", "\r\n", " ", "?query", "#fragment", "/child"]) {
    assert.equal(regex.test(uri() + suffix), false, JSON.stringify(suffix));
  }
  assert.equal(regex.test(uri().replace("azureai://", "azure://")), false);
  assert.equal(regex.test(uri().replace("azureai://", "AZUREAI://")), false);
  assert.equal(regex.test("prefix:" + uri()), false);
  assert.equal(regex.test(uri("accountName", "projectName", "")), false);
  assert.equal(
    regex.test(uri("accountName", "projectName", "modelName", "")),
    false,
  );
});

test("does not impose unverified model/version maxima", () => {
  assert(
    regex.test(
      uri("accountName", "projectName", "m".repeat(1024), "v".repeat(1024)),
    ),
  );
});

test("both TypeSpec entrypoints decode exactly the emitted pattern", async () => {
  for (const entry of ["main.tsp", "client.tsp"]) {
    const program = await compile(NodeHost, new URL(entry, project).pathname, {
      noEmit: true,
      warningAsError: true,
    });
    assert(!program.hasError(), entry);
    const namespace = program
      .getGlobalNamespaceType()
      .namespaces.get("Microsoft")
      .namespaces.get("CognitiveServices");
    const model = namespace.models.get("AdapterDeploymentProperties");
    assert(model, entry);
    assert.equal(
      getPattern(program, model.properties.get("sourceModelId")),
      pattern,
      entry,
    );
  }
});
