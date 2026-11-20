import fs from "node:fs";
import path from "node:path";
import { isMain, parseArgs, readJsonObject, runMain } from "./cli.mjs";
import { assembleCompliance, readComplianceCatalog } from "./compliance-assessment.mjs";
import { canonicalJson } from "./stable-id.mjs";
import {
  readWorkflowState,
  resolveWorkPath,
  transitionWorkflowState,
  verifyArtifactHashes,
} from "./workflow-state.mjs";

/** @typedef {import("./agent-decisions.schema.js").CandidateDecision} CompactCandidateDecision */
/** @typedef {import("./agent-decisions.schema.js").Guidance} CompactGuidance */
/** @typedef {import("./agent-decisions.schema.js").TypeSpecAssessmentCompactAgentDecisions} CompactDecisions */
/** @typedef {import("./compliance-search-evidence.schema.js").Document} ComplianceDocument */
/** @typedef {import("./compliance-search-evidence.schema.js").TypeSpecAzureGuidelinesSearchEvidence} SearchEvidence */
/** @typedef {import("./runtime-types.js").AssessmentInference} AssessmentInference */
/** @typedef {import("./runtime-types.js").AssessmentJudgment} AssessmentJudgment */
/** @typedef {import("./runtime-types.js").AssessmentModelInput} AssessmentModelInput */
/** @typedef {import("./runtime-types.js").ComplianceSearchRequest} ComplianceSearchRequest */
/** @typedef {import("./runtime-types.js").InferenceCandidate} InferenceCandidate */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {ReturnType<typeof readComplianceCatalog>[number]} CatalogEntry */
/**
 * @typedef {{
 *   input?: {path?: string},
 *   coverage?: {
 *     semanticIntentIds?: string[],
 *     restCandidateIds?: string[],
 *     downstreamCandidateIds?: string[],
 *     inferenceRequestIds?: string[],
 *     guidelineRequestIds?: string[]
 *   },
 *   requiredOutputs?: {
 *     agentDecisions?: string,
 *     materialized?: {
 *       inference?: string | null,
 *       guidelineEvidence?: string,
 *       judgment?: string
 *     },
 *     schemas?: {agentDecisions?: string}
 *   },
 *   materialization?: {script?: string},
 *   canonicalArtifactHashes?: Record<string, string>
 * }} AgentIndex
 * @typedef {Omit<ComplianceDocument, "guidance"> & {
 *   catalogId?: string,
 *   guidance: (CompactGuidance & {applicableDeclarationIds: string[]})[]
 * }} MaterializedComplianceDocument
 * @typedef {{
 *   schemaVersion: 2,
 *   queryProfiles: SearchEvidence["queryProfiles"],
 *   catalogRanking: SearchEvidence["catalogRanking"][number][],
 *   rankedDocuments: MaterializedComplianceDocument[],
 *   retrievalAttempts: SearchEvidence["retrievalAttempts"],
 *   blockers: string[],
 *   inputAccounting: SearchEvidence["inputAccounting"]
 * }} MaterializedSearchEvidence
 * @typedef {{
 *   evidence: MaterializedSearchEvidence,
 *   catalogById: Map<string, CatalogEntry>,
 *   fetchedById: Map<string, MaterializedComplianceDocument>
 * }} MaterializedSearchResult
 */

const INDEX_FILE = "agent-workspace/agent-index.json";
const DECISIONS_FILE = "agent-workspace/agent-decisions.json";
const SCORE_FIELDS = /** @type {const} */ ([
  "exactSymbol",
  "patternCategory",
  "servicePlane",
  "changeContext",
]);
/** @type {Record<(typeof SCORE_FIELDS)[number], number[]>} */
const SCORE_VALUES = {
  exactSymbol: [0, 4],
  patternCategory: [0, 3],
  servicePlane: [0, 2],
  changeContext: [0, 1],
};
/**
 * @param {unknown} value
 * @returns {value is "high" | "medium" | "low"}
 */
function isSeverity(value) {
  return value === "high" || value === "medium" || value === "low";
}

/**
 * @param {unknown} value
 * @param {string} label
 * @returns {asserts value is Record<string, unknown>}
 */
function assertObject(value, label) {
  if (!value || typeof value !== "object" || Array.isArray(value)) {
    throw new Error(`${label} must be an object.`);
  }
}

/**
 * @param {unknown} value
 * @param {string[]} allowed
 * @param {string} label
 * @returns {asserts value is Record<string, unknown>}
 */
function assertKeys(value, allowed, label) {
  assertObject(value, label);
  const unknown = Object.keys(value).filter((key) => !allowed.includes(key));
  if (unknown.length) {
    throw new Error(`${label} contains unknown fields: ${unknown.join(", ")}.`);
  }
}

/**
 * @param {unknown} value
 * @param {string} label
 * @returns {asserts value is unknown[]}
 */
function requireArray(value, label) {
  if (!Array.isArray(value)) throw new Error(`${label} must be an array.`);
}

/**
 * @param {unknown} value
 * @param {string} label
 * @returns {asserts value is string}
 */
function requireText(value, label) {
  if (typeof value !== "string" || !value.trim()) {
    throw new Error(`${label} must be a nonempty string.`);
  }
}

/**
 * @template T
 * @param {T[]} values
 * @returns {T[]}
 */
function duplicates(values) {
  /** @type {Set<T>} */
  const seen = new Set();
  return [
    ...new Set(values.filter((value) => (seen.has(value) ? true : (seen.add(value), false)))),
  ];
}

/**
 * @param {string[]} expected
 * @param {string[]} actual
 * @param {string} label
 */
function exactCoverage(expected, actual, label) {
  const duplicate = duplicates(actual);
  const expectedSet = new Set(expected);
  const unknown = actual.filter((item) => !expectedSet.has(item));
  const missing = expected.filter((item) => !actual.includes(item));
  if (duplicate.length || unknown.length || missing.length) {
    throw new Error(
      `${label} coverage mismatch. Missing: ${missing.join(", ") || "none"}; ` +
        `unknown: ${unknown.join(", ") || "none"}; duplicate: ${duplicate.join(", ") || "none"}.`,
    );
  }
}

