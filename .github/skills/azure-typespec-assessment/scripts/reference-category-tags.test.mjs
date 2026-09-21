import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import { analyzeSemanticIntents } from "./analyze-semantic-intents.mjs";
import { partitionSemanticIntents } from "./semantic-assessment-scope.mjs";
import { annotateReferenceCategories, REFERENCE_CATEGORIES } from "./reference-category-tags.mjs";

function fixture({
  lines = ["+model Widget { size?: int32; }"],
  declarations = [{ kind: "model", qualifiedName: "Widget" }],
  sourcePath = "specification/widgets/resource-manager/models.tsp",
  unit = {}, project = {}, facts = {},
} = {}) {
  const source = {
    id: "source-1", path: sourcePath,
    hunks: [{ id: "hunk-1", lines }],
    declarations: declarations.map((declaration, index) => ({
      id: `declaration-${index}`, hunkIds: ["hunk-1"],
      source: { revision: "current" }, ...declaration,
    })),
  };
  return {
    manifest: { projects: [{ id: "project-1", sourceChangeIds: [source.id], ...project }] },
    sourceIndex: { sourceChanges: [source] },
    semantic: {
      schemaVersion: 1, status: "ready", facts, blockers: [],
      reviewUnits: [{
        id: "semantic-stable", intentType: "normal", action: "modify",
        projectId: "project-1", sourceChangeIds: [source.id], hunkIds: ["hunk-1"],
        declarationIds: source.declarations.map((declaration) => declaration.id),
        operations: [], ownedOperationIds: [],
        groupingEvidence: { reasons: ["behavior:lro", "transform:client-name"] },
        ...unit,
      }],
    },
  };
}

function onlyUnit(options) {
  return annotateReferenceCategories(options).reviewUnits[0];
}

function stripAnnotation(result) {
  const { referenceCategoryDiagnostics, ...semantic } = result;
  return {
    ...semantic,
    reviewUnits: semantic.reviewUnits.map(({ referenceCategories, referenceCategoryEvidence, ...unit }) => unit),
  };
}

test("PR44988 custom and legacy ARM operations are tagged without standard templates", () => {
  const input = fixture({
    lines: [
      "+interface ConnectionAnalyzers extends Legacy.RoutedOperations<ConnectionAnalyzer> {",
      "+  analyze is CustomAnalyze<ConnectionAnalyzer>;",
      "+}",
    ],
    declarations: [{ kind: "interface", qualifiedName: "ConnectionAnalyzers" }],
  });
  const unit = onlyUnit(input);
  assert.deepEqual(unit.referenceCategories, ["arm-resource-operation"]);
  assert.equal(unit.referenceCategoryEvidence[0].ruleId, "arm-legacy-routed-operations");
  assert.ok(unit.referenceCategoryEvidence[0].evidence.includes("symbol:Legacy.RoutedOperations"));
  assert.deepEqual(unit.referenceCategoryEvidence[0].hunkIds, ["hunk-1"]);
  assert.deepEqual(unit.referenceCategoryEvidence[0].declarationIds, ["declaration-0"]);
});

test("all eight categories are independent, deterministic, and preserve every grouping field", () => {
  const input = fixture({
    lines: [
      '+@clientName("WidgetClient")',
      "+model Widget is TrackedResource<WidgetProperties>;",
      "+model WidgetProperties { size?: int32; }",
      "+interface Widgets { create is ArmResourceCreateOrReplaceAsync<Widget>; list is ArmResourceListByParent<Widget>; }",
      '+#suppress "@azure-tools/typespec-azure-core/no-openapi" "legacy"',
    ],
    declarations: [
      { kind: "model", qualifiedName: "Widget" },
      { kind: "property", qualifiedName: "WidgetProperties.size" },
      { kind: "interface", qualifiedName: "Widgets" },
    ],
    project: { artifactComparison: { mode: "existing-api-version", baseline: { apiVersion: "2025-01-01" }, target: { apiVersion: "2025-01-01" } } },
    unit: {
      ownedOperationIds: ["Widgets_Create"],
      operations: [{ operationId: "Widgets_Create", matchBasis: "operation-identity", hunkIds: ["hunk-1"] }],
      groupingEvidence: { tags: ["unchanged-tag"], reasons: ["feature"], edges: [{ memberIds: ["unchanged-member"] }] },
    },
  });
  const before = JSON.stringify(input);
  const result = annotateReferenceCategories(input);
  assert.deepEqual(result.reviewUnits[0].referenceCategories, REFERENCE_CATEGORIES);
  assert.equal(JSON.stringify(stripAnnotation(result)), JSON.stringify(input.semantic));
  assert.equal(JSON.stringify(input), before);
  assert.deepEqual(annotateReferenceCategories({ ...input, semantic: result }), result);
});

