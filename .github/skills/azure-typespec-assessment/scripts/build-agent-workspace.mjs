import fs from "node:fs";
import path from "node:path";
import { isMain, parseArgs, readJsonObject, runMain } from "./cli.mjs";
import { readComplianceCatalog } from "./compliance-assessment.mjs";
import {
  atomicWriteJson,
  comparisonIdentity,
  hashArtifacts,
  resolveWorkPath,
  transitionWorkflowState,
} from "./workflow-state.mjs";

/** @typedef {import("./runtime-types.js").AssessmentModelInput} AssessmentModelInput */
/** @typedef {import("./runtime-types.js").ComplianceSearchRequest} ComplianceSearchRequest */
/** @typedef {import("./runtime-types.js").EvidenceSet} EvidenceSet */
/** @typedef {import("./runtime-types.js").ModelInputItem} ModelInputItem */
/** @typedef {import("./runtime-types.js").SourceIndex} SourceIndex */

const INDEX_FILE = "agent-workspace/agent-index.json";
const DECISIONS_DRAFT = "agent-workspace/agent-decisions.draft.json";
const DECISIONS_FILE = "agent-workspace/agent-decisions.json";

/** @param {(string | undefined)[]} values */
function unique(values) {
  return [
    ...new Set(values.filter(/** @returns {value is string} */ (value) => value !== undefined)),
  ].sort();
}

/**
 * @param {AssessmentModelInput} modelInput
 * @param {ModelInputItem} item
 * @returns {EvidenceSet}
 */
function evidenceFor(modelInput, item) {
  const evidence = item.evidenceSetId ? modelInput.evidenceSets?.[item.evidenceSetId] : undefined;
  if (!evidence) {
    throw new Error(
      `Missing evidence set ${item.evidenceSetId ?? "<missing>"} for ${item.id ?? item.reviewUnitId ?? item.requestId}.`,
    );
  }
  return evidence;
}

/** @param {AssessmentModelInput} modelInput */
function validateBoundedEvidence(modelInput) {
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

/**
 * @param {string} root
 * @param {AssessmentModelInput} modelInput
 * @returns {Map<string, string[]>}
 */
function declarationNamesByIntent(root, modelInput) {
  if (!modelInput.complianceSearchRequests.length) return new Map();
  const requestsValue = readJsonObject(
    resolveWorkPath(root, modelInput.artifactReferences.complianceSearchRequests),
  ).requests;
  if (!Array.isArray(requestsValue)) {
    throw new Error("Compliance search requests must contain a requests array.");
  }
  const requests = /** @type {ComplianceSearchRequest[]} */ (requestsValue);
  const sourceIndex = /** @type {SourceIndex} */ (
    /** @type {unknown} */ (
      readJsonObject(resolveWorkPath(root, modelInput.artifactReferences.sourceIndex))
    )
  );
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

/**
 * @param {AssessmentModelInput} modelInput
 * @param {Map<string, string[]>} declarationNames
 */
function decisionsDraft(modelInput, declarationNames) {
  /** @param {{id: string}} candidate */
  const decision = (candidate) => ({
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

/** @param {AssessmentModelInput} modelInput */
function canonicalPaths(modelInput) {
  return unique([
    "model-input.json",
    "preparation-manifest.json",
    ...Object.values(modelInput.artifactReferences ?? {}),
    "dimensions/document-quality-input.json",
  ]);
}

/** @param {{work: string}} options */
export function buildAgentWorkspace({ work }) {
  const started = performance.now();
  const root = path.resolve(work);
  const modelInputPath = path.join(root, "model-input.json");
  if (!fs.existsSync(modelInputPath)) throw new Error("Missing model-input.json.");
  const modelInput = /** @type {AssessmentModelInput} */ (readJsonObject(modelInputPath));
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
      script: "scripts/materialize-assessment-results.mjs",
      command:
        "node <skill-directory>/scripts/materialize-assessment-results.mjs --work <work-directory>",
    },
    serving: {
      script: "scripts/serve-assessment.mjs",
      command:
        "node <skill-directory>/scripts/serve-assessment.mjs --file <work-directory>/assessment.html",
      requiredOutput: "http://127.0.0.1:<port>/assessment.html",
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
      "Run materialize-assessment-results.mjs and require all materialized Agent artifacts.",
      "Run finalize-assessment.mjs and require validated assessment.json and assessment.html.",
      "Start serve-assessment.mjs as an attached long-lived process, wait for its localhost URL, and return it as the clickable Assessment report link with the absolute assessment.json path.",
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
