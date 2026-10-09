import assert from "node:assert/strict";
import test from "node:test";
import {
  diffPublicParameters,
  publicParameterContract,
  semanticLroContract,
} from "./sdk-method-delta.mjs";

/**
 * @typedef {{kind: string, name?: string, crossLanguageDefinitionId?: string, valueType?: SdkType, keyType?: SdkType}} SdkType
 * @typedef {{name: string, type: SdkType, optional: boolean, onClient: boolean, isApiVersionParam: boolean}} SdkParameter
 */

/** @param {string} name @param {string} type @param {boolean} [optional] @returns {SdkParameter} */
const parameter = (name, type, optional = false) => ({
  name,
  type: { kind: type },
  optional,
  onClient: false,
  isApiVersionParam: false,
});

void test("diffs added, removed, modified, and relatively reordered parameters", () => {
  const changes = diffPublicParameters(
    [
      parameter("removed", "string"),
      parameter("modified", "string"),
      parameter("first", "string"),
      parameter("second", "string"),
      parameter("unchanged", "string"),
    ],
    [
      parameter("modified", "boolean", true),
      parameter("second", "string"),
      parameter("first", "string"),
      parameter("unchanged", "string"),
      parameter("added", "boolean", true),
    ],
  );

  assert.deepEqual(
    changes.added.map((item) => item.parameter.name),
    ["added"],
  );
  assert.deepEqual(
    changes.removed.map((item) => item.parameter.name),
    ["removed"],
  );
  assert.deepEqual(changes.modified[0].changedFields, ["optional", "type"]);
  assert.deepEqual(
    changes.reordered.map((item) => item.name),
    ["second", "first"],
  );
  assert.equal(changes.unchangedCount, 1);
});

void test("does not treat URI-template-only metadata as an LRO behavior change", () => {
  const base = {
    finalStateVia: "azure-async-operation",
    operation: {
      kind: "http",
      path: "/policies/{name}",
      verb: "put",
      uriTemplate: "/policies/{name}?api-version",
    },
    logicalResult: { kind: "model", name: "FirewallPolicy" },
  };
  const current = {
    ...base,
    operation: {
      ...base.operation,
      uriTemplate: "/policies/{name}?api-version,afcManagedSync",
    },
  };

  assert.deepEqual(semanticLroContract(base), semanticLroContract(current));
});

void test("retains nested array and dictionary parameter type contracts", () => {
  /** @param {string} model @returns {SdkType} */
  const composite = (model) => ({
    kind: "array",
    valueType: {
      kind: "dictionary",
      keyType: { kind: "string" },
      valueType: {
        kind: "model",
        name: model,
        crossLanguageDefinitionId: `Contoso.${model}`,
      },
    },
  });
  const before = [{ ...parameter("items", "array"), type: composite("Widget") }];
  const after = [{ ...parameter("items", "array"), type: composite("Gadget") }];

  assert.deepEqual(publicParameterContract(before)[0].type, {
    kind: "array",
    valueType: {
      kind: "dictionary",
      keyType: "string",
      valueType: "Contoso.Widget",
    },
  });
  assert.deepEqual(diffPublicParameters(before, after).modified[0].changedFields, ["type"]);
});
