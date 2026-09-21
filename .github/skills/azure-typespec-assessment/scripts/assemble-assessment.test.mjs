import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test, { after } from "node:test";
import {
  assembleAssessment,
  matchTypeFindingIntents,
} from "./assemble-assessment.mjs";
import { readJson, writeJson } from "./cli.mjs";
import { readComplianceCatalog, resolveDocumentSelections, searchInputAccounting } from "./compliance-assessment.mjs";
import { renderAssessmentHtml } from "./render-assessment-html.mjs";
import { reportSection } from "./report-test-utils.mjs";
import { validateAssessment } from "./validate-assessment.mjs";

const fixtureDirectories = new Set();
after(() => {
  for (const directory of fixtureDirectories) fs.rmSync(directory, { recursive: true, force: true });
});

test("validator rejects passed dimensions with blockers", () => {
  const errors = validateAssessment({
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
  });

  assert.ok(errors.includes("REST status must be not-assessed."));
});

function fixture() {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".typespec-assessment-test-"));
  fixtureDirectories.add(work);
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
        declarationIds: ["declaration-1"],
        referenceCategories: ["models-and-enums"],
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

test("assembly retains mapped operations without treating paging metadata as a wire change", () => {
  for (const wireField of [undefined, "responses", "produces"]) {
    const work = fixture();
    try {
      const before = {
        id: "before", operationId: "OutboundRules_Post", method: "post",
        path: "/managedNetworks/{name}/batchOutboundRules", apiVersion: "v1",
        responses: [{ statusCode: "200", schema: { type: "object" } }],
        produces: ["application/json"],
      };
      const after = { ...structuredClone(before), id: "after", paging: { nextLinkName: "nextLink" } };
      if (wireField === "responses") after.responses[0].schema.type = "array";
      if (wireField === "produces") after.produces = ["text/plain"];
      writeJson(path.join(work, "dimensions", "semantic-intents-input.json"), {
        status: "ready", blockers: [], facts: { before, after },
        reviewUnits: [{
          id: "semantic-1", action: "modify", sourceChangeIds: ["source-1"], hunkIds: ["hunk-1"],
          ownedOperationIds: ["OutboundRules_Post"], operationIds: ["after"],
          operations: [{
            operationId: "OutboundRules_Post", beforeFactId: "before", afterFactId: "after",
            restChanged: Boolean(wireField), matchBasis: "operation-identity",
          }],
        }],
      });
      writeJson(path.join(work, "dimensions", "rest-breaking-input.json"), {
        status: "ready", facts: {}, candidates: [], blockers: [],
      });
      const result = assembleAssessment({ work, judgment: {
        schemaVersion: 2, overallConfidence: "high", blockers: [],
        semanticIntents: [{ reviewUnitId: "semantic-1", title: "Mark outbound rules as paged", summary: "Add SDK paging metadata." }],
        restDecisions: [], downstreamDecisions: [], complianceDecisions: [],
      } });
      const operations = result.dimensions.semantic.items[0].operations;
      assert.equal(operations.length, 1);
      assert.equal(operations[0].operationId, "OutboundRules_Post");
      assert.equal(operations[0].restChanged, Boolean(wireField));
      assert.ok(operations[0].changedAspects.includes("paging"));
      if (wireField) assert.match(operations[0].outcome, /REST contract changed:/);
      else {
        assert.match(operations[0].outcome, /HTTP signature and represented payload contract unchanged; SDK paging metadata changed/);
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

test("assembler restores API-version-wide intents without candidate decisions", () => {
  const work = fixture();
  try {
    const semanticPath = path.join(
      work,
      "dimensions",
      "semantic-intents-input.json",
    );
    const semantic = readJson(semanticPath);
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

    const result = assembleAssessment({
      work,
      judgment: {
        schemaVersion: 2,
        overallConfidence: "high",
        blockers: [],
        semanticIntents: [],
        restDecisions: [],
        downstreamDecisions: [],
        complianceDecisions: [],
      },
    });

    assert.equal(result.dimensions.semantic.items.length, 1);
    assert.equal(
      result.dimensions.semantic.items[0].intentType,
      "api-version-wide-change",
    );
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

function addComplianceInput(work) {
  const selected = readComplianceCatalog().slice(0, 2);
  const request = {
    reviewUnitId: "semantic-1",
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
    declarationIds: ["declaration-1"],
    referenceCategories: ["models-and-enums"],
    guidanceRouting: {
      mandatoryCatalogIds: selected.map((item) => item.catalogId),
      selections: selected.map((item) => ({ catalogId: item.catalogId, category: "models-and-enums", ruleId: "model-guidance" })),
      discoveryRequests: [],
    },
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
  const documents = selected.map(({ catalogId, catalogOrder, title, canonicalUrl }, index) => ({
    catalogId, catalogOrder, title, canonicalUrl,
    retrieval: {
      status: "fetched",
      retrievalSource: "network",
      retrievedAt: "2026-08-28T00:00:00.000Z",
      contentHash: `sha256:${"a".repeat(64)}`,
      bytes: 100,
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
  const evidence = {
    schemaVersion: 3,
    queryProfiles: [
      {
        reviewUnitId: "semantic-1",
        queryProfile: request.queryProfile,
      },
    ],
    documentSelections: resolveDocumentSelections({ requests: [request], discoveryResults: [], additionalSelections: [] }).documentSelections,
    documents,
    discoveryResults: [],
    additionalSelections: [],
    retrievalAttempts: [],
    blockers: [],
  };
  evidence.inputAccounting = searchInputAccounting(evidence);
  writeJson(path.join(work, "compliance-search-evidence.json"), evidence);
  return [
    {
      reviewUnitId: "semantic-1",
      reviewedCatalogIds: selected.map((item) => item.catalogId),
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

test("assembler joins confirmed evidence and derives scoped safety", () => {
  const work = fixture();
  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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
    assessment.dimensions.semantic.items[0].operations.map(
      (operation) => operation.operationId,
    ),
    ["Widgets_Get", "Widgets_List"],
  );
  assert.equal(assessment.dimensions.rest.findings.length, 1);
  assert.deepEqual(validateAssessment(assessment), []);
});

function documentJudgment() {
  return {
    schemaVersion: 2,
    semanticIntents: [{
      reviewUnitId: "semantic-1", title: "Update Widget", summary: "Update the Widget source documentation.",
    }],
    restDecisions: [{
      candidateId: "rest-1", decision: "reject", rationale: "No confirmed REST break.",
    }],
    downstreamDecisions: [],
    complianceDecisions: [],
    overallConfidence: "high",
    blockers: [],
  };
}

function addDocumentInput(work, documentationPresent) {
  const semanticPath = path.join(work, "dimensions", "semantic-intents-input.json");
  const semantic = readJson(semanticPath);
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
  const sourceIndex = readJson(sourceIndexPath);
  sourceIndex.sourceChanges[0].declarations = [{
    id: "declaration-1",
    qualifiedName: "Contoso.Widget",
    kind: "model",
    documentationPresent,
    hunkIds: ["hunk-1"],
    source: declaration.source,
  }];
  sourceIndex.sourceChanges[0].documentEvidence = {
    schemaVersion: 4,
    status: "ready",
    blockers: [],
    declarations: [{ ...declaration, sourceChangeId: undefined }].map(
      ({ sourceChangeId: _sourceChangeId, ...item }) => item,
    ),
  };
  writeJson(sourceIndexPath, sourceIndex);
  writeJson(path.join(work, "dimensions", "document-quality-input.json"), {
    schemaVersion: 4, status: "ready", blockers: [],
    reviewUnits: [{
      reviewUnitId: "semantic-1", status: "ready",
      sourceChangeIds: ["source-1"], hunkIds: ["hunk-1"], declarationIds: ["declaration-1"],
      declarations: [declaration],
    }],
  });
}

test("assembler derives missing documentation without changing REST/downstream safety", () => {
  const work = fixture();
  try {
    addDocumentInput(work, false);
    const judgment = documentJudgment();
    const assessment = assembleAssessment({ work, judgment });
    assert.equal(assessment.dimensions.documentQuality.status, "failed");
    assert.equal(assessment.dimensions.documentQuality.assessmentVersion, 4);
    assert.equal(assessment.dimensions.documentQuality.coverage.missingDeclarationCount, 1);
    assert.match(assessment.dimensions.documentQuality.findings[0].title, /Missing documentation/);
    assert.equal(assessment.safety.status, "passed");
    assert.equal(assessment.provenance.documentQuality, "dimensions/document-quality-input.json");
    assert.deepEqual(validateAssessment(assessment), []);
    assessment.dimensions.documentQuality.findings = [];
    assert.ok(validateAssessment(assessment).some((error) => error.includes("Document Quality")));
    assessment.dimensions.documentQuality = { status: "not-assessed", summary: "Pretend legacy input." };
    assert.ok(validateAssessment(assessment).some((error) => error.includes("canonical provenance")));
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test("assembler rejects Agent-authored documentation decisions", () => {
  const work = fixture();
  try {
    const judgment = documentJudgment();
    assert.equal(assembleAssessment({ work, judgment }).dimensions.documentQuality.status, "not-assessed");
    judgment.documentQualityDecisions = [];
    assert.throws(() => assembleAssessment({ work, judgment }), /unknown fields: documentQualityDecisions/);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test("compiler documentation presence flows through assembly, validation, and HTML", () => {
  const work = fixture();
  try {
    addDocumentInput(work, false);
    const judgment = documentJudgment();
    judgment.complianceDecisions = addComplianceInput(work).map((decision) => {
      const { title: _title, severity: _severity, ...pass } = decision;
      return {
        ...pass, decision: "applicable-pass",
        actual: "The source model satisfies the selected model guidance.",
        rationale: "The applicable model guidance is satisfied.",
      };
    });
    const modelInput = readJson(path.join(work, "model-input.json"));
    if (modelInput.inferenceRequests?.length) {
      writeJson(path.join(work, "inference.json"), {
        schemaVersion: 1,
        results: modelInput.inferenceRequests.map((request) => ({
          requestId: request.requestId, reviewUnitId: request.reviewUnitId, hunkId: request.hunkId,
          decision: "no-impact", rationale: "The source documentation change has no REST or downstream impact.",
          candidates: [],
        })),
      });
    }
    assert.equal(modelInput.documentQualityReviewUnits, undefined);
    assert.equal(modelInput.documentQualityCriterion, undefined);
    const assessment = assembleAssessment({ work, judgment });
    assert.deepEqual(validateAssessment(assessment), []);
    assert.equal(assessment.dimensions.documentQuality.status, "failed");
    assert.equal(assessment.dimensions.documentQuality.assessmentVersion, 4);
    assert.equal(assessment.dimensions.documentQuality.coverage.declarationCount, 1);
    assert.equal(assessment.dimensions.rest.status, "passed");
    assert.equal(assessment.dimensions.downstream.status, "passed");
    assert.equal(assessment.dimensions.compliance.status, "passed");
    assert.equal(assessment.safety.status, "passed");
    const finding = assessment.dimensions.documentQuality.findings[0];
    assert.equal(finding.declarationId, "declaration-1");
    assert.match(finding.actual, /returned no nonempty documentation/);
    assert.equal(finding.sources[0].id, "source-1");
    assert.equal(finding.sources[0].path, "specification/a/main.tsp");
    assert.equal(finding.sources[0].hunks, undefined);
    const html = renderAssessmentHtml(assessment);
    assert.match(html, /Documentation Completeness/);
    assert.match(html, /Missing documentation for Contoso\.Widget/);
    fs.rmSync(path.join(work, "dimensions", "document-quality-input.json"));
    const legacy = assembleAssessment({ work, judgment });
    assert.deepEqual(validateAssessment(legacy), []);
    assert.equal(legacy.dimensions.documentQuality.status, "not-assessed");
    assert.equal(Object.keys(legacy.dimensions.documentQuality).length, 2);
    assert.doesNotThrow(() => renderAssessmentHtml(legacy));
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test("assembler rejects incomplete candidate coverage", () => {
  const work = fixture();
  assert.throws(
    () =>
      assembleAssessment({
        work,
        judgment: {
          schemaVersion: 2,
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

test("assembler requires inference output for uncovered hunk requests", () => {
  const work = fixture();
  writeJson(path.join(work, "model-input.json"), inferenceModelInput());
  assert.throws(
    () =>
      assembleAssessment({
        work,
        judgment: {
          schemaVersion: 2,
          semanticIntents: [
            {
              reviewUnitId: "semantic-1",
              title: "Change Go client placement",
              summary:
                "The customization changes generated Go client placement.",
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

test("assembler validates and joins inferred candidates", () => {
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
            actual:
              "Widgets operations move to a different generated Go client.",
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
  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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
          rationale:
            "Existing Go callers resolve the operation from a different client.",
        },
      ],
      complianceDecisions: [],
      overallConfidence: "high",
      blockers: [],
    },
  });

  assert.equal(assessment.dimensions.downstream.findings.length, 1);
  assert.equal(
    assessment.dimensions.downstream.findings[0].id,
    "inferred-downstream-1",
  );
  assert.equal(assessment.dimensions.downstream.findings[0].inferred, true);
  assert.deepEqual(
    assessment.dimensions.downstream.findings[0].inferenceRequestIds,
    ["inference-request-1"],
  );
  assert.equal(assessment.dimensions.downstream.findings[0].evidence.length, 1);
  assert.equal(assessment.provenance.inference, "inference.json");
  assert.deepEqual(validateAssessment(assessment), []);
});

test("blocked inference makes scoped safety not assessed", () => {
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
  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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
  assert.equal(assessment.blockers[0].code, "inference-blocked");
  assert.deepEqual(validateAssessment(assessment), []);
});

test("assembler requires and joins active Azure Guidelines evidence", () => {
  const work = fixture();
  const complianceDecisions = addComplianceInput(work);
  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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
  assert.equal(
    assessment.dimensions.compliance.sharedSearch.documents.length,
    2,
  );
  assert.equal(
    assessment.provenance.complianceSearchEvidence,
    "compliance-search-evidence.json",
  );
  assert.deepEqual(assessment.dimensions.semantic.items[0].referenceCategories, ["models-and-enums"]);
  assert.deepEqual(
    assessment.dimensions.compliance.intentAssessments[0].requiredCatalogIds,
    assessment.dimensions.compliance.intentAssessments[0].reviewedCatalogIds,
  );
  const tampered = structuredClone(assessment);
  tampered.dimensions.compliance.intentAssessments[0].reviewedCatalogIds = [];
  assert.ok(validateAssessment(tampered).some((error) => /falsely claims completed review/.test(error)));
  const changedCategories = structuredClone(assessment);
  changedCategories.dimensions.compliance.intentAssessments[0].referenceCategories = ["warnings"];
  assert.ok(validateAssessment(changedCategories).some((error) => /category ownership/.test(error)));
  const changedExcerpt = structuredClone(assessment);
  changedExcerpt.dimensions.compliance.findings[0].applicableGuidance[0].excerpt = "Invented normative guidance.";
  assert.ok(validateAssessment(changedExcerpt).some((error) => /retained normative excerpts/.test(error)));
  assert.deepEqual(validateAssessment(assessment), []);
});

test("failed guidance preserves judgment evidence subsets through assembly and exact final validation", () => {
  const work = fixture();
  const complianceDecisions = addComplianceInput(work);
  const sourcesPath = path.join(work, "source", "source-index.json");
  const sourceIndex = readJson(sourcesPath);
  sourceIndex.sourceChanges.push({
    id: "source-2", path: "specification/a/other.tsp",
    hunks: [{ id: "hunk-2", lines: ["+model Other {}"] }],
    declarations: [{
      id: "declaration-2", kind: "model", qualifiedName: "Contoso.Other",
      hunkIds: ["hunk-2"], source: { revision: "current", startLine: 1, endLine: 1 },
    }],
  });
  writeJson(sourcesPath, sourceIndex);
  const semanticPath = path.join(work, "dimensions", "semantic-intents-input.json");
  const semantic = readJson(semanticPath);
  const modelPath = path.join(work, "model-input.json");
  const model = readJson(modelPath);
  for (const owner of [semantic.reviewUnits[0], model.complianceSearchRequests[0]]) {
    owner.sourceChangeIds.push("source-2");
    owner.hunkIds.push("hunk-2");
    owner.declarationIds.push("declaration-2");
  }
  writeJson(semanticPath, semantic);
  writeJson(modelPath, model);
  const evidencePath = path.join(work, "compliance-search-evidence.json");
  const evidence = readJson(evidencePath);
  evidence.documents[0].guidance.push({
    section: "Other model context", excerpt: "Retained guidance for the other declaration.",
    queryTerms: ["Other"], examples: [], applicableDeclarationIds: ["declaration-2"],
  });
  evidence.inputAccounting = searchInputAccounting(evidence);
  writeJson(evidencePath, evidence);

  const assessment = assembleAssessment({
    work, judgment: { ...documentJudgment(), complianceDecisions },
  });
  const compliance = assessment.dimensions.compliance;
  assert.equal(compliance.intentAssessments[0].decision, "applicable-fail");
  for (const field of ["sourceChangeIds", "hunkIds", "declarationIds"]) {
    assert.deepEqual(compliance.intentAssessments[0][field], complianceDecisions[0][field]);
    assert.deepEqual(compliance.findings[0][field], complianceDecisions[0][field]);
    assert.equal(assessment.dimensions.semantic.items[0][field].length, 2);
  }
  assert.deepEqual(validateAssessment(assessment), []);
  const tampered = structuredClone(assessment);
  tampered.dimensions.compliance.findings[0].declarationIds = [
    ...tampered.dimensions.compliance.findings[0].declarationIds, "declaration-2",
  ];
  assert.ok(validateAssessment(tampered).some((error) => /findings must exactly match/.test(error)));
});

test("assembler treats no applicable guidance as assessed and links its intent", () => {
  const work = fixture();
  const complianceDecisions = addComplianceInput(work);
  const evidencePath = path.join(work, "compliance-search-evidence.json");
  const evidence = readJson(evidencePath);
  for (const document of evidence.documents) {
    document.guidance = [];
    document.noRelevantGuidance = true;
  }
  evidence.inputAccounting.guidanceExcerptsRetained = 0;
  evidence.inputAccounting.guidanceExcerptBytesRetained = 0;
  writeJson(evidencePath, evidence);
  complianceDecisions[0] = {
    reviewUnitId: "semantic-1",
    reviewedCatalogIds: evidence.documents.map((item) => item.catalogId),
    applicableGuidance: [],
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
    declarationIds: ["declaration-1"],
    decision: "no-applicable-guidance",
    actual: "The intent uses a generator-specific decorator.",
    rationale: "None of the fetched documents governs this decorator.",
  };
  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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
  assert.equal(
    assessment.dimensions.compliance.coverage.assessedIntentCount,
    1,
  );
  assert.deepEqual(
    assessment.dimensions.compliance.coverage.unassessedIntentIds,
    [],
  );
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

test("aggregates direct SDK deltas by method without REST operation links", () => {
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
  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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

  assert.equal(assessment.dimensions.downstream.methodGroups.length, 1);
  assert.equal(
    assessment.dimensions.downstream.methodGroups[0].deltas.length,
    3,
  );
  assert.equal(
    assessment.dimensions.downstream.methodGroups[0].parametersUnchanged,
    true,
  );
  assert.equal(
    assessment.dimensions.downstream.methodGroups[0].deltas[0].before,
    "basic",
  );
  assert.equal(
    assessment.dimensions.downstream.methodGroups[0].deltas[0].after,
    "lro",
  );
  assert.deepEqual(
    assessment.dimensions.semantic.items[0].relatedFindings.downstream,
    [assessment.dimensions.downstream.methodGroups[0].id],
  );
  assert.deepEqual(validateAssessment(assessment), []);
});

test("assembles changed-only parameters and suppresses URI-template-only LRO deltas", () => {
  const work = fixture();
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
    parameters: [
      ...before.parameters,
      parameter("afcManagedSync", "boolean", true),
    ],
    lro: {
      ...before.lro,
      operation: {
        ...before.lro.operation,
        uriTemplate: "/widgets?api-version,afcManagedSync",
      },
    },
  };
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
  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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

  const group = assessment.dimensions.downstream.methodGroups[0];
  assert.equal(assessment.dimensions.downstream.findings.length, 1);
  assert.equal(group.deltas.length, 1);
  assert.equal(group.deltas[0].field, "parameters");
  assert.equal(group.deltas[0].before, undefined);
  assert.equal(group.deltas[0].after, undefined);
  assert.deepEqual(
    group.deltas[0].changes.added.map((item) => item.parameter),
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
  assert.equal(group.deltas[0].changes.unchangedCount, 3);
  assert.deepEqual(validateAssessment(assessment), []);
});

test("assembles SDK type impacts from deterministic method paths", () => {
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
  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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

  assert.equal(assessment.dimensions.downstream.typeImpacts.length, 1);
  const impact = assessment.dimensions.downstream.typeImpacts[0];
  assert.equal(impact.type, "Contoso.Widget");
  assert.deepEqual(impact.locations, ["response-body"]);
  assert.deepEqual(
    impact.affectedMethods.map((item) => item.symbol),
    ["Contoso.Widgets.get"],
  );
  assert.deepEqual(
    assessment.dimensions.semantic.items[0].relatedFindings.typeImpact,
    [impact.id],
  );
  assert.deepEqual(validateAssessment(assessment), []);
});

test("uses only version-governance hunks for legacy publication operations", () => {
  const work = fixture();
  const manifestPath = path.join(work, "preparation-manifest.json");
  const manifest = readJson(manifestPath);
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
  const sourceIndex = readJson(sourceIndexPath);
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
  const semanticPath = path.join(
    work,
    "dimensions",
    "semantic-intents-input.json",
  );
  const semantic = readJson(semanticPath);
  semantic.facts["operation-1"].projectId = "project-1";
  semantic.reviewUnits[0].sourceChangeIds = ["source-1", "source-unrelated"];
  semantic.reviewUnits[0].hunkIds = ["hunk-1", "hunk-unrelated"];
  semantic.reviewUnits[0].groupingEvidence = {
    reasons: ["cross-project:api-version-publication"],
  };
  writeJson(semanticPath, semantic);

  const assessment = assembleAssessment({
    work,
    judgment: {
      schemaVersion: 2,
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

  const operationSources =
    assessment.dimensions.semantic.items[0].operations[0].sources;
  assert.deepEqual(
    operationSources.map((source) => source.id),
    ["source-1"],
  );
  assert.deepEqual(
    operationSources[0].hunks.map((hunk) => hunk.id),
    ["hunk-1"],
  );
});

test("matches type findings to semantic intents by changed declaration identity", () => {
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

  const matches = matchTypeFindingIntents(
    {
      crossLanguageDefinitionId: "Storage.File.FileItem",
      evidence: [],
    },
    semanticItems,
  );

  assert.deepEqual(
    matches.map((intent) => intent.id),
    ["semantic-file-items"],
  );
});
