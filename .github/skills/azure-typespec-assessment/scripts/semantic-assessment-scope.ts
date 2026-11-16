import { hasOnlyApiVersionDeclarations } from "./semantic-change-facts.ts";

const VERSION_MATCH_BASES = new Set(["direct-version-governance", "version-transition-change"]);

type SemanticUnit = {
  id: string;
  intentType?: string;
  groupingEvidence?: {
    reasons?: string[];
  };
  declarationNames?: string[];
  operations?: {
    matchBasis: string;
  }[];
  ownedOperationIds?: string[];
  changeTypes?: string[];
  changeFacts?: { qualifiedName?: string }[];
};

function hasPublicationReason(unit: SemanticUnit): boolean {
  const reasons = unit.groupingEvidence?.reasons ?? [];
  return (
    reasons.includes("publication") || reasons.includes("cross-project:api-version-publication")
  );
}

export function isInformationalPublicationIntent(unit: SemanticUnit) {
  return semanticIntentType(unit) === "api-version-publication";
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
  const versionOnly = unit.changeTypes?.length === 1 && unit.changeTypes[0] === "versioning";
  if (
    hasPublicationReason(unit) &&
    (unit.changeTypes === undefined || (versionOnly && hasOnlyApiVersionDeclarations(unit)))
  ) {
    return "api-version-publication";
  }
  if (isApiVersionWideChangeIntent(unit)) return "api-version-wide-change";
  return "normal";
}

export function semanticGroupingPresentation(unit: SemanticUnit): {
  label: string;
  basis: string;
  notice?: string;
} {
  const type = unit.intentType ?? semanticIntentType(unit);
  const reasons = unit.groupingEvidence?.reasons ?? [];
  const supporting =
    Boolean(unit.changeTypes?.length) &&
    unit.changeTypes?.every((value) =>
      ["sdk-customization", "generation-configuration", "documentation"].includes(value),
    );
  const label =
    type === "api-version-publication"
      ? "API-version publication"
      : type === "api-version-wide-change"
        ? "Shared dependency / version-wide change"
        : supporting
          ? "Supporting change"
          : "Feature / contract change";
  const basis =
    type === "api-version-publication"
      ? "Version-publication grouping"
      : reasons.some((reason) => reason.startsWith("source:"))
        ? "Source-file grouping"
        : reasons.some((reason) => reason.startsWith("feature:"))
          ? "File/name-based grouping"
          : reasons.includes("sdk-compatibility")
            ? "SDK-compatibility grouping"
            : "Operation/transform relationship grouping";
  const names = (unit.changeFacts ?? [])
    .map((fact) => fact.qualifiedName)
    .filter((name): name is string => Boolean(name));
  const versionName = (name: string) => name === "Versions" || name.endsWith(".Versions");
  return {
    label,
    basis,
    ...(type === "normal" && names.some(versionName) && names.some((name) => !versionName(name))
      ? {
          notice:
            "This coarse group includes a version declaration and other facts; it is not a standalone API-version publication.",
        }
      : {}),
  };
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
