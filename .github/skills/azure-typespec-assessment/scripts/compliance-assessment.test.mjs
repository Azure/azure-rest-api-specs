import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import {
  assembleCompliance, readComplianceCatalog, resolveDocumentSelections, searchInputAccounting,
} from "./compliance-assessment.mjs";

const HASH = `sha256:${"a".repeat(64)}`;

function fixture(count = 2) {
  const catalog = readComplianceCatalog().slice(0, count);
  const requests = [{
    requestId: "compliance-search-1", reviewUnitId: "semantic-1",
    sourceChangeIds: ["source-1"], hunkIds: ["hunk-1"], declarationIds: ["declaration-1"],
    referenceCategories: ["arm-resource-type"],
    queryProfile: { servicePlane: "resource-manager" },
    guidanceRouting: {
      mandatoryCatalogIds: catalog.map((item) => item.catalogId),
      selections: catalog.map((item) => ({ catalogId: item.catalogId, category: "arm-resource-type", ruleId: "resource-template" })),
      discoveryRequests: [],
    },
  }];
  const documents = catalog.map(({ catalogId, catalogOrder, title, canonicalUrl }) => ({
    catalogId, catalogOrder, title, canonicalUrl,
    retrieval: { status: "fetched", retrievalSource: "network", retrievedAt: "2026-08-28T00:00:00.000Z", contentHash: HASH, bytes: 100 },
    guidance: [], noRelevantGuidance: true,
  }));
  const evidence = {
    schemaVersion: 3, queryProfiles: [], documentSelections: [],
    documents, discoveryResults: [], additionalSelections: [], retrievalAttempts: [], blockers: [],
  };
  const decisions = [{
    reviewUnitId: "semantic-1", reviewedCatalogIds: catalog.map((item) => item.catalogId),
    applicableGuidance: [], sourceChangeIds: ["source-1"], hunkIds: ["hunk-1"], declarationIds: ["declaration-1"],
    decision: "no-applicable-guidance", actual: "Changed resource template.",
    rationale: "The reviewed sections do not govern this changed concern.",
  }];
  const sourceChanges = [{
    id: "source-1", path: "main.tsp",
    hunks: [{ id: "hunk-1", lines: ["+model Widget {}"] }],
    declarations: [{ id: "declaration-1", qualifiedName: "Widget", source: { startLine: 1, endLine: 1 } }],
  }];
  const result = { requests, evidence, decisions, sourceChanges };
  refresh(result);
  return result;
}

function refresh(input) {
  input.evidence.queryProfiles = input.requests.map(({ reviewUnitId, queryProfile }) => ({ reviewUnitId, queryProfile }));
  input.evidence.documentSelections = resolveDocumentSelections({ requests: input.requests, ...input.evidence }).documentSelections;
  input.evidence.inputAccounting = searchInputAccounting(input.evidence);
}

test("catalog preserves canonical identity and the eight reference headings", () => {
  const catalog = readComplianceCatalog();
  assert.equal(new Set(catalog.map((item) => item.canonicalUrl)).size, catalog.length);
  assert.deepEqual([...new Set(catalog.map((item) => item.category))], [
    "ARM Resource Type", "ARM Resource Operation", "API Versioning",
    "Long-Running Operations (LRO)", "Paging", "Models and Enums", "Decorators", "Warnings",
  ]);
  assert.equal(catalog.find((item) => item.title === "TypeSpec.Rest decorators").category, "ARM Resource Type");
});

test("catalog parser rejects missing or duplicate raw headings even without entries", () => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".catalog-heading-test-"));
  try {
    const original = fs.readFileSync(new URL("../references/reference-document-links.md", import.meta.url), "utf8");
    for (const malformed of [
      original + "\n## Warnings\n",
      original.replace("## Warnings", "## Unknown"),
      original.replace("## Warnings", ""),
    ]) {
      const file = path.join(work, "catalog.md");
      fs.writeFileSync(file, malformed);
      assert.throws(() => readComplianceCatalog(file), /exactly the eight canonical category headings/);
    }
    const file = path.join(work, "catalog.md");
    const duplicateEntry = original.match(/^- \[[^\]]+\]\(https?:\/\/[^)]+\):.+$/m)[0];
    fs.writeFileSync(file, `${original}\n${duplicateEntry}\n`);
    assert.throws(() => readComplianceCatalog(file), /duplicate canonical URL/);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

for (const count of [1, 2, 6, readComplianceCatalog().length]) {
  test(`reviews exactly ${count} required documents without a minimum or maximum-four cutoff`, () => {
    const result = assembleCompliance(fixture(count));
    assert.equal(result.sharedSearch.documents.length, count);
    assert.equal(result.coverage.selectedDocumentCount, count);
    assert.equal(result.sharedSearch.catalogRanking, undefined);
    assert.match(result.summary, /not an all-guidelines compliance pass/);
    assert.deepEqual(result.intentAssessments[0].requiredCatalogIds, result.intentAssessments[0].reviewedCatalogIds);
  });
}

