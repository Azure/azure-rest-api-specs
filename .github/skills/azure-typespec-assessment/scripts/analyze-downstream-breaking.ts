import path from "node:path";
import { isMain, isRecord, parseArgs, readJsonObject, runMain, writeJson } from "./cli.ts";
import { typeIdentity } from "./sdk-method-delta.ts";
import { canonicalJson, stableId } from "./stable-id.ts";
import { normalizeTcgcContract } from "./tcgc-contract.ts";

type ArtifactComparison = import("./runtime-types.ts").ArtifactComparison;

type AssessmentFact = import("./runtime-types.ts").AssessmentFact;

type DownstreamAnalysis = import("./runtime-types.ts").DownstreamAnalysis;

type DownstreamCandidate = import("./runtime-types.ts").DownstreamCandidate;

type DownstreamRootCause = import("./runtime-types.ts").DownstreamRootCause;

type NormalizedTcgcContract = import("./runtime-types.ts").NormalizedTcgcContract;

type NormalizedTcgcMethod = import("./runtime-types.ts").NormalizedTcgcMethod;

type NormalizedTcgcNamedType = import("./runtime-types.ts").NormalizedTcgcNamedType;

type NormalizedTcgcParameter = import("./runtime-types.ts").NormalizedTcgcParameter;

type NormalizedTcgcType = import("./runtime-types.ts").NormalizedTcgcType;

type PreparationBlocker = import("./runtime-types.ts").PreparationBlocker;

type PreparationManifest = import("./runtime-types.ts").PreparationManifest;

type PreparationProject = import("./runtime-types.ts").PreparationProject;

type SourceChange = import("./runtime-types.ts").SourceChange;

type SourceDeclaration = import("./runtime-types.ts").SourceDeclaration;

type SourceIndex = import("./runtime-types.ts").SourceIndex;

type TcgcArtifact = import("./runtime-types.ts").TcgcArtifact;

type DownstreamEvidence = {
  sourceChangeIds: string[];
  declarationIds: string[];
  declarations: SourceDeclaration[];
  sources: SourceChange[];
  artifactComparison?: ArtifactComparison;
};

type DownstreamValue =
  | NormalizedTcgcMethod
  | NormalizedTcgcNamedType
  | NormalizedTcgcContract["clients"][number]
  | Record<string, unknown>;

type CandidateDetail = {
  name?: string;
  before?: unknown;
  after?: unknown;
  values?: unknown[];
};

type ReferenceGraph = {
  projectId: string;
  comparisonRole: "baseline" | "target";
  nodes: Map<string, ReferenceNode>;
  reverse: Map<string, ReferenceEdge[]>;
  ensureFact: (key: string) => string | undefined;
};
type ReferenceNode = {
  key: string;
  factKind: string;
  value: DownstreamValue;
  factId?: string;
};
type ReferenceEdge = {
  from: string;
  to: string;
  kind: string;
  memberName?: string;
  location?: string;
};

function stringField(value: unknown, field: string) {
  if (!isRecord(value)) return undefined;
  const item = value[field];
  return typeof item === "string" ? item : undefined;
}

function isPreparationManifest(value: unknown): value is PreparationManifest {
  return (
    isRecord(value) &&
    Array.isArray(value.projects) &&
    value.projects.every(
      (project) =>
        isRecord(project) &&
        typeof project.id === "string" &&
        Array.isArray(project.sourceChangeIds) &&
        isRecord(project.artifacts),
    )
  );
}

function isSourceIndex(value: unknown): value is SourceIndex {
  return (
    isRecord(value) &&
    Array.isArray(value.sourceChanges) &&
    value.sourceChanges.every(
      (sourceChange) =>
        isRecord(sourceChange) &&
        typeof sourceChange.id === "string" &&
        Array.isArray(sourceChange.declarations),
    )
  );
}

function readPreparationManifest(file: string): PreparationManifest {
  const value = readJsonObject(file);
  if (!isPreparationManifest(value)) {
    throw new TypeError(`Expected a preparation manifest in ${file}.`);
  }
  return value;
}

function readSourceIndex(file: string): SourceIndex {
  const value = readJsonObject(file);
  if (!isSourceIndex(value)) {
    throw new TypeError(`Expected a source index in ${file}.`);
  }
  return value;
}

function textValue(value: unknown) {
  return typeof value === "string" || typeof value === "number" || typeof value === "boolean"
    ? String(value)
    : canonicalJson(value);
}

function loadInputs(options: {
  manifest: string | PreparationManifest;
  manifestPath?: string;
  workRoot?: string;
  sourceIndex?: SourceIndex;
  output?: string;
}) {
  const manifestPath =
    typeof options.manifest === "string" ? path.resolve(options.manifest) : undefined;
  const workRoot = path.resolve(
    options.workRoot ?? (manifestPath ? path.dirname(manifestPath) : process.cwd()),
  );
  const manifest =
    typeof options.manifest === "string"
      ? readPreparationManifest(path.resolve(options.manifest))
      : options.manifest;
  return {
    workRoot,
    manifest,
    sourceIndex:
      options.sourceIndex ?? readSourceIndex(path.join(workRoot, "source", "source-index.json")),
  };
}

