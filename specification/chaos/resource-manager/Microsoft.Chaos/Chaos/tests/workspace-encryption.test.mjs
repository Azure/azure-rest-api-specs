import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import test from "node:test";

const root = fileURLToPath(new URL("../", import.meta.url));
const readJson = (name) =>
  JSON.parse(readFileSync(path.join(root, name), "utf8"));
const spec = readJson("stable/2026-11-01/openapi.json");
const definitions = spec.definitions;
const fullEncryption = definitions.WorkspaceProperties.properties.encryption;
const resolve = (schema) =>
  schema.$ref?.startsWith("#/definitions/")
    ? definitions[schema.$ref.split("/").at(-1)]
    : schema;
const patchEncryption = resolve(
  definitions.WorkspaceUpdateProperties.properties.encryption,
);
const patchKeyProperties = resolve(
  patchEncryption.properties.keyVaultProperties,
);
const workspacePath =
  "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}";
const example = (name) => readJson(`examples/2026-11-01/${name}.json`);

function visitLocalSchemas(schema, visitor, seen = new Set()) {
  visitor(schema);
  if (schema.$ref?.startsWith("#/definitions/") && !seen.has(schema.$ref)) {
    seen.add(schema.$ref);
    visitLocalSchemas(
      definitions[schema.$ref.split("/").at(-1)],
      visitor,
      seen,
    );
  }
  for (const child of Object.values(schema.properties ?? {})) {
    visitLocalSchemas(child, visitor, seen);
  }
  for (const child of schema.allOf ?? [])
    visitLocalSchemas(child, visitor, seen);
  if (schema.items) visitLocalSchemas(schema.items, visitor, seen);
}

test("full encryption has a static PUT default, required input, and no nullable fields", () => {
  assert.deepEqual(
    definitions.WorkspaceProperties.properties.encryption.default,
    {
      keySource: "Microsoft.Storage",
    },
  );
  assert.ok(!definitions.WorkspaceProperties.required.includes("encryption"));
  assert.deepEqual(fullEncryption.required, ["keySource"]);
  assert.deepEqual(definitions.WorkspaceEncryptionKeyVaultProperties.required, [
    "keyUri",
  ]);
  visitLocalSchemas(fullEncryption, (schema) => {
    assert.notEqual(schema["x-nullable"], true);
    assert.notEqual(schema["x-ms-nullable"], true);
  });
  assert.deepEqual(definitions.WorkspaceEncryptionKeySource.enum, [
    "Microsoft.Keyvault",
    "Microsoft.Storage",
  ]);
});

test("PATCH deletion is request-only, optional, and default-free at every new level", () => {
  assert.equal(
    definitions.WorkspaceUpdate.properties.properties.$ref,
    "#/definitions/WorkspaceUpdateProperties",
  );
  visitLocalSchemas(definitions.WorkspaceUpdateProperties, (schema) => {
    assert.equal(schema.required, undefined);
    assert.equal(schema.default, undefined);
    assert.notDeepEqual(schema["x-ms-mutability"], ["create"]);
  });
  for (const [model, field] of [
    [definitions.WorkspaceUpdateProperties, "encryption"],
    [patchEncryption, "keySource"],
    [patchEncryption, "keyVaultProperties"],
    [patchKeyProperties, "keyUri"],
  ]) {
    assert.equal(
      model.properties[field]["x-nullable"],
      true,
      `${model}.${field}`,
    );
  }
  assert.deepEqual(Object.keys(patchEncryption.properties), [
    "keySource",
    "keyVaultProperties",
  ]);
});

test("service observations and consent identity are read-only without a second provisioning state", () => {
  for (const field of ["identity", "status"]) {
    assert.equal(fullEncryption.properties[field].readOnly, true);
  }
  for (const model of [
    "WorkspaceEncryptionIdentity",
    "WorkspaceEncryptionStatus",
  ]) {
    for (const field of Object.values(definitions[model].properties)) {
      assert.equal(field.readOnly, true);
    }
  }
  assert.deepEqual(Object.keys(fullEncryption.properties), [
    "keySource",
    "keyVaultProperties",
    "identity",
    "status",
  ]);
  assert.deepEqual(
    Object.keys(definitions.WorkspaceEncryptionStatus.properties),
    ["state", "observedKeySource", "observedKeyUri", "lastCheckedAt", "error"],
  );
  assert.deepEqual(definitions.WorkspaceEncryptionState.enum, [
    "NotConfigured",
    "Pending",
    "Applied",
    "Failed",
    "Unknown",
  ]);
  assert.match(
    definitions.WorkspaceEncryptionStatus.properties.error.$ref,
    /\/v5\/types.json#\/definitions\/ErrorDetail$/,
  );
});

test("key URI schema rejects a version, query, fragment, and non-HTTPS URI", () => {
  const schema = definitions.WorkspaceEncryptionKeyUri;
  assert.equal(schema.format, "uri");
  const pattern = new RegExp(schema.pattern);
  const uri = "https://contoso-vault.vault.azure.net/keys/workspace-key";
  assert.ok(pattern.test(uri));
  for (const invalid of [
    `${uri}/0123456789abcdef`,
    `${uri}?version=latest`,
    `${uri}#key`,
    uri.replace("https:", "http:"),
    uri.replace("/keys/", "/secrets/"),
  ]) {
    assert.ok(!pattern.test(invalid), invalid);
  }
});

