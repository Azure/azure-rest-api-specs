import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import {
  analyzeSemanticIntents,
  dedupePublicationHunks,
} from "./analyze-semantic-intents.mjs";

function writeJson(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, JSON.stringify(value));
}

function artifact(file) {
  return {
    format: "swagger-2.0",
    status: "succeeded",
    files: [{ path: file, documentRole: "primary" }],
  };
}

function mappedOperationFixture(context) {
  const workRoot = fs.mkdtempSync(path.join(process.cwd(), ".semantic-operation-mapping-"));
  context.after(() => fs.rmSync(workRoot, { recursive: true, force: true }));
  const route = "/managedNetworks/{managedNetworkName}/batchOutboundRules";
  const qualifiedName = "ManagedNetworkSettingsPropertiesBasicResources.post";
  const document = {
    swagger: "2.0",
    info: { title: "CognitiveServices", version: "v1" },
    paths: { [route]: { post: {
      operationId: "OutboundRules_Post",
      responses: { 202: { description: "accepted", schema: {
        type: "object", properties: { value: { type: "array", items: { type: "string" } } },
      } } },
      "x-ms-long-running-operation": true,
    } } },
  };
  const sdk = {
    crossLanguagePackageId: "Microsoft.CognitiveServices",
    crossLanguageVersion: "1.0",
    metadata: { apiVersions: ["v1"] },
    clients: [{ kind: "client", name: "OutboundRules", methods: [{
      kind: "lro",
      name: "post",
      crossLanguageDefinitionId: `Microsoft.CognitiveServices.${qualifiedName}`,
      apiVersions: ["v1"],
      operation: { kind: "http", verb: "post", path: route },
    }] }],
  };
  const project = {
    id: "project-cognitive",
    path: "specification/cognitive",
    sourceChangeIds: ["source-mapping"],
    artifactComparison: {
      baseline: { sourceRevision: "base", apiVersion: "v1" },
      target: { sourceRevision: "current", apiVersion: "v1" },
    },
    artifacts: Object.fromEntries(["baseline", "target"].map((role) => [role, {
      autorest: artifact(`${role}.json`),
      tcgc: { format: "tcgc-yaml", files: [{ path: `${role}.yaml` }] },
    }])),
  };
  const source = {
    id: "source-mapping", path: "specification/cognitive/main.tsp", status: "modified",
    hunks: [{ id: "hunk-mapping", lines: ["+@list"] }],
    declarations: ["base", "current"].map((revision) => ({
      id: `declaration-${revision}`, kind: "operation", qualifiedName,
      hunkIds: ["hunk-mapping"], source: { revision },
    })),
  };
  const inputs = { workRoot, manifest: { projects: [project] }, sourceIndex: { sourceChanges: [source] } };
  for (const role of ["baseline", "target"]) {
    writeJson(path.join(workRoot, `${role}.json`), document);
    writeJson(path.join(workRoot, `${role}.yaml`), sdk);
  }
  return { inputs, project, source, document, sdk, route,
    write: (file, value) => writeJson(path.join(workRoot, file), value) };
}

test("maps renamed compiler operations through TCGC HTTP identity without changing compatible wire facts", (context) => {
  const { inputs, document, sdk, route, write } = mappedOperationFixture(context);
  document.paths[route].post["x-ms-pageable"] = { itemName: "value", nextLinkName: null };
  sdk.clients[0].methods[0].kind = "lropaging";
  write("target.json", document);
  write("target.yaml", sdk);

  const result = analyzeSemanticIntents(inputs);
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
  assert.equal(result.facts[operation.beforeFactId].sourceRevision, "base");
  assert.equal(result.facts[operation.afterFactId].sourceRevision, "current");
  assert.equal(result.facts[operation.afterFactId].operationId, "OutboundRules_Post");
  assert.equal(result.facts[operation.beforeFactId].paging, undefined);
  assert.deepEqual(result.facts[operation.afterFactId].paging, { itemName: "value", nextLinkName: null });
});

test("retains wire changes when a renamed operation also gains paging", (context) => {
  const { inputs, document, route, write } = mappedOperationFixture(context);
  document.paths[route].post["x-ms-pageable"] = { itemName: "value" };
  document.paths[route].post.responses[202].schema.properties.value.items.type = "integer";
  write("target.json", document);
  assert.equal(analyzeSemanticIntents(inputs).reviewUnits[0].operations[0].restChanged, true);
});

