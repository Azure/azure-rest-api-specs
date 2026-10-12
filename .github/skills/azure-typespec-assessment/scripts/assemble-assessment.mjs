import fs from "node:fs";
import path from "node:path";
import { deriveSafety, dimensionStatus } from "./assessment-display.mjs";
import { sameAutorestContract } from "./autorest-contract.mjs";
import { isMain, parseArgs, readJsonObject, runMain, writeJson } from "./cli.mjs";
import { assembleCompliance } from "./compliance-assessment.mjs";
import {
  assembleDocumentQuality,
  DOCUMENT_QUALITY_ARTIFACT,
} from "./document-quality-assessment.mjs";
import {
  diffPublicParameters,
  publicParameterContract,
  semanticLroContract,
  typeIdentity,
} from "./sdk-method-delta.mjs";
import {
  informationalIntentText,
  partitionSemanticIntents,
  semanticIntentType,
} from "./semantic-assessment-scope.mjs";
import { canonicalJson, stableId } from "./stable-id.mjs";

/** @typedef {import("./runtime-types.js").AssessmentFact} AssessmentFact */
/** @typedef {import("./runtime-types.js").AssessmentInference} AssessmentInference */
/** @typedef {import("./runtime-types.js").AssessmentJudgment} AssessmentJudgment */
/** @typedef {import("./runtime-types.js").AssessmentModelInput} AssessmentModelInput */
/** @typedef {import("./runtime-types.js").BreakingAnalysis} BreakingAnalysis */
/** @typedef {import("./runtime-types.js").BreakingCandidate} BreakingCandidate */
/** @typedef {import("./runtime-types.js").CandidateDecision} CandidateDecision */
/** @typedef {import("./runtime-types.js").ComplianceSearchRequest} ComplianceSearchRequest */
/** @typedef {import("./runtime-types.js").DownstreamAnalysis} DownstreamAnalysis */
/** @typedef {import("./runtime-types.js").DownstreamCandidate} DownstreamCandidate */
/** @typedef {import("./runtime-types.js").DownstreamRootCause} DownstreamRootCause */
/** @typedef {import("./runtime-types.js").InferenceCandidate} InferenceCandidate */
/** @typedef {import("./runtime-types.js").InferenceRequest} InferenceRequest */
/** @typedef {import("./runtime-types.js").InternalSemanticOperation} InternalSemanticOperation */
/** @typedef {import("./runtime-types.js").InternalSemanticUnit} InternalSemanticUnit */
/** @typedef {import("./runtime-types.js").PreparationManifest} PreparationManifest */
/** @typedef {import("./runtime-types.js").PreparationProject} PreparationProject */
/** @typedef {import("./runtime-types.js").SemanticAnalysis} SemanticAnalysis */
/** @typedef {import("./runtime-types.js").SdkType} SdkType */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {import("./runtime-types.js").SourceIndex} SourceIndex */
/** @typedef {import("./runtime-types.js").DocumentQualityInput} DocumentQualityInput */
/** @typedef {import("./compliance-search-evidence.schema.js").TypeSpecAzureGuidelinesSearchEvidence} ComplianceSearchEvidence */
/**
 * @typedef {{
 *   severity: "high" | "medium" | "low",
 *   rationale: string,
 *   evidence: AssessmentFact[],
 *   sources: SourceChange[],
 *   relatedSemanticIntents?: string[],
 *   semanticMatchBasis?: string,
 *   symbol?: string
 * }} JoinedFindingFields
 * @typedef {(BreakingCandidate | InferenceCandidate) & JoinedFindingFields} RestFinding
 * @typedef {(DownstreamCandidate | InferenceCandidate) & JoinedFindingFields} DownstreamFinding
 * @typedef {InternalSemanticOperation & {
 *   apiVersion?: string,
 *   method?: string,
 *   path?: string,
 *   restChanged: boolean,
 *   changedAspects: string[],
 *   before?: AssessmentFact,
 *   after?: AssessmentFact,
 *   outcome: string,
 *   sources: SourceChange[]
 * }} PresentedOperation
 * @typedef {InternalSemanticUnit & {
 *   title: string,
 *   summary: string,
 *   informational: boolean,
 *   operations: PresentedOperation[],
 *   sources: SourceChange[],
 *   relatedFindings?: {rest: string[], downstream: string[], typeImpact: string[]}
 * }} SemanticItem
 * @typedef {{
 *   name: string,
 *   optional?: boolean,
 *   onClient?: boolean,
 *   isApiVersionParam?: boolean,
 *   type?: SdkType
 * }} SdkMethodParameter
 */

/**
 * @template T
 * @param {T[]} values
 * @returns {T[]}
 */
function duplicates(values) {
  /** @type {Set<T>} */
  const seen = new Set();
  return values.filter((value) => (seen.has(value) ? true : (seen.add(value), false)));
}

/**
 * @param {string[]} expected
 * @param {string[]} actual
 * @param {string} label
 */
function exactCoverage(expected, actual, label) {
  const duplicate = duplicates(actual);
  if (duplicate.length)
    throw new Error(`Duplicate ${label} IDs: ${[...new Set(duplicate)].join(", ")}`);
  const expectedSet = new Set(expected);
  const unknown = actual.filter((item) => !expectedSet.has(item));
  const missing = expected.filter((item) => !actual.includes(item));
  if (unknown.length || missing.length) {
    throw new Error(
      `${label} coverage mismatch. Missing: ${missing.join(", ") || "none"}; unknown: ${unknown.join(", ") || "none"}.`,
    );
  }
}

/**
 * @param {CandidateDecision} decision
 * @param {{id: string}} candidate
 */
function validateDecision(decision, candidate) {
  if (!["approve", "reject"].includes(decision.decision)) {
    throw new Error(`Invalid decision for ${candidate.id}.`);
  }
  if (!decision.rationale?.trim()) throw new Error(`Missing rationale for ${candidate.id}.`);
  if (
    decision.decision === "approve" &&
    decision.severity !== "high" &&
    decision.severity !== "medium" &&
    decision.severity !== "low"
  ) {
    throw new Error(`An approve decision for candidate ${candidate.id} requires severity.`);
  }
  if (decision.decision === "reject" && decision.severity !== undefined) {
    throw new Error(`Rejected candidate ${candidate.id} must omit severity.`);
  }
}

/**
 * @param {object} value
 * @param {string[]} allowed
 * @param {string} label
 */
function assertKeys(value, allowed, label) {
  const unknown = Object.keys(value).filter((key) => !allowed.includes(key));
  if (unknown.length) throw new Error(`${label} contains unknown fields: ${unknown.join(", ")}.`);
}