function artifactReady(
  artifact:
    | (TcgcArtifact & {
        status?: string;
      })
    | undefined,
) {
  return (
    artifact && (!artifact.status || artifact.status === "succeeded") && artifact.files?.length
  );
}

function evidence(project: PreparationProject, sourceIndex: SourceIndex): DownstreamEvidence {
  const sourceById = new Map(sourceIndex.sourceChanges.map((item) => [item.id, item]));
  const sourceChangeIds = (project.sourceChangeIds ?? []).filter((id) => sourceById.has(id)).sort();
  const sources = sourceChangeIds.flatMap((id) => {
    const source = sourceById.get(id);
    return source ? [source] : [];
  });
  const declarations = sources.flatMap((item) => item.declarations);
  return {
    sourceChangeIds,
    declarationIds: declarations
      .map((item) => item.id)
      .filter(Boolean)
      .sort(),
    declarations,
    sources,
  };
}

function candidateEvidence(
  source: DownstreamEvidence,
  symbol: string,
  before: DownstreamValue | undefined,
  after: DownstreamValue | undefined,
  kind: string,
  detail: CandidateDetail | undefined,
) {
  const names: Set<string> = new Set();

  const memberNames: Set<string> = new Set();

  const addName = (value: unknown) => {
    if (typeof value === "string" && value.trim()) names.add(value.trim());
  };
  for (const value of [symbol, before, after]) {
    if (typeof value === "string") {
      addName(value);
      continue;
    }
    if (!isRecord(value)) continue;
    addName(value.identity);
    addName(value.crossLanguageDefinitionId);
    addName(value.name);
    if (
      kind === "method" &&
      typeof value.clientName === "string" &&
      typeof value.name === "string"
    ) {
      addName(`${value.clientName}.${value.name}`);
    }
  }
  if (detail?.name) {
    for (const value of [
      symbol,
      stringField(before, "identity"),
      stringField(before, "name"),
      stringField(after, "identity"),
      stringField(after, "name"),
    ]) {
      if (value) memberNames.add(`${value}.${detail.name}`);
    }
  }

  const matchesName = (qualifiedName: string, expectedNames: Set<string>) => {
    if (!qualifiedName) return false;
    return [...expectedNames].some(
      (name) =>
        qualifiedName === name ||
        qualifiedName.endsWith(`.${name}`) ||
        name.endsWith(`.${qualifiedName}`),
    );
  };
  let declarations = source.declarations.filter((item) =>
    matchesName(item.qualifiedName, memberNames.size ? memberNames : names),
  );
  if (!declarations.length && memberNames.size) {
    declarations = source.declarations.filter((item) => matchesName(item.qualifiedName, names));
  }
  if (!declarations.length) {
    return {
      sourceChangeIds: source.sources.length === 1 ? [source.sources[0].id] : [],
      declarationIds: [],
      hunkIds: [],
    };
  }
  const declarationIds = new Set(declarations.map((item) => item.id).filter(Boolean));
  return {
    sourceChangeIds: source.sources
      .filter((item) =>
        (item.declarations ?? []).some((declaration) => declarationIds.has(declaration.id)),
      )
      .map((item) => item.id)
      .sort(),
    declarationIds: [...declarationIds].sort(),
    hunkIds: [...new Set(declarations.flatMap((item) => item.hunkIds ?? []))].sort(),
  };
}

function addFact(
  facts: Record<string, AssessmentFact>,
  projectId: string,
  comparisonRole: "baseline" | "target",
  kind: string,
  value: DownstreamValue,
  artifactComparison: ArtifactComparison | undefined,
) {
  const selection = artifactComparison?.[comparisonRole];
  const fact = Object.assign(
    {} as AssessmentFact,
    {
      projectId,
      comparisonRole,
      sourceRevision:
        selection?.sourceRevision ?? (comparisonRole === "baseline" ? "base" : "current"),
      sourceCommit: selection?.commit,
      apiVersion: selection?.apiVersion,
      factKind: kind,
    },
    value,
  );
  const operation = kind === "method" ? (value as NormalizedTcgcMethod).operation : undefined;
  // Response headers are new graph evidence, not part of the established fact identity.
  const identityFact = operation
    ? {
        ...fact,
        operation: {
          ...operation,
          responses: (operation.responses ?? []).map((response) => {
            const bounded = { ...response };
            delete bounded.headers;
            return bounded;
          }),
          exceptions: (operation.exceptions ?? []).map((response) => {
            const bounded = { ...response };
            delete bounded.headers;
            return bounded;
          }),
        },
      }
    : fact;
  const id = stableId("sdk-fact", identityFact);
  facts[id] = { ...fact, id };
  return id;
}

function same(left: unknown, right: unknown) {
  return left === undefined || right === undefined
    ? left === right
    : canonicalJson(left) === canonicalJson(right);
}

function unique(values: (string | undefined)[]): string[] {
  return [...new Set(values.filter((value) => value !== undefined))].sort();
}

