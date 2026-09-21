import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { assembleAssessment, matchTypeFindingIntents } from "./assemble-assessment.mjs";
import { readJson, writeJson } from "./cli.mjs";
import { readComplianceCatalog } from "./compliance-assessment.mjs";
import { renderAssessmentHtml } from "./render-assessment-html.mjs";
import { reportSection } from "./report-test-utils.mjs";
import { validateAssessment } from "./validate-assessment.mjs";

/** @typedef {import("./runtime-types.js").AssessmentModelInput} AssessmentModelInput */
/** @typedef {import("./runtime-types.js").AssessmentJudgment} AssessmentJudgment */
/** @typedef {import("./runtime-types.js").AssessmentMethodGroup} AssessmentMethodGroup */
/** @typedef {import("./runtime-types.js").AssessmentOutput} AssessmentOutput */
/** @typedef {import("./runtime-types.js").ComplianceDecision} ComplianceDecision */

/**
 * Treat the assembler's inferred return shape as its public output contract.
 * @param {Parameters<typeof assembleAssessment>[0]} options
 * @returns {AssessmentOutput}
 */
function assembleTestAssessment(options) {
  return /** @type {AssessmentOutput} */ (/** @type {unknown} */ (assembleAssessment(options)));
}

void test("validator rejects passed dimensions with blockers", () => {
  const malformedAssessment = {
    schemaVersion: 1,
    safety: { scope: "rest-and-downstream-only", status: "safe" },
    dimensions: {
      semantic: { status: "passed", items: [], blockers: [] },
      rest: {
        status: "passed",
        findings: [],
        blockers: [{ code: "inference-blocked", message: "Blocked." }],
      },
      downstream: { status: "passed", findings: [], blockers: [] },
      compliance: {
        status: "not-assessed",
        coverage: {
          semanticIntentCount: 0,
          assessedIntentCount: 0,
          selectedDocumentCount: 0,
          unassessedIntentIds: [],
        },
        intentAssessments: [],
        findings: [],
        retrievalFailures: [],
        blockers: [],
      },
      documentQuality: { status: "not-assessed" },
    },
    blockers: [],
  };
  const errors = validateAssessment(
    /** @type {AssessmentOutput} */ (/** @type {unknown} */ (malformedAssessment)),
  );

  assert.ok(errors.includes("REST status must be not-assessed."));
});

function fixture() {
  const work = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-assessment-"));
  writeJson(path.join(work, "preparation-manifest.json"), {
    schemaVersion: 1,
    repository: { root: "repo" },
    pullRequest: {
      number: 123,
      url: "https://github.com/Azure/azure-rest-api-specs/pull/123",
    },
    comparison: {
      baseRef: "origin/main",
      mergeBaseCommit: "base",
      headCommit: "head",
      workingTree: {},
    },
    changedFiles: [{ path: "specification/a/main.tsp", origins: ["unstaged"] }],
    projects: [],
    blockers: [],
    timings: {},
  });
  writeJson(path.join(work, "source", "source-index.json"), {
    sourceChanges: [
      {
        id: "source-1",
        path: "specification/a/main.tsp",
        hunks: [{ id: "hunk-1", lines: ["+model Widget {}"] }],
        declarations: [
          {
            id: "declaration-1",
            kind: "model",
            qualifiedName: "Contoso.Widget",
            hunkIds: ["hunk-1"],
            source: { revision: "current", startLine: 1, endLine: 2 },
          },
        ],
      },
    ],
  });
  writeJson(path.join(work, "dimensions", "semantic-intents-input.json"), {
    status: "ready",
    facts: {
      "operation-1": {
        id: "operation-1",
        revision: "current",
        operationId: "Widgets_Get",
        apiVersion: "v1",
        method: "get",
        path: "/widgets",
      },
      "operation-2": {
        id: "operation-2",
        revision: "current",
        operationId: "Widgets_List",
        apiVersion: "v1",
        method: "get",
        path: "/widgets/all",
      },
    },
    reviewUnits: [
      {
        id: "semantic-1",
        action: "modify",
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        operationIds: ["operation-1", "operation-2"],
      },
    ],
    blockers: [],
  });
  writeJson(path.join(work, "dimensions", "rest-breaking-input.json"), {
    status: "ready",
    facts: { "rest-fact-1": { id: "rest-fact-1" } },
    candidates: [
      {
        id: "rest-1",
        rule: "required-property-added",
        actual: "mode is required",
        expected: "mode remains optional",
        operationIds: ["Widgets_Get"],
        sourceChangeIds: ["source-1"],
        evidenceFactIds: ["rest-fact-1"],
      },
    ],
    blockers: [],
  });
  writeJson(path.join(work, "dimensions", "downstream-breaking-input.json"), {
    status: "ready",
    facts: {},
    candidates: [],
    blockers: [],
  });
  return work;
}

