import { assert, test } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { analyzeRestBreaking } from "../scripts/analyze-rest-breaking.ts";
import { compatibilitySkipReason } from "../scripts/compatibility-policy.ts";

void test.each(["new", "existing"])(
  "policy skips %s projects before accessing REST artifacts",
  (classification) => {
    const result = analyzeRestBreaking({
      manifest: {
        projects: [
          {
            id: "preview",
            classification,
            artifactComparison: {
              compatibilityPolicy: { action: "skip", reason: "no-stable-api-version" },
            },
            get artifacts() {
              throw new Error("Policy-skipped artifacts must not be accessed.");
            },
          },
        ],
      },
      sourceIndex: { sourceChanges: [] },
    } as unknown as Parameters<typeof analyzeRestBreaking>[0]);
    assert.equal(result.status, "blocked");
    assert.deepEqual(result.analyzedProjectIds, []);
    assert.deepEqual(result.candidates, []);
    assert.deepEqual(result.facts, {});
    assert.deepEqual(result.blockers, [compatibilitySkipReason("preview")]);
  },
);

function writeJson(file: string, value: unknown) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, JSON.stringify(value));
}

void test("emits explicit REST candidates for parameters, required properties, enums, statuses, paging, and LRO", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-analyzer-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));

  const document = (current: boolean) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets/{id}": {
        post: {
          operationId: "Widgets_Create",
          parameters: [
            { name: "id", in: "path", required: true, type: current ? "integer" : "string" },
            {
              name: "body",
              in: "body",
              required: current,
              schema: {
                type: "object",
                required: current ? ["mode"] : [],
                properties: {
                  mode: {
                    type: "string",
                    enum: current ? ["Fast"] : ["Fast", "Safe"],
                    "x-ms-enum": { name: "Mode", modelAsString: !current },
                  },
                },
              },
            },
          ],
          responses: current
            ? { 202: { description: "accepted" } }
            : {
                200: { description: "ok" },
                202: { description: "accepted" },
              },
          "x-ms-pageable": current ? { nextLinkName: "next" } : undefined,
          "x-ms-long-running-operation": current,
        },
      },
    },
  });

  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "current.json"), document(true));

  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-1",
          sourceChangeIds: ["source-authoritative"],
          artifacts: {
            base: { autorest: artifact("base.json") },
            current: { autorest: artifact("current.json") },
          },
        },
      ],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-authoritative",
          declarations: [{ id: "declaration-authoritative" }],
        },
      ],
    },
  } as unknown as Parameters<typeof analyzeRestBreaking>[0]);
  const rules = new Set(result.candidates.map((item) => item.rule));
  for (const rule of [
    "parameter-wire-type-changed",
    "request-body-required",
    "property-required",
    "enum-values-removed",
    "enum-closed",
    "response-status-removed",
    "paging-behavior-changed",
    "lro-behavior-changed",
  ]) {
    assert.ok(rules.has(rule), `missing ${rule}`);
  }
  assert.ok(result.candidates.every((item) => item.sourceChangeIds[0] === "source-authoritative"));
  assert.ok(result.candidates.every((item) => item.contractChange?.rule === item.rule));
  assert.deepEqual(
    result.candidates.map((item) => item.id),
    result.candidates.map((item) => item.id).sort(),
  );
});

void test("new projects are complete and non-breaking without baseline artifacts", () => {
  const result = analyzeRestBreaking({
    manifest: {
      projects: [
        {
          id: "project-new",
          classification: "new",
          sourceChangeIds: ["source-new"],
          artifacts: {},
          artifactComparison: {
            mode: "new-project",
            baseline: {
              sourceRevision: "absent",
              reason: "No pre-existing REST contract exists.",
            },
            target: {
              sourceRevision: "current",
              commit: "head",
              reason: "unversioned",
            },
            addedCurrentVersions: [],
            available: { base: [], current: [] },
          },
        },
      ],
    },
    sourceIndex: { sourceChanges: [] },
  } as unknown as Parameters<typeof analyzeRestBreaking>[0]);

  assert.equal(result.status, "ready");
  assert.deepEqual(result.candidates, []);
  assert.deepEqual(result.blockers, []);
});