/**
 * @param {string[]} actual
 * @param {string[]} expected
 * @param {string} label
 */
function subset(actual, expected, label) {
  requireArray(actual, label);
  if (duplicates(actual).length || actual.some((item) => !expected.includes(item))) {
    throw new Error(`${label} contains an unknown or duplicate ID.`);
  }
}

/**
 * @param {CompactCandidateDecision} decision
 * @param {string} label
 */
function validateCandidateDecision(decision, label) {
  assertKeys(decision, ["candidateId", "decision", "severity", "rationale"], label);
  requireText(decision.candidateId, `${label}.candidateId`);
  requireText(decision.rationale, `${label}.rationale`);
  if (!["approve", "reject"].includes(decision.decision)) {
    throw new Error(`${label} has an invalid decision.`);
  }
  if (decision.decision === "approve" && !isSeverity(decision.severity)) {
    throw new Error(`${label} approve requires a severity.`);
  }
  if (decision.decision === "reject" && decision.severity !== undefined) {
    throw new Error(`${label} reject must omit severity.`);
  }
}

/**
 * @param {CompactDecisions} decisions
 * @param {AssessmentModelInput} modelInput
 * @returns {{inference: AssessmentInference | undefined, candidates: InferenceCandidate[]}}
 */
function materializeInference(decisions, modelInput) {
  const requests = modelInput.inferenceRequests ?? [];
  const compact = decisions.inferenceResults;
  if (!requests.length) {
    if (compact !== undefined && compact.length) {
      throw new Error("inferenceResults must be omitted or empty when no inference is required.");
    }
    return { inference: undefined, candidates: [] };
  }
  requireArray(compact, "Agent decisions.inferenceResults");
  exactCoverage(
    requests.map((item) => item.requestId),
    compact.map((item) => item.requestId),
    "Inference result",
  );
  const requestsById = new Map(requests.map((request) => [request.requestId, request]));
  /** @type {string[]} */
  const candidateIds = [];
  /** @type {InferenceCandidate[]} */
  const candidates = [];
  const results = compact.map((result) => {
    assertKeys(
      result,
      ["requestId", "decision", "rationale", "candidates"],
      `Inference result ${result.requestId ?? "<unknown>"}`,
    );
    const request = requestsById.get(result.requestId);
    if (!request) {
      throw new Error(`Inference result ${result.requestId} is unknown.`);
    }
    requireText(result.rationale, `Inference result ${result.requestId}.rationale`);
    requireArray(result.candidates, `Inference result ${result.requestId}.candidates`);
    if (!["candidates", "no-impact", "blocked"].includes(result.decision)) {
      throw new Error(`Inference result ${result.requestId} has an invalid decision.`);
    }
    if ((result.decision === "candidates") !== result.candidates.length > 0) {
      throw new Error(
        `Inference result ${result.requestId} candidate count does not match its decision.`,
      );
    }
    const materializedCandidates = result.candidates.map((candidate) => {
      assertKeys(
        candidate,
        [
          "id",
          "dimension",
          "rule",
          "defaultSeverity",
          "actual",
          "expected",
          "crossLanguageDefinitionId",
          "operationIds",
          "evidenceFactIds",
        ],
        `Inferred candidate ${candidate.id ?? "<unknown>"}`,
      );
      for (const field of ["id", "rule", "actual", "expected"]) {
        requireText(candidate[field], `Inferred candidate ${candidate.id ?? "<unknown>"}.${field}`);
      }
      if (!request.allowedDimensions.includes(candidate.dimension)) {
        throw new Error(`Inferred candidate ${candidate.id} uses a disallowed dimension.`);
      }
      if (!candidate.id.startsWith(`inferred-${candidate.dimension}-`)) {
        throw new Error(`Inferred candidate ${candidate.id} has an invalid ID.`);
      }
      if (!["high", "medium", "low"].includes(candidate.defaultSeverity)) {
        throw new Error(`Inferred candidate ${candidate.id} has an invalid severity.`);
      }
      if (candidate.dimension === "downstream" && !candidate.crossLanguageDefinitionId?.trim()) {
        throw new Error(`Inferred candidate ${candidate.id} requires an SDK symbol.`);
      }
      subset(
        candidate.operationIds,
        request.relatedOperationIds ?? [],
        `Inferred candidate ${candidate.id} operationIds`,
      );
      subset(
        candidate.evidenceFactIds,
        Object.keys(modelInput.facts ?? {}),
        `Inferred candidate ${candidate.id} evidenceFactIds`,
      );
      candidateIds.push(candidate.id);
      /** @type {InferenceCandidate} */
      const materialized = {
        ...candidate,
        sourceChangeIds: [request.sourceChangeId],
        hunkIds: [request.hunkId],
        reviewRequired: true,
      };
      candidates.push(materialized);
      return materialized;
    });
    return {
      requestId: request.requestId,
      reviewUnitId: request.reviewUnitId,
      hunkId: request.hunkId,
      decision: result.decision,
      rationale: result.rationale,
      candidates: materializedCandidates,
    };
  });
  if (duplicates(candidateIds).length) {
    throw new Error(`Duplicate inferred candidate IDs: ${duplicates(candidateIds).join(", ")}.`);
  }
  return { inference: { schemaVersion: 1, results }, candidates };
}

/**
 * @param {AssessmentModelInput} modelInput
 * @param {Map<string, Record<string, unknown>>} artifacts
 * @returns {ComplianceSearchRequest[]}
 */
