import { canonicalJson, stableId } from "./stable-id.mjs";
import { buildDocumentQualityInput, DOCUMENT_QUALITY_CRITERION } from "./document-quality-input.mjs";

export const DOCUMENT_QUALITY_ARTIFACT = "dimensions/document-quality-input.json";
const checksFor = (version) => version >= 2 ? ["description"] : ["correctness", "meaning"];
const DECISION_FIELDS = [
  "reviewUnitId", "documentId", "check", "decision", "rationale",
  "title", "expected", "docQuote",
];
const LEGACY_SUMMARY = "Document Quality was not assessed: source documentation input is unavailable.";

function requireValue(condition, message) {
  if (!condition) throw new Error(`Document Quality: ${message}`);
}

function object(value, fields, label) {
  requireValue(value && typeof value === "object" && !Array.isArray(value), `${label} must be an object.`);
  const unknown = Object.keys(value).filter((key) => !fields.includes(key));
  requireValue(!unknown.length, `${label} contains unknown fields: ${unknown.join(", ")}.`);
}

function text(value, label) {
  requireValue(typeof value === "string" && value.trim().length > 0, `${label} must be a nonempty string.`);
}

function array(value, label) {
  requireValue(Array.isArray(value), `${label} must be an array.`);
}

function ids(value, label) {
  array(value, label);
  value.forEach((id) => text(id, label));
  requireValue(new Set(value).size === value.length, `${label} contains duplicates.`);
}

function coverage(expected, actual, label) {
  ids(actual, label);
  requireValue(
    expected.length === actual.length && expected.every((id) => actual.includes(id)),
    `${label} coverage mismatch.`,
  );
}

function equal(expected, actual, label) {
  requireValue(canonicalJson(expected) === canonicalJson(actual), `${label} does not match canonical evidence.`);
}

function validateSnapshot(snapshot, revision, source, label, version) {
  if (snapshot === null) return;
  object(snapshot, ["doc", "declaration", "source", ...(version === 3 ? ["documentationOrigin"] : [])], label);
  if (Object.hasOwn(snapshot, "documentationOrigin")) {
    requireValue(snapshot.documentationOrigin === "inherited", `${label}.documentationOrigin must be inherited.`);
  }
  requireValue(typeof snapshot.doc === "string", `${label}.doc must be a string.`);
  text(snapshot.declaration, `${label}.declaration`);
  object(snapshot.source, ["path", "revision", "startLine", "endLine"], `${label}.source`);
  requireValue(
    snapshot.source.path === source.path && snapshot.source.revision === revision &&
      Number.isInteger(snapshot.source.startLine) && snapshot.source.startLine > 0 &&
      Number.isInteger(snapshot.source.endLine) && snapshot.source.endLine >= snapshot.source.startLine,
    `${label} has invalid source provenance.`,
  );
}

function validateDocument(document, unit, sources, version) {
  object(document, ["id", "sourceChangeId", "qualifiedName", "kind", "before", "after"], "document");
  text(document.id, "document.id");
  requireValue(document.id.startsWith("document-"), "document.id must start with document-.");
  text(document.qualifiedName, "document.qualifiedName");
  text(document.kind, "document.kind");
  const source = sources.get(document.sourceChangeId);
  requireValue(source && unit.sourceChangeIds.includes(document.sourceChangeId), `document ${document.id} references an unknown source.`);
  const evidence = source.documentEvidence?.documents?.find((item) => item.id === document.id);
  const scopedHunks = unit.hunkIds.length ? unit.hunkIds : (source.declarations ?? [])
    .filter((declaration) => unit.declarationIds.includes(declaration.id))
    .flatMap((declaration) => declaration.hunkIds ?? []);
  requireValue(evidence && evidence.hunkIds?.some((id) => scopedHunks.includes(id)),
    `document ${document.id} does not match its semantic declaration scope.`);
  const { hunkIds: _hunks, blocker: _blocker, ...canonical } = evidence;
  validateSnapshot(document.before, "base", source, `${document.id}.before`, version);
  requireValue(document.after !== null, `document ${document.id} requires current documentation.`);
  validateSnapshot(document.after, "current", source, `${document.id}.after`, version);
  requireValue(document.after.doc.trim().length > 0,
    `document ${document.id} has empty or whitespace @doc, which is missing documentation and outside assessment scope.`);
  equal(canonical, document, `document ${document.id}`);
}

