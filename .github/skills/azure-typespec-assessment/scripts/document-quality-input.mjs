function unique(values = []) {
  return [...new Set(values)].sort();
}

export const DOCUMENT_QUALITY_CRITERION =
  "Does the TypeSpec compiler return a nonempty effective document?";

const NEW_DECLARATION_KINDS = new Set(["operation", "model", "enum", "interface"]);

function declarationIdentity(declaration) {
  return `${declaration.kind}:${declaration.qualifiedName}`;
}

function isEligibleNewDeclaration(source, declaration, schemaVersion) {
  if (schemaVersion < 5) return true;
  if (!NEW_DECLARATION_KINDS.has(declaration.kind)) return false;
  if (typeof declaration.newDeclaration === "boolean") {
    return declaration.newDeclaration;
  }
  const identity = declarationIdentity(declaration);
  return !(source.declarations ?? []).some((candidate) =>
    candidate.source?.revision === "base" &&
    declarationIdentity(candidate) === identity);
}

function buildCompletenessInput({ sourceIndex, semantic, schemaVersion }) {
  const sources = new Map((sourceIndex?.sourceChanges ?? []).map((source) => [source.id, source]));
  const blockers = [];
  if (!Array.isArray(semantic?.reviewUnits)) {
    return {
      schemaVersion: 4,
      status: "blocked",
      blockers: [{ reason: "Semantic review units are unavailable; documentation scope cannot be established." }],
      reviewUnits: [],
    };
  }
  if (semantic.status === "blocked") {
    blockers.push({ reason: "Semantic assessment is blocked; documentation scope cannot be established." });
  }
  const reviewUnits = semantic.reviewUnits.map((unit) => {
    const sourceChangeIds = unique(unit.sourceChangeIds);
    const hunkIds = unique(unit.hunkIds);
    const declarationIds = unique(unit.declarationIds);
    const reasons = [];
    const declarations = [];
    if (!sourceChangeIds.length) {
      reasons.push("No changed source is associated with this review unit.");
    }
    for (const sourceId of sourceChangeIds) {
      const source = sources.get(sourceId);
      if (!source) {
        reasons.push(`Unknown changed source: ${sourceId}.`);
        continue;
      }
      const eligibleDeclarationIds = new Set(
        (source.declarations ?? [])
          .filter((declaration) => {
            if (declaration.source?.revision !== "current") return false;
            if (!isEligibleNewDeclaration(source, declaration, schemaVersion)) return false;
            if (declarationIds.length) return declarationIds.includes(declaration.id);
            return hunkIds.some((hunkId) => declaration.hunkIds?.includes(hunkId));
          })
          .map((declaration) => declaration.id),
      );
      if (schemaVersion >= 5 && !eligibleDeclarationIds.size) continue;
      const evidence = source.documentEvidence;
      if (evidence?.schemaVersion !== 4) {
        reasons.push(`Documentation presence must be recollected for ${source.path}.`);
        continue;
      }
      if (evidence.status !== "ready") {
        reasons.push(`Compiler documentation presence unavailable for ${source.path}: ${
          evidence.blockers?.map((blocker) => blocker.message).join(" ") ||
          "documentation evidence was not collected."
        }`);
        continue;
      }
      for (const declaration of evidence.declarations ?? []) {
        if (!isEligibleNewDeclaration(source, declaration, schemaVersion)) continue;
        if (schemaVersion >= 5 && !eligibleDeclarationIds.has(declaration.declarationId)) continue;
        if (declarationIds.length && !declarationIds.includes(declaration.declarationId)) continue;
        if (!declarationIds.length && !hunkIds.some((hunkId) =>
          source.declarations?.find((item) => item.id === declaration.declarationId)?.hunkIds?.includes(hunkId))) {
          continue;
        }
        const { newDeclaration: _newDeclaration, ...bounded } = declaration;
        declarations.push({ ...bounded, sourceChangeId: sourceId });
      }
    }
    const uniqueDeclarations = [...new Map(
      declarations.map((declaration) => [declaration.declarationId, declaration]),
    ).values()].sort((left, right) => left.declarationId.localeCompare(right.declarationId));
    if (semantic.status === "blocked") {
      reasons.push("Semantic assessment is blocked; documentation scope cannot be established.");
    }
    return {
      reviewUnitId: unit.id,
      status: reasons.length ? "blocked" : uniqueDeclarations.length ? "ready" : "not-applicable",
      ...(reasons.length
        ? { reason: unique(reasons).join(" ") }
        : uniqueDeclarations.length
          ? {}
          : { reason: schemaVersion >= 5
            ? "No newly added operation, model, enum, or interface declaration is in this Semantic intent."
            : "No changed compiler declaration is in this Semantic intent." }),
      sourceChangeIds,
      hunkIds,
      declarationIds,
      declarations: uniqueDeclarations,
    };
  });
  for (const unit of reviewUnits.filter((unit) => unit.status === "blocked")) {
    blockers.push({ reviewUnitId: unit.reviewUnitId, reason: unit.reason });
  }
  return {
    schemaVersion,
    status: blockers.length ? "blocked" : "ready",
    blockers,
    reviewUnits,
  };
}

