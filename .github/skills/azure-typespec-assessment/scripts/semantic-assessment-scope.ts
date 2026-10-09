const VERSION_MATCH_BASES = new Set(["direct-version-governance", "version-transition-change"]);

type SemanticUnit = {
  id: string;
  groupingEvidence?: {
    reasons?: string[];
  };
  declarationNames?: string[];
  operations?: {
    matchBasis: string;
  }[];
  ownedOperationIds?: string[];
};

function hasPublicationReason(unit: SemanticUnit): boolean {
  const reasons = unit.groupingEvidence?.reasons ?? [];
  return (
    reasons.includes("publication") || reasons.includes("cross-project:api-version-publication")
  );
}

export function isInformationalPublicationIntent(unit: SemanticUnit) {
  return hasPublicationReason(unit);
}

export function isApiVersionWideChangeIntent(unit: SemanticUnit) {
  const declarationNames = unit.declarationNames ?? [];
  const operations = unit.operations ?? [];
  return (
    !hasPublicationReason(unit) &&
    operations.length > 0 &&
    (unit.ownedOperationIds?.length ?? 0) === 0 &&
    declarationNames.length > 0 &&
    declarationNames.every((name) => name === "Versions" || name.endsWith(".Versions")) &&
    operations.every((operation) => VERSION_MATCH_BASES.has(operation.matchBasis))
  );
}

export function semanticIntentType(
  unit: SemanticUnit,
): "api-version-publication" | "api-version-wide-change" | "normal" {
  if (hasPublicationReason(unit)) return "api-version-publication";
  if (isApiVersionWideChangeIntent(unit)) return "api-version-wide-change";
  return "normal";
}

export function isInformationalIntent(unit: SemanticUnit) {
  return isApiVersionWideChangeIntent(unit) || isInformationalPublicationIntent(unit);
}

export function partitionSemanticIntents<T extends SemanticUnit>(
  units: T[] | undefined,
): {
  assessed: T[];
  informational: T[];
} {
  const assessed: T[] = [];

  const informational: T[] = [];
  for (const unit of units ?? []) {
    (isInformationalIntent(unit) ? informational : assessed).push(unit);
  }
  return { assessed, informational };
}

export function informationalIntentText(unit: SemanticUnit): {
  reviewUnitId: string;
  title: string;
  summary: string;
} {
  const operationCount = unit.operations?.length ?? 0;
  if (isApiVersionWideChangeIntent(unit)) {
    return {
      reviewUnitId: unit.id,
      title: "Apply an API-version-wide change",
      summary:
        `Covers ${operationCount} affected operations. ` +
        "This API-version-wide intent is reported deterministically and is not used for inference, guideline findings, or breaking-change relationships.",
    };
  }
  return {
    reviewUnitId: unit.id,
    title: "Publish a new API version",
    summary:
      `Carries ${operationCount} existing operations into the new API version. ` +
      "This publication intent is reported deterministically and is not used for inference, guideline findings, or breaking-change relationships.",
  };
}
