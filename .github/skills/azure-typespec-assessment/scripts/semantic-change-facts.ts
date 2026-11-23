import path from "node:path";
import { stableId } from "./stable-id.ts";

type InternalSemanticUnit = import("./runtime-types.ts").InternalSemanticUnit;
type SemanticChangeFact = import("./runtime-types.ts").SemanticChangeFact;
type SemanticChangeType = import("./runtime-types.ts").SemanticChangeType;
type SourceChange = import("./runtime-types.ts").SourceChange;
type SourceDeclaration = import("./runtime-types.ts").SourceDeclaration;
type SourceIndex = import("./runtime-types.ts").SourceIndex;

function unique(values: (string | undefined)[]) {
  return [...new Set(values.filter((value): value is string => Boolean(value)))].sort();
}

function declarationRevision(declaration: SourceDeclaration) {
  return declaration.source?.revision ?? declaration.revision;
}

function changedText(
  source: SourceChange,
  hunkIds: Set<string>,
  declarations: SourceDeclaration[] = [],
) {
  const ranges = declarations.filter(
    (declaration) =>
      Number.isFinite(declaration.source?.startLine) &&
      Number.isFinite(declaration.source?.endLine),
  );
  const lines: string[] = [];
  for (const hunk of source.hunks ?? []) {
    if (!hunkIds.has(hunk.id)) continue;
    let baseLine = hunk.base?.startLine;
    let currentLine = hunk.current?.startLine;
    for (const line of hunk.lines ?? []) {
      if (/^(?:@@|\\|\+\+\+|---)/.test(line)) continue;
      const added = line.startsWith("+");
      const removed = line.startsWith("-");
      const lineNumber = added ? currentLine : baseLine;
      const revision = added ? "current" : "base";
      if (
        (added || removed) &&
        (!ranges.length ||
          ranges.some(
            (declaration) =>
              declarationRevision(declaration) === revision &&
              lineNumber >= declaration.source.startLine &&
              lineNumber <= declaration.source.endLine,
          ))
      ) {
        lines.push(line.slice(1));
      }
      if (!added) baseLine += 1;
      if (!removed) currentLine += 1;
    }
  }
  return lines.join("\n");
}

function documentationOnly(text: string) {
  const lines = text
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter(Boolean);
  return (
    lines.length > 0 &&
    lines.every(
      (line) =>
        line.startsWith("//") ||
        line.startsWith("/*") ||
        line.startsWith("*") ||
        line.startsWith("*/") ||
        line.startsWith("@doc("),
    )
  );
}

function isApiVersionDeclarationName(name: string) {
  return name === "Versions" || name.endsWith(".Versions");
}

function changeTypeFor({
  source,
  declarations,
  text,
}: {
  source: SourceChange;
  declarations: SourceDeclaration[];
  text: string;
}): SemanticChangeType {
  const baseName = path.basename(source.path ?? "").toLowerCase();
  const names = declarations.map((declaration) => declaration.qualifiedName);
  const kinds = new Set(declarations.map((declaration) => declaration.kind.toLowerCase()));
  if (baseName === "tspconfig.yaml" || baseName === "package.json") {
    return "generation-configuration";
  }
  if (documentationOnly(text)) return "documentation";
  if (names.some(isApiVersionDeclarationName)) return "versioning";
  if (
    ["client.tsp", "back-compatible.tsp"].includes(baseName) ||
    /Azure\.ClientGenerator\.Core|@@(?:alternateType|clientName|access|usage)\b/.test(text)
  ) {
    return "sdk-customization";
  }
  if (kinds.has("operation") || kinds.has("op")) return "operation";
  return "type";
}

function facetsFor(
  text: string,
  unit: InternalSemanticUnit,
  declarations: SourceDeclaration[] = [],
) {
  const facets =
    declarations.length &&
    !declarations.some((declaration) => ["operation", "op"].includes(declaration.kind))
      ? []
      : [...(unit.changedAspects ?? [])];
  if (/@armCommonTypesVersion\b/.test(text)) facets.push("common-type-version");
  if (/@useDependency\b/.test(text)) facets.push("version-dependency");
  if (/@(?:added|removed|renamedFrom)\b/.test(text)) facets.push("version-activation");
  if (/@madeRequired\b/.test(text)) facets.push("requiredness");
  if (/@clientName\b|@@clientName\b/.test(text)) facets.push("public-name");
  if (/@@(?:alternateType|access|usage)\b/.test(text)) facets.push("sdk-mapping");
  if (/\bPage\s*</.test(text) || /@pageItems\b|@nextLink\b/.test(text)) facets.push("paging");
  if (/LongRunning|useFinalStateVia|ArmResourceActionAsync|@extension\b/.test(text)) {
    facets.push("lro");
  }
  if (
    /^[+-]\s*[A-Za-z_]\w*\??\s*:/m.test(
      text
        .split(/\r?\n/)
        .map((line) => `+${line}`)
        .join("\n"),
    )
  ) {
    facets.push("property-contract");
  }
  if (/\?\s*:/.test(text)) facets.push("optionality");
  return unique(facets);
}

