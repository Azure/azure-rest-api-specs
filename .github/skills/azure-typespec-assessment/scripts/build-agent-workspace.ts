import fs from "node:fs";
import path from "node:path";
import { randomUUID } from "node:crypto";
import {
  captureAssessmentRuntime,
  createRuntimePhaseProvenance,
  resolvedRuntimeCommand,
} from "./assessment-runtime.ts";
import { isMain, parseArgs, readJsonObject, runMain } from "./cli.ts";
import { readComplianceCatalog } from "./compliance-assessment.ts";
import {
  atomicWriteJson,
  comparisonIdentity,
  hashArtifacts,
  resolveWorkPath,
  transitionWorkflowState,
} from "./workflow-state.ts";

type AssessmentModelInput = import("./runtime-types.ts").AssessmentModelInput;

type ComplianceSearchRequest = import("./runtime-types.ts").ComplianceSearchRequest;

type EvidenceSet = import("./runtime-types.ts").EvidenceSet;

type ModelInputItem = import("./runtime-types.ts").ModelInputItem;

type SourceIndex = import("./runtime-types.ts").SourceIndex;

const INDEX_FILE = "agent-workspace/agent-index.json";
const DECISIONS_DRAFT = "agent-workspace/agent-decisions.draft.json";
const DECISIONS_FILE = "agent-workspace/agent-decisions.json";

function unique(values: (string | undefined)[]) {
  return [...new Set(values.filter((value): value is string => value !== undefined))].sort();
}

function evidenceFor(modelInput: AssessmentModelInput, item: ModelInputItem): EvidenceSet {
  const evidence = item.evidenceSetId ? modelInput.evidenceSets?.[item.evidenceSetId] : undefined;
  if (!evidence) {
    throw new Error(
      `Missing evidence set ${item.evidenceSetId ?? "<missing>"} for ${item.id ?? item.reviewUnitId ?? item.requestId}.`,
    );
  }
  return evidence;
}

function validateBoundedEvidence(modelInput: AssessmentModelInput) {
  const referencedFactIds = unique(
    [
      ...modelInput.semanticReviewUnits,
      ...modelInput.restCandidates,
      ...modelInput.downstreamCandidates,
      ...modelInput.complianceSearchRequests,
    ].flatMap((item) => evidenceFor(modelInput, item).evidenceFactIds ?? []),
  );
  for (const id of referencedFactIds) {
    if (!modelInput.facts?.[id]) {
      throw new Error(`Referenced canonical fact ${id} is missing.`);
    }
  }
}

function declarationNamesByIntent(
  root: string,
  modelInput: AssessmentModelInput,
): Map<string, string[]> {
  if (!modelInput.complianceSearchRequests.length) return new Map();
  const requestsValue = readJsonObject(
    resolveWorkPath(root, modelInput.artifactReferences.complianceSearchRequests),
  ).requests;
  if (!Array.isArray(requestsValue)) {
    throw new Error("Compliance search requests must contain a requests array.");
  }
  const requests = requestsValue as ComplianceSearchRequest[];
  const sourceIndex = readJsonObject(
    resolveWorkPath(root, modelInput.artifactReferences.sourceIndex),
  ) as unknown as SourceIndex;
  const sourceChanges = sourceIndex.sourceChanges;
  const sourcesById = new Map(sourceChanges.map((source) => [source.id, source]));
  return new Map(
    requests.map((request) => {
      const declarationIds = new Set(request.declarationIds);
      const declarations = request.sourceChangeIds.flatMap(
        (sourceId) => sourcesById.get(sourceId)?.declarations ?? [],
      );
      const names = [
        ...new Set(
          declarations
            .filter((declaration) => declarationIds.has(declaration.id))
            .map((declaration) => declaration.qualifiedName)
            .filter(Boolean),
        ),
      ].sort();
      const foundIds = new Set(
        declarations
          .filter((declaration) => declarationIds.has(declaration.id))
          .map((declaration) => declaration.id),
      );
      const missing = request.declarationIds.filter((id) => !foundIds.has(id));
      if (missing.length) {
        throw new Error(
          `Compliance request ${request.requestId} has declarations missing from its source: ${missing.join(", ")}.`,
        );
      }
      const unnamed = declarations
        .filter(
          (declaration) => declarationIds.has(declaration.id) && !declaration.qualifiedName?.trim(),
        )
        .map((declaration) => declaration.id);
      if (unnamed.length) {
        throw new Error(
          `Compliance request ${request.requestId} has declarations without qualified names: ${unnamed.join(", ")}.`,
        );
      }
      return [request.reviewUnitId, names];
    }),
  );
}