function normalizedParameterTypeContract(type: NormalizedTcgcType | undefined): unknown {
  if (!type) return typeIdentity(type);
  switch (type.kind) {
    case "array":
      return {
        kind: "array",
        valueType: normalizedParameterTypeContract(type.valueType),
      };
    case "dictionary":
    case "dict":
      return {
        kind: "dictionary",
        keyType: normalizedParameterTypeContract(type.keyType),
        valueType: normalizedParameterTypeContract(type.valueType),
      };
    case "tuple":
      return {
        kind: "tuple",
        valueTypes: (type.valueTypes ?? []).map(normalizedParameterTypeContract),
      };
    case "nullable":
      return {
        kind: "nullable",
        type: normalizedParameterTypeContract(type.type),
      };
    default:
      return typeIdentity(type);
  }
}

function normalizedPublicParameterContract(parameters: NormalizedTcgcParameter[]) {
  return parameters
    .filter((parameter) => parameter.type?.kind !== "constant")
    .map((parameter) => ({
      name: parameter.name,
      optional: Boolean(parameter.optional),
      onClient: Boolean(parameter.onClient),
      isApiVersionParam: Boolean(parameter.isApiVersionParam),
      type: normalizedParameterTypeContract(parameter.type),
    }));
}

function unknownField(value: unknown, field: string): unknown {
  return isRecord(value) ? value[field] : undefined;
}

function normalizedSemanticLroContract(lro: unknown) {
  if (!lro) return undefined;
  const operationValue = unknownField(lro, "operation");
  const operation = operationValue
    ? {
        kind: unknownField(operationValue, "kind"),
        path: unknownField(operationValue, "path"),
        verb: unknownField(operationValue, "verb"),
      }
    : undefined;
  return {
    finalStateVia: unknownField(lro, "finalStateVia"),
    pollingStep: unknownField(lro, "pollingStep"),
    finalStep: unknownField(lro, "finalStep"),
    statusMonitorStep: unknownField(lro, "statusMonitorStep"),
    operation,
    logicalResult: unknownField(lro, "logicalResult"),
    pollingInfo: unknownField(lro, "pollingInfo"),
    envelopeResult: unknownField(lro, "envelopeResult"),
    finalEnvelopeResult: unknownField(lro, "finalEnvelopeResult"),
    finalResult: unknownField(lro, "finalResult"),
    logicalPath: unknownField(lro, "logicalPath"),
    finalResultPath: unknownField(lro, "finalResultPath"),
    finalResponse: unknownField(lro, "finalResponse"),
  };
}

function severity(rule: string): "high" | "medium" {
  return ["method-paging-changed", "method-lro-changed", "customization-changed"].includes(rule)
    ? "medium"
    : "high";
}

function candidateText(rule: string, symbol: string, detail: CandidateDetail | undefined) {
  let actual;
  switch (rule) {
    case "method-removed":
      actual = `${symbol} is no longer generated.`;
      break;
    case "method-identity-changed":
      actual = `${symbol} changed its generated SDK method name or identity.`;
      break;
    case "method-location-changed":
      actual = `${symbol} moved to a different client.`;
      break;
    case "method-kind-changed":
      actual = `${symbol} changed method kind${
        detail ? ` from ${textValue(detail.before)} to ${textValue(detail.after)}` : ""
      }.`;
      break;
    case "method-parameters-changed":
      actual = `${symbol} has a different ordered public parameter list.`;
      break;
    case "method-response-changed":
      actual = `${symbol} has a different response type.`;
      break;
    case "method-access-changed":
      actual = `${symbol} is no longer public.`;
      break;
    case "method-paging-changed":
      actual = `${symbol} changed paging behavior.`;
      break;
    case "method-lro-changed":
      actual = `${symbol} changed long-running behavior.`;
      break;
    case "model-property-removed":
      actual = `${symbol} no longer exposes property ${detail?.name}.`;
      break;
    case "model-property-changed":
      actual = `${symbol}.${detail?.name} changed type, optionality, flattening, or access.`;
      break;
    case "model-property-added-required":
      actual = `${symbol} added required property ${detail?.name}.`;
      break;
    case "model-hierarchy-changed":
      actual = `${symbol} changed its base model or discriminator hierarchy.`;
      break;
    case "enum-values-removed":
      actual = `${symbol} removed enum values: ${(detail?.values ?? []).join(", ")}.`;
      break;
    case "enum-extensibility-changed":
      actual = `${symbol} changed enum extensibility.`;
      break;
    case "public-surface-changed":
      actual = `${symbol} changed public access, usage, or reachability.`;
      break;
    case "client-location-changed":
      actual = `${symbol} changed client ownership or name.`;
      break;
    case "customization-changed":
      actual = `${symbol} changed SDK customization decorators.`;
      break;
    default:
      throw new Error(`Unsupported downstream rule: ${rule}`);
  }
  return {
    actual,
    expected: `${symbol} preserves its existing language-neutral generated SDK contract.`,
  };
}