void test("ignores PR 43308-style string format annotations across intersected response models", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-format-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));

  const document = (revision: string) => ({
    swagger: "2.0",
    info: { title: "Chaos", version: "2026-05-01-preview" },
    definitions: {
      ScenarioRun: {
        allOf: [
          {
            $ref: `../../worktrees/${revision}/specification/common-types/resource-management/v5/types.json#/definitions/ProxyResource`,
          },
        ],
        properties: {
          resourceId: {
            type: "string",
            ...(revision === "current" ? { format: "arm-id" } : {}),
          },
        },
      },
      ScenarioRunListResult: {
        type: "object",
        properties: {
          value: {
            type: "array",
            items: { $ref: "#/definitions/ScenarioRun" },
          },
        },
      },
    },
    paths: {
      "/runs": {
        get: {
          operationId: "ScenarioRuns_ListAll",
          responses: { 200: { schema: { $ref: "#/definitions/ScenarioRunListResult" } } },
        },
      },
      "/runs/{runId}": {
        get: {
          operationId: "ScenarioRuns_Get",
          responses: {
            200: { schema: { $ref: "#/definitions/ScenarioRun" } },
            202: {
              schema: { $ref: "#/definitions/ScenarioRun" },
              headers: {
                Location: {
                  type: "string",
                  ...(revision === "current" ? { format: "uri" } : {}),
                },
              },
            },
          },
        },
      },
    },
  });
  writeJson(path.join(work, "base", "autorest", "openapi.json"), document("base"));
  writeJson(path.join(work, "current", "autorest", "openapi.json"), document("current"));

  const artifact = (revision: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: `${revision}/autorest/openapi.json`, documentRole: "primary" }],
  });
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-1",
          sourceChangeIds: ["source-authoritative"],
          artifacts: {
            base: { autorest: artifact("base") },
            current: { autorest: artifact("current") },
          },
        },
      ],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-authoritative",
          declarations: [{ id: "declaration-authoritative" }],
        },
      ],
    },
  } as unknown as Parameters<typeof analyzeRestBreaking>[0]);

  assert.deepEqual(result.candidates, []);
});

void test("treats changed ARM common-type references as opaque while retaining resolved candidates", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-unresolved-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (reference: string, required: boolean) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets": {
        get: {
          operationId: "Widgets_List",
          parameters: [{ name: "filter", in: "query", type: "string", required }],
          responses: {
            200: {
              schema: {
                $ref: reference,
              },
            },
          },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "source", "source-index.json"), {
    sourceChanges: [{ id: "source-1", declarations: [] }],
  });
  writeJson(
    path.join(work, "base.json"),
    document(
      "../specification/common-types/resource-management/v6/types.json#/definitions/TrackedResource",
      false,
    ),
  );
  writeJson(
    path.join(work, "current.json"),
    document(
      "../common-types/resource-management/v5/types.json#/definitions/TrackedResource",
      true,
    ),
  );
  writeJson(path.join(work, "manifest.json"), {
    projects: [
      {
        id: "project-1",
        sourceChangeIds: ["source-1"],
        artifacts: {
          base: { autorest: artifact("base.json") },
          current: { autorest: artifact("current.json") },
        },
      },
    ],
  });
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: path.join(work, "manifest.json"),
  });
  assert.equal(result.status, "ready");
  assert.deepEqual(
    result.candidates.map((candidate) => candidate.rule),
    ["parameter-required"],
  );
  assert.equal(Object.keys(result.facts).length, 2);
  assert.deepEqual(result.blockers, []);
});