function buildLegacyDocumentQualityInput({ sourceIndex, semantic, schemaVersion }) {
  if (![1, 2, 3].includes(schemaVersion)) throw new Error("Unsupported documentation input schemaVersion.");
  const sources = new Map((sourceIndex?.sourceChanges ?? []).map((source) => [source.id, source]));
  const blockers = [];
  if (!Array.isArray(semantic?.reviewUnits)) {
    return {
      schemaVersion, status: "blocked",
      blockers: [{ reason: "Semantic review units are unavailable; documentation scope cannot be established." }],
      reviewUnits: [],
    };
  }
  const semanticBlockReason = semantic.status === "blocked"
    ? "Semantic assessment is blocked; documentation review scope cannot be established."
    : undefined;
  if (semanticBlockReason) blockers.push({ reason: semanticBlockReason });
  const reviewUnits = (semantic?.reviewUnits ?? []).map((unit) => {
    const result = {
      reviewUnitId: unit.id,
      status: "ready",
      sourceChangeIds: unique(unit.sourceChangeIds),
      hunkIds: unique(unit.hunkIds),
      declarationIds: unique(unit.declarationIds),
      documents: [],
    };
    const reasons = semanticBlockReason ? [semanticBlockReason] : [];
    if (!result.sourceChangeIds.length) reasons.push("No changed source is associated with this review unit.");
    for (const sourceId of result.sourceChangeIds) {
      const source = sources.get(sourceId);
      if (!source) {
        reasons.push(`Unknown changed source: ${sourceId}.`);
        continue;
      }
      const evidence = source.documentEvidence;
      if (schemaVersion >= 2 && evidence?.schemaVersion !== schemaVersion) {
        reasons.push(schemaVersion === 2
          ? `Source descriptions must be recollected for ${source.path}; cached evidence does not cover TypeSpec documentation comments.`
          : `Source descriptions must be recollected for ${source.path}; cached evidence does not match v3 effective local and inherited documentation coverage.`);
        continue;
      }
      if (evidence?.status !== "ready") {
        reasons.push(`Compiler @doc context unavailable for ${source.path}: ${
          evidence?.blockers?.map((blocker) => blocker.message).join(" ") || "document evidence was not collected."
        }`);
        continue;
      }
      if (!result.hunkIds.length && !result.declarationIds.length && evidence.documents.length) {
        reasons.push(`No hunk or declaration association establishes documentation scope for ${source.path}.`);
        continue;
      }
      const declarationHunks = (source.declarations ?? [])
        .filter((declaration) => result.declarationIds.includes(declaration.id))
        .flatMap((declaration) => declaration.hunkIds ?? []);
      const scopedHunks = result.hunkIds.length ? result.hunkIds : declarationHunks;
      for (const document of evidence.documents) {
        if (!document.hunkIds.some((hunkId) => scopedHunks.includes(hunkId))) continue;
        if (document.after && document.after.doc.trim().length === 0) continue;
        if (schemaVersion === 3 && document.after?.documentationOrigin === "inherited") {
          (result.inheritedDocumentIds ??= []).push(document.id);
          continue;
        }
        if (document.blocker) {
          reasons.push(`${document.qualifiedName}: ${document.blocker}`);
          continue;
        }
        if (!document.after) continue;
        const { hunkIds: _hunkIds, blocker: _blocker, ...bounded } = document;
        result.documents.push(bounded);
      }
    }
    result.documents = [...new Map(result.documents.map((document) => [document.id, document])).values()]
      .sort((left, right) => left.id.localeCompare(right.id));
    if (result.inheritedDocumentIds) result.inheritedDocumentIds = unique(result.inheritedDocumentIds);
    if (reasons.length) {
      result.status = "blocked";
      result.reason = unique(reasons).join(" ");
      blockers.push({ reviewUnitId: unit.id, reason: result.reason });
    } else if (!result.documents.length) {
      result.status = "not-applicable";
      result.reason = result.inheritedDocumentIds?.length
        ? "Inherited documentation is present; its quality is not reviewed in v1."
        : "No changed, associated nonempty @doc with a current target; absent, deleted, empty, or whitespace-only @doc is outside documentation coverage scope.";
    }
    return result;
  });
  return { schemaVersion, status: blockers.length ? "blocked" : "ready", blockers, reviewUnits };
}

export function buildDocumentQualityInput({ sourceIndex, semantic, schemaVersion = 5 }) {
  return schemaVersion === 4 || schemaVersion === 5
    ? buildCompletenessInput({ sourceIndex, semantic, schemaVersion })
    : buildLegacyDocumentQualityInput({ sourceIndex, semantic, schemaVersion });
}
