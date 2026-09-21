import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import { buildAgentWorkspace } from "./build-agent-workspace.mjs";
import { readJson, writeJson } from "./cli.mjs";
import { assembleCompliance, readComplianceCatalog } from "./compliance-assessment.mjs";
import {
  materializeAssessmentResults,
  validateCompactDecisions,
} from "./materialize-assessment-results.mjs";

function fixture({ inference = false, guidelineCount = 0 } = {}) {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".materializer-test-"));
  writeJson(path.join(work, "preparation-manifest.json"), {
    comparison: {
      mergeBaseCommit: "base",
      headCommit: "head",
      baseRef: "main",
      workingTree: { staged: false, unstaged: false, untracked: false },
    },
    projects: [],
  });
  writeJson(path.join(work, "source", "source-index.json"), {
    sourceChanges: [],
  });
  writeJson(path.join(work, "dimensions", "semantic-intents-input.json"), {
    status: "ready",
    reviewUnits: [],
    facts: {},
    blockers: [],
  });
  writeJson(path.join(work, "dimensions", "rest-breaking-input.json"), {
    status: "ready",
    candidates: [],
    facts: {},
    blockers: [],
  });
  writeJson(path.join(work, "dimensions", "downstream-breaking-input.json"), {
    status: "ready",
    candidates: [],
    facts: {},
    blockers: [],
  });
  writeJson(path.join(work, "dimensions", "document-quality-input.json"), {
    schemaVersion: 4,
    reviewUnits: [],
    blockers: [],
  });
  writeJson(path.join(work, "model-input.json"), {
    schemaVersion: 2,
    context: {
      sourceComparison: {
        baseCommit: "base",
        headCommit: "head",
        baseRef: "main",
        workingTree: { staged: false, unstaged: false, untracked: false },
      },
      projects: [],
    },
    artifactReferences: {
      sourceIndex: "source/source-index.json",
      semanticReviewUnits: "dimensions/semantic-intents-input.json",
      restCandidates: "dimensions/rest-breaking-input.json",
      downstreamCandidates: "dimensions/downstream-breaking-input.json",
    },
    evidenceSets: {},
    facts: {},
    semanticReviewUnits: [],
    restCandidates: [],
    downstreamCandidates: [],
    downstreamRootCauses: [],
    complianceSearchRequests: [],
    inferenceRequests: inference
      ? [
          {
            requestId: "inference-request-1",
            reviewUnitId: "semantic-1",
            sourceChangeId: "source-1",
            hunkId: "hunk-1",
            relatedOperationIds: [],
            allowedDimensions: ["rest"],
          },
        ]
      : [],
    blockers: [],
  });
  if (guidelineCount) {
    const selected = readComplianceCatalog().slice(0, guidelineCount);
    const unit = {
      id: "semantic-1", intentType: "normal",
      sourceChangeIds: ["source-1"], hunkIds: ["hunk-1"], declarationIds: ["declaration-1"],
      referenceCategories: ["models-and-enums"],
      referenceCategoryEvidence: [{ category: "models-and-enums", ruleId: "model-declaration", hunkIds: ["hunk-1"], declarationIds: ["declaration-1"], evidence: ["kind:model"] }],
    };
    const request = {
      requestId: "compliance-search-1", reviewUnitId: unit.id,
      sourceChangeIds: unit.sourceChangeIds, hunkIds: unit.hunkIds, declarationIds: unit.declarationIds,
      queryProfile: { servicePlane: "data-plane" }, referenceCategories: unit.referenceCategories,
      guidanceRouting: {
        mandatoryCatalogIds: selected.map((entry) => entry.catalogId),
        selections: selected.map((entry) => ({ catalogId: entry.catalogId, category: "models-and-enums", ruleId: "model-guidance" })),
        discoveryRequests: [],
      },
    };
    writeJson(path.join(work, "source", "source-index.json"), {
      sourceChanges: [{ id: "source-1", path: "main.tsp",
        hunks: [{ id: "hunk-1", lines: ["+model Widget {}"] }],
        declarations: [{ id: "declaration-1", qualifiedName: "Widget", hunkIds: ["hunk-1"], source: { startLine: 1, endLine: 1 } }],
      }],
    });
    writeJson(path.join(work, "dimensions", "semantic-intents-input.json"), {
      status: "ready", reviewUnits: [unit], facts: {}, blockers: [],
    });
    writeJson(path.join(work, "dimensions", "compliance-search-requests.json"), { requests: [request] });
    const model = readJson(path.join(work, "model-input.json"));
    model.artifactReferences.complianceSearchRequests = "dimensions/compliance-search-requests.json";
    model.evidenceSets["evidence-set-1"] = { evidenceFactIds: [] };
    model.semanticReviewUnits = [{ reviewUnitId: unit.id, referenceCategories: unit.referenceCategories, evidenceSetId: "evidence-set-1" }];
    model.complianceSearchRequests = [{ ...request, evidenceSetId: "evidence-set-1" }];
    writeJson(path.join(work, "model-input.json"), model);
  }
  buildAgentWorkspace({ work });
  return work;
}

