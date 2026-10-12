import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { analyzeSemanticIntents, dedupePublicationHunks } from "./analyze-semantic-intents.mjs";

/** @typedef {import("node:test").TestContext} TestContext */
/** @typedef {import("./runtime-types.js").InternalSemanticUnit} InternalSemanticUnit */
/** @typedef {import("./runtime-types.js").OpenApiSchema} OpenApiSchema */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {Parameters<typeof analyzeSemanticIntents>[0]} SemanticAnalysisOptions */
/**
 * @typedef {{
 *   operationId: string,
 *   responses: Record<string, {description: string, schema?: OpenApiSchema}>,
 *   "x-ms-long-running-operation"?: boolean,
 *   "x-ms-pageable"?: {itemName: string, nextLinkName?: string | null}
 * }} FixtureOperation
 */
/**
 * @typedef {{
 *   swagger: string,
 *   info: {title: string, version: string},
 *   paths: Record<string, Record<string, FixtureOperation>>,
 *   "x-ms-paths"?: Record<string, Record<string, FixtureOperation>>,
 *   definitions?: Record<string, OpenApiSchema>
 * }} FixtureDocument
 */
/**
 * @typedef {{
 *   name: string,
 *   kind: string,
 *   crossLanguageDefinitionId: string,
 *   apiVersions?: string[],
 *   operation: {kind: string, verb: string, path: string}
 * }} FixtureSdkMethod
 */
/**
 * @typedef {{
 *   crossLanguagePackageId: string,
 *   crossLanguageVersion: string,
 *   metadata: {apiVersions: string[]},
 *   clients: {kind: string, name: string, methods: FixtureSdkMethod[]}[]
 * }} FixtureSdk
 */
/**
 * @typedef {{
 *   id: string,
 *   path: string,
 *   sourceChangeIds: string[],
 *   artifactComparison: Record<"baseline" | "target", {sourceRevision: string, apiVersion: string}>,
 *   artifacts: Record<"baseline" | "target", {
 *     autorest: ReturnType<typeof artifact>,
 *     tcgc?: {format: string, files: {path: string}[]}
 *   }>
 * }} FixtureProject
 */
/**
 * @typedef {{
 *   id: string,
 *   path: string,
 *   status: string,
 *   hunks: {id: string, lines: string[]}[],
 *   declarations: {
 *     id: string,
 *     kind: string,
 *     qualifiedName: string,
 *     hunkIds: string[],
 *     source: {revision: string}
 *   }[]
 * }} FixtureSource
 */
/**
 * @typedef {{
 *   workRoot: string,
 *   manifest: {projects: FixtureProject[]},
 *   sourceIndex: {
 *     sourceChanges: FixtureSource[],
 *     referencedDeclarations?: Record<string, unknown>
 *   }
 * }} FixtureInputs
 */

/** @param {unknown} value @returns {asserts value is Record<string, unknown>} */
function assertRecord(value) {
  assert.ok(value !== null && typeof value === "object" && !Array.isArray(value));
}

/** @param {unknown} value @returns {asserts value is unknown[]} */
function assertArray(value) {
  assert.ok(Array.isArray(value));
}

/** @param {unknown} value @returns {asserts value is SemanticAnalysisOptions} */
function assertSemanticAnalysisOptions(value) {
  assertRecord(value);
  assert.ok("manifest" in value);
}

/** @param {unknown} value */
function analyzeFixture(value) {
  assertRecord(value);
  const manifest = value.manifest;
  assertRecord(manifest);
  const projects = manifest.projects;
  assertArray(projects);
  const sourceIndex = value.sourceIndex;
  assertRecord(sourceIndex);
  const options = {
    ...value,
    manifest: {
      ...manifest,
      projects: projects.map((project, index) => {
        assertRecord(project);
        return { path: `fixture/project-${index}`, ...project };
      }),
    },
    sourceIndex: {
      schemaVersion: 1,
      analysis: { status: "ready", authority: "test", blockers: [] },
      ...sourceIndex,
    },
  };
  assertSemanticAnalysisOptions(options);
  return analyzeSemanticIntents(options);
}