/** @param {AssessmentJudgment} answer */
function validateJudgment(answer) {
  if (!answer || typeof answer !== "object" || Array.isArray(answer)) {
    throw new Error("Judgment must be an object.");
  }
  assertKeys(
    answer,
    [
      "schemaVersion",
      "semanticIntents",
      "restDecisions",
      "downstreamDecisions",
      "complianceDecisions",
      "overallConfidence",
      "blockers",
    ],
    "Judgment",
  );
  if (answer.schemaVersion !== 1) throw new Error("Unsupported judgment schemaVersion.");
  /** @type {[string, unknown][]} */
  const arrayFields = [
    ["semanticIntents", answer.semanticIntents],
    ["restDecisions", answer.restDecisions],
    ["downstreamDecisions", answer.downstreamDecisions],
    ["complianceDecisions", answer.complianceDecisions],
    ["blockers", answer.blockers],
  ];
  for (const [field, value] of arrayFields) {
    if (!Array.isArray(value)) throw new Error(`Judgment.${field} must be an array.`);
  }
  if (!["high", "medium", "low"].includes(answer.overallConfidence)) {
    throw new Error("Judgment.overallConfidence is invalid.");
  }
  if (answer.blockers.some((item) => typeof item !== "string")) {
    throw new Error("Judgment.blockers must contain strings.");
  }
  for (const intent of answer.semanticIntents) {
    assertKeys(
      intent,
      ["reviewUnitId", "title", "summary"],
      `Semantic intent ${intent.reviewUnitId ?? "<unknown>"}`,
    );
    if (!intent.title?.trim() || !intent.summary?.trim()) {
      throw new Error(`Semantic intent ${intent.reviewUnitId ?? "<unknown>"} is incomplete.`);
    }
  }
  for (const decision of [...answer.restDecisions, ...answer.downstreamDecisions]) {
    assertKeys(
      decision,
      ["candidateId", "decision", "severity", "rationale"],
      `Decision ${decision.candidateId ?? "<unknown>"}`,
    );
  }
  for (const decision of answer.complianceDecisions) {
    assertKeys(
      decision,
      [
        "reviewUnitId",
        "applicableGuidance",
        "sourceChangeIds",
        "hunkIds",
        "declarationIds",
        "decision",
        "title",
        "severity",
        "expected",
        "actual",
        "rationale",
      ],
      `Azure Guidelines decision ${decision.reviewUnitId ?? "<unknown>"}`,
    );
  }
}

/**
 * @param {AssessmentInference} inference
 * @param {InferenceRequest[]} requests
 * @param {Partial<AssessmentModelInput>} modelInput
 */
function validateInference(inference, requests, modelInput) {
  if (!inference || typeof inference !== "object" || Array.isArray(inference)) {
    throw new Error("Inference must be an object.");
  }
  assertKeys(inference, ["schemaVersion", "results"], "Inference");
  if (inference.schemaVersion !== 1) throw new Error("Unsupported inference schemaVersion.");
  if (!Array.isArray(inference.results)) throw new Error("Inference.results must be an array.");
  exactCoverage(
    requests.map((item) => item.requestId),
    inference.results.map((item) => item.requestId),
    "inference request",
  );
  const requestsById = new Map(requests.map((request) => [request.requestId, request]));
  /** @type {Map<string, InferenceCandidate>} */
  const candidatesById = new Map();
  for (const result of inference.results) {
    assertKeys(
      result,
      ["requestId", "reviewUnitId", "hunkId", "decision", "rationale", "candidates"],
      `Inference result ${result.requestId ?? "<unknown>"}`,
    );
    const request = requestsById.get(result.requestId);
    if (!request) {
      throw new Error(`Inference result ${result.requestId} is unknown.`);
    }
    if (result.reviewUnitId !== request.reviewUnitId || result.hunkId !== request.hunkId) {
      throw new Error(`Inference result ${result.requestId} does not match its request.`);
    }
    if (!["candidates", "no-impact", "blocked"].includes(result.decision)) {
      throw new Error(`Inference result ${result.requestId} has an invalid decision.`);
    }
    if (!result.rationale?.trim()) {
      throw new Error(`Inference result ${result.requestId} requires a rationale.`);
    }
    if (!Array.isArray(result.candidates)) {
      throw new Error(`Inference result ${result.requestId}.candidates must be an array.`);
    }
    if (result.decision === "candidates" && !result.candidates.length) {
      throw new Error(`Inference result ${result.requestId} requires candidates.`);
    }
    if (result.decision !== "candidates" && result.candidates.length) {
      throw new Error(`Inference result ${result.requestId} must not contain candidates.`);
    }
    for (const candidate of result.candidates) {
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
          "sourceChangeIds",
          "hunkIds",
          "operationIds",
          "evidenceFactIds",
          "reviewRequired",
        ],
        `Inferred candidate ${candidate.id ?? "<unknown>"}`,
      );
      if (!request.allowedDimensions.includes(candidate.dimension)) {
        throw new Error(`Inferred candidate ${candidate.id} uses a disallowed dimension.`);
      }
      if (!candidate.id?.startsWith(`inferred-${candidate.dimension}-`)) {
        throw new Error(`Inferred candidate ${candidate.id ?? "<unknown>"} has an invalid ID.`);
      }
      if (!candidate.rule?.trim() || !candidate.actual?.trim() || !candidate.expected?.trim()) {
        throw new Error(`Inferred candidate ${candidate.id} is incomplete.`);
      }
      if (!["high", "medium", "low"].includes(candidate.defaultSeverity)) {
        throw new Error(`Inferred candidate ${candidate.id} has an invalid default severity.`);
      }
      if (candidate.reviewRequired !== true) {
        throw new Error(`Inferred candidate ${candidate.id} must require review.`);
      }
      const allowedHunkIds = new Set(
        requests
          .filter(
            (item) =>
              item.reviewUnitId === request.reviewUnitId &&
              item.sourceChangeId === request.sourceChangeId,
          )
          .map((item) => item.hunkId),
      );
      if (
        candidate.sourceChangeIds.length !== 1 ||
        candidate.sourceChangeIds[0] !== request.sourceChangeId ||
        !candidate.hunkIds.includes(request.hunkId) ||
        candidate.hunkIds.some((id) => !allowedHunkIds.has(id))
      ) {
        throw new Error(`Inferred candidate ${candidate.id} is outside its source request.`);
      }
      if ((candidate.operationIds ?? []).some((id) => !request.relatedOperationIds.includes(id))) {
        throw new Error(`Inferred candidate ${candidate.id} uses an unknown operation.`);
      }
      if ((candidate.evidenceFactIds ?? []).some((id) => modelInput.facts?.[id] === undefined)) {
        throw new Error(`Inferred candidate ${candidate.id} uses an unknown fact.`);
      }
      if (candidate.dimension === "downstream" && !candidate.crossLanguageDefinitionId?.trim()) {
        throw new Error(`Inferred downstream candidate ${candidate.id} requires an SDK symbol.`);
      }
      const existing = candidatesById.get(candidate.id);
      if (existing && canonicalJson(existing) !== canonicalJson(candidate)) {
        throw new Error(`Inferred candidate ${candidate.id} has conflicting definitions.`);
      }
      candidatesById.set(candidate.id, candidate);
    }
  }
}