test("maps renamed operations with exactly unchanged REST contracts", (context) => {
  const { inputs } = mappedOperationFixture(context);
  const result = analyzeSemanticIntents(inputs);
  assert.equal(result.reviewUnits[0].operations[0].restChanged, false);
  assert.deepEqual(result.reviewUnits[0].changedAspects, []);
});

test("reuses TCGC normalization across hunks and repeated semantic analyses", (context) => {
  const { inputs, source } = mappedOperationFixture(context);
  source.hunks.push({ id: "another-hunk", lines: ["+@doc(\"Changed\")"] });
  for (const declaration of source.declarations) declaration.hunkIds.push("another-hunk");
  const read = context.mock.method(fs, "readFileSync");
  const first = analyzeSemanticIntents(inputs);
  assert.deepEqual(analyzeSemanticIntents(inputs), first);
  const tcgcReads = read.mock.calls.filter((call) => String(call.arguments[0]).endsWith(".yaml"));
  assert.equal(tcgcReads.length, 2);
});

test("retains direct REST operations absent from the convenience SDK without reading TCGC", (context) => {
  const { inputs, source, document, sdk, write } = mappedOperationFixture(context);
  for (const declaration of source.declarations) declaration.qualifiedName = "OutboundRules.post";
  sdk.clients[0].methods = [];
  document.paths["/unrelated"] = { get: {
    operationId: "AAA_Get", responses: { 200: { description: "ok" } },
  } };
  for (const role of ["baseline", "target"]) {
    write(`${role}.json`, document);
    write(`${role}.yaml`, sdk);
  }
  const read = context.mock.method(fs, "readFileSync");
  const result = analyzeSemanticIntents(inputs);
  assert.deepEqual(result.blockers, []);
  assert.equal(result.reviewUnits[0].operations.length, 1);
  assert.equal(result.reviewUnits[0].operations[0].matchBasis, "operation-identity");
  assert.deepEqual(result.reviewUnits[0].ownedOperationIds, ["OutboundRules_Post"]);
  assert.equal(read.mock.calls.filter((call) => String(call.arguments[0]).endsWith(".yaml")).length, 0);
});

test("preserves AutoRest overload identities without consulting different TCGC query paths", (context) => {
  const { inputs, source, document, sdk, write } = mappedOperationFixture(context);
  const operations = [
    ["Directory.getProperties", "Directory_GetProperties", "?restype=directory", "getProperties"],
    ["File.listHandles", "File_ListHandles", "?comp=listhandles", "listHandles"],
  ];
  document.paths = {};
  document["x-ms-paths"] = Object.fromEntries(operations.map(([, operationId, route, name]) => [
    `${route}&_overload=${name}`, { get: { operationId, responses: { 200: { description: "ok" } } } },
  ]));
  source.declarations = source.declarations.flatMap((declaration) => operations.map(([qualifiedName]) => ({
    ...declaration, qualifiedName, id: `${declaration.id}-${qualifiedName}`,
  })));
  sdk.clients[0].methods = operations.map(([identity, , route, name]) => ({
    name, kind: "basic", crossLanguageDefinitionId: `Storage.File.${identity}`,
    operation: { kind: "http", verb: "get", path: route },
  }));
  for (const role of ["baseline", "target"]) {
    write(`${role}.json`, document);
    write(`${role}.yaml`, sdk);
  }
  const read = context.mock.method(fs, "readFileSync");
  const result = analyzeSemanticIntents(inputs);
  assert.deepEqual(result.blockers, []);
  assert.equal(result.reviewUnits[0].operations.length, 2);
  assert.deepEqual(result.reviewUnits[0].ownedOperationIds, operations.map((item) => item[1]));
  assert.ok(Object.values(result.facts).every((fact) => fact.path.includes("&_overload=")));
  assert.equal(read.mock.calls.filter((call) => String(call.arguments[0]).endsWith(".yaml")).length, 0);
});