function scopeForSemantic(unit) {
  const sourceIds = unit.sourceChangeIds ?? (unit.sources ?? []).map((source) => source.id);
  const hunkIds = unit.hunkIds ?? (unit.sources ?? []).flatMap((source) => source.hunks.map((hunk) => hunk.id));
  return {
    sourceIds, hunkIds,
    declarationIds: unit.declarationIds ?? [],
  };
}

function validateCompletenessInput(input, semanticUnits, sourceChanges, semanticStatus) {
  object(input, ["schemaVersion", "status", "blockers", "reviewUnits"], "input");
  requireValue([4, 5].includes(input.schemaVersion), "unsupported completeness input schemaVersion.");
  requireValue(["ready", "blocked"].includes(input.status), "invalid input status.");
  array(input.blockers, "input.blockers");
  array(input.reviewUnits, "input.reviewUnits");
  coverage(
    semanticUnits.map((unit) => unit.id ?? unit.reviewUnitId),
    input.reviewUnits.map((unit) => unit.reviewUnitId),
    "review unit",
  );
  for (const unit of input.reviewUnits) {
    object(unit, [
      "reviewUnitId", "status", "reason", "sourceChangeIds", "hunkIds",
      "declarationIds", "declarations",
    ], "review unit");
    requireValue(["ready", "not-applicable", "blocked"].includes(unit.status), "invalid review unit status.");
    if (unit.status !== "ready") text(unit.reason, "review unit reason");
    for (const field of ["sourceChangeIds", "hunkIds", "declarationIds"]) {
      ids(unit[field], `review unit ${field}`);
    }
    array(unit.declarations, "review unit declarations");
    ids(unit.declarations.map((declaration) => declaration.declarationId), "declaration IDs");
    for (const declaration of unit.declarations) {
      object(declaration, [
        "declarationId", "qualifiedName", "kind", "documentationPresent",
        "source", "sourceChangeId",
      ], "documentation declaration");
      text(declaration.declarationId, "declaration.declarationId");
      text(declaration.qualifiedName, "declaration.qualifiedName");
      text(declaration.kind, "declaration.kind");
      requireValue(typeof declaration.documentationPresent === "boolean",
        "declaration.documentationPresent must be boolean.");
      text(declaration.sourceChangeId, "declaration.sourceChangeId");
      requireValue(unit.sourceChangeIds.includes(declaration.sourceChangeId),
        "documentation declaration references an out-of-scope source.");
    }
    requireValue(unit.status !== "ready" || unit.declarations.length > 0,
      "ready review unit requires declarations.");
    requireValue(unit.status !== "not-applicable" || unit.declarations.length === 0,
      "not-applicable review unit cannot contain declarations.");
  }
  equal(buildDocumentQualityInput({
    schemaVersion: input.schemaVersion,
    sourceIndex: { sourceChanges },
    semantic: {
      status: semanticStatus,
      reviewUnits: semanticUnits.map((unit) => ({
        ...unit,
        id: unit.id ?? unit.reviewUnitId,
        ...scopeForSemantic(unit),
      })),
    },
  }), input, "input");
}