test("versioned API evolution is recognized without changed version decorators", () => {
  const unit = onlyUnit(fixture({
    project: { artifactComparison: { mode: "new-api-version", baseline: { apiVersion: "v1-preview" }, target: { apiVersion: "v2" } } },
  }));
  assert.deepEqual(unit.referenceCategories, ["api-versioning", "models-and-enums"]);
  assert.ok(unit.referenceCategoryEvidence[0].evidence.includes("version-baseline:v1-preview"));
});

test("scoped Extension resource templates retain resource-type guidance", () => {
  const unit = onlyUnit(fixture({ lines: ["+model Widget is Extension.Resource<WidgetProperties>;"] }));
  assert.deepEqual(unit.referenceCategories, ["arm-resource-type"]);
  assert.ok(unit.referenceCategoryEvidence[0].evidence.includes("symbol:Extension.Resource"));
});

test("transitive operation ownership and old grouping tags do not classify a plain model as ARM operations or LRO", () => {
  const unit = onlyUnit(fixture({
    lines: ['+@extension("x-custom-value", "Location")', "+model Widget { size?: int32; }"],
    facts: { after: { lro: { isLongRunning: true } } },
    unit: {
      ownedOperationIds: ["Widgets_Create"], operationIds: ["after"],
      operations: [{ operationId: "Widgets_Create", afterFactId: "after", matchBasis: "model-reference", hunkIds: ["hunk-1"] }],
    },
  }));
  assert.deepEqual(unit.referenceCategories, ["models-and-enums", "decorators"]);
});

test("removed constructs retain baseline decorators and contracts", () => {
  const unit = onlyUnit(fixture({
    lines: ["-op analyze is ArmResourceActionAsync<Widget>;"],
    declarations: [{ kind: "operation", qualifiedName: "Widgets.analyze", source: { revision: "base" }, decorators: ["@useFinalStateVia(\"location\")"] }],
    unit: { action: "remove" },
  }));
  assert.deepEqual(unit.referenceCategories, ["arm-resource-operation", "long-running-operation"]);
  assert.ok(unit.referenceCategoryEvidence[1].evidence.includes("decorator:useFinalStateVia"));
});

test("mixed operation and model groups do not inherit LRO contracts from transitive model consumers", () => {
  const unit = onlyUnit(fixture({
    lines: ["+op get(): Widget;", "+model Widget { size?: int32; }"],
    declarations: [
      { kind: "operation", qualifiedName: "get" },
      { kind: "model", qualifiedName: "Widget" },
    ],
    facts: { after: { lro: { isLongRunning: true } } },
    unit: { operations: [
      { operationId: "Get", matchBasis: "operation-identity" },
      { operationId: "UnchangedCreate", matchBasis: "compiled-contract-containment", afterFactId: "after", hunkIds: ["hunk-1"] },
    ] },
  }));
  assert.deepEqual(unit.referenceCategories, ["arm-resource-operation", "models-and-enums"]);
});

test("a direct operation contract delta uses existing facts, not a compiler pass", () => {
  const unit = onlyUnit(fixture({
    lines: ["+op analyze(): AcceptedResponse;"],
    declarations: [{ kind: "operation", qualifiedName: "analyze" }],
    facts: { before: { lro: undefined }, after: { lro: { finalStateVia: "location" } } },
    unit: { operations: [{ operationId: "Analyze", matchBasis: "operation-identity", beforeFactId: "before", afterFactId: "after" }] },
  }));
  assert.ok(unit.referenceCategories.includes("long-running-operation"));
  assert.ok(unit.referenceCategoryEvidence.find((record) => record.category === "long-running-operation")
    .evidence.includes("operation-contract:Analyze:lro"));
});

test("informational version intents keep their types and filtering while receiving descriptive version tags", () => {
  const input = fixture({
    lines: ['+enum Versions { v2: "2025-01-01"; }'],
    declarations: [{ kind: "enum", qualifiedName: "Versions" }],
  });
  const unit = input.semantic.reviewUnits[0];
  input.semantic.reviewUnits = [
    { ...unit, id: "publication", intentType: "api-version-publication", groupingEvidence: { reasons: ["publication"] } },
    { ...unit, id: "wide", intentType: "api-version-wide-change", declarationNames: ["Versions"],
      operations: [{ operationId: "Read", matchBasis: "direct-version-governance" }] },
    { ...unit, id: "normal", intentType: "normal" },
  ];
  const result = annotateReferenceCategories(input);
  assert.equal(JSON.stringify(stripAnnotation(result)), JSON.stringify(input.semantic));
  assert.deepEqual(partitionSemanticIntents(result.reviewUnits).assessed.map((entry) => entry.id), ["normal"]);
  for (const entry of result.reviewUnits) assert.ok(entry.referenceCategories.includes("api-versioning"));
  assert.ok(result.reviewUnits.every((entry) => !entry.referenceCategories.includes("models-and-enums")));
});

