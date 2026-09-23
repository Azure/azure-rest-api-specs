import path from "node:path";
import { deriveSafety, dimensionStatus } from "./assessment-display.mjs";
import { isMain, readJsonObject, runMain } from "./cli.mjs";
import { readComplianceCatalog } from "./compliance-assessment.mjs";
import {
  DOCUMENT_QUALITY_ARTIFACT,
  validateDocumentQualityDimension,
} from "./document-quality-assessment.mjs";

/** @typedef {import("./runtime-types.js").AssessmentFinding} AssessmentFinding */
/** @typedef {import("./runtime-types.js").AssessmentOutput} AssessmentOutput */
/** @typedef {import("./runtime-types.js").AssessmentSemanticItem} AssessmentSemanticItem */
/** @typedef {import("./runtime-types.js").FinalComplianceAssessment} FinalComplianceAssessment */
/**
 * @typedef {{
 *   schemaVersion?: never,
 *   baseline?: {commit?: string},
 *   head?: {commit?: string},
 *   dimensions?: {
 *     semanticUnderstanding?: {items?: unknown[]},
 *     restBreakingChanges?: {findings?: unknown[]},
 *     restCompatibleDownstreamBreakingChanges?: {findings?: unknown[]},
 *     azureCompliance?: {findings?: unknown[]}
 *   }
 * }} LegacyAssessment
 */

/**
 * @param {{id?: string}[]} items
 * @param {string} pathName
 * @param {string[]} errors
 */
function uniqueIds(items, pathName, errors) {
  /** @type {Set<string>} */
  const seen = new Set();
  for (const item of items) {
    if (!item?.id) errors.push(`${pathName} contains an item without id.`);
    else if (seen.has(item.id)) errors.push(`${pathName} contains duplicate id ${item.id}.`);
    else seen.add(item.id);
  }
}

/**
 * @template T
 * @param {T[]} values
 * @returns {T[]}
 */
function duplicateValues(values) {
  return [...new Set(values.filter((value, index) => values.indexOf(value) !== index))];
}

/**
 * @param {AssessmentFinding} finding
 * @param {"REST" | "downstream"} dimension
 * @param {string[]} errors
 */
function validateFinding(finding, dimension, errors) {
  const prefix = `${dimension} finding ${finding.id ?? "<unknown>"}`;
  if (!finding.actual?.trim()) errors.push(`${prefix} is missing actual behavior.`);
  if (!finding.expected?.trim()) errors.push(`${prefix} is missing expected behavior.`);
  if (!["high", "medium", "low"].includes(finding.severity)) {
    errors.push(`${prefix} has invalid severity.`);
  }
  if (!finding.rationale?.trim()) errors.push(`${prefix} is missing rationale.`);
  if (!finding.sources?.length) errors.push(`${prefix} has no changed TypeSpec source.`);
  for (const source of finding.sources ?? []) {
    if (!source.hunks?.length)
      errors.push(`${prefix} links source ${source.id} without changed hunks.`);
  }
  if (dimension === "REST" && !finding.operationIds?.length) {
    errors.push(`${prefix} has no affected operation.`);
  }
  if (dimension === "downstream" && !finding.crossLanguageDefinitionId && !finding.symbol) {
    errors.push(`${prefix} has no affected SDK symbol.`);
  }
  if (!finding.evidence?.length && !finding.inferred) {
    errors.push(`${prefix} has no deterministic evidence.`);
  }
  if (finding.inferred && (!finding.inferenceRequestIds?.length || !finding.hunkIds?.length)) {
    errors.push(`${prefix} has incomplete inference provenance.`);
  }
}

