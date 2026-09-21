import assert from "node:assert/strict";
import { existsSync, readFileSync } from "node:fs";
import test from "node:test";
import { documentQualitySummary } from "./assessment-report-ui.mjs";
import { readComplianceCatalog } from "./compliance-assessment.mjs";
import {
  assembleDocumentQuality,
  DOCUMENT_QUALITY_ARTIFACT,
} from "./document-quality-assessment.mjs";
import { buildDocumentQualityInput } from "./document-quality-input.mjs";
import {
  complianceFindingGroups,
  downstreamTypeCards,
  escapeHtml,
  operationContractRows,
  renderAssessmentHtml as renderCurrentAssessmentHtml,
  representativeSource,
  restContractCards,
  visibleSharedTypeImpacts,
} from "./render-assessment-html.mjs";
import { normalizeRecordedAssessment, reportSection } from "./report-test-utils.mjs";

/** @typedef {import("./runtime-types.js").AssessmentFact} AssessmentFact */
/** @typedef {import("./runtime-types.js").AssessmentFinding} AssessmentFinding */
/** @typedef {import("./runtime-types.js").AssessmentOutput} AssessmentOutput */
/** @typedef {import("./runtime-types.js").AssessmentTypeImpact} AssessmentTypeImpact */
/** @typedef {import("./runtime-types.js").DocumentQualityDimension} DocumentQualityDimension */
/** @typedef {import("./runtime-types.js").FinalComplianceAssessment} FinalComplianceAssessment */
/** @typedef {NonNullable<Parameters<typeof renderCurrentAssessmentHtml>[1]>} RenderOptions */
/**
 * @typedef {{
 *   schemaVersion?: number,
 *   comparison?: {
 *     baseCommit: string,
 *     headCommit: string,
 *     workingTree?: boolean | Record<string, unknown>,
 *     [key: string]: unknown
 *   },
 *   dimensions: Record<string, unknown>,
 *   blockers?: unknown[],
 *   [key: string]: unknown
 * }} AssessmentFixture
 */
/**
 * @typedef {AssessmentOutput & {
 *   dimensions: AssessmentOutput["dimensions"] & {
 *     documentQuality: DocumentQualityDimension & {
 *       coverage: NonNullable<DocumentQualityDimension["coverage"]>,
 *       intentAssessments: NonNullable<DocumentQualityDimension["intentAssessments"]>,
 *       findings: NonNullable<DocumentQualityDimension["findings"]>
 *     }
 *   }
 * }} DocumentedAssessment
 */
/** @typedef {"pass" | "fail" | "not-assessed"} TestDocumentDecision */
/** @typedef {Pick<AssessmentTypeImpact, "findingIds" | "affectedMethodCount">} VisibleImpactFixture */
/**
 * @typedef {Pick<AssessmentFinding,
 *   "id" | "severity" | "crossLanguageDefinitionId" | "relatedSemanticIntents"
 * >} DownstreamFindingFixture
 */
/**
 * @typedef {Pick<AssessmentFinding,
 *   "id" | "rule" | "severity" | "contractChange" | "operationIds" |
 *   "relatedSemanticIntents" | "sources" | "evidence"
 * >} RestFindingFixture
 */

/**
 * @template T
 * @param {T | null | undefined} value
 * @param {string} [message]
 * @returns {T}
 */
function required(value, message = "Expected test fixture value.") {
  assert.ok(value, message);
  return value;
}

/**
 * @param {{
 *   operationId: string,
 *   changedAspects: string[],
 *   before: Record<string, unknown>,
 *   after: Record<string, unknown>
 * }} operation
 */
function fixtureOperationContractRows(operation) {
  return operationContractRows(
    /** @type {Parameters<typeof operationContractRows>[0]} */ (/** @type {unknown} */ (operation)),
  );
}

/** @param {{sources: Record<string, unknown>[], operations: Record<string, unknown>[]}} item */
function fixtureRepresentativeSource(item) {
  return representativeSource(
    /** @type {Parameters<typeof representativeSource>[0]} */ (/** @type {unknown} */ (item)),
  );
}

/** @param {Record<string, unknown>[]} findings */
function fixtureComplianceFindingGroups(findings) {
  return complianceFindingGroups(
    /** @type {Parameters<typeof complianceFindingGroups>[0]} */ (
      /** @type {unknown} */ (findings)
    ),
  );
}

/**
 * @param {string} value
 * @param {RegExp} pattern
 * @param {number} [group]
 */
function requiredMatch(value, pattern, group = 0) {
  const match = value.match(pattern);
  assert.ok(match);
  const capture = match[group];
  assert.ok(capture);
  return capture;
}

/** @param {VisibleImpactFixture[]} impacts */
function visibleFixtureImpacts(impacts) {
  return visibleSharedTypeImpacts(
    /** @type {AssessmentTypeImpact[]} */ (/** @type {unknown} */ (impacts)),
  );
}

/**
 * @param {{findings: DownstreamFindingFixture[], typeImpacts: AssessmentTypeImpact[]}} dimension
 */
function fixtureDownstreamTypeCards(dimension) {
  return downstreamTypeCards(
    /** @type {AssessmentOutput["dimensions"]["downstream"]} */ (
      /** @type {unknown} */ (dimension)
    ),
  );
}

/** @param {RestFindingFixture[]} findings */
function fixtureRestContractCards(findings) {
  return restContractCards(/** @type {AssessmentFinding[]} */ (/** @type {unknown} */ (findings)));
}

/** @param {URL} url @returns {AssessmentOutput} */
function readAssessment(url) {
  const value = /** @type {unknown} */ (JSON.parse(readFileSync(url, "utf8")));
  return /** @type {AssessmentOutput} */ (value);
}

/**
 * @param {AssessmentOutput | AssessmentFixture} assessment
 * @param {RenderOptions} [options]
 */
function renderAssessmentHtml(assessment, options) {
  return renderCurrentAssessmentHtml(
    normalizeRecordedAssessment(
      /** @type {AssessmentOutput} */ (/** @type {unknown} */ (assessment)),
    ),
    options,
  );
}

const recordedAssessmentTest = existsSync(new URL("../evals/assessments", import.meta.url))
  ? test
  : test.skip;

/** @param {string} html */
function assertNoDocumentAppendixUi(html) {
  const body = html.includes("<main") ? html.slice(html.indexOf("<main")) : html;
  assert.doesNotMatch(
    body,
    /documentation-review-appendix|document-quality-passed-group|document-quality-not-assessed-group|document-quality-file|class="document-quality-document"/,
  );
}

/** @param {string} html @param {string} label */
function summaryCardValue(html, label) {
  const escapedLabel = label.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  return Number(
    required(
      html.match(
        new RegExp(
          `<div class="summary-label">${escapedLabel}<\\/div><\\/div><div class="summary-detail">(?:Not assessed<br>)?(\\d+) (?:findings?|intents?)`,
        ),
      ),
    )[1],
  );
}

/** @returns {FinalComplianceAssessment} */
function notAssessedCompliance() {
  return {
    status: "not-assessed",
    summary: "Azure Guidelines evidence is unavailable.",
    coverage: {
      semanticIntentCount: 0,
      assessedIntentCount: 0,
      selectedDocumentCount: 0,
      unassessedIntentIds: [],
    },
    intentAssessments: [],
    findings: [],
    retrievalFailures: [],
    blockers: [
      {
        message: "compliance-search-input-missing: test fixture has no search input.",
      },
    ],
  };
}

void test("shows confirmed type impacts without method reachability", () => {
  const impact = {
    findingIds: ["downstream-1"],
    affectedMethodCount: 0,
  };
  assert.deepEqual(visibleFixtureImpacts([impact]), [impact]);
  assert.deepEqual(
    visibleFixtureImpacts([
      {
        findingIds: [],
        affectedMethodCount: 0,
      },
    ]),
    [],
  );
});

void test("renders one collapsed downstream card per SDK type", () => {
  /** @type {DownstreamFindingFixture[]} */
  const findings = [
    {
      id: "downstream-1",
      severity: "high",
      crossLanguageDefinitionId: "Contoso.Widget",
      relatedSemanticIntents: ["semantic-1"],
    },
    {
      id: "downstream-2",
      severity: "medium",
      crossLanguageDefinitionId: "Contoso.Widget",
      relatedSemanticIntents: ["semantic-1"],
    },
    {
      id: "downstream-3",
      severity: "high",
      crossLanguageDefinitionId: "Contoso.Gadget",
      relatedSemanticIntents: ["semantic-2"],
    },
  ];
  const cards = fixtureDownstreamTypeCards({
    findings,
    typeImpacts: [
      {
        id: "shared-1",
        rootCauseIds: ["root-1"],
        summary: "Shared change.",
        findingIds: ["downstream-1", "downstream-2"],
        type: "Contoso.Widget",
        affectedMethods: [],
      },
      {
        id: "shared-2",
        rootCauseIds: ["root-2"],
        summary: "Shared change.",
        findingIds: ["downstream-3"],
        type: "Contoso.Gadget",
        affectedMethods: [],
      },
    ],
  });

  assert.deepEqual(
    cards.map((card) => card.type),
    ["Contoso.Gadget", "Contoso.Widget"],
  );
  assert.equal(cards[1].findings.length, 2);
  assert.deepEqual(cards[1].relatedSemanticIntents, ["semantic-1"]);
  assert.deepEqual(cards[0].legacyImpactIds, ["shared-2"]);
});

