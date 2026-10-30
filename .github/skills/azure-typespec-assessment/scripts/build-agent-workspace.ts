import fs from "node:fs";
import path from "node:path";
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
    },
    drafts: {
      agentDecisions: DECISIONS_DRAFT,
    },
    materialization: {
      script: "scripts/materialize-assessment-results.ts",
      command:
        "node <skill-directory>/scripts/materialize-assessment-results.ts --work <work-directory>",
    },
    serving: {
      script: "scripts/serve-assessment.ts",
      command:
        "node <skill-directory>/scripts/serve-assessment.ts --file <work-directory>/assessment.html",
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
      inferenceRequestIds: modelInput.inferenceRequests.map((request) => request.requestId),
      guidelineRequestIds: modelInput.complianceSearchRequests.map((request) => request.requestId),
    },
    completionChecklist: [
      "Read model-input.json exactly once.",
      ...(modelInput.inferenceRequests.length
        ? ["Resolve every inference request in the compact Agent decisions."]
        : []),
      ...(modelInput.complianceSearchRequests.length
        ? [
            "Score the full catalog, fetch the first four retrievable documents with fallback, and complete the compact Agent decisions; use only prefilled intent-scoped declarationNames in complianceJudgments.",
          ]
        : []),
      "Run materialize-assessment-results.ts and require all materialized Agent artifacts.",
      "Run finalize-assessment.ts and require validated assessment.json and assessment.html.",
      "Start serve-assessment.ts as an attached long-lived process, immediately read its startup output without waiting for process completion or a completion notification, and return its localhost URL as the clickable Assessment report link with the absolute assessment.json path.",
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