export function validateDocumentQualityInput(input, semanticUnits, sourceChanges, semanticStatus = "ready") {
  if ([4, 5].includes(input?.schemaVersion)) {
    validateCompletenessInput(input, semanticUnits, sourceChanges, semanticStatus);
    return;
  }
  object(input, ["schemaVersion", "status", "blockers", "reviewUnits"], "input");
  requireValue([1, 2, 3].includes(input.schemaVersion), "unsupported input schemaVersion.");
  requireValue(["ready", "blocked"].includes(input.status), "invalid input status.");
  array(input.blockers, "input.blockers");
  array(input.reviewUnits, "input.reviewUnits");
  const semantic = new Map(semanticUnits.map((unit) => [unit.id ?? unit.reviewUnitId, unit]));
  const sources = new Map(sourceChanges.map((source) => [source.id, source]));
  coverage([...semantic.keys()], input.reviewUnits.map((unit) => unit.reviewUnitId), "review unit");
  for (const unit of input.reviewUnits) {
    object(unit, ["reviewUnitId", "status", "reason", "sourceChangeIds", "hunkIds", "declarationIds", "documents",
      ...(input.schemaVersion === 3 ? ["inheritedDocumentIds"] : [])], "review unit");
    if (unit.inheritedDocumentIds !== undefined) ids(unit.inheritedDocumentIds, "inherited document IDs");
    requireValue(["ready", "not-applicable", "blocked"].includes(unit.status), "invalid review unit status.");
    if (unit.status !== "ready" || unit.reason !== undefined) text(unit.reason, "review unit reason");
    const scope = scopeForSemantic(semantic.get(unit.reviewUnitId));
    coverage(scope.sourceIds, unit.sourceChangeIds, "source change");
    coverage(scope.hunkIds, unit.hunkIds, "hunk");
    coverage(scope.declarationIds, unit.declarationIds, "declaration");
    for (const id of unit.sourceChangeIds) {
      requireValue(sources.has(id), `unknown source ${id}.`);
    }
    for (const id of unit.hunkIds) {
      requireValue(unit.sourceChangeIds.some((sourceId) =>
        sources.get(sourceId).hunks?.some((hunk) => hunk.id === id)), `unknown hunk ${id}.`);
    }
    for (const id of unit.declarationIds) {
      requireValue(unit.sourceChangeIds.some((sourceId) =>
        sources.get(sourceId).declarations?.some((declaration) =>
          declaration.id === id && (!unit.hunkIds.length ||
            declaration.hunkIds?.some((hunkId) => unit.hunkIds.includes(hunkId))))),
      `unknown or out-of-scope declaration ${id}.`);
    }
    array(unit.documents, "review unit documents");
    ids(unit.documents.map((document) => document.id), "document IDs");
    requireValue(unit.status !== "ready" || unit.documents.length > 0, "ready review unit requires documents.");
    requireValue(unit.status !== "not-applicable" || unit.documents.length === 0, "not-applicable review unit cannot contain documents.");
    for (const document of unit.documents) {
      validateDocument(document, unit, sources, input.schemaVersion);
    }
  }
  requireValue(input.status !== "ready" || (!input.blockers.length && input.reviewUnits.every((unit) => unit.status !== "blocked")),
    "ready input cannot contain blockers or blocked review units.");
  requireValue(input.status !== "blocked" || input.blockers.length > 0 || input.reviewUnits.some((unit) => unit.status === "blocked"),
    "blocked input requires a blocker or blocked review unit.");
  equal(buildDocumentQualityInput({
    schemaVersion: input.schemaVersion,
    sourceIndex: { sourceChanges },
    semantic: { status: semanticStatus, reviewUnits: semanticUnits.map((unit) => {
      const scope = scopeForSemantic(unit);
      return {
        ...unit, id: unit.id ?? unit.reviewUnitId,
        sourceChangeIds: scope.sourceIds,
        hunkIds: scope.hunkIds,
        declarationIds: scope.declarationIds,
      };
    }) },
  }), input, "input");
}

function validateModelSummaries(modelInput, input) {
  if (input.schemaVersion >= 2) {
    requireValue(modelInput.documentQualityAssessmentVersion === input.schemaVersion, "model documentation assessment version mismatch.");
    requireValue(modelInput.documentQualityCriterion === DOCUMENT_QUALITY_CRITERION, "model documentation criterion mismatch.");
  } else {
    requireValue(modelInput.documentQualityAssessmentVersion === undefined && modelInput.documentQualityCriterion === undefined,
      "legacy input cannot use versioned model documentation metadata.");
  }
  array(modelInput.documentQualityReviewUnits, "model documentQualityReviewUnits");
  coverage(input.reviewUnits.map((unit) => unit.reviewUnitId),
    modelInput.documentQualityReviewUnits.map((unit) => unit.reviewUnitId), "model review unit");
  for (const summary of modelInput.documentQualityReviewUnits) {
    object(summary, [
      "reviewUnitId", "status", "documentIds", "evidenceSetId", "reason",
      "qualifiedNames", "sourceChangeIds", "hunkIds", "declarationIds", "inheritedDocumentCount",
    ], "model review unit");
    const unit = input.reviewUnits.find((item) => item.reviewUnitId === summary.reviewUnitId);
    requireValue((summary.inheritedDocumentCount ?? 0) === (unit.inheritedDocumentIds?.length ?? 0),
      "model inherited documentation count mismatch.");
    requireValue(summary.status === unit.status, "model review unit status mismatch.");
    coverage(unit.documents.map((document) => document.id), summary.documentIds, "model document");
    text(summary.evidenceSetId, "model evidenceSetId");
    const evidence = modelInput.evidenceSets?.[summary.evidenceSetId];
    requireValue(evidence, "model references an unknown evidence set.");
    equal({
      sourceChangeIds: unit.sourceChangeIds,
      hunkIds: unit.hunkIds,
      declarationCount: unit.declarationIds.length,
      evidenceFactIds: [],
      evidenceRef: { artifact: DOCUMENT_QUALITY_ARTIFACT, id: unit.reviewUnitId },
    }, evidence, "model evidence set");
    if (summary.qualifiedNames !== undefined) {
      coverage([...new Set(unit.documents.map((document) => document.qualifiedName))].sort().slice(0, 24),
        summary.qualifiedNames, "model qualified name");
    }
    for (const field of ["sourceChangeIds", "hunkIds", "declarationIds"]) {
      if (summary[field] !== undefined) coverage(unit[field], summary[field], `model ${field}`);
    }
    if (unit.reason !== undefined || summary.reason !== undefined) {
      requireValue(unit.reason === summary.reason, "model reason mismatch.");
    }
  }
}

