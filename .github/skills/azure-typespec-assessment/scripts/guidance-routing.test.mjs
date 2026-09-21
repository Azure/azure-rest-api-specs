import assert from "node:assert/strict";
import test from "node:test";
import { readComplianceCatalog } from "./compliance-assessment.mjs";
import { createGuidanceRouter, GUIDANCE_URLS, mandatoryGuidanceCatalog, validateGuidanceCatalog } from "./guidance-routing.mjs";
import { REFERENCE_CATEGORIES } from "./reference-category-tags.mjs";

const catalog = readComplianceCatalog();
const route = createGuidanceRouter(catalog);
const urls = (routing) => routing.mandatoryCatalogIds.map((id) => catalog.find((entry) => entry.catalogId === id).canonicalUrl);
function unit(evidence) {
  return {
    id: "semantic-1",
    referenceCategories: REFERENCE_CATEGORIES.filter((category) => evidence[category]),
    referenceCategoryEvidence: Object.entries(evidence).map(([category, values]) => ({
      category, ruleId: "test-rule", hunkIds: ["hunk-1"], declarationIds: ["declaration-1"], evidence: values,
    })),
  };
}

test("catalog contains exactly the eight headings and all 31 canonical official URLs", () => {
  assert.equal(catalog.length, 31);
  assert.doesNotThrow(() => validateGuidanceCatalog(catalog));
  assert.throws(() => validateGuidanceCatalog(catalog.slice(1)), /31/);
  assert.throws(() => validateGuidanceCatalog(catalog.map((entry, index) =>
    index ? entry : { ...entry, canonicalUrl: "https://example.org/invented" })), /unresolved official URL/);
  assert.throws(() => validateGuidanceCatalog(catalog.map((entry, index) =>
    index ? entry : { ...entry, category: "Resource Semantics" })), /eight category headings/);
  assert.throws(() => validateGuidanceCatalog(catalog.map((entry, index) =>
    index ? entry : { ...entry, catalogId: catalog[1].catalogId })), /unique/);
});

test("legacy ARM operations mandate both operations and interface references without scoring", () => {
  const routing = route(unit({ "arm-resource-operation": ["service-plane:resource-manager", "symbol:Legacy.RoutedOperations"] }));
  assert.deepEqual(urls(routing), [GUIDANCE_URLS.armOperations, GUIDANCE_URLS.armInterfaces]);
  assert.deepEqual(routing.discoveryRequests, []);
  assert.equal(routing.selections[0].ruleId, "arm-operation-template-guidance");
  assert.equal(routing.rank, undefined);
  assert.equal(routing.score, undefined);
});

test("multiple tags select more than four documents without truncation and deduplicate shared URLs", () => {
  const routing = route(unit({
    "arm-resource-type": ["service-plane:resource-manager", "symbol:ExtensionResource", "decorator:parentResource"],
    "arm-resource-operation": ["service-plane:resource-manager", "decorator:armResourceRead"],
    "api-versioning": ["service-plane:resource-manager", "version-baseline:v1", "version-target:v2"],
    "long-running-operation": ["service-plane:resource-manager"],
    paging: ["service-plane:resource-manager", "symbol:ArmTopParameter"],
    "models-and-enums": ["kind:enum", "kind:scalar"],
    decorators: ["decorator:doc"],
    warnings: ["diagnostic:@azure-tools/typespec-azure-core/no-openapi"],
  }));
  assert.ok(routing.mandatoryCatalogIds.length > 4);
  assert.equal(new Set(routing.mandatoryCatalogIds).size, routing.mandatoryCatalogIds.length);
  assert.equal(routing.selections.filter((selection) => selection.catalogId === catalog.find((entry) => entry.canonicalUrl === GUIDANCE_URLS.armOperations).catalogId).length, 2);
  assert.deepEqual(mandatoryGuidanceCatalog([{ guidanceRouting: routing }], catalog).map((entry) => entry.catalogId), routing.mandatoryCatalogIds);
});

test("tagged sections are not fetched wholesale and data-plane resources reuse Rest guidance without ARM tags", () => {
  assert.deepEqual(urls(route(unit({ "arm-resource-type": ["service-plane:resource-manager", "symbol:TrackedResource"] }))), [GUIDANCE_URLS.armResource]);
  const routing = route(unit({ decorators: ["service-plane:data-plane", "decorator:resource"] }));
  assert.deepEqual(urls(routing), [GUIDANCE_URLS.restDecorators, GUIDANCE_URLS.decorators]);
  assert.ok(routing.selections.every((selection) => selection.category === "decorators"));
});

