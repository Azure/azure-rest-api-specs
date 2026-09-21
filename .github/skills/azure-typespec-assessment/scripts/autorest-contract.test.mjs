import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import {
  discoverAutorestDocuments,
  normalizeAutorestDocuments,
  responseStatusKind,
  sameAutorestContract,
} from "./autorest-contract.mjs";

function fixtureDirectory() {
  return fs.mkdtempSync(path.join(process.cwd(), ".autorest-contract-test-"));
}

test("ignores version-specific document prefixes in equivalent schema references", () => {
  const before = {
    kind: "object",
    reference:
      "stable/2026-02-23/confidentialledger.json#/definitions/LedgerUser",
    references: [
      "stable/2026-02-23/confidentialledger.json#/definitions/LedgerUser",
    ],
    properties: [
      {
        name: "userId",
        required: false,
        schema: { kind: "scalar", type: "string" },
      },
    ],
  };
  const after = {
    kind: "object",
    reference:
      "preview/2026-07-31-preview/confidentialledger.json#/definitions/LedgerUser",
    references: [
      "preview/2026-07-31-preview/confidentialledger.json#/definitions/LedgerUser",
    ],
    properties: [
      {
        name: "userId",
        required: false,
        schema: { kind: "scalar", type: "string" },
      },
    ],
  };

  assert.equal(sameAutorestContract(before, after), true);
});

test("normalizes Swagger 2 paths, x-ms-paths, refs, allOf, multipart, and response statuses", () => {
  const root = path.resolve("virtual-autorest");
  const commonPath = path.join(root, "common.json");
  const featurePath = path.join(root, "feature.json");
  const contract = normalizeAutorestDocuments([
    {
      path: "common.json",
      absolutePath: commonPath,
      documentRole: "common",
      document: {
        swagger: "2.0",
        info: { title: "Common", version: "2026-01-01" },
        paths: {},
        definitions: {
          Base: {
            type: "object",
            required: ["id"],
            properties: {
              id: { type: "string" },
              state: {
                type: "string",
                enum: ["Ready", "Done"],
                "x-ms-enum": { name: "State", modelAsString: true },
              },
            },
          },
        },
      },
    },
    {
      path: "feature.json",
      absolutePath: featurePath,
      documentRole: "feature",
      document: {
        swagger: "2.0",
        info: { title: "Feature", version: "2026-01-01" },
        parameters: {
          Subscription: { name: "subscriptionId", in: "path", required: true, type: "string" },
        },
        definitions: {
          Widget: {
            allOf: [
              { $ref: "./common.json#/definitions/Base" },
              {
                type: "object",
                properties: { note: { type: "string", "x-nullable": true } },
              },
            ],
          },
        },
        paths: {
          "/widgets/{subscriptionId}": {
            parameters: [{ $ref: "#/parameters/Subscription" }],
            post: {
              operationId: "Widgets_Create",
              parameters: [
                {
                  name: "widget",
                  in: "body",
                  required: true,
                  schema: { $ref: "#/definitions/Widget" },
                },
              ],
              responses: {
                200: {
                  schema: { $ref: "#/definitions/Widget" },
                  headers: { ETag: { type: "string" } },
                },
                default: { description: "error" },
                "4XX": { description: "client error" },
              },
              "x-ms-long-running-operation": true,
              "x-ms-long-running-operation-options": { "final-state-via": "location" },
            },
          },
          "/uploads": {
            post: {
              operationId: "Widgets_Upload",
              parameters: [
                { name: "file", in: "formData", required: true, type: "file" },
                {
                  name: "labels",
                  in: "formData",
                  type: "array",
                  items: { type: "string" },
                  collectionFormat: "multi",
                },
              ],
              responses: { 204: { description: "ok" } },
            },
          },
        },
        "x-ms-paths": {
          "/widgets?api-version={api-version}": {
            get: {
              operationId: "Widgets_List",
              parameters: [],
              responses: { "2XX": { description: "ok" } },
              "x-ms-pageable": { nextLinkName: "nextLink" },
            },
          },
        },
      },
    },
  ]);

  assert.equal(contract.documents.length, 2);
  assert.equal(contract.operations.length, 3);
  const create = contract.operations.find((item) => item.operationId === "Widgets_Create");
  assert.equal(create.parameters[0].name, "subscriptionId");
  assert.equal(create.request.schema.kind, "object");
  assert.deepEqual(create.request.schema.properties.map((item) => item.name), ["id", "note", "state"]);
  assert.equal(create.request.schema.properties.find((item) => item.name === "note").schema.nullable, true);
  assert.deepEqual(create.responses.map((item) => item.status), ["200", "4XX", "default"]);
  assert.equal(create.lro.options["final-state-via"], "location");
  const upload = contract.operations.find((item) => item.operationId === "Widgets_Upload");
  assert.equal(upload.request.kind, "multipart");
  assert.equal(upload.request.members.find((item) => item.name === "file").schema.type, "file");
  const list = contract.operations.find((item) => item.operationId === "Widgets_List");
  assert.equal(list.routeSource, "x-ms-paths");
  assert.equal(list.responses[0].status, "2XX");
});

test("discovers configurable multi-file output from service manifest and rejects OpenAPI 3", (context) => {
  const root = fixtureDirectory();
  context.after(() => fs.rmSync(root, { recursive: true, force: true }));
  fs.mkdirSync(path.join(root, "generated"), { recursive: true });
  fs.writeFileSync(
    path.join(root, "service.yaml"),
    "input-file:\n  - generated/feature.json\n  - generated/common.json\n",
  );
  for (const name of ["feature.json", "common.json"]) {
    fs.writeFileSync(
      path.join(root, "generated", name),
      JSON.stringify({ swagger: "2.0", info: { title: name, version: "v1" }, paths: {} }),
    );
  }
  const documents = discoverAutorestDocuments({
    workRoot: root,
    artifact: { format: "swagger-2.0", files: [], serviceManifestPath: "service.yaml" },
  });
  assert.deepEqual(documents.map((item) => item.path), [
    "generated/common.json",
    "generated/feature.json",
  ]);
  assert.throws(
    () => normalizeAutorestDocuments([{ path: "openapi.json", document: { openapi: "3.0.0" } }]),
    /Swagger 2.0|OpenAPI 3/,
  );
  assert.equal(responseStatusKind("default"), "exception");
  assert.equal(responseStatusKind("2XX"), "normal");
});

test("keeps resolved reference identities stable across base and current artifact roots", () => {
  const document = {
    swagger: "2.0",
    info: { title: "Widgets", version: "2026-01-01" },
    definitions: {
      Widget: { type: "object", properties: { id: { type: "string" } } },
    },
    paths: {
      "/widgets": {
        get: {
          operationId: "Widgets_Get",
          responses: { 200: { schema: { $ref: "#/definitions/Widget" } } },
        },
      },
    },
  };
  const normalize = (revision) => normalizeAutorestDocuments([{
    path: `projects/widgets/${revision}/autorest/stable/2026-01-01/openapi.json`,
    absolutePath: path.resolve("virtual-autorest", revision, "openapi.json"),
    documentRole: "primary",
    document,
  }]).operations[0].responses[0].schema;

  assert.deepEqual(normalize("base"), normalize("current"));
});
