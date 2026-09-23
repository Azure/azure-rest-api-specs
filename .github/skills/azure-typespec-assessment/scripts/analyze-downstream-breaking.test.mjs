import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import { stringify } from "yaml";
import { analyzeDownstreamBreaking } from "./analyze-downstream-breaking.mjs";

/** @typedef {import("node:test").TestContext} TestContext */

/** @param {boolean} current */
function packageShape(current) {
  const stringType = { kind: "string" };
  const widgetType = {
    kind: "model",
    name: "ScenarioRun",
    crossLanguageDefinitionId: "Microsoft.Chaos.ScenarioRun",
  };
  return {
    crossLanguagePackageId: "Microsoft.Chaos",
    crossLanguageVersion: "1",
    metadata: { apiVersions: ["v1"] },
    clients: [
      {
        kind: "client",
        name: "ScenarioRuns",
        crossLanguageDefinitionId: "Microsoft.Chaos.ScenarioRuns",
        children: [],
        methods: [
          {
            kind: current ? "lro" : "basic",
            name: "cancel",
            access: "public",
            crossLanguageDefinitionId: "Microsoft.Chaos.ScenarioRuns.cancel",
            parameters: [
              {
                kind: "method",
                name: "runId",
                optional: false,
                onClient: false,
                type: stringType,
              },
            ],
            operation: {
              kind: "http",
              path: "/runs/{runId}/cancel",
              uriTemplate: "/runs/{runId}/cancel",
              verb: "post",
              parameters: [],
              responses: [{ statusCodes: 202 }],
              exceptions: [{ statusCodes: "*" }],
            },
            response: current ? { kind: "method", type: widgetType } : { kind: "method" },
            lroMetadata: current
              ? {
                  finalStateVia: "location",
                  pollingStep: { responseBody: widgetType },
                  operation: {
                    kind: "http",
                    path: "/runs/{runId}/cancel",
                    uriTemplate: "/runs/{runId}/cancel",
                    verb: "post",
                  },
                  logicalResult: widgetType,
                  pollingInfo: {
                    kind: "pollingOperationStep",
                    responseModel: widgetType,
                    terminationStatus: { kind: "status-code" },
                  },
                  envelopeResult: widgetType,
                }
              : undefined,
          },
        ],
      },
    ],
    models: [
      {
        ...widgetType,
        access: "public",
        usage: 3,
        properties: current
          ? []
          : [
              {
                kind: "property",
                name: "status",
                serializedName: "status",
                optional: false,
                discriminator: false,
                type: stringType,
              },
            ],
      },
    ],
    enums: [],
    unions: [],
    namespaces: [],
  };
}

/**
 * @param {boolean} current
 * @param {string} [finalStateVia]
 */
function parameterOnlyLroShape(current, finalStateVia = "azure-async-operation") {
  const shape = packageShape(true);
  const method = shape.clients[0].methods[0];
  method.parameters = [
    ...method.parameters,
    ...(current
      ? [
          {
            kind: "method",
            name: "afcManagedSync",
            optional: true,
            onClient: false,
            type: { kind: "boolean" },
          },
        ]
      : []),
  ];
  method.operation.uriTemplate = current
    ? "/runs/{runId}/cancel?api-version,afcManagedSync"
    : "/runs/{runId}/cancel?api-version";
  assert.ok(method.lroMetadata);
  method.lroMetadata.finalStateVia = finalStateVia;
  method.lroMetadata.operation.uriTemplate = method.operation.uriTemplate;
  return shape;
}

