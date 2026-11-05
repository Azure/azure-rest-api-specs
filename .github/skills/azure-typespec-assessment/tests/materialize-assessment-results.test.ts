import { assert, test } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { buildAgentWorkspace } from "../scripts/build-agent-workspace.ts";
import { readJson, writeJson } from "../scripts/cli.ts";
import {
  materializeAssessmentResults,
  validateCompactDecisions,
} from "../scripts/materialize-assessment-results.ts";

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
  assessmentMode = "full",
}: { inference?: boolean; assessmentMode?: "full" | "fast" } = {}) {
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
  buildAgentWorkspace({ work });
  return work;
}

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