/** @param {Partial<AssessmentModelInput>} modelInput */
function validateInferenceRequests(modelInput) {
  const units = modelInput.semanticReviewUnits ?? [];
  const requests = modelInput.inferenceRequests ?? [];
  const expected = units.flatMap((unit) =>
    (unit.deterministicCoverage?.uncoveredHunkIds ?? []).map(
      (hunkId) => `${unit.reviewUnitId}\u0000${hunkId}`,
    ),
  );
  const actual = requests.map((request) => `${request.reviewUnitId}\u0000${request.hunkId}`);
  exactCoverage(expected, actual, "inference request target");
  const unitsById = new Map(units.map((unit) => [unit.reviewUnitId, unit]));
  for (const request of requests) {
    const unit = unitsById.get(request.reviewUnitId);
    const evidenceRef = request.evidenceRef;
    if (
      !unit ||
      evidenceRef?.artifact !== "source/source-index.json" ||
      evidenceRef.sourceChangeId !== request.sourceChangeId ||
      evidenceRef.hunkId !== request.hunkId
    ) {
      throw new Error(`Inference request ${request.requestId} has unknown source evidence.`);
    }
    if (!request.sourceExcerpt?.trim()) {
      throw new Error(`Inference request ${request.requestId} has no source excerpt.`);
    }
  }
}

/**
 * @param {SourceIndex} sourceIndex
 * @returns {Record<string, SourceChange>}
 */
function sourceMap(sourceIndex) {
  return Object.fromEntries(sourceIndex.sourceChanges.map((source) => [source.id, source]));
}

/**
 * @template {BreakingCandidate | DownstreamCandidate | InferenceCandidate} T
 * @param {T[]} candidates
 * @param {CandidateDecision[]} decisions
 * @param {Record<string, AssessmentFact>} facts
 * @param {Record<string, SourceChange>} sources
 * @returns {(T & JoinedFindingFields)[]}
 */
function joinFindings(candidates, decisions, facts, sources) {
  const decisionMap = new Map(decisions.map((decision) => [decision.candidateId, decision]));
  return candidates.flatMap((candidate) => {
    const decision = decisionMap.get(candidate.id);
    if (!decision) {
      throw new Error(`Missing decision for ${candidate.id}.`);
    }
    validateDecision(decision, candidate);
    if (decision.decision === "reject") return [];
    if (decision.severity === undefined) {
      throw new Error(`Missing severity for ${candidate.id}.`);
    }
    return [
      {
        ...candidate,
        severity: decision.severity,
        rationale: decision.rationale,
        evidence: candidate.evidenceFactIds.map((id) => facts[id]).filter(Boolean),
        sources: candidate.sourceChangeIds
          .map((id) => {
            const source = sources[id];
            return source && candidate.hunkIds?.length
              ? sourceForUnit(source, candidate.hunkIds)
              : source;
          })
          .filter(Boolean),
      },
    ];
  });
}

/**
 * @param {AssessmentFact | undefined} before
 * @param {AssessmentFact | undefined} after
 * @param {string[]} fields
 */
function changedFields(before, after, fields) {
  return fields.filter((field) => !sameAutorestContract(before?.[field], after?.[field]));
}

/**
 * @param {InternalSemanticOperation} operation
 * @param {Record<string, AssessmentFact>} facts
 */
function operationPresentation(operation, facts) {
  const before = operation.beforeFactId ? facts[operation.beforeFactId] : undefined;
  const after = operation.afterFactId ? facts[operation.afterFactId] : undefined;
  const current = after ?? before;
  const changed = changedFields(before, after, [
    "method",
    "path",
    "parameters",
    "request",
    "responses",
    "paging",
    "lro",
    "consumes",
    "produces",
  ]);
  const wireChanges = changed.filter((field) => field !== "paging");
  return {
    ...operation,
    apiVersion: current?.apiVersion,
    method: current?.method,
    path: current?.path,
    restChanged: wireChanges.length > 0,
    changedAspects: changed,
    before,
    after,
    outcome: wireChanges.length
      ? `REST contract changed: ${wireChanges.join(", ")}.`
      : changed.includes("paging")
        ? "HTTP signature and represented payload contract unchanged; SDK paging metadata changed."
        : "HTTP signature and represented payload contract unchanged.",
  };
}

/**
 * @param {InternalSemanticUnit} unit
 * @param {PresentedOperation[]} operations
 */
function semanticAction(unit, operations) {
  if (
    operations.length &&
    operations.every((operation) => !operation.beforeFactId && operation.afterFactId)
  ) {
    return "add";
  }
  if (
    operations.length &&
    operations.every((operation) => operation.beforeFactId && !operation.afterFactId)
  ) {
    return "remove";
  }
  if (operations.length) return "modify";
  return unit.action ?? unit.changeKind;
}

/**
 * @param {SourceChange} source
 * @param {string[]} hunkIds
 * @returns {SourceChange}
 */
function sourceForUnit(source, hunkIds) {
  const allowed = new Set(hunkIds);
  return {
    ...source,
    hunks: (source.hunks ?? []).filter((hunk) => allowed.has(hunk.id)),
    declarations: (source.declarations ?? []).filter((declaration) =>
      declaration.hunkIds?.some((id) => allowed.has(id)),
    ),
  };
}

/**
 * @param {InternalSemanticOperation} operation
 * @param {InternalSemanticUnit} unit
 * @param {Record<string, SourceChange>} sources
 * @param {Record<string, AssessmentFact>} facts
 * @param {Map<string, PreparationProject>} projectsById
 * @returns {SourceChange[]}
 */