function decisionsDraft(modelInput: AssessmentModelInput, declarationNames: Map<string, string[]>) {
  const decision = (candidate: { id: string }) => ({
    candidateId: candidate.id,
    decision: "__UNRESOLVED__",
    rationale: "",
  });
  return {
    schemaVersion: 1,
    semanticSummaries: modelInput.semanticReviewUnits.map((unit) => ({
      reviewUnitId: unit.reviewUnitId,
      title: "",
      summary: "",
    })),
    restDecisions: modelInput.restCandidates.map(decision),
    downstreamDecisions: modelInput.downstreamCandidates.map(decision),
    sourceReviews: (modelInput.sourceReviewRequests ?? []).map((request) => ({
      candidateId: request.candidateId,
      outcome: "__UNRESOLVED__",
      selectedDeclarationIds: request.deterministicDeclarationIds,
      rationale: "",
    })),
    ...(modelInput.inferenceRequests.length
      ? {
          inferenceResults: modelInput.inferenceRequests.map((request) => ({
            requestId: request.requestId,
            decision: "__UNRESOLVED__",
            rationale: "",
            candidates: [],
          })),
        }
      : {}),
    catalogScores: modelInput.complianceSearchRequests.length
      ? readComplianceCatalog().map((entry) => ({
          catalogId: entry.catalogId,
          exactSymbol: 0,
          patternCategory: 0,
          servicePlane: 0,
          changeContext: 0,
          rationale: "",
        }))
      : [],
    fetchedDocuments: [],
    failedRetrievals: [],
    searchBlockers: [],
    complianceJudgments: modelInput.complianceSearchRequests.map((request) => ({
      reviewUnitId: request.reviewUnitId,
      applicableGuidance: [],
      declarationNames: declarationNames.get(request.reviewUnitId) ?? [],
      decision: "__UNRESOLVED__",
      actual: "",
      rationale: "",
    })),
    overallConfidence: "__UNRESOLVED__",
    blockers: [],
  };
}

function canonicalPaths(modelInput: AssessmentModelInput) {
  return unique([
    "model-input.json",
    "preparation-manifest.json",
    ...Object.values(modelInput.artifactReferences ?? {}),
    "dimensions/document-quality-input.json",
  ]);
}