/** @param {LegacyAssessment} assessment */
function validateLegacy(assessment) {
  /** @type {string[]} */
  const errors = [];
  if (!assessment.baseline?.commit) errors.push("Legacy assessment is missing baseline.commit.");
  if (!assessment.head?.commit) errors.push("Legacy assessment is missing head.commit.");
  const dimensions = assessment.dimensions;
  if (!dimensions?.semanticUnderstanding?.items) {
    errors.push("Legacy assessment is missing semanticUnderstanding.items.");
  }
  if (!dimensions?.restBreakingChanges?.findings) {
    errors.push("Legacy assessment is missing restBreakingChanges.findings.");
  }
  if (!dimensions?.restCompatibleDownstreamBreakingChanges?.findings) {
    errors.push("Legacy assessment is missing downstream findings.");
  }
  if (!dimensions?.azureCompliance?.findings) {
    errors.push("Legacy assessment is missing azureCompliance.findings.");
  }
  return errors;
}

/**
 * @param {FinalComplianceAssessment} compliance
 * @param {AssessmentSemanticItem[]} semanticItems
 * @param {string[]} errors
 */
function validateComplianceDimension(compliance, semanticItems, errors) {
  if (!["passed", "failed", "not-assessed"].includes(compliance?.status)) {
    errors.push("Azure Guidelines status is invalid.");
    return;
  }
  for (const field of /** @type {const} */ ([
    "intentAssessments",
    "findings",
    "retrievalFailures",
    "blockers",
  ])) {
    if (!Array.isArray(compliance[field]))
      errors.push(`Azure Guidelines ${field} must be an array.`);
  }
  if (!compliance.coverage || typeof compliance.coverage !== "object") {
    errors.push("Azure Guidelines coverage is required.");
    return;
  }
  const catalog = readComplianceCatalog();
  const catalogUrls = new Set(catalog.map((item) => item.canonicalUrl));
  const catalogByUrl = new Map(catalog.map((item) => [item.canonicalUrl, item]));
  const semanticMap = new Map(semanticItems.map((item) => [item.id, item]));
  const assessments = compliance.intentAssessments ?? [];
  const assessmentIds = assessments.map((item) => item.semanticIntentId);
  if (duplicateValues(assessmentIds).length) {
    errors.push("Azure Guidelines contains duplicate intent assessments.");
  }
  const migrationBlocked = (compliance.blockers ?? []).some((item) =>
    (typeof item === "string"
      ? item
      : typeof item.message === "string"
        ? item.message
        : JSON.stringify(item)
    ).startsWith("compliance-search-input-missing:"),
  );
  const semanticIds = semanticItems.filter((item) => !item.informational).map((item) => item.id);
  if (
    !migrationBlocked &&
    (semanticIds.some((id) => !assessmentIds.includes(id)) ||
      assessmentIds.some((id) => !semanticIds.includes(id)))
  ) {
    errors.push("Azure Guidelines intent coverage does not match Semantic intents.");
  }

  const sharedSearch = compliance.sharedSearch;
  const sharedDocuments = sharedSearch?.documents ?? [];
  const sharedRanking = sharedSearch?.catalogRanking ?? [];
  const allDeclarationIds = new Set(assessments.flatMap((item) => item.declarationIds ?? []));
  let selectedDocumentCount = sharedSearch ? sharedDocuments.length : 0;
  if (sharedSearch) {
    const hasExhaustion = (compliance.blockers ?? []).some((item) =>
      (typeof item === "string"
        ? item
        : typeof item.message === "string"
          ? item.message
          : JSON.stringify(item)
      ).startsWith("catalog-exhausted:"),
    );
    if (sharedDocuments.length !== 4 && !hasExhaustion) {
      errors.push("Azure Guidelines shared search requires four documents.");
    }
    if (
      sharedRanking.length !== catalog.length ||
      duplicateValues(sharedRanking.map((entry) => entry.canonicalUrl)).length
    ) {
      errors.push("Azure Guidelines shared search has incomplete catalog ranking.");
    }
    const sortedRanking = [...sharedRanking].sort(
      (left, right) =>
        right.score.total - left.score.total || left.catalogOrder - right.catalogOrder,
    );
    if (
      sharedRanking.some((entry, index) => {
        const catalogEntry = catalogByUrl.get(entry.canonicalUrl);
        const score = entry.score ?? {};
        return (
          entry.rank !== index + 1 ||
          !catalogEntry ||
          entry.catalogOrder !== catalogEntry.catalogOrder ||
          entry.title !== catalogEntry.title ||
          ![0, 4].includes(score.exactSymbol) ||
          ![0, 3].includes(score.patternCategory) ||
          ![0, 2].includes(score.servicePlane) ||
          ![0, 1].includes(score.changeContext) ||
          score.total !==
            score.exactSymbol + score.patternCategory + score.servicePlane + score.changeContext
        );
      }) ||
      JSON.stringify(sortedRanking.map((entry) => entry.canonicalUrl)) !==
        JSON.stringify(sharedRanking.map((entry) => entry.canonicalUrl))
    ) {
      errors.push("Azure Guidelines shared search has invalid catalog ranking.");
    }
    const failedUrls = new Set(
      (compliance.retrievalFailures ?? []).map((failure) => failure.canonicalUrl),
    );
    const expectedUrls = sharedRanking
      .filter((entry) => !failedUrls.has(entry.canonicalUrl))
      .slice(0, 4)
      .map((entry) => entry.canonicalUrl);
    const urls = sharedDocuments.map((document) => document.canonicalUrl);
    if (duplicateValues(urls).length || JSON.stringify(expectedUrls) !== JSON.stringify(urls)) {
      errors.push("Azure Guidelines shared search selected invalid documents.");
    }
  }
  /** @type {string[]} */
  const assessedIntentIds = [];
  /** @type {string[]} */
  const failedIntentIds = [];
  let incompleteEvidence = (compliance.blockers ?? []).length > 0;
  for (const item of assessments) {
    if (!semanticMap.has(item.semanticIntentId)) {
      errors.push(`Azure Guidelines references unknown semantic intent ${item.semanticIntentId}.`);
      continue;
    }
    const documents = sharedSearch ? sharedDocuments : (item.documents ?? []);
    const ranking = sharedSearch ? sharedRanking : (item.catalogRanking ?? []);
    if (!sharedSearch) selectedDocumentCount += documents.length;
    const hasExhaustion = (item.blockers ?? []).some((value) =>
      value.startsWith("catalog-exhausted:"),
    );
    if (!sharedSearch && documents.length !== 4 && !hasExhaustion) {
      errors.push(`Azure Guidelines intent ${item.semanticIntentId} requires four documents.`);
      incompleteEvidence = true;
    }
    if (
      !sharedSearch &&
      (ranking.length !== catalog.length ||
        duplicateValues(ranking.map((entry) => entry.canonicalUrl)).length)
    ) {
      errors.push(
        `Azure Guidelines intent ${item.semanticIntentId} has incomplete catalog ranking.`,
      );
    }
    const sortedRanking = [...ranking].sort(
      (left, right) =>
        right.score.total - left.score.total || left.catalogOrder - right.catalogOrder,
    );
    if (
      !sharedSearch &&
      (ranking.some((entry, index) => {
        const catalogEntry = catalogByUrl.get(entry.canonicalUrl);
        const score = entry.score ?? {};
        return (
          entry.rank !== index + 1 ||
          !catalogEntry ||
          entry.catalogOrder !== catalogEntry.catalogOrder ||
          entry.title !== catalogEntry.title ||
          ![0, 4].includes(score.exactSymbol) ||
          ![0, 3].includes(score.patternCategory) ||
          ![0, 2].includes(score.servicePlane) ||
          ![0, 1].includes(score.changeContext) ||
          score.total !==
            score.exactSymbol + score.patternCategory + score.servicePlane + score.changeContext
        );
      }) ||
        JSON.stringify(sortedRanking.map((entry) => entry.canonicalUrl)) !==
          JSON.stringify(ranking.map((entry) => entry.canonicalUrl)))
    ) {
      errors.push(`Azure Guidelines intent ${item.semanticIntentId} has invalid catalog ranking.`);
    }
    const failedUrls = new Set(
      (compliance.retrievalFailures ?? [])
        .filter((failure) => sharedSearch || failure.reviewUnitId === item.semanticIntentId)
        .map((failure) => failure.canonicalUrl),
    );
    const expectedUrls = ranking
      .filter((entry) => !failedUrls.has(entry.canonicalUrl))
      .slice(0, 4)
      .map((entry) => entry.canonicalUrl);
    const urls = documents.map((document) => document.canonicalUrl);
    if (
      !sharedSearch &&
      (duplicateValues(urls).length || JSON.stringify(expectedUrls) !== JSON.stringify(urls))
    ) {
      errors.push(`Azure Guidelines intent ${item.semanticIntentId} selected invalid documents.`);
    }
    for (const document of documents) {
      if (
        !catalogUrls.has(document.canonicalUrl) ||
        !document.retrievedAt ||
        !/^sha256:[0-9a-f]{64}$/i.test(document.contentHash ?? "") ||
        typeof document.noRelevantGuidance !== "boolean" ||
        document.noRelevantGuidance === (document.guidance ?? []).length > 0
      ) {
        errors.push(`Azure Guidelines document ${document.canonicalUrl} is invalid.`);
      }
      for (const guidance of document.guidance ?? []) {
        if (
          !guidance.section?.trim() ||
          !guidance.excerpt?.trim() ||
          !Array.isArray(guidance.queryTerms) ||
          !Array.isArray(guidance.applicableDeclarationIds) ||
          !guidance.applicableDeclarationIds.length ||
          guidance.applicableDeclarationIds.some((id) =>
            sharedSearch ? !allDeclarationIds.has(id) : !(item.declarationIds ?? []).includes(id),
          )
        ) {
          errors.push(
            `Azure Guidelines document ${document.canonicalUrl} has incomplete guidance.`,
          );
        }
      }
    }
    if (
      !["applicable-pass", "applicable-fail", "no-applicable-guidance", "not-assessed"].includes(
        item.decision,
      ) ||
      !item.actual?.trim() ||
      !item.gap?.trim() ||
      !Array.isArray(item.applicableGuidance)
    ) {
      errors.push(`Azure Guidelines intent ${item.semanticIntentId} has an invalid decision.`);
      incompleteEvidence = true;
      continue;
    }
    if (item.decision === "applicable-pass" || item.decision === "applicable-fail") {
      assessedIntentIds.push(item.semanticIntentId);
      if (
        !item.expected?.trim() ||
        !item.applicableGuidance.length ||
        !(item.sourceLinks ?? []).length ||
        !(item.codeSnippets ?? []).length
      ) {
        errors.push(`Azure Guidelines intent ${item.semanticIntentId} lacks applicable evidence.`);
      }
      for (const applicable of item.applicableGuidance) {
        const document = documents.find(
          (candidate) => candidate.canonicalUrl === applicable.canonicalDocumentUrl,
        );
        if (
          !document?.guidance?.some((guidance) => guidance.section === applicable.guidanceSection)
        ) {
          errors.push(`Azure Guidelines intent ${item.semanticIntentId} uses unknown guidance.`);
        }
      }
    } else if (item.decision === "no-applicable-guidance") {
      assessedIntentIds.push(item.semanticIntentId);
      if (item.applicableGuidance.length || (item.blockers ?? []).length) {
        errors.push(
          `Azure Guidelines intent ${item.semanticIntentId} cannot use no-applicable-guidance with applicable guidance or blockers.`,
        );
      }
    } else {
      incompleteEvidence = true;
    }
    if (item.decision === "applicable-fail") {
      failedIntentIds.push(item.semanticIntentId);
      if (
        !item.title?.trim() ||
        typeof item.severity !== "string" ||
        !["high", "medium", "low"].includes(item.severity)
      ) {
        errors.push(`Azure Guidelines intent ${item.semanticIntentId} lacks finding presentation.`);
      }
    }
    if ((item.blockers ?? []).length) incompleteEvidence = true;
  }

  for (const failure of compliance.retrievalFailures ?? []) {
    if (
      (!sharedSearch && (!failure.reviewUnitId || !semanticMap.has(failure.reviewUnitId))) ||
      !catalogUrls.has(failure.canonicalUrl) ||
      failure.status !== "failed" ||
      !failure.error?.trim()
    ) {
      errors.push("Azure Guidelines contains an invalid retrieval failure.");
    }
  }
  const findingIntentIds = (compliance.findings ?? []).map((item) => item.semanticIntentId);
  if (
    duplicateValues(findingIntentIds).length ||
    failedIntentIds.some((id) => !findingIntentIds.includes(id)) ||
    findingIntentIds.some((id) => !failedIntentIds.includes(id))
  ) {
    errors.push("Azure Guidelines findings must exactly match failed intent assessments.");
  }
  for (const finding of compliance.findings ?? []) {
    if (
      !finding.expected?.trim() ||
      !finding.actual?.trim() ||
      !finding.gap?.trim() ||
      !finding.title?.trim() ||
      typeof finding.severity !== "string" ||
      !["high", "medium", "low"].includes(finding.severity) ||
      !Array.isArray(finding.applicableGuidance) ||
      !finding.applicableGuidance.length ||
      !(finding.sourceLinks ?? []).length ||
      !(finding.codeSnippets ?? []).length
    ) {
      errors.push(`Azure Guidelines finding ${finding.id ?? "<unknown>"} is incomplete.`);
    }
  }
  uniqueIds(compliance.findings ?? [], "Azure Guidelines findings", errors);
  const coverageSemanticIds = migrationBlocked ? [] : semanticIds;
  const unassessedIntentIds = coverageSemanticIds.filter((id) => !assessedIntentIds.includes(id));
  const coverage = compliance.coverage;
  if (
    coverage.semanticIntentCount !== coverageSemanticIds.length ||
    coverage.assessedIntentCount !== assessedIntentIds.length ||
    coverage.selectedDocumentCount !== selectedDocumentCount ||
    JSON.stringify([...(coverage.unassessedIntentIds ?? [])].sort()) !==
      JSON.stringify(unassessedIntentIds.sort())
  ) {
    errors.push("Azure Guidelines coverage counts are inconsistent.");
  }
  const expectedStatus = failedIntentIds.length
    ? "failed"
    : incompleteEvidence || unassessedIntentIds.length
      ? "not-assessed"
      : "passed";
  if (compliance.status !== expectedStatus) {
    errors.push(`Azure Guidelines status must be ${expectedStatus}.`);
  }
}
/**
 * @param {AssessmentOutput | LegacyAssessment} assessment
 * @returns {string[]}
 */
