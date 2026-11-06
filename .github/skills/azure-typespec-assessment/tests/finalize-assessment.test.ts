import { assert, test } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import {
  createRuntimePhaseProvenance,
  verifyAssessmentRuntime,
  verifyRuntimePhaseProvenance,
} from "../scripts/assessment-runtime.ts";
import { buildAgentWorkspace } from "../scripts/build-agent-workspace.ts";
import { readJson, writeJson } from "../scripts/cli.ts";
import { readComplianceCatalog } from "../scripts/compliance-assessment.ts";
import { finalizeAssessment } from "../scripts/finalize-assessment.ts";
import { materializeAssessmentResults } from "../scripts/materialize-assessment-results.ts";
import { readWorkflowState, transitionWorkflowState } from "../scripts/workflow-state.ts";

type FinalAssessment = {
  dimensions: {
    semantic: {
      items: unknown[];
    };
  };
};

type AssessmentJudgment =
  import("../scripts/assessment-judgment.schema.js").TypeSpecAssessmentJudgment;

type TestWorkflowState = {
  state: string;
  failure: {
    code: string;
  };
};

function fixture() {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".finalize & ' test-"));
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
  writeJson(path.join(work, "dimensions", "compliance-search-requests.json"), {
    schemaVersion: 1,
    requests: [
      {
        requestId: "compliance-1",
        reviewUnitId: "semantic-1",
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        declarationIds: [],
        queryProfile: { servicePlane: "data-plane" },
      },
    ],
  });
  writeJson(path.join(work, "model-input.json"), {
    schemaVersion: 1,
    context: { projects: [] },
    artifactReferences: {
      sourceIndex: "source/source-index.json",
      semanticReviewUnits: "dimensions/semantic-intents-input.json",
      restCandidates: "dimensions/rest-breaking-input.json",
      downstreamCandidates: "dimensions/downstream-breaking-input.json",
      complianceSearchRequests: "dimensions/compliance-search-requests.json",
    },
    evidenceSets: {
      "evidence-1": {
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        declarationCount: 0,
        evidenceFactIds: [],
      },
    },
    facts: {},
    semanticReviewUnits: [{ reviewUnitId: "semantic-1", evidenceSetId: "evidence-1" }],
    restCandidates: [],
    downstreamCandidates: [],
    downstreamRootCauses: [],
    complianceSearchRequests: [
      {
        requestId: "compliance-1",
        reviewUnitId: "semantic-1",
        evidenceSetId: "evidence-1",
      },
    ],
    inferenceRequests: [],
    inputAccounting: {},
  });
  buildAgentWorkspace({ work });
  const catalog = readComplianceCatalog();
  writeJson(path.join(work, "agent-workspace", "agent-decisions.json"), {
    schemaVersion: 1,
    semanticSummaries: [
      {
        reviewUnitId: "semantic-1",
        title: "Add Widget",
        summary: "Adds the Widget model.",
      },
    ],
    restDecisions: [],
    downstreamDecisions: [],
    catalogScores: catalog.map(({ catalogId }) => ({
      catalogId,
      exactSymbol: 0,
      patternCategory: 0,
      servicePlane: 0,
      changeContext: 0,
      rationale: "Synthetic test ranks the catalog in its canonical order.",
    })),
    fetchedDocuments: catalog.slice(0, 4).map(({ catalogId }) => ({
      catalogId,
      retrievedAt: "2026-09-18T00:00:00.000Z",
      contentHash: `sha256:${"0".repeat(64)}`,
      bytes: 0,
      guidance: [],
      noRelevantGuidance: true,
    })),
    failedRetrievals: [],
    searchBlockers: [],
    complianceJudgments: [
      {
        reviewUnitId: "semantic-1",
        applicableGuidance: [],
        declarationNames: [],
        decision: "no-applicable-guidance",
        actual: "Adds the synthetic Widget model.",
        rationale: "The synthetic test documents contain no applicable guidance.",
      },
    ],
    overallConfidence: "high",
    blockers: [],
  });
  materializeAssessmentResults({ work });
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
    const assessment = readJson(first.assessmentPath) as FinalAssessment;
    assert.equal(assessment.dimensions.semantic.items.length, 1);
    assert.equal(
      (readJson(path.join(work, "workflow-state.json")) as TestWorkflowState).state,
      "complete",
    );
    const state = readWorkflowState(work);
    assert.deepEqual(state?.runtimePhases?.finalization?.runtime, state?.runtime);
    assert.deepEqual(Object.keys(state?.runtimePhases?.finalization?.outputHashes ?? {}), [
      "assessment.html",
      "assessment.json",
    ]);
    const second = finalizeAssessment({ work });
    assert.ok(fs.existsSync(second.assessmentPath));
    assert.equal(
      (readJson(path.join(work, "workflow-state.json")) as TestWorkflowState).state,
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
    const judgment = readJson(judgmentPath) as AssessmentJudgment;
    judgment.semanticIntents[0].title = "";
    writeJson(judgmentPath, judgment);
    const state = readWorkflowState(work);
    assert.ok(state?.runtime);
    const materialization = state.runtimePhases?.materialization;
    assert.ok(materialization);
    transitionWorkflowState(work, "awaiting-finalization", {
      runtimePhases: {
        ...state.runtimePhases,
        materialization: createRuntimePhaseProvenance(
          work,
          state.runtime,
          Object.keys(materialization.inputHashes),
          Object.keys(materialization.outputHashes),
        ),
      },
    });
    assert.throws(() => finalizeAssessment({ work }), /incomplete/);
    assert.equal(fs.existsSync(path.join(work, "assessment.json")), false);
    const failedState = readJson(path.join(work, "workflow-state.json")) as TestWorkflowState;
    assert.equal(failedState.state, "awaiting-agent-judgment");
    assert.equal(failedState.failure.code, "finalization-failed");
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("the indexed finalization command accepts normally recorded originating materialization", () => {
  const work = fixture();
  try {
    const index = readJson(path.join(work, "agent-workspace", "agent-index.json")) as ReturnType<
      typeof buildAgentWorkspace
    >["index"];
    const { executable, args } = index.finalization.command;
    const result = spawnSync(executable, args, { encoding: "utf8", shell: false });
    assert.equal(result.status, 0, result.stderr);
    assert.ok(fs.existsSync(path.join(work, "assessment.json")));
    assert.ok(readWorkflowState(work)?.runtimePhases?.finalization);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("finalization rejects unrecorded or unsupported old-script materialization", () => {
  const work = fixture();
  try {
    const state = readWorkflowState(work);
    assert.ok(state?.runtimePhases?.materialization);
    for (const materialization of [
      undefined,
      { ...state.runtimePhases.materialization, schemaVersion: 2 },
    ]) {
      writeJson(path.join(work, "workflow-state.json"), {
        ...state,
        runtimePhases: { ...state.runtimePhases, materialization },
      });
      assert.throws(
        () => finalizeAssessment({ work }),
        /Missing or unsupported successful materialization runtime provenance/,
      );
      assert.equal(fs.existsSync(path.join(work, "assessment.json")), false);
      assert.equal(fs.existsSync(path.join(work, "assessment.html")), false);
      assert.equal(
        (readWorkflowState(work)?.failure as { code: string } | undefined)?.code,
        "runtime-tooling-error",
      );
    }
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("finalization rejects materialization recorded by the wrong root or fingerprint", () => {
  const work = fixture();
  try {
    const state = readWorkflowState(work);
    assert.ok(state);
    const materialization = state?.runtimePhases?.materialization;
    assert.ok(materialization);
    for (const runtime of [
      { ...materialization.runtime, root: path.join(work, "old-runtime") },
      { ...materialization.runtime, fingerprint: `sha256:${"0".repeat(64)}` },
    ]) {
      writeJson(path.join(work, "workflow-state.json"), {
        ...state,
        runtimePhases: {
          ...state.runtimePhases,
          materialization: { ...materialization, runtime },
        },
      });

      assert.throws(
        () => finalizeAssessment({ work }),
        /(?:Wrong runtime origin|Runtime fingerprint changed) for materialization phase/,
      );
      assert.equal(fs.existsSync(path.join(work, "assessment.json")), false);
    }
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("failed rematerialization cannot authorize earlier successful output", () => {
  const work = fixture();
  try {
    const decisionsPath = path.join(work, "agent-workspace", "agent-decisions.json");
    const decisions = readJson(decisionsPath) as Record<string, unknown>;
    decisions.overallConfidence = "__UNRESOLVED__";
    writeJson(decisionsPath, decisions);
    assert.throws(() => materializeAssessmentResults({ work }), /overallConfidence is invalid/);
    assert.ok(fs.existsSync(path.join(work, "assessment-judgment.json")));
    assert.isUndefined(readWorkflowState(work)?.runtimePhases?.materialization);
    assert.throws(
      () => finalizeAssessment({ work }),
      /Missing or unsupported successful materialization runtime provenance/,
    );
    assert.equal(fs.existsSync(path.join(work, "assessment.json")), false);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("finalization retains canonical assessment input hash guards", () => {
  const work = fixture();
  try {
    fs.appendFileSync(path.join(work, "preparation-manifest.json"), "\n");
    assert.throws(() => finalizeAssessment({ work }), /Canonical assessment inputs changed/);
    assert.equal(fs.existsSync(path.join(work, "assessment.json")), false);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("finalization rejects output or decisions changed after successful materialization", () => {
  const work = fixture();
  try {
    const judgmentPath = path.join(work, "assessment-judgment.json");
    fs.appendFileSync(judgmentPath, "\n");
    assert.throws(() => finalizeAssessment({ work }), /Stale materialization runtime provenance/);
    materializeAssessmentResults({ work });
    const decisionsPath = path.join(work, "agent-workspace", "agent-decisions.json");
    fs.appendFileSync(decisionsPath, "\n");
    assert.throws(() => finalizeAssessment({ work }), /Stale materialization runtime provenance/);
    assert.equal(fs.existsSync(path.join(work, "assessment.json")), false);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("materialization accepts timestamp-only changes to the prepared index", () => {
  const work = fixture();
  try {
    const indexPath = path.join(work, "agent-workspace", "agent-index.json");
    const index = fs.readFileSync(indexPath);
    const later = new Date(Date.now() + 2_000);
    fs.utimesSync(indexPath, later, later);
    assert.deepEqual(fs.readFileSync(indexPath), index);
    materializeAssessmentResults({ work });
    assert.ok(fs.existsSync(finalizeAssessment({ work }).assessmentPath));
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("finalization accepts byte-identical output replacement and timestamp changes", () => {
  const work = fixture();
  try {
    const judgmentPath = path.join(work, "assessment-judgment.json");
    const judgment = fs.readFileSync(judgmentPath);
    const replacementPath = path.join(work, "replacement.json");
    fs.writeFileSync(replacementPath, judgment);
    fs.renameSync(replacementPath, judgmentPath);
    const later = new Date(Date.now() + 2_000);
    fs.utimesSync(judgmentPath, later, later);
    assert.deepEqual(fs.readFileSync(judgmentPath), judgment);
    const result = finalizeAssessment({ work });
    assert.ok(fs.existsSync(result.assessmentPath));
    assert.ok(fs.existsSync(result.reportPath));
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("a new preparation cannot reuse stale materialization provenance", () => {
  const work = fixture();
  try {
    const state = readWorkflowState(work);
    const oldMaterialization = state?.runtimePhases?.materialization;
    assert.ok(oldMaterialization);
    buildAgentWorkspace({ work });
    assert.throws(
      () => finalizeAssessment({ work }),
      /Missing or unsupported successful materialization runtime provenance/,
    );
    const fresh = readWorkflowState(work);
    transitionWorkflowState(work, "awaiting-finalization", {
      runtimePhases: { ...fresh?.runtimePhases, materialization: oldMaterialization },
    });
    assert.throws(() => finalizeAssessment({ work }), /Stale materialization runtime provenance/);
    assert.equal(fs.existsSync(path.join(work, "assessment.json")), false);
    materializeAssessmentResults({ work });
    const runtime = verifyAssessmentRuntime(
      work,
      new URL("../scripts/finalize-assessment.ts", import.meta.url).href,
    );
    verifyRuntimePhaseProvenance(work, "materialization", runtime);
    assert.ok(fs.existsSync(finalizeAssessment({ work }).assessmentPath));
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});