function sourcesForOperation(operation, unit, sources, facts, projectsById) {
  let sourceChangeIds = operation.sourceChangeIds ?? [];
  let hunkIds = operation.hunkIds ?? [];
  const publication = (unit.groupingEvidence?.reasons ?? []).some(
    (reason) => reason === "publication" || reason.includes("api-version-publication"),
  );
  if (!sourceChangeIds.length && publication) {
    const unitHunkIds = new Set(unit.hunkIds ?? []);
    const operationFactId = operation.afterFactId ?? operation.beforeFactId;
    const operationFact = operationFactId ? facts[operationFactId] : undefined;
    const projectId = operationFact?.projectId;
    const projectPath = projectId ? projectsById.get(projectId)?.path : undefined;
    /** @param {SourceChange | undefined} source */
    const inProject = (source) =>
      !projectPath || source?.path === projectPath || source?.path?.startsWith(`${projectPath}/`);
    const governance = (unit.sourceChangeIds ?? []).flatMap((sourceId) => {
      const source = sources[sourceId];
      if (!inProject(source)) return [];
      const versionHunkIds = (source?.declarations ?? [])
        .filter(
          (declaration) =>
            declaration.qualifiedName === "Versions" ||
            declaration.qualifiedName?.endsWith(".Versions"),
        )
        .flatMap((declaration) => declaration.hunkIds ?? [])
        .filter((hunkId) => unitHunkIds.has(hunkId));
      return versionHunkIds.length ? [{ sourceId, hunkIds: versionHunkIds }] : [];
    });
    sourceChangeIds = governance.map((item) => item.sourceId);
    hunkIds = [...new Set(governance.flatMap((item) => item.hunkIds))];
  }
  if (!sourceChangeIds.length && unit.sourceChangeIds?.length === 1) {
    sourceChangeIds = unit.sourceChangeIds;
    hunkIds = unit.hunkIds;
  }
  return sourceChangeIds
    .map((id) => sources[id] && sourceForUnit(sources[id], hunkIds))
    .filter((source) => source !== undefined);
}

/** @param {DownstreamFinding} finding */
function methodFacts(finding) {
  /** @param {AssessmentFact} fact */
  const role = (fact) =>
    fact.comparisonRole ??
    (fact.revision === "base" ? "baseline" : fact.revision === "current" ? "target" : undefined);
  return {
    before: finding.evidence.find(
      (fact) => fact.factKind === "method" && role(fact) === "baseline",
    ),
    after: finding.evidence.find((fact) => fact.factKind === "method" && role(fact) === "target"),
  };
}

/**
 * @param {AssessmentFact | undefined} fact
 * @param {string} field
 */
function methodDeltaValue(fact, field) {
  if (field === "responseType") {
    return typeIdentity(fact?.responseType) ?? "void";
  }
  if (field === "lro") {
    const semantic = semanticLroContract(fact?.lro);
    if (!semantic) return "none";
    return {
      finalStateVia: semantic.finalStateVia,
      logicalResult: typeIdentity(semantic.logicalResult),
      pollingStep: semantic.pollingStep?.kind ?? semantic.pollingStep?.responseBody?.kind,
      finalStep: semantic.finalStep?.kind,
      statusMonitorStep: semantic.statusMonitorStep?.kind,
    };
  }
  if (field === "paging") {
    return fact?.paging
      ? {
          nextLinkName: fact.paging.nextLinkName,
          itemName: fact.paging.itemName,
        }
      : "none";
  }
  return fact?.[field] ?? "none";
}

/**
 * The SDK delta helpers require names produced by the SDK analyzer.
 * @param {AssessmentFact["parameters"]} parameters
 * @returns {SdkMethodParameter[] | undefined}
 */
function sdkMethodParameters(parameters) {
  return /** @type {SdkMethodParameter[] | undefined} */ (/** @type {unknown} */ (parameters));
}

/** @type {Record<string, string | undefined>} */
const METHOD_RULE_FIELDS = {
  "method-kind-changed": "kind",
  "method-location-changed": "client",
  "method-parameters-changed": "parameters",
  "method-response-changed": "responseType",
  "method-access-changed": "access",
  "method-paging-changed": "paging",
  "method-lro-changed": "lro",
};

/** @param {DownstreamFinding} finding */
function meaningfulDownstreamFinding(finding) {
  const field = METHOD_RULE_FIELDS[finding.rule];
  if (!field) return true;
  const { before, after } = methodFacts(finding);
  if (!before && !after) return true;
  if (field === "parameters") {
    return (
      canonicalJson(publicParameterContract(sdkMethodParameters(before?.parameters))) !==
      canonicalJson(publicParameterContract(sdkMethodParameters(after?.parameters)))
    );
  }
  const beforeValue =
    field === "lro" ? semanticLroContract(before?.lro) : methodDeltaValue(before, field);
  const afterValue =
    field === "lro" ? semanticLroContract(after?.lro) : methodDeltaValue(after, field);
  return canonicalJson(beforeValue ?? null) !== canonicalJson(afterValue ?? null);
}

/** @param {SemanticItem[]} semanticItems */
function semanticOperationIndex(semanticItems) {
  /** @type {{intent: SemanticItem, operation: PresentedOperation}[]} */
  const operations = [];
  for (const intent of semanticItems) {
    for (const operation of intent.operations) {
      operations.push({ intent, operation });
    }
  }
  return operations;
}

/**
 * @param {DownstreamFinding} finding
 * @param {SemanticItem[]} semanticItems
 */
export function matchTypeFindingIntents(finding, semanticItems) {
  const typeNames = new Set(
    [
      finding.crossLanguageDefinitionId?.split(".").at(-1),
      finding.symbol?.split(".").at(-1),
      ...(finding.evidence ?? []).map((fact) => fact.name),
    ].filter(Boolean),
  );
  if (!typeNames.size) return [];
  return semanticItems.filter((intent) => {
    const declarationIds = new Set(intent.declarationIds ?? []);
    return (intent.sources ?? []).some((source) =>
      (source.declarations ?? []).some((declaration) => {
        if (declarationIds.size && !declarationIds.has(declaration.id)) {
          return false;
        }
        const declarationSegments = declaration.qualifiedName?.split(".") ?? [];
        return declarationSegments.some((segment) => typeNames.has(segment));
      }),
    );
  });
}

/**
 * @param {RestFinding[]} restFindings
 * @param {DownstreamFinding[]} downstreamFindings
 * @param {SemanticItem[]} semanticItems
 */
function findingRelations(restFindings, downstreamFindings, semanticItems) {
  const semanticOperations = semanticOperationIndex(semanticItems);
  for (const finding of restFindings) {
    const matches = semanticOperations.filter(({ operation }) =>
      finding.operationIds.includes(operation.operationId),
    );
    finding.relatedSemanticIntents = [...new Set(matches.map(({ intent }) => intent.id))];
    finding.semanticMatchBasis = finding.relatedSemanticIntents.length
      ? "operation-identity"
      : undefined;
  }
  for (const finding of downstreamFindings) {
    const declarationMatches = matchTypeFindingIntents(finding, semanticItems);
    if (declarationMatches.length) {
      finding.relatedSemanticIntents = declarationMatches.map((intent) => intent.id);
      finding.semanticMatchBasis = "declaration-identity";
      continue;
    }
    const sourceIds = new Set(finding.sourceChangeIds);
    const sourceMatches = semanticItems.filter((intent) =>
      intent.sourceChangeIds.some((id) => sourceIds.has(id)),
    );
    finding.relatedSemanticIntents = sourceMatches.length === 1 ? [sourceMatches[0].id] : [];
    finding.semanticMatchBasis = sourceMatches.length === 1 ? "unique-source" : undefined;
  }
}

