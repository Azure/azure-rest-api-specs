import assert from "node:assert/strict";
import { readFileSync, readdirSync } from "node:fs";
import { resolve } from "node:path";
import test from "node:test";
import { loadVersion, project, versions } from "./helpers.mjs";

const api = loadVersion(versions[0]);
const resource = api.swagger.definitions.NeuroShieldProtectedResource;
const properties = api.property(resource, "properties");
const identity = api.property(
  properties.schema,
  "targetIdentity",
  properties.file,
);

function createReadable(value) {
  assert.ok(value);
  assert.notEqual(value.schema.readOnly, true);
  assert.deepEqual(value.schema["x-ms-mutability"], ["read", "create"]);
}

test("target identity exists only in optional properties.targetIdentity", () => {
  for (const field of [
    "identity",
    "legacyIdentity",
    "targetIdentity",
    "principalId",
    "tenantId",
    "clientId",
    "userAssignedIdentities",
  ]) {
    assert.equal(api.property(resource, field), undefined);
  }
  assert.equal(
    api.property(properties.schema, "identity", properties.file),
    undefined,
  );
  assert.ok(!properties.schema.required?.includes("targetIdentity"));
  createReadable(identity);
  assert.deepEqual(identity.schema.required, ["type"]);
  assert.equal(identity.schema["x-nullable"], undefined);
  const type = api.property(identity.schema, "type", identity.file).schema;
  for (const kind of ["None", "SystemAssigned", "UserAssigned"]) {
    assert.ok(type.enum.includes(kind));
  }
  assert.equal(type.default, undefined);
});

test("applicable nested identity IDs are create/read GUID strings, not read-only or nullable", () => {
  const assigned = api.property(
    identity.schema,
    "userAssignedIdentities",
    identity.file,
  );
  assert.equal(assigned.schema.type, "object");
  assert.equal(assigned.schema.minProperties, undefined);
  assert.equal(assigned.schema.maxProperties, undefined);
  const entry = api.dereference(
    assigned.schema.additionalProperties,
    assigned.file,
  );
  assert.equal(entry.schema.type, "object");
  assert.equal(entry.schema["x-nullable"], undefined);
  assert.equal(entry.schema.required, undefined);
  for (const [owner, field] of [
    [identity, "principalId"],
    [identity, "tenantId"],
    [entry, "principalId"],
    [entry, "clientId"],
  ]) {
    const value = api.property(owner.schema, field, owner.file);
    createReadable(value);
    assert.equal(value.schema.type, "string");
    assert.equal(value.schema.format, undefined);
    assert.equal(value.schema["x-nullable"], undefined);
    const pattern = new RegExp(value.schema.pattern);
    for (const valid of [
      "11111111-1111-1111-1111-111111111111",
      "ABCDEF12-ABCD-1234-0000-ABCDEF123456",
      "00000000-0000-0000-0000-000000000000",
    ]) {
      assert.ok(pattern.test(valid));
    }
    for (const invalid of [
      "",
      "not-a-guid",
      "11111111111111111111111111111111",
      "{11111111-1111-1111-1111-111111111111}",
      "urn:uuid:11111111-1111-1111-1111-111111111111",
      null,
    ]) {
      assert.equal(pattern.test(invalid), false);
    }
  }
});

test("conditional identity requirements remain documented service rules", () => {
  assert.match(identity.schema.description, /SystemAssigned requires nonzero/);
  assert.match(identity.schema.description, /exactly one non-null dictionary/);
  assert.match(identity.schema.description, /Omission on update preserves/);
  assert.match(identity.schema.description, /Explicit None cannot clear/);
  assert.match(identity.schema.description, /service-side verification/);
  assert.ok(!identity.schema.required.includes("principalId"));
  assert.ok(!identity.schema.required.includes("tenantId"));
});

test("PUT request, responses, GET and list consume the same required properties envelope", () => {
  const operation = (id) => {
    const result = api.operations.find((op) => op.operationId === id);
    assert.ok(result);
    return result;
  };
  const put = operation("NeuroShieldProtectedResources_CreateOrUpdate");
  const body = put.parameters
    .map((p) => api.dereference(p).schema)
    .find((p) => p.in === "body");
  assert.equal(body.required, true);
  assert.equal(body.schema.$ref, "#/definitions/NeuroShieldProtectedResource");
  for (const [op, status] of [
    [put, "200"],
    [put, "201"],
    [operation("NeuroShieldProtectedResources_Get"), "200"],
  ]) {
    assert.equal(op.responses[status].schema.$ref, body.schema.$ref);
  }
  const list = api.dereference(
    operation("NeuroShieldProtectedResources_List").responses["200"].schema,
  ).schema;
  assert.equal(list.properties.value.items.$ref, body.schema.$ref);
  assert.deepEqual(resource.required, ["properties"]);
  assert.ok(properties.schema.required.includes("targetResourceId"));
});

test("examples cover user/system assigned, explicit None and omitted identities without aliases", () => {
  const names = [
    "NeuroShieldProtectedResources_CreateOrUpdate",
    "NeuroShieldProtectedResources_CreateOrUpdate_SystemAssigned",
    "NeuroShieldProtectedResources_CreateOrUpdate_NoneIdentity",
    "NeuroShieldProtectedResources_CreateOrUpdate_WithoutIdentity",
  ];
  const seen = new Set();
  for (const name of names) {
    const example = api.example(name);
    const target = example.parameters.resource.properties.targetIdentity;
    seen.add(target?.type ?? "omitted");
    if (target?.type === "SystemAssigned") {
      assert.ok(target.principalId);
      assert.ok(target.tenantId);
      assert.equal(target.userAssignedIdentities, undefined);
    }
    if (target?.type === "UserAssigned") {
      assert.equal(target.principalId, undefined);
      assert.equal(target.tenantId, undefined);
      const entries = Object.values(target.userAssignedIdentities);
      assert.equal(entries.length, 1);
      assert.ok(entries[0].principalId);
      assert.ok(entries[0].clientId);
    }
  }
  assert.deepEqual(
    [...seen].sort(),
    ["None", "SystemAssigned", "UserAssigned", "omitted"].sort(),
  );
  for (const file of readdirSync(resolve(project, "examples", versions[0]))) {
    if (!file.startsWith("NeuroShieldProtectedResources_")) continue;
    const example = api.example(file.slice(0, -".json".length));
    const values = [];
    if (example.parameters.resource) values.push(example.parameters.resource);
    for (const response of Object.values(example.responses)) {
      if (response.body?.properties) values.push(response.body);
      if (response.body?.value) values.push(...response.body.value);
    }
    for (const value of values) {
      for (const field of ["identity", "legacyIdentity", "targetIdentity"]) {
        assert.equal(Object.hasOwn(value, field), false);
      }
      assert.equal(Object.hasOwn(value.properties, "identity"), false);
    }
  }
});

test("no obsolete identity-envelope or private-helper suppression returns", () => {
  const source = readFileSync(resolve(project, "models.tsp"), "utf8");
  assert.doesNotMatch(
    source,
    /arm-resource-invalid-envelope-property|legacyIdentity/,
  );
  assert.match(
    source,
    /@visibility\(Lifecycle\.Create, Lifecycle\.Read\)\s+targetIdentity\?: NeuroShieldProtectedResourceIdentity/,
  );
  assert.equal((source.match(/#suppress/g) ?? []).length, 3);
  assert.equal(
    (
      source.match(
        /#suppress "@azure-tools\/typespec-azure-resource-manager\/arm-resource-provisioning-state"/g,
      ) ?? []
    ).length,
    3,
  );
});