void test("does not block when an unchanged common-type-backed property shifts array position", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-common-type-position-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (current: boolean) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets": {
        get: {
          operationId: "Widgets_List",
          responses: {
            200: {
              schema: {
                type: "object",
                properties: {
                  ...(current ? { alpha: { type: "string" } } : {}),
                  resource: {
                    $ref: "../common-types/v6/types.json#/definitions/TrackedResource",
                  },
                },
              },
            },
          },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "current.json"), document(true));
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-1",
          artifacts: {
            base: { autorest: artifact("base.json") },
            current: { autorest: artifact("current.json") },
          },
        },
      ],
    },
    sourceIndex: { sourceChanges: [] },
  } as unknown as Parameters<typeof analyzeRestBreaking>[0]);
  assert.deepEqual(result.candidates, []);
  assert.deepEqual(result.blockers, []);
});

void test("compares effective JSON wire properties across object and allOf representations", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-effective-object-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (current: boolean) => ({
    swagger: "2.0",
    info: { title: "Cloud accounts", version: current ? "v2" : "v1" },
    definitions: {
      CloudAccountUpdate: current
        ? {
            allOf: [{ $ref: "#/definitions/TrackedResourceUpdate" }],
            properties: {
              identity: { type: "string" },
              properties: { $ref: "#/definitions/CloudAccountPropertiesUpdate" },
            },
          }
        : {
            type: "object",
            properties: {
              identity: { type: "string" },
              tags: { type: "object", additionalProperties: { type: "string" } },
              properties: { $ref: "#/definitions/CloudAccountUpdateProperties" },
            },
          },
      TrackedResourceUpdate: {
        type: "object",
        allOf: [
          {
            $ref: "../common-types/resource-management/v5/types.json#/definitions/Resource",
          },
        ],
        properties: {
          tags: { type: "object", additionalProperties: { type: "string" } },
        },
      },
      CloudAccountUpdateProperties: {
        type: "object",
        properties: {
          marketplace: { type: "string" },
          user: { type: "string" },
        },
      },
      CloudAccountPropertiesUpdate: {
        type: "object",
        properties: {
          marketplace: { type: "string" },
          user: { type: "string" },
          company: { type: "string" },
        },
      },
    },
    paths: {
      "/cloudAccounts/{name}": {
        patch: {
          operationId: "CloudAccounts_Update",
          parameters: [
            {
              name: "properties",
              in: "body",
              required: true,
              schema: { $ref: "#/definitions/CloudAccountUpdate" },
            },
          ],
          responses: { 200: { description: "OK" } },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "current.json"), document(true));
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-1",
          artifacts: {
            base: { autorest: artifact("base.json") },
            current: { autorest: artifact("current.json") },
          },
        },
      ],
    },
    sourceIndex: { sourceChanges: [] },
  } as unknown as Parameters<typeof analyzeRestBreaking>[0]);

  assert.deepEqual(result.candidates, []);
  assert.deepEqual(result.blockers, []);
});

void test("detects breaking changes inside inherited allOf JSON properties", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-inherited-property-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (current: boolean) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    definitions: {
      Widget: {
        allOf: [
          {
            type: "object",
            required: current ? ["name"] : [],
            properties: { name: { type: "string" } },
          },
        ],
      },
    },
    paths: {
      "/widgets": {
        post: {
          operationId: "Widgets_Create",
          parameters: [
            {
              name: "body",
              in: "body",
              required: true,
              schema: { $ref: "#/definitions/Widget" },
            },
          ],
          responses: { 200: { description: "OK" } },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "current.json"), document(true));
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-1",
          artifacts: {
            base: { autorest: artifact("base.json") },
            current: { autorest: artifact("current.json") },
          },
        },
      ],
    },
    sourceIndex: { sourceChanges: [] },
  } as unknown as Parameters<typeof analyzeRestBreaking>[0]);

  assert.deepEqual(
    result.candidates.map((candidate) => [candidate.rule, candidate.contractChange?.location]),
    [["property-required", "request body.name"]],
  );
});

