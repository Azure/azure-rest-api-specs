import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import {
  indexTcgcOperations,
  normalizeTcgcContract,
  normalizeTcgcPackage,
  parseTcgcYaml,
} from "./tcgc-contract.mjs";

/**
 * @template T
 * @param {T | null | undefined} value
 * @returns {T}
 */
function required(value) {
  assert.ok(value);
  return value;
}

/**
 * @param {unknown} value
 * @returns {value is Record<string, unknown>}
 */
function isRecord(value) {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

void test("reuses normalized TCGC artifacts while invalidating changed files and parser limits", (context) => {
  const root = fs.mkdtempSync(path.join(process.cwd(), ".tcgc-contract-cache-"));
  context.after(() => fs.rmSync(root, { recursive: true, force: true }));
  const artifact = { format: "tcgc-yaml", files: [{ path: "tcgc.yaml" }] };
  const file = path.join(root, "tcgc.yaml");
  const raw = { crossLanguagePackageId: "Example", crossLanguageVersion: "1.0", metadata: {} };
  fs.writeFileSync(file, JSON.stringify(raw));
  const read = context.mock.method(fs, "readFileSync");
  const options = { workRoot: root, artifact };
  const first = normalizeTcgcContract(options);
  assert.equal(normalizeTcgcContract(options), first);
  assert.equal(read.mock.callCount(), 1);
  assert.throws(() => normalizeTcgcContract({ ...options, maxObjects: 1 }), /resource limit/);
  raw.crossLanguagePackageId = "ChangedPackage";
  fs.writeFileSync(file, JSON.stringify(raw));
  const second = normalizeTcgcContract(options);
  assert.notEqual(second, first);
  assert.equal(second.package.crossLanguagePackageId, "ChangedPackage");
  const other = path.join(root, "other");
  fs.mkdirSync(other);
  fs.writeFileSync(path.join(other, "tcgc.yaml"), JSON.stringify(raw));
  assert.notEqual(normalizeTcgcContract({ ...options, workRoot: other }), second);
});

void test("indexes compiler identities once per normalized contract and selected version", () => {
  let scans = 0;
  const method = {
    crossLanguageDefinitionId: "Service.Owner.post",
    apiVersions: ["v1"],
    operation: { verb: "POST", path: "/one" },
  };
  const contract = {
    get methods() {
      scans += 1;
      return [
        method,
        { ...method, apiVersions: ["v2"], operation: { verb: "post", path: "/two" } },
      ];
    },
  };
  const normalizedContract = /** @type {import("./runtime-types.js").NormalizedTcgcContract} */ (
    /** @type {unknown} */ (contract)
  );
  const first = indexTcgcOperations(normalizedContract, "v1");
  assert.deepEqual(
    [...required(required(first.get("Owner.post")).get("Service.Owner.post"))],
    ["post\0/one"],
  );
  assert.equal(
    required(first.get("Owner.post")).get("Service.Owner.post"),
    required(first.get("post")).get("Service.Owner.post"),
  );
  assert.equal(
    required(first.get("Owner.post")).get("Service.Owner.post"),
    required(first.get("Service.Owner.post")).get("Service.Owner.post"),
  );
  for (let count = 0; count < 100; count += 1) {
    assert.equal(indexTcgcOperations(normalizedContract, "v1"), first);
    assert.equal(required(first.get("Owner.post")).size, 1);
  }
  assert.equal(scans, 1);
  const second = indexTcgcOperations(normalizedContract, "v2");
  assert.deepEqual(
    [...required(required(second.get("Owner.post")).get("Service.Owner.post"))],
    ["post\0/two"],
  );
  assert.equal(scans, 2);
});

void test("normalizes the TCGC graph with aliases, cycles, all method kinds, and separate bodyParam", () => {
  const root = parseTcgcYaml(`
crossLanguagePackageId: Contoso
crossLanguageVersion: "1.0"
metadata:
  apiVersions:
    Contoso: v2
  apiVersion: v1
clients:
  - &client
    kind: client
    name: Widgets
    crossLanguageDefinitionId: Contoso.Widgets
    methods:
      - &method
        kind: basic
        name: get
        access: public
        crossLanguageDefinitionId: Contoso.Widgets.get
        parameters:
          - kind: method
            name: id
            optional: false
            onClient: false
            type: { kind: string }
        operation:
          kind: http
          path: /widgets/{id}
          uriTemplate: /widgets/{id}
          verb: post
          parameters:
            - kind: path
              name: id
              type: { kind: string }
              methodParameterSegments:
                - [{ kind: method, name: id }]
              correspondingMethodParams:
                - { kind: method, name: oldId }
          bodyParam:
            kind: body
            name: body
            type:
              kind: dictionary
              keyType: { kind: string }
              valueType:
                kind: nullable
                type:
                  kind: array
                  valueType:
                    kind: tuple
                    valueTypes: [{ kind: string }, { kind: int32 }]
          responses:
            - statusCodes: { start: 200, end: 299 }
          exceptions:
            - statusCodes: "*"
      - <<: *method
        kind: paging
        name: list
        crossLanguageDefinitionId: Contoso.Widgets.list
        pagingMetadata:
          pageItemsSegments: [items]
          nextLinkVerb: get
      - <<: *method
        kind: lro
        name: begin
        crossLanguageDefinitionId: Contoso.Widgets.begin
        response:
          kind: method
          type: { kind: model, name: Widget, crossLanguageDefinitionId: Contoso.Widget }
        lroMetadata:
          finalStateVia: location
          pollingStep: { responseBody: { kind: string } }
          operation:
            kind: http
            path: /widgets/{id}
            uriTemplate: /widgets/{id}
            verb: post
          logicalResult: { kind: model, name: Widget, crossLanguageDefinitionId: Contoso.Widget }
          pollingInfo:
            kind: pollingOperationStep
            responseModel: { kind: model, name: Widget, crossLanguageDefinitionId: Contoso.Widget }
            terminationStatus: { kind: status-code }
          envelopeResult: { kind: model, name: Widget, crossLanguageDefinitionId: Contoso.Widget }
      - <<: *method
        kind: lropaging
        name: beginList
        crossLanguageDefinitionId: Contoso.Widgets.beginList
        pagingMetadata: { nextLinkSegments: [nextLink] }
        lroMetadata:
          finalStateVia: azure-async-operation
          pollingStep: { responseBody: { kind: string } }
          operation:
            kind: http
            path: /widgets/{id}
            uriTemplate: /widgets/{id}
            verb: post
          logicalResult: { kind: model, name: Widget, crossLanguageDefinitionId: Contoso.Widget }
          pollingInfo:
            kind: pollingOperationStep
            responseModel: { kind: model, name: Widget, crossLanguageDefinitionId: Contoso.Widget }
            terminationStatus: { kind: status-code }
          envelopeResult: { kind: model, name: Widget, crossLanguageDefinitionId: Contoso.Widget }
    children: []
models:
  - &widget
    kind: model
    name: Widget
    access: public
    usage: 3
    crossLanguageDefinitionId: Contoso.Widget
    discriminatorProperty: &kindProp
      kind: property
      name: kind
      serializedName: kind
      optional: false
      discriminator: true
      type: { kind: string }
    discriminatorValue: widget
    discriminatedSubtypes: {}
    properties:
      - *kindProp
      - kind: property
        name: child
        optional: true
        discriminator: false
        type: *widget
enums:
  - kind: enum
    name: Mode
    access: public
    usage: 1
    crossLanguageDefinitionId: Contoso.Mode
    valueType: { kind: string }
    isFixed: false
    isUnionAsEnum: true
    values: [{ name: Fast, value: fast }]
unions:
  - kind: union
    name: Choice
    access: public
    usage: 1
    crossLanguageDefinitionId: Contoso.Choice
    variantTypes:
      - { kind: string }
      - kind: string
        external: { kind: externalTypeInfo, identity: ext.Ext, package: ext }
    discriminatedOptions:
      envelope: object
      discriminatorPropertyName: kind
      envelopePropertyName: value
namespaces:
  - name: Contoso
    clients: [*client]
`);
  const contract = normalizeTcgcPackage(root);
  assert.deepEqual(
    contract.methods.map((item) => item.kind),
    ["lro", "lropaging", "basic", "paging"],
  );
  const get = required(contract.methods.find((item) => item.name === "get"));
  const operation = required(get.operation);
  assert.equal(required(required(operation.parameters)[0]).kind, "path");
  assert.equal(required(operation.bodyParam).kind, "body");
  assert.equal(required(operation.bodyParam).type.kind, "dictionary");
  assert.deepEqual(required(required(operation.responses)[0]).statusCodes, {
    start: 200,
    end: 299,
  });
  assert.equal(required(required(operation.exceptions)[0]).statusCodes, "*");
  assert.equal(contract.clients.length, 1);
  const model = required(contract.models[0]);
  assert.equal(model.discriminatorProperty, "kind");
  assert.equal(required(required(model.properties)[1]).type.id, "Contoso.Widget");
  assert.equal(required(contract.enums[0]).isUnionAsEnum, true);
  const union = required(contract.unions[0]);
  const external = required(required(required(union.variantTypes)[1]).external);
  assert.ok(isRecord(external));
  assert.equal(external.identity, "ext.Ext");
  assert.ok(isRecord(union.discriminatedOptions));
  assert.equal(union.discriminatedOptions.envelope, "object");
  assert.deepEqual(contract.package.apiVersions, [{ service: "Contoso", version: "v2" }]);
  assert.deepEqual(
    contract.conflicts.map((item) => item.code),
    ["api-version-conflict", "method-parameter-segments-conflict"],
  );
});

void test("rejects invalid normal response status arrays", () => {
  assert.throws(
    () =>
      normalizeTcgcPackage({
        crossLanguagePackageId: "Contoso",
        crossLanguageVersion: "1",
        metadata: { apiVersions: ["v1"] },
        clients: [
          {
            kind: "client",
            name: "Client",
            methods: [
              {
                kind: "basic",
                name: "get",
                parameters: [],
                operation: {
                  kind: "http",
                  parameters: [],
                  responses: [{ statusCodes: [200, 201] }],
                  exceptions: [],
                },
              },
            ],
            children: [],
          },
        ],
        models: [],
        enums: [],
        unions: [],
        namespaces: [],
      }),
    /one exact status/,
  );
});