void test("assembly retains mapped operations without treating paging metadata as a wire change", () => {
  for (const wireField of [undefined, "responses", "produces"]) {
    const work = fixture();
    try {
      const before = {
        id: "before",
        operationId: "OutboundRules_Post",
        method: "post",
        path: "/managedNetworks/{name}/batchOutboundRules",
        apiVersion: "v1",
        responses: [{ statusCode: "200", schema: { type: "object" } }],
        produces: ["application/json"],
      };
      const after = {
        ...structuredClone(before),
        id: "after",
        paging: { nextLinkName: "nextLink" },
      };
      if (wireField === "responses") after.responses[0].schema.type = "array";
      if (wireField === "produces") after.produces = ["text/plain"];
      writeJson(path.join(work, "dimensions", "semantic-intents-input.json"), {
        status: "ready",
        blockers: [],
        facts: { before, after },
        reviewUnits: [
          {
            id: "semantic-1",
            action: "modify",
            sourceChangeIds: ["source-1"],
            hunkIds: ["hunk-1"],
            ownedOperationIds: ["OutboundRules_Post"],
            operationIds: ["after"],
            operations: [
              {
                operationId: "OutboundRules_Post",
                beforeFactId: "before",
                afterFactId: "after",
                restChanged: Boolean(wireField),
                matchBasis: "operation-identity",
              },
            ],
          },
        ],
      });
      writeJson(path.join(work, "dimensions", "rest-breaking-input.json"), {
        status: "ready",
        facts: {},
        candidates: [],
        blockers: [],
      });
      const result = assembleTestAssessment({
        work,
        judgment: {
          schemaVersion: 1,
          overallConfidence: "high",
          blockers: [],
          semanticIntents: [
            {
              reviewUnitId: "semantic-1",
              title: "Mark outbound rules as paged",
              summary: "Add SDK paging metadata.",
            },
          ],
          restDecisions: [],
          downstreamDecisions: [],
          complianceDecisions: [],
        },
      });
      const operations = result.dimensions.semantic.items[0].operations;
      assert.equal(operations.length, 1);
      const operation = operations[0];
      assert.ok(operation);
      assert.equal(operation.operationId, "OutboundRules_Post");
      assert.equal(operation.restChanged, Boolean(wireField));
      assert.ok(operation.changedAspects?.includes("paging"));
      assert.ok(operation.outcome);
      if (wireField) assert.match(operation.outcome, /REST contract changed:/);
      else {
        assert.match(
          operation.outcome,
          /HTTP signature and represented payload contract unchanged; SDK paging metadata changed/,
        );
        const html = renderAssessmentHtml(result);
        assert.match(html, /Affected operations \(1\)/);
        assert.match(html, /OutboundRules_Post/);
        assert.doesNotMatch(html, /No directly affected REST operation/);
      }
    } finally {
      fs.rmSync(work, { recursive: true, force: true });
    }
  }
});