test("unavailable and conflicting source evidence produce explicit diagnostics, not an invented plane", () => {
  const missing = fixture({ sourcePath: "custom/main.tsp", lines: ["+@pageItems"], declarations: [] });
  missing.semantic.reviewUnits[0].hunkIds.push("missing-hunk");
  const result = annotateReferenceCategories(missing);
  assert.deepEqual(result.referenceCategoryDiagnostics.map((item) => item.code), [
    "reference-source-evidence-unavailable", "reference-service-plane-unknown",
  ]);
  assert.ok(result.reviewUnits[0].referenceCategoryEvidence[0].evidence.includes("service-plane:unknown"));
  const conflict = annotateReferenceCategories(fixture({
    sourcePath: "specification/widgets/data-plane/main.tsp",
    lines: ["+op list is Azure.ResourceManager.ArmResourceListByParent<Widget>;"],
    declarations: [{ kind: "operation", qualifiedName: "list" }],
  }));
  assert.ok(conflict.referenceCategoryDiagnostics.some((item) => item.code === "reference-service-plane-conflicting"));
  assert.ok(!conflict.reviewUnits[0].referenceCategories.includes("arm-resource-operation"));
});

test("comments and string literals are not template or decorator evidence", () => {
  const unit = onlyUnit(fixture({
    lines: ['+@doc("Use ArmResourceCreateOrReplaceAsync and @pageItems")', "+// @pollingOperation(foo)", "+model Widget {}"],
  }));
  assert.deepEqual(unit.referenceCategories, ["models-and-enums", "decorators"]);
});

test("Azure.Core shared types do not contradict explicit ARM service evidence", () => {
  const result = annotateReferenceCategories(fixture({
    lines: ["+op create is Azure.Core.LongRunningRpcOperation<Widget>;"],
    declarations: [{ kind: "operation", qualifiedName: "create" }],
  }));
  assert.deepEqual(result.referenceCategoryDiagnostics, []);
  assert.deepEqual(result.reviewUnits[0].referenceCategories, ["arm-resource-operation", "long-running-operation"]);
  assert.ok(result.reviewUnits[0].referenceCategoryEvidence.every((record) =>
    record.evidence.includes("service-plane:resource-manager")));
});

test("canonical evidence is not truncated to compact token or excerpt limits", () => {
  const names = Array.from({ length: 125 }, (_, index) => `decorator${index}`);
  const input = fixture({ lines: [...names.map((name) => `+@${name}`), "+@clientName(\"Custom\")"] });
  const unit = onlyUnit(input);
  const evidence = unit.referenceCategoryEvidence.find((record) => record.category === "decorators").evidence;
  assert.ok(names.every((name) => evidence.includes(`decorator:${name}`)));
  assert.ok(evidence.includes("decorator:clientName"));
});

test("post-analysis annotation preserves real finalized semantic IDs, member evidence, operations, and types", (context) => {
  const workRoot = fs.mkdtempSync(path.join(process.cwd(), ".reference-category-test-"));
  context.after(() => fs.rmSync(workRoot, { recursive: true, force: true }));
  const document = {
    swagger: "2.0", info: { title: "Widgets", version: "v1" },
    paths: { "/widgets": { get: { operationId: "Widgets_List", responses: { 200: { description: "ok" } } } } },
  };
  for (const role of ["baseline", "target"]) {
    fs.writeFileSync(path.join(workRoot, `${role}.json`), JSON.stringify(document));
  }
  const input = fixture({
    lines: ["+interface Widgets extends Legacy.RoutedOperations<Widget> {}"],
    declarations: [{ kind: "interface", qualifiedName: "Widgets" }],
    project: {
      path: "specification/widgets/resource-manager",
      artifacts: Object.fromEntries(["baseline", "target"].map((role) => [role, {
        autorest: { format: "swagger-2.0", status: "succeeded", files: [{ path: `${role}.json`, documentRole: "primary" }] },
      }])),
    },
  });
  const semantic = analyzeSemanticIntents({ workRoot, manifest: input.manifest, sourceIndex: input.sourceIndex });
  assert.ok(semantic.reviewUnits.length > 0);
  const before = JSON.stringify(semantic);
  const annotated = annotateReferenceCategories({ ...input, semantic });
  assert.equal(JSON.stringify(stripAnnotation(annotated)), before);
  assert.equal(JSON.stringify(semantic), before);
  assert.deepEqual(annotated.reviewUnits.map((unit) => unit.intentType), semantic.reviewUnits.map((unit) => unit.intentType));
});
