// Run after tsp compile: node --test test/cognitiveservices/custom-keys-contract.mjs
// Set CUSTOM_KEYS_BASE_REF to check historical and unrelated contracts against Git.
import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";
import {
  compile,
  createSourceFile,
  isSecret,
  NodeHost,
} from "@typespec/compiler";

const root = fileURLToPath(new URL("../../", import.meta.url));
const project = path.join(
  root,
  "specification",
  "cognitiveservices",
  "resource-manager",
  "Microsoft.CognitiveServices",
  "CognitiveServices",
);
const version = process.env.CUSTOM_KEYS_API_VERSION ?? "2026-11-01";
const status = version.endsWith("-preview") ? "preview" : "stable";
const specFile = path.join(project, status, version, "cognitiveservices.json");
const spec = JSON.parse(readFileSync(specFile, "utf8"));
const baselineRef = process.env.CUSTOM_KEYS_BASE_REF;
const historyBaselineRef =
  process.env.CUSTOM_KEYS_HISTORY_BASE_REF ?? baselineRef;
const documents = new Map([[specFile, spec]]);
const git = (...args) =>
  execFileSync("git", args, { cwd: root, maxBuffer: 64 * 1024 * 1024 });

function resolve(schema, file = specFile) {
  if (!schema.$ref) return [schema, file];
  const [relative, fragment] = schema.$ref.split("#");
  const target = relative ? path.resolve(path.dirname(file), relative) : file;
  if (!documents.has(target)) {
    documents.set(target, JSON.parse(readFileSync(target, "utf8")));
  }
  const value = fragment
    .split("/")
    .slice(1)
    .reduce(
      (current, key) =>
        current[key.replaceAll("~1", "/").replaceAll("~0", "~")],
      documents.get(target),
    );
  assert(value, `Unresolved schema: ${schema.$ref}`);
  return [value, target];
}

function properties(schema, file = specFile) {
  [schema, file] = resolve(schema, file);
  return Object.assign(
    {},
    ...(schema.allOf ?? []).map((base) => properties(base, file)),
    schema.properties,
  );
}

function customKeys(propertiesSchema) {
  const baseRef = propertiesSchema.$ref;
  assert(baseRef?.startsWith("#/definitions/"));
  const matches = Object.entries(spec.definitions).filter(([, model]) => {
    return (
      model.allOf?.some((base) => base.$ref === baseRef) &&
      model["x-ms-discriminator-value"] === "CustomKeys"
    );
  });
  assert.equal(matches.length, 1, `Unique CustomKeys subtype of ${baseRef}`);
  return matches[0][1];
}

const collectionPaths = Object.keys(spec.paths).filter((route) =>
  /\/connections$/.test(route),
);
assert.equal(
  collectionPaths.length,
  2,
  "Account and project connection scopes",
);

test("reconciled certificate trust and tool controls remain preview-only", () => {
  for (const [model, property] of [
    ["AccountProperties", "trustedCertificateSources"],
    ["ProjectProperties", "toolControls"],
  ]) {
    assert.equal(
      Object.hasOwn(properties(spec.definitions[model]), property),
      status === "preview",
      `${model}.${property}`,
    );
  }
  for (const model of [
    "TrustedCertificateSource",
    "TrustedCertificateSourceType",
    "CertificateBundleReference",
    "ToolControls",
    "ToolControlEntry",
    "ToolControlsDefaultAction",
    "ToolControlType",
  ]) {
    assert.equal(
      Object.hasOwn(spec.definitions, model),
      status === "preview",
      model,
    );
  }
});

test("read projections preserve every authentication variant and all unrelated properties", () => {
  const variants = (base) =>
    new Map(
      Object.values(spec.definitions)
        .filter((model) =>
          model.allOf?.some(
            (parent) => parent.$ref === `#/definitions/${base}`,
          ),
        )
        .map((model) => [model["x-ms-discriminator-value"], model]),
    );
  const original = variants("ConnectionPropertiesV2");
  const read = variants("ConnectionPropertiesV2Read");
  assert.deepEqual([...read.keys()].sort(), [...original.keys()].sort());
  for (const [authType, model] of original) {
    const expected = properties(model);
    if (authType === "CustomKeys") delete expected.credentials;
    assert.deepEqual(properties(read.get(authType)), expected, authType);
    const ownProperties = Object.keys(model.properties ?? {}).filter(
      (name) => authType !== "CustomKeys" || name !== "credentials",
    );
    assert.deepEqual(
      Object.keys(read.get(authType).properties ?? {}).sort(),
      ownProperties.sort(),
      `${authType}: inherited properties must not be redeclared`,
    );
  }
});