function pushCandidate(
  candidates: DownstreamCandidate[],
  facts: Record<string, AssessmentFact>,
  source: DownstreamEvidence,
  projectId: string,
  rule: string,
  symbol: string,
  before: DownstreamValue | undefined,
  after: DownstreamValue | undefined,
  kind: string,
  detail?: CandidateDetail,
) {
  const beforeFactId = before
    ? addFact(facts, projectId, "baseline", kind, before, source.artifactComparison)
    : undefined;
  const afterFactId = after
    ? addFact(facts, projectId, "target", kind, after, source.artifactComparison)
    : undefined;
  const text = candidateText(rule, symbol, detail);
  const ownership = candidateEvidence(source, symbol, before, after, kind, detail);

  const candidate: Omit<DownstreamCandidate, "id"> = {
    rule,
    defaultSeverity: severity(rule),
    actual: text.actual,
    expected: text.expected,
    crossLanguageDefinitionId: symbol,
    sourceChangeIds: ownership.sourceChangeIds,
    declarationIds: ownership.declarationIds,
    hunkIds: ownership.hunkIds,
    evidenceFactIds: [beforeFactId, afterFactId].filter((id) => id !== undefined),
    reviewRequired: true,
  };
  candidates.push({ id: stableId("downstream", candidate), ...candidate });
}

function compareMethods(
  projectId: string,
  base: NormalizedTcgcContract,
  current: NormalizedTcgcContract,
  source: DownstreamEvidence,
  facts: Record<string, AssessmentFact>,
  candidates: DownstreamCandidate[],
) {
  const currentMethods = new Map(current.methods.map((item) => [item.identity, item]));

  const currentByHttp: Map<string, NormalizedTcgcMethod[]> = new Map();
  for (const method of current.methods) {
    const protocol = method.operation;
    if (!protocol?.verb || !protocol?.path) continue;
    const key = `${protocol.verb}\u0000${protocol.path}`;
    const values = currentByHttp.get(key) ?? [];
    values.push(method);
    currentByHttp.set(key, values);
  }
  for (const before of base.methods) {
    let after = currentMethods.get(before.identity);
    if (!after && before.operation?.verb && before.operation?.path) {
      const matches =
        currentByHttp.get(`${before.operation.verb}\u0000${before.operation.path}`) ?? [];
      if (matches.length === 1) after = matches[0];
    }
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (!after) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-removed",
        symbol,
        before,
        undefined,
        "method",
      );
      continue;
    }
    if (before.identity !== after.identity || before.name !== after.name) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-identity-changed",
        symbol,
        before,
        after,
        "method",
      );
    }
    if (before.client !== after.client) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-location-changed",
        symbol,
        before,
        after,
        "method",
      );
    }
    if (before.kind !== after.kind) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-kind-changed",
        symbol,
        before,
        after,
        "method",
        { before: before.kind, after: after.kind },
      );
    }
    if (
      !same(
        normalizedPublicParameterContract(before.parameters),
        normalizedPublicParameterContract(after.parameters),
      )
    ) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-parameters-changed",
        symbol,
        before,
        after,
        "method",
      );
    }
    if (!same(before.responseType, after.responseType)) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-response-changed",
        symbol,
        before,
        after,
        "method",
      );
    }
    if (before.access === "public" && after.access !== "public") {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-access-changed",
        symbol,
        before,
        after,
        "method",
      );
    }
    if (!same(before.paging, after.paging)) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-paging-changed",
        symbol,
        before,
        after,
        "method",
      );
    }
    if (
      !same(normalizedSemanticLroContract(before.lro), normalizedSemanticLroContract(after.lro))
    ) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-lro-changed",
        symbol,
        before,
        after,
        "method",
      );
    }
  }
}

function compareModels(
  projectId: string,
  base: NormalizedTcgcContract,
  current: NormalizedTcgcContract,
  source: DownstreamEvidence,
  facts: Record<string, AssessmentFact>,
  candidates: DownstreamCandidate[],
) {
  const currentModels = new Map(current.models.map((item) => [item.identity, item]));
  for (const before of base.models.filter((item) => item.reachable)) {
    const after = currentModels.get(before.identity);
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (!after) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "public-surface-changed",
        symbol,
        before,
        undefined,
        "model",
      );
      continue;
    }
    if (
      before.access !== after.access ||
      before.usage !== after.usage ||
      before.reachable !== after.reachable
    ) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "public-surface-changed",
        symbol,
        before,
        after,
        "model",
      );
    }
    if (
      !same(before.baseModel, after.baseModel) ||
      !same(before.discriminatorProperty, after.discriminatorProperty) ||
      !same(before.discriminatorValue, after.discriminatorValue) ||
      !same(before.discriminatedSubtypes, after.discriminatedSubtypes)
    ) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "model-hierarchy-changed",
        symbol,
        before,
        after,
        "model",
      );
    }
    const afterProperties = new Map((after.properties ?? []).map((item) => [item.name, item]));
    const beforeProperties = new Set((before.properties ?? []).map((item) => item.name));
    for (const property of before.properties ?? []) {
      const currentProperty = afterProperties.get(property.name);
      if (!currentProperty) {
        pushCandidate(
          candidates,
          facts,
          source,
          projectId,
          "model-property-removed",
          symbol,
          before,
          after,
          "model",
          { name: property.name },
        );
      } else if (canonicalJson(property) !== canonicalJson(currentProperty)) {
        pushCandidate(
          candidates,
          facts,
          source,
          projectId,
          "model-property-changed",
          symbol,
          before,
          after,
          "model",
          { name: property.name },
        );
      }
    }
    for (const property of after.properties ?? []) {
      if (!beforeProperties.has(property.name) && !property.optional) {
        pushCandidate(
          candidates,
          facts,
          source,
          projectId,
          "model-property-added-required",
          symbol,
          before,
          after,
          "model",
          { name: property.name },
        );
      }
    }
  }
}

