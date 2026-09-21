import fs from "node:fs";
import path from "node:path";
import { isMain, parseArgs, readJson, runMain } from "./cli.mjs";
import {
  assembleCompliance,
  readComplianceCatalog,
  resolveDocumentSelections,
  searchInputAccounting,
} from "./compliance-assessment.mjs";
import {
  readWorkflowState,
  resolveWorkPath,
  transitionWorkflowState,
  verifyArtifactHashes,
} from "./workflow-state.mjs";
import { canonicalJson } from "./stable-id.mjs";

const INDEX_FILE = "agent-workspace/agent-index.json";
const DECISIONS_FILE = "agent-workspace/agent-decisions.json";
const VERSION_EVOLUTION_RULE = "versioned-api-evolution-guidance";
const STANDARD_ARM_RULES = new Set([
  "arm-operation-interface-guidance",
  "arm-operation-template-guidance",
  "arm-resource-modeling-guidance",
]);
const VERSIONING_DECORATORS = new Set([
  "@added",
  "@madeOptional",
  "@madeRequired",
  "@removed",
  "@renamedFrom",
  "@returnTypeChangedFrom",
  "@typeChangedFrom",
  "@useDependency",
  "@versioned",
]);

function assertObject(value, label) {
  if (!value || typeof value !== "object" || Array.isArray(value)) {
    throw new Error(`${label} must be an object.`);
  }
}

function assertKeys(value, allowed, label) {
  assertObject(value, label);
  const unknown = Object.keys(value).filter((key) => !allowed.includes(key));
  if (unknown.length) {
    throw new Error(`${label} contains unknown fields: ${unknown.join(", ")}.`);
  }
}

function requireArray(value, label) {
  if (!Array.isArray(value)) throw new Error(`${label} must be an array.`);
}

function requireText(value, label) {
  if (typeof value !== "string" || !value.trim()) {
    throw new Error(`${label} must be a nonempty string.`);
  }
}

function duplicates(values) {
  const seen = new Set();
  return [
    ...new Set(
      values.filter((value) =>
        seen.has(value) ? true : (seen.add(value), false),
      ),
    ),
  ];
}

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

function subset(actual, expected, label) {
  requireArray(actual, label);
  if (
    duplicates(actual).length ||
    actual.some((item) => !expected.includes(item))
  ) {
    throw new Error(`${label} contains an unknown or duplicate ID.`);
  }
}

function validateCandidateDecision(decision, label) {
  assertKeys(
    decision,
    ["candidateId", "decision", "severity", "rationale"],
    label,
  );
  requireText(decision.candidateId, `${label}.candidateId`);
  requireText(decision.rationale, `${label}.rationale`);
  if (!["approve", "reject"].includes(decision.decision)) {
    throw new Error(`${label} has an invalid decision.`);
  }

  if (
    decision.decision === "approve" &&
    !["high", "medium", "low"].includes(decision.severity)
  ) {
    throw new Error(`${label} approve requires a severity.`);
  }
  if (decision.decision === "reject" && decision.severity !== undefined) {
    throw new Error(`${label} reject must omit severity.`);
  }
}

function versionEvolutionSelection(request) {
  return request.guidanceRouting.selections.find(
    (selection) => selection.ruleId === VERSION_EVOLUTION_RULE,
  );
}

function hasChangedVersioningDecorator(request) {
  return (request.queryProfile.changedTokens ?? []).some((token) =>
    VERSIONING_DECORATORS.has(token),
  );
}

function newLegacyArmUsages(request) {
  if (request.queryProfile.action !== "add") return [];
  if (
    !(request.queryProfile.declarationKinds ?? []).some((kind) =>
      ["interface", "model", "operation"].includes(kind),
    )
  ) {
    return [];
  }
  return (request.queryProfile.changedTokens ?? []).filter((token) =>
    /^@?Azure\.ResourceManager\.Legacy(?:\.|$)/.test(token),
  );
}