for (const collection of collectionPaths) {
  const resource = `${collection}/{connectionName}`;
  const operations = spec.paths[resource];
  test(`${collection}: ordinary GET, PUT, PATCH and LIST omit CustomKeys credentials`, () => {
    for (const operation of [
      operations.get,
      operations.put,
      operations.patch,
      spec.paths[collection].get,
    ]) {
      for (const [statusCode, response] of Object.entries(
        operation.responses,
      )) {
        if (!statusCode.startsWith("2") || !response.schema) continue;
        let payload = response.schema;
        const envelope = properties(payload);
        if (envelope.value) payload = envelope.value.items;
        const resourceProperties = properties(payload);
        for (const field of ["id", "name", "type", "properties"]) {
          assert(
            resourceProperties[field],
            `${operation.operationId}: ${field}`,
          );
        }
        const connectionProperties = properties(payload).properties;
        assert(connectionProperties, operation.operationId);
        const subtype = customKeys(connectionProperties);
        assert.equal(
          Object.hasOwn(properties(subtype), "credentials"),
          false,
          `${operation.operationId} ${statusCode}`,
        );
        assert.equal(subtype["x-ms-discriminator-value"], "CustomKeys");
        assert(properties(subtype).metadata, "Non-secret metadata is retained");
      }
    }
  });

  test(`${collection}: PUT/PATCH retain optional secret credentials and required authType`, () => {
    for (const operation of [operations.put, operations.patch]) {
      const body = operation.parameters
        .map((parameter) => resolve(parameter)[0])
        .find((parameter) => parameter.in === "body");
      assert(body, operation.operationId);
      const connectionProperties = properties(body.schema).properties;
      const subtype = customKeys(connectionProperties);
      const credentials = properties(subtype).credentials;
      assert(credentials, operation.operationId);
      assert.equal(credentials["x-ms-secret"], true);
      assert.deepEqual(credentials["x-ms-mutability"], ["update", "create"]);
      assert(!subtype.required?.includes("credentials"));
      assert(resolve(connectionProperties)[0].required.includes("authType"));
      const keys = properties(credentials).keys;
      assert.equal(keys["x-ms-secret"], true);
      assert.equal(keys.type, "object");
      assert.equal(keys.additionalProperties.type, "string");
    }
  });
}

test("authorized secret-response projection retains credentials without adding a public action", async () => {
  const entry = path.join(project, "__custom_keys_contract_test.tsp");
  const source = [
    'import "./main.tsp";',
    "namespace Microsoft.CognitiveServices;",
    "@TypeSpec.Versioning.added(Versions.v2026_11_01)",
    "model CustomKeysProjectionProbe {",
    "  ordinary: ConnectionPropertiesV2Read;",
    "  authorized: Read<CreateOrUpdate<CustomKeysConnectionProperties>>;",
    "}",
  ].join("\n");
  const host = {
    ...NodeHost,
    stat: (file) =>
      path.resolve(file) === entry
        ? Promise.resolve({ isFile: () => true, isDirectory: () => false })
        : NodeHost.stat(file),
    realpath: (file) =>
      path.resolve(file) === entry
        ? Promise.resolve(entry)
        : NodeHost.realpath(file),
    readFile: (file) =>
      path.resolve(file) === entry
        ? Promise.resolve(createSourceFile(source, file))
        : NodeHost.readFile(file),
  };
  const program = await compile(host, entry, {
    noEmit: true,
    warningAsError: true,
  });
  assert(
    !program.hasError(),
    JSON.stringify(
      program.diagnostics.map(({ code, message, severity }) => ({
        code,
        message,
        severity,
      })),
    ),
  );
  const namespace = program
    .getGlobalNamespaceType()
    .namespaces.get("Microsoft")
    .namespaces.get("CognitiveServices");
  const ordinary = namespace.models.get("CustomKeysConnectionPropertiesRead");
  assert(!ordinary.properties.has("credentials"));
  const authorized = namespace.models
    .get("CustomKeysProjectionProbe")
    .properties.get("authorized").type;
  const credentials = authorized.properties.get("credentials");
  assert(
    credentials,
    "Explicit secret-response projection retains credentials",
  );
  assert(isSecret(program, credentials));
  assert(isSecret(program, credentials.type.properties.get("keys")));
  assert.equal(
    collectionPaths.some((route) => spec.paths[route].post),
    false,
    "No public connection action is introduced",
  );
  assert(
    !Object.keys(spec.paths).some((route) =>
      /\/connections\/.*\/listsecrets$/i.test(route),
    ),
  );
});

if (historyBaselineRef) {
  test("every historical generated contract and example retains its Git blob hash", () => {
    const prefix = path.relative(root, project).split(path.sep).join("/");
    const entries = git("ls-tree", "-r", "-z", historyBaselineRef, "--", prefix)
      .toString()
      .split("\0")
      .filter(Boolean)
      .filter((entry) => {
        const [, file] = entry.split("\t");
        return (
          file.endsWith(".json") &&
          !file.includes(`/${version}/`) &&
          /\/(?:stable|preview|examples)\//.test(file)
        );
      });
    assert(entries.length > 0);
    const files = entries.map((entry) => entry.split("\t")[1]);
    const hashes = execFileSync("git", ["hash-object", "--stdin-paths"], {
      cwd: root,
      input: files.join("\n") + "\n",
      encoding: "utf8",
      maxBuffer: 8 * 1024 * 1024,
    })
      .trim()
      .split(/\r?\n/);
    assert.equal(hashes.length, entries.length);
    for (const [index, entry] of entries.entries()) {
      const [metadata, file] = entry.split("\t");
      assert.equal(hashes[index], metadata.split(" ")[2], file);
    }
  });
}

if (baselineRef) {
  test("unrelated November operations remain unchanged", () => {
    const file = path.relative(root, specFile).split(path.sep).join("/");
    const baseline = JSON.parse(git("show", `${baselineRef}:${file}`));
    for (const [route, methods] of Object.entries(baseline.paths)) {
      for (const [method, operation] of Object.entries(methods)) {
        if (
          collectionPaths.some(
            (collection) =>
              (route === collection && method === "get") ||
              (route === `${collection}/{connectionName}` &&
                ["get", "put", "patch"].includes(method)),
          )
        )
          continue;
        assert.deepEqual(
          spec.paths[route][method],
          operation,
          `${method} ${route}`,
        );
      }
    }
  });
}