void test("renders SDK contract changes without REST operation association", () => {
  const source = {
    id: "source-enum",
    path: "specification/hardwaresecuritymodules/models.tsp",
    origins: ["committed"],
    hunks: [
      {
        id: "hunk-enum",
        current: { startLine: 283, endLine: 296 },
        lines: [
          "-enum CloudHsmClusterSkuName {",
          "-  `Standard B10`,",
          "+union CloudHsmClusterSkuName {",
          "+  string,",
          '+  StandardB10: "Standard B10",',
        ],
      },
    ],
    declarations: [],
  };
  /**
   * @param {string} comparisonRole
   * @param {{name: string, value: string | number}[]} values
   * @param {boolean} isFixed
   * @param {boolean} isUnionAsEnum
   * @returns {AssessmentFact}
   */
  const enumFact = (comparisonRole, values, isFixed, isUnionAsEnum) => ({
    factKind: "enum",
    comparisonRole,
    isFixed,
    isUnionAsEnum,
    values,
  });
  const operations = ["CreateOrUpdate", "Get", "Update"].map((name) => ({
    operationId: `CloudHsmClusters_${name}`,
    apiVersion: "2025-03-31",
    method: name === "CreateOrUpdate" ? "put" : name === "Update" ? "patch" : "get",
    path: "/cloudHsmClusters/{cloudHsmClusterName}",
    changedAspects: [],
    restChanged: false,
    outcome: "HTTP contract unchanged.",
  }));
  const html = renderAssessmentHtml({
    schemaVersion: 1,
    comparison: { baseCommit: "base", headCommit: "head" },
    confidence: "high",
    safety: { scope: "rest-and-downstream-only", status: "failed" },
    dimensions: {
      semantic: {
        status: "assessed",
        sourceHunkIds: ["hunk-enum"],
        items: [
          {
            id: "semantic-enum",
            action: "modify",
            title: "Make Cloud HSM SKU names extensible",
            summary: "Replace the fixed enum with an extensible enum.",
            sources: [source],
            operations,
            relatedFindings: {
              downstream: [],
              typeImpact: ["shared-enum"],
            },
          },
        ],
      },
      rest: { status: "passed", findings: [] },
      downstream: {
        status: "failed",
        findings: [
          {
            id: "downstream-enum",
            rule: "enum-values-removed",
            severity: "high",
            actual: "The generated enum member identity changed.",
            expected: "The generated enum member identity remains stable.",
            rationale:
              "Making the enum extensible is compatible by itself. Existing SDK source must migrate from `Standard B10` to `StandardB10`.",
            crossLanguageDefinitionId: "Microsoft.HardwareSecurityModules.CloudHsmClusterSkuName",
            evidence: [
              enumFact(
                "baseline",
                [
                  { name: "Standard B10", value: "Standard B10" },
                  { name: "Standard_B1", value: "Standard_B1" },
                ],
                true,
                false,
              ),
              enumFact(
                "target",
                [
                  { name: "StandardB10", value: "Standard B10" },
                  { name: "Standard_B1", value: "Standard_B1" },
                ],
                false,
                true,
              ),
            ],
            sources: [source],
            relatedSemanticIntents: ["semantic-enum"],
          },
        ],
        methodGroups: [],
        typeImpacts: [
          {
            id: "shared-enum",
            rootCauseIds: ["root-enum"],
            summary: "The public SDK enum member changed.",
            findingIds: ["downstream-enum"],
            type: "Microsoft.HardwareSecurityModules.CloudHsmClusterSkuName",
            locations: ["response-body"],
            affectedMethods: [
              {
                symbol: "Microsoft.HardwareSecurityModules.CloudHsmClusters.get",
                locations: ["response-body"],
                referenceFactIds: ["method-1", "type-1"],
              },
            ],
            affectedMethodCount: 1,
            relatedSemanticIntents: ["semantic-enum"],
          },
        ],
      },
      compliance: notAssessedCompliance(),
      documentQuality: {
        status: "not-assessed",
        summary: "Document Quality and Agent Friendliness is not assessed.",
      },
    },
    changedFiles: [source],
    projects: [],
    blockers: [],
    provenance: {},
  });

  assert.match(html, /<strong>CloudHsmClusters\.get<\/strong>/);
  assert.match(html, /\.contract-tag\{background:#dbeafe;color:#1e40af\}/);
  assert.doesNotMatch(html, /SDK contract changes — 3 affected REST operations/);
  assert.doesNotMatch(html, /Mapped SDK methods/);
  assert.doesNotMatch(html, /Root-cause provenance/);
  assert.match(html, /Fixed enum[\s\S]*Extensible enum/);
  assert.match(html, /Contract area<\/th><th>Before<\/th><th>After/);
  assert.match(html, /<span class="contract-area-kind">Enum shape<\/span>/);
  assert.match(html, /CloudHsmClusterSkuName\.Standard B10/);
  assert.match(html, /StandardB10/);
  const downstream = requiredMatch(
    html,
    /<section id="downstream-breaking">([\s\S]*?)<\/section>/,
    1,
  );
  assert.doesNotMatch(downstream, /Affected REST operations/);
  assert.match(downstream, /1 mapped methods/);
  assert.match(downstream, /Microsoft\.HardwareSecurityModules\.CloudHsmClusters\.get/);
  assert.match(html, /Impacts \(1\)/);
  assert.match(html, /class="report-link impact"[^>]*>Downstream: CloudHsmClusters\.get<\/a>/);
  assert.doesNotMatch(downstream, /CloudHsmClusters_CreateOrUpdate/);
  assert.doesNotMatch(downstream, /Changed TypeSpec:/);
  assert.match(downstream, /Affected intents \(1\)/);
});

void test("groups REST contract deltas by schema identity and retains affected operations", () => {
  /**
   * @param {string} comparisonRole
   * @param {string} operationId
   * @returns {AssessmentFact}
   */
  const operation = (comparisonRole, operationId) =>
    /** @type {AssessmentFact} */ (
      /** @type {unknown} */ ({
        comparisonRole,
        operationId,
        apiVersion: "v1",
        method: "get",
        path: "/widgets",
        responses: [
          {
            status: "200",
            headers: [],
            schema: {
              kind: "object",
              properties:
                comparisonRole === "baseline"
                  ? [
                      {
                        name: "state",
                        schema: {
                          kind: "enum",
                          type: "string",
                          reference: "stable/v1.json#/definitions/WidgetState",
                          values: ["Ready", "Deleted"],
                        },
                      },
                    ]
                  : [],
            },
          },
        ],
      })
    );
  /** @type {RestFindingFixture[]} */
  const findings = ["Widgets_Get", "Widgets_List"].map((operationId, index) => ({
    id: `rest-${index}`,
    rule: "serialized-property-removed",
    severity: "high",
    contractChange: {
      rule: "serialized-property-removed",
      location: "response 200.state",
    },
    operationIds: [operationId],
    relatedSemanticIntents: ["semantic-1"],
    sources: [],
    evidence: [operation("baseline", operationId), operation("target", operationId)],
  }));

  const cards = fixtureRestContractCards(findings);

  assert.equal(cards.length, 1);
  assert.equal(cards[0].identity, "WidgetState");
  assert.equal(cards[0].operations.length, 2);
  assert.equal(cards[0].findings[0].contractDelta.before, "WidgetState { Ready | Deleted }");
  assert.equal(cards[0].findings[0].contractDelta.after, "removed");
});

void test("renderer shows fetched Azure Guidelines guidance and expands failures", () => {
  const catalog = readComplianceCatalog();
  const scores = [10, 9, 8, 7];
  const catalogRanking = catalog.map((item, index) => ({
    rank: index + 1,
    catalogOrder: item.catalogOrder,
    title: item.title,
    canonicalUrl: item.canonicalUrl,
    score:
      index < 4
        ? {
            exactSymbol: 4,
            patternCategory: 3,
            servicePlane: index < 2 ? 2 : 0,
            changeContext: index === 0 || index === 2 ? 1 : 0,
            total: scores[index],
          }
        : {
            exactSymbol: 0,
            patternCategory: 0,
            servicePlane: 0,
            changeContext: 0,
            total: 0,
          },
    selectionRationale:
      index < 4
        ? "Matches the changed resource pattern."
        : "Lower relevance to the changed resource pattern.",
  }));
  const documents = catalogRanking.slice(0, 4).map((item, index) => ({
    ...item,
    retrievedAt: "2026-08-28T00:00:00.000Z",
    contentHash: `sha256:${"a".repeat(64)}`,
    guidance:
      index === 0
        ? [
            {
              section: "Resource types",
              excerpt: "Use the standard resource template.",
              queryTerms: ["ProxyResource"],
              examples: ["model Child is ProxyResource<ChildProperties>;"],
              applicableDeclarationIds: ["declaration-1"],
            },
          ]
        : [],
    noRelevantGuidance: index !== 0,
  }));
  const sourceLinks = [
    {
      path: "specification/widgets/main.tsp",
      startLine: 1,
      endLine: 1,
      link: "https://example.test/main.tsp#L1",
    },
  ];
  const codeSnippets = [
    {
      path: "specification/widgets/main.tsp",
      hunkId: "hunk-version",
      lines: ['+v2026_01_01: "2026-01-01",'],
    },
    {
      path: "specification/widgets/main.tsp",
      hunkId: "hunk-1",
      lines: ["+model Child extends LegacyResource {}"],
    },
    {
      path: "specification/widgets/main.tsp",
      hunkId: "hunk-operations",
      lines: ["+interface ChildOperations {}"],
    },
  ];
  const intentAssessment = {
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
    expected: "Use the standard resource template.",
    actual: "The intent introduces a child resource using LegacyResource.",
    rationale: "The changed intent does not use the documented template.",
    gap: "The changed intent does not use the documented template.",
    sourceLinks,
    codeSnippets,
  };
  const finding = {
    id: "compliance-1",
    semanticIntentId: "semantic-1",
    ...intentAssessment,
    applicableGuidance: [
      {
        canonicalDocumentUrl: documents[0].canonicalUrl,
        guidanceSection: "Resource types",
        excerpt: "Use the standard resource template.",
      },
    ],
  };
  const html = renderAssessmentHtml({
    schemaVersion: 1,
    pullRequest: {
      number: 123,
      url: "https://github.com/Azure/azure-rest-api-specs/pull/123",
    },
    comparison: {
      baseRef: "origin/main",
      baseCommit: "base",
      headCommit: "head",
      workingTree: {},
    },
    artifactComparisons: [],
    confidence: "high",
    safety: { scope: "rest-and-downstream-only", status: "failed" },
    dimensions: {
      semantic: {
        status: "assessed",
        sourceHunkIds: ["hunk-1"],
        items: [
          {
            id: "semantic-1",
            action: "add",
            title: "Add child resource",
            summary: "Adds a child resource.",
            sourceChangeIds: ["source-1"],
            hunkIds: ["hunk-1"],
            operations: [],
            sources: [
              {
                id: "source-1",
                path: "specification/widgets/main.tsp",
                hunks: [{ id: "hunk-1", lines: codeSnippets[0].lines }],
                declarations: [
                  {
                    id: "declaration-1",
                    hunkIds: ["hunk-1"],
                    source: { revision: "current", startLine: 1, endLine: 1 },
                  },
                ],
              },
            ],
            relatedFindings: {
              rest: ["rest-1"],
              downstream: [],
              sharedTypeImpact: [],
            },
          },
        ],
        blockers: [],
      },
      rest: {
        status: "failed",
        findings: [
          {
            id: "rest-1",
            rule: "response-contract-changed",
            severity: "high",
            actual: "The response contract changed.",
            expected: "The response contract remains compatible.",
            rationale: "Existing clients may observe a different payload.",
            relatedSemanticIntents: ["semantic-1"],
            operationIds: ["Widgets_Get"],
            sources: [
              {
                id: "source-1",
                path: "specification/widgets/main.tsp",
                hunks: [{ id: "hunk-1", lines: codeSnippets[0].lines }],
                declarations: [],
              },
            ],
            evidence: [{ id: "fact-1" }],
          },
        ],
        blockers: [],
      },
      downstream: {
        status: "passed",
        findings: [],
        operationGroups: [],
        sharedTypeImpacts: [],
        impliedByRest: [],
        blockers: [],
      },
      compliance: {
        status: "failed",
        summary: "1 documentation-grounded Azure Guidelines finding.",
        coverage: {
          semanticIntentCount: 1,
          assessedIntentCount: 1,
          selectedDocumentCount: 4,
          unassessedIntentIds: [],
        },
        sharedSearch: { catalogRanking, documents },
        intentAssessments: [
          {
            semanticIntentId: "semantic-1",
            ...intentAssessment,
            blockers: [],
          },
        ],
        findings: [finding],
        retrievalFailures: [],
        blockers: [],
      },
      documentQuality: { status: "not-assessed", summary: "Not assessed." },
    },
    blockers: [],
    projects: [],
    changedFiles: [],
    provenance: {},
  });
  assert.match(html, /Azure Guidelines/);
  assert.match(
    html,
    /<section id="azure-compliance"><div class="report-section-head"><div><h2>Azure Guidelines<\/h2>/,
  );
  assert.doesNotMatch(html, /class="panel compliance-summary/);
  assert.doesNotMatch(html, /class="finding compliance-finding medium"[^>]* open/);
  assert.equal(summaryCardValue(html, "Azure Guidelines"), 1);
  assert.match(
    html,
    /<span class="fail" aria-label="Failed">×<\/span><\/div><div class="summary-label">Azure Guidelines<\/div><\/div><div class="summary-detail">1 finding<br>1\/1 intents assessed/,
  );
  const complianceHtml = reportSection(html, "azure-compliance");
  assert.ok(
    html.indexOf('<section id="azure-compliance">') <
      html.indexOf('<section id="semantic-intents">'),
  );
  assert.ok(
    html.indexOf('<a class="summary-card" href="#semantic-intents">') <
      html.indexOf('<a class="summary-card" href="#azure-compliance">'),
  );
  assert.doesNotMatch(complianceHtml, /Ranked official documents/);
  assert.doesNotMatch(complianceHtml, /class="compliance-intent"/);
  const appendixHtml = reportSection(html, "appendix");
  assert.match(appendixHtml, /Guidance fetched/);
  assert.match(appendixHtml, /<ul class="guidance-document-list">/);
  assert.doesNotMatch(appendixHtml, /class="compliance-intent"/);
  assert.match(
    appendixHtml,
    new RegExp(
      `<li><a href="${documents[0].canonicalUrl.replaceAll("/", "\\/")}">${documents[0].title}<\\/a><\\/li>`,
    ),
  );
  assert.doesNotMatch(appendixHtml, /applicable fail|finding\(s\)|score 10\/10/);
  assert.match(html, /<details class="report-card intent" id="intent-semantic-1"><summary>/);
  assert.match(
    html,
    /class="report-link impact" href="#(?:finding-rest-1|rest-operation-[^"]+)">REST:/,
  );
  assert.match(
    html,
    /class="report-link" href="#compliance-finding-compliance-1">Azure Guidelines<\/a>/,
  );
  assert.doesNotMatch(html, /Related findings:/);
  assert.doesNotMatch(html, /View Azure Guidelines assessment/);
  assert.match(html, /if \(element\.tagName === "DETAILS"\) element\.open = true/);
  assert.match(html, /Use the standard resource template/);
  assert.match(html, /Child does not use the documented resource template/);
  assert.doesNotMatch(html, /class="severity/);
  assert.doesNotMatch(html, />medium<\/span>/);
  assert.match(html, /<small>The changed intent does not use the documented template/);
  assert.match(html, /<h3>Expected<\/h3>/);
  assert.match(html, /Documented TypeSpec example/);
  assert.match(html, /<h3>Actual<\/h3>/);
  assert.match(html, /class="diff"/);
  const findingHtml = complianceHtml.slice(
    complianceHtml.indexOf('id="compliance-finding-compliance-1"'),
  );
  assert.doesNotMatch(findingHtml, /TypeSpec source:/);
  assert.match(findingHtml, /v2026_01_01/);
  assert.match(findingHtml, /The intent introduces a child resource using LegacyResource/);
  assert.match(findingHtml, /model Child extends LegacyResource/);
  assert.match(findingHtml, /interface ChildOperations/);
});

void test("escapeHtml escapes Agent and source text", () => {
  assert.equal(escapeHtml('<script x="1">&'), "&lt;script x=&quot;1&quot;&gt;&amp;");
});

void test("renderer labels active Azure Guidelines and scoped safety", () => {
  const html = renderAssessmentHtml({
    schemaVersion: 1,
    pullRequest: {
      number: 123,
      url: "https://github.com/Azure/azure-rest-api-specs/pull/123",
    },
    comparison: {
      baseRef: "origin/main",
      baseCommit: "9f0ad696cc186c2d16cb522abc0fbd4aa3854ca5",
      headCommit: "780a61ace56c22ce10dd01caa8ab95ca4514ac2e",
      workingTree: {},
    },
    artifactComparisons: [
      {
        projectId: "new-version",
        mode: "new-api-version",
        baseline: {
          sourceRevision: "current",
          commit: "780a61ace56c22ce10dd01caa8ab95ca4514ac2e",
          apiVersion: "2025-07-01",
          reason: "newest-added-version",
        },
        target: {
          sourceRevision: "current",
          commit: "780a61ace56c22ce10dd01caa8ab95ca4514ac2e",
          apiVersion: "2025-09-01",
          reason: "newest-current-version",
        },
      },
      {
        projectId: "existing-version",
        mode: "existing-api-version",
        baseline: {
          sourceRevision: "base",
          commit: "9f0ad696cc186c2d16cb522abc0fbd4aa3854ca5",
          apiVersion: "2018-10-01",
          reason: "affected-existing-version",
        },
        target: {
          sourceRevision: "current",
          commit: "780a61ace56c22ce10dd01caa8ab95ca4514ac2e",
          apiVersion: "2018-10-01",
          reason: "same-existing-version",
        },
      },
    ],
    confidence: "high",
    safety: { scope: "rest-and-downstream-only", status: "passed" },
    dimensions: {
      semantic: { status: "assessed", items: [], blockers: [] },
      rest: { status: "passed", findings: [], blockers: [] },
      downstream: { status: "passed", findings: [], blockers: [] },
      compliance: notAssessedCompliance(),
      documentQuality: { status: "not-assessed", summary: "Not assessed." },
    },
    blockers: [],
    projects: [
      {
        id: "new-version",
        path: "specification/widgets/new-version",
        artifacts: {},
      },
      {
        id: "existing-version",
        path: "specification/widgets/existing-version",
        artifacts: {},
      },
    ],
    changedFiles: [],
    provenance: {},
  });
  assert.match(html, /Azure Guidelines/);
  assert.match(html, /Documentation Completeness/);
  assert.match(html, /class="eyebrow">TypeSpec Assessment/);
  assert.match(html, /class="summary-grid"/);
  assert.match(html, /<a class="summary-card" href="#rest-breaking">/);
  assert.match(html, /<a class="summary-card" href="#semantic-intents">/);
  assert.match(html, /<a class="summary-card" href="#downstream-breaking">/);
  assert.match(html, /<a class="summary-card" href="#azure-compliance">/);
  assert.match(html, /<a class="summary-card" href="#document-quality">/);
  const summaryLabels = [
    ...html.matchAll(
      /<a class="summary-card"[\s\S]*?<div class="summary-label">([^<]+)<\/div>[\s\S]*?<\/a>/g,
    ),
  ].map((match) => match[1]);
  assert.deepEqual(summaryLabels, [
    "Semantic intents",
    "Azure Guidelines",
    "REST breaking changes",
    "Downstream breaking changes",
    "Documentation Completeness",
  ]);
  assert.doesNotMatch(html, /Overall code quality/);
  assert.equal(summaryCardValue(html, "Semantic intents"), 0);
  assert.match(html, /0 operations<br>0 Added, 0 Modified, 0 Removed/);
  assert.match(
    html,
    /<span class="pass" aria-label="Passed">✓<\/span><\/div><div class="summary-label">REST breaking changes<\/div><\/div><div class="summary-detail">0 findings/,
  );
  assert.match(
    html,
    /<span class="pass" aria-label="Passed">✓<\/span><\/div><div class="summary-label">Downstream breaking changes<\/div><\/div><div class="summary-detail">0 findings/,
  );
  assert.match(html, /Azure Guidelines/);
  assert.match(html, /0\/0 intents assessed/);
  assert.match(
    html,
    /<span class="" aria-label="Not assessed">i<\/span><\/div><div class="summary-label">Azure Guidelines<\/div><\/div><div class="summary-detail">Not assessed<br>0 findings<br>0\/0 intents assessed/,
  );
  assert.match(
    html,
    /<section id="document-quality"><div class="report-section-head"><div><h2>Documentation Completeness<\/h2>[\s\S]*?report-badge add">passed/,
  );
  assert.match(
    html,
    /<details class="notice"><summary class="container"><span class="notice-title">Preview Notice<\/span>/,
  );
  assert.doesNotMatch(html, /<details class="notice" open>/);
  assert.match(html, /min-height:46px/);
  assert.match(
    html,
    /The TypeSpec Assessment Assistant is currently in preview\. Its goal is to help service developers build confidence earlier in the TypeSpec authoring workflow/,
  );
  assert.match(
    html,
    /Official validation tools, generated artifacts, and reviewer feedback remain the source of truth for merge and release decisions\./,
  );
  const sectionOrder = [
    "semantic-intents",
    "azure-compliance",
    "rest-breaking",
    "downstream-breaking",
    "document-quality",
  ].map((id) => html.indexOf(`<section id="${id}">`));
  assert.deepEqual(
    sectionOrder,
    [...sectionOrder].sort((a, b) => a - b),
  );
  assert.match(
    html,
    /TypeSpec source diff: <code>9f0ad696cc186c2d16cb522abc0fbd4aa3854ca5<\/code> → <code>780a61ace56c22ce10dd01caa8ab95ca4514ac2e<\/code>/,
  );
  assert.match(html, /<h3 id="projects-and-compiler-status">Projects and compiler status<\/h3>/);
  assert.match(
    html,
    /<section id="appendix"><details class="dimension-details"><summary><h2>Appendix<\/h2><\/summary>/,
  );
  assert.doesNotMatch(html, /<section id="appendix"><details class="dimension-details" open>/);
  assert.match(
    html,
    /<strong>Pull request:<\/strong> <a href="https:\/\/github\.com\/Azure\/azure-rest-api-specs\/pull\/123">#123<\/a>/,
  );
  assert.doesNotMatch(html, /Assessment comparison/);
});

void test("renderer shows expandable REST operations and aggregated downstream methods", () => {
  const source = {
    id: "source-1",
    path: "specification/widgets/main.tsp",
    hunks: [{ id: "hunk-1", lines: ["-  get is Basic;", "+  get is Lro;"] }],
    declarations: [],
  };
  const html = renderAssessmentHtml({
    schemaVersion: 1,
    comparison: { baseCommit: "base", headCommit: "head" },
    artifactComparisons: [
      {
        projectId: "project-1",
        mode: "existing-api-version",
        baseline: {
          sourceRevision: "base",
          commit: "base",
          apiVersion: "v1",
          reason: "affected-version",
        },
        target: {
          sourceRevision: "current",
          commit: "head",
          apiVersion: "v1",
          reason: "affected-version",
        },
      },
    ],
    confidence: "high",
    safety: { scope: "rest-and-downstream-only", status: "failed" },
    dimensions: {
      semantic: {
        status: "assessed",
        sourceHunkIds: ["hunk-1"],
        items: [
          {
            id: "semantic-1",
            action: "modify",
            title: "Modify get",
            summary: "Change the SDK projection.",
            sources: [source],
            operations: [
              {
                operationId: "Widgets_Get",
                apiVersion: "v1",
                method: "get",
                path: "/widgets",
                changedAspects: [],
                restChanged: false,
                outcome: "HTTP signature and represented payload contract unchanged.",
              },
            ],
            relatedFindings: { downstream: ["downstream-group-1"] },
          },
        ],
      },
      rest: { status: "passed", findings: [] },
      downstream: {
        status: "failed",
        findings: [
          {
            id: "downstream-finding-1",
            rule: "method-kind-changed",
            actual: "Method kind changed.",
            expected: "Method kind remains stable.",
            severity: "high",
            rationale: "Generated callers observe a different method shape.",
            crossLanguageDefinitionId: "Contoso.Widgets.get",
            sources: [source],
            evidence: [{ id: "fact-1" }],
            relatedSemanticIntents: ["semantic-1"],
            semanticMatchBasis: "http-method-path",
          },
          {
            id: "downstream-parameters",
            rule: "method-parameters-changed",
            actual: "Method parameters changed.",
            expected: "Method parameters remain stable.",
            severity: "high",
            rationale: "Generated callers observe an added parameter.",
            crossLanguageDefinitionId: "Contoso.Widgets.get",
            sources: [source],
            evidence: [{ id: "fact-1" }],
            relatedSemanticIntents: ["semantic-1"],
            semanticMatchBasis: "http-method-path",
          },
        ],
        methodGroups: [
          {
            id: "downstream-group-1",
            symbol: "Contoso.Widgets.get",
            parametersUnchanged: false,
            deltas: [
              {
                findingId: "downstream-parameters",
                rule: "method-parameters-changed",
                field: "parameters",
                severity: "high",
                rationale: "Generated callers observe an added parameter.",
                changes: {
                  added: [
                    {
                      parameter: {
                        name: "afcManagedSync",
                        optional: true,
                        type: "boolean",
                      },
                      index: 3,
                    },
                  ],
                  removed: [],
                  modified: [],
                  reordered: [],
                  unchangedCount: 3,
                },
              },
              {
                findingId: "downstream-finding-1",
                rule: "method-kind-changed",
                field: "kind",
                severity: "high",
                rationale: "Generated callers observe a different method shape.",
                before: "basic",
                after: "lro",
              },
            ],
            relatedSemanticIntents: ["semantic-1"],
          },
        ],
      },
      compliance: notAssessedCompliance(),
      documentQuality: { status: "not-assessed", summary: "Not assessed." },
    },
    blockers: [],
    projects: [
      {
        id: "project-1",
        path: "specification/widgets",
        artifacts: {},
      },
    ],
    changedFiles: [],
    provenance: {},
  });

  assert.match(html, /Affected operations \(1\)/);
  assert.match(html, /HTTP signature and represented payload contract unchanged/);
  assert.match(html, /Contoso\.Widgets\.get/);
  assert.match(html, /<strong>Widgets\.get<\/strong>/);
  assert.match(html, /\.contract-tag\{background:#dbeafe;color:#1e40af\}/);
  assert.doesNotMatch(html, /2 SDK contract changes/);
  assert.match(html, /Contract area<\/th><th>Before<\/th><th>After/);
  assert.match(
    html,
    /<span class="contract-area-kind">Method parameter<\/span><strong>afcManagedSync<\/strong>/,
  );
  assert.match(html, /afcManagedSync\? \(location unknown\): boolean/);
  assert.match(html, /afcManagedSync/);
  assert.match(html, /location unknown/);
  assert.match(html, /not present/);
  assert.match(html, /Method kind/);
  assert.match(html, /Why this is breaking/);
  const downstream = requiredMatch(
    html,
    /<section id="downstream-breaking">([\s\S]*?)<\/section>/,
    1,
  );
  assert.doesNotMatch(downstream, /Changed TypeSpec:/);
  assert.match(downstream, /Affected intents \(1\)/);
  assert.match(
    html,
    /<span class="fail" aria-label="Failed">×<\/span><\/div><div class="summary-label">Downstream breaking changes<\/div><\/div><div class="summary-detail">2 findings/,
  );
  assert.match(html, /TypeSpec source diff: <code>base<\/code> → <code>head<\/code>/);
  assert.doesNotMatch(html, /method-parameters-changed/);
  assert.doesNotMatch(html, /&quot;name&quot;:&quot;afcManagedSync&quot;/);
  assert.match(html, /get is Lro/);
  assert.match(html, /Changed TypeSpec source/);
  assert.doesNotMatch(html, /Complete TypeSpec source evidence/);
  assert.doesNotMatch(html, /complete-typespec-evidence/);
  assert.match(html, /<details class="report-card intent" id="intent-semantic-1"><summary>/);
  assert.match(html, /class="report-link impact"[^>]*>Downstream: Widgets\.get<\/a>/);
  assert.doesNotMatch(html, /Related findings:/);
  assert.doesNotMatch(html, /<details class="report-card intent"[^>]* open/);
  assert.match(html, /<details class="report-source" open><summary>/);
  assert.doesNotMatch(html, /<details class="report-subdetails"[^>]* open/);
  const operationCards = html.match(/<details class="operation">.*?<\/details>/gs) ?? [];
  assert.equal(operationCards.length, 1);
  assert.doesNotMatch(operationCards[0], /class="diff"/);
});

void test("renderer reports operations omitted from large semantic intents", () => {
  const source = {
    id: "source-1",
    path: "specification/widgets/main.tsp",
    hunks: [{ id: "hunk-1", lines: ['+  v1: "v1",'] }],
    declarations: [],
  };
  const operations = Array.from({ length: 16 }, (_, index) => ({
    operationId: `Widgets_Operation${String(index).padStart(2, "0")}`,
    apiVersion: "v1",
    method: "get",
    path: `/widgets/${index}`,
    changedAspects: [],
    restChanged: false,
    outcome: "HTTP signature and represented payload contract unchanged.",
  }));
  const html = renderAssessmentHtml({
    schemaVersion: 1,
    comparison: { baseCommit: "base", headCommit: "head" },
    confidence: "high",
    safety: { scope: "rest-and-downstream-only", status: "passed" },
    dimensions: {
      semantic: {
        status: "assessed",
        sourceHunkIds: ["hunk-1"],
        items: [
          {
            id: "semantic-1",
            action: "modify",
            title: "Publish v1",
            summary: "Publish the new version.",
            sources: [source],
            operations,
            relatedFindings: {},
          },
        ],
      },
      rest: { status: "passed", findings: [] },
      downstream: { status: "passed", findings: [] },
      compliance: notAssessedCompliance(),
      documentQuality: { status: "not-assessed", summary: "Not assessed." },
    },
    blockers: [],
    projects: [],
    changedFiles: [],
    provenance: {},
  });

  assert.equal((html.match(/<details class="operation">/g) ?? []).length, 10);
  assert.match(html, /Other affected operations \(6\)/);
  for (const operation of operations) assert.ok(html.includes(operation.operationId));
});

void test("representative source prefers operation evidence and stable ordering", () => {
  const item = {
    sources: [
      {
        id: "source-b",
        path: "specification/widgets/z-context.tsp",
        hunks: [{ id: "hunk-context", lines: ['+import "./feature.tsp";'] }],
        declarations: [],
      },
      {
        id: "source-a",
        path: "specification/widgets/feature.tsp",
        hunks: [
          { id: "hunk-other", lines: ["+model Other {}"] },
          { id: "hunk-operation", lines: ["+op create(): void;"] },
        ],
        declarations: [
          {
            hunkIds: ["hunk-operation"],
            source: { revision: "current", startLine: 20 },
          },
        ],
      },
    ],
    operations: [
      {
        sources: [
          {
            id: "source-a",
            hunks: [{ id: "hunk-operation" }],
          },
        ],
      },
    ],
  };

  const selected = required(fixtureRepresentativeSource(item));
  assert.equal(selected.path, "specification/widgets/feature.tsp");
  assert.deepEqual(
    selected.hunks.map((hunk) => hunk.id),
    ["hunk-operation"],
  );
});

void test("representative source uses hunk position before hunk ID", () => {
  const selected = required(
    fixtureRepresentativeSource({
      sources: [
        {
          id: "source-1",
          path: "specification/widgets/main.tsp",
          hunks: [
            {
              id: "hunk-a",
              current: { startLine: 100 },
              lines: ["+model Later {}"],
            },
            {
              id: "hunk-z",
              current: { startLine: 10 },
              lines: ["+model Earlier {}"],
            },
          ],
          declarations: [],
        },
      ],
      operations: [],
    }),
  );

  assert.equal(selected.hunks[0].id, "hunk-z");
});

void test("renderer shows complete changed intent source once and expanded", () => {
  const sources = [
    {
      id: "source-1",
      path: "specification/widgets/main.tsp",
      hunks: [
        { id: "hunk-1", lines: ["+model Widget {}"] },
        { id: "hunk-2", lines: ["+op create(): Widget;"] },
      ],
      declarations: [],
    },
  ];
  const html = renderAssessmentHtml({
    schemaVersion: 1,
    comparison: { baseCommit: "base", headCommit: "head" },
    confidence: "high",
    safety: { scope: "rest-and-downstream-only", status: "passed" },
    dimensions: {
      semantic: {
        status: "assessed",
        sourceHunkIds: ["hunk-1", "hunk-2"],
        items: [
          {
            id: "semantic-1",
            action: "add",
            title: "Add widgets",
            summary: "Adds the widget API.",
            sources,
            operations: [],
            relatedFindings: {},
            deterministicCoverage: {
              coveredHunkIds: ["hunk-1"],
              uncoveredHunkIds: ["hunk-2"],
              classifications: [
                { hunkId: "hunk-1", status: "no-impact" },
                { hunkId: "hunk-2", status: "unknown" },
              ],
            },
            inferenceRequired: true,
            inferenceResults: [
              {
                requestId: "inference-request-1",
                hunkId: "hunk-2",
                decision: "no-impact",
                rationale: "No contract impact.",
                candidateIds: [],
              },
            ],
          },
        ],
      },
      rest: { status: "passed", findings: [] },
      downstream: { status: "passed", findings: [] },
      compliance: notAssessedCompliance(),
      documentQuality: { status: "not-assessed", summary: "Not assessed." },
    },
    blockers: [],
    projects: [],
    changedFiles: [],
    provenance: {},
  });

  assert.equal((html.match(/<details class="report-source" open>/g) ?? []).length, 1);
  assert.doesNotMatch(html, /Deterministic coverage:/);
  assert.equal((html.match(/class="diff"/g) ?? []).length, 2);
  assert.doesNotMatch(html, /complete-typespec-evidence/);
});

void recordedAssessmentTest(
  "refreshed baseline preserves semantic and REST-derived downstream links",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/44742/assessment.json", import.meta.url),
    );
    const html = renderAssessmentHtml(assessment);
    const complianceFinding = required(assessment.dimensions.compliance.findings[0]);
    const complianceIntent = assessment.dimensions.semantic.items.find(
      (item) => item.id === complianceFinding.semanticIntentId,
    );
    const restFinding = required(assessment.dimensions.rest.findings[0]);
    const restIntentId = required(restFinding.relatedSemanticIntents)[0];
    const restIntent = assessment.dimensions.semantic.items.find(
      (item) => item.id === restIntentId,
    );
    assert.ok(html.includes(`href="#compliance-finding-${complianceFinding.id}"`));
    const selectedComplianceIntent = required(complianceIntent);
    const selectedRestIntent = required(restIntent);
    assert.ok(html.includes(`href="#intent-${selectedComplianceIntent.id}"`));

    assert.match(html, /4 intents ·/);
    assert.match(
      html,
      /<strong>Pull request:<\/strong> <a href="https:\/\/github\.com\/Azure\/azure-rest-api-specs\/pull\/44742">#44742<\/a>/,
    );
    for (const intent of assessment.dimensions.semantic.items) {
      assert.ok(html.includes(`id="intent-${intent.id}"`));
      assert.ok(html.includes(intent.title));
    }
    const restHtml = reportSection(html, "rest-breaking");
    assert.match(restHtml, /class="report-card rest-contract-card"/);
    assert.match(restHtml, /class="report-http"/);
    assert.match(restHtml, /Contract area<\/th><th>Before<\/th><th>After/);
    assert.match(restHtml, /class="breaking-rationale"/);
    assert.match(restHtml, /id="rest-operation-[^"]+"/);
    assert.doesNotMatch(restHtml, /<details class="affected-operations" open>/);
    assert.ok(
      restHtml.includes(`href="#intent-${selectedRestIntent.id}">${selectedRestIntent.title}</a>`),
    );
    assert.doesNotMatch(restHtml, /Changed TypeSpec:/);
    assert.doesNotMatch(html, /REST contract changes require generated-client updates/);
    assert.match(html, /<h2>Downstream breaking changes<\/h2>/);
    assert.doesNotMatch(html, /from REST breaking/);
    const downstreamHtml = reportSection(html, "downstream-breaking");
    assert.doesNotMatch(
      downstreamHtml,
      /<span class="origin-tag rest-breaking-tag">REST breaking<\/span>/,
    );
    assert.doesNotMatch(html, /REST-compatible downstream changes/);
    assert.doesNotMatch(
      html,
      /<summary><strong><span class="action"><\/span>\s*<\/strong><\/summary>/,
    );
    assert.ok(
      assessment.dimensions.rest.findings.some((finding) => finding.severity) ||
        assessment.dimensions.downstream.findings.some((finding) => finding.severity) ||
        assessment.dimensions.compliance.findings.some((finding) => finding.severity),
    );
    assert.doesNotMatch(html, /<span class="severity/);
    assert.doesNotMatch(html, /class="finding [^"]*\b(?:high|medium|low)\b/);
    assert.match(html, /\.finding\{border-left:1px solid var\(--line\)\}/);
  },
);

void recordedAssessmentTest(
  "counts repeated Azure guideline findings as raw findings in header cards despite one visible issue",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/44742/assessment.json", import.meta.url),
    );
    const findings = assessment.dimensions.compliance.findings;
    const html = renderAssessmentHtml(assessment);
    const complianceHtml = reportSection(html, "azure-compliance");

    assert.equal(complianceFindingGroups(findings).length, 1);
    assert.equal(findings.length, 4);
    assert.match(
      html,
      /<span class="fail" aria-label="Failed">×<\/span><\/div><div class="summary-label">Azure Guidelines<\/div><\/div><div class="summary-detail">4 findings<br>4\/4 intents assessed/,
    );
    assert.equal(
      summaryCardValue(html, "Azure Guidelines"),
      findings.length + (assessment.dimensions.compliance.legacyFindings?.length ?? 0),
    );
    assert.doesNotMatch(html, /Overall code quality/);
    assert.match(complianceHtml, /<h2>Azure Guidelines<\/h2>/);
    assert.equal((complianceHtml.match(/class="report-card compliance-finding /g) ?? []).length, 1);
    assert.match(complianceHtml, /class="report-relation-label">Affected intents \(4\)<\/span>/);
    assert.equal((complianceHtml.match(/id="compliance-finding-/g) ?? []).length, 4);
    assert.equal((complianceHtml.match(/<h3>Expected<\/h3>/g) ?? []).length, 1);
    assert.equal(
      (complianceHtml.match(/Use `@removed` with the version where an existing model/g) ?? [])
        .length,
      1,
    );
    for (const finding of findings) {
      const intent = required(
        assessment.dimensions.semantic.items.find((item) => item.id === finding.semanticIntentId),
      );
      assert.ok(complianceHtml.includes(`id="compliance-finding-${finding.id}"`));
      assert.ok(complianceHtml.includes(`href="#intent-${intent.id}">${intent.title}</a>`));
      assert.ok(complianceHtml.includes(finding.actual));
    }
  },
);

void recordedAssessmentTest(
  "keeps REST location labels out of SDK type rows without TCGC paths",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/44742/assessment.json", import.meta.url),
    );
    const intent = assessment.dimensions.semantic.items.find(
      (item) => item.id === "semantic-259f67bc56ae9c3d",
    );
    const selectedIntent = required(intent);
    const operation = selectedIntent.operations.find(
      (item) => item.operationId === "Directory_ListFilesAndDirectoriesSegment",
    );
    const rows = operationContractRows(
      required(operation),
      assessment.dimensions.rest.findings,
      selectedIntent.id,
    );

    assert.ok(rows.some((row) => row.area === "response 200.segment.fileItems[].fileType"));
    assert.doesNotMatch(rows.map((row) => row.area).join(","), /(?:^|,)responses(?:,|$)/);

    const html = renderAssessmentHtml(assessment);
    const semanticHtml = reportSection(html, "semantic-intents");
    assert.match(
      semanticHtml,
      /<table class="report-table"><thead><tr><th>Contract area<\/th><th>Before<\/th><th>After<\/th>/,
    );
    assert.match(
      semanticHtml,
      /Response body property<\/span><strong>200 · segment\.fileItems\[\]\.fileType/,
    );
    assert.match(semanticHtml, /<td><pre>/);
    assert.match(semanticHtml, /<\/pre><\/td><td><pre>/);
    assert.match(
      html,
      /<span class="contract-area-kind">SDK type member<\/span><strong>socketItems<\/strong><\/td><td><pre>SocketItem\[\]\?<\/pre>/,
    );
    assert.doesNotMatch(
      html,
      /<td class="contract-member">[\s\S]*?<code>model-property-removed<\/code>/,
    );
  },
);

void recordedAssessmentTest("labels SDK method parameters with normalized TCGC locations", () => {
  const assessment = readAssessment(
    new URL("../evals/assessments/44988/assessment.json", import.meta.url),
  );
  const html = renderAssessmentHtml(assessment);

  assert.match(html, /afcManagedSync\? \(query\): boolean/);
  assert.match(
    html,
    /<span class="contract-area-kind">Query parameter<\/span><strong>afcManagedSync<\/strong>/,
  );
});

void recordedAssessmentTest("labels response header contract rows consistently", () => {
  const assessment = readAssessment(
    new URL("../evals/assessments/43308/assessment.json", import.meta.url),
  );
  const html = renderAssessmentHtml(assessment);

  assert.match(
    html,
    /<span class="contract-area-kind">Response header<\/span><strong>202 · Location<\/strong>/,
  );
});

void recordedAssessmentTest(
  "omits compatible response-wrapper and response-only required properties",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/45162/assessment.json", import.meta.url),
    );
    const html = renderAssessmentHtml(assessment);

    assert.doesNotMatch(html, /<code>transactionId<\/code>/);
    assert.doesNotMatch(
      html,
      /<span class="contract-area-kind">Response body property<\/span><code>state<\/code>/,
    );
    assert.match(
      html,
      /<span class="pass" aria-label="Passed">✓<\/span><\/div><div class="summary-label">Downstream breaking changes<\/div><\/div><div class="summary-detail">0 findings/,
    );
  },
);

void test("derives narrow structural rows without confirmed REST findings", () => {
  const rows = fixtureOperationContractRows({
    operationId: "Widgets_Get",
    changedAspects: ["responses"],
    before: { responses: [{ status: "200" }] },
    after: { responses: [{ status: "200" }, { status: "404" }] },
  });

  assert.deepEqual(rows, [
    {
      area: "response 404",
      before: "not present",
      after: "present",
    },
  ]);
});

void test("keeps whole-operation additions as one contract row", () => {
  const rows = fixtureOperationContractRows({
    operationId: "Widgets_Create",
    changedAspects: ["method", "path", "parameters", "request", "responses", "lro"],
    before: {},
    after: {
      method: "put",
      path: "/widgets/{widgetName}",
      parameters: [
        {
          in: "path",
          name: "widgetName",
          required: true,
          schema: { kind: "scalar", type: "string" },
        },
      ],
      request: { kind: "body", schema: { kind: "object" } },
      responses: [{ status: "200" }],
      lro: { enabled: true },
    },
  });

  assert.deepEqual(rows, [
    {
      area: "operation",
      before: "not present",
      after: "PUT /widgets/{widgetName}",
    },
  ]);
});

void recordedAssessmentTest(
  "shows nested response header changes without identical response summaries",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/43308/assessment.json", import.meta.url),
    );
    const intent = assessment.dimensions.semantic.items.find((item) =>
      item.operations?.some((operation) => operation.operationId === "ScenarioRuns_Get"),
    );
    const selectedIntent = required(intent);
    const operation = selectedIntent.operations.find(
      (item) => item.operationId === "ScenarioRuns_Get",
    );
    const rows = operationContractRows(
      required(operation),
      assessment.dimensions.rest.findings,
      selectedIntent.id,
    );

    assert.deepEqual(rows, [
      {
        area: "response 202.header:Location",
        before: "string",
        after: "string uri",
      },
    ]);
    assert.ok(
      !rows.some(
        (row) =>
          row.area === "responses" &&
          row.before === "200, 202, default" &&
          row.after === "200, 202, default",
      ),
    );
  },
);