void test("detects constraints inherited only through resolved allOf branches", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-inherited-constraint-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (current: boolean) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    definitions: {
      Widget: current
        ? {
            allOf: [{ $ref: "#/definitions/ConstrainedWidget" }],
            properties: { name: { type: "string" } },
          }
        : {
            type: "object",
            properties: { name: { type: "string" } },
          },
      ConstrainedWidget: {
        type: "object",
        minProperties: 1,
      },
    },
    paths: {
      "/widgets": {
        post: {
          operationId: "Widgets_Create",
          parameters: [
            {
              name: "body",
              in: "body",
              required: true,
              schema: { $ref: "#/definitions/Widget" },
            },
          ],
          responses: { 200: { description: "OK" } },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "current.json"), document(true));
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-1",
          artifacts: {
            base: { autorest: artifact("base.json") },
            current: { autorest: artifact("current.json") },
          },
        },
      ],
    },
    sourceIndex: { sourceChanges: [] },
  } as unknown as Parameters<typeof analyzeRestBreaking>[0]);

  assert.deepEqual(
    result.candidates.map((candidate) => [candidate.rule, candidate.contractChange?.location]),
    [["wire-schema-changed", "request body"]],
  );
});

void test("intersects additionalProperties evidence across resolved allOf branches", (context) => {
  const work = fs.mkdtempSync(
    path.join(process.cwd(), ".rest-inherited-additional-properties-test-"),
  );
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (current: boolean) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    definitions: {
      Widget: current
        ? {
            allOf: [
              { type: "object", additionalProperties: false },
              { type: "object", additionalProperties: true },
            ],
          }
        : {
            type: "object",
          },
    },
    paths: {
      "/widgets": {
        post: {
          operationId: "Widgets_Create",
          parameters: [
            {
              name: "body",
              in: "body",
              required: true,
              schema: { $ref: "#/definitions/Widget" },
            },
          ],
          responses: { 200: { description: "OK" } },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "current.json"), document(true));
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-1",
          artifacts: {
            base: { autorest: artifact("base.json") },
            current: { autorest: artifact("current.json") },
          },
        },
      ],
    },
    sourceIndex: { sourceChanges: [] },
  } as unknown as Parameters<typeof analyzeRestBreaking>[0]);

  assert.deepEqual(
    result.candidates.map((candidate) => [candidate.rule, candidate.contractChange?.location]),
    [["additional-properties-changed", "request body"]],
  );
});

void test("blocks changed or missing non-common unresolved references", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-non-common-unresolved-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (reference?: string) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets": {
        get: {
          operationId: "Widgets_List",
          responses: {
            200: {
              ...(reference ? { schema: { $ref: reference } } : {}),
            },
          },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document("../shared/v1/types.json#/definitions/Widget"));
  for (const [scenario, targetReference] of [
    ["changed", "../shared/v2/types.json#/definitions/Widget"],
    ["missing", undefined],
  ] as const) {
    writeJson(path.join(work, "current.json"), document(targetReference));
    const result = analyzeRestBreaking({
      workRoot: work,
      manifest: {
        projects: [
          {
            id: "project-1",
            artifacts: {
              base: { autorest: artifact("base.json") },
              current: { autorest: artifact("current.json") },
            },
          },
        ],
      },
      sourceIndex: { sourceChanges: [] },
    } as unknown as Parameters<typeof analyzeRestBreaking>[0]);
    assert.ok(
      result.candidates.some((candidate) => candidate.rule === "wire-schema-changed"),
      scenario,
    );
    assert.equal(result.blockers.length, 1, scenario);
    assert.equal(result.blockers[0].code, "autorest-contract-unresolved", scenario);
    assert.match(result.blockers[0].message, /Widgets_List/, scenario);
  }
});

