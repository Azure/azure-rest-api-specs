import { assert, test } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import {
  verifyAssessmentRuntime,
  verifyRuntimePhaseProvenance,
} from "../scripts/assessment-runtime.ts";
import { buildAgentWorkspace } from "../scripts/build-agent-workspace.ts";
import { buildSourceAssociation } from "../scripts/source-association.ts";
import { finalizeAssessment } from "../scripts/finalize-assessment.ts";
import { readJson, writeJson } from "../scripts/cli.ts";
import {
  materializeSourceReviews,
  materializeAssessmentResults,
  validateCompactDecisions,
} from "../scripts/materialize-assessment-results.ts";
import { readWorkflowState } from "../scripts/workflow-state.ts";

type CatalogScore = import("../scripts/agent-decisions.schema.js").CatalogScore;

type FetchedDocument = import("../scripts/agent-decisions.schema.js").FetchedDocument;

type AssessmentJudgment =
  import("../scripts/assessment-judgment.schema.js").TypeSpecAssessmentJudgment;

type ComplianceSearchEvidence =
  import("../scripts/compliance-search-evidence.schema.js").TypeSpecAzureGuidelinesSearchEvidence;

type AssessmentModelInput = import("../scripts/runtime-types.ts").AssessmentModelInput;

type TestAgentDecisions = {
  catalogScores: CatalogScore[];
  fetchedDocuments: FetchedDocument[];
  overallConfidence: "high" | "medium" | "low";
  [key: string]: unknown;
};

