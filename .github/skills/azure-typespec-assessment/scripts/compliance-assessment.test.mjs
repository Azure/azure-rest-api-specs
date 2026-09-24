import assert from "node:assert/strict";
import test from "node:test";
import { assembleCompliance, readComplianceCatalog } from "./compliance-assessment.mjs";
import { buildComplianceSearchRequests } from "./compliance-search-request.mjs";

/** @typedef {import("./compliance-search-evidence.schema.js").Document} ComplianceDocument */
/** @typedef {import("./compliance-search-evidence.schema.js").RankedCatalogEntry} RankedCatalogEntry */
/** @typedef {import("./compliance-search-evidence.schema.js").Score} ComplianceScore */
/** @typedef {import("./compliance-search-evidence.schema.js").TypeSpecAzureGuidelinesSearchEvidence} SearchEvidence */
/** @typedef {import("./runtime-types.js").ComplianceDecision} ComplianceDecision */
/** @typedef {import("./runtime-types.js").ComplianceSearchRequest} ComplianceSearchRequest */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {SearchEvidence & {rankedDocuments: [ComplianceDocument, ComplianceDocument, ComplianceDocument, ComplianceDocument]}} FixtureEvidence */
/**
 * @typedef {{
 *   source: SourceChange,
 *   requests: [ComplianceSearchRequest, ...ComplianceSearchRequest[]],
 *   evidence: FixtureEvidence,
 *   decisions: [ComplianceDecision, ...ComplianceDecision[]]
 * }} Fixture
 */

const HASH = `sha256:${"a".repeat(64)}`;

/**
 * @param {unknown} value
 * @returns {value is unknown[]}
 */
function isUnknownArray(value) {
  return Array.isArray(value);
}

void test("catalog prioritizes API evolution and separates supported resource and paging guidance", () => {
  const catalog = readComplianceCatalog();
  const urls = catalog.map((entry) => entry.canonicalUrl);
  assert.equal(catalog[0].title, "Evolving APIs");
  assert.equal(new Set(urls).size, urls.length);
  for (const excluded of [
    "/howtos/arm/agent-base-type/",
    "/getstarted/azure-core/step05/",
    "/libraries/azure-core/reference/interfaces/",
  ]) {
    assert.equal(
      urls.some((url) => url.endsWith(excluded)),
      false,
    );
  }
  const pagination = catalog.find((entry) => entry.title === "TypeSpec pagination");
  const resourceManagerDataTypes = catalog.find(
    (entry) => entry.title === "Azure.ResourceManager data types",
  );
  const restDecorators = catalog.find((entry) => entry.title === "TypeSpec.Rest decorators");
  const resourceManagerDecorators = catalog.find(
    (entry) => entry.title === "Azure.ResourceManager decorators",
  );
  assert.ok(pagination);
  assert.ok(resourceManagerDataTypes);
  assert.ok(restDecorators);
  assert.ok(resourceManagerDecorators);
  assert.equal(pagination.category, "Data-Plane Paging");
  assert.equal(resourceManagerDataTypes.category, "ARM Paging");
  assert.equal(restDecorators.category, "Resource Semantics");
  assert.equal(resourceManagerDecorators.category, "Resource Semantics");
  assert.ok(catalog.some((entry) => entry.title === "Specific extension resource sample"));
});