/** @param {boolean} current */
function nestedResponseShape(current) {
  const shape = packageShape(false);
  const method = shape.clients[0].methods[0];
  method.name = "listFilesAndDirectoriesSegment";
  method.crossLanguageDefinitionId = "Storage.File.Directory.listFilesAndDirectoriesSegment";
  method.response = {
    kind: "method",
    type: {
      kind: "model",
      name: "ListFilesAndDirectoriesSegmentResponse",
      crossLanguageDefinitionId: "Storage.File.ListFilesAndDirectoriesSegmentResponse",
    },
  };
  /** @param {string} name @param {unknown} type */
  const property = (name, type) => ({
    kind: "property",
    name,
    serializedName: name,
    optional: true,
    discriminator: false,
    type,
  });
  const mutableShape = /** @type {{
    models: (Record<string, unknown> & {
      properties: ReturnType<typeof property>[]
    })[]
  }} */ (/** @type {unknown} */ (shape));
  mutableShape.models = [
    {
      kind: "model",
      name: "ListFilesAndDirectoriesSegmentResponse",
      crossLanguageDefinitionId: "Storage.File.ListFilesAndDirectoriesSegmentResponse",
      access: "public",
      usage: 2,
      properties: [
        property("segment", {
          kind: "model",
          name: "FilesAndDirectoriesListSegment",
          crossLanguageDefinitionId: "Storage.File.FilesAndDirectoriesListSegment",
        }),
      ],
    },
    {
      kind: "model",
      name: "FilesAndDirectoriesListSegment",
      crossLanguageDefinitionId: "Storage.File.FilesAndDirectoriesListSegment",
      access: "public",
      usage: 2,
      properties: current
        ? []
        : [
            property("blockDeviceItems", {
              kind: "array",
              valueType: {
                kind: "model",
                name: "BlockDeviceItem",
                crossLanguageDefinitionId: "Storage.File.BlockDeviceItem",
              },
            }),
          ],
    },
    {
      kind: "model",
      name: "BlockDeviceItem",
      crossLanguageDefinitionId: "Storage.File.BlockDeviceItem",
      access: "public",
      usage: 2,
      properties: [],
    },
  ];
  return shape;
}

/**
 * @param {TestContext} context
 * @param {unknown} base
 * @param {unknown} current
 * @param {Record<string, unknown>[]} [declarations]
 * @param {{id: string, declarations: Record<string, unknown>[]}[]} [suppliedSources]
 */
function analyzeShapes(context, base, current, declarations = [], suppliedSources) {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".downstream-analyzer-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  fs.writeFileSync(path.join(work, "base.yaml"), stringify(base));
  fs.writeFileSync(path.join(work, "current.yaml"), stringify(current));
  /** @param {string} file */
  const artifact = (file) => ({
    status: "succeeded",
    format: "tcgc-yaml",
    files: [{ path: file }],
  });
  const sourceChanges = suppliedSources ?? [
    {
      id: "source-supplied",
      declarations: [{ id: "declaration-supplied", decorators: [] }, ...declarations],
    },
  ];
  const options = {
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-1",
          sourceChangeIds: sourceChanges.map((item) => item.id),
          artifacts: {
            base: { tcgc: artifact("base.yaml") },
            current: { tcgc: artifact("current.yaml") },
          },
        },
      ],
    },
    sourceIndex: { sourceChanges },
  };
  return analyzeDownstreamBreaking(
    /** @type {Parameters<typeof analyzeDownstreamBreaking>[0]} */ (
      /** @type {unknown} */ (options)
    ),
  );
}

void test("detects PR 43308-style kind/response/LRO changes without inventing parameter changes", (context) => {
  const result = analyzeShapes(context, packageShape(false), packageShape(true));
  const rules = new Set(result.candidates.map((item) => item.rule));
  assert.ok(rules.has("method-kind-changed"));
  assert.ok(rules.has("method-response-changed"));
  assert.ok(rules.has("method-lro-changed"));
  assert.ok(rules.has("model-property-removed"));
  assert.ok(!rules.has("method-parameters-changed"));
  assert.ok(result.candidates.every((item) => item.sourceChangeIds[0] === "source-supplied"));
  assert.ok(
    result.candidates.every((item) =>
      item.crossLanguageDefinitionId.startsWith("Microsoft.Chaos."),
    ),
  );
  assert.ok(
    Object.values(result.facts).some((item) => item.factKind === "method" && item.kind === "lro"),
  );
});

