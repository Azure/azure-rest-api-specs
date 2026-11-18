import { assert, test } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  discoverAutorestDocuments,
  effectiveSchemaProperties,
  normalizeAutorestDocuments,
  responseStatusKind,
  sameAutorestContract,
} from "../scripts/autorest-contract.ts";

function fixtureDirectory() {
  return fs.mkdtempSync(path.join(process.cwd(), ".autorest-contract-test-"));
}

void test("ignores version-specific document prefixes in equivalent schema references", () => {
  const before = {
    kind: "object",
    reference: "stable/2026-02-23/confidentialledger.json#/definitions/LedgerUser",
    references: ["stable/2026-02-23/confidentialledger.json#/definitions/LedgerUser"],
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
    reference: "preview/2026-07-31-preview/confidentialledger.json#/definitions/LedgerUser",
    references: ["preview/2026-07-31-preview/confidentialledger.json#/definitions/LedgerUser"],
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

void test("normalizes Swagger 2 paths, x-ms-paths, refs, allOf, multipart, and response statuses", () => {
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
  assert.ok(create);
  assert.equal(create.parameters[0].name, "subscriptionId");
  const createRequest = create.request;
  assert.ok(createRequest);
  const createSchema = createRequest.schema;
  assert.ok(createSchema);
  const createProperties = effectiveSchemaProperties(createSchema);
  assert.equal(createSchema.kind, "object");
  assert.deepEqual(
    createProperties.map((item) => item.name),
    ["id", "note", "state"],
  );
  const note = createProperties.find((item) => item.name === "note");
  assert.ok(note);
  assert.equal(note.schema.nullable, true);
  assert.deepEqual(
    create.responses.map((item) => item.status),
    ["200", "4XX", "default"],
  );
  assert.ok(create.lro);
  assert.equal(
    (
      create.lro as {
        options: Record<string, unknown>;
      }
    ).options["final-state-via"],
    "location",
  );
  const upload = contract.operations.find((item) => item.operationId === "Widgets_Upload");
  assert.ok(upload);
  const uploadRequest = upload.request;
  assert.ok(uploadRequest);
  assert.equal(uploadRequest.kind, "multipart");
  const uploadMembers = uploadRequest.members;
  assert.ok(uploadMembers);
  const file = uploadMembers.find((item) => item.name === "file");
  assert.ok(file?.schema);
  assert.equal(file.schema.type, "file");
  const list = contract.operations.find((item) => item.operationId === "Widgets_List");
  assert.ok(list);
  assert.equal(list.routeSource, "x-ms-paths");
  assert.equal(list.responses[0].status, "2XX");
});

void test("keeps nested shared allOf schemas finite while preserving effective properties", () => {
  const root = path.resolve("virtual-nested-autorest");
  const contract = normalizeAutorestDocuments([
    {
      path: "feature.json",
      absolutePath: path.join(root, "feature.json"),
      documentRole: "feature",
      document: {
        swagger: "2.0",
        info: { title: "Feature", version: "2026-01-01" },
        definitions: {
          Base: {
            type: "object",
            properties: { id: { type: "string" } },
          },
          Shared: {
            allOf: [{ $ref: "#/definitions/Base" }],
            properties: { name: { type: "string" } },
          },
          Widget: {
            allOf: [{ $ref: "#/definitions/Shared" }, { $ref: "#/definitions/Shared" }],
            properties: { state: { type: "string" } },
          },
        },
        paths: {
          "/widgets": {
            get: {
              operationId: "Widgets_Get",
              responses: { 200: { schema: { $ref: "#/definitions/Widget" } } },
            },
          },
        },
      },
    },
  ]);

  const schema = contract.operations[0].responses[0].schema;
  assert.ok(schema);
  assert.deepEqual(
    schema.properties?.map((property) => property.name),
    ["state"],
  );
  assert.deepEqual(
    effectiveSchemaProperties(schema).map((property) => property.name),
    ["id", "name", "state"],
  );
  assert.ok(JSON.stringify(contract).length < 10_000);
});

void test("preserves the own schema as a mixed allOf composition branch", () => {
  const root = path.resolve("virtual-mixed-autorest");
  const contract = normalizeAutorestDocuments([
    {
      path: "feature.json",
      absolutePath: path.join(root, "feature.json"),
      documentRole: "feature",
      document: {
        swagger: "2.0",
        info: { title: "Feature", version: "2026-01-01" },
        definitions: {
          Mixed: {
            allOf: [{ type: "string" }],
            properties: { id: { type: "string" } },
          },
        },
        paths: {
          "/mixed": {
            get: {
              operationId: "Mixed_Get",
              responses: { 200: { schema: { $ref: "#/definitions/Mixed" } } },
            },
          },
        },
      },
    },
  ]);

  const schema = contract.operations[0].responses[0].schema;
  assert.ok(schema);
  assert.equal(schema.kind, "intersection");
  assert.equal(schema.allOf?.length, 2);
  assert.deepEqual(
    schema.allOf?.[1].properties?.map((property) => property.name),
    ["id"],
  );
  assert.deepEqual(
    effectiveSchemaProperties(schema).map((property) => property.name),
    ["id"],
  );
});

void test("discovers configurable multi-file output from service manifest and rejects OpenAPI 3", (context) => {
  const root = fixtureDirectory();
  context.onTestFinished(() => fs.rmSync(root, { recursive: true, force: true }));
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
  assert.deepEqual(
    documents.map((item) => item.path),
    ["generated/common.json", "generated/feature.json"],
  );
  assert.throws(
    () => normalizeAutorestDocuments([{ path: "openapi.json", document: { openapi: "3.0.0" } }]),
    /Swagger 2.0|OpenAPI 3/,
  );
  assert.equal(responseStatusKind("default"), "exception");
  assert.equal(responseStatusKind("2XX"), "normal");
});

void test("keeps resolved reference identities stable across base and current artifact roots", () => {
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

  const normalize = (revision: string) =>
    normalizeAutorestDocuments([
      {
        path: `projects/widgets/${revision}/autorest/stable/2026-01-01/openapi.json`,
        absolutePath: path.resolve("virtual-autorest", revision, "openapi.json"),
        documentRole: "primary",
        document,
      },
    ]).operations[0].responses[0].schema;

  assert.deepEqual(normalize("base"), normalize("current"));
});

void test("deduplicates diamond allOf hierarchies without exponential contract expansion", () => {
  const depth = 25;
  const buildDiamondDefinitions = (withUnresolvedRoot: boolean) => {
    const definitions: Record<string, unknown> = {
      D0: {
        ...(withUnresolvedRoot
          ? {
              allOf: [
                {
                  $ref: "../../../../../common-types/resource-management/v6/types.json#/definitions/Resource",
                },
              ],
            }
          : {}),
        type: "object",
        properties: {
          p0: { type: "string" },
          overridden: { type: "string" },
        },
      },
    };
    for (let index = 1; index <= depth; index += 1) {
      const prev = `D${index - 1}`;
      definitions[`L${index}`] = {
        type: "object",
        allOf: [{ $ref: `#/definitions/${prev}` }],
        properties: { [`l${index}`]: { type: "string" } },
      };
      definitions[`R${index}`] = {
        type: "object",
        allOf: [{ $ref: `#/definitions/${prev}` }],
        properties: { [`r${index}`]: { type: "string" } },
      };
      definitions[`D${index}`] = {
        type: "object",
        allOf: [{ $ref: `#/definitions/L${index}` }, { $ref: `#/definitions/R${index}` }],
        properties: {
          [`d${index}`]: { type: "string" },
          ...(index === depth ? { overridden: { type: "integer", format: "int32" } } : {}),
        },
      };
    }
    return definitions;
  };

  for (const withUnresolvedRoot of [false, true]) {
    const contract = normalizeAutorestDocuments([
      {
        path: "projects/diamond/current/autorest/stable/2026-01-01/diamond.json",
        document: {
          swagger: "2.0",
          info: { title: "Diamond", version: "2026-01-01" },
          definitions: buildDiamondDefinitions(withUnresolvedRoot),
          paths: {
            "/diamond": {
              get: {
                operationId: "Diamond_Get",
                responses: { 200: { schema: { $ref: `#/definitions/D${depth}` } } },
              },
            },
          },
        },
      },
    ]);

    const schema = contract.operations[0].responses[0].schema;
    assert.ok(schema);
    assert.ok((schema.allOf?.length ?? 0) <= depth * 3 + 2);
    const props = effectiveSchemaProperties(schema);
    assert.equal(props.length, depth * 3 + 2);
    assert.equal(props.find((item) => item.name === "overridden")?.schema.type, "integer");
    assert.ok(schema.references?.includes("stable/2026-01-01/diamond.json#/definitions/D0"));
    assert.ok(schema.references?.includes(`stable/2026-01-01/diamond.json#/definitions/L${depth}`));
    assert.ok(schema.references?.includes(`stable/2026-01-01/diamond.json#/definitions/R${depth}`));
    assert.ok(JSON.stringify(contract).length < 60_000);
  }
});

void test("does not reuse mutually recursive $ref cache entries across active caller cycles", () => {
  const ringSize = 14;
  const definitions: Record<string, unknown> = {
    Resource: {
      type: "object",
      properties: {
        id: { type: "string" },
        name: { type: "string" },
      },
    },
  };
  const paths: Record<string, unknown> = {};
  for (let index = 0; index < ringSize; index += 1) {
    const next = (index + 1) % ringSize;
    definitions[`Node${index}`] = {
      type: "object",
      allOf: [{ $ref: "#/definitions/Resource" }],
      properties: {
        peer: { $ref: `#/definitions/Node${next}` },
        label: { type: "string" },
      },
    };
    paths[`/nodes/${index}`] = {
      get: {
        operationId: `Nodes_Get${index}`,
        responses: { 200: { schema: { $ref: `#/definitions/Node${index}` } } },
      },
    };
  }

  const contract = normalizeAutorestDocuments([
    {
      path: "projects/ring/current/autorest/stable/2026-01-01/ring.json",
      document: {
        swagger: "2.0",
        info: { title: "Ring", version: "2026-01-01" },
        definitions,
        paths,
      },
    },
  ]);

  assert.equal(contract.operations.length, ringSize);
  const sizes = contract.operations.map((operation) => JSON.stringify(operation).length);
  const minSize = Math.min(...sizes);
  const maxSize = Math.max(...sizes);
  assert.ok(maxSize < minSize + 64, `expected uniform ring sizes, got ${minSize}..${maxSize}`);
});

void test("isolates normalizedRefs cache across multiple openapi.json documents and normalizes relative autorest/ paths", () => {
  const contract = normalizeAutorestDocuments([
    {
      path: "service-a/openapi.json",
      document: {
        swagger: "2.0",
        info: { title: "ServiceA", version: "2026-01-01" },
        definitions: {
          Widget: {
            type: "object",
            properties: { alphaOnly: { type: "string" } },
          },
        },
        paths: {
          "/alpha": {
            get: {
              operationId: "Alpha_Get",
              responses: { 200: { schema: { $ref: "#/definitions/Widget" } } },
            },
          },
        },
      },
    },
    {
      path: "service-b/openapi.json",
      document: {
        swagger: "2.0",
        info: { title: "ServiceB", version: "2026-01-01" },
        definitions: {
          Widget: {
            type: "object",
            properties: { betaOnly: { type: "integer", format: "int32" } },
          },
        },
        paths: {
          "/beta": {
            get: {
              operationId: "Beta_Get",
              responses: { 200: { schema: { $ref: "#/definitions/Widget" } } },
            },
          },
        },
      },
    },
    {
      path: "autorest/preview/2026-02-01-preview/openapi.json",
      document: {
        swagger: "2.0",
        info: { title: "PreviewService", version: "2026-02-01-preview" },
        definitions: {
          Widget: {
            type: "object",
            properties: { previewOnly: { type: "boolean" } },
          },
        },
        paths: {
          "/preview": {
            get: {
              operationId: "Preview_Get",
              responses: { 200: { schema: { $ref: "#/definitions/Widget" } } },
            },
          },
        },
      },
    },
  ]);

  const alpha = contract.operations.find((op) => op.operationId === "Alpha_Get");
  const beta = contract.operations.find((op) => op.operationId === "Beta_Get");
  const preview = contract.operations.find((op) => op.operationId === "Preview_Get");
  assert.deepEqual(
    alpha?.responses[0].schema?.properties?.map((prop) => prop.name),
    ["alphaOnly"],
  );
  assert.deepEqual(
    beta?.responses[0].schema?.properties?.map((prop) => prop.name),
    ["betaOnly"],
  );
  assert.deepEqual(
    preview?.responses[0].schema?.properties?.map((prop) => prop.name),
    ["previewOnly"],
  );
  assert.equal(
    preview?.responses[0].schema?.reference,
    "preview/2026-02-01-preview/openapi.json#/definitions/Widget",
  );
});
