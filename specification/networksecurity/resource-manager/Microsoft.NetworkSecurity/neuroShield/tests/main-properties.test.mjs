import assert from "node:assert/strict";
import test from "node:test";
import { loadVersion, versions } from "./helpers.mjs";

const api = loadVersion(versions[0]);
const schema = (model, field) =>
  api.property(api.swagger.definitions[model], field).schema;

test("PUT requires Auto/Manual responseMode without a default; PATCH remains optional", () => {
  const properties = api.swagger.definitions.NeuroShieldProperties;
  const patch = api.swagger.definitions.NeuroShieldPatchProperties;
  assert.deepEqual(properties.required, ["responseMode"]);
  assert.equal(patch.required, undefined);
  assert.deepEqual(api.swagger.definitions.NeuroShieldResponseMode.enum, [
    "Auto",
    "Manual",
  ]);
  assert.equal(
    api.swagger.definitions.NeuroShieldResponseMode["x-ms-enum"].modelAsString,
    true,
  );
  for (const model of ["NeuroShieldProperties", "NeuroShieldPatchProperties"]) {
    for (const field of ["responseMode", "severityThreshold", "description"]) {
      assert.equal(schema(model, field).default, undefined);
    }
  }
});

test("omission examples distinguish documented PUT defaults from PATCH preservation", () => {
  const put = api.example(
    "NeuroShields_CreateOrUpdate_OmittedOptionalProperties",
  );
  assert.equal(put.parameters.resource.properties.responseMode, "Manual");
  for (const field of ["severityThreshold", "description"]) {
    assert.equal(
      Object.hasOwn(put.parameters.resource.properties, field),
      false,
    );
  }
  for (const response of Object.values(put.responses)) {
    assert.equal(response.body.properties.responseMode, "Manual");
    assert.equal(response.body.properties.severityThreshold, "Low");
    assert.equal(response.body.properties.description, "");
    assert.deepEqual(response.body.tags, {});
  }
  const patch = api.example("NeuroShields_Update_OmittedProperties");
  assert.deepEqual(patch.parameters.properties.tags, {});
  assert.equal(Object.hasOwn(patch.parameters.properties, "properties"), false);
  assert.equal(patch.responses["200"].body.properties.responseMode, "Auto");
  assert.equal(
    patch.responses["200"].body.properties.severityThreshold,
    "High",
  );
  assert.equal(
    patch.responses["200"].body.properties.description,
    "Updated NeuroShield resource",
  );
});

test("description and PATCH tag constraints preserve Unicode and only permitted controls", () => {
  for (const model of ["NeuroShieldProperties", "NeuroShieldPatchProperties"]) {
    const description = schema(model, "description");
    assert.equal(description.maxLength, 512);
    const pattern = new RegExp(description.pattern);
    for (const valid of ["", "Café 日本語", "line\nnext", "tab\tvalue", "\r"]) {
      assert.ok(pattern.test(valid));
    }
    for (let code = 0; code <= 159; code++) {
      const control = code <= 31 || (code >= 127 && code <= 159);
      const permitted = [9, 10, 13].includes(code);
      assert.equal(
        pattern.test(String.fromCharCode(code)),
        !control || permitted,
      );
    }
  }
  const tags = schema("NeuroShieldPatch", "tags");
  const tag = api.dereference(tags.additionalProperties).schema;
  assert.equal(tag.maxLength, 256);
  assert.equal(
    tag.pattern,
    schema("NeuroShieldProperties", "description").pattern,
  );
  const fullPutTags = schema("NeuroShieldResource", "tags");
  assert.equal(fullPutTags.additionalProperties.$ref, undefined);
});

test("service GUID fields use canonical strings rather than UUID format metadata", () => {
  for (const [model, field] of [
    ["NeuroShieldProperties", "resourceGuid"],
    ["NeuroShieldInventoryUploadRequestMetadata", "requestId"],
    ["NeuroShieldInventoryUploadRequestResult", "requestId"],
  ]) {
    const value = schema(model, field);
    assert.equal(value.type, "string");
    assert.equal(value.format, undefined);
    const pattern = new RegExp(value.pattern);
    assert.ok(pattern.test("ABCDEF12-ABCD-1234-0000-ABCDEF123456"));
    for (const invalid of [
      "urn:uuid:abcdef12-abcd-1234-0000-abcdef123456",
      "{abcdef12-abcd-1234-0000-abcdef123456}",
      "abcdef12abcd12340000abcdef123456",
      "not-a-guid",
    ]) {
      assert.equal(pattern.test(invalid), false);
    }
  }
});

test("optional outputs are non-nullable without weakening required response properties", () => {
  for (const [model, fields] of Object.entries({
    NeuroShieldProperties: [
      "provisioningState",
      "resourceGuid",
      "severityThreshold",
      "description",
    ],
    NeuroShieldPatch: ["tags", "properties"],
    NeuroShieldPatchProperties: [
      "responseMode",
      "severityThreshold",
      "description",
    ],
    NeuroShieldProtectedResourceProperties: [
      "provisioningState",
      "agentHealth",
      "inventoryUploadRequest",
      "targetIdentity",
    ],
    NeuroShieldAgentHealth: ["lastSeenTime"],
    NeuroShieldFindingProperties: ["detectedTime"],
    NeuroShieldMitigationProperties: ["statusDetails", "appliedTime"],
    NeuroShieldResourceListResult: ["nextLink"],
    NeuroShieldProtectedResourceListResult: ["nextLink"],
    NeuroShieldFindingListResult: ["nextLink"],
    NeuroShieldMitigationListResult: ["nextLink"],
    NeuroShieldSummaryListResult: ["nextLink"],
  })) {
    const definition = api.swagger.definitions[model];
    for (const field of fields) {
      assert.ok(!definition.required?.includes(field), `${model}.${field}`);
      assert.notEqual(schema(model, field)["x-nullable"], true);
    }
  }
  for (const model of ["NeuroShieldFinding", "NeuroShieldMitigation"]) {
    assert.deepEqual(api.swagger.definitions[model].required, ["properties"]);
  }
  for (const model of [
    "NeuroShieldResourceListResult",
    "NeuroShieldFindingListResult",
    "NeuroShieldMitigationListResult",
    "NeuroShieldProtectedResourceListResult",
  ]) {
    assert.deepEqual(api.swagger.definitions[model].required, ["value"]);
  }
  assert.ok(
    api.swagger.definitions.NeuroShieldFindingProperties.required.includes(
      "reason",
    ),
  );
  assert.equal(schema("NeuroShieldMitigationProperties", "score").minimum, 0);
  assert.equal(schema("NeuroShieldMitigationProperties", "score").maximum, 100);
});
