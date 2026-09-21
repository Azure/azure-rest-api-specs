import { stableId } from "./stable-id.mjs";
import { createGuidanceRouter } from "./guidance-routing.mjs";
import { referenceServicePlane } from "./reference-category-tags.mjs";

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

function uniqueSorted(values) {
  return [...new Set(values.filter(Boolean))].sort((left, right) =>
    left.localeCompare(right),
  );
}

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
      ),
  );
}

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
      const score = (excerpt) => {
        const compatibilityFile =
          /(?:^|\/)(?:client|back-compatible)\.tsp$/i.test(excerpt.path);
        const substantive =
          /\b(model|interface|op|enum|union|scalar|alias)\b/.test(excerpt.text);
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

function materialDeclarations(unit, sources) {
  const allowedHunks = new Set(unit.hunkIds ?? []);
  const preferredRevision = unit.action === "remove" ? "base" : "current";
  const all = sources.flatMap((source) =>
    (source.declarations ?? [])
      .filter(
        (declaration) =>
          declaration.id &&
          declaration.hunkIds?.some((id) => allowedHunks.has(id)),
      )
      .map((declaration) => ({ ...declaration, sourceChangeId: source.id })),
  );
  const byIdentity = new Map();
  for (const declaration of all) {
    const key = declaration.qualifiedName ?? declaration.id;
    const existing = byIdentity.get(key);
    if (!existing || declaration.source?.revision === preferredRevision) {
      byIdentity.set(key, declaration);
    }
  }
  return [...byIdentity.values()].sort((left, right) =>
    left.id.localeCompare(right.id),
  );
}

export function buildComplianceSearchRequests({
  semanticReviewUnits,
  sourceChanges,
  catalog,
  referenceCategoryDiagnostics = [],
}) {
  const route = createGuidanceRouter(catalog);
  const diagnosticsByUnit = new Map();
  for (const diagnostic of referenceCategoryDiagnostics) {
    const diagnostics = diagnosticsByUnit.get(diagnostic.reviewUnitId) ?? [];
    diagnostics.push(diagnostic);
    diagnosticsByUnit.set(diagnostic.reviewUnitId, diagnostics);
  }
  return semanticReviewUnits.filter((unit) =>
    !["api-version-publication", "api-version-wide-change"].includes(unit.intentType),
  ).map((unit) => {
    const sources = unit.sourceChangeIds
      .map((id) => sourceChanges[id])
      .filter(Boolean);
    const declarations = materialDeclarations(unit, sources);
    const tokens = changedTokens(sources, unit.hunkIds ?? []);
    const annotatedPlanes = uniqueSorted((unit.referenceCategoryEvidence ?? [])
      .flatMap((record) => record.evidence)
      .filter((value) => value.startsWith("service-plane:"))
      .map((value) => value.slice(14)));
    const servicePlane = annotatedPlanes.length === 1
      ? annotatedPlanes[0]
      : referenceServicePlane({ sources, symbols: declarations.flatMap(declarationSymbols).filter((value) => typeof value === "string") });
    const request = {
      reviewUnitId: unit.id,
      sourceChangeIds: [...unit.sourceChangeIds].sort(),
      hunkIds: [...(unit.hunkIds ?? [])].sort(),
      declarationIds: [...(unit.declarationIds ?? [])].sort(),
      referenceCategories: [...(unit.referenceCategories ?? [])],
      queryProfile: {
        servicePlane,
        action: unit.action ?? unit.changeKind ?? "modify",
        declarationKinds: uniqueSorted(declarations.map((item) => item.kind)),
        qualifiedNames: uniqueSorted(
          declarations.map((item) => item.qualifiedName),
        ),
        symbols: uniqueSorted(declarations.flatMap(declarationSymbols)),
        categories: [...(unit.referenceCategories ?? [])],
        changedTokens: tokens,
        representativeSourceExcerpts: representativeSourceExcerpts(
          sources,
          unit.hunkIds ?? [],
        ),
        affectedOperationCount: unit.operations?.length ?? 0,
      },
    };
    request.guidanceRouting = route(unit, request.queryProfile, diagnosticsByUnit.get(unit.id));
    return {
      requestId: stableId("compliance-search", request),
      ...request,
    };
  });
}
