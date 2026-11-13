import { assert, test } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  captureAssessmentRuntime,
  verifyRuntimePhaseProvenance,
} from "../scripts/assessment-runtime.ts";
import type { AssessmentRuntime, RuntimeCommand } from "../scripts/assessment-runtime.ts";
import { buildAgentWorkspace } from "../scripts/build-agent-workspace.ts";
import { readJson, writeJson } from "../scripts/cli.ts";
import { readWorkflowState, transitionWorkflowState } from "../scripts/workflow-state.ts";

type AssessmentModelInput = import("../scripts/runtime-types.ts").AssessmentModelInput;

type TestWorkflowState = {
  state: string;
  telemetry: {
    agentIndexBytes: number;
  };
};
type AgentDecisionsDraft = {
  inferenceResults: {
    decision: string;
  }[];
  semanticSummaries: {
    title: string;
  }[];
  downstreamDecisions: {
    decision: string;
  }[];
  sourceReviews: {
    outcome: string;
  }[];
  complianceJudgments: unknown[];
  catalogScores: unknown[];
};
type AgentWorkspaceIndex = {
  preparationId: string;
  runtime: AssessmentRuntime;
  requiredOutputs: {
    schemas: Record<string, string>;
    resolvedSchemas: Record<string, string>;
  };
  coverage: {
    semanticIntentIds: string[];
    downstreamCandidateIds: string[];
    inferenceRequestIds: string[];
    sourceReviewCandidateIds: string[];
  };
  input: {
    path: string;
    readExactlyOnce: boolean;
    bytes: number;
  };
  counts: {
    assessedSemanticIntents: number;
    informationalSemanticIntents: number;
    guidelineRequests: number;
    sourceReviewRequests: number;
  };
  materialization: {
    script: string;
    command: RuntimeCommand;
  };
  finalization: {
    script: string;
    command: RuntimeCommand;
  };
  serving: {
    script: string;
    command: RuntimeCommand;
    requiredOutput: string;
    longLived: boolean;
    readStartupOutputImmediately: boolean;
    waitForProcessCompletion: boolean;
  };
  completionChecklist: string[];
};

function fixture() {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".agent workspace & ' test-"));
  const source = {
    sourceChanges: [
      {
        id: "source-1",
        path: "specification/widget/main.tsp",
        hunks: [{ id: "hunk-1", lines: ["+model Widget {}"] }],
        declarations: [
          {
            id: "declaration-1",
            kind: "model",
            qualifiedName: "Contoso.Widget",
            hunkIds: ["hunk-1"],
          },
        ],
      },
    ],
  };
  const semanticFact = {
    id: "operation-1",
    operationId: "Widgets_Get",
    method: "get",
    path: "/widgets/{name}",
  };
  const downstreamFact = {
    id: "sdk-fact-1",
    factKind: "model",
    identity: "Contoso.Widget",
  };
  writeJson(path.join(work, "preparation-manifest.json"), {
    comparison: {
      mergeBaseCommit: "base",
      headCommit: "head",
      baseRef: "main",
      workingTree: {},
    },
    projects: [],
  });
  writeJson(path.join(work, "source", "source-index.json"), source);
  writeJson(path.join(work, "dimensions", "semantic-intents-input.json"), {
    status: "ready",
    reviewUnits: [
      {
        id: "semantic-1",
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        declarationIds: ["declaration-1"],
        beforeFactIds: [],
        afterFactIds: ["operation-1"],
        operations: [
          {
            operationId: "Widgets_Get",
            afterFactId: "operation-1",
          },
        ],
      },
    ],
    facts: { "operation-1": semanticFact },
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
    candidates: [
      {
        id: "downstream-1",
        rule: "model-changed",
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        evidenceFactIds: ["sdk-fact-1"],
      },
    ],
    facts: { "sdk-fact-1": downstreamFact },
    rootCauses: [],
    blockers: [],
  });
  writeJson(path.join(work, "dimensions", "compliance-search-requests.json"), {
    schemaVersion: 1,
    requests: [
      {
        requestId: "compliance-search-1",
        reviewUnitId: "semantic-1",
        sourceChangeIds: ["source-1"],
        hunkIds: ["hunk-1"],
        declarationIds: ["declaration-1"],
        queryProfile: { servicePlane: "data-plane" },
      },
    ],
  });
  const semanticEvidence = {
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
    declarationCount: 1,
    evidenceFactIds: ["operation-1"],
  };
  const downstreamEvidence = {
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
    declarationCount: 1,
    evidenceFactIds: ["sdk-fact-1"],
  };
  writeJson(path.join(work, "model-input.json"), {
    schemaVersion: 1,
    context: {
      sourceComparison: {
        baseCommit: "base",
        headCommit: "head",
        baseRef: "main",
        workingTree: {},
      },
      projects: [],
    },
    artifactReferences: {
      sourceIndex: "source/source-index.json",
      semanticReviewUnits: "dimensions/semantic-intents-input.json",
      restCandidates: "dimensions/rest-breaking-input.json",
      downstreamCandidates: "dimensions/downstream-breaking-input.json",
      complianceSearchRequests: "dimensions/compliance-search-requests.json",
    },
    evidenceSets: {
      "evidence-semantic": semanticEvidence,
      "evidence-downstream": downstreamEvidence,
      "evidence-compliance": semanticEvidence,
    },
    facts: {
      "operation-1": semanticFact,
      "sdk-fact-1": downstreamFact,
    },
    semanticReviewUnits: [
      {
        reviewUnitId: "semantic-1",
        representativeOperationIds: ["Widgets_Get"],
        evidenceSetId: "evidence-semantic",
      },
    ],
    restCandidates: [],
    downstreamCandidates: [
      {
        id: "downstream-1",
        operationIds: ["Widgets_Get"],
        evidenceSetId: "evidence-downstream",
      },
    ],
    sourceReviewDeclarations: [],
    sourceReviewRequests: [
      {
        candidateId: "downstream-1",
        dimension: "downstream",
        evidenceSetId: "evidence-downstream",
        deterministicStatus: "unresolved",
        deterministicDeclarationIds: [],
        availableDeclarationIds: [],
        sourceChangeIds: [],
        hunkIds: [],
      },
    ],
    complianceSearchRequests: [
      {
        requestId: "compliance-search-1",
        reviewUnitId: "semantic-1",
        evidenceSetId: "evidence-compliance",
      },
    ],
    inferenceRequests: [
      {
        requestId: "inference-request-1",
        reviewUnitId: "semantic-1",
        sourceChangeId: "source-1",
        hunkId: "hunk-1",
        evidenceFactIds: ["operation-1"],
        allowedDimensions: ["downstream"],
      },
    ],
    blockers: [],
  });
  return { work, semanticFact, downstreamFact };
}