void test("assembler restores API-version-wide intents without candidate decisions", () => {
  const work = fixture();
  try {
    const semanticPath = path.join(work, "dimensions", "semantic-intents-input.json");
    const semantic = /** @type {{reviewUnits: Record<string, unknown>[]}} */ (
      readJson(semanticPath)
    );
    semantic.reviewUnits = [
      {
        id: "semantic-version-wide",
        action: "modify",
        intentType: "api-version-wide-change",
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        declarationIds: ["declaration-1"],
        declarationNames: ["Versions"],
        ownedOperationIds: [],
        operationIds: ["operation-1", "operation-2"],
        operations: [
          {
            operationId: "Widgets_Get",
            afterFactId: "operation-1",
            matchBasis: "version-transition-change",
          },
          {
            operationId: "Widgets_List",
            afterFactId: "operation-2",
            matchBasis: "version-transition-change",
          },
        ],
      },
    ];
    writeJson(semanticPath, semantic);
    writeJson(path.join(work, "model-input.json"), {
      semanticReviewUnits: [],
      informationalSemanticIntentIds: ["semantic-version-wide"],
      restCandidates: [],
      downstreamCandidates: [],
      inferenceRequests: [],
      complianceSearchRequests: [],
      inputAccounting: {},
    });

    const result = assembleTestAssessment({
      work,
      judgment: {
        schemaVersion: 1,
        overallConfidence: "high",
        blockers: [],
        semanticIntents: [],
        restDecisions: [],
        downstreamDecisions: [],
        complianceDecisions: [],
      },
    });

    assert.equal(result.dimensions.semantic.items.length, 1);
    assert.equal(result.dimensions.semantic.items[0].intentType, "api-version-wide-change");
    assert.equal(result.dimensions.semantic.items[0].informational, true);
    assert.equal(result.dimensions.semantic.items[0].operations.length, 2);
    assert.deepEqual(result.dimensions.rest.findings, []);
    assert.equal(result.dimensions.compliance.status, "passed");
    assert.deepEqual(result.dimensions.compliance.coverage, {
      semanticIntentCount: 0,
      assessedIntentCount: 0,
      selectedDocumentCount: 0,
      unassessedIntentIds: [],
    });
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

/** @param {string} work @returns {ComplianceDecision[]} */
function addComplianceInput(work) {
  const request = {
    reviewUnitId: "semantic-1",
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
    declarationIds: ["declaration-1"],
    queryProfile: {
      servicePlane: "data-plane",
      action: "modify",
      declarationKinds: ["model"],
      qualifiedNames: ["Contoso.Widget"],
      symbols: [],
      categories: ["models"],
      changedTokens: ["Widget"],
    },
  };
  writeJson(path.join(work, "model-input.json"), {
    complianceSearchRequests: [request],
    inputAccounting: {},
  });
  const scores = [10, 9, 8, 7];
  const catalogRanking = readComplianceCatalog().map((item, index) => ({
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
      index < 4 ? "Relevant to the changed model." : "Lower relevance to the changed model.",
  }));
  const documents = catalogRanking.slice(0, 4).map((item, index) => ({
    ...item,
    retrieval: {
      status: "fetched",
      retrievedAt: "2026-08-28T00:00:00.000Z",
      contentHash: `sha256:${"a".repeat(64)}`,
    },
    guidance:
      index === 0
        ? [
            {
              section: "Resource types",
              excerpt: "Use the standard resource template.",
              queryTerms: ["Widget"],
              examples: [],
              applicableDeclarationIds: ["declaration-1"],
            },
          ]
        : [],
    noRelevantGuidance: index !== 0,
  }));
  writeJson(path.join(work, "compliance-search-evidence.json"), {
    schemaVersion: 2,
    queryProfiles: [
      {
        reviewUnitId: "semantic-1",
        queryProfile: request.queryProfile,
      },
    ],
    catalogRanking,
    rankedDocuments: documents,
    retrievalAttempts: [],
    blockers: [],
    inputAccounting: {
      catalogEntriesScored: readComplianceCatalog().length,
      documentsFetched: 4,
      documentBytesFetched: 100,
      guidanceExcerptsRetained: 1,
      guidanceExcerptBytesRetained: 35,
    },
  });
  return [
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
      title: "Widget does not use the documented resource template",
      severity: "medium",
      expected: "Use the standard resource template.",
      actual: "model Widget {}",
      rationale: "The model does not use the documented resource template.",
    },
  ];
}

function inferenceModelInput() {
  return {
    artifactReferences: {
      sourceIndex: "source/source-index.json",
    },
    facts: {
      "sdk-fact-inferred": {
        id: "sdk-fact-inferred",
        factKind: "client",
        identity: "Contoso.Widgets",
      },
    },
    semanticReviewUnits: [
      {
        reviewUnitId: "semantic-1",
        deterministicCoverage: {
          coveredHunkIds: [],
          uncoveredHunkIds: ["hunk-1"],
        },
        inferenceRequired: true,
      },
    ],
    inferenceRequests: [
      {
        requestId: "inference-request-1",
        reviewUnitId: "semantic-1",
        sourceChangeId: "source-1",
        hunkId: "hunk-1",
        reason: "source-change-not-represented-in-language-neutral-artifacts",
        sourceExcerpt: '+@@clientLocation(Widgets.get, Contoso, "!go");',
        relatedOperationIds: [],
        allowedDimensions: ["rest", "downstream"],
        evidenceRef: {
          artifact: "source/source-index.json",
          sourceChangeId: "source-1",
          hunkId: "hunk-1",
        },
      },
    ],
    inputAccounting: {},
  };
}

void test("assembler joins confirmed evidence and derives scoped safety", () => {
  const work = fixture();
  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Require mode",
          summary: "The request now requires mode.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "approve",
          severity: "high",
          rationale: "Existing requests fail.",
        },
      ],
      downstreamDecisions: [],
      complianceDecisions: [],
      overallConfidence: "high",
      blockers: [],
    },
  });
  assert.equal(assessment.safety.status, "failed");
  assert.deepEqual(assessment.pullRequest, {
    number: 123,
    url: "https://github.com/Azure/azure-rest-api-specs/pull/123",
  });
  assert.equal(assessment.dimensions.semantic.items[0].action, "add");
  assert.equal(assessment.dimensions.semantic.items[0].changeKind, "add");
  assert.deepEqual(
    assessment.dimensions.semantic.items[0].operations.map((operation) => operation.operationId),
    ["Widgets_Get", "Widgets_List"],
  );
  assert.equal(assessment.dimensions.rest.findings.length, 1);
  assert.deepEqual(validateAssessment(assessment), []);
});

/** @returns {AssessmentJudgment} */
function documentJudgment() {
  return {
    schemaVersion: 1,
    semanticIntents: [
      {
        reviewUnitId: "semantic-1",
        title: "Update Widget",
        summary: "Update the Widget source documentation.",
      },
    ],
    restDecisions: [
      {
        candidateId: "rest-1",
        decision: "reject",
        rationale: "No confirmed REST break.",
      },
    ],
    downstreamDecisions: [],
    complianceDecisions: [],
    overallConfidence: "high",
    blockers: [],
  };
}

/** @param {string} work @param {boolean} documentationPresent */
function addDocumentInput(work, documentationPresent) {
  const semanticPath = path.join(work, "dimensions", "semantic-intents-input.json");
  const semantic = /** @type {{reviewUnits: {declarationIds: string[]}[]}} */ (
    readJson(semanticPath)
  );
  semantic.reviewUnits[0].declarationIds = ["declaration-1"];
  writeJson(semanticPath, semantic);
  const declaration = {
    declarationId: "declaration-1",
    sourceChangeId: "source-1",
    qualifiedName: "Contoso.Widget",
    kind: "model",
    documentationPresent,
    source: { revision: "current", startLine: 1, endLine: 2 },
  };
  const sourceIndexPath = path.join(work, "source", "source-index.json");
  const sourceIndex =
    /** @type {{sourceChanges: {declarations: unknown[], documentEvidence?: unknown}[]}} */ (
      readJson(sourceIndexPath)
    );
  sourceIndex.sourceChanges[0].declarations = [
    {
      id: "declaration-1",
      qualifiedName: "Contoso.Widget",
      kind: "model",
      documentationPresent,
      hunkIds: ["hunk-1"],
      source: declaration.source,
    },
  ];
  sourceIndex.sourceChanges[0].documentEvidence = {
    schemaVersion: 4,
    status: "ready",
    blockers: [],
    declarations: [
      {
        declarationId: declaration.declarationId,
        qualifiedName: declaration.qualifiedName,
        kind: declaration.kind,
        documentationPresent: declaration.documentationPresent,
        source: declaration.source,
      },
    ],
  };
  writeJson(sourceIndexPath, sourceIndex);
  writeJson(path.join(work, "dimensions", "document-quality-input.json"), {
    schemaVersion: 4,
    status: "ready",
    blockers: [],
    reviewUnits: [
      {
        reviewUnitId: "semantic-1",
        status: "ready",
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        declarationIds: ["declaration-1"],
        declarations: [declaration],
      },
    ],
  });
}