/** @returns {Fixture} */
function fixture() {
  /** @type {SourceChange} */
  const source = {
    id: "source-1",
    path: "specification/widgets/resource-manager/Microsoft.Widgets/main.tsp",
    status: "modified",
    origins: [],
    hunks: [
      {
        id: "hunk-1",
        base: { startLine: 10, endLine: 10 },
        current: { startLine: 10, endLine: 11 },
        lines: ["+@parentResource(Widget)", "+model Child is ProxyResource<ChildProperties>;"],
      },
    ],
    declarations: [
      {
        id: "declaration-1",
        kind: "model",
        qualifiedName: "Microsoft.Widgets.Child",
        decorators: ["@parentResource"],
        versionedMembers: [],
        hunkIds: ["hunk-1"],
        source: {
          revision: "current",
          startLine: 10,
          endLine: 11,
          link: "https://example.test/main.tsp#L10-L11",
        },
      },
    ],
  };
  const requests = /** @type {[ComplianceSearchRequest, ...ComplianceSearchRequest[]]} */ (
    buildComplianceSearchRequests({
      semanticReviewUnits: [
        {
          id: "semantic-1",
          action: "add",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
        },
      ],
      sourceChanges: { "source-1": source },
    })
  );
  /** @type {ComplianceScore[]} */
  const scoreValues = [
    {
      exactSymbol: 4,
      patternCategory: 3,
      servicePlane: 2,
      changeContext: 1,
      total: 10,
    },
    {
      exactSymbol: 4,
      patternCategory: 3,
      servicePlane: 2,
      changeContext: 0,
      total: 9,
    },
    {
      exactSymbol: 4,
      patternCategory: 3,
      servicePlane: 0,
      changeContext: 1,
      total: 8,
    },
    {
      exactSymbol: 4,
      patternCategory: 3,
      servicePlane: 0,
      changeContext: 0,
      total: 7,
    },
  ];
  const catalogRankingEntries = readComplianceCatalog().map((item, index) => ({
    rank: index + 1,
    catalogOrder: item.catalogOrder,
    title: item.title,
    canonicalUrl: item.canonicalUrl,
    score: scoreValues[index] ?? {
      exactSymbol: 0,
      patternCategory: 0,
      servicePlane: 0,
      changeContext: 0,
      total: 0,
    },
    selectionRationale:
      index < 4
        ? "The document matches the changed ARM resource pattern."
        : "The document has lower relevance to this intent.",
  }));
  assert.ok(catalogRankingEntries[0]);
  /** @type {[RankedCatalogEntry, ...RankedCatalogEntry[]]} */
  const catalogRanking = [catalogRankingEntries[0], ...catalogRankingEntries.slice(1)];
  const documentEntries = catalogRanking.slice(0, 4).map((item, index) => ({
    ...item,
    retrieval: {
      status: /** @type {const} */ ("fetched"),
      retrievedAt: "2026-08-28T00:00:00.000Z",
      contentHash: HASH,
    },
    guidance:
      index === 0
        ? [
            {
              section: "Resource types",
              excerpt: "Guidance 1",
              queryTerms: ["ProxyResource"],
              examples: /** @type {[string]} */ ([
                "model Child is ProxyResource<ChildProperties>;",
              ]),
              applicableDeclarationIds: /** @type {[string]} */ (["declaration-1"]),
            },
          ]
        : [],
    noRelevantGuidance: index !== 0,
  }));
  assert.ok(documentEntries[0]);
  assert.ok(documentEntries[1]);
  assert.ok(documentEntries[2]);
  assert.ok(documentEntries[3]);
  /** @type {[ComplianceDocument, ComplianceDocument, ComplianceDocument, ComplianceDocument]} */
  const documents = [
    documentEntries[0],
    documentEntries[1],
    documentEntries[2],
    documentEntries[3],
  ];
  /** @type {FixtureEvidence} */
  const evidence = {
    schemaVersion: 2,
    queryProfiles: [
      {
        reviewUnitId: "semantic-1",
        queryProfile: requests[0].queryProfile,
      },
    ],
    catalogRanking,
    rankedDocuments: documents,
    retrievalAttempts: [],
    blockers: [],
    inputAccounting: {
      catalogEntriesScored: readComplianceCatalog().length,
      documentsFetched: 4,
      documentBytesFetched: 1000,
      guidanceExcerptsRetained: 1,
      guidanceExcerptBytesRetained: 100,
    },
  };
  /** @type {[ComplianceDecision, ...ComplianceDecision[]]} */
  const decisions = [
    {
      reviewUnitId: "semantic-1",
      applicableGuidance: [
        {
          canonicalDocumentUrl: documents[0].canonicalUrl,
          guidanceSection: "Resource types",
        },
      ],
      sourceChangeIds: ["source-1"],
      hunkIds: ["hunk-1"],
      declarationIds: ["declaration-1"],
      decision: "applicable-fail",
      title: "Child does not use the documented resource template",
      severity: "medium",
      expected: "Guidance 1",
      actual: "model Child is ProxyResource<ChildProperties>;",
      rationale: "The changed intent contradicts the documented requirement.",
    },
  ];
  return { source, requests, evidence, decisions };
}

void test("builds a bounded Azure Guidelines query profile from Semantic intent evidence", () => {
  const { requests } = fixture();
  assert.equal(requests.length, 1);
  assert.equal(requests[0].queryProfile.servicePlane, "resource-manager");
  assert.equal(requests[0].queryProfile.action, "add");
  assert.deepEqual(requests[0].declarationIds, ["declaration-1"]);
  assert.ok(requests[0].queryProfile.categories.includes("resource"));
  assert.ok(requests[0].queryProfile.symbols.includes("@parentResource"));
  assert.equal(requests[0].queryProfile.representativeSourceExcerpts.length, 1);
  assert.equal(requests[0].queryProfile.affectedOperationCount, 0);
});

void test("assembles one Azure Guidelines finding and coverage per Semantic intent", () => {
  const { source, requests, evidence, decisions } = fixture();
  const compliance = assembleCompliance({
    requests,
    evidence,
    decisions,
    sourceChanges: [source],
  });
  assert.equal(compliance.status, "failed");
  assert.equal(compliance.findings.length, 1);
  assert.equal(compliance.coverage.semanticIntentCount, 1);
  assert.equal(compliance.coverage.assessedIntentCount, 1);
  assert.equal(compliance.coverage.selectedDocumentCount, 4);
  assert.equal(compliance.intentAssessments[0].decision, "applicable-fail");
  assert.equal(compliance.intentAssessments[0].documents, undefined);
  assert.ok(compliance.sharedSearch);
  assert.ok(isUnknownArray(compliance.sharedSearch.documents));
  assert.equal(compliance.sharedSearch.documents.length, 4);
  const snippets = /** @type {{lines?: string[]}[]} */ (compliance.findings[0].codeSnippets);
  assert.ok(snippets);
  assert.deepEqual(snippets[0].lines, [
    "+@parentResource(Widget)",
    "+model Child is ProxyResource<ChildProperties>;",
  ]);
});