function canonicalRequests(modelInput, artifacts) {
  const compactRequests = modelInput.complianceSearchRequests ?? [];
  if (!compactRequests.length) return [];
  const artifactPath = modelInput.artifactReferences?.complianceSearchRequests;
  if (!artifactPath) {
    throw new Error("Missing canonical compliance search request artifact.");
  }
  const artifact = artifacts.get(artifactPath.replaceAll("\\", "/"));
  const artifactRequests = artifact?.requests;
  requireArray(artifactRequests, "Canonical compliance search requests");
  const requests = /** @type {ComplianceSearchRequest[]} */ (artifactRequests);
  exactCoverage(
    compactRequests.map((item) => item.requestId),
    requests.map((item) => item.requestId),
    "Canonical compliance search request",
  );
  if (
    duplicates(requests.map((item) => item.requestId)).length ||
    duplicates(requests.map((item) => item.reviewUnitId)).length
  ) {
    throw new Error("Canonical compliance search requests contain duplicate ownership.");
  }
  const compactById = new Map(compactRequests.map((item) => [item.requestId, item]));
  for (const request of requests) {
    const compact = compactById.get(request.requestId);
    if (!compact) {
      throw new Error(`Canonical compliance request ${request.requestId} is unknown.`);
    }
    if (request.reviewUnitId !== compact.reviewUnitId) {
      throw new Error(
        `Canonical compliance search request ${request.requestId} has cross-intent ownership.`,
      );
    }
  }
  return requests;
}

/**
 * @param {CompactGuidance} guidance
 * @param {string} label
 */
function validateGuidance(guidance, label) {
  assertKeys(
    guidance,
    ["section", "excerpt", "queryTerms", "examples", "applicableDeclarationIds"],
    label,
  );
  requireText(guidance.section, `${label}.section`);
  requireText(guidance.excerpt, `${label}.excerpt`);
  requireArray(guidance.queryTerms, `${label}.queryTerms`);
  requireArray(guidance.examples, `${label}.examples`);
  if (guidance.examples.length > 2) {
    throw new Error(`${label} may retain at most two examples.`);
  }
  for (const [index, example] of guidance.examples.entries()) {
    requireText(example, `${label}.examples[${index}]`);
    if (example.split(/\r?\n/).length > 12) {
      throw new Error(`${label}.examples[${index}] exceeds 12 lines.`);
    }
  }
  if (guidance.applicableDeclarationIds !== undefined) {
    requireArray(guidance.applicableDeclarationIds, `${label}.applicableDeclarationIds`);
  }
}

/**
 * @param {CompactDecisions} decisions
 * @param {ComplianceSearchRequest[]} requests
 * @param {SourceChange[]} sourceChanges
 * @returns {Map<string, string[]>}
 */
function resolveComplianceJudgmentDeclarations(decisions, requests, sourceChanges) {
  exactCoverage(
    requests.map((item) => item.reviewUnitId),
    decisions.complianceJudgments.map((item) => item.reviewUnitId),
    "Compliance judgment",
  );
  const requestsByIntent = new Map(requests.map((request) => [request.reviewUnitId, request]));
  const sourcesById = new Map(sourceChanges.map((source) => [source.id, source]));
  /** @type {Map<string, Map<string, string[]>>} */
  const declarationsByIntent = new Map();
  /** @type {Map<string, Set<string>>} */
  const intentsByName = new Map();
  for (const request of requests) {
    const requestedIds = new Set(request.declarationIds ?? []);
    const declarations = request.sourceChangeIds.flatMap(
      (sourceId) => sourcesById.get(sourceId)?.declarations ?? [],
    );
    const eligible = declarations.filter((item) => requestedIds.has(item.id));
    const foundIds = new Set(eligible.map((item) => item.id));
    const missing = [...requestedIds].filter((id) => !foundIds.has(id));
    if (missing.length) {
      throw new Error(
        `Compliance request ${request.requestId} has declarations missing from its source: ${missing.join(", ")}.`,
      );
    }
    /** @type {Map<string, string[]>} */
    const byName = new Map();
    for (const declaration of eligible) {
      requireText(
        declaration.qualifiedName,
        `Compliance declaration ${declaration.id}.qualifiedName`,
      );
      const matches = byName.get(declaration.qualifiedName) ?? [];
      matches.push(declaration.id);
      byName.set(declaration.qualifiedName, matches);
      const owners = intentsByName.get(declaration.qualifiedName) ?? new Set();
      owners.add(request.reviewUnitId);
      intentsByName.set(declaration.qualifiedName, owners);
    }
    declarationsByIntent.set(request.reviewUnitId, byName);
  }

  /** @type {Map<string, string[]>} */
  const resolved = new Map();
  for (const judgment of decisions.complianceJudgments) {
    requireArray(
      judgment.applicableGuidance,
      `Compliance judgment ${judgment.reviewUnitId}.applicableGuidance`,
    );
    const request = requestsByIntent.get(judgment.reviewUnitId);
    if (!request) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} is unknown.`);
    }
    const declarationNames = judgment.declarationNames;
    const declarationIds = judgment.declarationIds;
    const usesNames = declarationNames !== undefined;
    const usesIds = declarationIds !== undefined;
    if (usesNames === usesIds) {
      throw new Error(
        `Compliance judgment ${judgment.reviewUnitId} must use exactly one of declarationNames or legacy declarationIds.`,
      );
    }
    if (declarationIds !== undefined) {
      subset(
        declarationIds,
        request.declarationIds ?? [],
        `Compliance judgment ${judgment.reviewUnitId}.declarationIds`,
      );
      resolved.set(judgment.reviewUnitId, [...declarationIds].sort());
      continue;
    }
    requireArray(declarationNames, `Compliance judgment ${judgment.reviewUnitId}.declarationNames`);
    const duplicateNames = duplicates(declarationNames);
    if (duplicateNames.length) {
      throw new Error(
        `Compliance judgment ${judgment.reviewUnitId} has duplicate declaration names: ${duplicateNames.join(", ")}.`,
      );
    }
    const ownDeclarations = declarationsByIntent.get(judgment.reviewUnitId);
    if (!ownDeclarations) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} has no declarations.`);
    }
    const resolvedIds = declarationNames.map((name) => {
      requireText(name, `Compliance judgment ${judgment.reviewUnitId}.declarationNames`);
      const matches = ownDeclarations.get(name) ?? [];
      if (matches.length > 1) {
        throw new Error(
          `Compliance judgment ${judgment.reviewUnitId} has ambiguous declaration name ${name}.`,
        );
      }
      if (!matches.length) {
        const otherOwners = [...(intentsByName.get(name) ?? [])].filter(
          (intentId) => intentId !== judgment.reviewUnitId,
        );
        if (otherOwners.length) {
          throw new Error(
            `Compliance judgment ${judgment.reviewUnitId} uses cross-intent declaration name ${name}.`,
          );
        }
        throw new Error(
          `Compliance judgment ${judgment.reviewUnitId} uses unknown declaration name ${name}.`,
        );
      }
      return matches[0];
    });
    resolved.set(judgment.reviewUnitId, [...resolvedIds].sort());
  }
  return resolved;
}