void test("assembler derives missing documentation without changing REST/downstream safety", () => {
  const work = fixture();
  try {
    addDocumentInput(work, false);
    const judgment = documentJudgment();
    const assessment = assembleTestAssessment({ work, judgment });
    const documentQuality = assessment.dimensions.documentQuality;
    assert.equal(documentQuality.status, "failed");
    assert.equal(documentQuality.assessmentVersion, 4);
    assert.ok(documentQuality.coverage);
    assert.equal(documentQuality.coverage.missingDeclarationCount, 1);
    assert.ok(documentQuality.findings);
    assert.match(documentQuality.findings[0].title, /Missing documentation/);
    assert.equal(assessment.safety.status, "passed");
    assert.ok(assessment.provenance);
    assert.equal(assessment.provenance.documentQuality, "dimensions/document-quality-input.json");
    assert.deepEqual(validateAssessment(assessment), []);
    documentQuality.findings = [];
    assert.ok(validateAssessment(assessment).some((error) => error.includes("Document Quality")));
    assessment.dimensions.documentQuality = {
      status: "not-assessed",
      summary: "Pretend legacy input.",
    };
    assert.ok(
      validateAssessment(assessment).some((error) => error.includes("canonical provenance")),
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("assembler rejects Agent-authored documentation decisions", () => {
  const work = fixture();
  try {
    const judgment = documentJudgment();
    assert.equal(
      assembleTestAssessment({ work, judgment }).dimensions.documentQuality.status,
      "not-assessed",
    );
    const malformedJudgment = {
      ...judgment,
      documentQualityDecisions: [],
    };
    assert.throws(
      () =>
        assembleTestAssessment({
          work,
          judgment: /** @type {AssessmentJudgment} */ (/** @type {unknown} */ (malformedJudgment)),
        }),
      /unknown fields: documentQualityDecisions/,
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("compiler documentation presence flows through assembly, validation, and HTML", () => {
  const work = fixture();
  try {
    addDocumentInput(work, false);
    const judgment = documentJudgment();
    judgment.complianceDecisions = addComplianceInput(work).map((decision) => {
      const pass = { ...decision };
      delete pass.title;
      delete pass.severity;
      return {
        ...pass,
        decision: "applicable-pass",
        actual: "The source model satisfies the selected model guidance.",
        rationale: "The applicable model guidance is satisfied.",
      };
    });
    const modelInput = /** @type {AssessmentModelInput} */ (
      readJson(path.join(work, "model-input.json"))
    );
    if (modelInput.inferenceRequests?.length) {
      writeJson(path.join(work, "inference.json"), {
        schemaVersion: 1,
        results: modelInput.inferenceRequests.map((request) => ({
          requestId: request.requestId,
          reviewUnitId: request.reviewUnitId,
          hunkId: request.hunkId,
          decision: "no-impact",
          rationale: "The source documentation change has no REST or downstream impact.",
          candidates: [],
        })),
      });
    }
    assert.equal(modelInput.documentQualityReviewUnits, undefined);
    assert.equal(modelInput.documentQualityCriterion, undefined);
    const assessment = assembleTestAssessment({ work, judgment });
    assert.deepEqual(validateAssessment(assessment), []);
    const documentQuality = assessment.dimensions.documentQuality;
    assert.equal(documentQuality.status, "failed");
    assert.equal(documentQuality.assessmentVersion, 4);
    assert.ok(documentQuality.coverage);
    assert.equal(documentQuality.coverage.declarationCount, 1);
    assert.equal(assessment.dimensions.rest.status, "passed");
    assert.equal(assessment.dimensions.downstream.status, "passed");
    assert.equal(assessment.dimensions.compliance.status, "passed");
    assert.equal(assessment.safety.status, "passed");
    assert.ok(documentQuality.findings);
    const finding = documentQuality.findings[0];
    assert.equal(finding.declarationId, "declaration-1");
    assert.match(finding.actual, /returned no nonempty documentation/);
    assert.ok(finding.sources);
    assert.equal(finding.sources[0].id, "source-1");
    assert.equal(finding.sources[0].path, "specification/a/main.tsp");
    assert.equal(finding.sources[0].hunks, undefined);
    const html = renderAssessmentHtml(assessment);
    assert.match(html, /Documentation Completeness/);
    assert.match(html, /Missing documentation for Contoso\.Widget/);
    fs.rmSync(path.join(work, "dimensions", "document-quality-input.json"));
    const legacy = assembleTestAssessment({ work, judgment });
    assert.deepEqual(validateAssessment(legacy), []);
    assert.equal(legacy.dimensions.documentQuality.status, "not-assessed");
    assert.equal(Object.keys(legacy.dimensions.documentQuality).length, 2);
    assert.doesNotThrow(() => renderAssessmentHtml(legacy));
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("assembler rejects incomplete candidate coverage", () => {
  const work = fixture();
  assert.throws(
    () =>
      assembleTestAssessment({
        work,
        judgment: {
          schemaVersion: 1,
          semanticIntents: [
            {
              reviewUnitId: "semantic-1",
              title: "Title",
              summary: "Summary",
            },
          ],
          restDecisions: [],
          downstreamDecisions: [],
          complianceDecisions: [],
          overallConfidence: "high",
          blockers: [],
        },
      }),
    /coverage mismatch/,
  );
});

void test("assembler requires inference output for uncovered hunk requests", () => {
  const work = fixture();
  writeJson(path.join(work, "model-input.json"), inferenceModelInput());
  assert.throws(
    () =>
      assembleTestAssessment({
        work,
        judgment: {
          schemaVersion: 1,
          semanticIntents: [
            {
              reviewUnitId: "semantic-1",
              title: "Change Go client placement",
              summary: "The customization changes generated Go client placement.",
            },
          ],
          restDecisions: [
            {
              candidateId: "rest-1",
              decision: "reject",
              rationale: "The REST contract is unchanged.",
            },
          ],
          downstreamDecisions: [],
          complianceDecisions: [],
          overallConfidence: "high",
          blockers: [],
        },
      }),
    /Missing inference\.json/,
  );
});

void test("assembler validates and joins inferred candidates", () => {
  const work = fixture();
  writeJson(path.join(work, "model-input.json"), inferenceModelInput());
  writeJson(path.join(work, "inference.json"), {
    schemaVersion: 1,
    results: [
      {
        requestId: "inference-request-1",
        reviewUnitId: "semantic-1",
        hunkId: "hunk-1",
        decision: "candidates",
        rationale: "The Go scope changes generated client ownership.",
        candidates: [
          {
            id: "inferred-downstream-1",
            dimension: "downstream",
            rule: "client-location-changed",
            defaultSeverity: "high",
            actual: "Widgets operations move to a different generated Go client.",
            expected: "Existing generated Go client placement remains stable.",
            crossLanguageDefinitionId: "Contoso.Widgets",
            sourceChangeIds: ["source-1"],
            hunkIds: ["hunk-1"],
            operationIds: [],
            evidenceFactIds: ["sdk-fact-inferred"],
            reviewRequired: true,
          },
        ],
      },
    ],
  });
  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Change Go client placement",
          summary: "The customization changes generated Go client placement.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "reject",
          rationale: "The REST contract is unchanged.",
        },
      ],
      downstreamDecisions: [
        {
          candidateId: "inferred-downstream-1",
          decision: "approve",
          severity: "high",
          rationale: "Existing Go callers resolve the operation from a different client.",
        },
      ],
      complianceDecisions: [],
      overallConfidence: "high",
      blockers: [],
    },
  });

  assert.equal(assessment.dimensions.downstream.findings.length, 1);
  assert.equal(assessment.dimensions.downstream.findings[0].id, "inferred-downstream-1");
  assert.equal(assessment.dimensions.downstream.findings[0].inferred, true);
  assert.deepEqual(assessment.dimensions.downstream.findings[0].inferenceRequestIds, [
    "inference-request-1",
  ]);
  assert.equal(assessment.dimensions.downstream.findings[0].evidence.length, 1);
  assert.ok(assessment.provenance);
  assert.equal(assessment.provenance.inference, "inference.json");
  assert.deepEqual(validateAssessment(assessment), []);
});

void test("blocked inference makes scoped safety not assessed", () => {
  const work = fixture();
  writeJson(path.join(work, "model-input.json"), inferenceModelInput());
  writeJson(path.join(work, "inference.json"), {
    schemaVersion: 1,
    results: [
      {
        requestId: "inference-request-1",
        reviewUnitId: "semantic-1",
        hunkId: "hunk-1",
        decision: "blocked",
        rationale: "Language-specific generator evidence is unavailable.",
        candidates: [],
      },
    ],
  });
  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Change Go client placement",
          summary: "The language-specific impact could not be resolved.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "reject",
          rationale: "The REST contract is unchanged.",
        },
      ],
      downstreamDecisions: [],
      complianceDecisions: [],
      overallConfidence: "low",
      blockers: [],
    },
  });

  assert.equal(assessment.dimensions.rest.status, "not-assessed");
  assert.equal(assessment.dimensions.downstream.status, "not-assessed");
  assert.equal(assessment.safety.status, "not-assessed");
  const blocker = assessment.blockers[0];
  assert.ok(blocker && typeof blocker === "object" && "code" in blocker);
  assert.equal(blocker.code, "inference-blocked");
  assert.deepEqual(validateAssessment(assessment), []);
});

void test("assembler requires and joins active Azure Guidelines evidence", () => {
  const work = fixture();
  const complianceDecisions = addComplianceInput(work);
  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Change Widget",
          summary: "Changes the Widget model.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "reject",
          rationale: "The REST contract remains compatible.",
        },
      ],
      downstreamDecisions: [],
      complianceDecisions,
      overallConfidence: "high",
      blockers: [],
    },
  });
  assert.equal(assessment.dimensions.compliance.status, "failed");
  assert.equal(assessment.dimensions.compliance.findings.length, 1);
  const compliance = assessment.dimensions.compliance;
  assert.equal(compliance.sharedSearch?.documents?.length, 4);
  assert.ok(assessment.provenance);
  assert.equal(assessment.provenance.complianceSearchEvidence, "compliance-search-evidence.json");
  assert.deepEqual(validateAssessment(assessment), []);
});