void test("writes blocked semantic output when compiler indexing is unavailable", () => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "semantic-blocked-"));
  const output = path.join(root, "semantic-intents-input.json");
  try {
    const options = /** @type {unknown} */ ({
      manifest: { projects: [] },
      sourceIndex: {
        schemaVersion: 1,
        sourceChanges: [],
        analysis: {
          status: "blocked",
          authority: "typespec-compiler",
          blockers: [{ revision: "base", message: "compiler unavailable" }],
        },
      },
      workRoot: root,
      output,
    });
    assertSemanticAnalysisOptions(options);

    const result = analyzeSemanticIntents(options);

    assert.equal(result.status, "blocked");
    assert.deepEqual(JSON.parse(fs.readFileSync(output, "utf8")), result);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

/**
 * @param {unknown} value
 * @returns {asserts value is InternalSemanticUnit[]}
 */
function assertInternalSemanticUnits(value) {
  assert.ok(Array.isArray(value));
}

/** @param {unknown} value @returns {asserts value is SourceChange[]} */
function assertSourceChanges(value) {
  assert.ok(Array.isArray(value));
}

/** @param {unknown} units @param {unknown} sources */
function dedupeFixture(units, sources) {
  assertInternalSemanticUnits(units);
  assertSourceChanges(sources);
  return dedupePublicationHunks(units, sources);
}

/** @param {string} file @param {unknown} value */
function writeJson(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, JSON.stringify(value));
}

/** @param {string} file */
function artifact(file) {
  return {
    format: "swagger-2.0",
    status: "succeeded",
    files: [{ path: file, documentRole: "primary" }],
  };
}

/** @param {TestContext} context */
function mappedOperationFixture(context) {
  const workRoot = fs.mkdtempSync(path.join(process.cwd(), ".semantic-operation-mapping-"));
  context.after(() => fs.rmSync(workRoot, { recursive: true, force: true }));
  const route = "/managedNetworks/{managedNetworkName}/batchOutboundRules";
  const qualifiedName = "ManagedNetworkSettingsPropertiesBasicResources.post";
  /** @type {FixtureOperation} */
  const operation = {
    operationId: "OutboundRules_Post",
    responses: {
      202: {
        description: "accepted",
        schema: {
          type: "object",
          properties: { value: { type: "array", items: { type: "string" } } },
        },
      },
    },
    "x-ms-long-running-operation": true,
  };
  /** @type {FixtureDocument} */
  const document = {
    swagger: "2.0",
    info: { title: "CognitiveServices", version: "v1" },
    paths: { [route]: { post: operation } },
  };
  /** @type {FixtureSdk} */
  const sdk = {
    crossLanguagePackageId: "Microsoft.CognitiveServices",
    crossLanguageVersion: "1.0",
    metadata: { apiVersions: ["v1"] },
    clients: [
      {
        kind: "client",
        name: "OutboundRules",
        methods: [
          {
            kind: "lro",
            name: "post",
            crossLanguageDefinitionId: `Microsoft.CognitiveServices.${qualifiedName}`,
            apiVersions: ["v1"],
            operation: { kind: "http", verb: "post", path: route },
          },
        ],
      },
    ],
  };
  /** @type {FixtureProject} */
  const project = {
    id: "project-cognitive",
    path: "specification/cognitive",
    sourceChangeIds: ["source-mapping"],
    artifactComparison: {
      baseline: { sourceRevision: "base", apiVersion: "v1" },
      target: { sourceRevision: "current", apiVersion: "v1" },
    },
    artifacts: {
      baseline: {
        autorest: artifact("baseline.json"),
        tcgc: { format: "tcgc-yaml", files: [{ path: "baseline.yaml" }] },
      },
      target: {
        autorest: artifact("target.json"),
        tcgc: { format: "tcgc-yaml", files: [{ path: "target.yaml" }] },
      },
    },
  };
  /** @type {FixtureSource} */
  const source = {
    id: "source-mapping",
    path: "specification/cognitive/main.tsp",
    status: "modified",
    hunks: [{ id: "hunk-mapping", lines: ["+@list"] }],
    declarations: ["base", "current"].map((revision) => ({
      id: `declaration-${revision}`,
      kind: "operation",
      qualifiedName,
      hunkIds: ["hunk-mapping"],
      source: { revision },
    })),
  };
  /** @type {FixtureInputs} */
  const inputs = {
    workRoot,
    manifest: { projects: [project] },
    sourceIndex: { sourceChanges: [source] },
  };
  for (const role of /** @type {const} */ (["baseline", "target"])) {
    writeJson(path.join(workRoot, `${role}.json`), document);
    writeJson(path.join(workRoot, `${role}.yaml`), sdk);
  }
  /** @param {string} file @param {unknown} value */
  const write = (file, value) => writeJson(path.join(workRoot, file), value);
  return { inputs, project, source, document, sdk, route, write };
}

