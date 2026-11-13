import { assert, test } from "vitest";
import { restContractIdentity, schemaPath } from "../scripts/assessment-display.ts";
import type { AssessmentFact, NormalizedSchema } from "../scripts/runtime-types.ts";

const entity: NormalizedSchema = {
  kind: "object",
  reference: "#/definitions/EntityInfo",
  properties: [],
};
const properties: NormalizedSchema = {
  kind: "object",
  reference: "#/definitions/CloudAccountProperties",
  properties: [{ name: "backupAdminOnCcaCreate", required: false, schema: entity }],
};
const root: NormalizedSchema = {
  kind: "object",
  reference: "#/definitions/CloudAccount",
  properties: [{ name: "properties", required: false, schema: properties }],
};
function finding(
  rule: string,
  schema = root,
  location = "request body.properties.backupAdminOnCcaCreate",
) {
  const fact: AssessmentFact = { comparisonRole: "baseline", request: { kind: "body", schema } };
  return {
    rule,
    contractChange: { location },
    operationIds: ["CloudAccounts_CreateOrUpdate"],
    evidence: [fact],
  };
}
for (const rule of [
  "serialized-property-removed",
  "property-required",
  "required-property-added",
  "wire-type-changed",
  "nullable-restricted",
]) {
  test(`${rule} belongs to the declaring model, not its referenced property type`, () => {
    assert.equal(restContractIdentity(finding(rule)), "CloudAccountProperties");
  });
}
test("value resolution still returns EntityInfo for Before/After display", () => {
  const resolved = schemaPath(root, ["properties", "backupAdminOnCcaCreate"]);
  assert.equal(resolved.identity, "EntityInfo");
  assert.equal(resolved.ownerIdentity, "CloudAccountProperties");
  assert.equal(resolved.memberName, "backupAdminOnCcaCreate");
});
test("nested arrays retain the named declaring element model", () => {
  const schema: NormalizedSchema = {
    kind: "object",
    reference: "#/definitions/Request",
    properties: [
      { name: "accounts", required: false, schema: { kind: "array", items: properties } },
    ],
  };
  assert.equal(
    restContractIdentity(
      finding(
        "serialized-property-removed",
        schema,
        "request body.accounts[].backupAdminOnCcaCreate",
      ),
    ),
    "CloudAccountProperties",
  );
});
test("enum definition changes still belong to the referenced enum", () => {
  const schema: NormalizedSchema = {
    kind: "object",
    reference: "#/definitions/Account",
    properties: [
      {
        name: "status",
        required: false,
        schema: { kind: "enum", reference: "#/definitions/Status", values: ["active"] },
      },
    ],
  };
  assert.equal(
    restContractIdentity(finding("enum-values-removed", schema, "request body.status")),
    "Status",
  );
});
test("response member changes use the same owner semantics", () => {
  const value = finding("serialized-property-removed");
  value.contractChange.location = "response 200.properties.backupAdminOnCcaCreate";
  value.evidence = [{ comparisonRole: "baseline", responses: [{ status: "200", schema: root }] }];
  assert.equal(restContractIdentity(value), "CloudAccountProperties");
});
test("direct operation changes retain operation identity", () => {
  assert.equal(
    restContractIdentity(finding("path-changed", root, "path")),
    "CloudAccounts_CreateOrUpdate",
  );
});