function standardArmCatalogIds(request) {
  return request.guidanceRouting.selections
    .filter((selection) => STANDARD_ARM_RULES.has(selection.ruleId))
    .map((selection) => selection.catalogId);
}

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
  const requestsById = new Map(
    requests.map((request) => [request.requestId, request]),
  );
  const candidateIds = [];
  const candidates = [];
  const results = compact.map((result) => {
    assertKeys(
      result,
      ["requestId", "decision", "rationale", "candidates"],
      `Inference result ${result.requestId ?? "<unknown>"}`,
    );
    const request = requestsById.get(result.requestId);
    requireText(result.rationale, `Inference result ${result.requestId}.rationale`);
    requireArray(result.candidates, `Inference result ${result.requestId}.candidates`);
    if (!["candidates", "no-impact", "blocked"].includes(result.decision)) {
      throw new Error(`Inference result ${result.requestId} has an invalid decision.`);
    }
    if (
      (result.decision === "candidates") !== (result.candidates.length > 0)
    ) {
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
      if (
        candidate.dimension === "downstream" &&
        !candidate.crossLanguageDefinitionId?.trim()
      ) {
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

function canonicalRequests(modelInput, artifacts) {
  const compactRequests = modelInput.complianceSearchRequests ?? [];
  exactCoverage(
    modelInput.semanticReviewUnits.map((item) => item.reviewUnitId),
    compactRequests.map((item) => item.reviewUnitId),
    "Assessed compliance intent",
  );
  const artifactPath = modelInput.artifactReferences?.complianceSearchRequests;
  if (!compactRequests.length && !artifactPath) return [];
  if (!artifactPath) {
    throw new Error("Missing canonical compliance search request artifact.");
  }
  const artifact = artifacts.get(artifactPath.replaceAll("\\", "/"));
  requireArray(artifact?.requests, "Canonical compliance search requests");
  exactCoverage(
    compactRequests.map((item) => item.requestId),
    artifact.requests.map((item) => item.requestId),
    "Canonical compliance search request",
  );
  if (
    duplicates(artifact.requests.map((item) => item.requestId)).length ||
    duplicates(artifact.requests.map((item) => item.reviewUnitId)).length
  ) {
    throw new Error(
      "Canonical compliance search requests contain duplicate ownership.",
    );
  }
  const compactById = new Map(
    compactRequests.map((item) => [item.requestId, item]),
  );
  const semanticPath = modelInput.artifactReferences?.semanticReviewUnits;
  const semantic = artifacts.get(semanticPath?.replaceAll("\\", "/"))?.reviewUnits ?? [];
  for (const request of artifact.requests) {
    const compact = compactById.get(request.requestId);
    if (request.reviewUnitId !== compact.reviewUnitId) {
      throw new Error(
        `Canonical compliance search request ${request.requestId} has cross-intent ownership.`,
      );
    }
    for (const field of ["referenceCategories", "guidanceRouting"]) {
      if (canonicalJson(request[field]) !== canonicalJson(compact[field])) {
        throw new Error(`Canonical compliance request ${request.requestId} changed ${field}; rerun deterministic analysis.`);
      }
    }
    const unit = semantic.find((item) => item.id === request.reviewUnitId);
    if (!unit || ["api-version-publication", "api-version-wide-change"].includes(unit.intentType) ||
      canonicalJson(unit.referenceCategories) !== canonicalJson(request.referenceCategories)) {
      throw new Error(`Compliance request ${request.requestId} differs from canonical semantic category ownership.`);
    }
    for (const field of ["sourceChangeIds", "hunkIds", "declarationIds"]) {
      exactCoverage(unit[field] ?? [], request[field] ?? [], `Compliance request ${request.requestId} ${field}`);
    }
  }
  return artifact.requests;
}

function validateGuidance(guidance, label) {
  assertKeys(
    guidance,
    [
      "section",
      "excerpt",
      "queryTerms",
      "examples",
      "applicableDeclarationIds",
    ],
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
    requireArray(
      guidance.applicableDeclarationIds,
      `${label}.applicableDeclarationIds`,
    );
  }
}

function resolveComplianceJudgmentDeclarations(
  decisions,
  requests,
  sourceChanges,
) {
  exactCoverage(
    requests.map((item) => item.reviewUnitId),
    decisions.complianceJudgments.map((item) => item.reviewUnitId),
    "Compliance judgment",
  );
  const requestsByIntent = new Map(
    requests.map((request) => [request.reviewUnitId, request]),
  );
  const sourcesById = new Map(
    sourceChanges.map((source) => [source.id, source]),
  );
  const declarationsByIntent = new Map();
  const intentsByName = new Map();
  for (const request of requests) {
    const requestedIds = new Set(request.declarationIds ?? []);
    const declarations = request.sourceChangeIds.flatMap(
      (sourceId) => (sourcesById.get(sourceId)?.declarations ?? [])
        .map((declaration) => ({ ...declaration, sourceChangeId: sourceId })),
    );
    const eligible = declarations.filter((item) => requestedIds.has(item.id));
    const foundIds = new Set(eligible.map((item) => item.id));
    const missing = [...requestedIds].filter((id) => !foundIds.has(id));
    if (missing.length) {
      throw new Error(
        `Compliance request ${request.requestId} has declarations missing from its source: ${missing.join(", ")}.`,
      );
    }
    const byName = new Map();
    for (const declaration of eligible) {
      requireText(
        declaration.qualifiedName,
        `Compliance declaration ${declaration.id}.qualifiedName`,
      );
      const matches = byName.get(declaration.qualifiedName) ?? [];
      matches.push(declaration);
      byName.set(declaration.qualifiedName, matches);
      const owners = intentsByName.get(declaration.qualifiedName) ?? new Set();
      owners.add(request.reviewUnitId);
      intentsByName.set(declaration.qualifiedName, owners);
    }
    declarationsByIntent.set(request.reviewUnitId, byName);
  }

  const resolved = new Map();
  for (const judgment of decisions.complianceJudgments) {
    requireArray(
      judgment.applicableGuidance,
      `Compliance judgment ${judgment.reviewUnitId}.applicableGuidance`,
    );
    const request = requestsByIntent.get(judgment.reviewUnitId);
    const usesNames = judgment.declarationNames !== undefined;
    const usesIds = judgment.declarationIds !== undefined;
    if (usesNames === usesIds) {
      throw new Error(
        `Compliance judgment ${judgment.reviewUnitId} must use exactly one of declarationNames or legacy declarationIds.`,
      );
    }
    if (usesIds) {
      subset(
        judgment.declarationIds,
        request.declarationIds ?? [],
        `Compliance judgment ${judgment.reviewUnitId}.declarationIds`,
      );
      resolved.set(judgment.reviewUnitId, [...judgment.declarationIds].sort());
      continue;
    }
    requireArray(
      judgment.declarationNames,
      `Compliance judgment ${judgment.reviewUnitId}.declarationNames`,
    );
    const duplicateNames = duplicates(judgment.declarationNames);
    if (duplicateNames.length) {
      throw new Error(
        `Compliance judgment ${judgment.reviewUnitId} has duplicate declaration names: ${duplicateNames.join(", ")}.`,
      );
    }
    const ownDeclarations = declarationsByIntent.get(judgment.reviewUnitId);
    const resolvedIds = judgment.declarationNames.flatMap((name) => {
      requireText(
        name,
        `Compliance judgment ${judgment.reviewUnitId}.declarationNames`,
      );
      const matches = ownDeclarations.get(name) ?? [];
      const revisionPair = matches.length === 2 &&
        new Set(matches.map((item) => item.source?.revision)).size === 2 &&
        matches.every((item) => ["base", "current"].includes(item.source?.revision)) &&
        matches[0].sourceChangeId === matches[1].sourceChangeId &&
        matches[0].kind && matches[0].kind === matches[1].kind;
      if (matches.length > 1 && !revisionPair) {
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
      return matches.map((item) => item.id);
    });
    resolved.set(judgment.reviewUnitId, [...resolvedIds].sort());
  }
  return resolved;
}

function citedGuidanceDeclarations(decisions, requests, resolvedDeclarations) {
  const judgmentsByIntent = new Map(
    decisions.complianceJudgments.map((item) => [item.reviewUnitId, item]),
  );
  const declarationsByGuidance = new Map();
  for (const request of requests) {
    const judgment = judgmentsByIntent.get(request.reviewUnitId);
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
      for (const declarationId of resolvedDeclarations.get(
        judgment.reviewUnitId,
      )) {
        declarationIds.add(declarationId);
      }
      declarationsByGuidance.set(key, declarationIds);
    }
  }
  return new Map(
    [...declarationsByGuidance].map(([key, declarationIds]) => [
      key,
      [...declarationIds].sort(),
    ]),
  );
}

function materializeSearch(
  decisions,
  requests,
  catalog,
  resolvedDeclarations,
) {
  const catalogById = new Map(catalog.map((item) => [item.catalogId, item]));
  const declarationsByGuidance = citedGuidanceDeclarations(
    decisions,
    requests,
    resolvedDeclarations,
  );
  const { documentSelections } = resolveDocumentSelections({
    requests,
    discoveryResults: decisions.discoveryResults,
    additionalSelections: decisions.additionalSelections,
    documents: decisions.fetchedDocuments,
    catalog,
  });
  const selectedIds = [...new Set(documentSelections.map((item) => item.catalogId))];
  const failedIds = decisions.failedRetrievals.map((item) => item.catalogId);
  const fetchedIds = decisions.fetchedDocuments.map((item) => item.catalogId);
  subset(failedIds, selectedIds, "Failed retrieval selection provenance");
  subset(fetchedIds, selectedIds, "Fetched document selection provenance");
  for (const retrieval of decisions.failedRetrievals) {
    assertKeys(retrieval, ["catalogId", "error"], `Failed retrieval ${retrieval.catalogId}`);
    requireText(retrieval.error, `Failed retrieval ${retrieval.catalogId}.error`);
  }
  if (fetchedIds.some((id) => failedIds.includes(id))) {
    throw new Error("A catalog entry cannot be both fetched and failed.");
  }
  const documents = decisions.fetchedDocuments.map((document, index) => {
    assertKeys(
      document,
      [
        "catalogId",
        "retrievedAt",
        "contentHash",
        "retrievalSource",
        "bytes",
        "guidance",
        "noRelevantGuidance",
      ],
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
    if (!["network", "session-reuse"].includes(document.retrievalSource)) {
      throw new Error(`Fetched document ${document.catalogId} requires retrievalSource network or session-reuse.`);
    }
    if (!Number.isInteger(document.bytes) || document.bytes < 1) {
      throw new Error(`Fetched document ${document.catalogId} has invalid bytes.`);
    }
    requireArray(document.guidance, `Fetched document ${document.catalogId}.guidance`);
    if (typeof document.noRelevantGuidance !== "boolean") {
      throw new Error(`Fetched document ${document.catalogId} requires noRelevantGuidance.`);
    }
    if (document.noRelevantGuidance === (document.guidance.length > 0)) {
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
    const guidance = document.guidance.map((item) => {
      const applicableDeclarationIds = declarationsByGuidance.get(
        `${document.catalogId}\u0000${item.section}`,
      ) ?? [];
      const { applicableDeclarationIds: _legacy, ...excerpt } = item;
      return { ...excerpt, applicableDeclarationIds };
    });
    const entry = catalogById.get(document.catalogId);
    return {
      catalogId: entry.catalogId,
      catalogOrder: entry.catalogOrder,
      title: entry.title,
      canonicalUrl: entry.canonicalUrl,
      retrieval: {
        status: "fetched",
        retrievedAt: document.retrievedAt,
        contentHash: document.contentHash,
        retrievalSource: document.retrievalSource,
        bytes: document.bytes,
      },
      guidance,
      noRelevantGuidance: guidance.length === 0,
    };
  }).sort((left, right) => left.catalogOrder - right.catalogOrder);
  const retrievalAttempts = decisions.failedRetrievals
    .map((item) => ({
      catalogId: item.catalogId,
      canonicalUrl: catalogById.get(item.catalogId).canonicalUrl,
      status: "failed",
      error: item.error,
    }))
    .sort((left, right) => catalogById.get(left.catalogId).catalogOrder - catalogById.get(right.catalogId).catalogOrder);
  const evidence = {
      schemaVersion: 3,
      queryProfiles: requests.map((request) => ({
        reviewUnitId: request.reviewUnitId,
        queryProfile: request.queryProfile,
      })),
      documentSelections,
      documents,
      discoveryResults: decisions.discoveryResults,
      additionalSelections: decisions.additionalSelections,
      retrievalAttempts,
      blockers: decisions.searchBlockers,
  };
  evidence.inputAccounting = searchInputAccounting(evidence);
  return {
    evidence,
    catalogById,
    fetchedById: new Map(
      documents.map((item) => [
        item.catalogId,
        item,
      ]),
    ),
  };
}

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
    assertKeys(summary, ["reviewUnitId", "title", "summary"], `Semantic summary ${summary.reviewUnitId}`);
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
    [
      ...modelInput.downstreamCandidates.map((item) => item.id),
      ...inferredDownstreamIds,
    ],
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
  const requestsByIntent = new Map(
    requests.map((request) => [request.reviewUnitId, request]),
  );
  const complianceDecisions = decisions.complianceJudgments.map((judgment) => {
    assertKeys(
      judgment,
      [
        "reviewUnitId",
        "reviewedCatalogIds",
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
    requireArray(judgment.applicableGuidance, `Compliance judgment ${judgment.reviewUnitId}.applicableGuidance`);
    if (
      duplicates(
        judgment.applicableGuidance.map(
          (item) => `${item.catalogId}\u0000${item.guidanceSection}`,
        ),
      ).length
    ) {
      throw new Error(
        `Compliance judgment ${judgment.reviewUnitId} has duplicate guidance references.`,
      );
    }
    const request = requestsByIntent.get(judgment.reviewUnitId);
    const declarationIds = resolvedDeclarations.get(judgment.reviewUnitId);
    requireText(judgment.actual, `Compliance judgment ${judgment.reviewUnitId}.actual`);
    requireText(judgment.rationale, `Compliance judgment ${judgment.reviewUnitId}.rationale`);
    if (
      ![
        "applicable-pass",
        "applicable-fail",
        "no-applicable-guidance",
        "not-assessed",
      ].includes(judgment.decision)
    ) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} has an invalid decision.`);
    }
    const evolutionSelection = versionEvolutionSelection(request);
    if (evolutionSelection && judgment.decision !== "not-assessed") {
      if (
        !judgment.applicableGuidance.some(
          (reference) => reference.catalogId === evolutionSelection.catalogId,
        )
      ) {
        throw new Error(
          `Compliance judgment ${judgment.reviewUnitId} must apply Evolving APIs guidance to versioned API evolution.`,
        );
      }
      if (
        !hasChangedVersioningDecorator(request) &&
        judgment.decision !== "applicable-fail"
      ) {
        throw new Error(
          `Compliance judgment ${judgment.reviewUnitId} must fail existing-version evolution without a changed versioning decorator.`,
        );
      }
    }
    const legacyUsages = newLegacyArmUsages(request);
    if (legacyUsages.length && judgment.decision !== "not-assessed") {
      if (judgment.decision !== "applicable-fail") {
        throw new Error(
          `Compliance judgment ${judgment.reviewUnitId} must fail new declarations that use Azure.ResourceManager.Legacy constructs: ${legacyUsages.join(", ")}.`,
        );
      }
      const standardCatalogIds = standardArmCatalogIds(request);
      if (
        !standardCatalogIds.length ||
        !judgment.applicableGuidance.some((reference) =>
          standardCatalogIds.includes(reference.catalogId),
        )
      ) {
        throw new Error(
          `Compliance judgment ${judgment.reviewUnitId} must cite current standard ARM guidance for new legacy usage.`,
        );
      }
    }
    if (
      judgment.decision === "applicable-fail" &&
      (!judgment.title?.trim() ||
        !["high", "medium", "low"].includes(judgment.severity))
    ) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} lacks finding presentation.`);
    }
    if (
      judgment.decision !== "applicable-fail" &&
      (judgment.title !== undefined || judgment.severity !== undefined)
    ) {
      throw new Error(`Compliance judgment ${judgment.reviewUnitId} has unexpected finding presentation.`);
    }
    if (
      judgment.decision.startsWith("applicable-") &&
      (!judgment.expected?.trim() ||
        !judgment.applicableGuidance.length ||
      !declarationIds.length)
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
      const guidance = document.guidance.find(
        (item) => item.section === reference.guidanceSection,
      );
      if (
        !guidance ||
        !guidance.applicableDeclarationIds.some((id) =>
          declarationIds.includes(id),
        )
      ) {
        throw new Error(
          `Compliance judgment ${judgment.reviewUnitId} cites unowned guidance.`,
        );
      }
      return {
        canonicalDocumentUrl: catalog.canonicalUrl,
        guidanceSection: reference.guidanceSection,
      };
    });
    return {
      reviewUnitId: judgment.reviewUnitId,
      reviewedCatalogIds: judgment.reviewedCatalogIds,
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
    schemaVersion: 2,
    semanticIntents: decisions.semanticSummaries,
    restDecisions: decisions.restDecisions,
    downstreamDecisions: decisions.downstreamDecisions,
    complianceDecisions,
    overallConfidence: decisions.overallConfidence,
    blockers: decisions.blockers,
  };
}

export function validateCompactDecisions(decisions) {
  if (decisions?.schemaVersion !== 2 || decisions?.catalogScores !== undefined) {
    throw new Error("Unsupported ranked Agent decisions; rerun deterministic analysis and Agent judgment using schemaVersion 2.");
  }
  assertKeys(
    decisions,
    [
      "schemaVersion",
      "semanticSummaries",
      "restDecisions",
      "downstreamDecisions",
      "inferenceResults",
      "discoveryResults",
      "additionalSelections",
      "fetchedDocuments",
      "failedRetrievals",
      "searchBlockers",
      "complianceJudgments",
      "overallConfidence",
      "blockers",
    ],
    "Agent decisions",
  );
  for (const field of [
    "semanticSummaries",
    "restDecisions",
    "downstreamDecisions",
    "discoveryResults",
    "additionalSelections",
    "fetchedDocuments",
    "failedRetrievals",
    "searchBlockers",
    "complianceJudgments",
    "blockers",
  ]) {
    requireArray(decisions[field], `Agent decisions.${field}`);
  }
  if (decisions.inferenceResults !== undefined) {
    requireArray(decisions.inferenceResults, "Agent decisions.inferenceResults");
  }
  if (!["high", "medium", "low"].includes(decisions.overallConfidence)) {
    throw new Error("Agent decisions.overallConfidence is invalid.");
  }
  for (const field of ["blockers"]) {
    decisions[field].forEach((item, index) =>
      requireText(item, `Agent decisions.${field}[${index}]`),
    );
  }
}

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
    index.requiredOutputs?.materialized?.guidelineEvidence !==
      "compliance-search-evidence.json" ||
    index.requiredOutputs?.materialized?.judgment !==
      "assessment-judgment.json" ||
    index.requiredOutputs?.schemas?.agentDecisions !==
      "scripts/agent-decisions.schema.json" ||
    index.materialization?.script !==
      "scripts/materialize-assessment-results.mjs"
  ) {
    throw new Error("Agent index does not advertise the materializer contract.");
  }
}

function writeArtifactsAtomically(root, artifacts) {
  const transaction = `${process.pid}.${Date.now()}`;
  const staged = [];
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

function compactError(error) {
  return (error instanceof Error ? error.message : String(error))
    .split(/\r?\n/)
    .filter(Boolean)
    .slice(0, 12)
    .join("\n");
}

export function materializeAssessmentResults({
  work,
  decisions: decisionsPath = DECISIONS_FILE,
}) {
  const root = path.resolve(work);
  const started = performance.now();
  try {
    const index = readJson(resolveWorkPath(root, INDEX_FILE));
    const workflowState = readWorkflowState(root);
    if (
      canonicalJson(index.canonicalArtifactHashes ?? {}) !==
      canonicalJson(workflowState?.artifactHashes ?? {})
    ) {
      throw new Error(
        "Agent index canonical hashes do not match workflow-state.json.",
      );
    }
    const hashErrors = verifyArtifactHashes(
      root,
      index.canonicalArtifactHashes,
    );
    if (hashErrors.length) {
      throw new Error(
        `Canonical assessment inputs changed; rerun deterministic analysis.\n${hashErrors.join("\n")}`,
      );
    }
    transitionWorkflowState(root, "materializing-agent-results", {
      failure: undefined,
    });
    const modelInput = readJson(resolveWorkPath(root, index.input?.path));
    validateIndexCoverage(index, modelInput);
    const artifacts = new Map();
    for (const relativePath of Object.values(
      modelInput.artifactReferences ?? {},
    )) {
      artifacts.set(
        relativePath.replaceAll("\\", "/"),
        readJson(resolveWorkPath(root, relativePath)),
      );
    }
    const agentDecisions = readJson(resolveWorkPath(root, decisionsPath));
    validateCompactDecisions(agentDecisions);
    const requests = canonicalRequests(modelInput, artifacts);
    const catalog = readComplianceCatalog();
    const sourceArtifact =
      modelInput.artifactReferences?.sourceIndex ?? "source/source-index.json";
    const sourceChanges =
      artifacts.get(sourceArtifact.replaceAll("\\", "/"))?.sourceChanges ?? [];
    const resolvedDeclarations = resolveComplianceJudgmentDeclarations(
      agentDecisions,
      requests,
      sourceChanges,
    );
    const { inference, candidates } = materializeInference(
      agentDecisions,
      modelInput,
    );
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
    const semanticArtifact = artifacts.get(
      modelInput.artifactReferences?.semanticReviewUnits?.replaceAll("\\", "/"),
    );
    const classificationBlockers = (semanticArtifact?.referenceCategoryDiagnostics ?? [])
      .filter((item) => requests.some((request) => request.reviewUnitId === item.reviewUnitId))
      .map((item) => ({ reviewUnitId: item.reviewUnitId, message: `${item.code}: ${item.message}` }));
    assembleCompliance({
        requests,
        evidence,
        decisions: judgment.complianceDecisions,
        sourceChanges,
        initialBlockers: classificationBlockers,
    });
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
        agentDecisionBytes: fs.statSync(
          resolveWorkPath(root, decisionsPath),
        ).size,
      },
    });
    return {
      inferencePath: inference
        ? resolveWorkPath(root, "inference.json")
        : null,
      guidelineEvidencePath: resolveWorkPath(
        root,
        "compliance-search-evidence.json",
      ),
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
    throw new Error(message);
  }
}

if (isMain(import.meta.url)) {
  runMain(async () => {
    const args = parseArgs(process.argv.slice(2), { required: ["work"] });
    const result = materializeAssessmentResults({
      work: args.work,
      decisions: args.decisions,
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