void test("maps renamed compiler operations through TCGC HTTP identity without changing compatible wire facts", (context) => {
  const { inputs, document, sdk, route, write } = mappedOperationFixture(context);
  document.paths[route].post["x-ms-pageable"] = { itemName: "value", nextLinkName: null };
  sdk.clients[0].methods[0].kind = "lropaging";
  write("target.json", document);
  write("target.yaml", sdk);

  const result = analyzeFixture(inputs);
  assert.deepEqual(result.blockers, []);
  const unit = result.reviewUnits[0];
  assert.deepEqual(unit.ownedOperationIds, ["OutboundRules_Post"]);
  assert.equal(unit.operations.length, 1);
  const operation = unit.operations[0];
  assert.equal(operation.matchBasis, "operation-identity");
  assert.equal(operation.restChanged, false);
  assert.deepEqual(unit.changedAspects, ["paging"]);
  assert.deepEqual(unit.beforeFactIds, [operation.beforeFactId]);
  assert.deepEqual(unit.afterFactIds, [operation.afterFactId]);
  assert.ok(operation.beforeFactId);
  assert.ok(operation.afterFactId);
  assert.equal(result.facts[operation.beforeFactId].sourceRevision, "base");
  assert.equal(result.facts[operation.afterFactId].sourceRevision, "current");
  assert.equal(result.facts[operation.afterFactId].operationId, "OutboundRules_Post");
  assert.equal(result.facts[operation.beforeFactId].paging, undefined);
  assert.deepEqual(result.facts[operation.afterFactId].paging, {
    itemName: "value",
    nextLinkName: null,
  });
});

void test("retains wire changes when a renamed operation also gains paging", (context) => {
  const { inputs, document, route, write } = mappedOperationFixture(context);
  document.paths[route].post["x-ms-pageable"] = { itemName: "value" };
  const schema = document.paths[route].post.responses[202].schema;
  assert.ok(schema?.properties?.value?.items);
  schema.properties.value.items.type = "integer";
  write("target.json", document);
  assert.equal(analyzeFixture(inputs).reviewUnits[0].operations[0].restChanged, true);
});

void test("maps renamed operations with exactly unchanged REST contracts", (context) => {
  const { inputs } = mappedOperationFixture(context);
  const result = analyzeFixture(inputs);
  assert.equal(result.reviewUnits[0].operations[0].restChanged, false);
  assert.deepEqual(result.reviewUnits[0].changedAspects, []);
});

void test("reuses TCGC normalization across hunks and repeated semantic analyses", (context) => {
  const { inputs, source } = mappedOperationFixture(context);
  source.hunks.push({ id: "another-hunk", lines: ['+@doc("Changed")'] });
  for (const declaration of source.declarations) declaration.hunkIds.push("another-hunk");
  const read = context.mock.method(fs, "readFileSync");
  const first = analyzeFixture(inputs);
  assert.deepEqual(analyzeFixture(inputs), first);
  const tcgcReads = read.mock.calls.filter((call) => String(call.arguments[0]).endsWith(".yaml"));
  assert.equal(tcgcReads.length, 2);
});

void test("retains direct REST operations absent from the convenience SDK without reading TCGC", (context) => {
  const { inputs, source, document, sdk, write } = mappedOperationFixture(context);
  for (const declaration of source.declarations) declaration.qualifiedName = "OutboundRules.post";
  sdk.clients[0].methods = [];
  document.paths["/unrelated"] = {
    get: {
      operationId: "AAA_Get",
      responses: { 200: { description: "ok" } },
    },
  };
  for (const role of /** @type {const} */ (["baseline", "target"])) {
    write(`${role}.json`, document);
    write(`${role}.yaml`, sdk);
  }
  const read = context.mock.method(fs, "readFileSync");
  const result = analyzeFixture(inputs);
  assert.deepEqual(result.blockers, []);
  assert.equal(result.reviewUnits[0].operations.length, 1);
  assert.equal(result.reviewUnits[0].operations[0].matchBasis, "operation-identity");
  assert.deepEqual(result.reviewUnits[0].ownedOperationIds, ["OutboundRules_Post"]);
  assert.equal(
    read.mock.calls.filter((call) => String(call.arguments[0]).endsWith(".yaml")).length,
    0,
  );
});

