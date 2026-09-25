import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { readJson, writeJson } from "./cli.mjs";
import { finalizeAssessment } from "./finalize-assessment.mjs";

/** @typedef {{dimensions: {semantic: {items: unknown[]}}}} FinalAssessment */
/** @typedef {import("./assessment-judgment.schema.js").TypeSpecAssessmentJudgment} AssessmentJudgment */
/** @typedef {{state: string, failure: {code: string}}} TestWorkflowState */

function fixture() {
  const work = fs.mkdtempSync(path.join(os.tmpdir(), "finalize-assessment-"));
  writeJson(path.join(work, "preparation-manifest.json"), {
    schemaVersion: 1,
    repository: { root: "repo" },
    comparison: {
      baseRef: "main",
      mergeBaseCommit: "base",
      headCommit: "head",
      workingTree: {},
    },
    changedFiles: [{ path: "specification/a/main.tsp", origins: ["committed"] }],
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
        declarations: [],
      },
    ],
  });
  writeJson(path.join(work, "dimensions", "semantic-intents-input.json"), {
    status: "ready",
    facts: {},
    reviewUnits: [
      {
        id: "semantic-1",
        action: "add",
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        operationIds: [],
      },
    ],
    blockers: [],
  });
  writeJson(path.join(work, "dimensions", "rest-breaking-input.json"), {
    status: "ready",
    facts: {},
    candidates: [],
    blockers: [],
  });
  writeJson(path.join(work, "dimensions", "downstream-breaking-input.json"), {
    status: "ready",
    facts: {},
    candidates: [],
    rootCauses: [],
    blockers: [],
  });
  writeJson(path.join(work, "model-input.json"), {
    schemaVersion: 1,
    semanticReviewUnits: [{ reviewUnitId: "semantic-1" }],
    restCandidates: [],
    downstreamCandidates: [],
    inferenceRequests: [],
    inputAccounting: {},
  });
  writeJson(path.join(work, "assessment-judgment.json"), {
    schemaVersion: 1,
    semanticIntents: [
      {
        reviewUnitId: "semantic-1",
        title: "Add Widget",
        summary: "Adds the Widget model.",
      },
    ],
    restDecisions: [],
    downstreamDecisions: [],
    complianceDecisions: [],
    overallConfidence: "high",
    blockers: [],
  });
  return work;
}

void test("guarded finalization writes only validated complete artifacts", () => {
  const work = fixture();
  try {
    const first = finalizeAssessment({ work });
    assert.ok(fs.existsSync(first.assessmentPath));
    assert.ok(fs.existsSync(first.reportPath));
    assert.equal(Number.isInteger(first.finalizationMs), true);
    assert.ok(first.finalizationMs >= 0);
    const assessment = /** @type {FinalAssessment} */ (readJson(first.assessmentPath));
    assert.equal(assessment.dimensions.semantic.items.length, 1);
    assert.equal(
      /** @type {TestWorkflowState} */ (readJson(path.join(work, "workflow-state.json"))).state,
      "complete",
    );
    const second = finalizeAssessment({ work });
    assert.ok(fs.existsSync(second.assessmentPath));
    assert.equal(
      /** @type {TestWorkflowState} */ (readJson(path.join(work, "workflow-state.json"))).state,
      "complete",
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("invalid Agent output leaves a correction-ready workflow state", () => {
  const work = fixture();
  try {
    const judgmentPath = path.join(work, "assessment-judgment.json");
    const judgment = /** @type {AssessmentJudgment} */ (readJson(judgmentPath));
    judgment.semanticIntents[0].title = "";
    writeJson(judgmentPath, judgment);
    assert.throws(() => finalizeAssessment({ work }), /incomplete/);
    assert.equal(fs.existsSync(path.join(work, "assessment.json")), false);
    const state = /** @type {TestWorkflowState} */ (
      readJson(path.join(work, "workflow-state.json"))
    );
    assert.equal(state.state, "awaiting-agent-judgment");
    assert.equal(state.failure.code, "finalization-failed");
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});
