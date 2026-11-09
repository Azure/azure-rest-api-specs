import path from "node:path";
import { isMain, isRecord, parseArgs, readJsonObject, runMain, writeJson } from "./cli.ts";
import { unavailableHeadBaselineBlocker } from "./comparison-execution.ts";
import { typeIdentity } from "./sdk-method-delta.ts";
import { canonicalJson, stableId } from "./stable-id.ts";
import { normalizeTcgcContract } from "./tcgc-contract.ts";
import type {
  ArtifactComparison,
  AssessmentFact,
  DownstreamAnalysis,
  DownstreamCandidate,
  DownstreamIdentityEvidence,
  NormalizedTcgcContract,
  NormalizedTcgcMethod,
  NormalizedTcgcNamedType,
  NormalizedTcgcParameter,
  NormalizedTcgcType,
  PreparationBlocker,
  PreparationManifest,
  PreparationProject,
  SourceChange,
  SourceDeclaration,
  SourceIndex,
  TcgcArtifact,
} from "./runtime-types.ts";

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

type IdentityResolution<T> =
  | { status: "matched"; target: T; evidence?: DownstreamIdentityEvidence }
  | { status: "removed" }
  | { status: "blocked" };

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

function decoratorText(value: SourceDeclaration["decorators"][number]) {
  return typeof value === "string" ? value : (value.definition ?? value.name ?? "");
}

function qualifiedNameWithRenamedMember(qualifiedName: string, previousName: string) {
  const segments = qualifiedName.split(".");
  segments[segments.length - 1] = previousName;
  return segments.join(".");
}

function explicitRenames(source: DownstreamEvidence, declarationKind: "model" | "operation") {
  return source.declarations.flatMap((declaration) => {
    if (declaration.kind !== declarationKind || declaration.source?.revision !== "current") {
      return [];
    }
    const previousNames = declaration.decorators
      .map(decoratorText)
      .map((decorator) => /@renamedFrom\s*\(\s*[^,]+,\s*["']([^"']+)["']\s*\)/.exec(decorator)?.[1])
      .filter((name) => name !== undefined);
    return previousNames.map((previousName) => ({
      declarationId: declaration.id,
      baselineQualifiedName: qualifiedNameWithRenamedMember(
        declaration.qualifiedName,
        previousName,
      ),
      targetQualifiedName: declaration.qualifiedName,
    }));
  });
}

function identityMatchesQualifiedName(identity: string, qualifiedName: string) {
  return identity === qualifiedName || identity.endsWith(`.${qualifiedName}`);
}

function addIdentityBlocker<T extends NormalizedTcgcMethod | NormalizedTcgcNamedType>(
  blockers: PreparationBlocker[],
  facts: Record<string, AssessmentFact>,
  source: DownstreamEvidence,
  projectId: string,
  factKind: "method" | "model",
  before: T,
  targets: T[],
  reason: string,
) {
  const evidenceFactIds = [
    addFact(facts, projectId, "baseline", factKind, before, source.artifactComparison),
    ...targets.map((target) =>
      addFact(facts, projectId, "target", factKind, target, source.artifactComparison),
    ),
  ];
  blockers.push({
    code: "downstream-identity-unresolved",
    projectId,
    message: `Cannot deterministically resolve ${factKind} identity for ${
      before.crossLanguageDefinitionId ?? before.identity
    }: ${reason}`,
    evidenceFactIds: unique(evidenceFactIds),
  });
}