export function validateDocumentQualityDecisions(input, decisions) {
  array(decisions, "decisions");
  const checks = checksFor(input.schemaVersion);
  const expected = input.reviewUnits.filter((unit) => unit.status === "ready")
    .flatMap((unit) => unit.documents.flatMap((document) =>
      checks.map((check) => `${unit.reviewUnitId}/${document.id}/${check}`)));
  for (const decision of decisions) {
    object(decision, DECISION_FIELDS, "decision");
    for (const field of ["reviewUnitId", "documentId", "rationale"]) text(decision[field], `decision.${field}`);
    requireValue(checks.includes(decision.check), "invalid check.");
    requireValue(["pass", "fail", "not-assessed"].includes(decision.decision), "invalid decision.");
    for (const field of ["title", "expected", "docQuote"]) {
      if (decision.decision === "fail" || decision[field] !== undefined) text(decision[field], `decision.${field}`);
    }
    const unit = input.reviewUnits.find((item) => item.reviewUnitId === decision.reviewUnitId);
    const document = unit?.documents.find((item) => item.id === decision.documentId);
    requireValue(unit?.status === "ready" && document, "decision references an unknown or ineligible document.");
    if (decision.docQuote !== undefined) {
      requireValue(document.after.doc.includes(decision.docQuote), "docQuote must be an exact substring of current canonical @doc text.");
    }
  }
  coverage(expected, decisions.map((decision) =>
    `${decision.reviewUnitId}/${decision.documentId}/${decision.check}`), "decision");
}

function findingSources(unit, document, sources) {
  const source = sources.get(document.sourceChangeId);
  return [{
    ...source,
    hunks: (source.hunks ?? []).filter((hunk) => unit.hunkIds.includes(hunk.id)),
    declarations: (source.declarations ?? []).filter((declaration) => unit.declarationIds.includes(declaration.id)),
  }];
}