void recordedAssessmentTest("renders version-reference-only operation changes as unchanged", () => {
  const assessment = readAssessment(
    new URL("../evals/assessments/42853/assessment.json", import.meta.url),
  );
  const intent = assessment.dimensions.semantic.items.find((item) =>
    item.operations?.some((operation) => operation.operationId === "DeletedVaults_Get"),
  );
  const selectedIntent = required(intent);
  const operation = selectedIntent.operations.find(
    (item) => item.operationId === "DeletedVaults_Get",
  );

  assert.deepEqual(
    operationContractRows(
      required(operation),
      assessment.dimensions.rest.findings,
      selectedIntent.id,
    ),
    [],
  );

  const html = renderAssessmentHtml(assessment);
  const markerIndex = html.indexOf("<strong>DeletedVaults_Get</strong>");
  const cardStart = html.lastIndexOf('<details class="operation">', markerIndex);
  const cardEnd = html.indexOf("</details>", markerIndex);
  const card = html.slice(cardStart, cardEnd);
  const unchanged = "HTTP signature and represented payload contract unchanged.";

  assert.equal((card.match(new RegExp(unchanged, "g")) ?? []).length, 1);
  assert.doesNotMatch(card, /contract-change-table/);
  assert.doesNotMatch(card, /REST contract changed: responses/);
});