test("does not read TCGC for non-operation declarations or unmatched generic operation references", (context) => {
  const { inputs, source, document, route, write } = mappedOperationFixture(context);
  source.declarations = source.declarations.map((declaration) => ({
    ...declaration, kind: "model", qualifiedName: "Payload",
  }));
  document.paths[route].post.responses[202].schema = { $ref: "#/definitions/Payload" };
  document.definitions = { Payload: { type: "object", properties: { value: { type: "string" } } } };
  for (const role of ["baseline", "target"]) write(`${role}.json`, document);
  inputs.sourceIndex.referencedDeclarations = {
    generic: { id: "generic", kind: "operation", qualifiedName: "StorageOperationResponseBody",
      compilerEvidence: { referencedNames: ["Payload"] }, source: { revision: "current" } },
  };
  const read = context.mock.method(fs, "readFileSync");
  const result = analyzeSemanticIntents(inputs);
  assert.equal(result.reviewUnits[0].operations.length, 1);
  assert.equal(result.reviewUnits[0].operations[0].matchBasis, "compiled-contract-containment");
  assert.equal(read.mock.calls.filter((call) => String(call.arguments[0]).endsWith(".yaml")).length, 0);
});

for (const scenario of ["missing-identity", "missing-route", "ambiguous-identity", "ambiguous-method-route", "ambiguous-rest-route"]) {
  test(`does not guess a TCGC operation mapping: ${scenario}`, (context) => {
    const { inputs, source, document, sdk, route, write } = mappedOperationFixture(context);
    source.declarations = source.declarations.filter((item) => item.source.revision === "current");
    const method = sdk.clients[0].methods[0];
    if (scenario === "missing-identity") method.crossLanguageDefinitionId += "Similar";
    if (scenario === "missing-route") method.operation.verb = "get";
    if (scenario === "ambiguous-identity") {
      sdk.clients[0].methods.push({ ...method, crossLanguageDefinitionId:
        method.crossLanguageDefinitionId.replace("Microsoft", "Another") });
    }
    if (scenario === "ambiguous-method-route") {
      sdk.clients[0].methods.push({ ...method, operation: { ...method.operation, path: "/another" } });
    }
    if (scenario === "ambiguous-rest-route") {
      document["x-ms-paths"] = { [route]: { post: {
        ...document.paths[route].post, operationId: "Other_Post",
      } } };
      write("target.json", document);
    }
    write("target.yaml", sdk);
    const result = analyzeSemanticIntents(inputs);
    assert.equal(result.status, "ready");
    assert.deepEqual(result.reviewUnits[0].operations, []);
    assert.deepEqual(result.reviewUnits[0].ownedOperationIds, []);
    if (scenario !== "missing-identity") {
      assert.equal(result.blockers.length, 1);
      assert.equal(result.blockers[0].code, scenario.startsWith("ambiguous")
        ? "tcgc-operation-mapping-ambiguous" : "tcgc-operation-route-unresolved");
      assert.equal(result.blockers[0].comparisonRole, "target");
    }
  });
}

test("deduplicates equivalent method projections of the same compiler operation", (context) => {
  const { inputs, sdk, write } = mappedOperationFixture(context);
  sdk.clients[0].methods.push({ ...sdk.clients[0].methods[0], name: "postProtocol" });
  write("target.yaml", sdk);
  const result = analyzeSemanticIntents(inputs);
  assert.deepEqual(result.blockers, []);
  assert.equal(result.reviewUnits[0].operations.length, 1);
});

test("does not use a baseline method to resolve a target source declaration", (context) => {
  const { inputs, sdk, source, write } = mappedOperationFixture(context);
  source.declarations = source.declarations.filter((item) => item.source.revision === "current");
  sdk.clients[0].methods = [];
  write("target.yaml", sdk);
  assert.deepEqual(analyzeSemanticIntents(inputs).reviewUnits[0].operations, []);
});

test("honors comparison sourceRevision rather than assuming baseline means base", (context) => {
  const { inputs, project, sdk, source, write } = mappedOperationFixture(context);
  source.declarations = source.declarations.filter((item) => item.source.revision === "current");
  project.artifactComparison.baseline.sourceRevision = "current";
  sdk.clients[0].methods = [];
  write("target.yaml", sdk);
  assert.equal(analyzeSemanticIntents(inputs).reviewUnits[0].operations.length, 1);
});

test("does not fall back to a declaration from an unselected source revision", (context) => {
  const { inputs, project, source } = mappedOperationFixture(context);
  source.declarations = [{ ...source.declarations[0], qualifiedName: "OutboundRules.post" }];
  project.artifactComparison.baseline.sourceRevision = "current";
  assert.deepEqual(analyzeSemanticIntents(inputs).reviewUnits[0].operations, []);
});