void test("assembler treats no applicable guidance as assessed and links its intent", () => {
  const work = fixture();
  const complianceDecisions = addComplianceInput(work);
  const evidencePath = path.join(work, "compliance-search-evidence.json");
  const evidence =
    /** @type {{rankedDocuments: {guidance: unknown[], noRelevantGuidance: boolean}[], inputAccounting: Record<string, number>}} */ (
      readJson(evidencePath)
    );
  for (const document of evidence.rankedDocuments) {
    document.guidance = [];
    document.noRelevantGuidance = true;
  }
  evidence.inputAccounting.guidanceExcerptsRetained = 0;
  evidence.inputAccounting.guidanceExcerptBytesRetained = 0;
  writeJson(evidencePath, evidence);
  complianceDecisions[0] = {
    reviewUnitId: "semantic-1",
    applicableGuidance: [],
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
    declarationIds: ["declaration-1"],
    decision: "no-applicable-guidance",
    actual: "The intent uses a generator-specific decorator.",
    rationale: "None of the fetched documents governs this decorator.",
  };
  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Change Widget SDK customization",
          summary: "Changes a generator-specific customization.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "reject",
          rationale: "The REST contract remains compatible.",
        },
      ],
      downstreamDecisions: [],
      complianceDecisions,
      overallConfidence: "high",
      blockers: [],
    },
  });

  assert.equal(assessment.dimensions.compliance.status, "passed");
  assert.equal(assessment.dimensions.compliance.coverage.assessedIntentCount, 1);
  assert.deepEqual(assessment.dimensions.compliance.coverage.unassessedIntentIds, []);
  assert.deepEqual(assessment.dimensions.compliance.blockers, []);
  assert.deepEqual(validateAssessment(assessment), []);
  const html = renderAssessmentHtml(assessment);
  const complianceHtml = reportSection(html, "azure-compliance");
  assert.match(
    complianceHtml,
    /No applicable guideline was found for: <a class="report-link" href="#intent-semantic-1">Change Widget SDK customization<\/a>\./,
  );
  assert.doesNotMatch(complianceHtml, /<code>semantic-1<\/code>/);
});