void test("retains response-header evidence without changing established candidate IDs", (context) => {
  const withoutHeaders = analyzeShapes(context, packageShape(false), packageShape(true));
  const base = packageShape(false);
  const current = packageShape(true);
  for (const shape of [base, current]) {
    const operation = /** @type {{
      responses: {headers?: Record<string, unknown>[]}[],
      exceptions: {headers?: Record<string, unknown>[]}[]
    }} */ (/** @type {unknown} */ (shape.clients[0].methods[0].operation));
    operation.responses[0].headers = [
      {
        kind: "responseheader",
        name: "location",
        serializedName: "Location",
        optional: true,
        type: { kind: "string" },
      },
    ];
    operation.exceptions[0].headers = [];
  }
  const withHeaders = analyzeShapes(context, base, current);

  assert.deepEqual(
    withHeaders.candidates.map((item) => item.id),
    withoutHeaders.candidates.map((item) => item.id),
  );
  assert.ok(
    Object.values(withHeaders.facts).some(
      (fact) =>
        fact.factKind === "method" &&
        fact.operation?.responses?.[0]?.headers?.[0]?.serializedName === "Location",
    ),
  );
});

void test("does not emit an LRO finding when only a public parameter and nested URI template change", (context) => {
  const result = analyzeShapes(context, parameterOnlyLroShape(false), parameterOnlyLroShape(true));
  const rules = result.candidates.map((item) => item.rule);

  assert.ok(rules.includes("method-parameters-changed"));
  assert.ok(!rules.includes("method-lro-changed"));
});

void test("retains actual LRO behavior changes", (context) => {
  const result = analyzeShapes(
    context,
    parameterOnlyLroShape(false, "location"),
    parameterOnlyLroShape(false, "azure-async-operation"),
  );

  assert.ok(result.candidates.some((item) => item.rule === "method-lro-changed"));
  assert.ok(!result.candidates.some((item) => item.rule === "method-parameters-changed"));
});

void test("reports SDK method identity changes when matching by HTTP route", (context) => {
  const base = packageShape(false);
  const current = packageShape(false);
  const method = current.clients[0].methods[0];
  method.name = "abort";
  method.crossLanguageDefinitionId = "Microsoft.Chaos.ScenarioRuns.abort";

  const result = analyzeShapes(context, base, current);

  assert.ok(result.candidates.some((item) => item.rule === "method-identity-changed"));
  assert.ok(!result.candidates.some((item) => item.rule === "method-removed"));
});

void test("detects model base and discriminator hierarchy changes", (context) => {
  /** @type {[string, (model: Record<string, unknown>, current: boolean) => void][]} */
  const cases = [
    [
      "base model",
      (model, current) => {
        model.baseModel = {
          kind: "model",
          name: current ? "NewBase" : "OldBase",
          crossLanguageDefinitionId: `Microsoft.Chaos.${current ? "NewBase" : "OldBase"}`,
        };
      },
    ],
    [
      "discriminator property",
      (model, current) => {
        model.discriminatorProperty = { name: current ? "type" : "kind" };
      },
    ],
    [
      "discriminator value",
      (model, current) => {
        model.discriminatorValue = current ? "chaos" : "scenario";
      },
    ],
    [
      "polymorphic subtypes",
      (model, current) => {
        model.discriminatedSubtypes = {
          [current ? "chaos" : "scenario"]: {
            kind: "model",
            name: current ? "ChaosRun" : "ScenarioRunDetails",
            crossLanguageDefinitionId: `Microsoft.Chaos.${current ? "ChaosRun" : "ScenarioRunDetails"}`,
          },
        };
      },
    ],
  ];

  for (const [label, configure] of cases) {
    const base = packageShape(true);
    const current = packageShape(true);
    configure(base.models[0], false);
    configure(current.models[0], true);
    const result = analyzeShapes(context, base, current);
    assert.ok(
      result.candidates.some((item) => item.rule === "model-hierarchy-changed"),
      label,
    );
  }
});