test("shared content is stored once but each owner must independently review it", () => {
  const input = fixture(1);
  input.requests.push({ ...structuredClone(input.requests[0]), requestId: "compliance-search-2", reviewUnitId: "semantic-2" });
  input.decisions.push({ ...structuredClone(input.decisions[0]), reviewUnitId: "semantic-2" });
  refresh(input);
  const result = assembleCompliance(input);
  assert.equal(result.sharedSearch.documents.length, 1);
  assert.equal(result.sharedSearch.documentSelections.length, 2);
  input.decisions[1].reviewedCatalogIds = [];
  assert.throws(() => assembleCompliance(input), /falsely claims completed review/);
  input.decisions[1].decision = "not-assessed";
  const incomplete = assembleCompliance(input);
  assert.deepEqual(incomplete.coverage.unassessedIntentIds, ["semantic-2"]);
  assert.deepEqual(incomplete.intentAssessments[0].blockers, []);
});

test("missing required retrieval blocks only the owning intent and cannot be substituted", () => {
  const input = fixture(2);
  const [first, second] = input.requests[0].guidanceRouting.selections;
  input.requests[0].guidanceRouting = { mandatoryCatalogIds: [first.catalogId], selections: [first], discoveryRequests: [] };
  input.requests.push({ ...structuredClone(input.requests[0]), requestId: "compliance-search-2", reviewUnitId: "semantic-2",
    guidanceRouting: { mandatoryCatalogIds: [second.catalogId], selections: [second], discoveryRequests: [] } });
  input.decisions[0].reviewedCatalogIds = [first.catalogId];
  input.decisions.push({ ...structuredClone(input.decisions[0]), reviewUnitId: "semantic-2", reviewedCatalogIds: [], decision: "not-assessed" });
  input.evidence.documents.pop();
  input.evidence.retrievalAttempts.push({ catalogId: second.catalogId, canonicalUrl: readComplianceCatalog()[1].canonicalUrl, status: "failed", error: "Network unavailable." });
  refresh(input);
  const result = assembleCompliance(input);
  assert.deepEqual(result.coverage.unassessedIntentIds, ["semantic-2"]);
  assert.deepEqual(result.intentAssessments[0].blockers, []);
  input.decisions[1].decision = "no-applicable-guidance";
  assert.throws(() => assembleCompliance(input), /falsely claims completed review/);
});

test("same-session reuse preserves original provenance and counts no new network bytes", () => {
  const input = fixture(1);
  input.evidence.documents[0].retrieval.retrievalSource = "session-reuse";
  refresh(input);
  const result = assembleCompliance(input);
  assert.equal(result.sharedSearch.documents[0].retrievedAt, "2026-08-28T00:00:00.000Z");
  assert.equal(result.sharedSearch.documents[0].contentHash, HASH);
  assert.equal(result.sharedSearch.documents[0].retrievalSource, "session-reuse");
  assert.equal(result.sharedSearch.documents[0].retrieval.retrievalSource, "session-reuse");
  assert.equal(result.sharedSearch.documents[0].retrieval.contentHash, HASH);
  assert.equal(input.evidence.inputAccounting.documentsFetched, 0);
  assert.equal(input.evidence.inputAccounting.documentsReused, 1);
  assert.equal(input.evidence.inputAccounting.documentBytesFetched, 0);
  assert.equal(input.evidence.inputAccounting.documentBytesProcessed, 100);
});

test("unknown and unselected documents cannot be fetched or reviewed", () => {
  const input = fixture(1);
  input.evidence.documents[0].catalogId = readComplianceCatalog()[1].catalogId;
  assert.throws(() => assembleCompliance(input), /selection provenance/);
  const other = fixture(1);
  other.decisions[0].reviewedCatalogIds.push("catalog-entry-000000000000");
  assert.throws(() => assembleCompliance(other), /reviewedCatalogIds/);
});