for (const mismatch of ["package", "method"]) {
  test(`isolates selected API version from ${mismatch} metadata`, (context) => {
    const { inputs, sdk, source, write } = mappedOperationFixture(context);
    source.declarations = source.declarations.filter((item) => item.source.revision === "current");
    if (mismatch === "package") sdk.metadata.apiVersions = ["v2"];
    else sdk.clients[0].methods[0].apiVersions = ["v2"];
    write("target.yaml", sdk);
    const result = analyzeSemanticIntents(inputs);
    assert.deepEqual(result.reviewUnits[0].operations, []);
    if (mismatch === "package") assert.equal(result.blockers[0].code, "tcgc-operation-version-mismatch");
  });
}

test("keeps API-version and project-specific method indexes separate", (context) => {
  const { inputs, project, sdk, document, route, write } = mappedOperationFixture(context);
  const otherProject = structuredClone(project);
  otherProject.id = "other-project";
  otherProject.path = "specification/other";
  for (const role of ["baseline", "target"]) {
    otherProject.artifactComparison[role].apiVersion = "v2";
    otherProject.artifacts[role].tcgc = project.artifacts[role].tcgc;
    otherProject.artifacts[role].autorest = artifact("v2.json");
  }
  document.info.version = "v2";
  document.paths = { "/different": { post: { ...document.paths[route].post, operationId: "Other_Post" } } };
  write("v2.json", document);
  sdk.metadata.apiVersions = ["v1", "v2"];
  sdk.clients[0].methods.push({ ...sdk.clients[0].methods[0], apiVersions: ["v2"],
    operation: { kind: "http", verb: "post", path: "/different" } });
  write("baseline.yaml", sdk);
  write("target.yaml", sdk);
  inputs.manifest.projects.push(otherProject);
  const result = analyzeSemanticIntents(inputs);
  assert.deepEqual(result.blockers, []);
  const units = new Map(result.reviewUnits.map((unit) => [unit.projectId, unit]));
  assert.deepEqual(units.get(project.id).ownedOperationIds, ["OutboundRules_Post"]);
  assert.deepEqual(units.get(otherProject.id).ownedOperationIds, ["Other_Post"]);
  assert.equal(result.facts[units.get(otherProject.id).afterFactIds[0]].apiVersion, "v2");
});

test("selects only the requested REST version from a multi-version artifact", (context) => {
  const { inputs, project, document, route, write } = mappedOperationFixture(context);
  document.info.version = "v2";
  document.paths[route].post.operationId = "WrongVersion_Post";
  write("v2.json", document);
  for (const role of ["baseline", "target"]) {
    project.artifacts[role].autorest.files.push({ path: "v2.json", documentRole: "feature" });
  }
  const result = analyzeSemanticIntents(inputs);
  assert.deepEqual(result.blockers, []);
  assert.deepEqual(result.reviewUnits[0].ownedOperationIds, ["OutboundRules_Post"]);
  assert.ok(Object.values(result.facts).every((fact) => fact.apiVersion === "v1"));
});

test("does not import compiler-reference operations from another project", (context) => {
  const { inputs, source } = mappedOperationFixture(context);
  const declaration = source.declarations[1];
  source.declarations = [{
    id: "model", kind: "model", qualifiedName: "Polling",
    hunkIds: ["hunk-mapping"], source: { revision: "current" },
  }];
  inputs.sourceIndex.referencedDeclarations = {
    other: { ...declaration, project: "specification/other", compilerEvidence: { referencedNames: ["Polling"] } },
  };
  assert.deepEqual(analyzeSemanticIntents(inputs).reviewUnits[0].operations, []);
});

for (const missing of ["absent", "invalid"]) {
  test(`preserves legacy REST operation matching with ${missing} TCGC artifacts`, (context) => {
    const { inputs, source, project, write } = mappedOperationFixture(context);
    for (const declaration of source.declarations) declaration.qualifiedName = "OutboundRules.post";
    for (const role of ["baseline", "target"]) {
      if (missing === "absent") delete project.artifacts[role].tcgc;
      else write(`${role}.yaml`, {});
    }
    const result = analyzeSemanticIntents(inputs);
    assert.equal(result.status, "ready");
    assert.equal(result.reviewUnits[0].operations[0].matchBasis, "operation-identity");
    assert.equal(result.reviewUnits[0].operations[0].restChanged, false);
  });
}