export function validateAssessment(assessment) {
  if (assessment?.schemaVersion !== 1) return validateLegacy(assessment);
  /** @type {string[]} */
  const errors = [];
  if (!assessment.comparison?.baseCommit) errors.push("comparison.baseCommit is required.");
  if (!assessment.comparison?.headCommit) errors.push("comparison.headCommit is required.");
  if (assessment.pullRequest) {
    if (!Number.isInteger(assessment.pullRequest.number) || assessment.pullRequest.number < 1) {
      errors.push("pullRequest.number must be a positive integer.");
    }
    try {
      const url = new URL(assessment.pullRequest.url);
      if (!["http:", "https:"].includes(url.protocol)) {
        errors.push("pullRequest.url must use HTTP or HTTPS.");
      }
    } catch {
      errors.push("pullRequest.url must be a valid URL.");
    }
  }
  const projectIds = new Set((assessment.projects ?? []).map((project) => project.id));
  if ((assessment.artifactComparisons ?? []).length !== projectIds.size) {
    errors.push("artifactComparisons must contain exactly one entry per project.");
  }
  uniqueIds(
    (assessment.artifactComparisons ?? []).map((item) => ({
      ...item,
      id: item.projectId,
    })),
    "artifact comparisons",
    errors,
  );
  for (const comparison of assessment.artifactComparisons ?? []) {
    if (!projectIds.has(comparison.projectId)) {
      errors.push(`Artifact comparison references unknown project ${comparison.projectId}.`);
    }
    if (
      !["new-api-version", "existing-api-version", "unversioned", "legacy"].includes(
        comparison.mode ?? "",
      )
    ) {
      errors.push(`Artifact comparison ${comparison.projectId} has invalid mode.`);
    }
    for (const role of /** @type {const} */ (["baseline", "target"])) {
      const selection = comparison[role];
      if (!selection || !["base", "current"].includes(selection.sourceRevision)) {
        errors.push(
          `Artifact comparison ${comparison.projectId} has invalid ${role} source revision.`,
        );
      }
      if (!selection?.commit) {
        errors.push(`Artifact comparison ${comparison.projectId} is missing ${role} commit.`);
      }
      if (!selection?.reason) {
        errors.push(
          `Artifact comparison ${comparison.projectId} is missing ${role} selection reason.`,
        );
      }
    }
    if (
      comparison.mode === "new-api-version" &&
      (comparison.baseline?.sourceRevision !== "current" ||
        comparison.target?.sourceRevision !== "current" ||
        comparison.baseline?.commit !== assessment.comparison.headCommit ||
        comparison.target?.commit !== assessment.comparison.headCommit)
    ) {
      errors.push(
        `New-version artifact comparison ${comparison.projectId} must compile both roles from the head source.`,
      );
    }
  }
  if (!["high", "medium", "low"].includes(assessment.confidence)) {
    errors.push("confidence is invalid.");
  }
  const dimensions = assessment.dimensions ?? {};
  for (const name of ["semantic", "rest", "downstream", "compliance", "documentQuality"]) {
    if (!dimensions[name]) errors.push(`dimensions.${name} is required.`);
  }
  errors.push(
    ...validateDocumentQualityDimension(
      dimensions.documentQuality,
      (dimensions.semantic?.items ?? []).filter((item) => !item.informational),
      dimensions.semantic?.status === "assessed" ? "ready" : "blocked",
    ),
  );
  if (
    assessment.provenance?.documentQuality !== undefined &&
    (assessment.provenance.documentQuality !== DOCUMENT_QUALITY_ARTIFACT ||
      dimensions.documentQuality?.coverage === undefined)
  ) {
    errors.push(
      "Document Quality canonical provenance requires the complete assessed dimension shape.",
    );
  }
  uniqueIds(dimensions.semantic?.items ?? [], "semantic items", errors);
  uniqueIds(dimensions.rest?.findings ?? [], "REST findings", errors);
  uniqueIds(dimensions.downstream?.findings ?? [], "downstream findings", errors);
  for (const finding of dimensions.rest?.findings ?? []) validateFinding(finding, "REST", errors);
  for (const finding of dimensions.downstream?.findings ?? []) {
    validateFinding(finding, "downstream", errors);
  }
  if (dimensions.semantic?.status === "assessed") {
    /** @type {string[]} */
    const coveredHunks = [];
    for (const item of dimensions.semantic.items ?? []) {
      if (!item.title?.trim() || !item.summary?.trim()) {
        errors.push(`Semantic item ${item.id} is incomplete.`);
      }
      if (!["add", "remove", "modify"].includes(item.action ?? "")) {
        errors.push(`Semantic item ${item.id} has invalid action.`);
      }
      if (
        item.intentType !== undefined &&
        !["normal", "api-version-publication", "api-version-wide-change"].includes(item.intentType)
      ) {
        errors.push(`Semantic item ${item.id} has invalid intentType.`);
      }
      if (!item.sources?.length) errors.push(`Semantic item ${item.id} has no changed source.`);
      for (const source of item.sources ?? []) {
        for (const hunk of source.hunks ?? []) coveredHunks.push(hunk.id);
      }
      for (const operation of item.operations ?? []) {
        if (!operation.operationId || !operation.method || !operation.path) {
          errors.push(`Semantic item ${item.id} has incomplete REST operation evidence.`);
        }
        if (typeof operation.restChanged !== "boolean" || !operation.outcome?.trim()) {
          errors.push(`Semantic item ${item.id} has incomplete REST change outcome.`);
        }
      }
    }
    const duplicateHunks = coveredHunks.filter((id, index) => coveredHunks.indexOf(id) !== index);
    if (duplicateHunks.length) {
      errors.push(
        `Semantic source hunks are covered more than once: ${[...new Set(duplicateHunks)].join(", ")}.`,
      );
    }
    const expectedHunks = dimensions.semantic.sourceHunkIds ?? [];
    const missingHunks = expectedHunks.filter((id) => !coveredHunks.includes(id));
    const unknownHunks = coveredHunks.filter((id) => !expectedHunks.includes(id));
    if (missingHunks.length || unknownHunks.length) {
      errors.push(
        `Semantic source hunk coverage mismatch. Missing: ${missingHunks.join(", ") || "none"}; unknown: ${unknownHunks.join(", ") || "none"}.`,
      );
    }
  }
  const semanticIds = new Set((dimensions.semantic?.items ?? []).map((item) => item.id));
  const restIds = new Set((dimensions.rest?.findings ?? []).map((item) => item.id));
  const methodGroups =
    dimensions.downstream?.methodGroups ?? dimensions.downstream?.operationGroups ?? [];
  const typeImpacts =
    dimensions.downstream?.typeImpacts ?? dimensions.downstream?.sharedTypeImpacts ?? [];
  const downstreamGroupIds = new Set(methodGroups.map((item) => item.id));
  uniqueIds(methodGroups, "downstream method groups", errors);
  uniqueIds(typeImpacts, "SDK type impacts", errors);
  validateComplianceDimension(dimensions.compliance, dimensions.semantic?.items ?? [], errors);
  for (const impact of typeImpacts) {
    downstreamGroupIds.add(impact.id);
  }
  for (const finding of [
    ...(dimensions.rest?.findings ?? []),
    ...(dimensions.downstream?.findings ?? []),
  ]) {
    for (const id of finding.relatedSemanticIntents ?? []) {
      if (!semanticIds.has(id))
        errors.push(`Finding ${finding.id} links unknown semantic intent ${id}.`);
    }
    if (
      finding.semanticMatchBasis &&
      !["operation-identity", "http-method-path", "declaration-identity", "unique-source"].includes(
        finding.semanticMatchBasis,
      )
    ) {
      errors.push(`Finding ${finding.id} has unsupported semantic match basis.`);
    }
  }
  for (const item of dimensions.semantic?.items ?? []) {
    for (const [kind, ids] of Object.entries(item.relatedFindings ?? {})) {
      if (!ids) continue;
      const duplicates = duplicateValues(ids);
      if (duplicates.length) {
        errors.push(
          `Semantic item ${item.id} has duplicate ${kind} links: ${duplicates.join(", ")}.`,
        );
      }
    }
    for (const id of item.relatedFindings?.rest ?? []) {
      if (!restIds.has(id))
        errors.push(`Semantic item ${item.id} links unknown REST finding ${id}.`);
      const finding = (dimensions.rest?.findings ?? []).find((candidate) => candidate.id === id);
      if (finding && !finding.relatedSemanticIntents?.includes(item.id)) {
        errors.push(`Semantic item ${item.id} and REST finding ${id} are not reciprocal.`);
      }
    }
    for (const id of [
      ...(item.relatedFindings?.downstream ?? []),
      ...(item.relatedFindings?.typeImpact ?? []),
      ...(item.relatedFindings?.sharedTypeImpact ?? []),
    ]) {
      if (!downstreamGroupIds.has(id)) {
        errors.push(`Semantic item ${item.id} links unknown downstream group ${id}.`);
      }
    }
  }
  const downstreamFindingIds = new Set(
    (dimensions.downstream?.findings ?? []).map((item) => item.id),
  );
  /** @type {string[]} */
  const aggregatedFindingIds = [];
  for (const group of methodGroups) {
    if (!group.symbol || !group.deltas?.length)
      errors.push(`Downstream group ${group.id} is incomplete.`);
    for (const delta of group.deltas ?? []) {
      aggregatedFindingIds.push(delta.findingId);
      if (!downstreamFindingIds.has(delta.findingId)) {
        errors.push(`Downstream group ${group.id} links unknown finding ${delta.findingId}.`);
      }
    }
    for (const id of group.relatedSemanticIntents ?? []) {
      const intent = (dimensions.semantic?.items ?? []).find((item) => item.id === id);
      if (!intent?.relatedFindings?.downstream?.includes(group.id)) {
        errors.push(`Downstream group ${group.id} and semantic item ${id} are not reciprocal.`);
      }
    }
  }
  const allowedLocations = new Set([
    "request-path",
    "request-query",
    "request-header",
    "request-body",
    "response-header",
    "response-body",
  ]);
  for (const impact of typeImpacts) {
    const types = impact.type ? [impact.type] : (impact.types ?? []);
    if (!impact.summary?.trim() || !types.length) {
      errors.push(`SDK type impact ${impact.id} is incomplete.`);
    }
    for (const location of impact.locations ?? []) {
      if (!allowedLocations.has(location)) {
        errors.push(`SDK type impact ${impact.id} has unsupported location ${location}.`);
      }
    }
    if (
      impact.affectedMethodCount !==
      new Set((impact.affectedMethods ?? []).map((item) => item.symbol)).size
    ) {
      errors.push(`SDK type impact ${impact.id} has inconsistent method count.`);
    }
    for (const id of impact.findingIds ?? []) {
      aggregatedFindingIds.push(id);
      if (!downstreamFindingIds.has(id)) {
        errors.push(`Shared type impact ${impact.id} links unknown finding ${id}.`);
      }
    }
    for (const id of impact.relatedSemanticIntents ?? []) {
      const intent = (dimensions.semantic?.items ?? []).find((item) => item.id === id);
      if (
        !intent?.relatedFindings?.typeImpact?.includes(impact.id) &&
        !intent?.relatedFindings?.sharedTypeImpact?.includes(impact.id)
      ) {
        errors.push(`SDK type impact ${impact.id} and semantic item ${id} are not reciprocal.`);
      }
    }
  }
  const duplicateAggregates = duplicateValues(aggregatedFindingIds);
  const missingAggregates = [...downstreamFindingIds].filter(
    (id) => !aggregatedFindingIds.includes(id),
  );
  if (duplicateAggregates.length || missingAggregates.length) {
    errors.push(
      `Downstream aggregate coverage mismatch. Missing: ${missingAggregates.join(", ") || "none"}; duplicate: ${duplicateAggregates.join(", ") || "none"}.`,
    );
  }
  const expectedRestStatus = dimensionStatus(
    (dimensions.rest?.blockers ?? []).length > 0,
    dimensions.rest?.findings ?? [],
  );
  if (dimensions.rest?.status !== expectedRestStatus) {
    errors.push(`REST status must be ${expectedRestStatus}.`);
  }
  const expectedDownstreamStatus = dimensionStatus(
    (dimensions.downstream?.blockers ?? []).length > 0,
    dimensions.downstream?.findings ?? [],
  );
  if (dimensions.downstream?.status !== expectedDownstreamStatus) {
    errors.push(`Downstream status must be ${expectedDownstreamStatus}.`);
  }
  const expectedSafety = deriveSafety(dimensions.rest, dimensions.downstream);
  if (
    assessment.safety?.scope !== expectedSafety.scope ||
    assessment.safety?.status !== expectedSafety.status
  ) {
    errors.push("Scoped safety is inconsistent with REST/downstream dimensions.");
  }
  return errors;
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const file = process.argv[2];
    if (!file) throw new Error("Usage: validate-assessment.mjs <assessment.json>");
    const assessment = /** @type {AssessmentOutput | LegacyAssessment} */ (
      readJsonObject(path.resolve(file))
    );
    const errors = validateAssessment(assessment);
    if (errors.length) throw new Error(errors.join("\n"));
    console.log(`${path.resolve(file)} is valid.`);
  });
}