void test("does not group Azure guideline findings by title alone", () => {
  const base = {
    id: "compliance-1",
    title: "Repeated title",
    expected: "Use the documented pattern.",
    applicableGuidance: [
      {
        canonicalDocumentUrl: "https://example.com/guidance",
        guidanceSection: "Pattern",
      },
    ],
  };
  const groups = fixtureComplianceFindingGroups([
    base,
    {
      ...base,
      id: "compliance-2",
      applicableGuidance: [
        {
          canonicalDocumentUrl: "https://example.com/guidance",
          guidanceSection: "Different pattern",
        },
      ],
    },
    {
      ...base,
      id: "compliance-3",
      expected: "Use a different documented pattern.",
    },
  ]);

  assert.deepEqual(
    groups.map((group) => group.findings.map((finding) => finding.id)),
    [["compliance-1"], ["compliance-2"], ["compliance-3"]],
  );
});

void recordedAssessmentTest(
  "renderer links assessed intents with no applicable guidance by title",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/42853/assessment.json", import.meta.url),
    );
    const noGuidance = assessment.dimensions.compliance.intentAssessments.filter(
      (item) => item.decision === "no-applicable-guidance",
    );
    assert.equal(noGuidance.length, 1);
    const intent = required(
      assessment.dimensions.semantic.items.find(
        (item) => item.id === required(noGuidance[0]).semanticIntentId,
      ),
    );
    const html = renderAssessmentHtml(assessment);
    const complianceHtml = reportSection(html, "azure-compliance");
    assert.ok(
      complianceHtml.includes(
        `No applicable guideline was found for: <a class="report-link" href="#intent-${intent.id}">${intent.title}</a>.`,
      ),
    );
    assert.doesNotMatch(complianceHtml, /Unassessed intents/);
    assert.doesNotMatch(complianceHtml, /<code>semantic-[^<]+<\/code>/);

    const another = required(
      assessment.dimensions.compliance.intentAssessments.find(
        (item) => item.decision === "applicable-pass",
      ),
    );
    another.decision = "no-applicable-guidance";
    another.applicableGuidance = [];
    delete another.expected;
    const anotherIntent = required(
      assessment.dimensions.semantic.items.find((item) => item.id === another.semanticIntentId),
    );
    const multipleHtml = renderAssessmentHtml(assessment);
    const multipleComplianceHtml = reportSection(multipleHtml, "azure-compliance");
    assert.match(multipleComplianceHtml, /No applicable guideline was found for: /);
    assert.ok(
      multipleComplianceHtml.includes(
        `<a class="report-link" href="#intent-${intent.id}">${intent.title}</a>`,
      ),
    );
    assert.ok(
      multipleComplianceHtml.includes(
        `<a class="report-link" href="#intent-${anotherIntent.id}">${anotherIntent.title}</a>`,
      ),
    );
  },
);

