const VERSION_MATCH_BASES = new Set(["direct-version-governance", "version-transition-change"]);

/**
 * @typedef {{
 *   id: string,
 *   groupingEvidence?: {reasons?: string[]},
 *   declarationNames?: string[],
 *   operations?: {matchBasis: string}[],
 *   ownedOperationIds?: string[]
 * }} SemanticUnit
 */

/**
 * @param {SemanticUnit} unit
 * @returns {boolean}
 */
function hasPublicationReason(unit) {
  const reasons = unit.groupingEvidence?.reasons ?? [];
  return (
    reasons.includes("publication") || reasons.includes("cross-project:api-version-publication")
  );
}

/** @param {SemanticUnit} unit */
export function isInformationalPublicationIntent(unit) {
  return hasPublicationReason(unit);
}

/** @param {SemanticUnit} unit */
export function isApiVersionWideChangeIntent(unit) {
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

/**
 * @param {SemanticUnit} unit
 * @returns {"api-version-publication" | "api-version-wide-change" | "normal"}
 */
export function semanticIntentType(unit) {
  if (hasPublicationReason(unit)) return "api-version-publication";
  if (isApiVersionWideChangeIntent(unit)) return "api-version-wide-change";
  return "normal";
}

/** @param {SemanticUnit} unit */
export function isInformationalIntent(unit) {
  return isApiVersionWideChangeIntent(unit) || isInformationalPublicationIntent(unit);
}

/**
 * @template {SemanticUnit} T
 * @param {T[] | undefined} units
 * @returns {{assessed: T[], informational: T[]}}
 */
export function partitionSemanticIntents(units) {
  /** @type {T[]} */
  const assessed = [];
  /** @type {T[]} */
  const informational = [];
  for (const unit of units ?? []) {
    (isInformationalIntent(unit) ? informational : assessed).push(unit);
  }
  return { assessed, informational };
}

/**
 * @param {SemanticUnit} unit
 * @returns {{reviewUnitId: string, title: string, summary: string}}
 */
export function informationalIntentText(unit) {
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
