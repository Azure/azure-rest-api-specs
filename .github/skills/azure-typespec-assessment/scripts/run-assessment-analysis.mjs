import fs from "node:fs";
import path from "node:path";
import { ensureSkillDependencies } from "./skill-dependencies.mjs";

await ensureSkillDependencies();

const [
  { parseArgs, isMain, isRecord, readJsonObject, runMain, writeJson },
  { prepareAssessment },
  { analyzeSemanticIntents },
  { analyzeRestBreaking },
  { analyzeDownstreamBreaking },
  { validateAssessment },
  { renderAssessmentHtml },
  { buildComplianceSearchRequests },
  { buildDocumentQualityInput },
  { stableId },
  { resolveAssessmentInput },
  { buildAgentWorkspace },
  { partitionSemanticIntents },
  { transitionWorkflowState },
] = await Promise.all([
  import("./cli.mjs"),
  import("./prepare-assessment.mjs"),
  import("./analyze-semantic-intents.mjs"),
  import("./analyze-rest-breaking.mjs"),
  import("./analyze-downstream-breaking.mjs"),
  import("./validate-assessment.mjs"),
  import("./render-assessment-html.mjs"),
  import("./compliance-search-request.mjs"),
  import("./document-quality-input.mjs"),
  import("./stable-id.mjs"),
  import("./assessment-input.mjs"),
  import("./build-agent-workspace.mjs"),
  import("./semantic-assessment-scope.mjs"),
  import("./workflow-state.mjs"),
]);

/** @typedef {import("./runtime-types.js").AssessmentFact} AssessmentFact */
/** @typedef {import("./runtime-types.js").AssessmentModelInput} AssessmentModelInput */
/** @typedef {import("./runtime-types.js").AssessmentOutput} AssessmentOutput */
/** @typedef {import("./runtime-types.js").BreakingAnalysis} BreakingAnalysis */
/** @typedef {import("./runtime-types.js").BreakingCandidate} BreakingCandidate */
/** @typedef {import("./runtime-types.js").ComplianceSearchRequest} ComplianceSearchRequest */
/** @typedef {import("./runtime-types.js").DownstreamAnalysis} DownstreamAnalysis */
/** @typedef {import("./runtime-types.js").DownstreamCandidate} DownstreamCandidate */
/** @typedef {import("./runtime-types.js").InferenceRequest} InferenceRequest */
/** @typedef {import("./runtime-types.js").InternalSemanticOperation} InternalSemanticOperation */
/** @typedef {import("./runtime-types.js").InternalSemanticUnit} InternalSemanticUnit */
/** @typedef {import("./runtime-types.js").PreparationManifest} PreparationManifest */
/** @typedef {import("./runtime-types.js").SemanticAnalysis} SemanticAnalysis */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {import("./runtime-types.js").SourceDeclaration} SourceDeclaration */
/** @typedef {import("./runtime-types.js").SourceIndex} SourceIndex */
/**
 * @typedef {{
 *   hunkId: string,
 *   status: string,
 *   reason: string,
 *   restCandidateIds: string[],
 *   downstreamCandidateIds: string[]
 * }} HunkClassification
 * @typedef {{
 *   restCandidateIds: string[],
 *   downstreamCandidateIds: string[],
 *   complianceSearchRequestIds: string[],
 *   relatedOperationIds: string[],
 *   coveredHunkIds: string[],
 *   uncoveredHunkIds: string[],
 *   classifications: HunkClassification[],
 *   gaps: {hunkId: string, reason: string}[]
 * }} DeterministicCoverage
 * @typedef {BreakingCandidate | DownstreamCandidate} AssessmentCandidate
 * @typedef {{
 *   schemaVersion: number,
 *   context: Record<string, unknown>,
 *   artifactReferences: AssessmentModelInput["artifactReferences"],
 *   evidenceSets: Record<string, import("./runtime-types.js").EvidenceSet & Record<string, unknown>>,
 *   facts: Record<string, unknown>,
 *   semanticReviewUnits: AssessmentModelInput["semanticReviewUnits"],
 *   informationalSemanticIntentIds: string[],
 *   restCandidates: AssessmentModelInput["restCandidates"],
 *   downstreamCandidates: AssessmentModelInput["downstreamCandidates"],
 *   downstreamRootCauses: import("./runtime-types.js").DownstreamRootCause[],
 *   complianceSearchRequests: AssessmentModelInput["complianceSearchRequests"],
 *   inferenceRequests: AssessmentModelInput["inferenceRequests"],
 *   blockers: unknown[],
 *   inputAccounting: Record<string, unknown>
 * }} AnalysisModelInput
 * @typedef {{
 *   budgetTier: string | undefined,
 *   budgetBytes: number | undefined,
 *   bytes: number,
 *   estimatedTokens: number,
 *   retained: {
 *     evidenceSets: number,
 *     facts: number,
 *     semanticReviewUnits: number,
 *     restCandidates: number,
 *     downstreamCandidates: number,
 *     downstreamRootCauses: number,
 *     complianceSearchRequests: number,
 *     inferenceRequests: number
 *   },
 *   omittedRedundant: Record<string, boolean>
 * }} InputAccounting
 * @typedef {{
 *   output: string,
 *   repo?: string,
 *   pr?: string | number,
 *   base?: string,
 *   head?: string,
 *   sparse_root?: string[],
 *   sparseRoots?: string[],
 *   specification?: string,
 *   invocation?: Record<string, unknown>,
 *   model_input_budget_bytes?: string | number,
 *   [key: string]: unknown
 * }} AssessmentAnalysisOptions
 * @typedef {Record<string, string | boolean | string[] | undefined> & {_?: string[]}} CliArguments
 */

/** @type {[string, number][]} */
const BUDGET_TIERS = [
  ["small", 128 * 1024],
  ["medium", 256 * 1024],
  ["large", 512 * 1024],
  ["maximum", 1024 * 1024],
];
const ARTIFACT_REFERENCES = {
  sourceIndex: "source/source-index.json",
  semanticReviewUnits: "dimensions/semantic-intents-input.json",
  restCandidates: "dimensions/rest-breaking-input.json",
  downstreamCandidates: "dimensions/downstream-breaking-input.json",
  complianceSearchRequests: "dimensions/compliance-search-requests.json",
};
const QUALIFIED_NAME_LIMIT = 24;
const CHANGED_CONSTRUCT_LIMIT = 40;
const QUERY_TERM_LIMIT = 40;

/**
 * @param {unknown} value
 * @returns {value is string}
 */
function isNonEmptyString(value) {
  return typeof value === "string" && value.length > 0;
}

/**
 * @param {unknown} value
 * @param {number} [depth]
 * @returns {unknown}
 */
function typeSummary(value, depth = 0) {
  if (value === undefined || value === null) return value;
  if (typeof value !== "object") return value;
  if (depth >= 3) {
    if (!isRecord(value)) return "nested";
    return value.id ?? value.crossLanguageDefinitionId ?? value.name ?? value.kind ?? "nested";
  }
  if (Array.isArray(value)) return value.map((item) => typeSummary(item, depth + 1));
  if (!isRecord(value)) return "nested";
  /** @type {Record<string, unknown>} */
  const result = {};
  for (const key of [
    "kind",
    "id",
    "identity",
    "crossLanguageDefinitionId",
    "name",
    "type",
    "format",
    "nullable",
    "optional",
    "required",
    "serializedName",
    "value",
    "isFixed",
    "isUnionAsEnum",
  ]) {
    if (value[key] !== undefined) {
      result[key] =
        typeof value[key] === "object" ? typeSummary(value[key], depth + 1) : value[key];
    }
  }
  if (value.items) result.items = typeSummary(value.items, depth + 1);
  if (value.valueType) result.valueType = typeSummary(value.valueType, depth + 1);
  if (value.keyType) result.keyType = typeSummary(value.keyType, depth + 1);
  if (Array.isArray(value.variantTypes))
    result.variantTypes = value.variantTypes.map((item) => typeSummary(item, depth + 1));
  if (Array.isArray(value.properties)) {
    result.properties = value.properties.map((property) => ({
      name: isRecord(property) ? property.name : undefined,
      serializedName: isRecord(property) ? property.serializedName : undefined,
      required: isRecord(property) ? property.required : undefined,
      optional: isRecord(property) ? property.optional : undefined,
      type: typeSummary(
        isRecord(property) ? (property.schema ?? property.type) : undefined,
        depth + 1,
      ),
    }));
  }
  return result;
}