void recordedAssessmentTest("downstream section excludes REST breaking changes", () => {
  const assessment = readAssessment(
    new URL("../evals/assessments/44742/assessment.json", import.meta.url),
  );
  const html = renderAssessmentHtml(assessment);
  assert.match(
    html,
    /<strong>Directory_ListFilesAndDirectoriesSegment<\/strong><small><span class="report-http">GET<\/span> <code>\?restype=directory&amp;comp=list<\/code> · 2026-12-06/,
  );
  assert.match(html, /operations · \d+ findings/);
  assert.doesNotMatch(html, /contract\(s\)|Compared REST operation:/);
  const downstream = reportSection(html, "downstream-breaking");

  assert.match(downstream, /<h2>Downstream breaking changes<\/h2>/);
  assert.equal(
    (downstream.match(/class="origin-tag rest-breaking-tag">REST breaking<\/span>/g) ?? []).length,
    0,
  );
  assert.equal((downstream.match(/href="#rest-contract-/g) ?? []).length, 0);
  assert.doesNotMatch(downstream, /Approved REST finding/);
  assert.doesNotMatch(downstream, /REST-compatible downstream changes/);
});

void recordedAssessmentTest("renderer keeps API versions in the appendix", () => {
  const assessment = readAssessment(
    new URL("../evals/assessments/42853/assessment.json", import.meta.url),
  );
  const html = renderAssessmentHtml(assessment);

  assert.match(
    html,
    /TypeSpec source diff: <code>519e87e016492a37ce9ea6ac0fdf80d26767f47d<\/code> → <code>efe76fb07ac03d9c54e2c64de15ef3ff90fc4030<\/code>/,
  );
  assert.match(html, /<code>efe76fb07ac03d9c54e2c64de15ef3ff90fc4030@2026-01-01<\/code>/);
  assert.match(html, /<code>efe76fb07ac03d9c54e2c64de15ef3ff90fc4030@2026-02-01<\/code>/);
  assert.match(html, /new-api-version/);
  assert.match(html, /previous-latest-stable/);
  assert.match(html, /newest-added-version/);
});

void recordedAssessmentTest(
  "renderer presents assessment blockers as potential limits in the appendix",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/42853/assessment.json", import.meta.url),
    );
    assessment.blockers = ["Before/after evidence is incomplete for <one> candidate."];
    const html = renderAssessmentHtml(assessment);

    assert.doesNotMatch(html, /<section id="blockers">/);
    assert.doesNotMatch(html, /<h2>Blockers<\/h2>/);
    assert.match(
      html,
      /<section id="appendix"><details class="dimension-details"><summary><h2>Appendix<\/h2><\/summary><div class="panel">[\s\S]*<h3 id="potential-limits">Potential limits<\/h3>/,
    );
    assert.match(html, /Before\/after evidence is incomplete for &lt;one&gt; candidate\./);
  },
);

void recordedAssessmentTest(
  "renderer derives overall code quality from assessed dimensions",
  () => {
    const highAssessment = readAssessment(
      new URL("../evals/assessments/45348/assessment.json", import.meta.url),
    );
    const mediumAssessment = readAssessment(
      new URL("../evals/assessments/45536/assessment.json", import.meta.url),
    );
    const compliance = mediumAssessment.dimensions.compliance;
    compliance.status = "not-assessed";
    compliance.summary = "Azure Guidelines evidence is incomplete.";
    compliance.coverage.assessedIntentCount = 0;
    compliance.coverage.unassessedIntentIds = compliance.intentAssessments.map(
      (item) => item.semanticIntentId,
    );
    compliance.blockers = compliance.intentAssessments.map((item) => ({
      reviewUnitId: item.semanticIntentId,
      message: "test evidence blocker",
    }));
    for (const item of compliance.intentAssessments) {
      item.decision = "not-assessed";
      item.applicableGuidance = [];
      item.blockers = ["test evidence blocker"];
    }

    for (const assessment of [highAssessment, mediumAssessment]) {
      const html = renderAssessmentHtml(assessment);
      assert.doesNotMatch(html, /Overall code quality/);
      assert.equal(summaryCardValue(html, "Azure Guidelines"), 0);
    }
  },
);

/**
 * @param {TestDocumentDecision | Record<"correctness" | "meaning", TestDocumentDecision>} [decision]
 * @param {boolean} [noDocs]
 * @param {number} [version]
 * @returns {DocumentedAssessment}
 */
function documentedAssessment(decision = "pass", noDocs = false, version = 1) {
  /**
   * @type {{
   *   id: string,
   *   path: string,
   *   hunks: {id: string, lines: string[]}[],
   *   declarations: {id: string, qualifiedName: string, kind: string, hunkIds: string[]}[],
   *   documentEvidence?: Record<string, unknown>
   * }}
   */
  const source = {
    id: "source-widget",
    path: "models.tsp",
    hunks: [{ id: "hunk-widget", lines: ['-@doc("The count.")', '+@doc("A positive count.")'] }],
    declarations: [
      {
        id: "declaration-widget",
        qualifiedName: "Widget.count",
        kind: "property",
        hunkIds: ["hunk-widget"],
      },
    ],
  };
  const intent = {
    id: "semantic-widget",
    action: "modify",
    title: "Constrain widget counts",
    summary: "Require a positive count.",
    declarationIds: ["declaration-widget"],
    sources: [source],
    operations: [],
    relatedFindings: {},
  };
  const document = {
    id: "document-widget",
    sourceChangeId: source.id,
    qualifiedName: "Widget.count",
    kind: "property",
    before: {
      doc: "The count.",
      declaration: '@doc("The count.")\ncount: int32;',
      source: { path: source.path, revision: "base", startLine: 1, endLine: 2 },
    },
    after: {
      doc: "A positive count.",
      declaration: '@doc("A positive count.")\n@minValue(1)\ncount: int32;',
      source: { path: source.path, revision: "current", startLine: 1, endLine: 3 },
    },
  };
  source.documentEvidence = {
    schemaVersion: version,
    status: "ready",
    documents: noDocs ? [] : [{ ...document, hunkIds: ["hunk-widget"] }],
    blockers: [],
  };
  const unit = {
    reviewUnitId: intent.id,
    status: noDocs ? "not-applicable" : "ready",
    ...(noDocs ? { reason: "No current @doc in the changed declaration scope." } : {}),
    sourceChangeIds: [source.id],
    hunkIds: ["hunk-widget"],
    declarationIds: ["declaration-widget"],
    documents: noDocs ? [] : [document],
  };
  const input = buildDocumentQualityInput(
    /** @type {Parameters<typeof buildDocumentQualityInput>[0]} */ (
      /** @type {unknown} */ ({
        schemaVersion: version,
        sourceIndex: { sourceChanges: [source] },
        semantic: {
          reviewUnits: [
            {
              id: intent.id,
              sourceChangeIds: unit.sourceChangeIds,
              hunkIds: unit.hunkIds,
              declarationIds: unit.declarationIds,
            },
          ],
        },
      })
    ),
  );
  const checks = /** @type {("description" | "correctness" | "meaning")[]} */ (
    version >= 2 ? ["description"] : ["correctness", "meaning"]
  );
  const decisions = noDocs
    ? []
    : checks.map((check) => {
        const checkDecision =
          typeof decision === "string"
            ? decision
            : /** @type {Partial<Record<typeof check, TestDocumentDecision>>} */ (decision)[check];
        return {
          reviewUnitId: intent.id,
          documentId: document.id,
          check,
          decision: checkDecision,
          rationale:
            checkDecision === "not-assessed"
              ? "Contract evidence incomplete."
              : "Recorded documentation judgment.",
          ...(checkDecision === "fail"
            ? {
                title: `${check} issue in count documentation`,
                expected: "State the exact allowed count.",
                docQuote: "positive count",
              }
            : {}),
        };
      });
  const documentQuality = assembleDocumentQuality(
    /** @type {Parameters<typeof assembleDocumentQuality>[0]} */ (
      /** @type {unknown} */ ({
        input,
        modelInput: {
          ...(version >= 2
            ? {
                documentQualityAssessmentVersion: version,
                documentQualityCriterion:
                  "Does the TypeSpec compiler return a nonempty effective document?",
              }
            : {}),
          artifactReferences: { documentQuality: DOCUMENT_QUALITY_ARTIFACT },
          documentQualityReviewUnits: [
            {
              reviewUnitId: intent.id,
              status: unit.status,
              documentIds: unit.documents.map((item) => item.id),
              evidenceSetId: "evidence-document-widget",
              ...(input.reviewUnits[0].reason ? { reason: input.reviewUnits[0].reason } : {}),
            },
          ],
          evidenceSets: {
            "evidence-document-widget": {
              sourceChangeIds: unit.sourceChangeIds,
              hunkIds: unit.hunkIds,
              declarationCount: unit.declarationIds.length,
              evidenceFactIds: [],
              evidenceRef: { artifact: DOCUMENT_QUALITY_ARTIFACT, id: intent.id },
            },
          },
        },
        decisions,
        semanticUnits: [intent],
        sourceChanges: [source],
      })
    ),
  );
  return /** @type {DocumentedAssessment} */ (
    /** @type {unknown} */ ({
      schemaVersion: 1,
      comparison: { baseCommit: "baseline", headCommit: "target" },
      confidence: "high",
      safety: { scope: "rest-and-downstream-only", status: "passed" },
      dimensions: {
        semantic: { status: "assessed", sourceHunkIds: ["hunk-widget"], items: [intent] },
        rest: { status: "passed", findings: [] },
        downstream: { status: "passed", findings: [] },
        compliance: notAssessedCompliance(),
        documentQuality,
      },
      blockers: [],
      projects: [],
      changedFiles: [],
      provenance: {},
    })
  );
}

void test("five dimension cards retain the requested order without an overall quality card", () => {
  const html = renderAssessmentHtml(documentedAssessment("not-assessed"));
  const header = html.slice(html.indexOf('<div class="summary-grid">'), html.indexOf("</header>"));
  const links = [...header.matchAll(/<a class="summary-card" href="#([^"]+)"/g)].map(
    (match) => match[1],
  );
  assert.deepEqual(links, [
    "semantic-intents",
    "azure-compliance",
    "rest-breaking",
    "downstream-breaking",
    "document-quality",
  ]);
  assert.doesNotMatch(header, /Overall code quality|<div class="summary-card">/);
  assert.equal((header.match(/class="summary-card"/g) ?? []).length, 5);
  assert.match(
    html,
    /@media\(min-width:1051px\)\{\.summary-grid\{grid-template-columns:repeat\(5,minmax\(0,1fr\)\)\}\}/,
  );
});