/**
 * @param {CompactDecisions} decisions
 * @param {ComplianceSearchRequest[]} requests
 * @param {Map<string, string[]>} resolvedDeclarations
 * @returns {Map<string, string[]>}
 */
function citedGuidanceDeclarations(decisions, requests, resolvedDeclarations) {
  const judgmentsByIntent = new Map(
    decisions.complianceJudgments.map((item) => [item.reviewUnitId, item]),
  );
  /** @type {Map<string, Set<string>>} */
  const declarationsByGuidance = new Map();
  for (const request of requests) {
    const judgment = judgmentsByIntent.get(request.reviewUnitId);
    if (!judgment) {
      throw new Error(`Compliance request ${request.requestId} has no judgment.`);
    }
    for (const reference of judgment.applicableGuidance) {
      assertKeys(
        reference,
        ["catalogId", "guidanceSection"],
        `Compliance judgment ${judgment.reviewUnitId} guidance`,
      );
      requireText(
        reference.catalogId,
        `Compliance judgment ${judgment.reviewUnitId} guidance.catalogId`,
      );
      requireText(
        reference.guidanceSection,
        `Compliance judgment ${judgment.reviewUnitId} guidance.guidanceSection`,
      );
      const key = `${reference.catalogId}\u0000${reference.guidanceSection}`;
      const declarationIds = declarationsByGuidance.get(key) ?? new Set();
      for (const declarationId of resolvedDeclarations.get(judgment.reviewUnitId) ?? []) {
        declarationIds.add(declarationId);
      }
      declarationsByGuidance.set(key, declarationIds);
    }
  }
  return new Map(
    [...declarationsByGuidance].map(([key, declarationIds]) => [key, [...declarationIds].sort()]),
  );
}

/**
 * @param {CompactDecisions} decisions
 * @param {ComplianceSearchRequest[]} requests
 * @param {CatalogEntry[]} catalog
 * @param {Map<string, string[]>} resolvedDeclarations
 * @returns {MaterializedSearchResult}
 */