export function buildAgentWorkspace({ work }: { work: string }) {
  const started = performance.now();
  const root = path.resolve(work);
  const runtime = captureAssessmentRuntime(import.meta.url);
  const modelInputPath = path.join(root, "model-input.json");
  if (!fs.existsSync(modelInputPath)) throw new Error("Missing model-input.json.");
  const modelInput = readJsonObject(modelInputPath) as AssessmentModelInput;
  validateBoundedEvidence(modelInput);

  fs.mkdirSync(path.join(root, "agent-workspace"), { recursive: true });
  fs.rmSync(resolveWorkPath(root, "agent-workspace/inference.draft.json"), {
    force: true,
  });
  fs.rmSync(resolveWorkPath(root, "agent-workspace/assessment-judgment.draft.json"), {
    force: true,
  });
  atomicWriteJson(
    resolveWorkPath(root, DECISIONS_DRAFT),
    decisionsDraft(modelInput, declarationNamesByIntent(root, modelInput)),
  );

  const artifacts = canonicalPaths(modelInput).filter((relativePath) =>
    fs.existsSync(resolveWorkPath(root, relativePath)),
  );
  const artifactHashes = hashArtifacts(root, artifacts);
  const modelInputBytes = fs.statSync(modelInputPath).size;
  const index = {
    schemaVersion: 1,
    preparationId: randomUUID(),
    runtime,
    comparisonIdentity: comparisonIdentity(modelInput),
    input: {
      path: "model-input.json",
      bytes: modelInputBytes,
      readExactlyOnce: true,
    },
    counts: {
      assessedSemanticIntents: modelInput.semanticReviewUnits.length,
      informationalSemanticIntents: modelInput.informationalSemanticIntentIds?.length ?? 0,
      restCandidates: modelInput.restCandidates.length,
      downstreamCandidates: modelInput.downstreamCandidates.length,
      sourceReviewRequests: modelInput.sourceReviewRequests?.length ?? 0,
      inferenceRequests: modelInput.inferenceRequests.length,
      guidelineRequests: modelInput.complianceSearchRequests.length,
    },
    requiredOutputs: {
      agentDecisions: DECISIONS_FILE,
      materialized: {
        inference: modelInput.inferenceRequests.length > 0 ? "inference.json" : null,
        guidelineEvidence: "compliance-search-evidence.json",
        judgment: "assessment-judgment.json",
      },
      structuredResult: "assessment.json",
      report: "assessment.html",
      schemas: {
        agentDecisions: "scripts/agent-decisions.schema.json",
        inference: "scripts/inference.schema.json",
        guidelineEvidence: "scripts/compliance-search-evidence.schema.json",
        judgment: "scripts/assessment-judgment.schema.json",
      },
      resolvedSchemas: {
        agentDecisions: path.join(runtime.root, "scripts", "agent-decisions.schema.json"),
        inference: path.join(runtime.root, "scripts", "inference.schema.json"),
        guidelineEvidence: path.join(
          runtime.root,
          "scripts",
          "compliance-search-evidence.schema.json",
        ),
        judgment: path.join(runtime.root, "scripts", "assessment-judgment.schema.json"),
        assessment: path.join(runtime.root, "scripts", "assessment.schema.json"),
      },
    },
    drafts: {
      agentDecisions: DECISIONS_DRAFT,
    },
    materialization: {
      script: "scripts/materialize-assessment-results.ts",
      command: resolvedRuntimeCommand(runtime, "scripts/materialize-assessment-results.ts", [
        "--work",
        root,
      ]),
    },
    finalization: {
      script: "scripts/finalize-assessment.ts",
      command: resolvedRuntimeCommand(runtime, "scripts/finalize-assessment.ts", ["--work", root]),
    },
    serving: {
      script: "scripts/serve-assessment.ts",
      command: resolvedRuntimeCommand(runtime, "scripts/serve-assessment.ts", [
        "--file",
        path.join(root, "assessment.html"),
      ]),
      requiredOutput: "http://127.0.0.1:<port>/assessment.html",
      longLived: true,
      readStartupOutputImmediately: true,
      waitForProcessCompletion: false,
    },
    coverage: {
      semanticIntentIds: modelInput.semanticReviewUnits.map((unit) => unit.reviewUnitId),
      informationalSemanticIntentIds: modelInput.informationalSemanticIntentIds ?? [],
      restCandidateIds: modelInput.restCandidates.map((candidate) => candidate.id),
      downstreamCandidateIds: modelInput.downstreamCandidates.map((candidate) => candidate.id),
      sourceReviewCandidateIds: (modelInput.sourceReviewRequests ?? []).map(
        (request) => request.candidateId,
      ),
      inferenceRequestIds: modelInput.inferenceRequests.map((request) => request.requestId),
      guidelineRequestIds: modelInput.complianceSearchRequests.map((request) => request.requestId),
    },
    completionChecklist: [
      "Read model-input.json exactly once.",
      ...(modelInput.inferenceRequests.length
        ? [
            "Resolve every inference request in the compact Agent decisions. Add one sourceReviews entry for every inferred candidate.",
          ]
        : []),
      "Review deterministic TypeSpec source proposals for every candidate. Use keep/refine/associate/unresolved for approved findings and not-applicable for rejected candidates; select only declaration IDs supplied by the bounded source-review request or inference source evidence.",
      ...(modelInput.complianceSearchRequests.length
        ? [
            "Score the full catalog, fetch the first four retrievable documents with fallback, and complete the compact Agent decisions; use only prefilled intent-scoped declarationNames in complianceJudgments.",
          ]
        : []),
      "Execute materialization.command using its exact executable and args, without substituting another runtime; require all materialized Agent artifacts.",
      "Execute finalization.command using its exact executable and args; require validated assessment.json and assessment.html.",
      "Execute serving.command using its exact executable and args as an attached long-lived process, immediately read its startup output without waiting for process completion or a completion notification, and return its localhost URL as the clickable Assessment report link with the absolute assessment.json path.",
    ],
    canonicalArtifactHashes: artifactHashes,
  };
  atomicWriteJson(resolveWorkPath(root, INDEX_FILE), index);
  const indexBytes = fs.statSync(resolveWorkPath(root, INDEX_FILE)).size;
  const workspaceMs = Math.round(performance.now() - started);
  transitionWorkflowState(root, "awaiting-agent-judgment", {
    comparisonIdentity: index.comparisonIdentity,
    artifacts: {
      modelInput: "model-input.json",
      agentIndex: INDEX_FILE,
      agentDecisionsDraft: DECISIONS_DRAFT,
    },
    artifactHashes,
    runtime,
    runtimePhases: {
      preparation: createRuntimePhaseProvenance(root, runtime, [], [INDEX_FILE]),
    },
    resultHashes: undefined,
    failure: undefined,
    telemetry: {
      deterministicReadyAt: new Date().toISOString(),
      agentWorkspaceMs: workspaceMs,
      agentIndexBytes: indexBytes,
      modelInputBytes,
    },
  });
  return { index, indexPath: resolveWorkPath(root, INDEX_FILE) };
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2), { required: ["work"] });
    const work = args.work;
    if (typeof work !== "string") throw new Error("--work must be a path.");
    const result = buildAgentWorkspace({ work });
    console.log(result.indexPath);
  });
}