function completedDecisions(work) {
  const decisions = readJson(
    path.join(work, "agent-workspace", "agent-decisions.draft.json"),
  );
  decisions.overallConfidence = "high";
  decisions.semanticSummaries.forEach((item) => { item.title = "Update Widget"; item.summary = "Change the Widget model."; });
  const model = readJson(path.join(work, "model-input.json"));
  const selected = [...new Set(model.complianceSearchRequests.flatMap((request) => request.guidanceRouting.mandatoryCatalogIds))];
  decisions.fetchedDocuments = selected.map((catalogId) => ({
    catalogId, retrievalSource: "session-reuse", retrievedAt: "2026-09-18T00:00:00.000Z",
    contentHash: `sha256:${"a".repeat(64)}`, bytes: 100,
    guidance: [], noRelevantGuidance: true,
  }));
  decisions.complianceJudgments.forEach((item) => {
    item.reviewedCatalogIds = [...selected];
    item.decision = "no-applicable-guidance";
    item.actual = "The model changed.";
    item.rationale = "No governing guidance in the reviewed sections.";
  });
  return decisions;
}

function configureVersionEvolution(work, changedTokens = ["@list"]) {
  const evolving = readComplianceCatalog().find(
    (entry) => entry.title === "Evolving APIs",
  );
  assert.ok(evolving);
  const requestFile = path.join(
    work,
    "dimensions",
    "compliance-search-requests.json",
  );
  const requestArtifact = readJson(requestFile);
  const request = requestArtifact.requests[0];
  request.referenceCategories = ["api-versioning"];
  request.queryProfile = {
    ...request.queryProfile,
    action: "modify",
    changedTokens,
  };
  request.guidanceRouting = {
    mandatoryCatalogIds: [evolving.catalogId],
    selections: [
      {
        catalogId: evolving.catalogId,
        category: "api-versioning",
        ruleId: "versioned-api-evolution-guidance",
      },
    ],
    discoveryRequests: [],
  };
  writeJson(requestFile, requestArtifact);

  const semanticFile = path.join(
    work,
    "dimensions",
    "semantic-intents-input.json",
  );
  const semantic = readJson(semanticFile);
  semantic.reviewUnits[0].referenceCategories = ["api-versioning"];
  writeJson(semanticFile, semantic);

  const modelFile = path.join(work, "model-input.json");
  const model = readJson(modelFile);
  model.semanticReviewUnits[0].referenceCategories = ["api-versioning"];
  model.complianceSearchRequests[0] = {
    ...request,
    evidenceSetId: "evidence-set-1",
  };
  writeJson(modelFile, model);
  buildAgentWorkspace({ work });
  return evolving;
}