function fixture({
  inference = false,
  pipelineVersion,
  assessmentMode = "full",
}: {
  inference?: boolean;
  pipelineVersion?: 2;
  assessmentMode?: "full" | "fast";
} = {}) {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".materializer & ' test-"));
  writeJson(path.join(work, "preparation-manifest.json"), {
    schemaVersion: 1,
    repository: { remoteUrl: "https://github.com/Azure/azure-rest-api-specs" },
    comparison: {
      mergeBaseCommit: "base",
      headCommit: "head",
      baseRef: "main",
      workingTree: { staged: false, unstaged: false, untracked: false },
    },
    projects: [],
    blockers: [],
    changedFiles: [],
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
    status: "ready",
    reviewUnits: [],
    blockers: [],
  });
  writeJson(path.join(work, "model-input.json"), {
    schemaVersion: 2,
    ...(pipelineVersion === 2 ? { pipelineVersion } : {}),
    assessmentMode,
    context: {
      assessmentMode,
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
    ...(pipelineVersion === 2 ? {} : { sourceReviewDeclarations: [], sourceReviewRequests: [] }),
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
  buildAgentWorkspace({ work });
  return work;
}

void test("materializes and freezes judgment without requiring source decisions in pipeline 2", () => {
  const work = fixture({ pipelineVersion: 2 });
  try {
    const model = readJson(path.join(work, "model-input.json")) as AssessmentModelInput;
    model.restCandidates = [{ id: "rest-rejected", evidenceSetId: "evidence-rejected" }];
    model.evidenceSets = {
      "evidence-rejected": {
        sourceChangeIds: [],
        hunkIds: [],
        declarationIds: [],
        evidenceFactIds: [],
      },
    };
    writeJson(path.join(work, "model-input.json"), model);
    writeJson(path.join(work, "dimensions", "rest-breaking-input.json"), {
      status: "ready",
      facts: {},
      blockers: [],
      candidates: [
        {
          id: "rest-rejected",
          rule: "operation-removed",
          defaultSeverity: "high",
          actual: "Removed.",
          expected: "Preserved.",
          sourceChangeIds: [],
          hunkIds: [],
          declarationIds: [],
          evidenceFactIds: [],
          operationIds: ["Example_Get"],
          reviewRequired: true,
          contractChange: { rule: "operation-removed" },
        },
      ],
    });
    buildAgentWorkspace({ work });
    const decisions = completedDecisions(work);
    decisions.restDecisions = [
      { candidateId: "rest-rejected", decision: "reject", rationale: "No confirmed breaking." },
    ];
    assert.equal(decisions.schemaVersion, 2);
    assert.equal("sourceReviews" in decisions, false);
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    const result = materializeAssessmentResults({ work });
    const judgment = readJson(result.judgmentPath) as AssessmentJudgment;
    assert.equal(judgment.pipelineVersion, 2);
    const state = readJson(path.join(work, "workflow-state.json")) as {
      state: string;
      judgmentArtifactHashes: Record<string, string>;
    };
    assert.equal(state.state, "judgment-materialized");
    assert.ok(state.judgmentArtifactHashes["assessment-judgment.json"]);
    assert.equal(fs.existsSync(path.join(work, "source-association.json")), false);
    assert.throws(() => finalizeAssessment({ work }), /source-association-input.json/);
    assert.equal(buildSourceAssociation({ work }).itemCount, 0);
    const finalized = finalizeAssessment({ work });
    assert.equal(fs.existsSync(finalized.reportPath), true);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

function completedDecisions(work: string) {
  const decisions = readJson(
    path.join(work, "agent-workspace", "agent-decisions.draft.json"),
  ) as TestAgentDecisions;
  decisions.catalogScores = decisions.catalogScores.map((score) => ({
    ...score,
    rationale: "No changed semantic intent requires this document.",
  }));
  decisions.fetchedDocuments = decisions.catalogScores.slice(0, 4).map(({ catalogId }) => ({
    catalogId,
    retrievedAt: "2026-09-18T00:00:00.000Z",
    contentHash: `sha256:${"0".repeat(64)}`,
    bytes: 0,
    guidance: [],
    noRelevantGuidance: true,
  }));
  decisions.overallConfidence = "high";
  return decisions;
}

void test("materializes guideline evidence and judgment without inference", () => {
  const work = fixture();
  try {
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), completedDecisions(work));
    const result = materializeAssessmentResults({ work });
    assert.equal(result.inferencePath, null);
    assert.equal(fs.existsSync(path.join(work, "compliance-search-evidence.json")), true);
    const judgment = readJson(result.judgmentPath) as AssessmentJudgment;
    assert.equal(judgment.schemaVersion, 1);
    assert.deepEqual(judgment.complianceDecisions, []);
    const evidence = readJson(
      path.join(work, "compliance-search-evidence.json"),
    ) as ComplianceSearchEvidence;
    assert.lengthOf(evidence.catalogRanking, 0);
    assert.lengthOf(evidence.rankedDocuments, 0);
    assert.equal(evidence.inputAccounting.catalogEntriesScored, 0);
    assert.equal(
      JSON.stringify(readJson(path.join(work, "workflow-state.json"))).includes("guideline"),
      true,
    );
    const runtime = verifyAssessmentRuntime(
      work,
      new URL("../scripts/materialize-assessment-results.ts", import.meta.url).href,
    );
    const provenance = verifyRuntimePhaseProvenance(work, "materialization", runtime);
    assert.deepEqual(provenance.runtime, runtime);
    assert.deepEqual(Object.keys(provenance.outputHashes), [
      "assessment-judgment.json",
      "compliance-search-evidence.json",
    ]);
    assert.deepEqual(readWorkflowState(work)?.runtimePhases?.materialization, provenance);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("the indexed materialization command runs the pinned script with Windows-safe arguments", () => {
  const work = fixture();
  try {
    const { index } = buildAgentWorkspace({ work });
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), completedDecisions(work));
    const { executable, args } = index.materialization.command;
    const result = spawnSync(executable, args, { encoding: "utf8", shell: false });
    assert.equal(result.status, 0, result.stderr);
    assert.ok(fs.existsSync(path.join(work, "assessment-judgment.json")));
    assert.ok(readWorkflowState(work)?.runtimePhases?.materialization);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("materialization rejects a mismatched runtime before changing existing output or decisions", () => {
  const work = fixture();
  try {
    const { index, indexPath } = buildAgentWorkspace({ work });
    const decisionsPath = path.join(work, "agent-workspace", "agent-decisions.json");
    writeJson(decisionsPath, completedDecisions(work));
    const judgmentPath = path.join(work, "assessment-judgment.json");
    fs.writeFileSync(judgmentPath, "existing output");
    const decisions = fs.readFileSync(decisionsPath, "utf8");
    for (const runtime of [
      { ...index.runtime, root: path.join(work, "other-runtime") },
      { ...index.runtime, fingerprint: `sha256:${"0".repeat(64)}` },
    ]) {
      writeJson(indexPath, { ...index, runtime });
      assert.throws(
        () => materializeAssessmentResults({ work }),
        /Assessment runtime tooling error/,
      );
      assert.equal(fs.readFileSync(judgmentPath, "utf8"), "existing output");
      assert.equal(fs.readFileSync(decisionsPath, "utf8"), decisions);
      assert.equal(
        (readWorkflowState(work)?.failure as { code: string } | undefined)?.code,
        "runtime-tooling-error",
      );
      assert.isUndefined(readWorkflowState(work)?.runtimePhases?.materialization);
    }
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("rejects unknown fields in compact decisions", () => {
  assert.throws(
    () =>
      validateCompactDecisions({
        schemaVersion: 1,
        semanticSummaries: [],
        restDecisions: [],
        downstreamDecisions: [],
        catalogScores: [],
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

void test("fast materialization retains inference without guideline search or judgment", () => {
  const work = fixture({ assessmentMode: "fast", inference: true });
  try {
    const decisions = completedDecisions(work);
    decisions.inferenceResults = [
      {
        requestId: "inference-request-1",
        decision: "no-impact",
        rationale: "The changed hunk has no REST compatibility impact.",
        candidates: [],
      },
    ];
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    const result = materializeAssessmentResults({ work });
    assert.ok(result.inferencePath);
    assert.deepEqual(readJson(result.inferencePath), {
      schemaVersion: 1,
      results: [
        {
          requestId: "inference-request-1",
          reviewUnitId: "semantic-1",
          hunkId: "hunk-1",
          decision: "no-impact",
          rationale: "The changed hunk has no REST compatibility impact.",
          candidates: [],
        },
      ],
    });
    const judgment = readJson(result.judgmentPath) as AssessmentJudgment;
    assert.deepEqual(judgment.complianceDecisions, []);
    const evidence = readJson(result.guidelineEvidencePath) as ComplianceSearchEvidence;
    assert.deepEqual(evidence.queryProfiles, []);
    assert.lengthOf(evidence.catalogRanking, 0);
    assert.deepEqual(evidence.rankedDocuments, []);
    assert.deepEqual(evidence.retrievalAttempts, []);
    assert.deepEqual(evidence.blockers, []);
    assert.equal(evidence.inputAccounting.catalogEntriesScored, 0);
    assert.equal(evidence.inputAccounting.documentsFetched, 0);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

test.each([
  "catalogScores",
  "fetchedDocuments",
  "failedRetrievals",
  "searchBlockers",
  "complianceJudgments",
])("fast materialization rejects nonempty %s", (field) => {
  const work = fixture({ assessmentMode: "fast" });
  try {
    const decisions = completedDecisions(work);
    Reflect.set(
      decisions,
      field,
      field === "searchBlockers" ? ["unexpected search"] : [{ catalogId: "unexpected" }],
    );
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), decisions);
    assert.throws(
      () => materializeAssessmentResults({ work }),
      /coverage mismatch|invalid without compliance search requests/,
    );
    assert.isFalse(fs.existsSync(path.join(work, "assessment-judgment.json")));
    assert.isFalse(fs.existsSync(path.join(work, "compliance-search-evidence.json")));
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("rejects changed canonical input before materialization", () => {
  const work = fixture();
  try {
    writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), completedDecisions(work));
    const input = readJson(path.join(work, "model-input.json")) as AssessmentModelInput;
    (input.blockers as unknown[]).push("changed");
    writeJson(path.join(work, "model-input.json"), input);
    assert.throws(
      () => materializeAssessmentResults({ work }),
      /Canonical assessment inputs changed/,
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("source review materialization enforces deterministic selection outcomes", () => {
  const sourceChanges = [
    {
      id: "source-1",
      path: "main.tsp",
      status: "modified",
      origins: [],
      hunks: [],
      declarations: [
        {
          id: "declaration-1",
          kind: "model",
          qualifiedName: "Service.Request",
          decorators: [],
          versionedMembers: [],
          hunkIds: ["hunk-1"],
          source: { revision: "current", startLine: 10, endLine: 14 },
        },
        {
          id: "declaration-2",
          kind: "operation",
          qualifiedName: "Service.create",
          decorators: [],
          versionedMembers: [],
          hunkIds: ["hunk-1"],
          source: { revision: "current", startLine: 16, endLine: 18 },
        },
      ],
    },
  ] as import("../scripts/runtime-types.ts").SourceChange[];
  const modelInput = {
    sourceReviewDeclarations: [
      {
        declarationId: "declaration-1",
        sourceChangeId: "source-1",
        qualifiedName: "Service.Request",
        kind: "model",
        revision: "current",
        startLine: 10,
        endLine: 14,
        hunkIds: ["hunk-1"],
      },
      {
        declarationId: "declaration-2",
        sourceChangeId: "source-1",
        qualifiedName: "Service.create",
        kind: "operation",
        revision: "current",
        startLine: 16,
        endLine: 18,
        hunkIds: ["hunk-1"],
      },
    ],
    sourceReviewRequests: [
      {
        candidateId: "rest-1",
        dimension: "rest",
        evidenceSetId: "evidence-1",
        deterministicStatus: "associated",
        deterministicDeclarationIds: ["declaration-1"],
        availableDeclarationIds: ["declaration-1", "declaration-2"],
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
      },
    ],
  } as AssessmentModelInput;
  const decisions = [
    {
      candidateId: "rest-1",
      decision: "approve" as const,
      severity: "high" as const,
      rationale: "Breaking.",
    },
  ];

  const kept = materializeSourceReviews(
    [
      {
        candidateId: "rest-1",
        outcome: "keep",
        selectedDeclarationIds: ["declaration-1"],
        rationale: "The deterministic request model is complete.",
      },
    ],
    decisions,
    modelInput,
    [],
    sourceChanges,
  );
  assert.deepEqual(
    kept.get("rest-1")?.selectedDeclarations.map((item) => item.qualifiedName),
    ["Service.Request"],
  );

  const refined = materializeSourceReviews(
    [
      {
        candidateId: "rest-1",
        outcome: "refine",
        selectedDeclarationIds: ["declaration-1", "declaration-2"],
        rationale: "The operation makes the request model use clear.",
      },
    ],
    decisions,
    modelInput,
    [],
    sourceChanges,
  );
  assert.equal(refined.get("rest-1")?.selectedDeclarations.length, 2);

  assert.throws(
    () =>
      materializeSourceReviews(
        [
          {
            candidateId: "rest-1",
            outcome: "associate",
            selectedDeclarationIds: ["declaration-2"],
            rationale: "Invalid replacement.",
          },
        ],
        decisions,
        modelInput,
        [],
        sourceChanges,
      ),
    /must use refine/,
  );
  assert.throws(
    () =>
      materializeSourceReviews(
        [
          {
            candidateId: "rest-1",
            outcome: "keep",
            selectedDeclarationIds: ["declaration-2"],
            rationale: "Wrong deterministic set.",
          },
        ],
        decisions,
        modelInput,
        [],
        sourceChanges,
      ),
    /deterministic proposal coverage mismatch/,
  );
});