void recordedAssessmentTest(
  "content puts findings first and follows header order within both groups",
  () => {
    const cases = [
      {
        assessment: documentedAssessment("pass"),
        expected: [
          "semantic-intents",
          "azure-compliance",
          "rest-breaking",
          "downstream-breaking",
          "document-quality",
          "appendix",
        ],
      },
      {
        assessment: documentedAssessment("fail"),
        expected: [
          "document-quality",
          "semantic-intents",
          "azure-compliance",
          "rest-breaking",
          "downstream-breaking",
          "appendix",
        ],
      },
      {
        assessment: readAssessment(
          new URL("../evals/assessments/44988/assessment.json", import.meta.url),
        ),
        expected: [
          "downstream-breaking",
          "document-quality",
          "semantic-intents",
          "azure-compliance",
          "rest-breaking",
          "appendix",
        ],
      },
    ];
    for (const { assessment, expected } of cases) {
      const original = structuredClone(assessment);
      const html = renderAssessmentHtml(assessment);
      assert.deepEqual(
        [...html.matchAll(/<section id="([^"]+)">/g)].map((match) => match[1]),
        expected,
      );
      const ids = [...html.matchAll(/\bid="([^"]+)"/g)].map((match) => match[1]);
      for (const [, id] of html.matchAll(/href="#([^"]+)"/g))
        assert.ok(ids.includes(id), `Missing fragment ${id}`);
      assert.deepEqual(assessment, original);
    }
  },
);