function actionFor(before: SourceDeclaration[], after: SourceDeclaration[]) {
  if (!before.length) return "add" as const;
  if (!after.length) return "remove" as const;
  return "modify" as const;
}

export function deriveSemanticChangeFacts(
  unit: InternalSemanticUnit,
  sourceIndex: SourceIndex,
): SemanticChangeFact[] {
  const sourceById = new Map(sourceIndex.sourceChanges.map((source) => [source.id, source]));
  const facts: SemanticChangeFact[] = [];

  for (const sourceChangeId of unit.sourceChangeIds) {
    const source = sourceById.get(sourceChangeId);
    if (!source) continue;
    const unitHunks = new Set(
      (unit.hunkIds ?? []).filter((hunkId) => source.hunks?.some((hunk) => hunk.id === hunkId)),
    );
    if (!unitHunks.size) continue;
    const declarations = (source.declarations ?? []).filter(
      (declaration) =>
        (!unit.declarationIds?.length || unit.declarationIds.includes(declaration.id)) &&
        declaration.hunkIds?.some((hunkId) => unitHunks.has(hunkId)),
    );
    const text = changedText(source, unitHunks);
    const groups = new Map<string, SourceDeclaration[]>();
    for (const declaration of declarations) {
      const key = `${declaration.kind}\0${declaration.qualifiedName}`;
      const values = groups.get(key) ?? [];
      values.push(declaration);
      groups.set(key, values);
    }

    if (!groups.size) {
      const fact = {
        sourceChangeId,
        hunkIds: [...unitHunks].sort(),
        declarationIds: [],
        beforeDeclarationIds: [],
        afterDeclarationIds: [],
        changeType: changeTypeFor({ source, declarations: [], text }),
        action:
          source.status === "added"
            ? ("add" as const)
            : source.status === "removed"
              ? ("remove" as const)
              : ("modify" as const),
        facets: facetsFor(text, unit),
        evidenceRef: {
          artifact: "source/source-index.json" as const,
          sourceChangeId,
          hunkIds: [...unitHunks].sort(),
          declarationIds: [],
        },
      };
      facts.push({ id: stableId("semantic-change", fact), ...fact });
      continue;
    }

    for (const values of groups.values()) {
      const before = values.filter((declaration) => declarationRevision(declaration) === "base");
      const after = values.filter((declaration) => declarationRevision(declaration) === "current");
      const declarationIds = unique(values.map((declaration) => declaration.id));
      const hunkIds = unique(
        values.flatMap((declaration) =>
          declaration.hunkIds?.filter((hunkId) => unitHunks.has(hunkId)),
        ),
      );
      const representative = after[0] ?? before[0] ?? values[0];
      if (!representative) continue;
      const declarationText = changedText(source, new Set(hunkIds), values);
      const fact = {
        sourceChangeId,
        hunkIds,
        declarationIds,
        beforeDeclarationIds: unique(before.map((declaration) => declaration.id)),
        afterDeclarationIds: unique(after.map((declaration) => declaration.id)),
        changeType: changeTypeFor({ source, declarations: values, text: declarationText }),
        declarationKind: representative.kind,
        qualifiedName: representative.qualifiedName,
        action: actionFor(before, after),
        facets: facetsFor(declarationText, unit, values),
        evidenceRef: {
          artifact: "source/source-index.json" as const,
          sourceChangeId,
          hunkIds,
          declarationIds,
        },
      };
      facts.push({ id: stableId("semantic-change", fact), ...fact });
    }
  }

  return [...new Map(facts.map((fact) => [fact.id, fact])).values()].sort((left, right) =>
    left.id.localeCompare(right.id),
  );
}

export function attachSemanticChangeFacts(unit: InternalSemanticUnit, sourceIndex: SourceIndex) {
  const changeFacts = deriveSemanticChangeFacts(unit, sourceIndex);
  unit.classificationVersion = 3;
  unit.changeFacts = changeFacts;
  unit.changeTypes = unique(changeFacts.map((fact) => fact.changeType)) as SemanticChangeType[];
  return unit;
}

export function hasOnlyApiVersionDeclarations(unit: {
  declarationNames?: string[];
  changeFacts?: { qualifiedName?: string }[];
}) {
  const factNames = (unit.changeFacts ?? []).map((fact) => fact.qualifiedName);
  if (factNames.some(Boolean)) {
    return factNames.every((name) => typeof name === "string" && isApiVersionDeclarationName(name));
  }
  const names = unit.declarationNames ?? [];
  return names.length > 0 && names.every(isApiVersionDeclarationName);
}

export function isVersionGovernanceOnly(unit: InternalSemanticUnit) {
  const facts = unit.changeFacts ?? [];
  return (
    facts.length > 0 &&
    facts.every((fact) => fact.changeType === "versioning") &&
    hasOnlyApiVersionDeclarations(unit)
  );
}