void test("preserves AutoRest overload identities without consulting different TCGC query paths", (context) => {
  const { inputs, source, document, sdk, write } = mappedOperationFixture(context);
  const operations = [
    ["Directory.getProperties", "Directory_GetProperties", "?restype=directory", "getProperties"],
    ["File.listHandles", "File_ListHandles", "?comp=listhandles", "listHandles"],
  ];
  document.paths = {};
  document["x-ms-paths"] = Object.fromEntries(
    operations.map(([, operationId, route, name]) => [
      `${route}&_overload=${name}`,
      { get: { operationId, responses: { 200: { description: "ok" } } } },
    ]),
  );
  source.declarations = source.declarations.flatMap((declaration) =>
    operations.map(([qualifiedName]) => ({
      ...declaration,
      qualifiedName,
      id: `${declaration.id}-${qualifiedName}`,
    })),
  );
  sdk.clients[0].methods = operations.map(([identity, , route, name]) => ({
    name,
    kind: "basic",
    crossLanguageDefinitionId: `Storage.File.${identity}`,
    operation: { kind: "http", verb: "get", path: route },
  }));
  for (const role of ["baseline", "target"]) {
    write(`${role}.json`, document);
    write(`${role}.yaml`, sdk);
  }
  const read = context.mock.method(fs, "readFileSync");
  const result = analyzeFixture(inputs);
  assert.deepEqual(result.blockers, []);
  assert.equal(result.reviewUnits[0].operations.length, 2);
  assert.deepEqual(
    result.reviewUnits[0].ownedOperationIds,
    operations.map((item) => item[1]),
  );
  assert.ok(
    Object.values(result.facts).every((fact) => fact.path?.includes("&_overload=") === true),
  );
  assert.equal(
    read.mock.calls.filter((call) => String(call.arguments[0]).endsWith(".yaml")).length,
    0,
  );
});

void test("does not read TCGC for non-operation declarations or unmatched generic operation references", (context) => {
  const { inputs, source, document, route, write } = mappedOperationFixture(context);
  source.declarations = source.declarations.map((declaration) => ({
    ...declaration,
    kind: "model",
    qualifiedName: "Payload",
  }));
  document.paths[route].post.responses[202].schema = { $ref: "#/definitions/Payload" };
  document.definitions = { Payload: { type: "object", properties: { value: { type: "string" } } } };
  for (const role of ["baseline", "target"]) write(`${role}.json`, document);
  inputs.sourceIndex.referencedDeclarations = {
    generic: {
      id: "generic",
      kind: "operation",
      qualifiedName: "StorageOperationResponseBody",
      compilerEvidence: { referencedNames: ["Payload"] },
      source: { revision: "current" },
    },
  };
  const read = context.mock.method(fs, "readFileSync");
  const result = analyzeFixture(inputs);
  assert.equal(result.reviewUnits[0].operations.length, 1);
  assert.equal(result.reviewUnits[0].operations[0].matchBasis, "compiled-contract-containment");
  assert.equal(
    read.mock.calls.filter((call) => String(call.arguments[0]).endsWith(".yaml")).length,
    0,
  );
});

for (const scenario of [
  "missing-identity",
  "missing-route",
  "ambiguous-identity",
  "ambiguous-method-route",
  "ambiguous-rest-route",
]) {
  void test(`does not guess a TCGC operation mapping: ${scenario}`, (context) => {
    const { inputs, source, document, sdk, route, write } = mappedOperationFixture(context);
    source.declarations = source.declarations.filter((item) => item.source.revision === "current");
    const method = sdk.clients[0].methods[0];
    if (scenario === "missing-identity") method.crossLanguageDefinitionId += "Similar";
    if (scenario === "missing-route") method.operation.verb = "get";
    if (scenario === "ambiguous-identity") {
      sdk.clients[0].methods.push({
        ...method,
        crossLanguageDefinitionId: method.crossLanguageDefinitionId.replace("Microsoft", "Another"),
      });
    }
    if (scenario === "ambiguous-method-route") {
      sdk.clients[0].methods.push({
        ...method,
        operation: { ...method.operation, path: "/another" },
      });
    }
    if (scenario === "ambiguous-rest-route") {
      document["x-ms-paths"] = {
        [route]: {
          post: {
            ...document.paths[route].post,
            operationId: "Other_Post",
          },
        },
      };
      write("target.json", document);
    }
    write("target.yaml", sdk);
    const result = analyzeFixture(inputs);
    assert.equal(result.status, "ready");
    assert.deepEqual(result.reviewUnits[0].operations, []);
    assert.deepEqual(result.reviewUnits[0].ownedOperationIds, []);
    if (scenario !== "missing-identity") {
      assert.equal(result.blockers.length, 1);
      const blocker = result.blockers[0];
      assertRecord(blocker);
      assert.equal(
        blocker.code,
        scenario.startsWith("ambiguous")
          ? "tcgc-operation-mapping-ambiguous"
          : "tcgc-operation-route-unresolved",
      );
      assert.equal(blocker.comparisonRole, "target");
    }
  });
}

