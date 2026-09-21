import fs from "node:fs";
import path from "node:path";
import { isMain, parseArgs, readJson, runMain } from "./cli.mjs";
import {
  atomicWriteJson,
  comparisonIdentity,
  hashArtifacts,
  resolveWorkPath,
  transitionWorkflowState,
} from "./workflow-state.mjs";
import { validateGuidanceRouting } from "./compliance-assessment.mjs";

const INDEX_FILE = "agent-workspace/agent-index.json";
const DECISIONS_DRAFT = "agent-workspace/agent-decisions.draft.json";
const DECISIONS_FILE = "agent-workspace/agent-decisions.json";

function unique(values) {
  return [...new Set(values.filter(Boolean))].sort();
}

function evidenceFor(modelInput, item) {
  const evidence = modelInput.evidenceSets?.[item.evidenceSetId];
  if (!evidence) {
    throw new Error(
      `Missing evidence set ${item.evidenceSetId ?? "<missing>"} for ${item.id ?? item.reviewUnitId ?? item.requestId}.`,
    );
  }
  return evidence;
}

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

function declarationNamesByIntent(root, modelInput) {
  if (!modelInput.complianceSearchRequests.length) return new Map();
  const requests = readJson(
    resolveWorkPath(
      root,
      modelInput.artifactReferences.complianceSearchRequests,
    ),
  ).requests;
  const sourceChanges = readJson(
    resolveWorkPath(root, modelInput.artifactReferences.sourceIndex),
  ).sourceChanges;
  const sourcesById = new Map(
    sourceChanges.map((source) => [source.id, source]),
  );
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
          (declaration) =>
            declarationIds.has(declaration.id) &&
            !declaration.qualifiedName?.trim(),
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

function decisionsDraft(modelInput, declarationNames) {
  const decision = (candidate) => ({
    candidateId: candidate.id,
    decision: "__UNRESOLVED__",
    rationale: "",
  });
  return {
    schemaVersion: 2,
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
    discoveryResults: modelInput.complianceSearchRequests.flatMap((request) =>
      request.guidanceRouting.discoveryRequests.map((discovery) => ({
        requestId: discovery.requestId,
        intentId: request.reviewUnitId,
        outcome: "__UNRESOLVED__",
        catalogIds: [],
        rationale: "",
      })),
    ),
    additionalSelections: [],
    fetchedDocuments: [],
    failedRetrievals: [],
    searchBlockers: [],
    complianceJudgments: modelInput.complianceSearchRequests.map((request) => ({
      reviewUnitId: request.reviewUnitId,
      reviewedCatalogIds: [],
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

function canonicalPaths(modelInput) {
  return unique([
    "model-input.json",
    "preparation-manifest.json",
    ...Object.values(modelInput.artifactReferences ?? {}),
    "dimensions/document-quality-input.json",
  ]);
}

export function buildAgentWorkspace({ work }) {
  const started = performance.now();
  const root = path.resolve(work);
  const modelInputPath = path.join(root, "model-input.json");
  if (!fs.existsSync(modelInputPath)) throw new Error("Missing model-input.json.");
  const modelInput = readJson(modelInputPath);
  validateBoundedEvidence(modelInput);
  validateGuidanceRouting(modelInput.complianceSearchRequests);

  fs.mkdirSync(path.join(root, "agent-workspace"), { recursive: true });
  fs.rmSync(resolveWorkPath(root, "agent-workspace/inference.draft.json"), {
    force: true,
  });
  fs.rmSync(
    resolveWorkPath(root, "agent-workspace/assessment-judgment.draft.json"),
    { force: true },
  );
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
      informationalSemanticIntents:
        modelInput.informationalSemanticIntentIds?.length ?? 0,
      restCandidates: modelInput.restCandidates.length,
      downstreamCandidates: modelInput.downstreamCandidates.length,
      inferenceRequests: modelInput.inferenceRequests.length,
      guidelineRequests: modelInput.complianceSearchRequests.length,
    },
    requiredOutputs: {
      agentDecisions: DECISIONS_FILE,
      materialized: {
        inference:
          modelInput.inferenceRequests.length > 0 ? "inference.json" : null,
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
        "node <skill-directory>\\scripts\\materialize-assessment-results.mjs --work <work-directory>",
    },
    coverage: {
      semanticIntentIds: modelInput.semanticReviewUnits.map(
        (unit) => unit.reviewUnitId,
      ),
      informationalSemanticIntentIds:
        modelInput.informationalSemanticIntentIds ?? [],
      restCandidateIds: modelInput.restCandidates.map((candidate) => candidate.id),
      downstreamCandidateIds: modelInput.downstreamCandidates.map(
        (candidate) => candidate.id,
      ),
      inferenceRequestIds: modelInput.inferenceRequests.map(
        (request) => request.requestId,
      ),
      guidelineRequestIds: modelInput.complianceSearchRequests.map(
        (request) => request.requestId,
      ),
    },
    completionChecklist: [
      "Read model-input.json exactly once.",
      ...(modelInput.inferenceRequests.length
        ? ["Resolve every inference request in the compact Agent decisions."]
        : []),
      ...(modelInput.complianceSearchRequests.length
        ? [
            "Required document metadata is in model-input.json mandatoryGuidanceCatalog. For targeted discovery only, read references/reference-document-links.md relative to the skill directory; it is not a work-directory artifact.",
            "Obtain every mandatory document and resolve each targeted discovery request. Reuse available same-session content before web_fetch, preserving its original retrievedAt and contentHash with retrievalSource session-reuse; otherwise use network. Never add filler documents.",
            "Review every required or positively discovered document for its owning intent before recording reviewedCatalogIds; do not reuse prior judgments. Missing content or blocked discovery requires only the owning intent to be not-assessed. Use only prefilled intent-scoped declarationNames.",
            "A versioned-api-evolution-guidance selection makes Evolving APIs governing guidance. Cite it in every completed judgment. Existing-version evolution without a changed versioning decorator must be applicable-fail; unchanged wire shape does not make an SDK behavior change compliant.",
            "An added model, interface, or operation that directly or transitively uses an Azure.ResourceManager.Legacy construct must be applicable-fail and cite current standard ARM modeling or operation guidance. A suppression or valid static route does not make new legacy usage compliant.",
          ]
        : []),
      "Run materialize-assessment-results.mjs and require all materialized Agent artifacts.",
      "Run finalize-assessment.mjs and require validated assessment.json and assessment.html.",
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
  runMain(async () => {
    const args = parseArgs(process.argv.slice(2), { required: ["work"] });
    const result = buildAgentWorkspace({ work: args.work });
    console.log(result.indexPath);
  });
}
