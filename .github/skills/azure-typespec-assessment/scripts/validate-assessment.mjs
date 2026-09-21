import path from "node:path";
import { isMain, readJson, runMain } from "./cli.mjs";
import { deriveSafety, dimensionStatus } from "./assessment-display.mjs";
import { assembleCompliance, REFERENCE_CATEGORIES, searchInputAccounting } from "./compliance-assessment.mjs";
import { canonicalJson } from "./stable-id.mjs";
import { DOCUMENT_QUALITY_ARTIFACT, validateDocumentQualityDimension } from "./document-quality-assessment.mjs";

function uniqueIds(items, pathName, errors) {
  const seen = new Set();
  for (const item of items) {
    if (!item?.id) errors.push(`${pathName} contains an item without id.`);
    else if (seen.has(item.id))
      errors.push(`${pathName} contains duplicate id ${item.id}.`);
    else seen.add(item.id);
  }
}

function duplicateValues(values) {
  return [
    ...new Set(
      values.filter((value, index) => values.indexOf(value) !== index),
    ),
  ];
}

function validateFinding(finding, dimension, errors) {
  const prefix = `${dimension} finding ${finding.id ?? "<unknown>"}`;
  if (!finding.actual?.trim())
    errors.push(`${prefix} is missing actual behavior.`);
  if (!finding.expected?.trim())
    errors.push(`${prefix} is missing expected behavior.`);
  if (!["high", "medium", "low"].includes(finding.severity)) {
    errors.push(`${prefix} has invalid severity.`);
  }
  if (!finding.rationale?.trim())
    errors.push(`${prefix} is missing rationale.`);
  if (!finding.sources?.length)
    errors.push(`${prefix} has no changed TypeSpec source.`);
  for (const source of finding.sources ?? []) {
    if (!source.hunks?.length)
      errors.push(`${prefix} links source ${source.id} without changed hunks.`);
  }
  if (dimension === "REST" && !finding.operationIds?.length) {
    errors.push(`${prefix} has no affected operation.`);
  }
  if (
    dimension === "downstream" &&
    !finding.crossLanguageDefinitionId &&
    !finding.symbol
  ) {
    errors.push(`${prefix} has no affected SDK symbol.`);
  }
  if (!finding.evidence?.length && !finding.inferred) {
    errors.push(`${prefix} has no deterministic evidence.`);
  }
  if (
    finding.inferred &&
    (!finding.inferenceRequestIds?.length || !finding.hunkIds?.length)
  ) {
    errors.push(`${prefix} has incomplete inference provenance.`);
  }
}