function assembleCompleteness(input, sourceChanges) {
  const newDeclarationsOnly = input.schemaVersion >= 5;
  const sources = new Map(sourceChanges.map((source) => [source.id, source]));
  const unassessedIntentIds = [];
  const notApplicableIntentIds = [];
  const findings = [];
  let declarationCount = 0;
  let documentedDeclarationCount = 0;
  const intentAssessments = input.reviewUnits.map((unit) => {
    if (unit.status === "blocked") unassessedIntentIds.push(unit.reviewUnitId);
    if (unit.status === "not-applicable") notApplicableIntentIds.push(unit.reviewUnitId);
    declarationCount += unit.declarations.length;
    documentedDeclarationCount += unit.declarations.filter(
      (declaration) => declaration.documentationPresent,
    ).length;
    for (const declaration of unit.declarations.filter(
      (item) => !item.documentationPresent,
    )) {
      const source = sources.get(declaration.sourceChangeId);
      const sourceDeclaration = source?.declarations?.find((item) =>
        item.id === declaration.declarationId &&
        item.source?.revision === "current");
      findings.push({
        id: stableId("document-finding", [unit.reviewUnitId, declaration.declarationId]),
        reviewUnitId: unit.reviewUnitId,
        declarationId: declaration.declarationId,
        title: `Missing documentation for ${declaration.qualifiedName}`,
        expected: "Add a nonempty TypeSpec documentation description.",
        actual: "The TypeSpec compiler returned no nonempty documentation for this declaration.",
        rationale: "Documentation completeness checks presence only; documentation text is not compared with code.",
        semanticIntentIds: [unit.reviewUnitId],
        sources: source
          ? [
              {
                id: source.id,
                path: source.path,
                status: source.status,
                origins: source.origins,
              },
            ]
          : [],
        ...(sourceDeclaration?.sourceSnippet
          ? {
              codeSnippet: {
                path: source.path,
                ...sourceDeclaration.sourceSnippet,
              },
            }
          : {}),
        declaration,
      });
    }
    return {
      reviewUnitId: unit.reviewUnitId,
      status: unit.status === "blocked"
        ? "not-assessed"
        : unit.status === "not-applicable"
          ? "not-applicable"
          : unit.declarations.some((declaration) => !declaration.documentationPresent)
            ? "failed"
            : "passed",
      ...(unit.reason ? { reason: unit.reason } : {}),
      declarations: unit.declarations,
    };
  });
  const missingDeclarationCount = declarationCount - documentedDeclarationCount;
  const status = findings.length
    ? "failed"
    : input.status === "blocked" || unassessedIntentIds.length
      ? "not-assessed"
      : declarationCount
        ? "passed"
        : "not-applicable";
  return {
    assessmentVersion: input.schemaVersion,
    status,
    summary: status === "failed"
      ? newDeclarationsOnly
          ? `${missingDeclarationCount} newly added operation, model, enum, or interface declaration(s) have no nonempty compiler-resolved documentation.`
          : `${missingDeclarationCount} changed declaration(s) have no nonempty compiler-resolved documentation.`
      : status === "not-assessed"
          ? "Documentation completeness is incomplete because compiler evidence is unavailable."
          : status === "not-applicable"
            ? newDeclarationsOnly
              ? "No newly added operation, model, enum, or interface declarations require documentation completeness assessment."
              : "No changed compiler declarations require documentation completeness assessment."
            : newDeclarationsOnly
              ? "Every newly added operation, model, enum, and interface declaration has nonempty compiler-resolved documentation."
              : "Every changed compiler declaration has nonempty compiler-resolved documentation.",
    coverage: {
      semanticIntentCount: input.reviewUnits.length,
      assessedIntentCount: input.reviewUnits.length - unassessedIntentIds.length,
      declarationCount,
      documentedDeclarationCount,
      missingDeclarationCount,
      unassessedIntentIds,
      notApplicableIntentIds,
    },
    intentAssessments,
    findings,
    blockers: input.blockers,
  };
}

