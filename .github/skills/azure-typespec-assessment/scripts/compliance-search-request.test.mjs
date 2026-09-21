import assert from "node:assert/strict";
import test from "node:test";
import { annotateReferenceCategories } from "./reference-category-tags.mjs";
import { buildComplianceSearchRequests } from "./compliance-search-request.mjs";

test("requests carry canonical categories, routing, complete changed tokens, and real evidence IDs", () => {
  const source = {
    id: "source-1", path: "specification/widgets/resource-manager/main.tsp",
    hunks: [{ id: "hunk-1", lines: [
      "+interface ConnectionAnalyzers extends Legacy.RoutedOperations<Widget> {}",
      ...Array.from({ length: 100 }, (_, index) => `+@Custom${index}`),
      '+@clientName("Analyzers")',
    ] }],
    declarations: [{ id: "declaration-1", kind: "interface", qualifiedName: "ConnectionAnalyzers", hunkIds: ["hunk-1"] }],
  };
  const semantic = annotateReferenceCategories({
    semantic: { reviewUnits: [{
      id: "semantic-1", intentType: "normal", action: "add",
      sourceChangeIds: ["source-1"], hunkIds: ["hunk-1"], declarationIds: ["declaration-1"],
    }] },
    sourceIndex: { sourceChanges: [source] },
  });
  const [request] = buildComplianceSearchRequests({ semanticReviewUnits: semantic.reviewUnits, sourceChanges: { [source.id]: source } });
  assert.deepEqual(request.referenceCategories, ["arm-resource-operation", "decorators"]);
  assert.deepEqual(request.sourceChangeIds, ["source-1"]);
  assert.deepEqual(request.hunkIds, ["hunk-1"]);
  assert.deepEqual(request.declarationIds, ["declaration-1"]);
  assert.ok(request.queryProfile.changedTokens.length > 80);
  assert.ok(request.guidanceRouting.mandatoryCatalogIds.length >= 3);
  assert.ok(request.guidanceRouting.discoveryRequests.some((item) => item.queryTerms.includes("decorator:clientName")));
  assert.deepEqual(request, buildComplianceSearchRequests({ semanticReviewUnits: semantic.reviewUnits, sourceChanges: { [source.id]: source } })[0]);
});

test("informational version categories never create compliance requirements", () => {
  const requests = buildComplianceSearchRequests({
    semanticReviewUnits: ["api-version-publication", "api-version-wide-change"].map((intentType) => ({
      id: intentType, intentType, referenceCategories: ["api-versioning"], referenceCategoryEvidence: [],
    })),
    sourceChanges: {},
  });
  assert.deepEqual(requests, []);
});

test("request ownership preserves both revision declaration IDs even when query summaries prefer current", () => {
  const source = {
    id: "source-1", path: "specification/widgets/resource-manager/models.tsp",
    hunks: [{ id: "hunk-1", lines: ["-model Widget { size: string; }", "+model Widget { size: int32; }"] }],
    declarations: ["base", "current"].map((revision) => ({
      id: `declaration-${revision}`, kind: "model", qualifiedName: "Widget",
      hunkIds: ["hunk-1"], source: { revision },
    })),
  };
  const semantic = annotateReferenceCategories({
    semantic: { reviewUnits: [{
      id: "semantic-1", intentType: "normal", action: "modify",
      sourceChangeIds: [source.id], hunkIds: ["hunk-1"],
      declarationIds: ["declaration-base", "declaration-current"],
    }] },
    sourceIndex: { sourceChanges: [source] },
  });
  const [request] = buildComplianceSearchRequests({
    semanticReviewUnits: semantic.reviewUnits, sourceChanges: { [source.id]: source },
  });
  assert.deepEqual(request.declarationIds, ["declaration-base", "declaration-current"]);
  assert.deepEqual(request.queryProfile.qualifiedNames, ["Widget"]);
});

test("unclassified custom changes expose no-category discovery without assuming data-plane", () => {
  const source = { id: "source-1", path: "main.tsp", hunks: [{ id: "hunk-1", lines: ["+alias CustomAlias = Custom;"] }], declarations: [] };
  const [request] = buildComplianceSearchRequests({
    semanticReviewUnits: [{ id: "semantic-1", sourceChangeIds: ["source-1"], hunkIds: ["hunk-1"],
      referenceCategories: [], referenceCategoryEvidence: [] }],
    sourceChanges: { [source.id]: source },
  });

  assert.equal(request.queryProfile.servicePlane, "unknown");
  assert.equal(request.guidanceRouting.discoveryRequests[0].trigger, "no-category");
});

test("missing canonical evidence diagnostics reach routing without adding fake categories", () => {
  const [request] = buildComplianceSearchRequests({
    semanticReviewUnits: [{ id: "semantic-1", sourceChangeIds: [], hunkIds: [],
      referenceCategories: [], referenceCategoryEvidence: [] }],
    sourceChanges: {},
    referenceCategoryDiagnostics: [{ reviewUnitId: "semantic-1", code: "reference-source-evidence-unavailable" }],
  });
  assert.deepEqual(request.referenceCategories, []);
  assert.ok(request.guidanceRouting.discoveryRequests.some((item) => item.trigger === "classification-blocked"));
});