function materializeSearch(decisions, requests, catalog, resolvedDeclarations) {
  if (!requests.length) {
    exactCoverage(
      [],
      decisions.catalogScores.map((item) => item.catalogId),
      "Catalog score",
    );
    if (
      decisions.fetchedDocuments.length ||
      decisions.failedRetrievals.length ||
      decisions.searchBlockers.length
    ) {
      throw new Error(
        "Guideline retrieval results are invalid without compliance search requests.",
      );
    }
    return {
      evidence: {
        schemaVersion: 2,
        queryProfiles: [],
        catalogRanking: [],
        rankedDocuments: [],
        retrievalAttempts: [],
        blockers: [],
        inputAccounting: {
          catalogEntriesScored: 0,
          documentsFetched: 0,
          documentBytesFetched: 0,
          guidanceExcerptsRetained: 0,
          guidanceExcerptBytesRetained: 0,
        },
      },
      catalogById: new Map(),
      fetchedById: new Map(),
    };
  }
  const catalogById = new Map(catalog.map((item) => [item.catalogId, item]));
  /** @param {string} canonicalUrl */
  const catalogEntryByUrl = (canonicalUrl) => {
    const entry = catalog.find((item) => item.canonicalUrl === canonicalUrl);
    if (!entry) {
      throw new Error(`Unknown catalog URL ${canonicalUrl}.`);
    }
    return entry;
  };
  const declarationsByGuidance = citedGuidanceDeclarations(
    decisions,
    requests,
    resolvedDeclarations,
  );
  exactCoverage(
    catalog.map((item) => item.catalogId),
    decisions.catalogScores.map((item) => item.catalogId),
    "Catalog score",
  );
  const ranking = decisions.catalogScores
    .map((score, index) => {
      assertKeys(
        score,
        [...SCORE_FIELDS, "catalogId", "rationale"],
        `Catalog score ${score.catalogId ?? index}`,
      );
      requireText(score.rationale, `Catalog score ${score.catalogId}.rationale`);
      let total = 0;
      for (const field of SCORE_FIELDS) {
        if (!SCORE_VALUES[field].includes(score[field])) {
          throw new Error(`Catalog score ${score.catalogId} has invalid ${field}.`);
        }
        total += score[field];
      }
      const entry = catalogById.get(score.catalogId);
      if (!entry) {
        throw new Error(`Catalog score uses unknown ID ${score.catalogId}.`);
      }
      return {
        catalogOrder: entry.catalogOrder,
        title: entry.title,
        canonicalUrl: entry.canonicalUrl,
        score: {
          exactSymbol: score.exactSymbol,
          patternCategory: score.patternCategory,
          servicePlane: score.servicePlane,
          changeContext: score.changeContext,
          total,
        },
        selectionRationale: score.rationale,
      };
    })
    .sort(
      (left, right) =>
        right.score.total - left.score.total || left.catalogOrder - right.catalogOrder,
    )
    .map((entry, index) => ({ rank: index + 1, ...entry }));
  const rankingById = new Map(
    ranking.map((entry) => [catalogEntryByUrl(entry.canonicalUrl).catalogId, entry]),
  );

  const failedIds = decisions.failedRetrievals.map((item) => item.catalogId);
  const fetchedIds = decisions.fetchedDocuments.map((item) => item.catalogId);
  if (duplicates(failedIds).length || duplicates(fetchedIds).length) {
    throw new Error("Retrieval results contain duplicate catalog IDs.");
  }
  for (const retrieval of decisions.failedRetrievals) {
    assertKeys(retrieval, ["catalogId", "error"], `Failed retrieval ${retrieval.catalogId}`);
    if (!catalogById.has(retrieval.catalogId)) {
      throw new Error(`Failed retrieval uses unknown catalog ID ${retrieval.catalogId}.`);
    }
    requireText(retrieval.error, `Failed retrieval ${retrieval.catalogId}.error`);
  }
  if (fetchedIds.some((id) => failedIds.includes(id))) {
    throw new Error("A catalog entry cannot be both fetched and failed.");
  }
  if (decisions.fetchedDocuments.length > 4) {
    throw new Error("At most four documents may be fetched.");
  }
  const failedSet = new Set(failedIds);
  const expectedDocuments = ranking
    .filter((entry) => {
      const id = catalogEntryByUrl(entry.canonicalUrl).catalogId;
      return !failedSet.has(id);
    })
    .slice(0, 4);
  const expectedIds = expectedDocuments.map(
    (entry) => catalogEntryByUrl(entry.canonicalUrl).catalogId,
  );
  if (
    expectedIds.length !== fetchedIds.length ||
    expectedIds.some((id, index) => id !== fetchedIds[index])
  ) {
    throw new Error(
      "Fetched documents must be the first four retrievable catalog entries in ranked order.",
    );
  }
  const attemptedIds = new Set([...failedIds, ...fetchedIds]);
  const attemptedPrefix = ranking
    .slice(0, attemptedIds.size)
    .map((entry) => catalogEntryByUrl(entry.canonicalUrl).catalogId);
  if (
    attemptedPrefix.some((id) => !attemptedIds.has(id)) ||
    attemptedPrefix.length !== attemptedIds.size
  ) {
    throw new Error("Retrieval results must form a contiguous ranked prefix.");
  }
  if (
    fetchedIds.length === 4 &&
    attemptedIds.size !== rankingById.get(fetchedIds.at(-1) ?? "")?.rank
  ) {
    throw new Error("Retrieval attempts must stop after the fourth successful fetch.");
  }
  const exhausted = fetchedIds.length < 4;
  const hasExhaustionBlocker = decisions.searchBlockers.some((item) =>
    item.startsWith("catalog-exhausted:"),
  );
  if (exhausted && (attemptedIds.size !== catalog.length || !hasExhaustionBlocker)) {
    throw new Error(
      "Fewer than four fetched documents requires catalog exhaustion and an explicit blocker.",
    );
  }
  if (!exhausted && hasExhaustionBlocker) {
    throw new Error("Catalog exhaustion blocker is invalid after four successful fetches.");
  }

  /** @type {MaterializedComplianceDocument[]} */
  const rankedDocuments = decisions.fetchedDocuments.map((document, index) => {
    assertKeys(
      document,
      ["catalogId", "retrievedAt", "contentHash", "bytes", "guidance", "noRelevantGuidance"],
      `Fetched document ${document.catalogId ?? index}`,
    );
    if (!catalogById.has(document.catalogId)) {
      throw new Error(`Fetched document uses unknown catalog ID ${document.catalogId}.`);
    }
    if (Number.isNaN(Date.parse(document.retrievedAt ?? ""))) {
      throw new Error(`Fetched document ${document.catalogId} has invalid retrievedAt.`);
    }
    if (!/^sha256:[0-9a-f]{64}$/i.test(document.contentHash ?? "")) {
      throw new Error(`Fetched document ${document.catalogId} has invalid contentHash.`);
    }
    if (!Number.isInteger(document.bytes) || document.bytes < 0) {
      throw new Error(`Fetched document ${document.catalogId} has invalid bytes.`);
    }
    requireArray(document.guidance, `Fetched document ${document.catalogId}.guidance`);
    if (typeof document.noRelevantGuidance !== "boolean") {
      throw new Error(`Fetched document ${document.catalogId} requires noRelevantGuidance.`);
    }
    if (document.noRelevantGuidance === document.guidance.length > 0) {
      throw new Error(
        `Fetched document ${document.catalogId} must contain guidance or declare none, not both.`,
      );
    }
    const sections = document.guidance.map((item) => item.section);
    if (duplicates(sections).length) {
      throw new Error(`Fetched document ${document.catalogId} has duplicate guidance sections.`);
    }
    document.guidance.forEach((guidance, guidanceIndex) =>
      validateGuidance(
        guidance,
        `Fetched document ${document.catalogId} guidance ${guidanceIndex + 1}`,
      ),
    );
    const guidance = document.guidance.flatMap((item) => {
      const applicableDeclarationIds = declarationsByGuidance.get(
        `${document.catalogId}\u0000${item.section}`,
      );
      if (!applicableDeclarationIds?.length) return [];
      const excerpt = { ...item };
      delete excerpt.applicableDeclarationIds;
      return [{ ...excerpt, applicableDeclarationIds }];
    });
    const ranked = expectedDocuments[index];
    if (!ranked) {
      throw new Error(`Fetched document ${document.catalogId} has no ranked catalog entry.`);
    }
    return {
      ...ranked,
      retrieval: {
        status: /** @type {const} */ ("fetched"),
        retrievedAt: document.retrievedAt,
        contentHash: document.contentHash,
      },
      guidance,
      noRelevantGuidance: guidance.length === 0,
    };
  });
  const retrievalAttempts = decisions.failedRetrievals
    .map((item) => {
      const ranked = rankingById.get(item.catalogId);
      const catalogEntry = catalogById.get(item.catalogId);
      if (!ranked || !catalogEntry) {
        throw new Error(`Failed retrieval uses unranked catalog ID ${item.catalogId}.`);
      }
      return {
        rank: ranked.rank,
        canonicalUrl: catalogEntry.canonicalUrl,
        status: /** @type {const} */ ("failed"),
        error: item.error,
      };
    })
    .sort((left, right) => left.rank - right.rank);
  const guidance = rankedDocuments.flatMap((document) => document.guidance);
  return {
    evidence: {
      schemaVersion: 2,
      queryProfiles: requests.map((request) => ({
        reviewUnitId: request.reviewUnitId,
        queryProfile: request.queryProfile,
      })),
      catalogRanking: ranking,
      rankedDocuments,
      retrievalAttempts,
      blockers: decisions.searchBlockers,
      inputAccounting: {
        catalogEntriesScored: catalog.length,
        documentsFetched: decisions.fetchedDocuments.length,
        documentBytesFetched: decisions.fetchedDocuments.reduce(
          (total, document) => total + document.bytes,
          0,
        ),
        guidanceExcerptsRetained: guidance.length,
        guidanceExcerptBytesRetained: guidance.reduce(
          (total, item) => total + Buffer.byteLength(item.excerpt, "utf8"),
          0,
        ),
      },
    },
    catalogById,
    fetchedById: new Map(
      decisions.fetchedDocuments.map((item, index) => [item.catalogId, rankedDocuments[index]]),
    ),
  };
}