function resolveIdentity<T extends NormalizedTcgcMethod | NormalizedTcgcNamedType>(
  before: T,
  targets: T[],
  source: DownstreamEvidence,
  projectId: string,
  factKind: "method" | "model",
  blockers: PreparationBlocker[],
  facts: Record<string, AssessmentFact>,
): IdentityResolution<T> {
  const baselineIdentity = before.crossLanguageDefinitionId;
  if (!baselineIdentity) {
    const sameGeneratedName = targets.filter((target) => target.identity === before.identity);
    addIdentityBlocker(
      blockers,
      facts,
      source,
      projectId,
      factKind,
      before,
      sameGeneratedName,
      "the baseline artifact has no crossLanguageDefinitionId; matching generated names, shapes, or locations is not identity evidence.",
    );
    return { status: "blocked" };
  }

  const exact = targets.filter((target) => target.crossLanguageDefinitionId === baselineIdentity);
  if (exact.length === 1) return { status: "matched", target: exact[0] };
  if (exact.length > 1) {
    const baselineGenericIdentity =
      factKind === "model" && "genericInstanceIdentity" in before
        ? before.genericInstanceIdentity
        : undefined;
    if (typeof baselineGenericIdentity === "string") {
      const concrete = exact.filter(
        (target) =>
          "genericInstanceIdentity" in target &&
          target.genericInstanceIdentity === baselineGenericIdentity,
      );
      if (concrete.length === 1) return { status: "matched", target: concrete[0] };
      if (concrete.length === 0) return { status: "removed" };
      addIdentityBlocker(
        blockers,
        facts,
        source,
        projectId,
        factKind,
        before,
        concrete,
        "multiple target symbols have the same generic template arguments.",
      );
      return { status: "blocked" };
    }
    addIdentityBlocker(
      blockers,
      facts,
      source,
      projectId,
      factKind,
      before,
      exact,
      "multiple target symbols have the same crossLanguageDefinitionId.",
    );
    return { status: "blocked" };
  }

  const declarationKind = factKind === "method" ? "operation" : "model";
  const relevantRenames = explicitRenames(source, declarationKind).filter((rename) =>
    identityMatchesQualifiedName(baselineIdentity, rename.baselineQualifiedName),
  );
  if (!relevantRenames.length) return { status: "removed" };

  const renamedTargets = new Map<string, { target: T; declarationIds: string[] }>();
  for (const rename of relevantRenames) {
    for (const target of targets) {
      const targetIdentity = target.crossLanguageDefinitionId;
      if (
        !targetIdentity ||
        !identityMatchesQualifiedName(targetIdentity, rename.targetQualifiedName)
      ) {
        continue;
      }
      const match = renamedTargets.get(targetIdentity) ?? { target, declarationIds: [] };
      match.declarationIds.push(rename.declarationId);
      renamedTargets.set(targetIdentity, match);
    }
  }
  if (renamedTargets.size === 1) {
    const [{ target, declarationIds }] = [...renamedTargets.values()];
    return {
      status: "matched",
      target,
      evidence: {
        basis: "typespec-renamed-from",
        baselineIdentity,
        targetIdentity: target.crossLanguageDefinitionId as string,
        declarationIds: unique(declarationIds),
      },
    };
  }

  addIdentityBlocker(
    blockers,
    facts,
    source,
    projectId,
    factKind,
    before,
    [...renamedTargets.values()].map((item) => item.target),
    renamedTargets.size
      ? "explicit @renamedFrom metadata maps to multiple target symbols."
      : "explicit @renamedFrom metadata has no uniquely matching target crossLanguageDefinitionId.",
  );
  return { status: "blocked" };
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
    case "model-identity-changed":
      actual = `${symbol} changed its generated SDK model name or identity.`;
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
  identityEvidence?: DownstreamIdentityEvidence,
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
    ...(identityEvidence ? { identityEvidence } : {}),
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
  blockers: PreparationBlocker[],
) {
  for (const before of base.methods) {
    const resolution = resolveIdentity(
      before,
      current.methods,
      source,
      projectId,
      "method",
      blockers,
      facts,
    );
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (resolution.status === "blocked") continue;
    if (resolution.status === "removed") {
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
    const after = resolution.target;
    const identityEvidence = resolution.evidence;
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
        undefined,
        identityEvidence,
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
        undefined,
        identityEvidence,
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
        identityEvidence,
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
        undefined,
        identityEvidence,
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
        undefined,
        identityEvidence,
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
        undefined,
        identityEvidence,
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
        undefined,
        identityEvidence,
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
        undefined,
        identityEvidence,
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
  blockers: PreparationBlocker[],
) {
  for (const before of base.models.filter((item) => item.reachable)) {
    const resolution = resolveIdentity(
      before,
      current.models,
      source,
      projectId,
      "model",
      blockers,
      facts,
    );
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (resolution.status === "blocked") continue;
    if (resolution.status === "removed") {
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
    const after = resolution.target;
    const identityEvidence = resolution.evidence;
    if (before.identity !== after.identity || before.name !== after.name) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "model-identity-changed",
        symbol,
        before,
        after,
        "model",
        undefined,
        identityEvidence,
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
        "model",
        undefined,
        identityEvidence,
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
        undefined,
        identityEvidence,
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
          identityEvidence,
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
          identityEvidence,
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
          identityEvidence,
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

  const blockers: PreparationBlocker[] = [];
  let analyzedProjects = 0;
  for (const project of [...(manifest.projects ?? [])].sort((left, right) =>
    left.id.localeCompare(right.id),
  )) {
    const baselineBlocker = unavailableHeadBaselineBlocker(project);
    if (baselineBlocker) {
      blockers.push(baselineBlocker);
      continue;
    }
    if (project.classification === "new" || project.artifactComparison?.mode === "new-project") {
      analyzedProjects += 1;
      continue;
    }
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
      compareMethods(project.id, base, current, source, facts, candidates, blockers);
      compareModels(project.id, base, current, source, facts, candidates, blockers);
      compareEnums(project.id, base, current, source, facts, candidates);
      compareUnions(project.id, base, current, source, facts, candidates);
      compareClients(project.id, base, current, source, facts, candidates);
      compareCustomizations(project.id, source, facts, candidates);
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
  const result: DownstreamAnalysis = {
    schemaVersion: 1,
    status: analyzedProjects ? "ready" : "blocked",
    facts: Object.fromEntries(
      Object.entries(facts).sort(([left], [right]) => left.localeCompare(right)),
    ),
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
