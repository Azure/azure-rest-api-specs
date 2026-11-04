import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";

const projectRoot = new URL("../", import.meta.url);
const readJson = (path) =>
  JSON.parse(readFileSync(new URL(path, projectRoot), "utf8"));
const schema = readJson("preview/2027-01-15-preview/hci.json");
const collectionPath =
  "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/edgeMachines/{edgeMachineName}/storagePools";
const resourcePath = `${collectionPath}/{storagePoolName}`;
const example = (name) =>
  readJson(`examples/2027-01-15-preview/EdgeMachineStoragePools_${name}.json`);

test("schema and examples target the 2027-01-15 preview", () => {
  assert.equal(schema.info.version, "2027-01-15-preview");
  for (const name of ["Get", "List", "List_Empty"]) {
    assert.equal(example(name).parameters["api-version"], schema.info.version);
  }
});

test("EdgeMachine storage pools expose only GET and LIST", () => {
  for (const path of [collectionPath, resourcePath]) {
    assert.deepEqual(Object.keys(schema.paths[path]), ["get"]);
    assert.ok(schema.paths[path].get.responses["200"]);
    assert.ok(schema.paths[path].get.responses.default);
  }
  assert.equal(
    schema.paths[resourcePath].get.responses["200"].schema.$ref,
    "#/definitions/EdgeMachineStoragePool",
  );
  assert.equal(
    schema.paths[collectionPath].get.responses["200"].schema.$ref,
    "#/definitions/EdgeMachineStoragePoolListResult",
  );
});

test("storage pool names allow only letters, digits, underscores, and hyphens", () => {
  const parameter = schema.paths[resourcePath].get.parameters.find(
    (parameter) => parameter.name === "storagePoolName",
  );
  assert.ok(parameter);
  assert.equal(parameter.pattern, "^[A-Za-z0-9_-]{3,63}$");
  const pattern = new RegExp(parameter.pattern);
  for (const name of ["abc", "A0_-", "a".repeat(63)]) {
    assert.ok(pattern.test(name), `storagePoolName should accept ${name}`);
  }
  for (const name of ["", "ab", "a".repeat(64)]) {
    assert.equal(pattern.test(name), false);
  }
  for (let code = 32; code <= 126; code += 1) {
    const character = String.fromCharCode(code);
    if (!/[A-Za-z0-9_-]/.test(character)) {
      assert.equal(pattern.test(`a${character}b`), false);
    }
  }
});

test("pool state is read-only with int64 sizes and no configuration placeholder", () => {
  for (const property of Object.values(
    schema.definitions.EdgeMachineStoragePoolProperties.properties,
  )) {
    assert.equal(property.readOnly, true);
  }
  assert.equal(
    Object.hasOwn(schema.definitions, "EdgeMachineStoragePoolConfiguration"),
    false,
  );
  assert.equal(
    Object.hasOwn(
      schema.definitions.EdgeMachineStoragePoolProperties.properties,
      "storagePoolConfiguration",
    ),
    false,
  );
  const reported =
    schema.definitions.EdgeMachineStoragePoolReportedProperties.properties;
  assert.deepEqual(Object.keys(reported).sort(), [
    "availableSizeInBytes",
    "name",
    "sizeInBytes",
  ]);
  for (const property of Object.values(reported)) {
    assert.equal(property.readOnly, true);
  }
  assert.deepEqual(
    schema.definitions.EdgeMachineStoragePoolReportedProperties.required ?? [],
    [],
  );
  for (const name of ["sizeInBytes", "availableSizeInBytes"]) {
    assert.equal(reported[name].type, "integer");
    assert.equal(reported[name].format, "int64");
    assert.equal(reported[name].readOnly, true);
  }
  assert.equal(
    Object.hasOwn(schema.definitions, "EdgeMachineStoragePoolState"),
    false,
  );
  assert.deepEqual(schema.definitions.EdgeMachineStoragePoolType.enum, [
    "LVM",
    "StorageSpaces",
  ]);
  assert.equal(
    schema.definitions.EdgeMachineStoragePoolType["x-ms-enum"].modelAsString,
    true,
  );
});

test("representative LVM resources serialize with the correct ARM identity", () => {
  const response = example("Get");
  const resource = response.responses["200"].body;
  assert.deepEqual(JSON.parse(JSON.stringify(resource)), resource);
  const parameters = response.parameters;
  assert.equal(
    resource.id,
    `/subscriptions/${parameters.subscriptionId}/resourceGroups/${parameters.resourceGroupName}/providers/Microsoft.AzureStackHCI/edgeMachines/${parameters.edgeMachineName}/storagePools/${parameters.storagePoolName}`,
  );
  assert.equal(resource.name, parameters.storagePoolName);
  assert.notEqual(resource.properties.reportedProperties.name, resource.name);
  assert.equal(
    resource.type,
    "Microsoft.AzureStackHCI/edgeMachines/storagePools",
  );
  assert.equal(resource.properties.poolType, "LVM");
  assert.equal(resource.properties.provisioningState, "Succeeded");
  assert.equal(
    Object.hasOwn(resource.properties, "storagePoolConfiguration"),
    false,
  );
  assert.ok(
    Number.isSafeInteger(resource.properties.reportedProperties.sizeInBytes),
  );
  assert.ok(
    Number.isSafeInteger(
      resource.properties.reportedProperties.availableSizeInBytes,
    ),
  );
});

test("reported capacity is consistent and removed properties are absent", () => {
  const response = example("Get");
  const reported = response.responses["200"].body.properties.reportedProperties;
  assert.equal(Object.hasOwn(reported, "allocatedSizeInBytes"), false);
  assert.ok(reported.availableSizeInBytes <= reported.sizeInBytes);
  assert.equal(Object.hasOwn(reported, "isSystemPool"), false);
  assert.equal(Object.hasOwn(reported, "state"), false);
  assert.equal(Object.hasOwn(reported, "id"), false);
  assert.equal(Object.hasOwn(reported, "uniqueId"), false);
  assert.equal(Object.hasOwn(reported, "memberDiskIds"), false);
});

test("lists represent one LVM pool or an empty partition-based machine", () => {
  assert.deepEqual(example("List").responses["200"].body.value, [
    example("Get").responses["200"].body,
  ]);
  assert.deepEqual(example("List_Empty").responses["200"].body, {
    value: [],
  });
  assert.equal(
    Object.hasOwn(example("List").responses["200"].body, "nextLink"),
    false,
  );
  assert.equal(
    schema.definitions.EdgeMachineStoragePoolListResult.properties.nextLink
      .type,
    "string",
  );
  assert.notEqual(
    schema.definitions.EdgeMachineStoragePoolListResult.properties.nextLink[
      "x-nullable"
    ],
    true,
  );
  assert.equal(
    (
      schema.definitions.EdgeMachineStoragePoolListResult.required ?? []
    ).includes("nextLink"),
    false,
  );
  assert.equal(
    schema.paths[collectionPath].get["x-ms-pageable"].nextLinkName,
    "nextLink",
  );
});

test("read operations use the standard ARM default error response", () => {
  for (const path of [collectionPath, resourcePath]) {
    const responses = schema.paths[path].get.responses;
    assert.deepEqual(Object.keys(responses).sort(), ["200", "default"]);
    assert.match(
      responses.default.schema.$ref,
      /#\/definitions\/ErrorResponse$/,
    );
  }
});