function configureLegacyUsage(
  work,
  {
    action = "add",
    changedTokens = [
      "Azure.ResourceManager.Legacy.RoutedOperations",
      "ConnectionAnalyzerOps.ActionAsync",
    ],
  } = {},
) {
  const standard = readComplianceCatalog().find(
    (entry) => entry.title === "ARM resource operations",
  );
  assert.ok(standard);
  const requestFile = path.join(
    work,
    "dimensions",
    "compliance-search-requests.json",
  );
  const requestArtifact = readJson(requestFile);
  const request = requestArtifact.requests[0];
  request.referenceCategories = ["arm-resource-operation"];
  request.queryProfile = {
    ...request.queryProfile,
    action,
    declarationKinds: ["operation"],
    changedTokens,
  };
  request.guidanceRouting = {
    mandatoryCatalogIds: [standard.catalogId],
    selections: [
      {
        catalogId: standard.catalogId,
        category: "arm-resource-operation",
        ruleId: "arm-operation-template-guidance",
      },
    ],
    discoveryRequests: [],
  };
  writeJson(requestFile, requestArtifact);

  const semanticFile = path.join(
    work,
    "dimensions",
    "semantic-intents-input.json",
  );
  const semantic = readJson(semanticFile);
  semantic.reviewUnits[0].referenceCategories = ["arm-resource-operation"];
  writeJson(semanticFile, semantic);

  const modelFile = path.join(work, "model-input.json");
  const model = readJson(modelFile);
  model.semanticReviewUnits[0].referenceCategories = [
    "arm-resource-operation",
  ];
  model.complianceSearchRequests[0] = {
    ...request,
    evidenceSetId: "evidence-set-1",
  };
  writeJson(modelFile, model);
  buildAgentWorkspace({ work });
  return standard;
}