test("selected discovery extends obligations; complete empty search permits no-applicable-guidance", () => {
  const input = fixture(0);
  input.requests[0].referenceCategories = [];
  input.requests[0].guidanceRouting.discoveryRequests = [{
    requestId: "discovery-request-1", reviewUnitId: "semantic-1", trigger: "unmapped-construct", queryTerms: ["union"],
  }];
  input.evidence.discoveryResults = [{ requestId: "discovery-request-1", intentId: "semantic-1", outcome: "no-match", catalogIds: [], rationale: "Catalog descriptions have no selectable guidance for this concern." }];
  refresh(input);
  assert.equal(assembleCompliance(input).coverage.assessedIntentCount, 1);
  const catalogId = readComplianceCatalog()[0].catalogId;
  input.evidence.discoveryResults[0] = { ...input.evidence.discoveryResults[0], outcome: "selected", catalogIds: [catalogId] };
  refresh(input);
  assert.throws(() => assembleCompliance(input), /falsely claims completed review/);
  input.decisions[0].decision = "not-assessed";
  assert.deepEqual(assembleCompliance(input).intentAssessments[0].selectedCatalogIds, [catalogId]);
});

for (const outcome of ["blocked", "missing"]) {
  test(`${outcome} discovery cannot silently become completed no-match`, () => {
    const input = fixture(1);
    input.requests[0].guidanceRouting.discoveryRequests = [{ requestId: "discovery-request-1", reviewUnitId: "semantic-1", trigger: "catalog-gap", queryTerms: ["custom union"] }];
    if (outcome === "blocked") input.evidence.discoveryResults = [{ requestId: "discovery-request-1", intentId: "semantic-1", outcome, catalogIds: [], rationale: "Necessary reference is not in the catalog." }];
    refresh(input);
    assert.throws(() => assembleCompliance(input), /blocked discovery/);
    input.decisions[0].decision = "not-assessed";
    assert.equal(assembleCompliance(input).status, "not-assessed");
  });
}

test("linked references require retained content, rooted selection provenance, and current-intent review", () => {
  const input = fixture(1);
  input.evidence.documents[0].guidance = [{ section: "Further reference", excerpt: "Consult the additional resource guidance.", queryTerms: [], examples: [], applicableDeclarationIds: [] }];
  input.evidence.documents[0].noRelevantGuidance = false;
  const second = readComplianceCatalog()[1].catalogId;
  input.evidence.additionalSelections = [{
    intentId: "semantic-1", sourceCatalogId: input.evidence.documents[0].catalogId,
    sourceSection: "Further reference", trigger: "linked-reference", outcome: "selected",
    catalogIds: [second], rationale: "This section identifies a necessary reference.",
  }];
  refresh(input);
  assert.throws(() => assembleCompliance(input), /falsely claims completed review/);
  input.decisions[0].decision = "not-assessed";
  assert.equal(assembleCompliance(input).coverage.selectedDocumentCount, 2);
  input.evidence.additionalSelections[0].sourceSection = "Unretained";
  assert.throws(() => refresh(input), /retained source document and section/);
});

test("targeted no-match cannot clear unavailable deterministic classification evidence", () => {
  const input = fixture(1);
  input.requests[0].guidanceRouting.discoveryRequests = [{
    requestId: "discovery-request-1", reviewUnitId: "semantic-1", trigger: "classification-blocked",
    queryTerms: ["classification-diagnostic:reference-service-plane-conflicting"],
  }];
  input.evidence.discoveryResults = [{
    requestId: "discovery-request-1", intentId: "semantic-1", outcome: "no-match",
    catalogIds: [], rationale: "No match.",
  }];
  assert.throws(() => refresh(input), /blocked canonical classification evidence/);
  input.evidence.discoveryResults[0].outcome = "blocked";
  input.decisions[0].decision = "not-assessed";
  refresh(input);
  assert.equal(assembleCompliance(input).status, "not-assessed");
});

test("normative findings require owned declarations and retained reviewed excerpts", () => {
  const input = fixture(1);
  input.evidence.documents[0].guidance = [{ section: "Resource types", excerpt: "Use the standard resource template.", queryTerms: ["Widget"], examples: [], applicableDeclarationIds: ["declaration-1"] }];
  input.evidence.documents[0].noRelevantGuidance = false;
  Object.assign(input.decisions[0], {
    decision: "applicable-fail", title: "Incorrect template", severity: "medium", expected: "Use the standard resource template.",
    applicableGuidance: [{ canonicalDocumentUrl: input.evidence.documents[0].canonicalUrl, guidanceSection: "Resource types" }],
  });
  refresh(input);
  const result = assembleCompliance(input);
  assert.equal(result.findings[0].applicableGuidance[0].excerpt, input.evidence.documents[0].guidance[0].excerpt);
  assert.deepEqual(result.findings[0].codeSnippets[0].lines, ["+model Widget {}"]);
  input.evidence.documents[0].guidance[0].applicableDeclarationIds = [];
  assert.throws(() => assembleCompliance(input), /unowned normative guidance/);
});