test("paging and LRO route by explicit plane and preserve the ARM template caveat", () => {
  assert.deepEqual(urls(route(unit({ paging: ["service-plane:resource-manager"] }))), [GUIDANCE_URLS.armOperations, GUIDANCE_URLS.armInterfaces]);
  assert.deepEqual(urls(route(unit({ paging: ["service-plane:data-plane"], "long-running-operation": ["service-plane:data-plane"] }))), [GUIDANCE_URLS.coreLro, GUIDANCE_URLS.pagination]);
  const unknown = route(unit({ paging: ["service-plane:unknown"] }));
  assert.deepEqual(unknown.mandatoryCatalogIds, []);
  assert.equal(unknown.discoveryRequests[0].trigger, "classification-blocked");
});

test("unavailable evidence creates a hard discovery blocker even when no category could be established", () => {
  const routing = route(unit({}), { servicePlane: "unknown" }, [{
    reviewUnitId: "semantic-1", code: "reference-source-evidence-unavailable",
  }]);
  assert.deepEqual(routing.discoveryRequests.map((request) => request.trigger).sort(), ["classification-blocked", "no-category"]);
  assert.ok(routing.discoveryRequests.find((request) => request.trigger === "classification-blocked")
    .queryTerms.includes("classification-diagnostic:reference-source-evidence-unavailable"));
});

test("shared classification diagnostics create one blocker rather than one per category", () => {
  const diagnostic = "classification-diagnostic:reference-service-plane-conflicting";
  const routing = route(unit({
    paging: ["service-plane:conflicting", diagnostic],
    "long-running-operation": ["service-plane:conflicting", diagnostic],
  }));
  assert.equal(routing.discoveryRequests.length, 1);
  assert.equal(routing.discoveryRequests[0].trigger, "classification-blocked");
});
test("unions are not enums and clientName retains explicit unmapped discovery", () => {
  const routing = route(unit({ "models-and-enums": ["kind:union"], decorators: ["decorator:clientName"] }));
  assert.ok(!urls(routing).includes(GUIDANCE_URLS.enums));
  assert.ok(urls(routing).includes(GUIDANCE_URLS.decorators));
  assert.equal(routing.discoveryRequests.length, 2);
  assert.ok(routing.discoveryRequests.some((request) => request.queryTerms.includes("decorator:clientName")));
  assert.ok(routing.discoveryRequests.every((request) => request.requestId.startsWith("discovery-request-")));
});

test("discovery is stable, explicit, and owned even when no category applies", () => {
  const input = unit({});
  const profile = { symbols: ["CustomConcern", "CustomConcern"], declarationKinds: ["alias"], servicePlane: "unknown" };
  const first = route(input, profile);
  assert.deepEqual(first, route(input, profile));
  assert.deepEqual(first.mandatoryCatalogIds, []);
  assert.equal(first.discoveryRequests[0].trigger, "no-category");
  assert.equal(first.discoveryRequests[0].reviewUnitId, input.id);
  assert.deepEqual(first.discoveryRequests[0].queryTerms, ["CustomConcern", "alias", "unknown"]);
});

test("missing or invalid canonical annotations are not treated as a completed no-match", () => {
  assert.throws(() => route({ id: "old" }), /annotation is required/);
  assert.throws(() => route({ id: "old", referenceCategories: ["models-and-enums"], referenceCategoryEvidence: [] }), /lacks canonical evidence/);
  assert.throws(() => route({ ...unit({}), referenceCategories: ["unknown-category"] }), /canonical order/);
});

for (const [baseline, target, key] of [
  ["2025-01-01-preview", "2025-02-01-preview", "previewAfterPreview"],
  ["2025-01-01-preview", "2025-02-01", "stableAfterPreview"],
  ["2025-01-01", "2025-02-01-preview", "previewAfterStable"],
  ["2025-01-01", "2025-02-01", "stableAfterStable"],
]) {
  test(`version evolution routes ${key} alongside primary Evolving APIs`, () => {
    const routing = route(unit({ "api-versioning": [
      `version-baseline:${baseline}`, `version-target:${target}`, "version-comparison:new-api-version",
    ] }));
    assert.deepEqual(urls(routing), [GUIDANCE_URLS.evolvingApis, GUIDANCE_URLS[key]]);
  });
}