/** @param {unknown} value */
function metadataSummary(value) {
  if (!value || typeof value !== "object") return value;
  if (!isRecord(value)) return value;
  /** @type {Record<string, unknown>} */
  const result = {};
  for (const key of [
    "isLongRunning",
    "finalStateVia",
    "nextLinkName",
    "itemName",
    "operationName",
    "nextLinkVerb",
  ]) {
    if (value[key] !== undefined) result[key] = value[key];
  }
  for (const key of ["logicalResult", "envelopeResult", "finalEnvelopeResult", "responseType"]) {
    if (value[key] !== undefined) result[key] = typeSummary(value[key]);
  }
  for (const key of [
    "pageItemsSegments",
    "nextLinkSegments",
    "pageSizeParameterSegments",
    "continuationTokenParameterSegments",
    "continuationTokenResponseSegments",
    "nextLinkReInjectedParametersSegments",
  ]) {
    if (Array.isArray(value[key])) {
      result[key] = value[key].map((item) =>
        isRecord(item)
          ? (item.crossLanguageDefinitionId ?? item.name ?? item.serializedName ?? item.kind)
          : typeSummary(item, 1),
      );
    }
  }
  for (const key of ["pollingStep", "statusMonitorStep", "finalStep"]) {
    if (isRecord(value[key])) {
      const item = value[key];
      result[key] = {
        kind: item.kind,
        target: isRecord(item.target) ? item.target.kind : undefined,
      };
    }
  }
  return result;
}

/** @param {AssessmentFact} fact */
function compactOperationFact(fact) {
  return {
    id: fact.id,
    projectId: fact.projectId,
    revision: fact.revision,
    comparisonRole: fact.comparisonRole,
    sourceRevision: fact.sourceRevision,
    sourceCommit: fact.sourceCommit,
    apiVersion: fact.apiVersion,
    operationId: fact.operationId,
    method: fact.method,
    path: fact.path,
    routeSource: fact.routeSource,
    parameters: (fact.parameters ?? []).map((parameter) => ({
      name: parameter.name,
      in: parameter.in,
      required: parameter.required,
      collectionFormat: parameter.collectionFormat,
      schema: typeSummary(parameter.schema),
    })),
    request: fact.request
      ? {
          kind: fact.request.kind,
          required: fact.request.required,
          schema: typeSummary(fact.request.schema),
          members: fact.request.members?.map((member) => ({
            name: member.name,
            required: member.required,
            schema: typeSummary(member.schema),
          })),
        }
      : undefined,
    responses: (fact.responses ?? []).map((response) => ({
      status: response.status,
      statusKind: response.statusKind,
      schema: typeSummary(response.schema),
      headers: response.headers?.map((header) => ({
        name: header.name,
        schema: typeSummary(header.schema),
      })),
    })),
    paging: metadataSummary(fact.paging),
    lro: metadataSummary(fact.lro),
  };
}

/** @param {AssessmentFact} fact */
function compactSdkFact(fact) {
  return {
    id: fact.id,
    projectId: fact.projectId,
    revision: fact.revision,
    comparisonRole: fact.comparisonRole,
    sourceRevision: fact.sourceRevision,
    sourceCommit: fact.sourceCommit,
    apiVersion: fact.apiVersion,
    apiVersions: fact.apiVersions,
    factKind: fact.factKind,
    kind: fact.kind,
    identity: fact.identity,
    crossLanguageDefinitionId: fact.crossLanguageDefinitionId,
    client: fact.client,
    operation: fact.operation
      ? {
          operationId: fact.operation.operationId,
          method: fact.operation.method,
          path: fact.operation.path,
        }
      : undefined,
    owner: fact.owner,
    parent: fact.parent,
    name: fact.name,
    access: fact.access,
    usage: fact.usage,
    reachable: fact.reachable,
    parameters: fact.parameters?.map((parameter) => ({
      position: parameter.position,
      name: parameter.name,
      optional: parameter.optional,
      onClient: parameter.onClient,
      type: typeSummary(parameter.type),
    })),
    responseType: typeSummary(fact.responseType),
    properties: fact.properties?.map((property) => ({
      name: property.name,
      serializedName: property.serializedName,
      optional: property.optional,
      access: property.access,
      flatten: property.flatten,
      type: typeSummary(property.type),
    })),
    values: fact.values?.map((item) => ({
      name: item.name,
      value: item.value,
    })),
    isFixed: fact.isFixed,
    isUnionAsEnum: fact.isUnionAsEnum,
    paging: metadataSummary(fact.paging),
    lro: metadataSummary(fact.lro),
    decorators: fact.decorators,
  };
}

/**
 * @param {string} id
 * @param {AssessmentFact} fact
 */
function compactFact(id, fact) {
  if (id.startsWith("sdk-fact-")) return compactSdkFact(fact);
  if (id.startsWith("operation-") || id.startsWith("rest-fact-")) {
    return compactOperationFact(fact);
  }
  return { id, summary: typeSummary(fact) };
}

/**
 * @param {{
 *   semanticUnits: InternalSemanticUnit[],
 *   sourceChanges: Record<string, SourceChange>,
 *   semantic: SemanticAnalysis,
 *   rest: BreakingAnalysis,
 *   downstream: DownstreamAnalysis,
 *   coverages: Map<string, DeterministicCoverage>
 * }} options
 */
function inferenceRelevantFactIds({
  semanticUnits,
  sourceChanges,
  semantic,
  rest,
  downstream,
  coverages,
}) {
  /** @type {Set<string>} */
  const ids = new Set();
  const available = { ...semantic.facts, ...rest.facts, ...downstream.facts };

  for (const unit of semanticUnits) {
    if ((coverages.get(unit.id)?.uncoveredHunkIds.length ?? 0) === 0) continue;
    for (const id of [
      ...(unit.beforeFactIds ?? []),
      ...(unit.afterFactIds ?? []),
      ...(unit.operations ?? []).flatMap((operation) => [
        operation.beforeFactId,
        operation.afterFactId,
      ]),
    ]) {
      if (id && available[id] !== undefined) ids.add(id);
    }

    const projectIds = new Set(unit.projectIds ?? (unit.projectId ? [unit.projectId] : []));
    const sourceText = (unit.hunkIds ?? [])
      .map((hunkId) => inferenceHunkText(sourceForHunk(unit, sourceChanges, hunkId), hunkId))
      .join("\n");
    const operationIds = new Set((unit.operations ?? []).map((operation) => operation.operationId));
    for (const [id, fact] of Object.entries(available)) {
      if (fact.projectId && !projectIds.has(fact.projectId)) continue;
      const terms = [fact.operationId, fact.identity, fact.crossLanguageDefinitionId, fact.name]
        .filter(isNonEmptyString)
        .filter((term) => term.length >= 3)
        .flatMap((term) => [term, term.split(".").at(-1)].filter(isNonEmptyString));
      if (
        (fact.operationId !== undefined && operationIds.has(fact.operationId)) ||
        terms.some((term) => sourceText.includes(term))
      ) {
        ids.add(id);
      }
    }
  }
  return ids;
}

/**
 * @param {SemanticAnalysis} semantic
 * @param {BreakingAnalysis} rest
 * @param {DownstreamAnalysis} downstream
 * @param {Set<string>} retainedIds
 */
function referencedFacts(semantic, rest, downstream, retainedIds) {
  const ids = new Set(retainedIds);
  const available = { ...semantic.facts, ...rest.facts, ...downstream.facts };
  return Object.fromEntries(
    [...ids]
      .filter((id) => available[id] !== undefined)
      .sort()
      .map((id) => [id, compactFact(id, available[id])]),
  );
}

