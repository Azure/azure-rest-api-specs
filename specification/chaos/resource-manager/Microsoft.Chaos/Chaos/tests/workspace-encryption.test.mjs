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
const resolve = (schema) =>
  schema.$ref?.startsWith("#/definitions/")
    ? definitions[schema.$ref.split("/").at(-1)]
    : schema;
const fullEncryption = resolve(
  definitions.WorkspaceProperties.properties.encryption,
);
const fullCustomerKey = resolve(
  fullEncryption.properties.customerManagedKeyEncryption,
);
const patchEncryption = resolve(
  definitions.WorkspaceUpdateProperties.properties.encryption,
);
const patchKeyProperties = resolve(
  patchEncryption.properties.customerManagedKeyEncryption,
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

test("full encryption defaults to absent CMK, requires the URL and vault ID pair, and is non-nullable", () => {
  assert.equal(
    definitions.WorkspaceProperties.properties.encryption.default,
    undefined,
  );
  assert.ok(!definitions.WorkspaceProperties.required.includes("encryption"));
  assert.equal(fullEncryption.required, undefined);
  assert.deepEqual(fullCustomerKey.required, [
    "keyEncryptionKeyUrl",
    "keyVaultResourceId",
  ]);
  visitLocalSchemas(fullEncryption, (schema) => {
    assert.notEqual(schema["x-nullable"], true);
    assert.notEqual(schema["x-ms-nullable"], true);
    assert.equal(schema.default, undefined);
  });
  assert.deepEqual(Object.keys(fullCustomerKey.properties), [
    "keyEncryptionKeyUrl",
    "keyVaultResourceId",
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
    [patchEncryption, "customerManagedKeyEncryption"],
    [patchKeyProperties, "keyEncryptionKeyUrl"],
    [patchKeyProperties, "keyVaultResourceId"],
  ]) {
    assert.equal(
      model.properties[field]["x-nullable"],
      true,
      `${model}.${field}`,
    );
  }
  assert.deepEqual(Object.keys(patchEncryption.properties), [
    "customerManagedKeyEncryption",
  ]);
});

test("vault references carry the same constrained ARM-ID type in full and partial models", () => {
  for (const field of [
    fullCustomerKey.properties.keyVaultResourceId,
    patchKeyProperties.properties.keyVaultResourceId,
  ]) {
    assert.equal(field.type, "string");
    assert.equal(field.format, "arm-id");
    assert.deepEqual(field["x-ms-arm-id-details"], {
      allowedResources: [{ type: "Microsoft.KeyVault/vaults" }],
    });
    assert.notEqual(field.readOnly, true);
    assert.equal(field.default, undefined);
  }
  assert.deepEqual(Object.keys(patchKeyProperties.properties), [
    "keyEncryptionKeyUrl",
    "keyVaultResourceId",
  ]);
});

test("all full CMK examples contain a coherent vault reference and exact URL casing", () => {
  let pairs = 0;
  function check(value) {
    if (!value || typeof value !== "object") return;
    const key = value.customerManagedKeyEncryption;
    if (key) {
      assert.deepEqual(Object.keys(key).sort(), [
        "keyEncryptionKeyUrl",
        "keyVaultResourceId",
      ]);
      const match =
        /^\/subscriptions\/[0-9a-f-]{36}\/resourceGroups\/[a-z0-9-]+\/providers\/Microsoft\.KeyVault\/vaults\/([a-z0-9-]+)$/i.exec(
          key.keyVaultResourceId,
        );
      assert.ok(match, key.keyVaultResourceId);
      assert.equal(
        new URL(key.keyEncryptionKeyUrl).hostname,
        `${match[1].toLowerCase()}.vault.azure.net`,
      );
      pairs++;
    }
    for (const child of Object.values(value)) check(child);
  }
  for (const file of readdirSync(path.join(root, "examples/2026-11-01"))) {
    if (!file.startsWith("Workspaces_")) continue;
    const data = readJson(`examples/2026-11-01/${file}`);
    if (data.operationId === "Workspaces_CreateOrUpdate")
      check(data.parameters.resource);
    for (const response of Object.values(data.responses)) check(response.body);
  }
  assert.ok(pairs >= 10);
  const sameVault = example("Workspaces_Update_ReplaceCustomerKey");
  assert.deepEqual(
    Object.keys(
      sameVault.parameters.properties.properties.encryption
        .customerManagedKeyEncryption,
    ),
    ["keyEncryptionKeyUrl"],
  );
  assert.ok(
    sameVault.responses[
      "200"
    ].body.properties.encryption.customerManagedKeyEncryption.keyVaultResourceId.endsWith(
      "/contoso-vault",
    ),
  );
  const differentVault = example("Workspaces_Update_ChangeKeyVault");
  const request =
    differentVault.parameters.properties.properties.encryption
      .customerManagedKeyEncryption;
  assert.ok(request.keyVaultResourceId.endsWith("/contoso-vault-b"));
  assert.ok(request.keyEncryptionKeyUrl.endsWith("/Workspace-Key-Next"));
  assert.deepEqual(
    differentVault.responses["200"].body.properties.encryption
      .customerManagedKeyEncryption,
    request,
  );
});

test("accepted pending PUT and GET/LIST project validated pairs without inferring protection", () => {
  const created = example("Workspaces_CreateOrUpdate_WithCustomerKey")
    .responses["201"].body;
  assert.equal(created.properties.provisioningState, "Creating");
  assert.equal(created.properties.encryption.status.state, "Pending");
  assert.equal(
    created.properties.encryption.status.observedProtection,
    undefined,
  );
  assert.ok(
    created.properties.encryption.customerManagedKeyEncryption
      .keyVaultResourceId,
  );
  const pending = example("Workspaces_Get_EncryptionPending").responses["200"]
    .body;
  const listed = example("Workspaces_List_EncryptionPending").responses["200"]
    .body.value[0];
  assert.deepEqual(listed, pending);
  assert.equal(pending.properties.encryption.status.state, "Pending");
  assert.equal(
    pending.properties.encryption.status.observedProtection,
    "MicrosoftManaged",
  );
});

test("service observations and consent identity are read-only without a second provisioning state", () => {
  for (const field of ["customerManagedKeyOnboarding", "status"]) {
    assert.equal(fullEncryption.properties[field].readOnly, true);
  }
  for (const model of [
    "WorkspaceCustomerManagedKeyOnboarding",
    "WorkspaceEncryptionStatus",
  ]) {
    for (const field of Object.values(definitions[model].properties)) {
      assert.equal(field.readOnly, true);
    }
  }
  assert.deepEqual(Object.keys(fullEncryption.properties), [
    "customerManagedKeyEncryption",
    "customerManagedKeyOnboarding",
    "status",
  ]);
  assert.deepEqual(
    Object.keys(definitions.WorkspaceEncryptionStatus.properties),
    [
      "state",
      "observedProtection",
      "observedKeyEncryptionKeyUrl",
      "lastCheckedAt",
      "error",
    ],
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
  assert.deepEqual(definitions.WorkspaceEncryptionProtection.enum, [
    "CustomerManaged",
    "MicrosoftManaged",
  ]);
  const onboarding = example("Workspaces_Get_EncryptionNotConfigured")
    .responses["200"].body.properties.encryption;
  assert.equal(onboarding.customerManagedKeyEncryption, undefined);
  assert.equal(
    onboarding.customerManagedKeyOnboarding.applicationId,
    "00000000-0000-0000-0000-000000000001",
  );
});

test("key URI schema rejects a version, query, fragment, and non-HTTPS URI", () => {
  const schema = definitions.WorkspaceKeyEncryptionKeyUrl;
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

test("Key Vault URL shape supports Premium RSA-HSM names but excludes Managed HSM endpoints", () => {
  const pattern = new RegExp(definitions.WorkspaceKeyEncryptionKeyUrl.pattern);
  for (const keyName of ["workspace-rsa", "workspace-rsa-hsm", "HSM-key"]) {
    assert.ok(
      pattern.test(`https://contoso-premium.vault.azure.net/keys/${keyName}`),
    );
  }
  for (const host of [
    "contoso-hsm.managedhsm.azure.net",
    // cspell:ignore usgovcloudapi
    "contoso-hsm.managedhsm.usgovcloudapi.net",
    "contoso-hsm.managedhsm.azure.cn",
  ]) {
    assert.ok(!pattern.test(`https://${host}/keys/workspace-key`), host);
  }
  assert.match(
    fullCustomerKey.properties.keyEncryptionKeyUrl.description,
    /RSA-HSM keys in Premium Key Vault/,
  );
  assert.match(
    fullCustomerKey.properties.keyEncryptionKeyUrl.description,
    /Azure Managed HSM service is not supported/,
  );
  const readme = readFileSync(path.join(root, "readme.md"), "utf8");
  assert.ok(readme.includes('"code": "InvalidEncryptionConfiguration"'));
  assert.ok(
    readme.includes(
      "Azure Managed HSM is not supported. Use Azure Key Vault; RSA-HSM keys in Premium Key Vault are supported.",
    ),
  );
});

test("examples distinguish replacement, omission, null deletion, and URL-only PATCH", () => {
  const put = example("Workspaces_CreateOrUpdate_OmitEncryption");
  assert.equal(put.parameters.resource.properties.encryption, undefined);
  assert.equal(
    put.responses["200"].body.properties.encryption
      .customerManagedKeyEncryption,
    undefined,
  );
  assert.equal(
    put.responses["200"].body.properties.encryption.status.observedProtection,
    "CustomerManaged",
  );
  const patch = example("Workspaces_Update_OmitEncryption");
  assert.equal(patch.parameters.properties.properties, undefined);
  assert.equal(
    patch.responses["200"].body.properties.encryption
      .customerManagedKeyEncryption.keyEncryptionKeyUrl,
    "https://contoso-vault.vault.azure.net/keys/workspace-key",
  );
  assert.equal(
    example("Workspaces_Update_RemoveCustomerKey").parameters.properties
      .properties.encryption.customerManagedKeyEncryption,
    null,
  );
  const replacement = example("Workspaces_Update_ReplaceCustomerKey");
  assert.deepEqual(
    Object.keys(replacement.parameters.properties.properties.encryption),
    ["customerManagedKeyEncryption"],
  );
  const failed = example("Workspaces_Get_EncryptionFailed").responses["200"]
    .body.properties.encryption;
  assert.notEqual(
    failed.status.observedKeyEncryptionKeyUrl.split("/").at(-2),
    failed.customerManagedKeyEncryption.keyEncryptionKeyUrl.split("/").at(-1),
  );
  assert.equal(failed.status.error.code, "CustomerKeyAccessFailed");
  const removed = example("Workspaces_Update_RemoveCustomerKey").responses[
    "200"
  ].body.properties.encryption;
  assert.equal(removed.customerManagedKeyEncryption, undefined);
  assert.equal(removed.status.observedProtection, "MicrosoftManaged");
  assert.equal(removed.status.observedKeyEncryptionKeyUrl, undefined);
  assert.ok(removed.customerManagedKeyOnboarding.applicationId);
});

test("no retired wire aliases or customer-selectable identity configuration remain", () => {
  const forbidden = [
    "keySource",
    "keyVaultProperties",
    "keyUri",
    "identity",
    "keyEncryptionKeyIdentity",
    "infrastructureEncryption",
    "observedKeySource",
    "observedKeyUri",
  ];
  for (const rootSchema of [fullEncryption, patchEncryption]) {
    visitLocalSchemas(rootSchema, (schema) => {
      for (const name of Object.keys(schema.properties ?? {}))
        assert.ok(!forbidden.includes(name), name);
    });
  }
});

test("empty PUT and nested deletion remove CMK while empty PATCH preserves an existing URL", () => {
  const emptyPut = example("Workspaces_CreateOrUpdate_EmptyEncryption");
  assert.deepEqual(emptyPut.parameters.resource.properties.encryption, {});
  assert.equal(
    emptyPut.responses["200"].body.properties.encryption
      .customerManagedKeyEncryption,
    undefined,
  );
  const wholeDelete = example("Workspaces_Update_RemoveEncryption");
  assert.equal(wholeDelete.parameters.properties.properties.encryption, null);
  assert.ok(
    wholeDelete.responses["200"].body.properties.encryption
      .customerManagedKeyOnboarding.applicationId,
  );
  const emptyPatch = example("Workspaces_Update_EmptyCustomerKeyPatch");
  assert.deepEqual(
    emptyPatch.parameters.properties.properties.encryption
      .customerManagedKeyEncryption,
    {},
  );
  assert.ok(
    emptyPatch.responses["200"].body.properties.encryption
      .customerManagedKeyEncryption.keyEncryptionKeyUrl,
  );
  assert.deepEqual(fullCustomerKey.required, [
    "keyEncryptionKeyUrl",
    "keyVaultResourceId",
  ]);
  assert.equal(patchKeyProperties.required, undefined);
});

test("unknown observations omit protection and key URL instead of inferring the desired value", () => {
  const encryption = example("Workspaces_Get_EncryptionUnknown").responses[
    "200"
  ].body.properties.encryption;
  assert.ok(encryption.customerManagedKeyEncryption.keyEncryptionKeyUrl);
  assert.equal(encryption.status.state, "Unknown");
  assert.equal(encryption.status.observedProtection, undefined);
  assert.equal(encryption.status.observedKeyEncryptionKeyUrl, undefined);
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
        /^(WorkspaceEncryption|WorkspaceCustomerManagedKey|WorkspaceKeyEncryptionKeyUrl)/.test(
          name,
        ),
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