/**
 * @param {DownstreamFinding[]} downstreamFindings
 * @param {DownstreamRootCause[]} [rootCauses]
 * @param {Record<string, AssessmentFact>} [facts]
 */
function downstreamGroups(downstreamFindings, rootCauses = [], facts = {}) {
  /** @type {Map<string, {
   *   id: string,
   *   projectId?: string,
   *   symbol: string,
   *   before?: AssessmentFact,
   *   after?: AssessmentFact,
   *   findings: DownstreamFinding[]
   * }>} */
  const byMethod = new Map();
  /** @type {DownstreamFinding[]} */
  const typeFindings = [];
  for (const finding of downstreamFindings) {
    const facts = methodFacts(finding);
    if (!facts.before && !facts.after) {
      typeFindings.push(finding);
      continue;
    }
    const symbol = finding.crossLanguageDefinitionId ?? finding.symbol;
    if (!symbol) {
      throw new Error(`Downstream finding ${finding.id} has no SDK symbol.`);
    }
    const projectId = (facts.after ?? facts.before)?.projectId;
    const key = `${projectId ?? ""}:${symbol}`;
    const group = byMethod.get(key) ?? {
      id: stableId("downstream-group", { projectId, symbol }),
      projectId,
      symbol,
      before: facts.before,
      after: facts.after,
      findings: [],
    };
    group.before ??= facts.before;
    group.after ??= facts.after;
    group.findings.push(finding);
    byMethod.set(key, group);
  }
  const methodGroups = [...byMethod.values()]
    .map((group) => {
      const representative = group.findings[0];
      return {
        ...group,
        apiVersion: (group.after ?? group.before)?.apiVersion,
        parametersUnchanged:
          canonicalJson(publicParameterContract(sdkMethodParameters(group.before?.parameters))) ===
          canonicalJson(publicParameterContract(sdkMethodParameters(group.after?.parameters))),
        deltas: group.findings.map((finding) => {
          const field = METHOD_RULE_FIELDS[finding.rule];
          /** @type {Record<string, unknown> & {
           *   findingId: string,
           *   rule: string,
           *   field: string | undefined,
           *   severity: string,
           *   actual: string,
           *   expected: string,
           *   rationale: string
           * }} */
          const delta = {
            findingId: finding.id,
            rule: finding.rule,
            field,
            severity: finding.severity,
            actual: finding.actual,
            expected: finding.expected,
            rationale: finding.rationale,
          };
          if (field === "parameters") {
            delta.changes = diffPublicParameters(
              sdkMethodParameters(group.before?.parameters),
              sdkMethodParameters(group.after?.parameters),
            );
          } else if (field) {
            delta.before = methodDeltaValue(group.before, field);
            delta.after = methodDeltaValue(group.after, field);
          }
          return delta;
        }),
        rootCauseIds: [
          ...new Set(group.findings.flatMap((finding) => finding.rootCauseIds ?? [])),
        ].sort(),
        relatedSemanticIntents: representative.relatedSemanticIntents ?? [],
      };
    })
    .sort((left, right) => left.symbol.localeCompare(right.symbol));
  const rootCauseById = new Map(rootCauses.map((item) => [item.id, item]));
  /** @type {Map<string, {
   *   projectId?: string,
   *   type: string,
   *   findings: DownstreamFinding[],
   *   rootCauseIds: Set<string>
   * }>} */
  const typeGroups = new Map();
  for (const finding of typeFindings) {
    const type = finding.crossLanguageDefinitionId ?? finding.symbol;
    if (!type) {
      throw new Error(`Downstream finding ${finding.id} has no SDK type.`);
    }
    const projectId = finding.evidence.find((fact) => fact.projectId)?.projectId;
    const key = `${projectId ?? ""}:${type}`;
    const group = typeGroups.get(key) ?? {
      projectId,
      type,
      findings: [],
      rootCauseIds: new Set(),
    };
    group.findings.push(finding);
    for (const id of finding.rootCauseIds ?? []) group.rootCauseIds.add(id);
    typeGroups.set(key, group);
  }
  const typeImpacts = [...typeGroups.values()]
    .map((group) => {
      const findingIds = group.findings.map((finding) => finding.id).sort();
      const roots = [...group.rootCauseIds]
        .map((id) => rootCauseById.get(id))
        .filter((root) => root !== undefined);
      /** @type {Map<string, {
       *   symbol: string,
       *   locations: Set<string>,
       *   referenceFactIds: Set<string>
       * }>} */
      const affectedMethods = new Map();
      for (const root of roots) {
        const locations = [
          ...new Set(
            (root.referenceEvidence ?? [])
              .map((edge) => edge.location)
              .filter((location) => location !== undefined),
          ),
        ].sort();
        const referenceFactIds = [
          ...new Set(
            (root.referenceEvidence ?? [])
              .flatMap((edge) => [edge.fromFactId, edge.toFactId])
              .filter((id) => id !== undefined),
          ),
        ].sort();
        for (const methodFactId of root.methodFactIds ?? []) {
          const method = facts[methodFactId];
          if (!method || method.factKind !== "method") continue;
          const symbol = method.crossLanguageDefinitionId ?? method.identity ?? method.name;
          if (!symbol) continue;
          const current = affectedMethods.get(symbol) ?? {
            symbol,
            locations: new Set(),
            referenceFactIds: new Set(),
          };
          locations.forEach((location) => current.locations.add(location));
          referenceFactIds.forEach((id) => current.referenceFactIds.add(id));
          affectedMethods.set(symbol, current);
        }
      }
      const methods = [...affectedMethods.values()]
        .map((method) => ({
          symbol: method.symbol,
          locations: [...method.locations].sort(),
          referenceFactIds: [...method.referenceFactIds].sort(),
        }))
        .sort((left, right) => left.symbol.localeCompare(right.symbol));
      const locations = [...new Set(methods.flatMap((method) => method.locations))].sort();
      const relatedSemanticIntents = [
        ...new Set(group.findings.flatMap((finding) => finding.relatedSemanticIntents ?? [])),
      ].sort();
      return {
        id: stableId("sdk-type-impact", {
          projectId: group.projectId,
          type: group.type,
          findingIds,
        }),
        projectId: group.projectId,
        type: group.type,
        locations,
        rootCauseIds: [...group.rootCauseIds].sort(),
        summary: "This generated SDK type has a confirmed public contract change.",
        findingIds,
        affectedMethodCount: methods.length,
        affectedMethods: methods,
        relatedSemanticIntents,
        unresolvedRelationshipReason: methods.length
          ? null
          : "No public SDK method reference path was deterministically established.",
      };
    })
    .sort((left, right) => left.id.localeCompare(right.id));
  return { methodGroups, typeImpacts };
}