/** @param {{candidates?: AssessmentCandidate[]}} analysis */
function candidateReferencedFactIds(analysis) {
  return new Set(
    (analysis.candidates ?? []).flatMap((candidate) => candidate.evidenceFactIds ?? []),
  );
}

/** @param {DownstreamAnalysis} downstream */
function downstreamReferencedFactIds(downstream) {
  const ids = candidateReferencedFactIds(downstream);
  for (const rootCause of downstream.rootCauses ?? []) {
    for (const id of [
      ...(rootCause.methodFactIds ?? []),
      ...(rootCause.typeFactIds ?? []),
      ...(rootCause.referenceEvidence ?? []).flatMap((edge) => [edge.fromFactId, edge.toFactId]),
    ]) {
      if (id) ids.add(id);
    }
  }
  return ids;
}

/**
 * @param {InternalSemanticUnit} unit
 * @param {Record<string, SourceChange>} sourceChanges
 */
function semanticSourceExcerpts(unit, sourceChanges) {
  const allowed = new Set(unit.hunkIds ?? []);
  return unit.sourceChangeIds
    .flatMap((sourceId) => {
      const source = sourceChanges[sourceId];
      return (source?.hunks ?? [])
        .filter((hunk) => allowed.has(hunk.id))
        .map((hunk) => ({
          sourceChangeId: sourceId,
          hunkId: hunk.id,
          path: source.path,
          text: (hunk.lines ?? [])
            .filter((line) => /^[+-](?![+-])/.test(line))
            .slice(0, 12)
            .join("\n"),
        }));
    })
    .filter((excerpt) => excerpt.text)
    .sort((left, right) => {
      /** @param {{path: string, text: string}} excerpt */
      const score = (excerpt) => {
        const compatibilityFile = /(?:^|\/)(?:client|back-compatible)\.tsp$/i.test(excerpt.path);
        const substantive = /\b(model|interface|op|enum|union|scalar|alias)\b/.test(excerpt.text);
        return (compatibilityFile ? 2 : 0) + (substantive ? 0 : 1);
      };
      return (
        score(left) - score(right) ||
        left.path.localeCompare(right.path) ||
        left.hunkId.localeCompare(right.hunkId)
      );
    })
    .slice(0, 3);
}

/**
 * @param {(string | undefined)[]} values
 * @param {number} limit
 */
function bounded(values, limit) {
  const unique = [...new Set(values.filter(isNonEmptyString))].sort();
  return {
    values: unique.slice(0, limit),
    count: unique.length,
    omitted: Math.max(0, unique.length - limit),
  };
}

/**
 * @param {Record<string, import("./runtime-types.js").EvidenceSet & Record<string, unknown>>} registry
 * @param {{
 *   sourceChangeIds?: string[],
 *   hunkIds?: string[],
 *   declarationIds?: string[],
 *   evidenceFactIds?: string[]
 * }} evidence
 * @param {string} artifact
 * @param {string} entityId
 */
function evidenceSet(registry, evidence, artifact, entityId) {
  const normalized = {
    sourceChangeIds: [...new Set(evidence.sourceChangeIds ?? [])].sort(),
    hunkIds: [...new Set(evidence.hunkIds ?? [])].sort(),
    declarationIds: [...new Set(evidence.declarationIds ?? [])].sort(),
    evidenceFactIds: [...new Set(evidence.evidenceFactIds ?? [])].sort(),
  };
  const id = stableId("evidence-set", normalized);
  registry[id] ??= {
    sourceChangeIds: normalized.sourceChangeIds,
    hunkIds: normalized.hunkIds,
    declarationCount: normalized.declarationIds.length,
    evidenceFactIds: normalized.evidenceFactIds,
    evidenceRef: { artifact, id: entityId },
  };
  return id;
}

/**
 * @param {InternalSemanticUnit} unit
 * @param {Record<string, SourceChange>} sourceChanges
 * @param {DeterministicCoverage} deterministicCoverage
 * @param {Record<string, import("./runtime-types.js").EvidenceSet & Record<string, unknown>>} evidenceSets
 */
function compactSemanticReviewUnit(unit, sourceChanges, deterministicCoverage, evidenceSets) {
  const declarations = unit.sourceChangeIds.flatMap((sourceId) => {
    const source = sourceChanges[sourceId];
    const allowed = new Set(unit.hunkIds ?? []);
    return (source?.declarations ?? []).filter((declaration) =>
      declaration.hunkIds?.some((hunkId) => allowed.has(hunkId)),
    );
  });
  const operations = [
    ...(unit.operations ??
      (unit.operationIds ?? []).map((id) => ({
        operationId: id,
      }))),
  ].sort((left, right) => left.operationId.localeCompare(right.operationId));
  const qualifiedNames = bounded(
    declarations.map((item) => item.qualifiedName),
    QUALIFIED_NAME_LIMIT,
  );
  const changedConstructs = bounded(
    declarations.flatMap((item) => [
      ...(item.decorators ?? []).map((decorator) =>
        typeof decorator === "string" ? decorator : decorator?.name,
      ),
      item.baseType,
      ...(item.compilerEvidence?.referencedNames ?? []),
    ]),
    CHANGED_CONSTRUCT_LIMIT,
  );
  return {
    reviewUnitId: unit.id,
    intentType: unit.intentType ?? "normal",
    action: unit.action ?? unit.changeKind ?? "modify",
    declarationKinds: [...new Set(declarations.map((item) => item.kind).filter(Boolean))].sort(),
    qualifiedNames: qualifiedNames.values,
    qualifiedNameCount: qualifiedNames.count,
    changedConstructs: changedConstructs.values,
    changedConstructCount: changedConstructs.count,
    representativeSourceExcerpts: semanticSourceExcerpts(unit, sourceChanges),
    affectedOperationCount: operations.length,
    representativeOperationIds: operations.slice(0, 3).map((item) => item.operationId),
    restChangedOperationCount: operations.filter((item) => item.restChanged).length,
    groupingSummaries: (unit.groupingEvidence?.edges ?? [])
      .map((item) => item.summary)
      .filter(Boolean)
      .slice(0, 3),
    evidenceSetId: evidenceSet(
      evidenceSets,
      unit,
      ARTIFACT_REFERENCES.semanticReviewUnits,
      unit.id,
    ),
    deterministicCoverage,
    inferenceRequired: deterministicCoverage.uncoveredHunkIds.length > 0,
  };
}

/**
 * @template T
 * @param {T[]} left
 * @param {Set<T> | T[]} right
 */
function intersection(left, right) {
  const rightSet = right instanceof Set ? right : new Set(right);
  return left.filter((item) => rightSet.has(item));
}

/**
 * @template T
 * @param {Map<string, T>} values
 * @param {string} key
 * @param {string} label
 * @returns {T}
 */
function requireMapValue(values, key, label) {
  const value = values.get(key);
  if (value === undefined) {
    throw new Error(`${label} is missing for ${key}.`);
  }
  return value;
}

/**
 * @param {InternalSemanticUnit} unit
 * @param {Record<string, SourceChange>} sourceChanges
 * @param {string} hunkId
 */