function assembleDimension(input, decisions, sourceChanges) {
  const checksPerDocument = checksFor(input.schemaVersion).length;
  const sources = new Map(sourceChanges.map((source) => [source.id, source]));
  const unassessedIntentIds = [];
  const notApplicableIntentIds = [];
  let documentCount = 0;
  let assessedDocumentCount = 0;
  let assessedCheckCount = 0;
  const findings = [];
  const intentAssessments = input.reviewUnits.map((unit) => {
    const checks = decisions.filter((decision) => decision.reviewUnitId === unit.reviewUnitId);
    const eligible = unit.status === "ready";
    const complete = unit.status === "not-applicable" ||
      (eligible && checks.every((check) => check.decision !== "not-assessed"));
    if (!complete) unassessedIntentIds.push(unit.reviewUnitId);
    if (unit.status === "not-applicable") notApplicableIntentIds.push(unit.reviewUnitId);
    if (eligible) {
      documentCount += unit.documents.length;
      assessedDocumentCount += unit.documents.filter((document) =>
        checks.filter((check) => check.documentId === document.id && check.decision !== "not-assessed").length === checksPerDocument).length;
      assessedCheckCount += checks.filter((check) => check.decision !== "not-assessed").length;
    }
    for (const check of checks.filter((check) => check.decision === "fail")) {
      const document = unit.documents.find((document) => document.id === check.documentId);
      findings.push({
        id: stableId("document-finding", [unit.reviewUnitId, document.id, check.check]),
        reviewUnitId: unit.reviewUnitId,
        documentId: document.id,
        check: check.check,
        title: check.title,
        expected: check.expected,
        actual: document.after.doc,
        rationale: check.rationale,
        docQuote: check.docQuote,
        semanticIntentIds: [unit.reviewUnitId],
        sources: findingSources(unit, document, sources),
        document,
      });
    }
    const status = checks.some((check) => check.decision === "fail") ? "failed"
      : unit.status === "not-applicable" ? "not-applicable"
        : complete ? "passed" : "not-assessed";
    return {
      reviewUnitId: unit.reviewUnitId,
      status,
      ...(unit.reason ? { reason: unit.reason } : {}),
      documents: unit.documents,
      ...(unit.inheritedDocumentIds ? { inheritedDocumentIds: unit.inheritedDocumentIds } : {}),
      checks,
    };
  });
  const inheritedDocumentCount = input.reviewUnits.reduce((sum, unit) => sum + (unit.inheritedDocumentIds?.length ?? 0), 0);
  const status = findings.length ? "failed"
    : input.status === "blocked" || unassessedIntentIds.length || input.blockers.length ? "not-assessed"
      : input.schemaVersion >= 2 && documentCount === 0 ? "not-applicable" : "passed";
  return {
    ...(input.schemaVersion >= 2 ? { assessmentVersion: input.schemaVersion } : {}),
    status,
    summary: status === "failed"
      ? input.schemaVersion >= 2
        ? `${findings.length} description(s) do not clearly and accurately explain their associated TypeSpec code.`
        : `${findings.length} source @doc Correctness or Meaning check(s) failed.`
      : status === "not-assessed"
        ? "Source @doc assessment is incomplete; blocked or not-assessed checks are not passes."
        : documentCount === 0
          ? inheritedDocumentCount
            ? "Inherited documentation is present; its quality is not reviewed in v1."
            : "No applicable current source @doc declarations in the changed semantic scope."
          : input.schemaVersion >= 2
            ? "All assessed descriptions clearly and accurately explain their associated TypeSpec code."
            : "All applicable source @doc Correctness and Meaning checks passed.",
    coverage: {
      semanticIntentCount: input.reviewUnits.length,
      assessedIntentCount: input.reviewUnits.length - unassessedIntentIds.length,
      documentCount,
      assessedDocumentCount,
      checkCount: documentCount * checksPerDocument,
      assessedCheckCount,
      ...(input.schemaVersion === 3 ? {
        inheritedDocumentCount,
      } : {}),
      unassessedIntentIds,
      notApplicableIntentIds,
    },
    intentAssessments,
    findings,
    blockers: input.blockers,
  };
}

export function assembleDocumentQuality({ input, modelInput = {}, decisions, semanticUnits, sourceChanges, semanticStatus = "ready" }) {
  if (input?.schemaVersion === 4 || input?.schemaVersion === 5) {
    requireValue(decisions === undefined || (Array.isArray(decisions) && decisions.length === 0),
      "documentation completeness does not accept Agent decisions.");
    validateDocumentQualityInput(input, semanticUnits, sourceChanges, semanticStatus);
    return assembleCompleteness(input, sourceChanges);
  }
  const declared = modelInput.artifactReferences?.documentQuality;
  if (input === undefined && declared === undefined && modelInput.documentQualityReviewUnits === undefined
    && modelInput.documentQualityAssessmentVersion === undefined && modelInput.documentQualityCriterion === undefined) {
    requireValue(decisions === undefined || (Array.isArray(decisions) && decisions.length === 0),
      "nonempty decisions require a declared canonical artifact.");
    return { status: "not-assessed", summary: LEGACY_SUMMARY };
  }
  requireValue(declared === DOCUMENT_QUALITY_ARTIFACT, "documentQualityReviewUnits requires the declared canonical artifact.");
  requireValue(input !== undefined, "declared canonical artifact is missing.");
  validateDocumentQualityInput(input, semanticUnits, sourceChanges, semanticStatus);
  validateModelSummaries(modelInput, input);
  validateDocumentQualityDecisions(input, decisions);
  return assembleDimension(input, decisions, sourceChanges);
}