void test("limits downstream evidence to matching declarations and hunks", (context) => {
  const base = packageShape(false);
  const current = packageShape(false);
  current.models[0].properties = [];
  /**
   * @param {string} id
   * @param {string} kind
   * @param {string} qualifiedName
   * @param {string} revision
   * @param {string} hunkId
   */
  const declaration = (id, kind, qualifiedName, revision, hunkId) => ({
    id,
    kind,
    qualifiedName,
    hunkIds: [hunkId],
    decorators: [],
    source: { revision },
  });
  const result = analyzeShapes(
    context,
    base,
    current,
    [],
    [
      {
        id: "scenario-source",
        declarations: [
          declaration("scenario-model", "model", "ScenarioRun", "current", "scenario-model-hunk"),
          declaration(
            "scenario-status",
            "property",
            "ScenarioRun.status",
            "base",
            "scenario-status-hunk",
          ),
        ],
      },
      {
        id: "unrelated-source",
        declarations: [declaration("other-model", "model", "Unrelated", "current", "other-hunk")],
      },
    ],
  );
  const candidate = result.candidates.find((item) => item.rule === "model-property-removed");

  assert.ok(candidate);
  assert.deepEqual(candidate.sourceChangeIds, ["scenario-source"]);
  assert.deepEqual(candidate.declarationIds, ["scenario-status"]);
  assert.deepEqual(candidate.hunkIds, ["scenario-status-hunk"]);
});

void test("detects augment and qualified SDK customization decorators", (context) => {
  /**
   * @param {string} id
   * @param {string} qualifiedName
   * @param {string} revision
   * @param {unknown} decorator
   */
  const declaration = (id, qualifiedName, revision, decorator) => ({
    id,
    qualifiedName,
    decorators: [decorator],
    source: { revision },
  });
  const result = analyzeShapes(context, packageShape(false), packageShape(false), [
    declaration(
      "location-base",
      "Microsoft.Chaos.ScenarioRuns.cancel",
      "base",
      '@@clientLocation(ScenarioRuns.cancel, Microsoft.Chaos, "go")',
    ),
    declaration(
      "location-current",
      "Microsoft.Chaos.ScenarioRuns.cancel",
      "current",
      '@@clientLocation(ScenarioRuns.cancel, Microsoft.Chaos, "python")',
    ),
    declaration(
      "name-base",
      "Microsoft.Chaos.ScenarioRun",
      "base",
      '@@Azure.ClientGenerator.Core.clientName(ScenarioRun, "ScenarioRun")',
    ),
    declaration(
      "name-current",
      "Microsoft.Chaos.ScenarioRun",
      "current",
      '@@Azure.ClientGenerator.Core.clientName(ScenarioRun, "ChaosScenarioRun")',
    ),
  ]);
  const customizations = result.candidates.filter((item) => item.rule === "customization-changed");

  assert.equal(customizations.length, 2);
  assert.deepEqual(customizations.map((item) => item.crossLanguageDefinitionId).sort(), [
    "Microsoft.Chaos.ScenarioRun",
    "Microsoft.Chaos.ScenarioRuns.cancel",
  ]);
});

void test("links nested response type changes to unchanged public methods", (context) => {
  const result = analyzeShapes(context, nestedResponseShape(false), nestedResponseShape(true));
  const propertyCandidate = result.candidates.find(
    (item) => item.rule === "model-property-removed",
  );

  assert.ok(propertyCandidate);
  assert.ok(!result.candidates.some((item) => item.rule === "method-response-changed"));
  const root = result.rootCauses.find((item) =>
    item.directCandidateIds.includes(propertyCandidate.id),
  );
  assert.ok(root);
  assert.equal(root.kind, "type-contract-propagation");
  assert.equal(root.methodFactIds.length, 1);
  assert.ok(
    root.referenceEvidence.some(
      (edge) => edge.kind === "response" && edge.location === "response-body",
    ),
  );
  assert.ok(
    root.referenceEvidence.some(
      (edge) =>
        edge.kind === "property" &&
        edge.memberName === "segment" &&
        edge.location === "response-body",
    ),
  );
  assert.ok(
    Object.values(result.facts).some(
      (fact) =>
        fact.factKind === "method" &&
        fact.crossLanguageDefinitionId === "Storage.File.Directory.listFilesAndDirectoriesSegment",
    ),
  );
});