void test("assesses new-version property removals, requiredness, and constraints instead of suppressing REST candidates", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-version-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const versions = ["2026-07-03-preview", "2026-08-01-preview"];
  const document = (current: boolean) => ({
    swagger: "2.0",
    info: { title: "Commvault", version: versions[Number(current)] },
    paths: {
      "/activateSaaS": {
        post: {
          operationId: "SaaS_Activate",
          parameters: [
            {
              name: "api-version",
              in: "query",
              required: true,
              type: "string",
              enum: [versions[Number(current)]],
            },
            {
              name: "body",
              in: "body",
              required: true,
              schema: {
                type: "object",
                required: current ? ["saasGuid", "roleName", "entities"] : ["saaSGuid"],
                properties: {
                  [current ? "saasGuid" : "saaSGuid"]: { type: "string" },
                  roleName: { type: "string" },
                  entities: {
                    type: "array",
                    items: { type: "string" },
                    ...(current ? { minItems: 1 } : {}),
                  },
                },
              },
            },
          ],
          responses: { 200: { description: "OK" } },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "target.json"), document(true));
  writeJson(path.join(work, "source", "source-index.json"), {
    sourceChanges: [{ id: "source-1", declarations: [] }],
  });
  writeJson(path.join(work, "manifest.json"), {
    projects: [
      {
        id: "p",
        sourceChangeIds: ["source-1"],
        artifactComparison: {
          mode: "new-api-version",
          baseline: { sourceRevision: "current", commit: "head", apiVersion: versions[0] },
          target: { sourceRevision: "current", commit: "head", apiVersion: versions[1] },
        },
        artifacts: {
          baseline: { autorest: artifact("base.json") },
          target: { autorest: artifact("target.json") },
        },
      },
    ],
  });
  const result = analyzeRestBreaking({ manifest: path.join(work, "manifest.json") });
  const changes = result.candidates.map((candidate) => candidate.contractChange);
  for (const [rule, location] of [
    ["serialized-property-removed", "request body.saaSGuid"],
    ["required-property-added", "request body.saasGuid"],
    ["property-required", "request body.roleName"],
    ["property-required", "request body.entities"],
    ["wire-schema-changed", "request body.entities"],
  ]) {
    assert.ok(changes.some((change) => change?.rule === rule && change.location === location));
  }
  assert.equal(result.candidates.length, 5);
  assert.deepEqual(result.blockers, []);
  assert.ok(Object.values(result.facts).every((fact) => fact.sourceCommit === "head"));
  assert.deepEqual(
    new Set(Object.values(result.facts).map((fact) => fact.apiVersion)),
    new Set(versions),
  );
});

void test("compares request and response schemas using read and create visibility", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-visibility-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (current: boolean) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: current ? "v2" : "v1" },
    definitions: {
      Widget: {
        type: "object",
        required: current ? ["name"] : ["name", "createToken", "readState"],
        properties: {
          name: { type: "string" },
          ...(current
            ? {}
            : {
                createToken: { type: "string", "x-ms-mutability": ["create"] },
                readState: { type: "string", readOnly: true },
              }),
        },
      },
    },
    paths: {
      "/widgets": {
        post: {
          operationId: "Widgets_Create",
          parameters: [
            {
              name: "body",
              in: "body",
              required: true,
              schema: { $ref: "#/definitions/Widget" },
            },
          ],
          responses: {
            200: { schema: { $ref: "#/definitions/Widget" } },
          },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "target.json"), document(true));
  writeJson(path.join(work, "source", "source-index.json"), {
    sourceChanges: [{ id: "source-1", declarations: [] }],
  });
  writeJson(path.join(work, "manifest.json"), {
    projects: [
      {
        id: "p",
        sourceChangeIds: ["source-1"],
        artifactComparison: { mode: "new-api-version" },
        artifacts: {
          baseline: { autorest: artifact("base.json") },
          target: { autorest: artifact("target.json") },
        },
      },
    ],
  });

  const result = analyzeRestBreaking({ manifest: path.join(work, "manifest.json") });
  assert.deepEqual(
    result.candidates.map((candidate) => candidate.contractChange?.location).sort(),
    ["request body.createToken", "response 200.readState"],
  );
  assert.deepEqual(result.blockers, []);
});

void test("blocks changed contracts with ambiguous visibility metadata", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-visibility-blocker-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (mutability: string[]) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets": {
        post: {
          operationId: "Widgets_Create",
          parameters: [
            {
              name: "body",
              in: "body",
              required: true,
              schema: {
                type: "object",
                properties: {
                  token: { type: "string", "x-ms-mutability": mutability },
                },
              },
            },
          ],
          responses: { 200: { description: "OK" } },
        },
      },
    },
  });
  const artifact = (file: string) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  writeJson(path.join(work, "base.json"), document(["create"]));
  writeJson(path.join(work, "target.json"), document(["create", "unknown"]));
  writeJson(path.join(work, "source", "source-index.json"), {
    sourceChanges: [{ id: "source-1", declarations: [] }],
  });
  writeJson(path.join(work, "manifest.json"), {
    projects: [
      {
        id: "p",
        sourceChangeIds: ["source-1"],
        artifacts: {
          baseline: { autorest: artifact("base.json") },
          target: { autorest: artifact("target.json") },
        },
      },
    ],
  });

  const result = analyzeRestBreaking({ manifest: path.join(work, "manifest.json") });
  assert.deepEqual(result.candidates, []);
  assert.equal(result.blockers[0].code, "autorest-contract-unresolved");
  assert.match(result.blockers[0].message, /ambiguous visibility metadata/);
});