/**
 * @param {CompactDecisions} decisions
 * @param {AssessmentModelInput} modelInput
 * @param {InferenceCandidate[]} inferenceCandidates
 * @param {ComplianceSearchRequest[]} requests
 * @param {Map<string, CatalogEntry>} catalogById
 * @param {Map<string, MaterializedComplianceDocument>} fetchedById
 * @param {Map<string, string[]>} resolvedDeclarations
 * @returns {AssessmentJudgment}
 */
function materializeJudgment(
  decisions,
  modelInput,
  inferenceCandidates,
  requests,
  catalogById,
  fetchedById,
  resolvedDeclarations,
) {
  exactCoverage(
    modelInput.semanticReviewUnits.map((item) => item.reviewUnitId),
    decisions.semanticSummaries.map((item) => item.reviewUnitId),
    "Semantic summary",
  );
  for (const summary of decisions.semanticSummaries) {
    assertKeys(
      summary,
      ["reviewUnitId", "title", "summary"],
      `Semantic summary ${summary.reviewUnitId}`,
    );
    requireText(summary.title, `Semantic summary ${summary.reviewUnitId}.title`);
    requireText(summary.summary, `Semantic summary ${summary.reviewUnitId}.summary`);
  }
  const inferredRestIds = inferenceCandidates
    .filter((item) => item.dimension === "rest")
    .map((item) => item.id);
  const inferredDownstreamIds = inferenceCandidates
    .filter((item) => item.dimension === "downstream")
    .map((item) => item.id);
  exactCoverage(
    [...modelInput.restCandidates.map((item) => item.id), ...inferredRestIds],
    decisions.restDecisions.map((item) => item.candidateId),
    "REST decision",
  );
  exactCoverage(
    [...modelInput.downstreamCandidates.map((item) => item.id), ...inferredDownstreamIds],
    decisions.downstreamDecisions.map((item) => item.candidateId),
    "Downstream decision",
  );
  decisions.restDecisions.forEach((item) =>
    validateCandidateDecision(item, `REST decision ${item.candidateId}`),
  );
  decisions.downstreamDecisions.forEach((item) =>
    validateCandidateDecision(item, `Downstream decision ${item.candidateId}`),
  );

  exactCoverage(
    requests.map((item) => item.reviewUnitId),
    decisions.complianceJudgments.map((item) => item.reviewUnitId),
    "Compliance judgment",
  );
  const requestsByIntent = new Map(requests.map((request) => [request.reviewUnitId, request]));
  const complianceDecisions = decisions.complianceJudgments.map((judgment) => {
    assertKeys(
      judgment,
      [
        "reviewUnitId",
        "applicableGuidance",
        "declarationNames",
        "declarationIds",
        "decision",
        "title",
        "severity",
        "expected",
        "actual",
        "rationale",
      ],
      `Compliance judgment ${judgment.reviewUnitId}`,
    );
    requireArray(
      judgment.applicableGuidance,
      `Compliance judgment ${judgment.reviewUnitId}.applicableGuidance`,
    );
    if (
      duplicates(
        judgment.applicableGuidance.map((item) => `${item.catalogId}\u0000${item.guidanceSection}`),
      ).length
    ) {
      throw new Error(
        `Compliance judgment ${judgment.reviewUnitId} has duplicate guidance references.`,
      );
    }
    const request = requestsByIntent.get(judgment.reviewUnitId);
    const declarationIds = resolvedDeclarations.get(judgment.reviewUnitId);
    if (!request || !declarationIds) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} has no canonical request.`);
    }
    requireText(judgment.actual, `Compliance judgment ${judgment.reviewUnitId}.actual`);
    requireText(judgment.rationale, `Compliance judgment ${judgment.reviewUnitId}.rationale`);
    if (
      !["applicable-pass", "applicable-fail", "no-applicable-guidance", "not-assessed"].includes(
        judgment.decision,
      )
    ) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} has an invalid decision.`);
    }
    if (
      judgment.decision === "applicable-fail" &&
      (!judgment.title?.trim() || !isSeverity(judgment.severity))
    ) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} lacks finding presentation.`);
    }
    if (
      judgment.decision !== "applicable-fail" &&
      (judgment.title !== undefined || judgment.severity !== undefined)
    ) {
      throw new Error(
        `Compliance judgment ${judgment.reviewUnitId} has unexpected finding presentation.`,
      );
    }
    if (
      judgment.decision.startsWith("applicable-") &&
      (!judgment.expected?.trim() || !judgment.applicableGuidance.length || !declarationIds.length)
    ) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} lacks applicable evidence.`);
    }
    if (
      !judgment.decision.startsWith("applicable-") &&
      (judgment.expected !== undefined || judgment.applicableGuidance.length)
    ) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} has inapplicable guidance.`);
    }
    const applicableGuidance = judgment.applicableGuidance.map((reference) => {
      assertKeys(
        reference,
        ["catalogId", "guidanceSection"],
        `Compliance judgment ${judgment.reviewUnitId} guidance`,
      );
      const catalog = catalogById.get(reference.catalogId);
      const document = fetchedById.get(reference.catalogId);
      if (!catalog || !document) {
        throw new Error(
          `Compliance judgment ${judgment.reviewUnitId} cites an unfetched catalog entry.`,
        );
      }
      const guidance = document.guidance.find((item) => item.section === reference.guidanceSection);
      if (
        !guidance ||
        !guidance.applicableDeclarationIds.some((id) => declarationIds.includes(id))
      ) {
        throw new Error(`Compliance judgment ${judgment.reviewUnitId} cites unowned guidance.`);
      }
      return {
        canonicalDocumentUrl: catalog.canonicalUrl,
        guidanceSection: reference.guidanceSection,
      };
    });
    return {
      reviewUnitId: judgment.reviewUnitId,
      applicableGuidance,
      sourceChangeIds: request.sourceChangeIds,
      hunkIds: request.hunkIds,
      declarationIds,
      decision: judgment.decision,
      ...(judgment.title === undefined ? {} : { title: judgment.title }),
      ...(judgment.severity === undefined ? {} : { severity: judgment.severity }),
      ...(judgment.expected === undefined ? {} : { expected: judgment.expected }),
      actual: judgment.actual,
      rationale: judgment.rationale,
    };
  });
  return {
    schemaVersion: 1,
    semanticIntents: decisions.semanticSummaries,
    restDecisions: decisions.restDecisions,
    downstreamDecisions: decisions.downstreamDecisions,
    complianceDecisions,
    overallConfidence: decisions.overallConfidence,
    blockers: decisions.blockers,
  };
}

/**
 * @param {unknown} decisions
 * @returns {asserts decisions is CompactDecisions}
 */
export function validateCompactDecisions(decisions) {
  assertKeys(
    decisions,
    [
      "schemaVersion",
      "semanticSummaries",
      "restDecisions",
      "downstreamDecisions",
      "inferenceResults",
      "catalogScores",
      "fetchedDocuments",
      "failedRetrievals",
      "searchBlockers",
      "complianceJudgments",
      "overallConfidence",
      "blockers",
    ],
    "Agent decisions",
  );
  if (decisions.schemaVersion !== 1) {
    throw new Error("Unsupported Agent decisions schemaVersion.");
  }
  for (const field of [
    "semanticSummaries",
    "restDecisions",
    "downstreamDecisions",
    "catalogScores",
    "fetchedDocuments",
    "failedRetrievals",
    "searchBlockers",
    "complianceJudgments",
    "blockers",
  ]) {
    const items = decisions[field];
    requireArray(items, `Agent decisions.${field}`);
  }
  if (decisions.inferenceResults !== undefined) {
    requireArray(decisions.inferenceResults, "Agent decisions.inferenceResults");
  }
  if (!isSeverity(decisions.overallConfidence)) {
    throw new Error("Agent decisions.overallConfidence is invalid.");
  }
  for (const field of /** @type {const} */ (["searchBlockers", "blockers"])) {
    const items = decisions[field];
    requireArray(items, `Agent decisions.${field}`);
    items.forEach((item, index) => requireText(item, `Agent decisions.${field}[${index}]`));
  }
}

/**
 * @param {MaterializedSearchEvidence} evidence
 * @returns {asserts evidence is SearchEvidence}
 */
function assertSearchEvidence(evidence) {
  if (!evidence.catalogRanking.length) {
    throw new Error("Azure Guidelines search evidence requires a ranked catalog.");
  }
  if (evidence.rankedDocuments.length > 4) {
    throw new Error("Azure Guidelines search evidence contains too many ranked documents.");
  }
  for (const document of evidence.rankedDocuments) {
    for (const guidance of document.guidance) {
      if (!guidance.applicableDeclarationIds.length) {
        throw new Error(`Guidance ${guidance.section} requires an applicable declaration.`);
      }
    }
  }
}

/**
 * @param {AgentIndex} index
 * @param {AssessmentModelInput} modelInput
 */
function validateIndexCoverage(index, modelInput) {
  if (index.input?.path !== "model-input.json") {
    throw new Error("Agent index must reference canonical model-input.json.");
  }
  const coverage = index.coverage ?? {};
  exactCoverage(
    modelInput.semanticReviewUnits.map((item) => item.reviewUnitId),
    coverage.semanticIntentIds ?? [],
    "Agent index Semantic intent",
  );
  exactCoverage(
    modelInput.restCandidates.map((item) => item.id),
    coverage.restCandidateIds ?? [],
    "Agent index REST candidate",
  );
  exactCoverage(
    modelInput.downstreamCandidates.map((item) => item.id),
    coverage.downstreamCandidateIds ?? [],
    "Agent index downstream candidate",
  );
  exactCoverage(
    modelInput.inferenceRequests.map((item) => item.requestId),
    coverage.inferenceRequestIds ?? [],
    "Agent index inference request",
  );
  exactCoverage(
    modelInput.complianceSearchRequests.map((item) => item.requestId),
    coverage.guidelineRequestIds ?? [],
    "Agent index compliance request",
  );
  if (
    index.requiredOutputs?.agentDecisions !== DECISIONS_FILE ||
    index.requiredOutputs?.materialized?.inference !==
      (modelInput.inferenceRequests.length ? "inference.json" : null) ||
    index.requiredOutputs?.materialized?.guidelineEvidence !== "compliance-search-evidence.json" ||
    index.requiredOutputs?.materialized?.judgment !== "assessment-judgment.json" ||
    index.requiredOutputs?.schemas?.agentDecisions !== "scripts/agent-decisions.schema.json" ||
    index.materialization?.script !== "scripts/materialize-assessment-results.mjs"
  ) {
    throw new Error("Agent index does not advertise the materializer contract.");
  }
}

/**
 * @param {string} root
 * @param {Iterable<[string, unknown]>} artifacts
 */
function writeArtifactsAtomically(root, artifacts) {
  const transaction = `${process.pid}.${Date.now()}`;
  /** @type {{target: string, temporary: string, remove: boolean}[]} */
  const staged = [];
  /** @type {{target: string, backup: string}[]} */
  const backups = [];
  try {
    for (const [relativePath, value] of artifacts) {
      const target = resolveWorkPath(root, relativePath);
      fs.mkdirSync(path.dirname(target), { recursive: true });
      const temporary = `${target}.${transaction}.tmp`;
      if (value !== undefined) {
        fs.writeFileSync(temporary, `${JSON.stringify(value, null, 2)}\n`);
      }
      staged.push({ target, temporary, remove: value === undefined });
    }
    for (const item of staged) {
      if (fs.existsSync(item.target)) {
        const backup = `${item.target}.${transaction}.bak`;
        fs.renameSync(item.target, backup);
        backups.push({ target: item.target, backup });
      }
    }
    for (const item of staged) {
      if (!item.remove) fs.renameSync(item.temporary, item.target);
    }
    for (const item of backups) {
      try {
        fs.rmSync(item.backup, { force: true });
      } catch {
        // The committed outputs are authoritative; a stale backup is harmless.
      }
    }
  } catch (error) {
    for (const item of staged) {
      fs.rmSync(item.temporary, { force: true });
      if (!item.remove && fs.existsSync(item.target)) {
        fs.rmSync(item.target, { force: true });
      }
    }
    for (const item of backups.reverse()) {
      if (fs.existsSync(item.backup)) fs.renameSync(item.backup, item.target);
    }
    throw error;
  }
}

/** @param {unknown} error */
function compactError(error) {
  return (error instanceof Error ? error.message : String(error))
    .split(/\r?\n/)
    .filter(Boolean)
    .slice(0, 12)
    .join("\n");
}

/**
 * @param {{work: string, decisions?: string}} options
 */
export function materializeAssessmentResults({ work, decisions: decisionsPath = DECISIONS_FILE }) {
  const root = path.resolve(work);
  const started = performance.now();
  try {
    const index = /** @type {AgentIndex} */ (readJsonObject(resolveWorkPath(root, INDEX_FILE)));
    const workflowState = readWorkflowState(root);
    if (
      canonicalJson(index.canonicalArtifactHashes ?? {}) !==
      canonicalJson(workflowState?.artifactHashes ?? {})
    ) {
      throw new Error("Agent index canonical hashes do not match workflow-state.json.");
    }
    const hashErrors = verifyArtifactHashes(root, index.canonicalArtifactHashes);
    if (hashErrors.length) {
      throw new Error(
        `Canonical assessment inputs changed; rerun deterministic analysis.\n${hashErrors.join("\n")}`,
      );
    }
    transitionWorkflowState(root, "materializing-agent-results", {
      failure: undefined,
    });
    if (!index.input?.path) {
      throw new Error("Agent index must declare its model input path.");
    }
    const modelInput = /** @type {AssessmentModelInput} */ (
      readJsonObject(resolveWorkPath(root, index.input.path))
    );
    validateIndexCoverage(index, modelInput);
    /** @type {Map<string, Record<string, unknown>>} */
    const artifacts = new Map();
    for (const relativePath of Object.values(modelInput.artifactReferences ?? {})) {
      artifacts.set(
        relativePath.replaceAll("\\", "/"),
        readJsonObject(resolveWorkPath(root, relativePath)),
      );
    }
    const agentDecisions = readJsonObject(resolveWorkPath(root, decisionsPath));
    validateCompactDecisions(agentDecisions);
    const requests = canonicalRequests(modelInput, artifacts);
    const catalog = readComplianceCatalog();
    const sourceArtifact = modelInput.artifactReferences?.sourceIndex ?? "source/source-index.json";
    const rawSourceChanges = artifacts.get(sourceArtifact.replaceAll("\\", "/"))?.sourceChanges;
    requireArray(rawSourceChanges, "Canonical source changes");
    const sourceChanges = /** @type {SourceChange[]} */ (rawSourceChanges);
    const resolvedDeclarations = resolveComplianceJudgmentDeclarations(
      agentDecisions,
      requests,
      sourceChanges,
    );
    const { inference, candidates } = materializeInference(agentDecisions, modelInput);
    const { evidence, catalogById, fetchedById } = materializeSearch(
      agentDecisions,
      requests,
      catalog,
      resolvedDeclarations,
    );
    const judgment = materializeJudgment(
      agentDecisions,
      modelInput,
      candidates,
      requests,
      catalogById,
      fetchedById,
      resolvedDeclarations,
    );
    if (requests.length) {
      assertSearchEvidence(evidence);
      assembleCompliance({
        requests,
        evidence,
        decisions: judgment.complianceDecisions,
        sourceChanges,
      });
    }
    /** @type {[string, unknown][]} */
    const outputArtifacts = [
      ["inference.json", inference],
      ["compliance-search-evidence.json", evidence],
      ["assessment-judgment.json", judgment],
    ];
    writeArtifactsAtomically(root, outputArtifacts);
    const outputBytes = outputArtifacts.reduce((total, [relativePath, value]) => {
      return value === undefined
        ? total
        : total + fs.statSync(resolveWorkPath(root, relativePath)).size;
    }, 0);
    const materializationMs = Math.round(performance.now() - started);
    transitionWorkflowState(root, "awaiting-finalization", {
      artifacts: {
        ...(workflowState?.artifacts ?? {}),
        inference: inference ? "inference.json" : null,
        guidelineEvidence: "compliance-search-evidence.json",
        judgment: "assessment-judgment.json",
        agentDecisions: decisionsPath,
      },
      failure: undefined,
      telemetry: {
        materializedAt: new Date().toISOString(),
        materializationMs,
        materializedOutputBytes: outputBytes,
        agentDecisionBytes: fs.statSync(resolveWorkPath(root, decisionsPath)).size,
      },
    });
    return {
      inferencePath: inference ? resolveWorkPath(root, "inference.json") : null,
      guidelineEvidencePath: resolveWorkPath(root, "compliance-search-evidence.json"),
      judgmentPath: resolveWorkPath(root, "assessment-judgment.json"),
      materializationMs,
      outputBytes,
    };
  } catch (error) {
    const message = compactError(error);
    transitionWorkflowState(root, "awaiting-agent-judgment", {
      failure: {
        code: "materialization-failed",
        message,
        recordedAt: new Date().toISOString(),
      },
      telemetry: {
        materializationMs: Math.round(performance.now() - started),
      },
    });
    throw new Error(message, { cause: error });
  }
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2), { required: ["work"] });
    const work = args.work;
    const decisions = args.decisions;
    if (typeof work !== "string") {
      throw new Error("--work must be a string.");
    }
    if (decisions !== undefined && typeof decisions !== "string") {
      throw new Error("--decisions must be a string.");
    }
    const result = materializeAssessmentResults({
      work,
      decisions,
    });
    console.log(
      JSON.stringify({
        inference: result.inferencePath,
        guidelineEvidence: result.guidelineEvidencePath,
        judgment: result.judgmentPath,
        materializationMs: result.materializationMs,
        outputBytes: result.outputBytes,
      }),
    );
  });
}