test("materializes guideline evidence and judgment without inference", () => {
  const work = fixture();
  try {
    writeJson(
      path.join(work, "agent-workspace", "agent-decisions.json"),
      completedDecisions(work),
    );
    const result = materializeAssessmentResults({ work });
    assert.equal(result.inferencePath, null);
    assert.equal(
      fs.existsSync(path.join(work, "compliance-search-evidence.json")),
      true,
    );
    const judgment = readJson(result.judgmentPath);
    assert.equal(judgment.schemaVersion, 2);
    assert.deepEqual(judgment.complianceDecisions, []);
    const evidence = readJson(
      path.join(work, "compliance-search-evidence.json"),
    );
    assert.equal(evidence.schemaVersion, 3);
    assert.deepEqual(evidence.documentSelections, []);
    assert.deepEqual(evidence.documents, []);
    assert.equal(evidence.inputAccounting.uniqueDocumentsSelected, 0);
    assert.equal(
      JSON.stringify(readJson(path.join(work, "workflow-state.json"))).includes(
        "guideline",
      ),
      true,
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test("rejects unknown fields in compact decisions", () => {
  assert.throws(
    () =>
      validateCompactDecisions({
        schemaVersion: 2,
        semanticSummaries: [],
        restDecisions: [],
        downstreamDecisions: [],
        discoveryResults: [],
        additionalSelections: [],
        fetchedDocuments: [],
        failedRetrievals: [],
        searchBlockers: [],
        complianceJudgments: [],
        overallConfidence: "high",
        blockers: [],
        complianceDecisions: [],
      }),
    /unknown fields: complianceDecisions/,
  );
});

test("rejects changed canonical input before materialization", () => {
  const work = fixture();
  try {
    writeJson(
      path.join(work, "agent-workspace", "agent-decisions.json"),
      completedDecisions(work),
    );
    const input = readJson(path.join(work, "model-input.json"));
    input.blockers.push("changed");
    writeJson(path.join(work, "model-input.json"), input);
    assert.throws(
      () => materializeAssessmentResults({ work }),
      /Canonical assessment inputs changed/,
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

for (const count of [1, 6]) {
  test(`offline materializer accepts ${count} selected documents and preserves reused provenance`, () => {
    const work = fixture({ guidelineCount: count });
    try {
      const decisions = completedDecisions(work);
      writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
      const result = materializeAssessmentResults({ work });
      const evidence = readJson(result.guidelineEvidencePath);
      assert.equal(evidence.documents.length, count);
      assert.equal(evidence.inputAccounting.documentBytesFetched, 0);
      assert.equal(evidence.inputAccounting.documentsReused, count);
      assert.equal(evidence.documents[0].retrieval.retrievedAt, decisions.fetchedDocuments[0].retrievedAt);
      assert.equal(evidence.documents[0].retrieval.contentHash, decisions.fetchedDocuments[0].contentHash);
      assert.deepEqual(readJson(result.judgmentPath).complianceDecisions[0].reviewedCatalogIds, decisions.complianceJudgments[0].reviewedCatalogIds);
    } finally {
      fs.rmSync(work, { recursive: true, force: true });
    }
  });
}

test("offline materializer rejects false mandatory completion without writing results", () => {
  const work = fixture({ guidelineCount: 1 });
  try {
    const decisions = completedDecisions(work);
    decisions.complianceJudgments[0].reviewedCatalogIds = [];
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    assert.throws(() => materializeAssessmentResults({ work }), /falsely claims completed review/);
    assert.equal(fs.existsSync(path.join(work, "assessment-judgment.json")), false);
    decisions.complianceJudgments[0].decision = "not-assessed";
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    materializeAssessmentResults({ work });
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test("category annotation and routing remain protected by canonical hashes", () => {
  for (const artifact of ["semantic-intents-input.json", "compliance-search-requests.json"]) {
    const work = fixture({ guidelineCount: 1 });
    try {
      writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), completedDecisions(work));
      const file = path.join(work, "dimensions", artifact);
      const content = readJson(file);
      (content.reviewUnits ?? content.requests)[0].referenceCategories = ["warnings"];
      writeJson(file, content);
      assert.throws(() => materializeAssessmentResults({ work }), /Canonical assessment inputs changed/);
    } finally {
      fs.rmSync(work, { recursive: true, force: true });
    }
  }
});

test("v1 ranked decisions require rerunning the new contract", () => {
  assert.throws(() => validateCompactDecisions({ schemaVersion: 1, catalogScores: [] }), /rerun deterministic analysis/);
});

test("canonical classification diagnostics block the owner even without tagged discovery records", () => {
  const work = fixture({ guidelineCount: 1 });
  try {
    const file = path.join(work, "dimensions", "semantic-intents-input.json");
    const semantic = readJson(file);
    semantic.referenceCategoryDiagnostics = [{
      reviewUnitId: "semantic-1", code: "reference-service-plane-conflicting",
      message: "Canonical plane evidence conflicts.", hunkIds: ["hunk-1"], declarationIds: ["declaration-1"],
    }];
    writeJson(file, semantic);
    buildAgentWorkspace({ work });
    const decisions = completedDecisions(work);
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    assert.throws(() => materializeAssessmentResults({ work }), /reference-service-plane-conflicting/);
    decisions.complianceJudgments[0].decision = "not-assessed";
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    materializeAssessmentResults({ work });
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test("materializer derives guidance ownership only from citing intent declarations", () => {
  const work = fixture({ guidelineCount: 1 });
  try {
    const decisions = completedDecisions(work);
    decisions.fetchedDocuments[0].guidance = [{
      section: "Models", excerpt: "Models define named properties.", queryTerms: ["model"], examples: [],
      applicableDeclarationIds: ["declaration-fabricated"],
    }];
    decisions.fetchedDocuments[0].noRelevantGuidance = false;
    Object.assign(decisions.complianceJudgments[0], {
      decision: "applicable-pass", expected: "Models define named properties.",
      applicableGuidance: [{ catalogId: decisions.fetchedDocuments[0].catalogId, guidanceSection: "Models" }],
    });

    test("existing-version evolution requires Evolving APIs and fails without a changed versioning decorator", () => {
      const work = fixture({ guidelineCount: 1 });
      try {
        const evolving = configureVersionEvolution(work);
        const decisions = completedDecisions(work);
        decisions.fetchedDocuments[0].guidance = [{
          section: "Evolving APIs",
          excerpt: "Use versioning decorators to evolve APIs without breaking existing clients.",
          queryTerms: ["versioning decorators"],
          examples: [],
        }];
        decisions.fetchedDocuments[0].noRelevantGuidance = false;
        Object.assign(decisions.complianceJudgments[0], {
          decision: "applicable-pass",
          expected: "Use versioning decorators to evolve APIs without breaking existing clients.",
          applicableGuidance: [{
            catalogId: evolving.catalogId,
            guidanceSection: "Evolving APIs",
          }],
        });
        writeJson(
          path.join(work, "agent-workspace", "agent-decisions.json"),
          decisions,
        );
        assert.throws(
          () => materializeAssessmentResults({ work }),
          /must fail existing-version evolution without a changed versioning decorator/,
        );

        Object.assign(decisions.complianceJudgments[0], {
          decision: "applicable-fail",
          title: "Existing-version behavior changed without versioning",
          severity: "medium",
        });
        writeJson(
          path.join(work, "agent-workspace", "agent-decisions.json"),
          decisions,
        );
        assert.doesNotThrow(() => materializeAssessmentResults({ work }));
      } finally {
        fs.rmSync(work, { recursive: true, force: true });
      }
    });

    test("versioned API evolution requires the Evolving APIs citation", () => {
      const work = fixture({ guidelineCount: 1 });
      try {
        configureVersionEvolution(work, ["@added"]);
        const decisions = completedDecisions(work);
        decisions.complianceJudgments[0].decision = "applicable-pass";
        decisions.complianceJudgments[0].expected = "The change is versioned.";
        decisions.complianceJudgments[0].applicableGuidance = [];
        writeJson(
          path.join(work, "agent-workspace", "agent-decisions.json"),
          decisions,
        );
        assert.throws(
          () => materializeAssessmentResults({ work }),
          /must apply Evolving APIs guidance/,
        );
      } finally {
        fs.rmSync(work, { recursive: true, force: true });
      }
    });

    test("new declarations using legacy ARM constructs require a failed standard-guidance decision", () => {
      const work = fixture({ guidelineCount: 1 });
      try {
        const standard = configureLegacyUsage(work, {
          changedTokens: [
            "@Azure.ResourceManager.Legacy.customAzureResource",
            "Azure.ResourceManager.Legacy.RoutedOperations",
            "ConnectionAnalyzerOps.ActionAsync",
            "@suppress",
          ],
        });
        const decisions = completedDecisions(work);
        decisions.fetchedDocuments[0].guidance = [{
          section: "Standard ARM operations",
          excerpt: "Use the standard ARM lifecycle templates for resource operations.",
          queryTerms: ["standard ARM lifecycle templates"],
          examples: [],
        }];
        decisions.fetchedDocuments[0].noRelevantGuidance = false;
        Object.assign(decisions.complianceJudgments[0], {
          decision: "applicable-pass",
          expected: "Use standard ARM templates.",
          applicableGuidance: [{
            catalogId: standard.catalogId,
            guidanceSection: "Standard ARM operations",
          }],
        });
        writeJson(
          path.join(work, "agent-workspace", "agent-decisions.json"),
          decisions,
        );
        assert.throws(
          () => materializeAssessmentResults({ work }),
          /must fail new declarations that use Azure\.ResourceManager\.Legacy constructs/,
        );

        Object.assign(decisions.complianceJudgments[0], {
          decision: "applicable-fail",
          title: "New operation uses a legacy ARM template",
          severity: "medium",
        });
        writeJson(
          path.join(work, "agent-workspace", "agent-decisions.json"),
          decisions,
        );
        assert.doesNotThrow(() => materializeAssessmentResults({ work }));
      } finally {
        fs.rmSync(work, { recursive: true, force: true });
      }
    });

    test("the new-legacy rule does not flag modification of an existing legacy declaration", () => {
      const work = fixture({ guidelineCount: 1 });
      try {
        configureLegacyUsage(work, { action: "modify" });
        writeJson(
          path.join(work, "agent-workspace", "agent-decisions.json"),
          completedDecisions(work),
        );
        assert.doesNotThrow(() => materializeAssessmentResults({ work }));
      } finally {
        fs.rmSync(work, { recursive: true, force: true });
      }
    });

    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    const result = materializeAssessmentResults({ work });
    assert.deepEqual(readJson(result.guidelineEvidencePath).documents[0].guidance[0].applicableDeclarationIds, ["declaration-1"]);
    decisions.complianceJudgments[0].declarationNames = ["Foreign.Model"];
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    assert.throws(() => materializeAssessmentResults({ work }), /unknown declaration name/);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test("materialized failed guidance retains the selected declaration subset in intent and finding", () => {
  const work = fixture({ guidelineCount: 1 });
  try {
    const sourceFile = path.join(work, "source", "source-index.json");
    const sourceIndex = readJson(sourceFile);
    sourceIndex.sourceChanges[0].declarations.push({
      id: "declaration-2", qualifiedName: "Other", hunkIds: ["hunk-1"],
      source: { startLine: 2, endLine: 2 },
    });
    writeJson(sourceFile, sourceIndex);
    for (const [relative, collection] of [
      ["dimensions\\semantic-intents-input.json", "reviewUnits"],
      ["dimensions\\compliance-search-requests.json", "requests"],
      ["model-input.json", "complianceSearchRequests"],
    ]) {
      const file = path.join(work, relative);
      const artifact = readJson(file);
      artifact[collection][0].declarationIds.push("declaration-2");
      writeJson(file, artifact);
    }
    buildAgentWorkspace({ work });
    const decisions = completedDecisions(work);
    decisions.fetchedDocuments[0].guidance = [{
      section: "Models", excerpt: "Models define named properties.",
      queryTerms: ["model"], examples: [],
    }];
    decisions.fetchedDocuments[0].noRelevantGuidance = false;
    Object.assign(decisions.complianceJudgments[0], {
      declarationNames: ["Widget"], decision: "applicable-fail",
      title: "Widget contradicts model guidance", severity: "medium",
      expected: "Models define named properties.",
      applicableGuidance: [{ catalogId: decisions.fetchedDocuments[0].catalogId, guidanceSection: "Models" }],
    });
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    const result = materializeAssessmentResults({ work });
    const judgment = readJson(result.judgmentPath);
    assert.deepEqual(judgment.complianceDecisions[0].declarationIds, ["declaration-1"]);
    const compliance = assembleCompliance({
      requests: readJson(path.join(work, "dimensions", "compliance-search-requests.json")).requests,
      evidence: readJson(result.guidelineEvidencePath),
      decisions: judgment.complianceDecisions,
      sourceChanges: sourceIndex.sourceChanges,
    });
    assert.deepEqual(compliance.intentAssessments[0].declarationIds, ["declaration-1"]);
    assert.deepEqual(compliance.findings[0].declarationIds, ["declaration-1"]);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test("declaration names resolve a canonical revision pair but reject same-revision ambiguity", () => {
  for (const baselineRevision of ["base", "current"]) {
    const work = fixture({ guidelineCount: 1 });
    try {
      const sourceFile = path.join(work, "source", "source-index.json");
      const sources = readJson(sourceFile);
      const current = sources.sourceChanges[0].declarations[0];
      current.kind = "model";
      current.source.revision = "current";
      sources.sourceChanges[0].declarations.push({
        ...structuredClone(current), id: "declaration-base",
        source: { ...current.source, revision: baselineRevision },
      });
      writeJson(sourceFile, sources);
      for (const [relative, collection] of [
        ["dimensions\\semantic-intents-input.json", "reviewUnits"],
        ["dimensions\\compliance-search-requests.json", "requests"],
        ["model-input.json", "complianceSearchRequests"],
      ]) {
        const file = path.join(work, relative);
        const artifact = readJson(file);
        artifact[collection][0].declarationIds.push("declaration-base");
        writeJson(file, artifact);
      }
      buildAgentWorkspace({ work });
      const decisions = completedDecisions(work);
      assert.deepEqual(decisions.complianceJudgments[0].declarationNames, ["Widget"]);
      writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
      if (baselineRevision === "base") {
        const result = materializeAssessmentResults({ work });
        assert.deepEqual(readJson(result.judgmentPath).complianceDecisions[0].declarationIds, ["declaration-1", "declaration-base"]);
      } else {
        assert.throws(() => materializeAssessmentResults({ work }), /ambiguous declaration name Widget/);
      }
    } finally {
      fs.rmSync(work, { recursive: true, force: true });
    }
  }
});