function compareEnums(
  projectId: string,
  base: NormalizedTcgcContract,
  current: NormalizedTcgcContract,
  source: DownstreamEvidence,
  facts: Record<string, AssessmentFact>,
  candidates: DownstreamCandidate[],
) {
  const currentEnums = new Map(current.enums.map((item) => [item.identity, item]));
  for (const before of base.enums.filter((item) => item.reachable)) {
    if (before.name === "Versions" || before.identity.endsWith(".Versions")) continue;
    const after = currentEnums.get(before.identity);
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (!after) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "public-surface-changed",
        symbol,
        before,
        undefined,
        "enum",
      );
      continue;
    }
    const currentValues = new Set((after.values ?? []).map((item) => canonicalJson(item)));
    const removed = (before.values ?? []).filter((item) => !currentValues.has(canonicalJson(item)));
    if (removed.length) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "enum-values-removed",
        symbol,
        before,
        after,
        "enum",
        { values: removed.map((item) => item.name ?? item.value) },
      );
    }
    if (before.isFixed !== after.isFixed || before.isUnionAsEnum !== after.isUnionAsEnum) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "enum-extensibility-changed",
        symbol,
        before,
        after,
        "enum",
      );
    }
    if (
      before.access !== after.access ||
      before.usage !== after.usage ||
      before.reachable !== after.reachable
    ) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "public-surface-changed",
        symbol,
        before,
        after,
        "enum",
      );
    }
  }
}

function compareUnions(
  projectId: string,
  base: NormalizedTcgcContract,
  current: NormalizedTcgcContract,
  source: DownstreamEvidence,
  facts: Record<string, AssessmentFact>,
  candidates: DownstreamCandidate[],
) {
  const currentUnions = new Map(current.unions.map((item) => [item.identity, item]));
  for (const before of base.unions.filter((item) => item.reachable)) {
    const after = currentUnions.get(before.identity);
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (!after || canonicalJson(before) !== canonicalJson(after)) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "public-surface-changed",
        symbol,
        before,
        after,
        "union",
      );
    }
  }
}

function compareClients(
  projectId: string,
  base: NormalizedTcgcContract,
  current: NormalizedTcgcContract,
  source: DownstreamEvidence,
  facts: Record<string, AssessmentFact>,
  candidates: DownstreamCandidate[],
) {
  const currentClients = new Map(current.clients.map((item) => [item.identity, item]));
  for (const before of base.clients) {
    const after = currentClients.get(before.identity);
    if (!after) continue;
    if (
      before.name !== after.name ||
      before.owner !== after.owner ||
      before.parent !== after.parent
    ) {
      const symbol = before.crossLanguageDefinitionId ?? before.identity;
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "client-location-changed",
        symbol,
        before,
        after,
        "client",
      );
    }
  }
}

function compareCustomizations(
  projectId: string,
  source: DownstreamEvidence,
  facts: Record<string, AssessmentFact>,
  candidates: DownstreamCandidate[],
) {
  const relevant =
    /^@@?(?:(?:Azure\.)?ClientGenerator\.Core(?:\.Legacy)?\.)?(clientName|flattenProperty|clientLocation|override)\b/;

  const byDeclaration: Map<
    string,
    {
      base?: string[];
      current?: string[];
      declaration?: SourceDeclaration;
    }
  > = new Map();
  for (const declaration of source.declarations) {
    const selected = (declaration.decorators ?? [])
      .filter((item) => typeof item === "string")
      .filter((item) => relevant.test(item))
      .sort();
    if (!selected.length) continue;
    const record = byDeclaration.get(declaration.qualifiedName) ?? {};
    record[declaration.source?.revision ?? "current"] = selected;
    record.declaration = declaration;
    byDeclaration.set(declaration.qualifiedName, record);
  }
  for (const [name, record] of byDeclaration) {
    if (canonicalJson(record.base ?? []) === canonicalJson(record.current ?? [])) continue;
    const before = { symbol: name, decorators: record.base ?? [] };
    const after = { symbol: name, decorators: record.current ?? [] };
    pushCandidate(
      candidates,
      facts,
      source,
      projectId,
      "customization-changed",
      name,
      before,
      after,
      "customization",
    );
  }
}

function factRole(fact: AssessmentFact | undefined) {
  return (
    fact?.comparisonRole ??
    (fact?.revision === "base" ? "baseline" : fact?.revision === "current" ? "target" : undefined)
  );
}

function referencedTypeNames(
  value: unknown,
  names: Set<string> = new Set(),
  seen: WeakSet<object> = new WeakSet(),
): Set<string> {
  if (!value || typeof value !== "object" || seen.has(value)) return names;
  seen.add(value);
  const identity = typeIdentity(value);
  if (identity) names.add(identity);
  for (const [key, child] of Object.entries(value)) {
    if (["id", "projectId", "sourceCommit", "operation", "httpOperation"].includes(key)) continue;
    if (Array.isArray(child)) child.forEach((item) => referencedTypeNames(item, names, seen));
    else referencedTypeNames(child, names, seen);
  }
  return names;
}