void test("deduplicates equivalent method projections of the same compiler operation", (context) => {
  const { inputs, sdk, write } = mappedOperationFixture(context);
  sdk.clients[0].methods.push({ ...sdk.clients[0].methods[0], name: "postProtocol" });
  write("target.yaml", sdk);
  const result = analyzeFixture(inputs);
  assert.deepEqual(result.blockers, []);
  assert.equal(result.reviewUnits[0].operations.length, 1);
});

void test("does not use a baseline method to resolve a target source declaration", (context) => {
  const { inputs, sdk, source, write } = mappedOperationFixture(context);
  source.declarations = source.declarations.filter((item) => item.source.revision === "current");
  sdk.clients[0].methods = [];
  write("target.yaml", sdk);
  assert.deepEqual(analyzeFixture(inputs).reviewUnits[0].operations, []);
});

void test("honors comparison sourceRevision rather than assuming baseline means base", (context) => {
  const { inputs, project, sdk, source, write } = mappedOperationFixture(context);
  source.declarations = source.declarations.filter((item) => item.source.revision === "current");
  project.artifactComparison.baseline.sourceRevision = "current";
  sdk.clients[0].methods = [];
  write("target.yaml", sdk);
  assert.equal(analyzeFixture(inputs).reviewUnits[0].operations.length, 1);
});

void test("does not fall back to a declaration from an unselected source revision", (context) => {
  const { inputs, project, source } = mappedOperationFixture(context);
  source.declarations = [{ ...source.declarations[0], qualifiedName: "OutboundRules.post" }];
  project.artifactComparison.baseline.sourceRevision = "current";
  assert.deepEqual(analyzeFixture(inputs).reviewUnits[0].operations, []);
});

for (const mismatch of ["package", "method"]) {
  void test(`isolates selected API version from ${mismatch} metadata`, (context) => {
    const { inputs, sdk, source, write } = mappedOperationFixture(context);
    source.declarations = source.declarations.filter((item) => item.source.revision === "current");
    if (mismatch === "package") sdk.metadata.apiVersions = ["v2"];
    else sdk.clients[0].methods[0].apiVersions = ["v2"];
    write("target.yaml", sdk);
    const result = analyzeFixture(inputs);
    assert.deepEqual(result.reviewUnits[0].operations, []);
    if (mismatch === "package") {
      const blocker = result.blockers[0];
      assertRecord(blocker);
      assert.equal(blocker.code, "tcgc-operation-version-mismatch");
    }
  });
}

void test("keeps API-version and project-specific method indexes separate", (context) => {
  const { inputs, project, sdk, document, route, write } = mappedOperationFixture(context);
  const otherProject = structuredClone(project);
  otherProject.id = "other-project";
  otherProject.path = "specification/other";
  for (const role of /** @type {const} */ (["baseline", "target"])) {
    otherProject.artifactComparison[role].apiVersion = "v2";
    otherProject.artifacts[role].tcgc = project.artifacts[role].tcgc;
    otherProject.artifacts[role].autorest = artifact("v2.json");
  }
  document.info.version = "v2";
  document.paths = {
    "/different": { post: { ...document.paths[route].post, operationId: "Other_Post" } },
  };
  write("v2.json", document);
  sdk.metadata.apiVersions = ["v1", "v2"];
  sdk.clients[0].methods.push({
    ...sdk.clients[0].methods[0],
    apiVersions: ["v2"],
    operation: { kind: "http", verb: "post", path: "/different" },
  });
  write("baseline.yaml", sdk);
  write("target.yaml", sdk);
  inputs.manifest.projects.push(otherProject);
  const result = analyzeFixture(inputs);
  assert.deepEqual(result.blockers, []);
  const units = new Map(result.reviewUnits.map((unit) => [unit.projectId, unit]));
  const projectUnit = units.get(project.id);
  const otherUnit = units.get(otherProject.id);
  assert.ok(projectUnit);
  assert.ok(otherUnit);
  assert.deepEqual(projectUnit.ownedOperationIds, ["OutboundRules_Post"]);
  assert.deepEqual(otherUnit.ownedOperationIds, ["Other_Post"]);
  assert.equal(result.facts[otherUnit.afterFactIds[0]].apiVersion, "v2");
});