test("keeps shared hunks only in their specific semantic unit", () => {
  const units = [{
    id: "semantic-publication",
    sourceChangeIds: ["source-version", "source-client"],
    hunkIds: ["hunk-version", "hunk-client"],
    declarationIds: ["declaration-version", "declaration-client"],
    operations: [],
    groupingEvidence: {
      reasons: ["cross-project:api-version-publication"],
      memberHunkIds: ["hunk-version", "hunk-client"],
    },
  }, {
    id: "semantic-client",
    sourceChangeIds: ["source-client"],
    hunkIds: ["hunk-client"],
    declarationIds: ["declaration-client"],
    operations: [],
    groupingEvidence: {
      reasons: ["sdk-compatibility"],
      memberHunkIds: ["hunk-client"],
    },
  }];
  const sources = [{
    id: "source-version",
    hunks: [{ id: "hunk-version" }],
    declarations: [{
      id: "declaration-version",
      hunkIds: ["hunk-version"],
    }],
  }, {
    id: "source-client",
    hunks: [{ id: "hunk-client" }],
    declarations: [{
      id: "declaration-client",
      hunkIds: ["hunk-client"],
    }],
  }];

  const result = dedupePublicationHunks(units, sources);

  assert.deepEqual(result[0].hunkIds, ["hunk-version"]);
  assert.deepEqual(result[0].sourceChangeIds, ["source-version"]);
  assert.deepEqual(result[0].declarationIds, ["declaration-version"]);
  assert.deepEqual(result[0].groupingEvidence.memberHunkIds, ["hunk-version"]);
  assert.deepEqual(result[1], units[1]);
});

test("creates source-first semantic units and retains unchanged REST operations", (context) => {
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
  const result = analyzeSemanticIntents({
    workRoot: work,
    manifest: {
      projects: [{
        id: "project-kept",
        sourceChangeIds: ["source-kept"],
        artifacts: {
          base: { autorest: artifact("base.json") },
          current: { autorest: artifact("current.json") },
        },
      }],
    },
    sourceIndex: {
      sourceChanges: [{
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
      }],
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

test("maps a top-level TypeSpec operation to its AutoRest operation ID", (context) => {
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
  const result = analyzeSemanticIntents({
    workRoot: work,
    manifest: {
      projects: [{
        id: "project-ledger",
        sourceChangeIds: ["source-ledger"],
        artifacts: {
          base: { autorest: artifact("base.json") },
          current: { autorest: artifact("current.json") },
        },
      }],
    },
    sourceIndex: {
      sourceChanges: [{
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
      }],
    },
  });

  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].operations[0].operationId, "CreateLedgerEntry");
  assert.equal(result.reviewUnits[0].operations[0].matchBasis, "operation-identity");
});

test("retains a semantic unit when changed TypeSpec has no REST operation", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".semantic-no-rest-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = {
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {},
  };
  writeJson(path.join(work, "base.json"), document);
  writeJson(path.join(work, "current.json"), document);
  const result = analyzeSemanticIntents({
    workRoot: work,
    manifest: {
      projects: [{
        id: "project-kept",
        sourceChangeIds: ["source-kept"],
        artifacts: {
          base: { autorest: artifact("base.json") },
          current: { autorest: artifact("current.json") },
        },
      }],
    },
    sourceIndex: {
      sourceChanges: [{
        id: "source-kept",
        status: "added",
        hunks: [{ id: "hunk-kept" }],
        declarations: [{
          id: "declaration-current",
          kind: "alias",
          qualifiedName: "InternalName",
          hunkIds: ["hunk-kept"],
          source: { revision: "current" },
        }],
      }],
    },
  });

  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].action, "add");
  assert.deepEqual(result.reviewUnits[0].operations, []);
});