void test("hero headings contain only an icon and title with counts in the detail below", () => {
  for (const [decision, noDocs] of /** @type {[TestDocumentDecision, boolean][]} */ ([
    ["pass", false],
    ["fail", false],
    ["not-assessed", false],
    ["pass", true],
  ])) {
    const html = renderAssessmentHtml(documentedAssessment(decision, noDocs));
    const header = html.slice(
      html.indexOf('<div class="summary-grid">'),
      html.indexOf("</header>"),
    );
    const headings = [
      ...header.matchAll(
        /<div class="summary-heading"><div class="summary-value"><span[^>]*>([^<]+)<\/span><\/div><div class="summary-label">([^<]+)<\/div><\/div><div class="summary-detail">/g,
      ),
    ];
    assert.equal(headings.length, 5);
    assert.ok(headings.every(([, icon]) => ["✓", "×", "i", "ⓘ"].includes(icon)));
    assert.deepEqual(
      headings.map(([, , label]) => summaryCardValue(html, label)),
      [1, 0, 0, 0, decision === "fail" ? 2 : 0],
    );
    assert.match(header, /0 findings/);
    assert.match(header, /class="info" aria-label="Information only">ⓘ<\/span>/);
    const docCard = requiredMatch(
      header,
      /<a class="summary-card" href="#document-quality">[\s\S]*?<\/a>/,
    );
    if (noDocs) assert.match(docCard, /0 findings<br>0 descriptions assessed/);
    if (decision === "not-assessed") assert.match(docCard, /0 findings<br>0 descriptions assessed/);
    assert.doesNotMatch(docCard, /Not reviewed|Partially reviewed/);
    assert.match(html, /\.summary-value\{white-space:nowrap\}/);
  }
});

void test("Semantic intents is informational and stays in the no-findings group regardless of document findings", () => {
  for (const decision of /** @type {const} */ (["pass", "fail"])) {
    const assessment = documentedAssessment(decision);
    const original = structuredClone(assessment);
    const html = renderAssessmentHtml(assessment);
    const card = requiredMatch(
      html,
      /<a class="summary-card" href="#semantic-intents">[\s\S]*?<\/a>/,
    );
    assert.match(
      card,
      /<div class="summary-value"><span class="info" aria-label="Information only">ⓘ<\/span><\/div>/,
    );
    assert.equal(summaryCardValue(html, "Semantic intents"), 1);
    assert.match(card, /0 operations<br>0 Added, 1 Modified, 0 Removed/);
    assert.doesNotMatch(card, /Pass|Fail|N\/A|Not assessed|class="(?:pass|fail)"/);
    const section = reportSection(html, "semantic-intents");
    assert.doesNotMatch(section, /class="report-badge [^"]*">(?:passed|failed|not assessed)</);
    const order = [...html.matchAll(/<section id="([^"]+)">/g)].map((match) => match[1]);
    assert.deepEqual(
      order,
      decision === "fail"
        ? [
            "document-quality",
            "semantic-intents",
            "azure-compliance",
            "rest-breaking",
            "downstream-breaking",
            "appendix",
          ]
        : [
            "semantic-intents",
            "azure-compliance",
            "rest-breaking",
            "downstream-breaking",
            "document-quality",
            "appendix",
          ],
    );
    assert.deepEqual(assessment, original);
  }
});

void test("document hero stays compact while detailed coverage remains in the summary API", () => {
  for (const [
    decision,
    noDocs,
    count,
    compact,
    coverage,
  ] of /** @type {[TestDocumentDecision, boolean, string, string, string][]} */ ([
    ["pass", false, "0", "0 findings<br>1 description assessed", "2/2 checks assessed"],
    ["fail", false, "2", "2 findings<br>1 description assessed", "2/2 checks assessed"],
    ["not-assessed", false, "0", "0 findings<br>0 descriptions assessed", "0/2 checks assessed"],
    ["pass", true, "0", "0 findings<br>0 descriptions assessed", "0/0 checks assessed"],
  ])) {
    const assessment = documentedAssessment(decision, noDocs);
    const before = structuredClone(assessment);
    const html = renderAssessmentHtml(assessment);
    const hero = required(
      [...html.matchAll(/<a class="summary-card" href="#document-quality">[\s\S]*?<\/a>/g)].find(
        ([card]) => card.includes('<div class="summary-label">Documentation Completeness</div>'),
      ),
    )[0];
    assert.equal(summaryCardValue(html, "Documentation Completeness"), Number(count));
    assert.ok(hero.includes(compact));
    assert.doesNotMatch(hero, /checks assessed|intent scopes|retained descriptions/);
    assert.match(
      documentQualitySummary(assessment.dimensions.documentQuality).detail,
      new RegExp(String(coverage).replace("/", "\\/")),
    );
    assert.doesNotMatch(
      reportSection(html, "appendix"),
      new RegExp(String(coverage).replace("/", "\\/")),
    );
    assertNoDocumentAppendixUi(html);
    assert.doesNotMatch(html, /Overall code quality/);
    assert.deepEqual(assessment, before);
    assert.equal(assessment.safety.status, "passed");
    const ids = [...html.matchAll(/\bid="([^"]+)"/g)].map((match) => match[1]);
    assert.equal(ids.length, new Set(ids).size);
    for (const [, id] of html.matchAll(/href="#([^"]+)"/g))
      assert.ok(ids.includes(id), `Missing fragment ${id}`);
  }
});

void recordedAssessmentTest(
  "partial document review omits appendix coverage strings but preserves raw summary data",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/43308/assessment.json", import.meta.url),
    );
    const original = structuredClone(assessment);
    const html = renderAssessmentHtml(assessment);
    const hero = requiredMatch(
      html,
      /<a class="summary-card" href="#document-quality">[\s\S]*?<\/a>/,
    );
    assert.match(hero, /<div class="summary-detail">0 findings<br>9 descriptions assessed<\/div>/);
    assert.match(hero, /class="pass" aria-label="Passed">✓<\/span>/);
    assert.doesNotMatch(hero, /9\/9|intent|retained|applicable|not reviewed|Partially/);
    assert.match(
      documentQualitySummary(assessment.dimensions.documentQuality).detail,
      /9\/9 descriptions assessed/,
    );
    assert.match(
      documentQualitySummary(assessment.dimensions.documentQuality).detail,
      /11 retained descriptions not reviewed/,
    );
    assert.match(
      documentQualitySummary(assessment.dimensions.documentQuality).detail,
      /1 intents with no applicable description/,
    );
    assert.doesNotMatch(
      reportSection(html, "appendix"),
      /9\/9 descriptions assessed|11 retained descriptions not reviewed|1 intents with no applicable description/,
    );
    assertNoDocumentAppendixUi(html);
    assert.deepEqual(assessment, original);
  },
);