test("examples distinguish replacement, omission, null deletion, and URI-only PATCH", () => {
  const put = example("Workspaces_CreateOrUpdate_OmitEncryption");
  assert.equal(put.parameters.resource.properties.encryption, undefined);
  assert.equal(
    put.responses["200"].body.properties.encryption.keySource,
    "Microsoft.Storage",
  );
  const patch = example("Workspaces_Update_OmitEncryption");
  assert.equal(patch.parameters.properties.properties, undefined);
  assert.equal(
    patch.responses["200"].body.properties.encryption.keySource,
    "Microsoft.Keyvault",
  );
  assert.equal(
    example("Workspaces_Update_RemoveCustomerKey").parameters.properties
      .properties.encryption,
    null,
  );
  const replacement = example("Workspaces_Update_ReplaceCustomerKey");
  assert.deepEqual(
    Object.keys(replacement.parameters.properties.properties.encryption),
    ["keyVaultProperties"],
  );
  const failed = example("Workspaces_Get_EncryptionFailed").responses["200"]
    .body.properties.encryption;
  assert.notEqual(
    failed.status.observedKeyUri.split("/").at(-2),
    failed.keyVaultProperties.keyUri.split("/").at(-1),
  );
  assert.equal(failed.status.error.code, "CustomerKeyAccessFailed");
});

test("Workspace LROs retain their existing routes and response shapes", () => {
  const operations = spec.paths[workspacePath];
  assert.equal(operations.put["x-ms-long-running-operation"], true);
  assert.equal(operations.patch["x-ms-long-running-operation"], true);
  for (const [verb, status] of [
    ["get", "200"],
    ["put", "200"],
    ["put", "201"],
    ["patch", "200"],
  ]) {
    assert.equal(
      operations[verb].responses[status].schema.$ref,
      "#/definitions/Workspace",
    );
  }
  assert.equal(operations.patch.responses["202"].schema, undefined);
  for (const name of [
    "Workspaces_Update_EnableCustomerKey",
    "Workspaces_Update_ReplaceCustomerKey",
    "Workspaces_Update_RemoveCustomerKey",
    "Workspaces_Update_ReenableCustomerKey",
  ]) {
    const responses = example(name).responses;
    assert.equal(responses["202"].body, undefined);
    assert.match(
      responses["202"].headers.Location,
      /^https:\/\/management.azure.com\/.*api-version=2026-11-01$/,
    );
    assert.equal(
      responses["200"].body.properties.provisioningState,
      "Succeeded",
    );
  }
});

test("new encryption types and properties are absent from all earlier generated versions", () => {
  for (const file of [
    "stable/2025-01-01/openapi.json",
    "preview/2026-05-01-preview/openapi.json",
    "preview/2026-08-01-preview/openapi.json",
  ]) {
    const previous = readJson(file);
    assert.ok(
      !Object.keys(previous.definitions).some((name) =>
        name.startsWith("WorkspaceEncryption"),
      ),
    );
    assert.equal(
      previous.definitions.WorkspaceProperties?.properties.encryption,
      undefined,
    );
    assert.equal(
      previous.definitions.WorkspaceUpdate?.properties.properties,
      undefined,
    );
  }
});

test("source and generated examples match and each example has exactly one operation reference", () => {
  const references = Object.values(spec.paths).flatMap((item) =>
    Object.values(item).flatMap((operation) =>
      Object.values(operation["x-ms-examples"] ?? {}).map(
        (entry) => entry.$ref,
      ),
    ),
  );
  for (const name of readdirSync(path.join(root, "examples/2026-11-01"))) {
    const source = readFileSync(path.join(root, "examples/2026-11-01", name));
    assert.deepEqual(
      source,
      readFileSync(path.join(root, "stable/2026-11-01/examples", name)),
    );
    assert.equal(
      references.filter((ref) => ref === `./examples/${name}`).length,
      1,
      name,
    );
  }
});

test(
  "stack-base comparison preserves all earlier output and adds no routes",
  {
    skip: !process.env.CHAOS_CONTRACT_BASE_REF,
  },
  () => {
    const ref = process.env.CHAOS_CONTRACT_BASE_REF;
    const repo = execFileSync("git", ["rev-parse", "--show-toplevel"], {
      cwd: root,
      encoding: "utf8",
    }).trim();
    const relative = path.relative(repo, root).split(path.sep).join("/");
    const files = execFileSync(
      "git",
      ["ls-tree", "-r", "--name-only", ref, "--", relative],
      { cwd: repo, encoding: "utf8" },
    )
      .trim()
      .split("\n");
    for (const file of files.filter(
      (file) =>
        /\/(?:preview|stable|examples)\/\d{4}-/.test(file) &&
        !file.includes("/2026-11-01/"),
    )) {
      assert.deepEqual(
        readFileSync(path.join(repo, file)),
        execFileSync("git", ["show", `${ref}:${file}`], {
          cwd: repo,
          maxBuffer: 20 * 1024 * 1024,
        }),
        file,
      );
    }
    const baseline = JSON.parse(
      execFileSync(
        "git",
        ["show", `${ref}:${relative}/stable/2026-11-01/openapi.json`],
        { cwd: repo, maxBuffer: 20 * 1024 * 1024, encoding: "utf8" },
      ),
    );
    assert.deepEqual(Object.keys(spec.paths), Object.keys(baseline.paths));
    for (const route of Object.keys(baseline.paths)) {
      assert.deepEqual(
        Object.keys(spec.paths[route]),
        Object.keys(baseline.paths[route]),
        route,
      );
    }
  },
);