function parameterLocation(method: NormalizedTcgcMethod, parameter: NormalizedTcgcParameter) {
  const protocolParameters = [
    ...(method.operation?.parameters ?? []),
    ...(method.operation?.bodyParam ? [method.operation.bodyParam] : []),
  ];
  const matches = protocolParameters.filter((item) => {
    const segments = (item.methodParameterSegments ?? []).flat(Infinity).map(String);
    return (
      item.name === parameter.name ||
      item.crossLanguageDefinitionId === parameter.crossLanguageDefinitionId ||
      (parameter.name !== undefined && segments.includes(parameter.name)) ||
      (parameter.crossLanguageDefinitionId !== undefined &&
        segments.includes(parameter.crossLanguageDefinitionId))
    );
  });
  const kinds = new Set(matches.map((item) => item.kind));
  if (kinds.size !== 1) return undefined;
  const [kind] = kinds;
  return typeof kind === "string" && ["path", "query", "header", "body"].includes(kind)
    ? `request-${kind}`
    : undefined;
}

function buildReferenceGraph(
  projectId: string,
  comparisonRole: "baseline" | "target",
  contract: NormalizedTcgcContract,
  source: DownstreamEvidence,
  facts: Record<string, AssessmentFact>,
): ReferenceGraph {
  const nodes: Map<string, ReferenceNode> = new Map();

  const reverse: Map<string, ReferenceEdge[]> = new Map();

  const reverseKeys: Map<string, Set<string>> = new Map();

  const addNode = (key: string, factKind: string, value: DownstreamValue) => {
    nodes.set(key, { key, factKind, value, factId: undefined });
  };
  for (const method of contract.methods.filter((item) => item.access === "public")) {
    addNode(`method:${method.identity}`, "method", method);
  }

  const namedTypes: ["model" | "enum" | "union", NormalizedTcgcNamedType[]][] = [
    ["model", contract.models],
    ["enum", contract.enums],
    ["union", contract.unions],
  ];
  for (const [factKind, values] of namedTypes) {
    for (const value of values) addNode(`type:${value.identity}`, factKind, value);
  }

  const addEdge = (
    from: string,
    targetIdentity: string,
    detail: Omit<ReferenceEdge, "from" | "to">,
  ) => {
    const to = `type:${targetIdentity}`;
    if (!nodes.has(from) || !nodes.has(to)) return;
    const edge = { from, to, ...detail };
    const values = reverse.get(to) ?? [];
    const keys = reverseKeys.get(to) ?? new Set();
    const edgeKey = canonicalJson(edge);
    if (!keys.has(edgeKey)) {
      keys.add(edgeKey);
      values.push(edge);
      reverse.set(to, values);
      reverseKeys.set(to, keys);
    }
  };

  const addTypeEdges = (
    from: string,
    value: unknown,
    detail: Omit<ReferenceEdge, "from" | "to">,
  ) => {
    for (const identity of referencedTypeNames(value)) {
      addEdge(from, identity, detail);
    }
  };
  for (const method of contract.methods.filter((item) => item.access === "public")) {
    const from = `method:${method.identity}`;
    for (const parameter of method.parameters) {
      addTypeEdges(from, parameter.type, {
        kind: "parameter",
        memberName: parameter.name,
        location: parameterLocation(method, parameter),
      });
    }
    addTypeEdges(from, method.responseType, {
      kind: "response",
      location: "response-body",
    });
    addTypeEdges(from, method.paging, {
      kind: "paging-item",
      location: "response-body",
    });
    addTypeEdges(from, method.lro, {
      kind: "lro-result",
      location: "response-body",
    });
    for (const response of method.operation?.responses ?? []) {
      for (const header of response.headers ?? []) {
        addTypeEdges(from, header.type, {
          kind: "response-header",
          memberName: stringField(header, "serializedName") ?? header.name,
          location: "response-header",
        });
      }
    }
  }
  for (const model of contract.models) {
    const from = `type:${model.identity}`;
    for (const property of model.properties ?? []) {
      addTypeEdges(from, property.type, {
        kind: "property",
        memberName: property.name,
      });
    }
    if (model.baseModel) addEdge(from, model.baseModel, { kind: "base-model" });
    addTypeEdges(from, model.additionalProperties, {
      kind: "additional-properties",
    });
    for (const subtype of model.discriminatedSubtypes ?? []) {
      if (subtype.type) {
        addEdge(from, subtype.type, {
          kind: "discriminated-subtype",
          memberName: subtype.name,
        });
      }
    }
  }
  for (const item of contract.enums) {
    addTypeEdges(`type:${item.identity}`, item.valueType, {
      kind: "enum-value-type",
    });
  }
  for (const item of contract.unions) {
    const from = `type:${item.identity}`;
    addTypeEdges(from, item.type, { kind: "union-value" });
    addTypeEdges(from, item.variantTypes, { kind: "union-variant" });
    addTypeEdges(from, item.discriminatedOptions, {
      kind: "union-variant",
    });
  }

  const ensureFact = (key: string) => {
    const node = nodes.get(key);
    if (!node) return undefined;
    node.factId ??= addFact(
      facts,
      projectId,
      comparisonRole,
      node.factKind,
      node.value,
      source.artifactComparison,
    );
    return node.factId;
  };
  return { projectId, comparisonRole, nodes, reverse, ensureFact };
}