test("maps a changed model to an operation through changed TypeSpec references", (context) => {
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
  const result = analyzeSemanticIntents({
    workRoot: work,
    manifest: {
      projects: [{
        id: "project-kept",
        sourceChangeIds: ["model-source", "operation-source"],
        artifacts: {
          base: { autorest: artifact("base.json") },
          current: { autorest: artifact("current.json") },
        },
      }],
    },
    sourceIndex: {
      sourceChanges: [{
        id: "model-source",
        status: "added",
        hunks: [{ id: "model-hunk", lines: ["+model PollingResponse {}"] }],
        declarations: [{
          id: "model",
          kind: "model",
          qualifiedName: "PollingResponse",
          hunkIds: ["model-hunk"],
          source: { revision: "current" },
        }],
      }, {
        id: "operation-source",
        status: "modified",
        hunks: [{
          id: "operation-hunk",
          lines: ["+  get is ArmResourceRead<Widget, Response = PollingResponse>;"],
        }],
        declarations: [{
          id: "operation",
          kind: "operation",
          qualifiedName: "Widgets.get",
          hunkIds: ["operation-hunk"],
          compilerEvidence: { referencedNames: ["PollingResponse"] },
          source: { revision: "current" },
        }],
      }],
    },
  });
  const modelUnit = result.reviewUnits.find((item) => item.sourceChangeIds.includes("model-source"));
  assert.ok(modelUnit, JSON.stringify(result));
  assert.equal(modelUnit.operations[0].operationId, "Widgets_Get");
  assert.equal(modelUnit.operations[0].matchBasis, "operation-identity");
});

test("classifies a new API surface as add despite modified registration code", (context) => {
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
  const result = analyzeSemanticIntents({
    workRoot: work,
    manifest: {
      projects: [{
        id: "project-widgets",
        sourceChangeIds: ["feature-source", "main-source"],
        artifactComparison: { mode: "new-api-version" },
        artifacts: {
          base: { autorest: artifact("base.json") },
          current: { autorest: artifact("current.json") },
        },
      }],
    },
    sourceIndex: {
      sourceChanges: [{
        id: "feature-source",
        path: "specification/widgets/Widget.tsp",
        status: "added",
        hunks: [{ id: "feature-hunk", lines: ["+op create(): void;"] }],
        declarations: [{
          id: "feature-operation",
          kind: "operation",
          qualifiedName: "Widgets.create",
          hunkIds: ["feature-hunk"],
          source: { revision: "current" },
        }],
      }, {
        id: "main-source",
        path: "specification/widgets/main.tsp",
        status: "modified",
        hunks: [{ id: "main-hunk", lines: ['+import "./Widget.tsp";'] }],
        declarations: [{
          id: "main-base",
          kind: "namespace",
          qualifiedName: "Widgets",
          hunkIds: ["main-hunk"],
          source: { revision: "base" },
        }, {
          id: "main-current",
          kind: "namespace",
          qualifiedName: "Widgets",
          hunkIds: ["main-hunk"],
          source: { revision: "current" },
        }],
      }],
    },
  });

  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].action, "add");
  assert.deepEqual(
    result.reviewUnits[0].operations.map((operation) => operation.operationId),
    ["Widgets_Create"],
  );
});

test("keeps mixed added and changed operations classified as modify", (context) => {
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
  const result = analyzeSemanticIntents({
    workRoot: work,
    manifest: {
      projects: [{
        id: "project-widgets",
        sourceChangeIds: ["feature-source", "main-source"],
        artifactComparison: { mode: "new-api-version" },
        artifacts: {
          base: { autorest: artifact("base.json") },
          current: { autorest: artifact("current.json") },
        },
      }],
    },
    sourceIndex: {
      sourceChanges: [{
        id: "feature-source",
        path: "specification/widgets/Widget.tsp",
        status: "added",
        hunks: [{ id: "feature-hunk", lines: ["+op create(): void;"] }],
        declarations: [{
          id: "feature-operation",
          kind: "operation",
          qualifiedName: "Widgets.create",
          hunkIds: ["feature-hunk"],
          source: { revision: "current" },
        }],
      }, {
        id: "main-source",
        path: "specification/widgets/main.tsp",
        status: "added",
        hunks: [{ id: "main-hunk", lines: ["-op get(): Widget;", "+op get(): CreatedWidget;"] }],
        declarations: [{
          id: "get-base",
          kind: "operation",
          qualifiedName: "Widgets.get",
          hunkIds: ["main-hunk"],
          source: { revision: "base" },
        }, {
          id: "get-current",
          kind: "operation",
          qualifiedName: "Widgets.get",
          hunkIds: ["main-hunk"],
          source: { revision: "current" },
        }],
      }],
    },
  });

  assert.equal(result.reviewUnits.length, 1);
  assert.equal(result.reviewUnits[0].action, "modify");
  assert.deepEqual(
    result.reviewUnits[0].operations.map((operation) => operation.operationId),
    ["Widgets_Create", "Widgets_Get"],
  );
});