void test("excludes only proven singleton API-version selector changes, not other parameter changes", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-selector-test-"));
  context.onTestFinished(() => fs.rmSync(work, { recursive: true, force: true }));
  for (const scenario of [
    "selector-only",
    "requiredness",
    "extra-value",
    "other-parameter",
    "existing-version",
  ]) {
    const document = (current: boolean) => ({
      swagger: "2.0",
      info: { title: "Widgets", version: current ? "v2" : "v1" },
      paths: {
        "/widgets": {
          get: {
            operationId: "Widgets_List",
            parameters: [
              {
                name: scenario === "other-parameter" ? "mode" : "api-version",
                in: "query",
                required: scenario === "requiredness" ? current : true,
                type: "string",
                enum:
                  scenario === "extra-value" && !current
                    ? ["v1", "legacy"]
                    : [current ? "v2" : "v1"],
                default: current ? "v2" : "v1",
              },
            ],
            responses: { 200: { description: "OK" } },
          },
        },
      },
    });
    writeJson(path.join(work, "base.json"), document(false));
    writeJson(path.join(work, "target.json"), document(true));
    writeJson(path.join(work, "source", "source-index.json"), {
      sourceChanges: [{ id: "source-1", declarations: [] }],
    });
    const artifact = (file: string) => ({
      status: "succeeded",
      format: "swagger-2.0",
      files: [{ path: file, documentRole: "primary" }],
    });
    writeJson(path.join(work, "manifest.json"), {
      projects: [
        {
          id: "p",
          sourceChangeIds: ["source-1"],
          artifactComparison: {
            mode: scenario === "existing-version" ? "existing-api-version" : "new-api-version",
          },
          artifacts: {
            baseline: { autorest: artifact("base.json") },
            target: { autorest: artifact("target.json") },
          },
        },
      ],
    });
    const result = analyzeRestBreaking({ manifest: path.join(work, "manifest.json") });
    assert.equal(result.candidates.length === 0, scenario === "selector-only", scenario);
    if (scenario === "requiredness") {
      assert.ok(result.candidates.some((candidate) => candidate.rule === "parameter-required"));
    }
  }
});