void test("selects only the requested REST version from a multi-version artifact", (context) => {
  const { inputs, project, document, route, write } = mappedOperationFixture(context);
  document.info.version = "v2";
  document.paths[route].post.operationId = "WrongVersion_Post";
  write("v2.json", document);
  for (const role of /** @type {const} */ (["baseline", "target"])) {
    project.artifacts[role].autorest.files.push({ path: "v2.json", documentRole: "feature" });
  }
  const result = analyzeFixture(inputs);
  assert.deepEqual(result.blockers, []);
  assert.deepEqual(result.reviewUnits[0].ownedOperationIds, ["OutboundRules_Post"]);
  assert.ok(Object.values(result.facts).every((fact) => fact.apiVersion === "v1"));
});

void test("does not import compiler-reference operations from another project", (context) => {
  const { inputs, source } = mappedOperationFixture(context);
  const declaration = source.declarations[1];
  source.declarations = [
    {
      id: "model",
      kind: "model",
      qualifiedName: "Polling",
      hunkIds: ["hunk-mapping"],
      source: { revision: "current" },
    },
  ];
  inputs.sourceIndex.referencedDeclarations = {
    other: {
      ...declaration,
      project: "specification/other",
      compilerEvidence: { referencedNames: ["Polling"] },
    },
  };
  assert.deepEqual(analyzeFixture(inputs).reviewUnits[0].operations, []);
});

for (const missing of ["absent", "invalid"]) {
  void test(`preserves legacy REST operation matching with ${missing} TCGC artifacts`, (context) => {
    const { inputs, source, project, write } = mappedOperationFixture(context);
    for (const declaration of source.declarations) declaration.qualifiedName = "OutboundRules.post";
    for (const role of /** @type {const} */ (["baseline", "target"])) {
      if (missing === "absent") delete project.artifacts[role].tcgc;
      else write(`${role}.yaml`, {});
    }
    const result = analyzeFixture(inputs);
    assert.equal(result.status, "ready");
    assert.equal(result.reviewUnits[0].operations[0].matchBasis, "operation-identity");
    assert.equal(result.reviewUnits[0].operations[0].restChanged, false);
  });
}

void test("keeps shared hunks only in their specific semantic unit", () => {
  const units = [
    {
      id: "semantic-publication",
      sourceChangeIds: ["source-version", "source-client"],
      hunkIds: ["hunk-version", "hunk-client"],
      declarationIds: ["declaration-version", "declaration-client"],
      operations: [],
      groupingEvidence: {
        reasons: ["cross-project:api-version-publication"],
        memberHunkIds: ["hunk-version", "hunk-client"],
      },
    },
    {
      id: "semantic-client",
      sourceChangeIds: ["source-client"],
      hunkIds: ["hunk-client"],
      declarationIds: ["declaration-client"],
      operations: [],
      groupingEvidence: {
        reasons: ["sdk-compatibility"],
        memberHunkIds: ["hunk-client"],
      },
    },
  ];
  const sources = [
    {
      id: "source-version",
      hunks: [{ id: "hunk-version" }],
      declarations: [
        {
          id: "declaration-version",
          hunkIds: ["hunk-version"],
        },
      ],
    },
    {
      id: "source-client",
      hunks: [{ id: "hunk-client" }],
      declarations: [
        {
          id: "declaration-client",
          hunkIds: ["hunk-client"],
        },
      ],
    },
  ];

  const result = dedupeFixture(units, sources);

  assert.deepEqual(result[0].hunkIds, ["hunk-version"]);
  assert.deepEqual(result[0].sourceChangeIds, ["source-version"]);
  assert.deepEqual(result[0].declarationIds, ["declaration-version"]);
  assert.ok(result[0].groupingEvidence);
  assert.deepEqual(result[0].groupingEvidence.memberHunkIds, ["hunk-version"]);
  assert.deepEqual(result[1], units[1]);
});