void test("rejects uncataloged Azure Guidelines evidence", () => {
  const { source, requests, evidence, decisions } = fixture();
  evidence.rankedDocuments[0].canonicalUrl = "https://example.test/invented";
  assert.throws(
    () =>
      assembleCompliance({
        requests,
        evidence,
        decisions,
        sourceChanges: [source],
      }),
    /uncataloged URL/,
  );
});

void test("rejects intent decisions that cite unknown guidance", () => {
  const { source, requests, evidence, decisions } = fixture();
  decisions[0].applicableGuidance[0].guidanceSection = "Unknown";
  assert.throws(
    () =>
      assembleCompliance({
        requests,
        evidence,
        decisions,
        sourceChanges: [source],
      }),
    /uses unfetched guidance/,
  );
});

void test("rejects incomplete declaration source provenance", () => {
  const { source, requests, evidence, decisions } = fixture();
  decisions[0] = { ...decisions[0], sourceChangeIds: [], hunkIds: [] };
  assert.throws(
    () =>
      assembleCompliance({
        requests,
        evidence,
        decisions,
        sourceChanges: [source],
      }),
    /lacks applicable evidence/,
  );
});

void test("counts completed searches with no governing guidance as assessed", () => {
  const { source, requests, evidence, decisions } = fixture();
  requests[0].declarationIds.push("declaration-2");
  evidence.rankedDocuments[0].guidance[0].applicableDeclarationIds.push("declaration-2");
  decisions[0] = {
    reviewUnitId: "semantic-1",
    applicableGuidance: [],
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
    declarationIds: ["declaration-1"],
    decision: "no-applicable-guidance",
    actual: "The intent uses a generator-specific decorator.",
    rationale:
      "The fetched page documents generic decorator syntax but does not define the generator-specific semantics.",
  };
  const compliance = assembleCompliance({
    requests,
    evidence,
    decisions,
    sourceChanges: [source],
  });
  assert.equal(compliance.status, "passed");
  assert.equal(compliance.findings.length, 0);
  assert.equal(compliance.coverage.assessedIntentCount, 1);
  assert.deepEqual(compliance.coverage.unassessedIntentIds, []);
  assert.deepEqual(compliance.blockers, []);
  assert.deepEqual(compliance.intentAssessments[0].declarationIds, [
    "declaration-1",
    "declaration-2",
  ]);
  assert.ok(isUnknownArray(compliance.intentAssessments[0].sourceLinks));
  assert.equal(compliance.intentAssessments[0].sourceLinks.length, 1);
});

void test("does not pass Azure Guidelines when Semantic analysis is blocked", () => {
  const compliance = assembleCompliance({
    requests: [],
    evidence: {
      schemaVersion: 1,
      intents: [],
      inputAccounting: {
        catalogEntriesScored: 0,
        documentsFetched: 0,
        documentBytesFetched: 0,
        guidanceExcerptsRetained: 0,
        guidanceExcerptBytesRetained: 0,
      },
    },
    decisions: [],
    sourceChanges: [],
    initialBlockers: ["semantic-analysis-blocked: compiler failed."],
  });
  assert.equal(compliance.status, "not-assessed");
  assert.equal(compliance.blockers.length, 1);
});

void test("ranks and fetches one shared document set for multiple Semantic intents", () => {
  const { source, requests, evidence, decisions } = fixture();
  requests.push({
    ...structuredClone(requests[0]),
    reviewUnitId: "semantic-2",
    requestId: "compliance-search-2",
  });
  evidence.queryProfiles.push({
    reviewUnitId: "semantic-2",
    queryProfile: structuredClone(requests[1].queryProfile),
  });
  decisions.push({
    reviewUnitId: "semantic-2",
    applicableGuidance: [],
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
    declarationIds: ["declaration-1"],
    decision: "no-applicable-guidance",
    actual: "The second intent changes the same resource area.",
    rationale: "None of the four shared documents governs this intent.",
  });
  const compliance = assembleCompliance({
    requests,
    evidence,
    decisions,
    sourceChanges: [source],
  });
  assert.equal(compliance.coverage.semanticIntentCount, 2);
  assert.equal(compliance.coverage.selectedDocumentCount, 4);
  assert.ok(compliance.sharedSearch);
  assert.ok(isUnknownArray(compliance.sharedSearch.documents));
  assert.equal(compliance.sharedSearch.documents.length, 4);
  assert.ok(
    compliance.intentAssessments.every(
      (intent) => intent.catalogRanking === undefined && intent.documents === undefined,
    ),
  );
});