function sourceForHunk(unit, sourceChanges, hunkId) {
  return unit.sourceChangeIds
    .map((sourceChangeId) => sourceChanges[sourceChangeId])
    .find((source) => source?.hunks?.some((hunk) => hunk.id === hunkId));
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 */
function changedHunkText(source, hunkId) {
  const hunk = source?.hunks?.find((item) => item.id === hunkId);
  return (hunk?.lines ?? [])
    .filter((line) => /^[+-](?![+-])/.test(line))
    .slice(0, 20)
    .join("\n");
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 */
function inferenceHunkText(source, hunkId) {
  const hunk = source?.hunks?.find((item) => item.id === hunkId);
  return (hunk?.lines ?? []).slice(0, 40).join("\n");
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 */
function documentationOnly(source, hunkId) {
  const changed = changedHunkText(source, hunkId)
    .split("\n")
    .map((line) => line.slice(1).trim())
    .filter(Boolean);
  return (
    changed.length > 0 &&
    changed.every(
      (line) =>
        line.startsWith("//") || line.startsWith("/*") || line.startsWith("*") || line === "*/",
    )
  );
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 */
function contractNeutralSupportingChange(source, hunkId) {
  const changed = changedHunkText(source, hunkId)
    .split("\n")
    .map((line) => line.slice(1).trim())
    .filter(Boolean);
  return (
    changed.length > 0 &&
    changed.every(
      (line) =>
        /^import\s/.test(line) ||
        /^using\s/.test(line) ||
        /^#suppress\s/.test(line) ||
        line.startsWith("//") ||
        line.startsWith("/*") ||
        line.startsWith("*") ||
        line === "*/",
    )
  );
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 */
function docDecoratorOnly(source, hunkId) {
  const hunk = source?.hunks?.find((item) => item.id === hunkId);
  const changed = changedHunkText(source, hunkId);
  const decorators = [...changed.matchAll(/@@?[A-Za-z0-9_.]+/g)].map((match) => match[0]);
  return (
    (hunk?.lines ?? []).some((line) => /@@?doc\s*\(/.test(line)) &&
    decorators.every((decorator) => decorator === "@doc" || decorator === "@@doc") &&
    !/\b(model|interface|op|enum|union|scalar|alias)\b/.test(changed)
  );
}

/** @param {string} line */
function structuralParenthesisDelta(line) {
  let quote;
  let escaped = false;
  let delta = 0;
  for (let index = 0; index < line.length; index += 1) {
    const character = line[index];
    if (escaped) {
      escaped = false;
      continue;
    }
    if (quote) {
      if (character === "\\") escaped = true;
      else if (character === quote) quote = undefined;
      continue;
    }
    if (character === '"' || character === "'" || character === "`") {
      quote = character;
    } else if (character === "/" && line[index + 1] === "/") {
      break;
    } else if (character === "(") {
      delta += 1;
    } else if (character === ")") {
      delta -= 1;
    }
  }
  return delta;
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 * @param {Set<string>} allowedDecorators
 * @param {(line: string) => boolean} [allowedStandalone]
 */
function decoratorOnlyChange(source, hunkId, allowedDecorators, allowedStandalone = () => false) {
  const hunk = source?.hunks?.find((item) => item.id === hunkId);
  let activeDecorator;
  let depth = 0;
  let changedLineCount = 0;
  let sawAllowedDecorator = false;

  for (const rawLine of hunk?.lines ?? []) {
    const changed = rawLine.startsWith("+") || rawLine.startsWith("-");
    const line = changed || rawLine.startsWith(" ") ? rawLine.slice(1) : rawLine;
    const decorators = [...line.matchAll(/@@?[A-Za-z0-9_.]+/g)].map((match) => match[0]);
    const standaloneAllowed = allowedStandalone(line.trim());
    const startsAllowedDecorator =
      decorators.length > 0 && decorators.every((decorator) => allowedDecorators.has(decorator));

    if (changed) {
      changedLineCount += 1;
      if (
        (!standaloneAllowed && decorators.some((decorator) => !allowedDecorators.has(decorator))) ||
        (!activeDecorator && !startsAllowedDecorator && !standaloneAllowed)
      ) {
        return false;
      }
    }

    if (startsAllowedDecorator) {
      activeDecorator = decorators[0];
      sawAllowedDecorator = true;
      depth = 0;
    }
    if (activeDecorator) {
      depth += structuralParenthesisDelta(line);
      if (depth <= 0) {
        activeDecorator = undefined;
        depth = 0;
      }
    }
  }

  return changedLineCount > 0 && sawAllowedDecorator;
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 * @param {BreakingAnalysis} rest
 * @param {DownstreamAnalysis} downstream
 */
function representedArtifactChange(source, hunkId, rest, downstream) {
  const changedText = changedHunkText(source, hunkId);
  if (
    rest.status === "ready" &&
    decoratorOnlyChange(
      source,
      hunkId,
      new Set([
        "@@operationId",
        "@@doc",
        "@@clientName",
        "@@Azure.ClientGenerator.Core.clientName",
        "@extension",
        "@Azure.Core.useFinalStateVia",
      ]),
      (line) => line.startsWith("#suppress "),
    ) &&
    !/\b(csharp|java|javascript|python|go)\b/i.test(changedText)
  ) {
    return "rest-artifact-represented-change-compared";
  }
  if (
    downstream.status === "ready" &&
    decoratorOnlyChange(
      source,
      hunkId,
      new Set(["@@clientName", "@@Azure.ClientGenerator.Core.clientName"]),
    ) &&
    !/\b(csharp|java|javascript|python|go)\b/i.test(changedText)
  ) {
    return "language-neutral-sdk-customization-compared";
  }
  return undefined;
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 */
function decoratorsAffectingChangedLines(source, hunkId) {
  const hunk = source?.hunks?.find((item) => item.id === hunkId);
  /** @type {Set<string>} */
  const decorators = new Set();
  /** @type {string | undefined} */
  let activeDecorator;
  let depth = 0;

  for (const rawLine of hunk?.lines ?? []) {
    const changed = rawLine.startsWith("+") || rawLine.startsWith("-");
    const line = changed || rawLine.startsWith(" ") ? rawLine.slice(1) : rawLine;
    const decorator = line.match(/^\s*(@@?[A-Za-z0-9_.]+)/)?.[1];
    if (decorator) {
      activeDecorator = decorator;
      depth = 0;
    }
    if (changed && activeDecorator) decorators.add(activeDecorator);
    if (activeDecorator) {
      depth += structuralParenthesisDelta(line);
      if (depth <= 0) {
        activeDecorator = undefined;
        depth = 0;
      }
    }
  }

  return decorators;
}

/**
 * @param {SourceChange | undefined} source
 * @param {string} hunkId
 */
function inferenceGapReason(source, hunkId) {
  const hunk = source?.hunks?.find((item) => item.id === hunkId);
  const fullText = (hunk?.lines ?? []).join("\n");
  const changedDecorators = decoratorsAffectingChangedLines(source, hunkId);
  const hasLanguageScope = /\b(csharp|java|javascript|python|go)\b/i.test(fullText);
  if (changedDecorators.has("@@clientLocation") && hasLanguageScope) {
    return "language-specific-client-location-not-represented";
  }
  if (
    [...changedDecorators].some((decorator) =>
      /^(?:@@?(?:clientName|alternateType)|@Azure\.ClientGenerator\.Core\.Legacy\.flattenProperty)$/.test(
        decorator,
      ),
    ) &&
    hasLanguageScope
  ) {
    return "language-specific-sdk-customization-not-represented";
  }
  const representedDecorators = new Set([
    "@action",
    "@added",
    "@armProviderNamespace",
    "@armResourceAction",
    "@armResourceCollectionAction",
    "@armResourceCreateOrUpdate",
    "@armResourceDelete",
    "@armResourceInternal",
    "@armResourceList",
    "@armResourceOperations",
    "@armResourceRead",
    "@armResourceUpdate",
    "@armVirtualResource",
    "@autoRoute",
    "@body",
    "@bodyRoot",
    "@delete",
    "@discriminator",
    "@doc",
    "@encode",
    "@error",
    "@errorsDoc",
    "@example",
    "@extension",
    "@format",
    "@get",
    "@header",
    "@identifiers",
    "@key",
    "@list",
    "@maxItems",
    "@maxLength",
    "@maxValue",
    "@maxValueExclusive",
    "@minItems",
    "@minLength",
    "@minValue",
    "@minValueExclusive",
    "@pageItems",
    "@parentResource",
    "@patch",
    "@path",
    "@pattern",
    "@pollingOperation",
    "@post",
    "@put",
    "@query",
    "@removed",
    "@returnsDoc",
    "@route",
    "@secret",
    "@segment",
    "@server",
    "@service",
    "@sharedRoute",
    "@statusCode",
    "@summary",
    "@tag",
    "@typeChangedFrom",
    "@uniqueItems",
    "@useDependency",
    "@visibility",
    "@Azure.ClientGenerator.Core.Legacy.flattenProperty",
    "@Azure.Core.useFinalStateVia",
    "@Azure.ResourceManager.Legacy.customAzureResource",
    "@Azure.ResourceManager.Legacy.feature",
    "@Http.Private.includeInapplicableMetadataInPayload",
    "@Xml.name",
    "@Xml.unwrapped",
    "@armCommonTypesVersion",
    "@nextLink",
    "@@doc",
    "@@extension",
    "@@identifiers",
    "@@operationId",
    "@@override",
    "@@clientName",
    "@@Azure.ClientGenerator.Core.clientName",
    "@@visibility",
  ]);
  if ([...changedDecorators].some((decorator) => !representedDecorators.has(decorator))) {
    return "unsupported-customization-not-represented";
  }
  return undefined;
}

/**
 * @param {InternalSemanticUnit} unit
 * @param {Record<string, SourceChange>} sourceChanges
 * @returns {Map<string, SourceDeclaration[]>}
 */
function declarationHunkIds(unit, sourceChanges) {
  const ids = new Set(unit.hunkIds ?? []);
  /** @type {Map<string, SourceDeclaration[]>} */
  const result = new Map();
  for (const sourceChangeId of unit.sourceChangeIds) {
    for (const declaration of sourceChanges[sourceChangeId]?.declarations ?? []) {
      for (const hunkId of declaration.hunkIds ?? []) {
        if (!ids.has(hunkId)) continue;
        const values = result.get(hunkId) ?? [];
        values.push(declaration);
        result.set(hunkId, values);
      }
    }
  }
  return result;
}

/**
 * @param {InternalSemanticUnit} unit
 * @returns {Map<string, InternalSemanticOperation[]>}
 */
function operationHunkIds(unit) {
  /** @type {Map<string, InternalSemanticOperation[]>} */
  const result = new Map();
  for (const operation of unit.operations ?? []) {
    for (const hunkId of operation.hunkIds ?? []) {
      const values = result.get(hunkId) ?? [];
      values.push(operation);
      result.set(hunkId, values);
    }
  }
  return result;
}

/** @param {string | undefined} value */
function normalizedSymbolNames(value) {
  if (!value) return [];
  const full = value.toLowerCase();
  const leaf = full.split(".").at(-1);
  return full === leaf ? [full] : [full, leaf];
}

/**
 * @param {InternalSemanticUnit} unit
 * @param {AssessmentCandidate} candidate
 * @param {Record<string, AssessmentFact>} facts
 * @param {Map<string, SourceDeclaration[]>} declarationsByHunk
 * @param {Map<string, InternalSemanticOperation[]>} operationsByHunk
 */
function candidateHunks(unit, candidate, facts, declarationsByHunk, operationsByHunk) {
  /** @type {Set<string>} */
  const matched = new Set();
  const candidateOperations = new Set(candidate.operationIds ?? []);
  for (const [hunkId, operations] of operationsByHunk) {
    if (operations.some((operation) => candidateOperations.has(operation.operationId))) {
      matched.add(hunkId);
    }
  }

  const candidateOperationKeys = new Set(
    (candidate.evidenceFactIds ?? []).flatMap((id) => {
      const operation = facts[id]?.operation;
      return operation?.verb && operation.path
        ? [`${operation.verb.toLowerCase()} ${operation.path}`]
        : [];
    }),
  );
  if (candidateOperationKeys.size) {
    for (const [hunkId, operations] of operationsByHunk) {
      const operationKeys = operations.flatMap((operation) =>
        [operation.beforeFactId, operation.afterFactId].flatMap((id) => {
          const fact = id ? facts[id] : undefined;
          return fact?.method && fact.path ? [`${fact.method.toLowerCase()} ${fact.path}`] : [];
        }),
      );
      if (operationKeys.some((key) => candidateOperationKeys.has(key))) matched.add(hunkId);
    }
  }

  const candidateSymbols = new Set(normalizedSymbolNames(candidate.crossLanguageDefinitionId));
  if (candidateSymbols.size) {
    for (const [hunkId, declarations] of declarationsByHunk) {
      if (
        declarations.some((declaration) =>
          normalizedSymbolNames(declaration.qualifiedName).some((name) =>
            candidateSymbols.has(name),
          ),
        )
      ) {
        matched.add(hunkId);
      }
    }
  }
  return matched;
}

/**
 * @param {{
 *   unit: InternalSemanticUnit,
 *   sourceChanges: Record<string, SourceChange>,
 *   semantic: SemanticAnalysis,
 *   rest: BreakingAnalysis,
 *   downstream: DownstreamAnalysis,
 *   complianceRequest?: ComplianceSearchRequest
 * }} options
 * @returns {DeterministicCoverage}
 */
function deterministicCoverage({
  unit,
  sourceChanges,
  semantic,
  rest,
  downstream,
  complianceRequest,
}) {
  const declarationsByHunk = declarationHunkIds(unit, sourceChanges);
  const operationsByHunk = operationHunkIds(unit);
  /** @type {Map<string, string[]>} */
  const restByHunk = new Map((unit.hunkIds ?? []).map((id) => [id, /** @type {string[]} */ ([])]));
  /** @type {Map<string, string[]>} */
  const downstreamByHunk = new Map(
    (unit.hunkIds ?? []).map((id) => [id, /** @type {string[]} */ ([])]),
  );
  const unitSources = new Set(unit.sourceChangeIds ?? []);
  /** @param {AssessmentCandidate} candidate */
  const relevant = (candidate) =>
    intersection(candidate.sourceChangeIds ?? [], unitSources).length > 0;

  for (const candidate of rest.status === "ready" ? rest.candidates : []) {
    if (!relevant(candidate)) continue;
    for (const hunkId of candidateHunks(
      unit,
      candidate,
      { ...semantic.facts, ...rest.facts },
      declarationsByHunk,
      operationsByHunk,
    )) {
      restByHunk.get(hunkId)?.push(candidate.id);
    }
  }
  for (const candidate of downstream.status === "ready" ? downstream.candidates : []) {
    if (!relevant(candidate)) continue;
    for (const hunkId of candidateHunks(
      unit,
      candidate,
      { ...semantic.facts, ...downstream.facts },
      declarationsByHunk,
      operationsByHunk,
    )) {
      downstreamByHunk.get(hunkId)?.push(candidate.id);
    }
  }

  /** @type {HunkClassification[]} */
  const classifications = (unit.hunkIds ?? []).map((hunkId) => {
    const restCandidateIds = [...new Set(restByHunk.get(hunkId) ?? [])].sort();
    const downstreamCandidateIds = [...new Set(downstreamByHunk.get(hunkId) ?? [])].sort();
    const source = sourceForHunk(unit, sourceChanges, hunkId);
    if (rest.status === "blocked" || downstream.status === "blocked") {
      return {
        hunkId,
        status: "blocked",
        reason: "required-deterministic-analysis-blocked",
        restCandidateIds: [],
        downstreamCandidateIds: [],
      };
    }
    const gapReason = inferenceGapReason(source, hunkId);
    if (gapReason) {
      return {
        hunkId,
        status: "unknown",
        reason: gapReason,
        restCandidateIds: [],
        downstreamCandidateIds: [],
      };
    }
    if (restCandidateIds.length || downstreamCandidateIds.length) {
      return {
        hunkId,
        status: "candidate-generated",
        reason: "mapped-deterministic-candidate",
        restCandidateIds,
        downstreamCandidateIds,
      };
    }
    if (declarationsByHunk.has(hunkId) || operationsByHunk.has(hunkId)) {
      return {
        hunkId,
        status: "no-impact",
        reason: declarationsByHunk.has(hunkId)
          ? "declaration-mapped-and-contracts-compared"
          : "operation-mapped-and-contracts-compared",
        restCandidateIds: [],
        downstreamCandidateIds: [],
      };
    }
    if (documentationOnly(source, hunkId)) {
      return {
        hunkId,
        status: "semantic-only",
        reason: "documentation-only-change",
        restCandidateIds: [],
        downstreamCandidateIds: [],
      };
    }
    if (docDecoratorOnly(source, hunkId)) {
      return {
        hunkId,
        status: "semantic-only",
        reason: "documentation-decorator-only-change",
        restCandidateIds: [],
        downstreamCandidateIds: [],
      };
    }
    if (contractNeutralSupportingChange(source, hunkId)) {
      return {
        hunkId,
        status: "semantic-only",
        reason: "contract-neutral-supporting-change",
        restCandidateIds: [],
        downstreamCandidateIds: [],
      };
    }
    const representedReason = representedArtifactChange(source, hunkId, rest, downstream);
    if (representedReason) {
      return {
        hunkId,
        status: "no-impact",
        reason: representedReason,
        restCandidateIds: [],
        downstreamCandidateIds: [],
      };
    }
    return {
      hunkId,
      status: "unknown",
      reason: "source-change-not-mapped-to-deterministic-contract-evidence",
      restCandidateIds: [],
      downstreamCandidateIds: [],
    };
  });
  const uncoveredHunkIds = classifications
    .filter((item) => item.status === "unknown")
    .map((item) => item.hunkId);
  return {
    restCandidateIds: [...new Set(classifications.flatMap((item) => item.restCandidateIds))].sort(),
    downstreamCandidateIds: [
      ...new Set(classifications.flatMap((item) => item.downstreamCandidateIds)),
    ].sort(),
    complianceSearchRequestIds: complianceRequest ? [complianceRequest.requestId] : [],
    relatedOperationIds: [
      ...new Set((unit.operations ?? []).map((operation) => operation.operationId)),
    ].sort(),
    coveredHunkIds: classifications
      .filter((item) => item.status !== "unknown")
      .map((item) => item.hunkId),
    uncoveredHunkIds,
    classifications,
    gaps: classifications
      .filter((item) => item.status === "unknown")
      .map((item) => ({
        hunkId: item.hunkId,
        reason: item.reason,
      })),
  };
}

/**
 * @param {InternalSemanticUnit[]} semanticUnits
 * @param {Record<string, SourceChange>} sourceChanges
 * @param {Map<string, DeterministicCoverage>} coverages
 * @returns {InferenceRequest[]}
 */
function buildInferenceRequests(semanticUnits, sourceChanges, coverages) {
  return semanticUnits.flatMap((unit) => {
    const coverage = requireMapValue(coverages, unit.id, "Deterministic coverage");
    return coverage.uncoveredHunkIds.map((hunkId) => {
      const source = sourceForHunk(unit, sourceChanges, hunkId);
      if (!source) {
        throw new Error(`Semantic review unit ${unit.id} references unknown hunk ${hunkId}.`);
      }
      const request = {
        reviewUnitId: unit.id,
        sourceChangeId: source.id,
        hunkId,
        reason: coverage.gaps.find((item) => item.hunkId === hunkId)?.reason,
        sourceExcerpt: inferenceHunkText(source, hunkId),
        relatedOperationIds: (unit.operations ?? [])
          .filter((operation) => operation.hunkIds?.includes(hunkId))
          .map((operation) => operation.operationId)
          .sort(),
        allowedDimensions: /** @type {InferenceRequest["allowedDimensions"]} */ ([
          "rest",
          "downstream",
        ]),
      };
      return {
        requestId: stableId("inference-request", request),
        ...request,
        evidenceRef: {
          artifact: ARTIFACT_REFERENCES.sourceIndex,
          sourceChangeId: source.id,
          hunkId,
        },
      };
    });
  });
}

/**
 * @param {SourceIndex} sourceIndex
 * @param {SemanticAnalysis} semantic
 * @param {BreakingAnalysis} rest
 * @param {DownstreamAnalysis} downstream
 * @returns {Record<string, SourceChange>}
 */
function compactSources(sourceIndex, semantic, rest, downstream) {
  const ids = new Set();
  for (const item of [...semantic.reviewUnits, ...rest.candidates, ...downstream.candidates]) {
    for (const id of item.sourceChangeIds) ids.add(id);
  }
  return Object.fromEntries(
    sourceIndex.sourceChanges
      .filter((source) => ids.has(source.id))
      .sort((left, right) => left.id.localeCompare(right.id))
      .map((source) => [
        source.id,
        {
          id: source.id,
          path: source.path,
          status: source.status,
          origins: source.origins,
          hunks: source.hunks,
          declarations: source.declarations,
        },
      ]),
  );
}

/**
 * @param {AnalysisModelInput} input
 * @param {number | undefined} maximumBytes
 * @returns {AnalysisModelInput}
 */
function accountInput(input, maximumBytes) {
  /** @type {[string, number][]} */
  const tiers = maximumBytes
    ? [
        ...BUDGET_TIERS.filter(([, limit]) => limit < maximumBytes),
        /** @type {[string, number]} */ (["configured-maximum", maximumBytes]),
      ]
    : BUDGET_TIERS;
  let bytes = 0;
  /** @type {[string, number] | undefined} */
  let tier;
  /** @type {InputAccounting | undefined} */
  let accounting;
  for (let attempt = 0; attempt < 4; attempt += 1) {
    accounting = {
      budgetTier: tier?.[0],
      budgetBytes: tier?.[1],
      bytes,
      estimatedTokens: Math.ceil(bytes / 4),
      retained: {
        evidenceSets: Object.keys(input.evidenceSets).length,
        facts: Object.keys(input.facts).length,
        semanticReviewUnits: input.semanticReviewUnits.length,
        restCandidates: input.restCandidates.length,
        downstreamCandidates: input.downstreamCandidates.length,
        downstreamRootCauses: input.downstreamRootCauses.length,
        complianceSearchRequests: input.complianceSearchRequests.length,
        inferenceRequests: input.inferenceRequests.length,
      },
      omittedRedundant: {
        rawEmitterArtifacts: true,
        compilerLogs: true,
        unchangedInventories: true,
        unreferencedFacts: true,
        unreferencedDeterministicFacts: true,
        sourceChanges: true,
        repeatedDeclarationIds: true,
        repeatedReviewUnitEvidence: true,
      },
    };
    input.inputAccounting = accounting;
    bytes = Buffer.byteLength(JSON.stringify(input));
    tier = tiers.find(([, limit]) => bytes <= limit);
  }
  const maximumTier = tiers.at(-1);
  if (!tier || !maximumTier || !accounting) {
    throw new Error(
      `Required model input is ${bytes} bytes, above the ${maximumTier?.[1]} byte maximum.`,
    );
  }
  accounting.budgetTier = tier[0];
  accounting.budgetBytes = tier[1];
  accounting.bytes = Buffer.byteLength(JSON.stringify(input));
  accounting.estimatedTokens = Math.ceil(accounting.bytes / 4);
  return input;
}

/**
 * @param {{
 *   manifest: PreparationManifest,
 *   sourceIndex: SourceIndex,
 *   semantic: SemanticAnalysis,
 *   rest: BreakingAnalysis,
 *   downstream: DownstreamAnalysis,
 *   maximumBytes?: number
 * }} options
 * @returns {AnalysisModelInput}
 */
export function buildModelInput({
  manifest,
  sourceIndex,
  semantic,
  rest,
  downstream,
  maximumBytes,
}) {
  const semanticUnits = semantic.status === "ready" ? semantic.reviewUnits : [];
  const { assessed: assessedSemanticUnits, informational: informationalSemanticUnits } =
    partitionSemanticIntents(semanticUnits);
  const assessedSemantic = {
    ...semantic,
    reviewUnits: assessedSemanticUnits,
  };
  const sourceChanges = compactSources(sourceIndex, assessedSemantic, rest, downstream);
  const fullComplianceSearchRequests = buildComplianceSearchRequests({
    semanticReviewUnits: assessedSemanticUnits,
    sourceChanges,
  });
  const complianceRequestsByUnit = new Map(
    fullComplianceSearchRequests.map((request) => [request.reviewUnitId, request]),
  );
  const coverages = new Map(
    assessedSemanticUnits.map((unit) => [
      unit.id,
      deterministicCoverage({
        unit,
        sourceChanges,
        semantic,
        rest,
        downstream,
        complianceRequest: complianceRequestsByUnit.get(unit.id),
      }),
    ]),
  );
  const informationalCoverages = new Map(
    informationalSemanticUnits.map((unit) => [
      unit.id,
      deterministicCoverage({
        unit,
        sourceChanges,
        semantic,
        rest,
        downstream,
      }),
    ]),
  );
  const retainedRestCandidateIds = new Set(
    [...coverages.values()].flatMap((coverage) => coverage.restCandidateIds),
  );
  const informationalRestCandidateIds = new Set(
    [...informationalCoverages.values()].flatMap((coverage) => coverage.restCandidateIds),
  );
  const retainedDownstreamCandidateIds = new Set(
    [...coverages.values()].flatMap((coverage) => coverage.downstreamCandidateIds),
  );
  const informationalDownstreamCandidateIds = new Set(
    [...informationalCoverages.values()].flatMap((coverage) => coverage.downstreamCandidateIds),
  );
  const retainedRestCandidates =
    rest.status === "ready"
      ? rest.candidates.filter(
          (candidate) =>
            !informationalRestCandidateIds.has(candidate.id) ||
            retainedRestCandidateIds.has(candidate.id),
        )
      : [];
  const retainedDownstreamCandidates =
    downstream.status === "ready"
      ? downstream.candidates.filter(
          (candidate) =>
            !informationalDownstreamCandidateIds.has(candidate.id) ||
            retainedDownstreamCandidateIds.has(candidate.id),
        )
      : [];
  const retainedRootCauseIds = new Set(
    retainedDownstreamCandidates.flatMap((candidate) => candidate.rootCauseIds ?? []),
  );
  const retainedDownstreamRootCauses = (downstream.rootCauses ?? []).filter((rootCause) =>
    retainedRootCauseIds.has(rootCause.id),
  );
  const retainedDownstream = {
    ...downstream,
    candidates: retainedDownstreamCandidates,
    rootCauses: retainedDownstreamRootCauses,
  };
  /** @type {Record<string, import("./runtime-types.js").EvidenceSet & Record<string, unknown>>} */
  const evidenceSets = {};
  const semanticReviewUnits = assessedSemanticUnits.map((unit) =>
    compactSemanticReviewUnit(
      unit,
      sourceChanges,
      requireMapValue(coverages, unit.id, "Deterministic coverage"),
      evidenceSets,
    ),
  );
  const inferenceRequests = buildInferenceRequests(assessedSemanticUnits, sourceChanges, coverages);
  const retainedInferenceFactIds = inferenceRelevantFactIds({
    semanticUnits: assessedSemanticUnits,
    sourceChanges,
    semantic,
    rest,
    downstream,
    coverages,
  });
  const retainedFactIds = new Set([
    ...retainedInferenceFactIds,
    ...retainedRestCandidates.flatMap((candidate) => candidate.evidenceFactIds ?? []),
    ...downstreamReferencedFactIds(retainedDownstream),
  ]);
  /**
   * @param {AssessmentCandidate} candidate
   * @param {string} artifact
   */
  const compactCandidate = (candidate, artifact) => {
    const { sourceChangeIds, hunkIds, declarationIds, ...judgmentInput } = candidate;
    return {
      ...judgmentInput,
      evidenceSetId: evidenceSet(
        evidenceSets,
        {
          sourceChangeIds,
          hunkIds,
          declarationIds,
          evidenceFactIds: candidate.evidenceFactIds,
        },
        artifact,
        candidate.id,
      ),
    };
  };
  /** @param {ComplianceSearchRequest["queryProfile"]} profile */
  const compactQuerySummary = (profile) => ({
    servicePlane: profile.servicePlane,
    action: profile.action,
    declarationKinds: profile.declarationKinds,
    qualifiedNames: profile.qualifiedNames.slice(0, QUALIFIED_NAME_LIMIT),
    qualifiedNameCount: profile.qualifiedNames.length,
    symbols: profile.symbols.slice(0, QUERY_TERM_LIMIT),
    symbolCount: profile.symbols.length,
    categories: profile.categories,
    changedTokens: profile.changedTokens.slice(0, QUERY_TERM_LIMIT),
    changedTokenCount: profile.changedTokens.length,
    affectedOperationCount: profile.affectedOperationCount,
  });
  const complianceSearchRequests = fullComplianceSearchRequests.map((request) => ({
    requestId: request.requestId,
    reviewUnitId: request.reviewUnitId,
    evidenceSetId: evidenceSet(
      evidenceSets,
      request,
      ARTIFACT_REFERENCES.complianceSearchRequests,
      request.requestId,
    ),
    querySummary: compactQuerySummary(request.queryProfile),
  }));
  /** @type {AnalysisModelInput} */
  const input = {
    schemaVersion: 1,
    context: {
      sourceComparison: {
        baseCommit: manifest.comparison.mergeBaseCommit,
        headCommit: manifest.comparison.headCommit,
        baseRef: manifest.comparison.baseRef,
        workingTree: manifest.comparison.workingTree,
      },
      projects: manifest.projects.map(
        ({ id, path: projectPath, artifactComparison, apiVersions }) => ({
          id,
          path: projectPath,
          artifactComparison: artifactComparison ?? {
            mode: "legacy",
            baseline: {
              sourceRevision: "base",
              commit: manifest.comparison.mergeBaseCommit,
              apiVersion: apiVersions?.base,
              reason: apiVersions?.baseReason,
            },
            target: {
              sourceRevision: "current",
              commit: manifest.comparison.headCommit,
              apiVersion: apiVersions?.current,
              reason: apiVersions?.currentReason,
            },
          },
        }),
      ),
    },
    artifactReferences: ARTIFACT_REFERENCES,
    evidenceSets,
    facts: referencedFacts(semantic, rest, downstream, retainedFactIds),
    semanticReviewUnits,
    informationalSemanticIntentIds: informationalSemanticUnits.map((unit) => unit.id),
    restCandidates:
      rest.status === "ready"
        ? retainedRestCandidates.map((candidate) =>
            compactCandidate(candidate, ARTIFACT_REFERENCES.restCandidates),
          )
        : [],
    downstreamCandidates:
      downstream.status === "ready"
        ? retainedDownstreamCandidates.map((candidate) =>
            compactCandidate(candidate, ARTIFACT_REFERENCES.downstreamCandidates),
          )
        : [],
    downstreamRootCauses: downstream.status === "ready" ? retainedDownstreamRootCauses : [],
    complianceSearchRequests,
    inferenceRequests,
    blockers: [
      ...manifest.blockers,
      ...semantic.blockers,
      ...rest.blockers,
      ...downstream.blockers,
    ],
    inputAccounting: {},
  };
  return accountInput(input, maximumBytes);
}

/**
 * @param {PreparationManifest} manifest
 * @param {SemanticAnalysis} semantic
 * @param {BreakingAnalysis} rest
 * @param {DownstreamAnalysis} downstream
 * @returns {AssessmentOutput}
 */
export function blockedAssessment(manifest, semantic, rest, downstream) {
  return requireAssessmentOutput({
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
    confidence: "low",
    safety: { scope: "rest-and-downstream-only", status: "not-assessed" },
    dimensions: {
      semantic: {
        status: "not-assessed",
        items: [],
        blockers: semantic.blockers,
      },
      rest: { status: "not-assessed", findings: [], blockers: rest.blockers },
      downstream: {
        status: "not-assessed",
        findings: [],
        blockers: downstream.blockers,
      },
      compliance: {
        status: "not-assessed",
        summary: "Azure Guidelines could not run because deterministic analysis was blocked.",
        coverage: {
          semanticIntentCount: 0,
          assessedIntentCount: 0,
          selectedDocumentCount: 0,
          unassessedIntentIds: [],
        },
        intentAssessments: [],
        findings: [],
        retrievalFailures: [],
        blockers: [...manifest.blockers, ...semantic.blockers],
      },
      documentQuality: {
        status: "not-assessed",
        summary:
          "Documentation Completeness could not run because deterministic analysis was blocked.",
      },
    },
    changedFiles: manifest.changedFiles,
    projects: manifest.projects,
    blockers: [
      ...manifest.blockers,
      ...semantic.blockers,
      ...rest.blockers,
      ...downstream.blockers,
    ],
    provenance: { preparationManifest: "preparation-manifest.json" },
    timings: manifest.timings,
  });
}

/** @param {string} output */
export function assertFreshOutput(output) {
  if (fs.existsSync(output) && fs.readdirSync(output, { withFileTypes: true }).length) {
    throw new Error(
      `Assessment output directory must be empty: ${output}. Choose a new --output directory.`,
    );
  }
}

/**
 * @param {unknown} value
 * @returns {AssessmentOutput}
 */
function requireAssessmentOutput(value) {
  if (
    !isRecord(value) ||
    value.schemaVersion !== 1 ||
    !isRecord(value.comparison) ||
    !isRecord(value.safety) ||
    !isRecord(value.dimensions) ||
    !Array.isArray(value.blockers)
  ) {
    throw new TypeError("Expected a current assessment output.");
  }
  return /** @type {AssessmentOutput} */ (value);
}

/**
 * @param {string} file
 * @returns {SourceIndex}
 */
function readSourceIndex(file) {
  const value = readJsonObject(file);
  if (
    typeof value.schemaVersion !== "number" ||
    !isRecord(value.analysis) ||
    !Array.isArray(value.sourceChanges) ||
    !value.sourceChanges.every(
      (source) =>
        isRecord(source) &&
        typeof source.id === "string" &&
        typeof source.path === "string" &&
        Array.isArray(source.hunks) &&
        Array.isArray(source.declarations),
    )
  ) {
    throw new TypeError(`Expected a source index in ${file}.`);
  }
  return /** @type {SourceIndex} */ (/** @type {unknown} */ (value));
}

/**
 * @param {AssessmentAnalysisOptions} options
 */
export async function runAssessmentAnalysis(options) {
  const output = path.resolve(options.output);
  assertFreshOutput(output);
  const resolvedOptions = options.invocation ? options : resolveAssessmentInput(options);
  fs.mkdirSync(output, { recursive: true });
  transitionWorkflowState(output, "preparing", {
    invocation: resolvedOptions.invocation,
    failure: undefined,
  });
  const manifest = await prepareAssessment({ ...resolvedOptions, output });
  if (manifest.status === "no-changes") {
    const result = {
      schemaVersion: 1,
      status: "no-changes",
      message: "No changed TypeSpec was found in the selected specification.",
      comparison: manifest.comparison,
    };
    writeJson(path.join(output, "model-input.json"), result);
    transitionWorkflowState(output, "complete", {
      phaseComplete: true,
      artifacts: { modelInput: "model-input.json" },
    });
    return result;
  }
  const sourceIndex = readSourceIndex(path.join(output, "source", "source-index.json"));
  fs.mkdirSync(path.join(output, "dimensions"), { recursive: true });
  /**
   * @template T
   * @param {string} name
   * @param {() => T} action
   * @returns {T}
   */
  const runDimension = (name, action) => {
    const started = performance.now();
    const result = action();
    manifest.timings[name] = Math.round(performance.now() - started);
    return result;
  };
  const semantic = runDimension("semanticAnalysisMs", () =>
    analyzeSemanticIntents({
      manifest,
      sourceIndex,
      workRoot: output,
      output: path.join(output, "dimensions", "semantic-intents-input.json"),
    }),
  );
  const rest = runDimension("restAnalysisMs", () =>
    analyzeRestBreaking({
      manifest,
      sourceIndex,
      workRoot: output,
      output: path.join(output, "dimensions", "rest-breaking-input.json"),
    }),
  );
  const downstream = runDimension("downstreamAnalysisMs", () =>
    analyzeDownstreamBreaking({
      manifest,
      sourceIndex,
      workRoot: output,
      output: path.join(output, "dimensions", "downstream-breaking-input.json"),
    }),
  );
  const documentQuality = runDimension("documentQualityAnalysisMs", () =>
    buildDocumentQualityInput({
      sourceIndex,
      semantic: {
        ...semantic,
        reviewUnits:
          semantic.status === "ready"
            ? partitionSemanticIntents(semantic.reviewUnits).assessed
            : [],
      },
    }),
  );
  writeJson(path.join(output, "dimensions", "document-quality-input.json"), documentQuality);
  writeJson(path.join(output, "preparation-manifest.json"), manifest);
  const allBlocked = [semantic, rest, downstream].every((item) => item.status === "blocked");
  if (allBlocked) {
    const assessment = blockedAssessment(manifest, semantic, rest, downstream);
    const errors = validateAssessment(assessment);
    if (errors.length) throw new Error(errors.join("\n"));
    writeJson(path.join(output, "assessment.json"), assessment);
    fs.writeFileSync(path.join(output, "assessment.html"), renderAssessmentHtml(assessment));
    transitionWorkflowState(output, "blocked", {
      phaseComplete: true,
      artifacts: {
        structuredResult: "assessment.json",
        report: "assessment.html",
      },
    });
    return { status: "blocked", assessment };
  }
  const configuredMaximum =
    options.model_input_budget_bytes === undefined
      ? undefined
      : Number(options.model_input_budget_bytes);
  if (
    configuredMaximum !== undefined &&
    (!Number.isInteger(configuredMaximum) || configuredMaximum <= 0)
  ) {
    throw new Error("--model-input-budget-bytes requires a positive integer.");
  }
  const modelInput = buildModelInput({
    manifest,
    sourceIndex,
    semantic,
    rest,
    downstream,
    maximumBytes: configuredMaximum,
  });
  writeJson(path.join(output, "dimensions", "compliance-search-requests.json"), {
    schemaVersion: 1,
    requests: buildComplianceSearchRequests({
      semanticReviewUnits:
        semantic.status === "ready" ? partitionSemanticIntents(semantic.reviewUnits).assessed : [],
      sourceChanges: compactSources(
        sourceIndex,
        {
          ...semantic,
          reviewUnits:
            semantic.status === "ready"
              ? partitionSemanticIntents(semantic.reviewUnits).assessed
              : [],
        },
        rest,
        downstream,
      ),
    }),
  });
  writeJson(path.join(output, "model-input.json"), modelInput);
  const workspace = buildAgentWorkspace({ work: output });
  return {
    status: "awaiting-agent-judgment",
    modelInput,
    agentIndex: workspace.indexPath,
  };
}

/**
 * @param {CliArguments} args
 * @returns {AssessmentAnalysisOptions}
 */
function assessmentOptionsFromArgs(args) {
  for (const name of [
    "output",
    "repo",
    "base",
    "head",
    "specification",
    "model_input_budget_bytes",
  ]) {
    if (args[name] !== undefined && typeof args[name] !== "string") {
      throw new TypeError(`--${name.replaceAll("_", "-")} requires a value.`);
    }
  }
  if (args.pr !== undefined && typeof args.pr !== "string" && typeof args.pr !== "number") {
    throw new TypeError("--pr requires a value.");
  }
  if (
    args.sparse_root !== undefined &&
    (!Array.isArray(args.sparse_root) ||
      !args.sparse_root.every((value) => typeof value === "string"))
  ) {
    throw new TypeError("--sparse-root requires a value.");
  }
  if (typeof args.output !== "string") {
    throw new TypeError("--output requires a value.");
  }
  return /** @type {AssessmentAnalysisOptions} */ (/** @type {unknown} */ (args));
}

if (isMain(import.meta.url)) {
  void runMain(async () => {
    const args = parseArgs(process.argv.slice(2), {
      required: ["output"],
      defaults: { repo: process.cwd() },
      arrays: ["sparse-root"],
    });
    const options = assessmentOptionsFromArgs(args);
    const result = await runAssessmentAnalysis(options);
    const agentIndex =
      "agentIndex" in result && typeof result.agentIndex === "string"
        ? result.agentIndex
        : path.join(path.resolve(options.output), "model-input.json");
    console.log(`${result.status}: ${agentIndex}`);
    if (result.status === "blocked") process.exitCode = 1;
  });
}