void test("aggregates direct SDK deltas by method without REST operation links", () => {
  const work = fixture();
  const before = {
    id: "sdk-before",
    projectId: "project-1",
    revision: "base",
    factKind: "method",
    kind: "basic",
    crossLanguageDefinitionId: "Contoso.Widgets.get",
    parameters: [{ name: "id", type: "string" }],
    responseType: undefined,
    operation: { verb: "get", path: "/widgets" },
    apiVersions: ["v1"],
  };
  const after = {
    ...before,
    id: "sdk-after",
    revision: "current",
    kind: "lro",
    responseType: "Widget",
    lro: {
      finalStateVia: "location",
      operation: { kind: "http", path: "/widgets", verb: "get" },
      logicalResult: { kind: "model", name: "Widget" },
    },
  };
  /** @param {string} id @param {string} rule */
  const candidate = (id, rule) => ({
    id,
    rule,
    actual: `${rule} actual`,
    expected: `${rule} expected`,
    crossLanguageDefinitionId: "Contoso.Widgets.get",
    sourceChangeIds: ["source-1"],
    evidenceFactIds: ["sdk-before", "sdk-after"],
  });
  writeJson(path.join(work, "dimensions", "downstream-breaking-input.json"), {
    status: "ready",
    facts: { "sdk-before": before, "sdk-after": after },
    candidates: [
      candidate("downstream-kind", "method-kind-changed"),
      candidate("downstream-response", "method-response-changed"),
      candidate("downstream-lro", "method-lro-changed"),
    ],
    blockers: [],
  });
  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Modify get",
          summary: "Modify the SDK projection while preserving REST.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "reject",
          rationale: "REST remains compatible.",
        },
      ],
      downstreamDecisions: [
        {
          candidateId: "downstream-kind",
          decision: "approve",
          severity: "high",
          rationale: "Method kind changed.",
        },
        {
          candidateId: "downstream-response",
          decision: "approve",
          severity: "high",
          rationale: "Response changed.",
        },
        {
          candidateId: "downstream-lro",
          decision: "approve",
          severity: "medium",
          rationale: "LRO behavior changed.",
        },
      ],
      complianceDecisions: [],
      overallConfidence: "high",
      blockers: [],
    },
  });

  const methodGroups = assessment.dimensions.downstream.methodGroups;
  assert.ok(methodGroups);
  assert.equal(methodGroups.length, 1);
  const group = methodGroups[0];
  assert.ok(group);
  assert.equal(group.deltas.length, 3);
  assert.equal(group.parametersUnchanged, true);
  assert.equal(group.deltas[0].before, "basic");
  assert.equal(group.deltas[0].after, "lro");
  const relatedFindings = assessment.dimensions.semantic.items[0].relatedFindings;
  assert.ok(relatedFindings);
  assert.deepEqual(relatedFindings.downstream, [group.id]);
  assert.deepEqual(validateAssessment(assessment), []);
});