export function validateDocumentQualityDimension(dimension, semanticItems, semanticStatus = "ready") {
  const errors = [];
  try {
    if ([4, 5].includes(dimension?.assessmentVersion)) {
      object(dimension, [
        "assessmentVersion", "status", "summary", "coverage",
        "intentAssessments", "findings", "blockers",
      ], "dimension");
      text(dimension.summary, "dimension.summary");
      for (const field of ["intentAssessments", "findings", "blockers"]) {
        array(dimension[field], `dimension.${field}`);
      }
      const sourceMap = new Map();
      for (const item of semanticItems) {
        for (const source of item.sources ?? []) {
          const previous = sourceMap.get(source.id);
          sourceMap.set(source.id, previous
            ? {
                ...previous,
                ...source,
                hunks: [...new Map([
                  ...(previous.hunks ?? []),
                  ...(source.hunks ?? []),
                ].map((hunk) => [hunk.id, hunk])).values()],
                declarations: [...new Map([
                  ...(previous.declarations ?? []),
                  ...(source.declarations ?? []),
                ].map((declaration) => [declaration.id, declaration])).values()],
              }
            : source);
        }
      }
      const semanticUnits = semanticItems.map((item) => ({
        ...item,
        sourceChangeIds: scopeForSemantic(item).sourceIds,
        hunkIds: scopeForSemantic(item).hunkIds,
        declarationIds: scopeForSemantic(item).declarationIds,
      }));
      const input = buildDocumentQualityInput({
        schemaVersion: dimension.assessmentVersion,
        sourceIndex: { sourceChanges: [...sourceMap.values()] },
        semantic: { status: semanticStatus, reviewUnits: semanticUnits },
      });
      const expected = assembleCompleteness(input, [...sourceMap.values()]);
      equal(expected, dimension, "documentation completeness dimension");
      return errors;
    }
    object(dimension, ["assessmentVersion", "status", "summary", "coverage", "intentAssessments", "findings", "blockers"], "dimension");
    requireValue(dimension.assessmentVersion === undefined || [2, 3].includes(dimension.assessmentVersion), "unsupported assessmentVersion.");
    text(dimension.summary, "dimension.summary");
    if (Object.keys(dimension).every((key) => ["status", "summary"].includes(key))) {
      requireValue(dimension.status === "not-assessed", "legacy dimension must be not-assessed.");
      return errors;
    }
    for (const field of ["intentAssessments", "findings", "blockers"]) array(dimension[field], `dimension.${field}`);
    coverage(semanticItems.map((item) => item.id), dimension.intentAssessments.map((item) => item.reviewUnitId), "final intent");
    const sourceMap = new Map();
    for (const item of semanticItems) {
      for (const source of item.sources ?? []) {
        const previous = sourceMap.get(source.id);
        sourceMap.set(source.id, previous ? {
          ...source,
          hunks: [...new Map([...previous.hunks, ...source.hunks].map((hunk) => [hunk.id, hunk])).values()],
          declarations: [...new Map([...previous.declarations, ...source.declarations].map((declaration) => [declaration.id, declaration])).values()],
        } : source);
      }
    }
    const reviewUnits = dimension.intentAssessments.map((item) => {
      object(item, ["reviewUnitId", "status", "reason", "documents", "checks",
        ...(dimension.assessmentVersion === 3 ? ["inheritedDocumentIds"] : [])], "intent assessment");
      requireValue(["passed", "failed", "not-assessed", "not-applicable"].includes(item.status), "invalid intent status.");
      array(item.documents, "intent documents");
      array(item.checks, "intent checks");
      const semantic = semanticItems.find((unit) => unit.id === item.reviewUnitId);
      const scope = scopeForSemantic(semantic);
      const status = item.status === "not-applicable" ? "not-applicable"
        : item.checks.length ? "ready" : "blocked";
      return {
        reviewUnitId: item.reviewUnitId,
        status,
        ...(item.reason !== undefined ? { reason: item.reason } : {}),
        sourceChangeIds: scope.sourceIds,
        hunkIds: scope.hunkIds,
        declarationIds: scope.declarationIds,
        documents: item.documents,
        ...(item.inheritedDocumentIds !== undefined ? { inheritedDocumentIds: item.inheritedDocumentIds } : {}),
      };
    });
    const input = {
      schemaVersion: dimension.assessmentVersion ?? 1,
      status: dimension.blockers.length || reviewUnits.some((unit) => unit.status === "blocked") ? "blocked" : "ready",
      blockers: dimension.blockers,
      reviewUnits,
    };
    validateDocumentQualityInput(input, semanticItems, [...sourceMap.values()], semanticStatus);
    const decisions = dimension.intentAssessments.flatMap((item) => item.checks);
    validateDocumentQualityDecisions(input, decisions);
    const expected = assembleDimension(input, decisions, [...sourceMap.values()]);
    equal(expected.status, dimension.status, "dimension status");
    equal(expected.coverage, dimension.coverage, "dimension coverage");
    equal(expected.intentAssessments, dimension.intentAssessments, "intent assessments");
    equal(expected.findings, dimension.findings, "findings");
  } catch (error) {
    errors.push(error.message);
  }
  return errors;
}