/**
 * @param {SemanticItem[]} semanticItems
 * @param {RestFinding[]} restFindings
 * @param {{
 *   methodGroups: {id: string, relatedSemanticIntents: string[]}[],
 *   typeImpacts: {id: string, relatedSemanticIntents: string[]}[]
 * }} downstream
 */
function addReciprocalRelations(semanticItems, restFindings, downstream) {
  for (const intent of semanticItems) {
    intent.relatedFindings = {
      rest: restFindings
        .filter((finding) => finding.relatedSemanticIntents?.includes(intent.id))
        .map((finding) => finding.id)
        .sort(),
      downstream: downstream.methodGroups
        .filter((group) => group.relatedSemanticIntents.includes(intent.id))
        .map((group) => group.id)
        .sort(),
      typeImpact: downstream.typeImpacts
        .filter((group) => group.relatedSemanticIntents.includes(intent.id))
        .map((group) => group.id)
        .sort(),
    };
  }
}

/**
 * @param {{work: string, judgment: string | AssessmentJudgment}} options
 */
export function assembleAssessment({ work, judgment }) {
  const manifest = /** @type {PreparationManifest} */ (
    /** @type {unknown} */ (readJsonObject(path.join(work, "preparation-manifest.json")))
  );
  const sourceIndex = /** @type {SourceIndex} */ (
    /** @type {unknown} */ (readJsonObject(path.join(work, "source", "source-index.json")))
  );
  const semantic = /** @type {SemanticAnalysis} */ (
    /** @type {unknown} */ (
      readJsonObject(path.join(work, "dimensions", "semantic-intents-input.json"))
    )
  );
  const rest = /** @type {BreakingAnalysis} */ (
    /** @type {unknown} */ (
      readJsonObject(path.join(work, "dimensions", "rest-breaking-input.json"))
    )
  );
  const downstream = /** @type {DownstreamAnalysis} */ (
    /** @type {unknown} */ (
      readJsonObject(path.join(work, "dimensions", "downstream-breaking-input.json"))
    )
  );
  const answer =
    typeof judgment === "string"
      ? /** @type {AssessmentJudgment} */ (/** @type {unknown} */ (readJsonObject(judgment)))
      : judgment;
  const modelInputPath = path.join(work, "model-input.json");
  /** @type {Partial<AssessmentModelInput>} */
  const modelInput = fs.existsSync(modelInputPath) ? readJsonObject(modelInputPath) : {};
  /**
   * @template {{id: string}} T
   * @param {T[]} canonicalCandidates
   * @param {{id: string}[] | undefined} inputCandidates
   * @param {string} label
   * @returns {T[]}
   */
  const scopedCandidates = (canonicalCandidates, inputCandidates, label) => {
    if (!Array.isArray(inputCandidates)) return canonicalCandidates;
    const canonicalById = new Map(
      canonicalCandidates.map((candidate) => [candidate.id, candidate]),
    );
    const unknownIds = inputCandidates
      .map((candidate) => candidate.id)
      .filter((id) => !canonicalById.has(id));
    if (unknownIds.length) {
      throw new Error(
        `${label} model input references unknown candidates: ${unknownIds.join(", ")}.`,
      );
    }
    return inputCandidates.map((candidate) => {
      const canonical = canonicalById.get(candidate.id);
      if (!canonical) {
        throw new Error(`${label} model input candidate is unavailable.`);
      }
      return canonical;
    });
  };
  const assessedRestCandidates = scopedCandidates(
    rest.candidates,
    modelInput.restCandidates,
    "REST",
  );
  const assessedDownstreamCandidates = scopedCandidates(
    downstream.candidates,
    modelInput.downstreamCandidates,
    "Downstream",
  );
  validateInferenceRequests(modelInput);
  const inferenceRequests = modelInput.inferenceRequests ?? [];
  const inferencePath = path.join(work, "inference.json");
  if (inferenceRequests.length && !fs.existsSync(inferencePath)) {
    throw new Error("Missing inference.json.");
  }
  if (!inferenceRequests.length && fs.existsSync(inferencePath)) {
    throw new Error("Unexpected inference.json without inference requests.");
  }
  const inference = inferenceRequests.length
    ? /** @type {AssessmentInference} */ (/** @type {unknown} */ (readJsonObject(inferencePath)))
    : undefined;
  if (inference) validateInference(inference, inferenceRequests, modelInput);
  const inferredCandidates = [
    ...new Map(
      (inference?.results ?? []).flatMap((result) =>
        result.candidates.map((candidate) => [
          candidate.id,
          {
            ...candidate,
            inferred: true,
            inferenceRequestIds: (inference?.results ?? [])
              .filter((item) => item.candidates.some((value) => value.id === candidate.id))
              .map((item) => item.requestId)
              .sort(),
          },
        ]),
      ),
    ).values(),
  ];
  const restCandidates = [
    ...assessedRestCandidates,
    ...inferredCandidates.filter((candidate) => candidate.dimension === "rest"),
  ];
  const downstreamCandidates = [
    ...assessedDownstreamCandidates,
    ...inferredCandidates.filter((candidate) => candidate.dimension === "downstream"),
  ];
  const deterministicCandidateIds = new Set([
    ...rest.candidates.map((candidate) => candidate.id),
    ...downstream.candidates.map((candidate) => candidate.id),
  ]);
  const conflictingCandidateIds = inferredCandidates
    .map((candidate) => candidate.id)
    .filter((id) => deterministicCandidateIds.has(id));
  if (conflictingCandidateIds.length) {
    throw new Error(
      `Inferred candidate IDs conflict with deterministic candidates: ${conflictingCandidateIds.join(", ")}.`,
    );
  }
  const inferenceRequestsById = new Map(
    inferenceRequests.map((request) => [request.requestId, request]),
  );
  const inferenceBlockers = (inference?.results ?? [])
    .filter((result) => result.decision === "blocked")
    .map((result) => {
      const request = inferenceRequestsById.get(result.requestId);
      if (!request) {
        throw new Error(`Inference result ${result.requestId} is unknown.`);
      }
      return {
        code: "inference-blocked",
        reviewUnitId: result.reviewUnitId,
        hunkId: result.hunkId,
        allowedDimensions: request.allowedDimensions,
        message: result.rationale,
      };
    });
  const complianceEvidencePath = path.join(work, "compliance-search-evidence.json");
  const modelComplianceRequests = modelInput.complianceSearchRequests;
  const hasComplianceContract = Array.isArray(modelComplianceRequests);
  const scopedComplianceRequests = hasComplianceContract ? modelComplianceRequests : [];
  const hasComplianceInput = hasComplianceContract && scopedComplianceRequests.length > 0;
  const complianceRequestArtifact = modelInput.artifactReferences?.complianceSearchRequests;
  const complianceRequests =
    hasComplianceInput && complianceRequestArtifact
      ? /** @type {{requests: ComplianceSearchRequest[]}} */ (
          readJsonObject(path.join(work, complianceRequestArtifact))
        ).requests
      : /** @type {ComplianceSearchRequest[]} */ (
          /** @type {unknown} */ (scopedComplianceRequests)
        );
  if (hasComplianceInput && complianceRequestArtifact) {
    exactCoverage(
      scopedComplianceRequests.map((item) => item.requestId),
      complianceRequests.map((item) => item.requestId),
      "Azure Guidelines search request",
    );
  }
  if (hasComplianceInput && !fs.existsSync(complianceEvidencePath)) {
    throw new Error("Missing compliance-search-evidence.json.");
  }
  const complianceEvidence = hasComplianceInput
    ? /** @type {ComplianceSearchEvidence} */ (
        /** @type {unknown} */ (readJsonObject(complianceEvidencePath))
      )
    : undefined;
  if (hasComplianceInput && !complianceEvidence) {
    throw new Error("Missing compliance search evidence.");
  }
  validateJudgment(answer);
  const scopedSemantic = partitionSemanticIntents(semantic.reviewUnits);
  const modelSemanticReviewUnits = modelInput.semanticReviewUnits;
  const hasScopedSemanticInput = Array.isArray(modelSemanticReviewUnits);
  const scopedModelSemanticUnits = hasScopedSemanticInput ? modelSemanticReviewUnits : [];
  const informationalSemanticIntentIds = new Set(modelInput.informationalSemanticIntentIds ?? []);
  if (hasScopedSemanticInput) {
    exactCoverage(
      scopedSemantic.informational.map((item) => item.id),
      [...informationalSemanticIntentIds],
      "informational semantic review unit",
    );
    exactCoverage(
      scopedSemantic.assessed.map((item) => item.id),
      scopedModelSemanticUnits.map((item) => item.reviewUnitId),
      "model-input semantic review unit",
    );
  }
  const assessedSemanticIntentIds = hasScopedSemanticInput
    ? scopedModelSemanticUnits.map((item) => item.reviewUnitId)
    : semantic.reviewUnits.map((item) => item.id);
  exactCoverage(
    assessedSemanticIntentIds,
    answer.semanticIntents.map((item) => item.reviewUnitId),
    "assessed semantic review unit",
  );
  exactCoverage(
    restCandidates.map((item) => item.id),
    answer.restDecisions.map((item) => item.candidateId),
    "REST candidate",
  );
  exactCoverage(
    downstreamCandidates.map((item) => item.id),
    answer.downstreamDecisions.map((item) => item.candidateId),
    "downstream candidate",
  );
  const sources = sourceMap(sourceIndex);
  const projectsById = new Map((manifest.projects ?? []).map((project) => [project.id, project]));
  const semanticUnits = new Map(semantic.reviewUnits.map((unit) => [unit.id, unit]));
  const modelSemanticUnits = new Map(
    scopedModelSemanticUnits.map((unit) => [unit.reviewUnitId, unit]),
  );
  /** @type {Map<string, import("./runtime-types.js").InferenceResult[]>} */
  const inferenceResultsByUnit = new Map();
  for (const result of inference?.results ?? []) {
    const values = inferenceResultsByUnit.get(result.reviewUnitId) ?? [];
    values.push(result);
    inferenceResultsByUnit.set(result.reviewUnitId, values);
  }
  const authoredSemanticIntents = new Map(
    answer.semanticIntents.map((intent) => [intent.reviewUnitId, intent]),
  );
  const semanticIntentAnswers = semantic.reviewUnits.map((unit) => {
    const intent = informationalSemanticIntentIds.has(unit.id)
      ? informationalIntentText(unit)
      : authoredSemanticIntents.get(unit.id);
    if (!intent) {
      throw new Error(`Missing authored Semantic intent ${unit.id}.`);
    }
    return intent;
  });
  /** @type {SemanticItem[]} */
  const semanticItems = semanticIntentAnswers.map((intent) => {
    const unit = semanticUnits.get(intent.reviewUnitId);
    if (!unit) {
      throw new Error(`Unknown Semantic intent ${intent.reviewUnitId}.`);
    }
    const modelUnit = modelSemanticUnits.get(intent.reviewUnitId);
    const operations = (
      unit.operations ??
      unit.operationIds.map((id) => ({
        operationId: semantic.facts[id]?.operationId,
        beforeFactId: unit.beforeFactIds?.find(
          (factId) => semantic.facts[factId]?.operationId === semantic.facts[id]?.operationId,
        ),
        afterFactId:
          unit.afterFactIds?.find(
            (factId) => semantic.facts[factId]?.operationId === semantic.facts[id]?.operationId,
          ) ??
          ((semantic.facts[id]?.comparisonRole ?? semantic.facts[id]?.revision) === "baseline" ||
          semantic.facts[id]?.revision === "base"
            ? undefined
            : id),
      }))
    ).map((operation) => ({
      ...operationPresentation(operation, semantic.facts),
      sources: sourcesForOperation(operation, unit, sources, semantic.facts, projectsById),
    }));
    const action = semanticAction(unit, operations);
    return {
      ...unit,
      action,
      changeKind: action,
      intentType: unit.intentType ?? semanticIntentType(unit),
      title: intent.title,
      summary: intent.summary,
      informational: informationalSemanticIntentIds.has(intent.reviewUnitId),
      ...(modelUnit?.deterministicCoverage
        ? {
            deterministicCoverage: modelUnit.deterministicCoverage,
            inferenceRequired: modelUnit.inferenceRequired,
          }
        : {}),
      ...(inferenceResultsByUnit.has(intent.reviewUnitId)
        ? {
            inferenceResults: (inferenceResultsByUnit.get(intent.reviewUnitId) ?? []).map(
              (result) => ({
                requestId: result.requestId,
                hunkId: result.hunkId,
                decision: result.decision,
                rationale: result.rationale,
                candidateIds: result.candidates.map((candidate) => candidate.id),
              }),
            ),
          }
        : {}),
      operations,
      sources: unit.sourceChangeIds
        .map(
          (id) =>
            sources[id] &&
            sourceForUnit(sources[id], unit.hunkIds ?? sources[id].hunks.map((hunk) => hunk.id)),
        )
        .filter(Boolean),
    };
  });
  const restFindings = joinFindings(
    restCandidates,
    answer.restDecisions,
    { ...modelInput.facts, ...rest.facts },
    sources,
  );
  const downstreamFindings = joinFindings(
    downstreamCandidates,
    answer.downstreamDecisions,
    { ...modelInput.facts, ...downstream.facts },
    sources,
  ).filter(meaningfulDownstreamFinding);
  findingRelations(
    restFindings,
    downstreamFindings,
    semanticItems.filter((intent) => !intent.informational),
  );
  const downstreamAggregation = downstreamGroups(downstreamFindings, downstream.rootCauses, {
    ...modelInput.facts,
    ...downstream.facts,
  });
  addReciprocalRelations(semanticItems, restFindings, downstreamAggregation);
  const restDimension = {
    status: dimensionStatus(
      rest.status === "blocked" ||
        inferenceBlockers.some((blocker) => blocker.allowedDimensions.includes("rest")),
      restFindings,
    ),
    findings: restFindings,
    rejectedCandidateCount: answer.restDecisions.filter((item) => item.decision === "reject")
      .length,
    blockers: [
      ...rest.blockers,
      ...inferenceBlockers.filter((blocker) => blocker.allowedDimensions.includes("rest")),
    ],
  };
  const downstreamDimension = {
    status: dimensionStatus(
      downstream.status === "blocked" ||
        inferenceBlockers.some((blocker) => blocker.allowedDimensions.includes("downstream")),
      downstreamFindings,
    ),
    findings: downstreamFindings,
    methodGroups: downstreamAggregation.methodGroups,
    typeImpacts: downstreamAggregation.typeImpacts,
    rootCauses: downstream.rootCauses ?? [],
    rejectedCandidateCount: answer.downstreamDecisions.filter((item) => item.decision === "reject")
      .length,
    blockers: [
      ...downstream.blockers,
      ...inferenceBlockers.filter((blocker) => blocker.allowedDimensions.includes("downstream")),
    ],
  };
  const complianceDimension = hasComplianceInput
    ? assembleCompliance({
        requests: complianceRequests,
        evidence: /** @type {ComplianceSearchEvidence} */ (complianceEvidence),
        decisions: answer.complianceDecisions,
        sourceChanges: sourceIndex.sourceChanges,
        initialBlockers:
          semantic.status === "blocked"
            ? semantic.blockers.length
              ? semantic.blockers
              : ["semantic-analysis-blocked: Azure Guidelines requires Semantic intents."]
            : [],
      })
    : hasComplianceContract
      ? {
          status: "passed",
          summary: "No assessed Semantic intents require Azure Guidelines review.",
          coverage: {
            semanticIntentCount: 0,
            assessedIntentCount: 0,
            selectedDocumentCount: 0,
            unassessedIntentIds: [],
          },
          intentAssessments: [],
          findings: [],
          retrievalFailures: [],
          blockers: [],
        }
      : {
          status: "not-assessed",
          summary: "Azure Guidelines search input was not available.",
          coverage: {
            semanticIntentCount: 0,
            assessedIntentCount: 0,
            selectedDocumentCount: 0,
            unassessedIntentIds: [],
          },
          intentAssessments: [],
          findings: [],
          retrievalFailures: [],
          blockers: [
            {
              message: "compliance-search-input-missing: rerun deterministic analysis.",
            },
          ],
        };
  const documentQualityPath = path.join(work, DOCUMENT_QUALITY_ARTIFACT);
  const documentQualityDimension = assembleDocumentQuality({
    input: fs.existsSync(documentQualityPath)
      ? /** @type {DocumentQualityInput} */ (
          /** @type {unknown} */ (readJsonObject(documentQualityPath))
        )
      : undefined,
    modelInput,
    decisions: undefined,
    semanticUnits: scopedSemantic.assessed,
    semanticStatus: semantic.status,
    sourceChanges: sourceIndex.sourceChanges,
  });
  return {
    schemaVersion: 1,
    generatedAt: new Date().toISOString(),
    title: `TypeSpec assessment: ${manifest.projects.map((project) => project.path).join(", ")}`,
    repository: manifest.repository,
    ...(manifest.pullRequest ? { pullRequest: manifest.pullRequest } : {}),
    comparison: {
      baseRef: manifest.comparison.baseRef,
      baseCommit: manifest.comparison.mergeBaseCommit,
      headCommit: manifest.comparison.headCommit,
      workingTree: manifest.comparison.workingTree,
    },
    artifactComparisons: manifest.projects.map((project) => ({
      projectId: project.id,
      ...(project.artifactComparison ?? {
        mode: "legacy",
        baseline: {
          sourceRevision: "base",
          commit: manifest.comparison.mergeBaseCommit,
          apiVersion: project.apiVersions?.base,
          reason: project.apiVersions?.baseReason ?? "legacy-selection",
        },
        target: {
          sourceRevision: "current",
          commit: manifest.comparison.headCommit,
          apiVersion: project.apiVersions?.current,
          reason: project.apiVersions?.currentReason ?? "legacy-selection",
        },
      }),
    })),
    confidence: answer.overallConfidence,
    safety: deriveSafety(restDimension, downstreamDimension),
    dimensions: {
      semantic: {
        status: semantic.status === "blocked" ? "not-assessed" : "assessed",
        items: semanticItems,
        sourceHunkIds: sourceIndex.sourceChanges
          .flatMap((source) => (source.hunks ?? []).map((hunk) => hunk.id))
          .sort(),
        blockers: semantic.blockers,
      },
      rest: restDimension,
      downstream: downstreamDimension,
      compliance: complianceDimension,
      documentQuality: documentQualityDimension,
    },
    changedFiles: manifest.changedFiles,
    projects: manifest.projects,
    blockers: [...manifest.blockers, ...answer.blockers, ...inferenceBlockers],
    provenance: {
      modelInput: "model-input.json",
      ...(fs.existsSync(documentQualityPath) ? { documentQuality: DOCUMENT_QUALITY_ARTIFACT } : {}),
      ...(inference ? { inference: "inference.json" } : {}),
      ...(hasComplianceInput
        ? { complianceSearchEvidence: "compliance-search-evidence.json" }
        : {}),
      judgment: "assessment-judgment.json",
      preparationManifest: "preparation-manifest.json",
    },
    inputAccounting: {
      ...modelInput.inputAccounting,
      ...(inference
        ? {
            inference: {
              requestCount: inferenceRequests.length,
              inferredCandidateCount: inferredCandidates.length,
              noImpactCount: inference.results.filter((result) => result.decision === "no-impact")
                .length,
              blockedCount: inference.results.filter((result) => result.decision === "blocked")
                .length,
            },
          }
        : {}),
      ...(hasComplianceInput
        ? {
            compliance: /** @type {ComplianceSearchEvidence} */ (complianceEvidence)
              .inputAccounting,
          }
        : {}),
    },
    timings: manifest.timings,
  };
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2), {
      required: ["work", "judgment", "output"],
    });
    const work = args.work;
    const judgment = args.judgment;
    const output = args.output;
    if (typeof work !== "string" || typeof judgment !== "string" || typeof output !== "string") {
      throw new Error("--work, --judgment, and --output must be paths.");
    }
    const assessment = assembleAssessment({
      work: path.resolve(work),
      judgment: path.resolve(judgment),
    });
    writeJson(path.resolve(output), assessment);
    console.log(path.resolve(output));
  });
}