void recordedAssessmentTest(
  "failed document hero shows findings and checked-declaration count",
  () => {
    const assessment = readAssessment(
      new URL("../evals/assessments/44988/assessment.json", import.meta.url),
    );
    const html = renderAssessmentHtml(assessment);
    const hero = requiredMatch(
      html,
      /<a class="summary-card" href="#document-quality">[\s\S]*?<\/a>/,
    );
    assert.match(
      hero,
      /<div class="summary-detail">20 findings<br>881 declarations checked<\/div>/,
    );
    assert.doesNotMatch(hero, /861\/881|intent|inherited|retained|not reviewed/);
  },
);

void test("legacy document hero uses findings status without inventing an assessed count", () => {
  const assessment = documentedAssessment();
  assessment.dimensions.documentQuality =
    /** @type {DocumentedAssessment["dimensions"]["documentQuality"]} */ (
      /** @type {unknown} */ ({
        status: "not-assessed",
        summary: 'Old artifacts lack <documentation> evidence & "checks".',
      })
    );
  const html = renderAssessmentHtml(assessment);
  const hero = required(
    [...html.matchAll(/<a class="summary-card" href="#document-quality">[\s\S]*?<\/a>/g)].find(
      ([card]) => card.includes('<div class="summary-label">Documentation Completeness</div>'),
    ),
  )[0];
  assert.match(hero, /0 findings<br>Assessment count unavailable/);
  assert.match(hero, /class="pass" aria-label="Passed">✓<\/span>/);
  assert.doesNotMatch(hero, /&lt;documentation&gt;/);
  assert.equal(
    documentQualitySummary(assessment.dimensions.documentQuality).detail,
    'Old artifacts lack <documentation> evidence & "checks".',
  );
  assert.doesNotMatch(
    reportSection(html, "appendix"),
    /&lt;documentation&gt; evidence &amp; &quot;checks&quot;/,
  );
  assert.doesNotMatch(hero, /checks assessed|0 descriptions assessed|Not reviewed/);
  assertNoDocumentAppendixUi(html);
});

for (const version of [2, 3])
  void test(`v${version} renders one description assessment and an honest no-document outcome`, () => {
    for (const [
      decision,
      noDocs,
      count,
    ] of /** @type {[TestDocumentDecision, boolean, string][]} */ ([
      ["pass", false, "0"],
      ["fail", false, "1"],
      ["not-assessed", false, "0"],
      ["pass", true, "0"],
    ])) {
      const assessment = documentedAssessment(decision, noDocs, version);
      const html = renderAssessmentHtml(assessment);
      const quality = reportSection(html, "document-quality");
      assert.equal(summaryCardValue(html, "Documentation Completeness"), Number(count));
      assert.match(quality, /Does the TypeSpec compiler return a nonempty effective document\?/);
      assert.doesNotMatch(
        quality.replaceAll("Documentation Completeness", ""),
        /Correctness|Meaning|Legacy assessment|checks assessed/,
      );
      assert.match(
        documentQualitySummary(assessment.dimensions.documentQuality).detail,
        new RegExp(
          `${noDocs || decision === "not-assessed" ? 0 : 1}\\/${noDocs ? 0 : 1} descriptions assessed`,
        ),
      );
      assert.doesNotMatch(
        reportSection(html, "appendix"),
        new RegExp(
          `${noDocs || decision === "not-assessed" ? 0 : 1}\\/${noDocs ? 0 : 1} descriptions assessed`,
        ),
      );
      if (noDocs) assert.match(quality, /report-badge add">passed/);
      else if (decision === "fail") assert.match(html, /Description explains code/);
      else assert.doesNotMatch(html, /Description explains code/);
      assert.equal(assessment.dimensions.documentQuality.coverage.checkCount, noDocs ? 0 : 1);
      assertNoDocumentAppendixUi(html);
    }
  });

void recordedAssessmentTest(
  "removing aggregate quality preserves documentation findings, assessment status and safety",
  () => {
    const recorded = readAssessment(
      new URL("../evals/assessments/45348/assessment.json", import.meta.url),
    );
    const passedGuidance = required(recorded.dimensions.compliance.intentAssessments[0]);
    assert.equal(recorded.dimensions.compliance.status, "passed");
    for (const version of [1, 2, 3])
      for (const [
        decision,
        legacy,
        expectedCount,
        noDocs = false,
      ] of /** @type {[TestDocumentDecision, boolean, string, boolean?][]} */ ([
        ["pass", false, "0"],
        ["fail", false, version === 1 ? "2" : "1"],
        ["not-assessed", false, "0"],
        ["pass", true, "0"],
        ["pass", false, "0", true],
      ])) {
        const assessment = documentedAssessment(decision, noDocs, version);
        assessment.dimensions.compliance = {
          ...structuredClone(recorded.dimensions.compliance),
          intentAssessments: [
            { ...structuredClone(passedGuidance), semanticIntentId: "semantic-widget" },
          ],
          coverage: {
            semanticIntentCount: 1,
            assessedIntentCount: 1,
            selectedDocumentCount: required(passedGuidance.documents).length,
            unassessedIntentIds: [],
          },
        };
        if (legacy) {
          assessment.dimensions.documentQuality =
            /** @type {DocumentedAssessment["dimensions"]["documentQuality"]} */ (
              /** @type {unknown} */ ({
                status: "not-assessed",
                summary: "Historical artifact has no doc assessment.",
              })
            );
        }
        const before = structuredClone(assessment);
        const html = renderAssessmentHtml(assessment);
        assert.doesNotMatch(html, /Overall code quality/);
        assert.equal(summaryCardValue(html, "Documentation Completeness"), Number(expectedCount));
        assert.deepEqual(assessment, before);
        assert.equal(assessment.safety.status, "passed");
        assert.equal(assessment.safety.scope, "rest-and-downstream-only");
      }
  },
);

void test("failed documentation with partial checks reports incomplete intent coverage", () => {
  const assessment = documentedAssessment({ correctness: "fail", meaning: "not-assessed" });
  const dimension = assessment.dimensions.documentQuality;
  assert.equal(dimension.status, "failed");
  assert.equal(required(dimension.intentAssessments[0]).status, "failed");
  assert.deepEqual(dimension.coverage.unassessedIntentIds, ["semantic-widget"]);
  assert.equal(dimension.coverage.assessedIntentCount, 0);
  assert.equal(dimension.coverage.assessedCheckCount, 1);
  const html = renderAssessmentHtml(assessment);
  assert.match(documentQualitySummary(dimension).detail, /1\/2 checks assessed/);
  assert.match(documentQualitySummary(dimension).detail, /0\/1 intent scopes resolved/);
  assert.doesNotMatch(
    html,
    /1\/2 checks assessed|0\/1 intent scopes resolved|Documentation not assessed for:/,
  );
  assert.equal(summaryCardValue(html, "Documentation Completeness"), 1);
  assert.doesNotMatch(html, /Overall code quality/);
  assert.equal(assessment.safety.status, "passed");
});

void test("passed documentation is omitted from HTML while summary data stays intact", () => {
  const assessment = documentedAssessment("pass");
  assert.ok(
    required(required(assessment.dimensions.documentQuality.intentAssessments[0]).checks).every(
      (check) => check.expected === undefined,
    ),
  );
  const html = renderAssessmentHtml(assessment);
  const main = reportSection(html, "document-quality");
  assert.doesNotMatch(main, /document-quality-intent|document-quality-check|Widget\.count/);
  assert.match(main, /0 findings · 1 description assessed/);
  assert.match(
    documentQualitySummary(assessment.dimensions.documentQuality).detail,
    /2\/2 checks assessed/,
  );
  assertNoDocumentAppendixUi(html);
});

void test("one failed and one passed doc check render only one full source comparison", () => {
  const html = renderAssessmentHtml(documentedAssessment({ correctness: "pass", meaning: "fail" }));
  const quality = reportSection(html, "document-quality");
  assert.equal((quality.match(/class="report-card document-quality-check"/g) ?? []).length, 1);
  assert.doesNotMatch(quality, /document-quality-check-summary/);
  assert.equal((quality.match(/class="report-document-snapshots"/g) ?? []).length, 1);
  assert.equal((quality.match(/<pre><code>/g) ?? []).length, 2);
  assert.equal((quality.match(/<h3>Suggested change<\/h3>/g) ?? []).length, 1);
  assert.equal((quality.match(/<h3>Current description<\/h3>/g) ?? []).length, 1);
  assert.match(quality, /meaning issue in count documentation/);
  assert.match(
    documentQualitySummary(
      documentedAssessment({ correctness: "pass", meaning: "fail" }).dimensions.documentQuality,
    ).detail,
    /1 legacy checks passed/,
  );
  assertNoDocumentAppendixUi(html);
  assert.doesNotMatch(quality, /Expected meaning or contract was not recorded/);
});

void test("unassessed documentation keeps summary coverage while HTML omits removed appendix details", () => {
  const html = renderAssessmentHtml(documentedAssessment("not-assessed"));
  const main = reportSection(html, "document-quality");
  const summary = documentQualitySummary(
    documentedAssessment("not-assessed").dimensions.documentQuality,
  );
  assert.doesNotMatch(main, /Not assessed reason|document-quality-file/);
  assert.match(summary.detail, /0 legacy checks passed/);
  assert.match(summary.detail, /0\/2 checks assessed/);
  assert.match(summary.detail, /0\/1 intent scopes resolved/);
  assert.doesNotMatch(
    html,
    /Contract evidence incomplete|Expected meaning or contract was not recorded|<h3>Expected|<h3>Actual|class="report-document-snapshots"/,
  );
  assertNoDocumentAppendixUi(html);
});

void test("Documentation Completeness labels retain red impacts and historical anchors", () => {
  for (const version of [1, 2, 3]) {
    const assessment = documentedAssessment("fail", false, version);
    const original = structuredClone(assessment);
    const html = renderAssessmentHtml(assessment);
    const main = reportSection(html, "document-quality");
    const hero = required(
      [...html.matchAll(/<a class="summary-card" href="#document-quality">[\s\S]*?<\/a>/g)].find(
        ([card]) => card.includes('<div class="summary-label">Documentation Completeness</div>'),
      ),
    )[0];
    assert.match(hero, /<div class="summary-label">Documentation Completeness<\/div>/);
    assert.doesNotMatch(hero, /Doc Correctness|Document Quality|Agent Friendliness/);
    assert.match(main, /<h2>Documentation Completeness<\/h2>/);
    assert.match(main, /Does the TypeSpec compiler return a nonempty effective document\?/);
    assert.match(main, /Examples, external documentation, and agent execution are not assessed/);
    assertNoDocumentAppendixUi(html);
    const semantic = reportSection(html, "semantic-intents");
    assert.match(semantic, /aria-label="Documentation Completeness findings"/);
    assert.doesNotMatch(
      semantic,
      /Document Quality:|Agent Friendliness:|aria-label="Document quality findings"/,
    );
    for (const finding of assessment.dimensions.documentQuality.findings) {
      assert.ok(
        semantic.includes(
          `class="report-link impact" href="#document-quality-${finding.id}">Documentation Completeness: `,
        ),
      );
      assert.ok(main.includes(`id="document-quality-${finding.id}"`));
    }
    assert.deepEqual(assessment, original);
  }
});