function shortestMethodPaths(graph: ReferenceGraph, typeName: string) {
  const start = `type:${typeName}`;
  if (!graph.nodes.has(start)) return [];

  const queue: {
    key: string;
    path: ReferenceEdge[];
  }[] = [{ key: start, path: [] }];
  const visited = new Set([start]);

  const results: {
    methodKey: string;
    location?: string;
    path: ReferenceEdge[];
  }[] = [];
  for (let index = 0; index < queue.length; index += 1) {
    const current = queue[index];
    for (const edge of graph.reverse.get(current.key) ?? []) {
      const path = [edge, ...current.path];
      if (edge.from.startsWith("method:")) {
        const location = path.find((item) => item.location)?.location;
        results.push({
          methodKey: edge.from,
          location,
          path: path.map((item) => ({
            ...item,
            location: item.location ?? location,
          })),
        });
        continue;
      }
      if (visited.has(edge.from)) continue;
      visited.add(edge.from);
      queue.push({ key: edge.from, path });
    }
  }
  return results;
}

function buildRootCauses(
  candidates: DownstreamCandidate[],
  facts: Record<string, AssessmentFact>,
  graphs: ReferenceGraph[],
): DownstreamRootCause[] {
  const candidateFact = (candidate: DownstreamCandidate, role: "baseline" | "target") =>
    candidate.evidenceFactIds.map((id) => facts[id]).find((fact) => factRole(fact) === role);
  const methodCandidates = candidates.filter((candidate) => {
    const factKind = (candidateFact(candidate, "target") ?? candidateFact(candidate, "baseline"))
      ?.factKind;
    return typeof factKind === "string" && ["method", "client", "customization"].includes(factKind);
  });
  const typeCandidates = candidates.filter((candidate) => {
    const factKind = (candidateFact(candidate, "target") ?? candidateFact(candidate, "baseline"))
      ?.factKind;
    return typeof factKind === "string" && ["model", "enum", "union"].includes(factKind);
  });

  const roots: DownstreamRootCause[] = [];

  const byMethod: Map<string, DownstreamCandidate[]> = new Map();
  for (const candidate of methodCandidates) {
    const fact = candidateFact(candidate, "target") ?? candidateFact(candidate, "baseline");
    const key = `${fact?.projectId ?? ""}:${candidate.crossLanguageDefinitionId}`;
    const values = byMethod.get(key) ?? [];
    values.push(candidate);
    byMethod.set(key, values);
  }
  for (const [rootKey, direct] of byMethod) {
    const root = {
      kind: "method-return-propagation",
      directCandidateIds: unique(direct.map((item) => item.id)),
      propagatedCandidateIds: [],
      methodFactIds: unique(direct.flatMap((item) => item.evidenceFactIds)),
      typeFactIds: [],
      referenceEvidence: [],
      rootKey,
    };
    roots.push({ id: stableId("downstream-root-cause", root), ...root });
  }

  const byType: Map<string, DownstreamCandidate[]> = new Map();
  for (const candidate of typeCandidates) {
    const fact = candidateFact(candidate, "target") ?? candidateFact(candidate, "baseline");
    const identity = typeIdentity(fact);
    const key = `${fact?.projectId ?? ""}:${identity}`;
    const values = byType.get(key) ?? [];
    values.push(candidate);
    byType.set(key, values);
  }
  for (const [rootKey, direct] of byType) {
    const firstCandidate = direct[0];
    if (!firstCandidate) continue;
    const fact =
      candidateFact(firstCandidate, "target") ?? candidateFact(firstCandidate, "baseline");
    const identity = typeIdentity(fact) ?? "undefined";
    const projectGraphs = graphs.filter((graph) => graph.projectId === fact?.projectId);

    const pathsByMethod: Map<
      string,
      {
        graph: ReferenceGraph;
        result: ReturnType<typeof shortestMethodPaths>[number];
        methodIdentity: string | undefined;
      }
    > = new Map();
    for (const graph of projectGraphs.sort((left, right) =>
      right.comparisonRole.localeCompare(left.comparisonRole),
    )) {
      for (const result of shortestMethodPaths(graph, identity)) {
        const method = graph.nodes.get(result.methodKey)?.value;
        const methodIdentity =
          stringField(method, "crossLanguageDefinitionId") ?? stringField(method, "identity");
        const key = `${methodIdentity ?? result.methodKey}:${result.location ?? ""}`;
        if (!pathsByMethod.has(key)) pathsByMethod.set(key, { graph, result, methodIdentity });
      }
    }

    const methodFactIds: (string | undefined)[] = [];
    const typeFactIds = direct.flatMap((item) => item.evidenceFactIds);

    const referenceEvidence: DownstreamRootCause["referenceEvidence"] = [];
    for (const { graph, result } of pathsByMethod.values()) {
      const methodFactId = graph.ensureFact(result.methodKey);
      methodFactIds.push(methodFactId);
      for (const edge of result.path) {
        const fromFactId = graph.ensureFact(edge.from);
        const toFactId = graph.ensureFact(edge.to);
        if (edge.to.startsWith("type:") && toFactId !== undefined) {
          typeFactIds.push(toFactId);
        }
        referenceEvidence.push({
          fromFactId,
          toFactId,
          kind: edge.kind,
          ...(edge.memberName ? { memberName: edge.memberName } : {}),
          ...(edge.location ? { location: edge.location } : {}),
        });
      }
    }
    const kind =
      fact?.factKind === "model" ? "type-contract-propagation" : "enum-union-propagation";
    const root = {
      kind: methodFactIds.length ? kind : "unresolved",
      directCandidateIds: unique(direct.map((item) => item.id)),
      propagatedCandidateIds: [],
      methodFactIds: unique(methodFactIds),
      typeFactIds: unique(typeFactIds),
      referenceEvidence: [
        ...new Map(referenceEvidence.map((item) => [canonicalJson(item), item])).values(),
      ],
      rootKey,
    };
    roots.push({ id: stableId("downstream-root-cause", root), ...root });
  }
  for (const candidate of candidates) {
    candidate.rootCauseIds = roots
      .filter(
        (root) =>
          root.directCandidateIds.includes(candidate.id) ||
          root.propagatedCandidateIds.includes(candidate.id),
      )
      .map((root) => root.id);
  }
  return roots.sort((left, right) => left.id.localeCompare(right.id));
}