void test("assembles changed-only parameters and suppresses URI-template-only LRO deltas", () => {
  const work = fixture();
  /** @param {string} name @param {string} kind @param {boolean} [optional] */
  const parameter = (name, kind, optional = false) => ({
    name,
    optional,
    onClient: false,
    isApiVersionParam: false,
    type: { kind },
  });
  const before = {
    id: "sdk-before",
    projectId: "project-1",
    revision: "base",
    factKind: "method",
    kind: "lro",
    crossLanguageDefinitionId: "Contoso.Widgets.get",
    parameters: [
      parameter("subscriptionId", "string"),
      parameter("resourceGroupName", "string"),
      parameter("widgetName", "string"),
    ],
    operation: { verb: "get", path: "/widgets" },
    apiVersions: ["v1"],
    lro: {
      finalStateVia: "azure-async-operation",
      operation: {
        kind: "http",
        path: "/widgets",
        verb: "get",
        uriTemplate: "/widgets?api-version",
      },
      logicalResult: { kind: "model", name: "Widget" },
    },
  };
  const after = {
    ...before,
    id: "sdk-after",
    revision: "current",
    parameters: [...before.parameters, parameter("afcManagedSync", "boolean", true)],
    lro: {
      ...before.lro,
      operation: {
        ...before.lro.operation,
        uriTemplate: "/widgets?api-version,afcManagedSync",
      },
    },
  };
  /** @param {string} id @param {string} rule */
  const candidate = (id, rule) => ({
    id,
    rule,
    actual: `${rule} actual`,
    expected: `${rule} expected`,
    crossLanguageDefinitionId: "Contoso.Widgets.get",
    sourceChangeIds: ["source-1"],
    evidenceFactIds: ["sdk-before", "sdk-after"],
  });
  writeJson(path.join(work, "dimensions", "downstream-breaking-input.json"), {
    status: "ready",
    facts: { "sdk-before": before, "sdk-after": after },
    candidates: [
      candidate("downstream-parameters", "method-parameters-changed"),
      candidate("downstream-lro", "method-lro-changed"),
    ],
    blockers: [],
  });
  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Modify get",
          summary: "Add an optional request parameter.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "reject",
          rationale: "REST remains compatible.",
        },
      ],
      downstreamDecisions: [
        {
          candidateId: "downstream-parameters",
          decision: "approve",
          severity: "high",
          rationale: "Public method parameters changed.",
        },
        {
          candidateId: "downstream-lro",
          decision: "approve",
          severity: "medium",
          rationale: "The source candidate duplicated URI metadata.",
        },
      ],
      complianceDecisions: [],
      overallConfidence: "high",
      blockers: [],
    },
  });

  const methodGroups = assessment.dimensions.downstream.methodGroups;
  assert.ok(methodGroups);
  const group = methodGroups[0];
  assert.ok(group);
  assert.equal(assessment.dimensions.downstream.findings.length, 1);
  assert.equal(group.deltas.length, 1);
  assert.equal(group.deltas[0].field, "parameters");
  assert.equal(group.deltas[0].before, undefined);
  assert.equal(group.deltas[0].after, undefined);
  const parameterChanges =
    /** @type {NonNullable<AssessmentMethodGroup["deltas"][number]["changes"]>} */ (
      group.deltas[0].changes
    );
  assert.ok(parameterChanges);
  assert.deepEqual(
    (parameterChanges.added ?? []).map((item) => item.parameter),
    [
      {
        name: "afcManagedSync",
        optional: true,
        onClient: false,
        isApiVersionParam: false,
        type: "boolean",
      },
    ],
  );
  assert.equal(parameterChanges.unchangedCount, 3);
  assert.deepEqual(validateAssessment(assessment), []);
});

void test("assembles SDK type impacts from deterministic method paths", () => {
  const work = fixture();
  const before = {
    id: "sdk-type-before",
    projectId: "project-1",
    comparisonRole: "baseline",
    factKind: "model",
    identity: "Contoso.Widget",
    crossLanguageDefinitionId: "Contoso.Widget",
    properties: [
      {
        name: "legacy",
        optional: true,
        type: { kind: "string" },
      },
    ],
  };
  const after = {
    ...before,
    id: "sdk-type-after",
    comparisonRole: "target",
    properties: [],
  };
  const method = {
    id: "sdk-method-current",
    projectId: "project-1",
    comparisonRole: "target",
    factKind: "method",
    identity: "Contoso.Widgets.get",
    crossLanguageDefinitionId: "Contoso.Widgets.get",
  };
  writeJson(path.join(work, "dimensions", "downstream-breaking-input.json"), {
    status: "ready",
    facts: {
      [before.id]: before,
      [after.id]: after,
      [method.id]: method,
    },
    candidates: [
      {
        id: "downstream-widget-property",
        rule: "model-property-removed",
        actual: "Contoso.Widget no longer exposes property legacy.",
        expected: "Contoso.Widget preserves its SDK contract.",
        crossLanguageDefinitionId: "Contoso.Widget",
        sourceChangeIds: ["source-1"],
        evidenceFactIds: [before.id, after.id],
        rootCauseIds: ["root-widget"],
      },
    ],
    rootCauses: [
      {
        id: "root-widget",
        kind: "type-contract-propagation",
        directCandidateIds: ["downstream-widget-property"],
        propagatedCandidateIds: [],
        methodFactIds: [method.id],
        typeFactIds: [before.id, after.id],
        referenceEvidence: [
          {
            fromFactId: method.id,
            toFactId: after.id,
            kind: "response",
            location: "response-body",
          },
        ],
      },
    ],
    blockers: [],
  });
  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Remove Widget legacy property",
          summary: "Remove the generated legacy response property.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "reject",
          rationale: "REST remains compatible.",
        },
      ],
      downstreamDecisions: [
        {
          candidateId: "downstream-widget-property",
          decision: "approve",
          severity: "high",
          rationale: "Existing SDK consumers can read this property.",
        },
      ],
      complianceDecisions: [],
      overallConfidence: "high",
      blockers: [],
    },
  });

  const typeImpacts = assessment.dimensions.downstream.typeImpacts;
  assert.ok(typeImpacts);
  assert.equal(typeImpacts.length, 1);
  const impact = typeImpacts[0];
  assert.ok(impact);
  assert.equal(impact.type, "Contoso.Widget");
  assert.deepEqual(impact.locations, ["response-body"]);
  assert.ok(impact.affectedMethods);
  assert.deepEqual(
    impact.affectedMethods.map((item) => item.symbol),
    ["Contoso.Widgets.get"],
  );
  const relatedFindings = assessment.dimensions.semantic.items[0].relatedFindings;
  assert.ok(relatedFindings);
  assert.deepEqual(relatedFindings.typeImpact, [impact.id]);
  assert.deepEqual(validateAssessment(assessment), []);
});