void test("creates source-first semantic units and retains unchanged REST operations", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".semantic-analyzer-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = {
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets/{id}/cancel": {
        post: {
          operationId: "Widgets_Cancel",
          parameters: [],
          responses: { 202: { description: "accepted" } },
        },
      },
    },
  };
  writeJson(path.join(work, "base.json"), document);
  writeJson(path.join(work, "current.json"), document);
  const result = analyzeFixture({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-kept",
          sourceChangeIds: ["source-kept"],
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
          id: "source-kept",
          status: "modified",
          hunks: [{ id: "hunk-kept" }],
          declarations: [
            {
              id: "declaration-base",
              kind: "operation",
              qualifiedName: "Widgets.cancel",
              hunkIds: ["hunk-kept"],
              source: { revision: "base" },
            },
            {
              id: "declaration-current",
              kind: "operation",
              qualifiedName: "Widgets.cancel",
              hunkIds: ["hunk-kept"],
              source: { revision: "current" },
            },
          ],
        },
      ],
    },
  });

  assert.equal(result.status, "ready");
  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].action, "modify");
  assert.equal(result.reviewUnits[0].operations[0].operationId, "Widgets_Cancel");
  assert.equal(result.reviewUnits[0].operations[0].restChanged, false);
  assert.deepEqual(result.reviewUnits[0].operations[0].sourceChangeIds, ["source-kept"]);
  assert.deepEqual(result.reviewUnits[0].operations[0].hunkIds, ["hunk-kept"]);
  assert.deepEqual(result.reviewUnits[0].hunkIds, ["hunk-kept"]);
});

void test("maps a top-level TypeSpec operation to its AutoRest operation ID", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".semantic-top-level-operation-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = {
    swagger: "2.0",
    info: { title: "Ledger", version: "v1" },
    paths: {
      "/app/transactions": {
        post: {
          operationId: "CreateLedgerEntry",
          parameters: [],
          responses: { 200: { description: "ok" } },
        },
      },
    },
  };
  writeJson(path.join(work, "base.json"), document);
  writeJson(path.join(work, "current.json"), document);
  const result = analyzeFixture({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-ledger",
          sourceChangeIds: ["source-ledger"],
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
          id: "source-ledger",
          status: "modified",
          hunks: [{ id: "hunk-ledger" }],
          declarations: [
            {
              id: "declaration-base",
              kind: "operation",
              qualifiedName: "createLedgerEntry",
              hunkIds: ["hunk-ledger"],
              source: { revision: "base" },
            },
            {
              id: "declaration-current",
              kind: "operation",
              qualifiedName: "createLedgerEntry",
              hunkIds: ["hunk-ledger"],
              source: { revision: "current" },
            },
          ],
        },
      ],
    },
  });

  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].operations[0].operationId, "CreateLedgerEntry");
  assert.equal(result.reviewUnits[0].operations[0].matchBasis, "operation-identity");
});

void test("retains a semantic unit when changed TypeSpec has no REST operation", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".semantic-no-rest-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = {
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {},
  };
  writeJson(path.join(work, "base.json"), document);
  writeJson(path.join(work, "current.json"), document);
  const result = analyzeFixture({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-kept",
          sourceChangeIds: ["source-kept"],
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
          id: "source-kept",
          status: "added",
          hunks: [{ id: "hunk-kept" }],
          declarations: [
            {
              id: "declaration-current",
              kind: "alias",
              qualifiedName: "InternalName",
              hunkIds: ["hunk-kept"],
              source: { revision: "current" },
            },
          ],
        },
      ],
    },
  });

  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].action, "add");
  assert.deepEqual(result.reviewUnits[0].operations, []);
});

void test("maps a changed model to an operation through changed TypeSpec references", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".semantic-source-reference-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = {
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets/{id}": {
        get: {
          operationId: "Widgets_Get",
          responses: { 200: { description: "ok", schema: { type: "object" } } },
        },
      },
    },
  };
  writeJson(path.join(work, "base.json"), document);
  writeJson(path.join(work, "current.json"), document);
  const result = analyzeFixture({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-kept",
          sourceChangeIds: ["model-source", "operation-source"],
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
          id: "model-source",
          status: "added",
          hunks: [{ id: "model-hunk", lines: ["+model PollingResponse {}"] }],
          declarations: [
            {
              id: "model",
              kind: "model",
              qualifiedName: "PollingResponse",
              hunkIds: ["model-hunk"],
              source: { revision: "current" },
            },
          ],
        },
        {
          id: "operation-source",
          status: "modified",
          hunks: [
            {
              id: "operation-hunk",
              lines: ["+  get is ArmResourceRead<Widget, Response = PollingResponse>;"],
            },
          ],
          declarations: [
            {
              id: "operation",
              kind: "operation",
              qualifiedName: "Widgets.get",
              hunkIds: ["operation-hunk"],
              compilerEvidence: { referencedNames: ["PollingResponse"] },
              source: { revision: "current" },
            },
          ],
        },
      ],
    },
  });
  const modelUnit = result.reviewUnits.find((item) =>
    item.sourceChangeIds.includes("model-source"),
  );
  assert.ok(modelUnit, JSON.stringify(result));
  assert.equal(modelUnit.operations[0].operationId, "Widgets_Get");
  assert.equal(modelUnit.operations[0].matchBasis, "operation-identity");
});