void test("builds a compact complete Agent workspace", () => {
  const { work } = fixture();
  try {
    const result = buildAgentWorkspace({ work });
    const index = readJson(result.indexPath) as AgentWorkspaceIndex;
    assert.ok(fs.statSync(result.indexPath).size < 20 * 1024);
    assert.deepEqual(index.coverage.semanticIntentIds, ["semantic-1"]);
    assert.deepEqual(index.coverage.downstreamCandidateIds, ["downstream-1"]);
    assert.deepEqual(index.coverage.inferenceRequestIds, ["inference-request-1"]);
    assert.deepEqual(index.coverage.sourceReviewCandidateIds, ["downstream-1"]);
    assert.equal(index.input.path, "model-input.json");
    assert.equal(index.input.readExactlyOnce, true);
    assert.equal(index.input.bytes, fs.statSync(path.join(work, "model-input.json")).size);
    assert.equal(index.counts.assessedSemanticIntents, 1);
    assert.equal(index.counts.informationalSemanticIntents, 0);
    assert.equal(index.counts.sourceReviewRequests, 1);
    assert.equal(index.materialization.script, "scripts/materialize-assessment-results.ts");
    const runtimeRoot = fs.realpathSync(
      path.resolve(path.dirname(fileURLToPath(import.meta.url)), ".."),
    );
    assert.deepEqual(
      index.runtime,
      captureAssessmentRuntime(
        new URL("../scripts/build-agent-workspace.ts", import.meta.url).href,
      ),
    );
    assert.equal(index.runtime.root, runtimeRoot);
    assert.match(index.preparationId, /^[a-f0-9-]{36}$/);
    assert.deepEqual(index.materialization.command, {
      executable: process.execPath,
      args: [
        path.join(runtimeRoot, "scripts", "materialize-assessment-results.ts"),
        "--work",
        work,
      ],
    });
    assert.equal(index.finalization.script, "scripts/finalize-assessment.ts");
    assert.deepEqual(index.finalization.command, {
      executable: process.execPath,
      args: [path.join(runtimeRoot, "scripts", "finalize-assessment.ts"), "--work", work],
    });
    assert.equal(index.serving.script, "scripts/serve-assessment.ts");
    assert.deepEqual(index.serving.command, {
      executable: process.execPath,
      args: [
        path.join(runtimeRoot, "scripts", "serve-assessment.ts"),
        "--file",
        path.join(work, "assessment.html"),
      ],
    });
    for (const [name, relativePath] of Object.entries(index.requiredOutputs.schemas)) {
      assert.equal(
        index.requiredOutputs.resolvedSchemas[name],
        path.resolve(runtimeRoot, relativePath),
      );
    }
    for (const file of Object.values(index.requiredOutputs.resolvedSchemas)) {
      assert.equal(path.isAbsolute(file), true);
      assert.equal(fs.existsSync(file), true);
    }
    assert.notInclude(JSON.stringify(index), "<skill-directory>");
    assert.notInclude(JSON.stringify(index), "<work-directory>");
    assert.equal(index.serving.requiredOutput, "http://127.0.0.1:<port>/assessment.html");
    assert.equal(index.serving.longLived, true);
    assert.equal(index.serving.readStartupOutputImmediately, true);
    assert.equal(index.serving.waitForProcessCompletion, false);
    assert.ok(
      index.completionChecklist.some(
        (item) =>
          item.includes("attached long-lived process") &&
          item.includes("immediately read its startup output") &&
          item.includes("without waiting for process completion") &&
          item.includes("clickable Assessment report link"),
      ),
    );
    const decisionsDraft = readJson(
      path.join(work, "agent-workspace", "agent-decisions.draft.json"),
    ) as AgentDecisionsDraft;
    assert.equal(decisionsDraft.inferenceResults[0].decision, "__UNRESOLVED__");
    assert.equal(decisionsDraft.semanticSummaries[0].title, "");
    assert.equal(decisionsDraft.downstreamDecisions[0].decision, "__UNRESOLVED__");
    assert.equal(decisionsDraft.sourceReviews[0].outcome, "__UNRESOLVED__");
    const state = readJson(path.join(work, "workflow-state.json")) as TestWorkflowState;
    assert.equal(state.state, "awaiting-agent-judgment");
    assert.equal(state.telemetry.agentIndexBytes, fs.statSync(result.indexPath).size);
    assert.deepEqual(readWorkflowState(work)?.runtime, index.runtime);
    assert.deepEqual(
      verifyRuntimePhaseProvenance(work, "preparation", index.runtime).runtime,
      index.runtime,
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("repreparation clears earlier phase provenance even with identical canonical inputs", () => {
  const { work } = fixture();
  try {
    const first = buildAgentWorkspace({ work }).index;
    const preparation = verifyRuntimePhaseProvenance(work, "preparation", first.runtime);
    transitionWorkflowState(work, "complete", {
      runtimePhases: {
        preparation,
        materialization: preparation,
        finalization: preparation,
      },
      resultHashes: { "assessment.json": "obsolete" },
    });
    const second = buildAgentWorkspace({ work }).index;
    assert.notEqual(first.preparationId, second.preparationId);
    assert.deepEqual(first.runtime, second.runtime);
    const state = readWorkflowState(work);
    assert.deepEqual(Object.keys(state?.runtimePhases ?? {}), ["preparation"]);
    assert.isUndefined(state?.resultHashes);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("rejects mutated or unresolved canonical evidence", () => {
  const { work } = fixture();
  try {
    const modelInputPath = path.join(work, "model-input.json");
    const modelInput = readJson(modelInputPath) as AssessmentModelInput;
    const evidenceSets = modelInput.evidenceSets;
    assert.ok(evidenceSets);
    evidenceSets["evidence-downstream"].evidenceFactIds = ["sdk-fact-missing"];
    writeJson(modelInputPath, modelInput);
    assert.throws(
      () => buildAgentWorkspace({ work }),
      /Referenced canonical fact sdk-fact-missing is missing/,
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("skips shared guideline search when all semantic intents are informational", () => {
  const { work } = fixture();
  try {
    const modelInputPath = path.join(work, "model-input.json");
    const modelInput = readJson(modelInputPath) as AssessmentModelInput;
    modelInput.semanticReviewUnits = [];
    modelInput.informationalSemanticIntentIds = ["semantic-1"];
    modelInput.downstreamCandidates = [];
    modelInput.complianceSearchRequests = [];
    modelInput.inferenceRequests = [];
    writeJson(modelInputPath, modelInput);

    const { indexPath } = buildAgentWorkspace({ work });
    const index = readJson(indexPath) as AgentWorkspaceIndex;
    const decisionsDraft = readJson(
      path.join(work, "agent-workspace", "agent-decisions.draft.json"),
    ) as AgentDecisionsDraft;

    assert.deepEqual(decisionsDraft.complianceJudgments, []);
    assert.deepEqual(decisionsDraft.catalogScores, []);
    assert.equal(index.counts.assessedSemanticIntents, 0);
    assert.equal(index.counts.informationalSemanticIntents, 1);
    assert.equal(index.counts.guidelineRequests, 0);
    assert.ok(!index.completionChecklist.some((item) => item.includes("fetch the first four")));
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});