void test("uses only version-governance hunks for legacy publication operations", () => {
  const work = fixture();
  const manifestPath = path.join(work, "preparation-manifest.json");
  const manifest =
    /** @type {{projects: {id: string, path: string, sourceChangeIds: string[]}[]}} */ (
      readJson(manifestPath)
    );
  manifest.projects = [
    {
      id: "project-1",
      path: "specification/a",
      sourceChangeIds: ["source-1"],
    },
    {
      id: "project-unrelated",
      path: "specification/b",
      sourceChangeIds: ["source-unrelated"],
    },
  ];
  writeJson(manifestPath, manifest);
  const sourceIndexPath = path.join(work, "source", "source-index.json");
  const sourceIndex =
    /** @type {{sourceChanges: {id: string, path?: string, hunks: {id: string}[], declarations: {id: string, kind: string, qualifiedName: string, hunkIds: string[], source: {revision: "current", startLine: number, endLine: number}}[]}[]}} */ (
      readJson(sourceIndexPath)
    );
  sourceIndex.sourceChanges[0].declarations = [
    {
      id: "version-declaration",
      kind: "enum",
      qualifiedName: "Contoso.Versions",
      hunkIds: ["hunk-1"],
      source: { revision: "current", startLine: 1, endLine: 2 },
    },
  ];
  sourceIndex.sourceChanges.push({
    id: "source-unrelated",
    path: "specification/b/main.tsp",
    hunks: [{ id: "hunk-unrelated" }],
    declarations: [
      {
        id: "unrelated-declaration",
        kind: "enum",
        qualifiedName: "Other.Versions",
        hunkIds: ["hunk-unrelated"],
        source: { revision: "current", startLine: 1, endLine: 2 },
      },
    ],
  });
  writeJson(sourceIndexPath, sourceIndex);
  const semanticPath = path.join(work, "dimensions", "semantic-intents-input.json");
  const semantic =
    /** @type {{facts: Record<string, {projectId?: string}>, reviewUnits: {sourceChangeIds: string[], hunkIds: string[], groupingEvidence?: {reasons: string[]}}[]}} */ (
      readJson(semanticPath)
    );
  semantic.facts["operation-1"].projectId = "project-1";
  semantic.reviewUnits[0].sourceChangeIds = ["source-1", "source-unrelated"];
  semantic.reviewUnits[0].hunkIds = ["hunk-1", "hunk-unrelated"];
  semantic.reviewUnits[0].groupingEvidence = {
    reasons: ["cross-project:api-version-publication"],
  };
  writeJson(semanticPath, semantic);

  const assessment = assembleTestAssessment({
    work,
    judgment: {
      schemaVersion: 1,
      semanticIntents: [
        {
          reviewUnitId: "semantic-1",
          title: "Publish v1",
          summary: "Publish the API version.",
        },
      ],
      restDecisions: [
        {
          candidateId: "rest-1",
          decision: "reject",
          rationale: "REST remains compatible.",
        },
      ],
      downstreamDecisions: [],
      complianceDecisions: [],
      overallConfidence: "high",
      blockers: [],
    },
  });

  const operationSources = assessment.dimensions.semantic.items[0].operations[0].sources;
  assert.ok(operationSources);
  assert.deepEqual(
    operationSources.map((source) => source.id),
    ["source-1"],
  );
  assert.deepEqual(
    operationSources[0].hunks.map((hunk) => hunk.id),
    ["hunk-1"],
  );
});

void test("matches type findings to semantic intents by changed declaration identity", () => {
  const semanticItems = [
    {
      id: "semantic-file-items",
      declarationIds: ["file-item", "file-item-name"],
      sources: [
        {
          declarations: [
            { id: "file-item", qualifiedName: "FileItem" },
            { id: "file-item-name", qualifiedName: "FileItem.name" },
            { id: "directory-item", qualifiedName: "DirectoryItem" },
          ],
        },
      ],
    },
    {
      id: "semantic-directory-items",
      declarationIds: ["directory-item"],
      sources: [
        {
          declarations: [
            { id: "file-item", qualifiedName: "FileItem" },
            { id: "directory-item", qualifiedName: "DirectoryItem" },
          ],
        },
      ],
    },
  ];

  const finding = /** @type {Parameters<typeof matchTypeFindingIntents>[0]} */ (
    /** @type {unknown} */ ({
      crossLanguageDefinitionId: "Storage.File.FileItem",
      evidence: [],
    })
  );
  const semanticItemFixtures = /** @type {Parameters<typeof matchTypeFindingIntents>[1]} */ (
    /** @type {unknown} */ (semanticItems)
  );
  const matches = matchTypeFindingIntents(finding, semanticItemFixtures);

  assert.deepEqual(
    matches.map((intent) => intent.id),
    ["semantic-file-items"],
  );
});
