const TOKEN_PATTERN = /@?[A-Za-z_][A-Za-z0-9_.]*/g;
const IGNORED_TOKENS = new Set([
  "alias",
  "enum",
  "extends",
  "false",
  "import",
  "interface",
  "is",
  "model",
  "namespace",
  "op",
  "scalar",
  "true",
  "union",
  "using",
]);

/** @param {(string | undefined)[]} values */
function uniqueSorted(values) {
  return [
    ...new Set(values.filter(/** @returns {value is string} */ (value) => value !== undefined)),
  ].sort((left, right) => left.localeCompare(right));
}

/** @param {SourceDeclaration} declaration */
function declarationSymbols(declaration) {
  const decorators = (declaration.decorators ?? []).flatMap((decorator) => {
    if (typeof decorator === "string") return [decorator];
    return [decorator?.name, decorator?.definition].filter(Boolean);
  });
  return [
    ...decorators,
    ...(declaration.compilerEvidence?.referencedNames ?? []),
    ...(declaration.templateArguments ?? []),
    declaration.baseType,
  ];
}

/**
 * @param {SourceChange[]} sources
 * @param {string[]} hunkIds
 */
function changedTokens(sources, hunkIds) {
  const allowed = new Set(hunkIds);
  return uniqueSorted(
    sources
      .flatMap((source) =>
        (source.hunks ?? [])
          .filter((hunk) => allowed.has(hunk.id))
          .flatMap((hunk) =>
            (hunk.lines ?? [])
              .filter((line) => /^[+-](?![+-])/.test(line))
              .flatMap((line) => line.match(TOKEN_PATTERN) ?? []),
          ),
      )
      .filter(
        (token) =>
          !IGNORED_TOKENS.has(token) &&
          (token.startsWith("@") || token.includes(".") || /[A-Z]/.test(token)),
      )
      .slice(0, 80),
  );
}

/**
 * @param {SourceChange[]} sources
 * @param {string[]} hunkIds
 */
function representativeSourceExcerpts(sources, hunkIds) {
  const allowed = new Set(hunkIds);
  return sources
    .flatMap((source) =>
      (source.hunks ?? [])
        .filter((hunk) => allowed.has(hunk.id))
        .map((hunk) => ({
          sourceChangeId: source.id,
          hunkId: hunk.id,
          path: source.path,
          text: (hunk.lines ?? [])
            .filter((line) => /^[+-](?![+-])/.test(line))
            .slice(0, 12)
            .join("\n"),
        })),
    )
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
 * @param {SourceDeclaration[]} declarations
 * @param {string[]} tokens
 */
function categories(declarations, tokens) {
  const kinds = new Set(declarations.map((item) => item.kind?.toLowerCase()));
  const normalizedTokens = new Set(
    tokens.map((token) => (token.replace(/^@/, "").split(".").at(-1) ?? "").toLowerCase()),
  );
  /** @param {string[]} values */
  const hasToken = (...values) => values.some((value) => normalizedTokens.has(value.toLowerCase()));
  const values = [];
  if (
    hasToken(
      "TrackedResource",
      "ProxyResource",
      "TenantResource",
      "ExtensionResource",
      "parentResource",
      "ResourceNameParameter",
    )
  )
    values.push("resource");
  if (
    kinds.has("operation") ||
    kinds.has("interface") ||
    hasToken(
      "ArmResourceOperations",
      "ArmResourceRead",
      "ArmResourceCreateOrReplaceAsync",
      "ArmResourceUpdateAsync",
      "ArmResourceDeleteAsync",
      "ArmResourceListByParent",
      "ArmResourceAction",
      "route",
    )
  ) {
    values.push("operations");
  }
  if (
    hasToken(
      "added",
      "removed",
      "renamedFrom",
      "typeChangedFrom",
      "returnTypeChangedFrom",
      "madeOptional",
    ) ||
    declarations.some((item) => item.qualifiedName?.endsWith(".Versions"))
  ) {
    values.push("versioning");
  }
  if (
    hasToken(
      "useFinalStateVia",
      "pollingOperation",
      "finalOperation",
      "ArmLroLocationHeader",
      "RetryAfterHeader",
    )
  )
    values.push("lro");
  if (hasToken("list", "pageItems", "nextLink", "continuationToken")) values.push("paging");
  if (kinds.has("model") || kinds.has("model-property") || kinds.has("scalar")) {
    values.push("models");
  }
  if (kinds.has("enum") || kinds.has("union")) values.push("enums");
  if (tokens.some((token) => token.startsWith("@"))) values.push("decorators");
  if (hasToken("suppress")) values.push("warnings");
  if (hasToken("client", "clientName", "clientLocation")) values.push("client-customization");
  return uniqueSorted(values.length ? values : ["general"]);
}

/**
 * @param {SemanticReviewUnit} unit
 * @param {SourceChange[]} sources
 */
function materialDeclarations(unit, sources) {
  const allowedHunks = new Set(unit.hunkIds ?? []);
  const preferredRevision = unit.action === "remove" ? "base" : "current";
  const all = sources.flatMap((source) =>
    (source.declarations ?? [])
      .filter(
        (declaration) => declaration.id && declaration.hunkIds?.some((id) => allowedHunks.has(id)),
      )
      .map((declaration) => ({ ...declaration, sourceChangeId: source.id })),
  );
  /** @type {Map<string, SourceDeclaration & {sourceChangeId: string}>} */
  const byIdentity = new Map();
  for (const declaration of all) {
    const key = declaration.qualifiedName ?? declaration.id;
    const existing = byIdentity.get(key);
    if (!existing || declaration.source?.revision === preferredRevision) {
      byIdentity.set(key, declaration);
    }
  }
  return [...byIdentity.values()].sort((left, right) => left.id.localeCompare(right.id));
}

/**
 * @param {{
 *   semanticReviewUnits: SemanticReviewUnit[],
 *   sourceChanges: Record<string, SourceChange>
 * }} options
 */
export function buildComplianceSearchRequests({ semanticReviewUnits, sourceChanges }) {
  return semanticReviewUnits.map((unit) => {
    const sources = unit.sourceChangeIds.map((id) => sourceChanges[id]).filter(Boolean);
    const declarations = materialDeclarations(unit, sources);
    const tokens = changedTokens(sources, unit.hunkIds ?? []);
    const servicePlane = sources.some((source) => /(^|\/)resource-manager(\/|$)/i.test(source.path))
      ? "resource-manager"
      : "data-plane";
    const request = {
      reviewUnitId: unit.id,
      sourceChangeIds: [...unit.sourceChangeIds].sort(),
      hunkIds: [...(unit.hunkIds ?? [])].sort(),
      declarationIds: declarations.map((item) => item.id),
      queryProfile: {
        servicePlane,
        action: unit.action ?? unit.changeKind ?? "modify",
        declarationKinds: uniqueSorted(declarations.map((item) => item.kind)),
        qualifiedNames: uniqueSorted(declarations.map((item) => item.qualifiedName)),
        symbols: uniqueSorted(declarations.flatMap(declarationSymbols)),
        categories: categories(declarations, tokens),
        changedTokens: tokens,
        representativeSourceExcerpts: representativeSourceExcerpts(sources, unit.hunkIds ?? []),
        affectedOperationCount: unit.operations?.length ?? 0,
      },
    };
    return {
      requestId: stableId("compliance-search", request),
      ...request,
    };
  });
}
import { stableId } from "./stable-id.mjs";
/** @typedef {import("./runtime-types.js").SemanticReviewUnit} SemanticReviewUnit */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {import("./runtime-types.js").SourceDeclaration} SourceDeclaration */