test("legacy findings show only changed code lines that use legacy constructs", () => {
  const input = fixture(1);
  input.requests[0].queryProfile.action = "add";
  Object.assign(input.sourceChanges[0].declarations[0], {
    kind: "model",
    hunkIds: ["hunk-1"],
    source: { revision: "current", startLine: 17, endLine: 32 },
    sourceSnippet: {
      startLine: 17,
      endLine: 32,
      lines: [
        'import "@azure-tools/typespec-azure-core";',
        'import "@azure-tools/typespec-azure-resource-manager";',
        "using Azure.ResourceManager;",
        "",
        '#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy compatibility"',
        "@Azure.ResourceManager.Legacy.feature(Features.widget)",
        "@added(Versions.v2)",
        "model Widget {",
        "  name: string;",
        "}",
      ],
    },
  });
  input.sourceChanges[0].hunks[0].lines = [
    '+import "@azure-tools/typespec-azure-core";',
    '+#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy compatibility"',
    "+@Azure.ResourceManager.Legacy.feature(Features.widget)",
    "+model Widget {}",
  ];
  input.evidence.documents[0].guidance = [{
    section: "Resource types",
    excerpt: "Use current ARM resource models.",
    queryTerms: ["resource models"],
    examples: [],
    applicableDeclarationIds: ["declaration-1"],
  }];
  input.evidence.documents[0].noRelevantGuidance = false;
  Object.assign(input.decisions[0], {
    decision: "applicable-fail",
    title: "New model uses legacy ARM",
    severity: "medium",
    expected: "Use current ARM resource models.",
    actual: "The added Widget model uses @Azure.ResourceManager.Legacy.feature.",
    applicableGuidance: [{
      canonicalDocumentUrl: input.evidence.documents[0].canonicalUrl,
      guidanceSection: "Resource types",
    }],
  });
  refresh(input);
  const [snippet] = assembleCompliance(input).findings[0].codeSnippets;
  assert.deepEqual(
    snippet.lines,
    [
      '+#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy compatibility"',
      "+@Azure.ResourceManager.Legacy.feature(Features.widget)",
      "+model Widget {}",
    ],
  );
});

test("legacy findings show owning declaration context when usage is inherited", () => {
  const input = fixture(1);
  input.requests[0].queryProfile.action = "add";
  input.requests[0].declarationIds.push("declaration-2");
  input.sourceChanges[0].declarations.push({
    id: "declaration-2",
    qualifiedName: "Widgets",
    kind: "interface",
    hunkIds: ["hunk-1"],
    source: { revision: "current", startLine: 10, endLine: 20 },
    sourceSnippet: {
      startLine: 10,
      endLine: 20,
      lines: [
        '#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Compatibility"',
        "@Azure.ResourceManager.Legacy.feature(Features.widget)",
        "@armResourceOperations",
        "interface Widgets {}",
      ],
    },
  });
  input.evidence.documents[0].guidance = [{
    section: "Resource operations",
    excerpt: "Use current ARM templates.",
    queryTerms: ["ARM templates"],
    examples: [],
    applicableDeclarationIds: ["declaration-1"],
  }];
  input.evidence.documents[0].noRelevantGuidance = false;
  Object.assign(input.decisions[0], {
    decision: "applicable-fail",
    title: "New operation inherits legacy ARM usage",
    severity: "medium",
    expected: "Use current ARM templates.",
    actual: "The added operation inherits @Azure.ResourceManager.Legacy.feature from Widgets.",
    applicableGuidance: [{
      canonicalDocumentUrl: input.evidence.documents[0].canonicalUrl,
      guidanceSection: "Resource operations",
    }],
  });
  refresh(input);
  assert.deepEqual(
    assembleCompliance(input).findings[0].codeSnippets[0].lines,
    [
      '+#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Compatibility"',
      "+@Azure.ResourceManager.Legacy.feature(Features.widget)",
      "+@armResourceOperations",
      "+interface Widgets {}",
    ],
  );
});

test("rejects rewritten immutable selections and legacy ranked artifacts with migration guidance", () => {
  const input = fixture(1);
  input.evidence.documentSelections[0].ruleId = "invented";
  assert.throws(() => assembleCompliance(input), /immutable canonical routing/);
  input.evidence.schemaVersion = 2;
  assert.throws(() => assembleCompliance(input), /rerun deterministic analysis/);
});

test("no informational intents means no documents; semantic blockers still prevent pass", () => {
  const input = fixture(0);
  input.requests = [];
  input.decisions = [];
  refresh(input);
  assert.equal(assembleCompliance(input).coverage.selectedDocumentCount, 0);
  assert.equal(assembleCompliance({ ...input, initialBlockers: ["Compiler failed."] }).status, "not-assessed");
  input.evidence.documents = fixture(1).evidence.documents;
  assert.throws(() => assembleCompliance(input), /selection provenance/);
});