export function analyzeDownstreamBreaking(options: {
  manifest: string | PreparationManifest;
  manifestPath?: string;
  workRoot?: string;
  sourceIndex?: SourceIndex;
  output?: string;
}): DownstreamAnalysis {
  const { workRoot, manifest, sourceIndex } = loadInputs(options);

  const facts: Record<string, AssessmentFact> = {};

  const candidates: DownstreamCandidate[] = [];

  const graphs: ReferenceGraph[] = [];

  const blockers: PreparationBlocker[] = [];
  let analyzedProjects = 0;
  for (const project of [...(manifest.projects ?? [])].sort((left, right) =>
    left.id.localeCompare(right.id),
  )) {
    const baseArtifact = project.artifacts?.baseline?.tcgc ?? project.artifacts?.base?.tcgc;
    const currentArtifact = project.artifacts?.target?.tcgc ?? project.artifacts?.current?.tcgc;
    if (!artifactReady(baseArtifact) || !artifactReady(currentArtifact)) {
      blockers.push({
        code: "tcgc-artifacts-unavailable",
        projectId: project.id,
        message: `Baseline and target TCGC artifacts are required for ${project.id}.`,
      });
      continue;
    }
    try {
      const base = normalizeTcgcContract({ workRoot, artifact: baseArtifact });
      const current = normalizeTcgcContract({ workRoot, artifact: currentArtifact });
      const source = evidence(project, sourceIndex);
      source.artifactComparison = project.artifactComparison;
      const candidateStart = candidates.length;
      compareMethods(project.id, base, current, source, facts, candidates);
      compareModels(project.id, base, current, source, facts, candidates);
      compareEnums(project.id, base, current, source, facts, candidates);
      compareUnions(project.id, base, current, source, facts, candidates);
      compareClients(project.id, base, current, source, facts, candidates);
      compareCustomizations(project.id, source, facts, candidates);
      const requiresTypeReachability = candidates
        .slice(candidateStart)
        .some((candidate) =>
          candidate.evidenceFactIds.some(
            (id) =>
              typeof facts[id]?.factKind === "string" &&
              ["model", "enum", "union"].includes(facts[id].factKind),
          ),
        );
      if (requiresTypeReachability) {
        graphs.push(
          buildReferenceGraph(project.id, "baseline", base, source, facts),
          buildReferenceGraph(project.id, "target", current, source, facts),
        );
      }
      analyzedProjects += 1;
    } catch (error) {
      blockers.push({
        code: "tcgc-contract-unsupported",
        projectId: project.id,
        message: error instanceof Error ? error.message : String(error),
      });
    }
  }
  const uniqueCandidates = new Map(candidates.map((item) => [item.id, item]));
  const normalizedCandidates = [...uniqueCandidates.values()].sort((left, right) =>
    left.id.localeCompare(right.id),
  );
  const rootCauses = buildRootCauses(normalizedCandidates, facts, graphs);

  const result: DownstreamAnalysis = {
    schemaVersion: 1,
    status: analyzedProjects ? "ready" : "blocked",
    facts: Object.fromEntries(
      Object.entries(facts).sort(([left], [right]) => left.localeCompare(right)),
    ),
    rootCauses,
    candidates: normalizedCandidates,
    blockers,
  };
  if (options.output) writeJson(path.resolve(options.output), result);
  return result;
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2), { required: ["manifest", "output"] });
    const manifest = args.manifest;
    const output = args.output;
    if (typeof manifest !== "string" || typeof output !== "string") {
      throw new TypeError("--manifest and --output must each have one value.");
    }
    const result = analyzeDownstreamBreaking({ manifest, output });
    console.log(path.resolve(output));
    if (result.status === "blocked") process.exitCode = 1;
  });
}