function validateLegacy(assessment) {
  const errors = [];
  if (!assessment.baseline?.commit)
    errors.push("Legacy assessment is missing baseline.commit.");
  if (!assessment.head?.commit)
    errors.push("Legacy assessment is missing head.commit.");
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

function validateComplianceDimension(compliance, semanticItems, errors) {
  try {
    if (!["passed", "failed", "not-assessed"].includes(compliance?.status)) throw new Error("Azure Guidelines status is invalid.");
    for (const field of ["intentAssessments", "findings", "retrievalFailures", "blockers"]) {
      if (!Array.isArray(compliance[field])) throw new Error(`Azure Guidelines ${field} must be an array.`);
    }
    if (!compliance.coverage) throw new Error("Azure Guidelines coverage is required.");
    const assessments = compliance.intentAssessments;
    const migrationBlocked = compliance.blockers.some((item) => String(item?.message ?? item).startsWith("compliance-search-input-missing:"));
    const semanticIds = migrationBlocked ? [] : semanticItems.filter((item) => !item.informational).map((item) => item.id);
    const assessmentIds = assessments.map((item) => item.semanticIntentId);
    if (duplicateValues(assessmentIds).length ||
      canonicalJson([...semanticIds].sort()) !== canonicalJson([...assessmentIds].sort())) {
      throw new Error("Azure Guidelines intent coverage does not match Semantic intents.");
    }
    const shared = compliance.sharedSearch;
    if (shared?.catalogRanking !== undefined || assessments.some((item) => item.catalogRanking !== undefined)) {
      throw new Error("Legacy ranked Guidelines evidence cannot validate as a live assessment; rerun deterministic analysis and Agent judgment.");
    }
    if (!shared && !assessments.length) {
      if (canonicalJson(compliance.coverage) !== canonicalJson({ semanticIntentCount: 0, assessedIntentCount: 0, selectedDocumentCount: 0, unassessedIntentIds: [] }) ||
        compliance.findings.length || compliance.retrievalFailures.length ||
        compliance.status !== (compliance.blockers.length ? "not-assessed" : "passed")) {
        throw new Error("Azure Guidelines empty assessment coverage is inconsistent.");
      }
      return;
    }
    if (!shared) throw new Error("Azure Guidelines selection provenance is missing; rerun assessment.");
    for (const document of shared.documents ?? []) {
      if (canonicalJson(document.retrieval) !== canonicalJson({
        status: "fetched", retrievedAt: document.retrievedAt, contentHash: document.contentHash,
        retrievalSource: document.retrievalSource, bytes: document.bytes,
      })) {
        throw new Error(`Azure Guidelines document ${document.catalogId} has inconsistent retrieval provenance.`);
      }
    }
    const requests = assessments.map((item) => {
      const semantic = semanticItems.find((unit) => unit.id === item.semanticIntentId);
      if (item.reviewUnitId !== item.semanticIntentId ||
        canonicalJson(item.referenceCategories) !== canonicalJson(semantic.referenceCategories)) {
        throw new Error(`Azure Guidelines intent ${item.semanticIntentId} has inconsistent category ownership.`);
      }
      if (canonicalJson(item.requiredCatalogIds) !== canonicalJson(item.guidanceRouting?.mandatoryCatalogIds)) {
        throw new Error(`Azure Guidelines intent ${item.semanticIntentId} has falsified mandatory document coverage.`);
      }
      for (const field of ["sourceChangeIds", "hunkIds", "declarationIds"]) {
        if (!Array.isArray(item[field]) || item[field].some((id) => !(semantic[field] ?? []).includes(id))) {
          throw new Error(`Azure Guidelines intent ${item.semanticIntentId} has incorrect source evidence.`);
        }
      }
      return {
        reviewUnitId: item.semanticIntentId,
        ...(item.evidenceSetId ? { evidenceSetId: item.evidenceSetId } : {}),
        referenceCategories: item.referenceCategories,
        guidanceRouting: item.guidanceRouting,
        queryProfile: item.queryProfile,
        sourceChangeIds: semantic.sourceChangeIds, hunkIds: semantic.hunkIds, declarationIds: semantic.declarationIds,
      };
    });
    const evidence = {
      schemaVersion: 3,
      queryProfiles: requests.map((item) => ({ reviewUnitId: item.reviewUnitId, queryProfile: item.queryProfile })),
      documentSelections: shared.documentSelections,
      documents: shared.documents.map(({ retrievedAt, contentHash, retrievalSource, bytes, ...document }) => ({
        ...document, retrieval: { status: "fetched", retrievedAt, contentHash, retrievalSource, bytes },
      })),
      discoveryResults: shared.discoveryResults, additionalSelections: shared.additionalSelections,
      retrievalAttempts: compliance.retrievalFailures,
      blockers: compliance.blockers.filter((item) => item.reviewUnitId),
    };
    evidence.inputAccounting = searchInputAccounting(evidence);
    const decisionFields = ["reviewUnitId", "reviewedCatalogIds", "applicableGuidance", "sourceChangeIds", "hunkIds", "declarationIds", "decision", "title", "severity", "expected", "actual", "rationale"];
    const decisions = assessments.map((item) => Object.fromEntries(decisionFields.filter((key) => item[key] !== undefined).map((key) => [key, item[key]])));
    const reconstructed = assembleCompliance({
      requests, evidence, decisions, sourceChanges: [],
      initialBlockers: compliance.blockers.filter((item) => !item.reviewUnitId),
    });
    if (canonicalJson(compliance.coverage) !== canonicalJson(reconstructed.coverage)) errors.push("Azure Guidelines coverage counts are inconsistent.");
    if (compliance.status !== reconstructed.status) errors.push(`Azure Guidelines status must be ${reconstructed.status}.`);
    for (const [index, item] of assessments.entries()) {
      if (canonicalJson(item.selectedCatalogIds) !== canonicalJson(reconstructed.intentAssessments[index].selectedCatalogIds) ||
        canonicalJson(item.blockers) !== canonicalJson(reconstructed.intentAssessments[index].blockers)) {
        errors.push(`Azure Guidelines intent ${item.semanticIntentId} has inconsistent review accounting.`);
      }
      if (item.gap !== item.rationale || (item.decision.startsWith("applicable-") && (!item.sourceLinks?.length || !item.codeSnippets?.length))) {
        errors.push(`Azure Guidelines intent ${item.semanticIntentId} lacks applicable evidence.`);
      }
    }
    const findings = reconstructed.findings.map(({ sourceLinks, codeSnippets, ...item }) => item);
    const actual = compliance.findings.map(({ sourceLinks, codeSnippets, ...item }) => item);
    if (canonicalJson(actual) !== canonicalJson(findings)) errors.push("Azure Guidelines findings must exactly match failed intent assessments and retained normative excerpts.");
    for (const finding of compliance.findings) {
      if (!finding.sourceLinks?.length || !finding.codeSnippets?.length) errors.push(`Azure Guidelines finding ${finding.id} lacks changed-source evidence.`);
    }
    uniqueIds(compliance.findings, "Azure Guidelines findings", errors);
  } catch (error) {
    errors.push(error.message);
  }
}
export function validateAssessment(assessment) {
  if (assessment?.schemaVersion !== 1) return validateLegacy(assessment);
  const errors = [];
  if (!assessment.comparison?.baseCommit)
    errors.push("comparison.baseCommit is required.");
  if (!assessment.comparison?.headCommit)
    errors.push("comparison.headCommit is required.");
  if (assessment.pullRequest) {
    if (
      !Number.isInteger(assessment.pullRequest.number) ||
      assessment.pullRequest.number < 1
    ) {
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
  const projectIds = new Set(
    (assessment.projects ?? []).map((project) => project.id),
  );
  if ((assessment.artifactComparisons ?? []).length !== projectIds.size) {
    errors.push(
      "artifactComparisons must contain exactly one entry per project.",
    );
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
      errors.push(
        `Artifact comparison references unknown project ${comparison.projectId}.`,
      );
    }
    if (
      ![
        "new-api-version",
        "existing-api-version",
        "unversioned",
        "legacy",
      ].includes(comparison.mode)
    ) {
      errors.push(
        `Artifact comparison ${comparison.projectId} has invalid mode.`,
      );
    }
    for (const role of ["baseline", "target"]) {
      const selection = comparison[role];
      if (
        !selection ||
        !["base", "current"].includes(selection.sourceRevision)
      ) {
        errors.push(
          `Artifact comparison ${comparison.projectId} has invalid ${role} source revision.`,
        );
      }
      if (!selection?.commit) {
        errors.push(
          `Artifact comparison ${comparison.projectId} is missing ${role} commit.`,
        );
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
  for (const name of [
    "semantic",
    "rest",
    "downstream",
    "compliance",
    "documentQuality",
  ]) {
    if (!dimensions[name]) errors.push(`dimensions.${name} is required.`);
  }
  errors.push(...validateDocumentQualityDimension(
    dimensions.documentQuality,
    (dimensions.semantic?.items ?? []).filter((item) => !item.informational),
    dimensions.semantic?.status === "assessed" ? "ready" : "blocked",
  ));
  if (assessment.provenance?.documentQuality !== undefined &&
      (assessment.provenance.documentQuality !== DOCUMENT_QUALITY_ARTIFACT ||
       dimensions.documentQuality?.coverage === undefined)) {
    errors.push("Document Quality canonical provenance requires the complete assessed dimension shape.");
  }
  uniqueIds(dimensions.semantic?.items ?? [], "semantic items", errors);
  uniqueIds(dimensions.rest?.findings ?? [], "REST findings", errors);
  uniqueIds(
    dimensions.downstream?.findings ?? [],
    "downstream findings",
    errors,
  );
  for (const finding of dimensions.rest?.findings ?? [])
    validateFinding(finding, "REST", errors);
  for (const finding of dimensions.downstream?.findings ?? []) {
    validateFinding(finding, "downstream", errors);
  }
  if (dimensions.semantic?.status === "assessed") {
    const coveredHunks = [];
    for (const item of dimensions.semantic.items ?? []) {
      if (!item.title?.trim() || !item.summary?.trim()) {
        errors.push(`Semantic item ${item.id} is incomplete.`);
      }
      if (!["add", "remove", "modify"].includes(item.action)) {
        errors.push(`Semantic item ${item.id} has invalid action.`);
      }
      if (
        item.intentType !== undefined &&
        ![
          "normal",
          "api-version-publication",
          "api-version-wide-change",
        ].includes(item.intentType)
      ) {
        errors.push(`Semantic item ${item.id} has invalid intentType.`);
      }
      if (item.referenceCategories !== undefined && (!Array.isArray(item.referenceCategories) ||
        duplicateValues(item.referenceCategories).length ||
        item.referenceCategories.some((category) => !REFERENCE_CATEGORIES.includes(category)))) {
        errors.push(`Semantic item ${item.id} has invalid referenceCategories.`);
      }
      if (!item.sources?.length)
        errors.push(`Semantic item ${item.id} has no changed source.`);
      for (const source of item.sources ?? []) {
        for (const hunk of source.hunks ?? []) coveredHunks.push(hunk.id);
      }
      for (const operation of item.operations ?? []) {
        if (!operation.operationId || !operation.method || !operation.path) {
          errors.push(
            `Semantic item ${item.id} has incomplete REST operation evidence.`,
          );
        }
        if (
          typeof operation.restChanged !== "boolean" ||
          !operation.outcome?.trim()
        ) {
          errors.push(
            `Semantic item ${item.id} has incomplete REST change outcome.`,
          );
        }
      }
    }
    const duplicateHunks = coveredHunks.filter(
      (id, index) => coveredHunks.indexOf(id) !== index,
    );
    if (duplicateHunks.length) {
      errors.push(
        `Semantic source hunks are covered more than once: ${[...new Set(duplicateHunks)].join(", ")}.`,
      );
    }
    const expectedHunks = dimensions.semantic.sourceHunkIds ?? [];
    const missingHunks = expectedHunks.filter(
      (id) => !coveredHunks.includes(id),
    );
    const unknownHunks = coveredHunks.filter(
      (id) => !expectedHunks.includes(id),
    );
    if (missingHunks.length || unknownHunks.length) {
      errors.push(
        `Semantic source hunk coverage mismatch. Missing: ${missingHunks.join(", ") || "none"}; unknown: ${unknownHunks.join(", ") || "none"}.`,
      );
    }
  }
  const semanticIds = new Set(
    (dimensions.semantic?.items ?? []).map((item) => item.id),
  );
  const restIds = new Set(
    (dimensions.rest?.findings ?? []).map((item) => item.id),
  );
  const methodGroups =
    dimensions.downstream?.methodGroups ??
    dimensions.downstream?.operationGroups ??
    [];
  const typeImpacts =
    dimensions.downstream?.typeImpacts ??
    dimensions.downstream?.sharedTypeImpacts ??
    [];
  const downstreamGroupIds = new Set(
    methodGroups.map((item) => item.id),
  );
  uniqueIds(
    methodGroups,
    "downstream method groups",
    errors,
  );
  uniqueIds(
    typeImpacts,
    "SDK type impacts",
    errors,
  );
  validateComplianceDimension(
    dimensions.compliance,
    dimensions.semantic?.items ?? [],
    errors,
  );
  for (const impact of typeImpacts) {
    downstreamGroupIds.add(impact.id);
  }
  for (const finding of [
    ...(dimensions.rest?.findings ?? []),
    ...(dimensions.downstream?.findings ?? []),
  ]) {
    for (const id of finding.relatedSemanticIntents ?? []) {
      if (!semanticIds.has(id))
        errors.push(
          `Finding ${finding.id} links unknown semantic intent ${id}.`,
        );
    }
    if (
      finding.semanticMatchBasis &&
      ![
        "operation-identity",
        "http-method-path",
        "declaration-identity",
        "unique-source",
      ].includes(finding.semanticMatchBasis)
    ) {
      errors.push(
        `Finding ${finding.id} has unsupported semantic match basis.`,
      );
    }
  }
  for (const item of dimensions.semantic?.items ?? []) {
    for (const [kind, ids] of Object.entries(item.relatedFindings ?? {})) {
      const duplicates = duplicateValues(ids);
      if (duplicates.length) {
        errors.push(
          `Semantic item ${item.id} has duplicate ${kind} links: ${duplicates.join(", ")}.`,
        );
      }
    }
    for (const id of item.relatedFindings?.rest ?? []) {
      if (!restIds.has(id))
        errors.push(
          `Semantic item ${item.id} links unknown REST finding ${id}.`,
        );
      const finding = (dimensions.rest?.findings ?? []).find(
        (candidate) => candidate.id === id,
      );
      if (finding && !finding.relatedSemanticIntents?.includes(item.id)) {
        errors.push(
          `Semantic item ${item.id} and REST finding ${id} are not reciprocal.`,
        );
      }
    }
    for (const id of [
      ...(item.relatedFindings?.downstream ?? []),
      ...(item.relatedFindings?.typeImpact ?? []),
      ...(item.relatedFindings?.sharedTypeImpact ?? []),
    ]) {
      if (!downstreamGroupIds.has(id)) {
        errors.push(
          `Semantic item ${item.id} links unknown downstream group ${id}.`,
        );
      }
    }
  }
  const downstreamFindingIds = new Set(
    (dimensions.downstream?.findings ?? []).map((item) => item.id),
  );
  const aggregatedFindingIds = [];
  for (const group of methodGroups) {
    if (!group.symbol || !group.deltas?.length)
      errors.push(`Downstream group ${group.id} is incomplete.`);
    for (const delta of group.deltas ?? []) {
      aggregatedFindingIds.push(delta.findingId);
      if (!downstreamFindingIds.has(delta.findingId)) {
        errors.push(
          `Downstream group ${group.id} links unknown finding ${delta.findingId}.`,
        );
      }
    }
    for (const id of group.relatedSemanticIntents ?? []) {
      const intent = (dimensions.semantic?.items ?? []).find(
        (item) => item.id === id,
      );
      if (!intent?.relatedFindings?.downstream?.includes(group.id)) {
        errors.push(
          `Downstream group ${group.id} and semantic item ${id} are not reciprocal.`,
        );
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
    const types = impact.type ? [impact.type] : impact.types ?? [];
    if (!impact.summary?.trim() || !types.length) {
      errors.push(`SDK type impact ${impact.id} is incomplete.`);
    }
    for (const location of impact.locations ?? []) {
      if (!allowedLocations.has(location)) {
        errors.push(
          `SDK type impact ${impact.id} has unsupported location ${location}.`,
        );
      }
    }
    if (
      impact.affectedMethodCount !==
      new Set((impact.affectedMethods ?? []).map((item) => item.symbol)).size
    ) {
      errors.push(
        `SDK type impact ${impact.id} has inconsistent method count.`,
      );
    }
    for (const id of impact.findingIds ?? []) {
      aggregatedFindingIds.push(id);
      if (!downstreamFindingIds.has(id)) {
        errors.push(
          `Shared type impact ${impact.id} links unknown finding ${id}.`,
        );
      }
    }
    for (const id of impact.relatedSemanticIntents ?? []) {
      const intent = (dimensions.semantic?.items ?? []).find(
        (item) => item.id === id,
      );
      if (
        !intent?.relatedFindings?.typeImpact?.includes(impact.id) &&
        !intent?.relatedFindings?.sharedTypeImpact?.includes(impact.id)
      ) {
        errors.push(
          `SDK type impact ${impact.id} and semantic item ${id} are not reciprocal.`,
        );
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
    errors.push(
      "Scoped safety is inconsistent with REST/downstream dimensions.",
    );
  }
  return errors;
}

if (isMain(import.meta.url)) {
  runMain(async () => {
    const file = process.argv[2];
    if (!file)
      throw new Error("Usage: validate-assessment.mjs <assessment.json>");
    const errors = validateAssessment(readJson(path.resolve(file)));
    if (errors.length) throw new Error(errors.join("\n"));
    console.log(`${path.resolve(file)} is valid.`);
  });
}