void test("classifies a new API surface as add despite modified registration code", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".semantic-added-feature-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  writeJson(path.join(work, "base.json"), {
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {},
  });
  writeJson(path.join(work, "current.json"), {
    swagger: "2.0",
    info: { title: "Widgets", version: "v2" },
    paths: {
      "/widgets": {
        put: {
          operationId: "Widgets_Create",
          responses: { 200: { description: "ok" } },
        },
      },
    },
  });
  const result = analyzeFixture({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-widgets",
          sourceChangeIds: ["feature-source", "main-source"],
          artifactComparison: { mode: "new-api-version" },
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
          id: "feature-source",
          path: "specification/widgets/Widget.tsp",
          status: "added",
          hunks: [{ id: "feature-hunk", lines: ["+op create(): void;"] }],
          declarations: [
            {
              id: "feature-operation",
              kind: "operation",
              qualifiedName: "Widgets.create",
              hunkIds: ["feature-hunk"],
              source: { revision: "current" },
            },
          ],
        },
        {
          id: "main-source",
          path: "specification/widgets/main.tsp",
          status: "modified",
          hunks: [{ id: "main-hunk", lines: ['+import "./Widget.tsp";'] }],
          declarations: [
            {
              id: "main-base",
              kind: "namespace",
              qualifiedName: "Widgets",
              hunkIds: ["main-hunk"],
              source: { revision: "base" },
            },
            {
              id: "main-current",
              kind: "namespace",
              qualifiedName: "Widgets",
              hunkIds: ["main-hunk"],
              source: { revision: "current" },
            },
          ],
        },
      ],
    },
  });

  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].action, "add");
  assert.deepEqual(
    result.reviewUnits[0].operations.map((operation) => operation.operationId),
    ["Widgets_Create"],
  );
});

void test("keeps mixed added and changed operations classified as modify", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".semantic-mixed-action-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  writeJson(path.join(work, "base.json"), {
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets/{id}": {
        get: {
          operationId: "Widgets_Get",
          responses: { 200: { description: "ok" } },
        },
      },
    },
  });
  writeJson(path.join(work, "current.json"), {
    swagger: "2.0",
    info: { title: "Widgets", version: "v2" },
    paths: {
      "/widgets": {
        put: {
          operationId: "Widgets_Create",
          responses: { 200: { description: "ok" } },
        },
      },
      "/widgets/{id}": {
        get: {
          operationId: "Widgets_Get",
          responses: { 201: { description: "created" } },
        },
      },
    },
  });
  const result = analyzeFixture({
    workRoot: work,
    manifest: {
      projects: [
        {
          id: "project-widgets",
          sourceChangeIds: ["feature-source", "main-source"],
          artifactComparison: { mode: "new-api-version" },
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
          id: "feature-source",
          path: "specification/widgets/Widget.tsp",
          status: "added",
          hunks: [{ id: "feature-hunk", lines: ["+op create(): void;"] }],
          declarations: [
            {
              id: "feature-operation",
              kind: "operation",
              qualifiedName: "Widgets.create",
              hunkIds: ["feature-hunk"],
              source: { revision: "current" },
            },
          ],
        },
        {
          id: "main-source",
          path: "specification/widgets/main.tsp",
          status: "added",
          hunks: [{ id: "main-hunk", lines: ["-op get(): Widget;", "+op get(): CreatedWidget;"] }],
          declarations: [
            {
              id: "get-base",
              kind: "operation",
              qualifiedName: "Widgets.get",
              hunkIds: ["main-hunk"],
              source: { revision: "base" },
            },
            {
              id: "get-current",
              kind: "operation",
              qualifiedName: "Widgets.get",
              hunkIds: ["main-hunk"],
              source: { revision: "current" },
            },
          ],
        },
      ],
    },
  });

  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].action, "modify");
  assert.deepEqual(
    result.reviewUnits[0].operations.map((operation) => operation.operationId),
    ["Widgets_Create", "Widgets_Get"],
  );
});
