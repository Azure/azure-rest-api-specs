import { isDeepStrictEqual } from "node:util";
import { DOCUMENT_QUALITY_CRITERION } from "./document-quality-input.ts";
import { semanticGroupingPresentation } from "./semantic-assessment-scope.ts";

type AssessmentFact = import("./runtime-types.ts").AssessmentFact;

type AssessmentFinding = import("./runtime-types.ts").AssessmentFinding;

type AssessmentMethodGroup = import("./runtime-types.ts").AssessmentMethodGroup;

type AssessmentOutput = import("./runtime-types.ts").AssessmentOutput;

type AssessmentTypeImpact = import("./runtime-types.ts").AssessmentTypeImpact;

type DocumentQualityDimension = import("./runtime-types.ts").DocumentQualityDimension;

type DocumentationDocument = import("./runtime-types.ts").DocumentationDocument;

type DocumentationSnapshot = import("./runtime-types.ts").DocumentationSnapshot;

type DownstreamAnalysis = import("./runtime-types.ts").DownstreamAnalysis;

type ComplianceIntentAssessment = import("./runtime-types.ts").ComplianceIntentAssessment;

type InternalSemanticOperation = import("./runtime-types.ts").InternalSemanticOperation;

type LegacyAssessmentFinding = import("./runtime-types.ts").LegacyAssessmentFinding;

type SourceChange = import("./runtime-types.ts").SourceChange;

type SdkType = import("./runtime-types.ts").SdkType;

type ReportRenderHelpers = {
  escapeHtml: (value: unknown) => string;
  operationContractRows: (
    operation: InternalSemanticOperation,
    findings: AssessmentFinding[],
    semanticId: string,
  ) => ReportRow[];
  restContractDelta: (finding: AssessmentFinding) => ReportRow;
  findingMatchesOperation: (
    finding: AssessmentFinding,
    operation: InternalSemanticOperation,
    semanticId: string,
  ) => boolean;
  complianceFindingGroups: (findings: ComplianceIntentAssessment[]) => {
    findings: ComplianceIntentAssessment[];
  }[];
  complianceCode: (snippets: unknown[]) => string;
  renderSourceHunks: (sources: SourceChange[]) => string;
  sourceLinks: (sources: SourceChange[]) => string;
  legacyEvidence: (evidence: string[]) => string;
  contractAreaParts: (row: ReportRow) => {
    areaKind: string;
    member: string;
  };
};
type DocumentRenderHelpers = {
  escapeHtml: (value: unknown) => string;
  sectionHead: (title: string, description: string, metadata: string) => string;
  status: (value: string | undefined) => string;
  count: (value: string) => string;
  summary: (title: string, description: string, badges: string, links?: string) => string;
  affectedIntents: (ids: string[]) => string;
  intentLinks: (ids: string[]) => string;
  intentTitle?: (id: string) => string;
  intentSources?: (id: string) => import("./runtime-types.ts").SourceChange[];
};
type DocumentQualityCheck = {
  reviewUnitId: string;
  documentId?: string;
  check?: string;
  decision?: string;
  rationale?: string;
  title?: string;
  expected?: string;
  docQuote?: string;
};
type DocumentQualityFinding = NonNullable<DocumentQualityDimension["findings"]>[number];
type RestCard = {
  operation: ReportOperation;
  findings: AssessmentFinding[];
  semanticIds: string[];
  key: string;
  id: string;
};
type ReportOperation = {
  projectId?: string;
  operationId: string;
  apiVersion?: string;
  method?: string;
  path?: string;
};
type MethodPresentation = {
  symbol: string;
  projectId?: string;
  name: string;
  aliases: string[];
  group?: AssessmentMethodGroup;
  findingIds: string[];
  rows: ReportRow[];
  types: {
    type: TypePresentation;
    paths: ReferencePath[];
  }[];
  semanticIds: string[];
  cause?: "mixed" | "direct" | "indirect";
  id?: string;
  before?: AssessmentFact;
  after?: AssessmentFact;
};
type TypePresentation = {
  id: string;
  type: string;
  findings: AssessmentFinding[];
  rows: ReportRow[];
  mapped: {
    symbol: string;
    projectId?: string;
    paths: ReferencePath[];
  }[];
  anchorId: string;
  semanticIds: string[];
};
type DownstreamRootCauseReference = {
  fromFactId?: string;
  toFactId?: string;
  kind: string;
  memberName?: string;
  location?: string;
};
type ReferencePath = {
  location?: string;
  role: string;
  path: string;
  steps: ReferenceStep[];
};
type ReferenceStep = {
  name: string;
  detail?: string;
  added?: boolean;
  visibility?: string;
  changed?: boolean;
};
type ReportRow = {
  area: string;
  label?: string;
  member?: string;
  areaKind?: string;
  before: unknown;
  after: unknown;
  detail?: string;
  model?: string;
  identity?: string;
  beforeDetail?: string;
  afterDetail?: string;
};
type DownstreamDimension = AssessmentOutput["dimensions"]["downstream"];

const isPresent = <T>(value: T): value is Exclude<T, undefined | null | false | ""> =>
  Boolean(value);

const unique = <T>(values: T[]): Exclude<T, undefined | null | false | "">[] => [
  ...new Set(values.filter(isPresent)),
];

const anchor = (value: unknown) => String(value).replaceAll(/[^A-Za-z0-9_-]/g, "-");

const symbolOf = (fact: AssessmentFact | undefined) =>
  fact?.crossLanguageDefinitionId ?? fact?.identity;

const impactsOf = (dimension: Partial<DownstreamDimension>) =>
  dimension.typeImpacts ?? dimension.sharedTypeImpacts ?? [];

const rootsOf = (
  item:
    | {
        rootCauseIds?: string[];
        rootCauseId?: string;
      }
    | undefined,
) => unique(item?.rootCauseIds ?? [item?.rootCauseId]);

const shortName = (symbol: string | undefined) =>
  String(symbol ?? "Unknown method")
    .split(".")
    .slice(-2)
    .join(".");

export function sdkTypeName(type: SdkType | string | null | undefined): string | undefined {
  if (type === null) return "void";
  if (type === undefined) return "Not recorded";
  if (typeof type === "string") return type;
  if (type.kind === "array") return `${sdkTypeName(type.valueType ?? type.items)}[]`;
  if (type.kind === "dictionary") return `Record<string, ${sdkTypeName(type.valueType)}>`;
  if (type.kind === "nullable") return `${sdkTypeName(type.type)}?`;
  if (type.kind === "constant") return JSON.stringify(type.value);
  return type.name ?? type.id ?? type.kind ?? "unknown";
}

function parameterLocation(
  method: AssessmentFact,
  parameter: NonNullable<AssessmentFact["parameters"]>[number],
) {
  const protocol = [
    ...(method?.operation?.parameters ?? []),
    ...(method?.operation?.bodyParam ? [method.operation.bodyParam] : []),
  ];
  const kinds = unique(
    protocol
      .filter((item) => {
        const segments = (item.methodParameterSegments ?? []).flat(Infinity);
        return (
          item.name === parameter.name ||
          (parameter.crossLanguageDefinitionId &&
            segments.includes(parameter.crossLanguageDefinitionId)) ||
          segments.some((segment) => String(segment).split(".").at(-1) === parameter.name)
        );
      })
      .map((item) => item.kind),
  );
  return kinds.length === 1 ? (kinds[0] === "body" ? "body input" : kinds[0]) : "location unknown";
}

function methodInputs(method: AssessmentFact | undefined) {
  if (!method || !Array.isArray(method.parameters)) return "Not recorded";
  return (
    method.parameters
      .filter(
        (parameter) =>
          !parameter.onClient &&
          (typeof parameter.type === "string" || parameter.type?.kind !== "constant"),
      )
      .map(
        (parameter, index) =>
          `${index + 1}. ${parameter.name}${parameter.optional ? "?" : ""} (${parameterLocation(method, parameter)}): ${sdkTypeName(parameter.type)}`,
      )
      .join("\n") || "No caller inputs"
  );
}

function methodSignature(method: AssessmentFact | undefined) {
  if (!method || !Array.isArray(method.parameters)) return "Not recorded";
  const parameters = method.parameters
    .filter(
      (parameter) =>
        !parameter.onClient &&
        (typeof parameter.type === "string" || parameter.type?.kind !== "constant"),
    )
    .map(
      (parameter) =>
        `${parameter.name}${parameter.optional ? "?" : ""}: ${sdkTypeName(parameter.type)}`,
    );
  return `${method.name ?? shortName(symbolOf(method)).split(".").at(-1)}(${parameters.join(", ")}): ${sdkTypeName(method.responseType)}`;
}

function displayValue(value: unknown) {
  return value === undefined
    ? "Not recorded"
    : typeof value === "string"
      ? value
      : JSON.stringify(value, null, 2);
}

function methodRows(group: AssessmentMethodGroup): ReportRow[] {
  const rows: ReportRow[] = [];
  if (
    !group.deltas?.some((delta) => delta.field === "parameters") &&
    (group.before?.parameters || group.after?.parameters)
  ) {
    rows.push({
      area: "SDK method",
      label: "Normalized input order",
      before: methodInputs(group.before),
      after: methodInputs(group.after),
    });
  }
  if (group.before?.name !== group.after?.name) {
    rows.push({
      area: "SDK method",
      label: "Normalized method name",
      before: group.before?.name ?? "Not recorded",
      after: group.after?.name ?? "Not recorded",
    });
  }
  for (const delta of group.deltas ?? []) {
    if (delta.field === "parameters" && group.before?.parameters && group.after?.parameters) {
      rows.push({
        area: "SDK method",
        label: "Normalized input order",
        before: methodInputs(group.before),
        after: methodInputs(group.after),
        detail: delta.rationale,
      });
    } else if (delta.field === "parameters" && delta.changes) {
      // Older reports sometimes contain deltas but no complete method facts.

      const signature = (parameter: NonNullable<AssessmentFact["parameters"]>[number]) =>
        `${parameter.name}${parameter.optional ? "?" : ""} (location unknown): ${sdkTypeName(parameter.type)}`;
      rows.push(
        ...(delta.changes.added ?? []).map(({ parameter }) => ({
          area: "Method parameter",
          label: parameter.name,
          before: "not present",
          after: signature(parameter),
        })),
        ...(delta.changes.removed ?? []).map(({ parameter }) => ({
          area: "Method parameter",
          label: parameter.name,
          before: signature(parameter),
          after: "removed",
        })),
        ...(delta.changes.modified ?? []).map((item) => ({
          area: "Method parameter",
          label: item.name,
          before: signature(item.before),
          after: signature(item.after),
        })),
        ...(delta.changes.reordered ?? []).map((item) => ({
          area: "Method parameter",
          label: item.name,
          before: `position ${item.beforeIndex + 1}`,
          after: `position ${item.afterIndex + 1}`,
        })),
      );
    } else if (delta.field !== "responseType") {
      rows.push({
        area: "SDK method",
        label:
          (
            {
              kind: "Method kind",
              lro: "Long-running behavior",
              paging: "Paging",
            } as Record<string, string>
          )[delta.field ?? ""] ??
          delta.field ??
          delta.rule,
        before: displayValue(delta.before),
        after: displayValue(delta.after),
        detail: delta.rationale,
      });
    }
  }
  const responseDelta = group.deltas?.find((delta) => delta.field === "responseType");
  rows.push({
    area: "SDK method",
    label: "Return type (body output)",
    before: sdkTypeName(
      group.before && "responseType" in group.before
        ? group.before.responseType
        : sdkTypeValue(responseDelta?.before),
    ),
    after: sdkTypeName(
      group.after && "responseType" in group.after
        ? group.after.responseType
        : sdkTypeValue(responseDelta?.after),
    ),
  });
  return rows;
}

function sdkTypeValue(value: unknown) {
  return typeof value === "string" ||
    value === null ||
    value === undefined ||
    (typeof value === "object" && !Array.isArray(value))
    ? value
    : undefined;
}

/**
 * Raw graph enrichment is opt-in. IDs alone are insufficient: verify the recorded
 * facts and candidates before using edges from another artifact.
 */

export function validateDownstreamInput(
  dimension: Partial<DownstreamDimension>,
  raw: DownstreamAnalysis | undefined,
) {
  if (!raw) return;
  if (!raw.facts || !Array.isArray(raw.rootCauses)) {
    throw new Error("Downstream input must contain facts and rootCauses.");
  }
  const roots = new Map(raw.rootCauses.map((root) => [root.id, root]));
  const findings = dimension.findings ?? [];
  const candidateMap = new Map(
    (raw.candidates ?? []).map((candidate) => [candidate.id, candidate]),
  );
  for (const item of [...impactsOf(dimension), ...findings]) {
    for (const id of rootsOf(item)) {
      if (!roots.has(id))
        throw new Error(`Downstream input snapshot mismatch: missing root ${id}.`);
    }
  }
  for (const finding of findings) {
    const evidence = finding.evidence ?? [];
    const ids = finding.evidenceFactIds ?? unique(evidence.map((fact) => fact.id));
    if (rootsOf(finding).length && !ids.length) {
      throw new Error(`Downstream input cannot verify evidence for ${finding.id}.`);
    }
    for (const id of rootsOf(finding)) {
      const root = roots.get(id);
      if (!root) throw new Error(`Downstream input snapshot mismatch: missing root ${id}.`);
      if (
        ![...(root.directCandidateIds ?? []), ...(root.propagatedCandidateIds ?? [])].includes(
          finding.id,
        )
      ) {
        throw new Error(
          `Downstream input snapshot mismatch: root ${id} has no matching confirmed finding ${finding.id}.`,
        );
      }
    }
    for (const id of ids) {
      const recorded = evidence.find((fact) => fact.id === id);
      if (!recorded || !raw.facts[id] || !isDeepStrictEqual(recorded, raw.facts[id])) {
        throw new Error(`Downstream input snapshot mismatch: evidence fact ${id}.`);
      }
    }
    const candidate = candidateMap.get(finding.id);
    if (
      candidate &&
      (candidate.rule !== finding.rule ||
        candidate.crossLanguageDefinitionId !== finding.crossLanguageDefinitionId ||
        !isDeepStrictEqual([...(candidate.evidenceFactIds ?? [])].sort(), [...ids].sort()))
    ) {
      throw new Error(`Downstream input snapshot mismatch: candidate ${finding.id}.`);
    }
  }
  for (const impact of impactsOf(dimension)) {
    for (const id of rootsOf(impact)) {
      const root = roots.get(id);
      if (!root) throw new Error(`Downstream input snapshot mismatch: missing root ${id}.`);
      const rootCandidates = new Set([
        ...(root.directCandidateIds ?? []),
        ...(root.propagatedCandidateIds ?? []),
      ]);
      if (!(impact.findingIds ?? []).some((findingId) => rootCandidates.has(findingId))) {
        throw new Error(
          `Downstream input snapshot mismatch: root ${id} has no matching confirmed finding.`,
        );
      }
    }
  }
}

export function downstreamPresentationDimension(
  assessment: AssessmentOutput,
  options: {
    downstreamAssessment?: AssessmentOutput;
    downstreamInput?: DownstreamAnalysis;
  } = {},
): DownstreamDimension {
  const dimension = assessment.dimensions.downstream;
  const replay = options.downstreamAssessment;
  if (!replay) return dimension;
  if (!options.downstreamInput) {
    throw new Error("A downstream assessment sidecar requires downstreamInput.");
  }
  if (
    !assessment.repository ||
    !assessment.comparison ||
    !isDeepStrictEqual(assessment.repository, replay.repository) ||
    !isDeepStrictEqual(assessment.comparison, replay.comparison)
  ) {
    throw new Error("Downstream assessment provenance mismatch: repository or comparison.");
  }
  const findings = dimension.findings ?? [];
  const replayFindings = replay.dimensions?.downstream?.findings ?? [];
  const replayById = new Map(replayFindings.map((finding) => [finding.id, finding]));
  if (findings.length !== replayFindings.length || replayById.size !== findings.length) {
    throw new Error("Downstream assessment provenance mismatch: finding coverage.");
  }

  const withoutRoots = (finding: AssessmentFinding) => {
    const result = { ...finding };
    delete result.rootCauseIds;
    return result;
  };
  for (const finding of findings) {
    const matched = replayById.get(finding.id);
    if (!matched || !isDeepStrictEqual(withoutRoots(finding), withoutRoots(matched))) {
      throw new Error(`Downstream assessment provenance mismatch: finding ${finding.id}.`);
    }
  }
  // Replace only presentation root associations. All judgments, facts, grouping,
  // method contracts and semantic relationships still come from the input.

  const presentation: DownstreamDimension = {
    ...dimension,
    findings: findings.map((finding) => ({
      ...finding,
      rootCauseIds: rootsOf(replayById.get(finding.id)),
    })),
  };
  const impacts = impactsOf(dimension).map((impact) => ({
    ...impact,
    rootCauseIds: unique(
      (impact.findingIds ?? []).flatMap((id) => rootsOf(replayById.get(id) ?? {})),
    ),
  }));
  if (dimension.typeImpacts) presentation.typeImpacts = impacts;
  else presentation.sharedTypeImpacts = impacts;
  validateDownstreamInput(presentation, options.downstreamInput);
  return presentation;
}

function mappedPaths(
  impact: AssessmentTypeImpact,
  type: string,
  raw: DownstreamAnalysis | undefined,
) {
  if (!raw) return [];

  const result: Map<
    string,
    {
      symbol: string;
      projectId?: string;
      paths: ReferencePath[];
    }
  > = new Map();
  const rootIds = new Set(rootsOf(impact));
  for (const cause of raw.rootCauses.filter((root) => rootIds.has(root.id))) {
    const edges = cause.referenceEvidence ?? [];
    for (const methodId of cause.methodFactIds ?? []) {
      const method = raw.facts[methodId];
      const methodSymbol = symbolOf(method);
      if (method?.factKind !== "method" || !methodSymbol) continue;
      for (const start of edges.filter((edge) => edge.fromFactId === methodId)) {
        if (!start.toFactId) continue;

        const queue: {
          id: string;
          path: DownstreamRootCauseReference[];
        }[] = [{ id: start.toFactId, path: [start] }];

        const visited: Set<string> = new Set();
        while (queue.length) {
          const current = queue.shift();
          if (!current) break;
          if (visited.has(current.id)) continue;
          visited.add(current.id);
          const fact = raw.facts[current.id];
          if (
            !fact ||
            fact.projectId !== method.projectId ||
            fact.comparisonRole !== method.comparisonRole ||
            fact.sourceCommit !== method.sourceCommit ||
            fact.apiVersion !== method.apiVersion
          )
            continue;
          if (symbolOf(fact) === type) {
            const key = `${method.projectId ?? ""}:${methodSymbol}`;

            const mapping: {
              symbol: string;
              projectId?: string;
              paths: ReferencePath[];
            } = result.get(key) ?? {
              symbol: methodSymbol,
              projectId: method.projectId,
              paths: [],
            };
            mapping.paths.push({
              location: start.location,
              role: method.comparisonRole ?? "unavailable",
              path:
                current.path
                  .map((edge) => edge.memberName)
                  .filter(Boolean)
                  .join(".") || "(returned type)",
              steps: referenceSteps(method, current.path, raw, type),
            });
            result.set(key, mapping);
            break;
          }
          for (const edge of edges) {
            if (
              edge.fromFactId === current.id &&
              edge.toFactId &&
              edge.location === start.location
            ) {
              queue.push({ id: edge.toFactId, path: [...current.path, edge] });
            }
          }
        }
      }
    }
  }
  return [...result.values()].map((mapping) => ({
    ...mapping,
    paths: [...new Map(mapping.paths.map((item) => [JSON.stringify(item), item])).values()],
  }));
}

function counterpartFact(fact: AssessmentFact, raw: DownstreamAnalysis, role: string) {
  const matches = Object.values(raw.facts).filter(
    (candidate) =>
      candidate.projectId === fact.projectId &&
      candidate.comparisonRole === role &&
      candidate.factKind === fact.factKind &&
      symbolOf(candidate) === symbolOf(fact),
  );
  return matches.length === 1 ? matches[0] : undefined;
}

function referenceSteps(
  method: AssessmentFact,
  edges: DownstreamRootCauseReference[],
  raw: DownstreamAnalysis,
  changedType: string,
): ReferenceStep[] {
  const steps: ReferenceStep[] = [
    { name: shortName(symbolOf(method)), detail: "Public SDK method" },
  ];
  for (const edge of edges) {
    const from = edge.fromFactId ? raw.facts[edge.fromFactId] : undefined;
    const to = edge.toFactId ? raw.facts[edge.toFactId] : undefined;
    if (!to) continue;
    const property = from?.properties?.find((item) => item.name === edge.memberName);
    const baseline = from && counterpartFact(from, raw, "baseline");
    const added =
      edge.kind === "property" &&
      from?.comparisonRole === "target" &&
      Boolean(baseline?.properties) &&
      !baseline?.properties?.some((item) => item.name === edge.memberName);
    const visibility =
      property && "visibility" in property && Array.isArray(property.visibility)
        ? property.visibility
        : [];
    const visibilityLabel =
      visibility.length === 1 && visibility[0] === 2 ? "Create-only" : undefined;
    const member =
      (edge.memberName ?? "") +
      (typeof property?.type !== "string" && property?.type?.kind === "array" ? "[]" : "");
    if (added) {
      steps.push({
        name: member,
        detail: "New property; absent in baseline",
        added: true,
        visibility: visibilityLabel,
      });
    }
    steps.push({
      name:
        String(symbolOf(to) ?? to.name ?? "Unknown type")
          .split(".")
          .at(-1) ?? "Unknown type",
      detail: added
        ? "Property value type"
        : edge.memberName
          ? `Via .${member}`
          : edge.kind === "response"
            ? "Return type"
            : (edge.kind?.replaceAll("-", " ") ?? "Type reference"),
      visibility: added ? undefined : visibilityLabel,
      changed: symbolOf(to) === changedType,
    });
  }
  return steps;
}

function factPair(finding: AssessmentFinding, kind?: string) {
  const facts = (finding.evidence ?? []).filter((fact) => !kind || fact.factKind === kind);
  return {
    before: facts.find((fact) => fact.comparisonRole === "baseline"),
    after: facts.find((fact) => fact.comparisonRole === "target"),
  };
}

function typeRows(type: string, findings: AssessmentFinding[]): ReportRow[] {
  const rows: ReportRow[] = [];
  for (const finding of findings) {
    const { before, after } = factPair(finding);
    const name =
      finding.actual?.match(/\bproperty\s+([A-Za-z_$][\w$]*)\b/)?.[1] ??
      (finding.actual?.startsWith(`${type}.`)
        ? finding.actual.slice(type.length + 1).match(/^([A-Za-z_$][\w$]*)\b/)?.[1]
        : undefined) ??
      finding.expected?.match(/\bproperty\s+([A-Za-z_$][\w$]*)\b/)?.[1];
    if (finding.rule?.startsWith("model-property-") && name && (before || after)) {
      const previous = before?.properties?.find((property) => property.name === name);
      const current = after?.properties?.find((property) => property.name === name);
      const signature = (property: NonNullable<AssessmentFact["properties"]>[number]) =>
        `${property.name}${property.optional ? "?" : ""}: ${sdkTypeName(property.type)}`;
      const requiredness = (property: NonNullable<AssessmentFact["properties"]>[number]) =>
        property.optional ? "Optional; may be omitted" : "Required; must be supplied";
      rows.push({
        area: "SDK type member",
        label: `${type.split(".").at(-1)}.${name}`,
        before: previous ? signature(previous) : before ? "not present" : "Not recorded",
        after: current ? signature(current) : after ? "removed" : "Not recorded",
        beforeDetail: previous ? requiredness(previous) : undefined,
        afterDetail: current ? requiredness(current) : undefined,
      });
      for (const field of ["access", "flatten", "serializedName"] as const) {
        if (previous?.[field] !== current?.[field] && previous && current) {
          rows.push({
            area: "SDK type member",
            label: `${type.split(".").at(-1)}.${name} (${field})`,
            before: displayValue(previous[field]),
            after: displayValue(current[field]),
          });
        }
      }
    } else if (finding.rule === "public-surface-changed") {
      const surface = (fact: AssessmentFact | undefined) =>
        fact
          ? `access: ${fact.access ?? "not recorded"} · reachable: ${fact.reachable ?? "not recorded"} · usage: ${String(fact.usage ?? "not recorded")}`
          : "Not recorded";
      rows.push({
        area: "SDK type availability",
        label: type.split(".").at(-1),
        before: surface(before),
        after: surface(after),
      });
      rows.push({
        area: "SDK type contract",
        label: type.split(".").at(-1),
        before: finding.expected,
        after: finding.actual,
      });
    } else if (before?.factKind === "enum" && after?.factKind === "enum") {
      if (before.isFixed !== after.isFixed || before.isUnionAsEnum !== after.isUnionAsEnum) {
        const shape = (fact: AssessmentFact) =>
          fact.isFixed ? "Fixed enum" : fact.isUnionAsEnum ? "Extensible enum" : "Enum";
        rows.push({ area: "Enum shape", label: type, before: shape(before), after: shape(after) });
      }
      const currentByValue = new Map(
        (after.values ?? []).map((value) => [JSON.stringify(value.value), value]),
      );
      for (const previous of before.values ?? []) {
        const current = currentByValue.get(JSON.stringify(previous.value));
        if (!current || current.name !== previous.name) {
          rows.push({
            area: "Enum member",
            label: `${type.split(".").at(-1)}.${previous.name}`,
            before: previous.name,
            after: current?.name ?? "removed",
            detail: current
              ? `Wire value remains ${JSON.stringify(previous.value)}.`
              : `Wire value ${JSON.stringify(previous.value)} is no longer declared.`,
          });
        }
      }
      rows.push({
        area: "SDK type contract",
        label: type.split(".").at(-1),
        before: finding.expected,
        after: finding.actual,
      });
    } else {
      rows.push({
        area: "SDK type contract",
        label: type.split(".").at(-1),
        before: finding.expected,
        after: finding.actual,
      });
    }
  }
  return [...new Map(rows.map((row) => [JSON.stringify(row), row])).values()];
}

function modelReferenceType(method: AssessmentFact | undefined, reference: ReferencePath) {
  if (!method) return;
  if (reference.location === "response-body") return method.responseType;
  if (!reference.location?.startsWith("request-")) return;
  const member = reference.path.split(".")[0];
  return method.parameters?.find(
    (parameter) =>
      !parameter.onClient &&
      (parameter.name === member ||
        (reference.location === "request-body" &&
          parameter.name === method.operation?.bodyParam?.name)),
  )?.type;
}

function referencedTypeKind(type: SdkType | string | null | undefined): string | undefined {
  if (!type || typeof type === "string") return;
  if (type.kind === "array" || type.kind === "dictionary")
    return referencedTypeKind(type.valueType ?? type.items);
  if (type.kind === "nullable") return referencedTypeKind(type.type);
  return type.kind;
}

function modelReferences(method: MethodPresentation, paths: ReferencePath[]) {
  const references = new Map<
    string,
    {
      direction: string;
      name: string;
      expression: string;
      roles: string[];
      unchangedName: boolean;
      isModel: boolean;
    }
  >();
  for (const reference of paths) {
    const side = reference.role === "baseline" ? method.before : method.after;
    const recordedType = modelReferenceType(side, reference);
    const name = recordedType === undefined ? reference.steps[1]?.name : sdkTypeName(recordedType);
    if (!name) continue;
    const direction = reference.location?.startsWith("request-")
      ? "Input"
      : reference.location?.startsWith("response-")
        ? "Output"
        : "SDK";
    const expression =
      reference.path === "(returned type)"
        ? name
        : direction === "Output"
          ? `${name}.${reference.path}`
          : reference.path;
    const before = modelReferenceType(method.before, reference);
    const after = modelReferenceType(method.after, reference);
    const key = JSON.stringify([reference.location, name, expression]);
    const item = references.get(key) ?? {
      direction,
      name,
      expression,
      roles: [],
      isModel: referencedTypeKind(recordedType) === "model",
      unchangedName:
        before !== undefined && after !== undefined && sdkTypeName(before) === sdkTypeName(after),
    };
    item.roles = unique([...item.roles, reference.role]);
    references.set(key, item);
  }
  return [...references.values()];
}

function modelContextRows(type: TypePresentation, method: MethodPresentation) {
  const pair = type.findings
    .map((finding) => factPair(finding, "model"))
    .find(
      ({ before, after }) => Array.isArray(before?.properties) && Array.isArray(after?.properties),
    );
  if (!pair?.before || !pair.after) return type.rows;
  const addedNames = new Set(
    method.types.flatMap(({ paths }) =>
      paths.flatMap((reference) =>
        reference.steps.filter((step) => step.added).map((step) => step.name.replace(/\[\]$/, "")),
      ),
    ),
  );
  const added: ReportRow[] = (pair.after.properties ?? [])
    .filter(
      (property) =>
        typeof property.name === "string" &&
        addedNames.has(property.name) &&
        !pair.before?.properties?.some((previous) => previous.name === property.name) &&
        !type.rows.some((row) => row.label === `${type.type.split(".").at(-1)}.${property.name}`),
    )
    .map((property) => ({
      area: "SDK model field",
      label: `${type.type.split(".").at(-1)}.${property.name}`,
      before: "not present",
      after: `${property.name}${property.optional ? "?" : ""}: ${sdkTypeName(property.type)}`,
      afterDetail: "Added field connecting a related changed type; context, not another finding.",
    }));
  return [...added, ...type.rows];
}

export function downstreamMethodData(
  dimension: Partial<DownstreamDimension> = {},
  raw?: DownstreamAnalysis,
) {
  validateDownstreamInput(dimension, raw);

  const methods: MethodPresentation[] = [];

  const aliases: Map<string, MethodPresentation> = new Map();

  const key = (projectId: string | undefined, symbol: string) => `${projectId ?? ""}:${symbol}`;

  const addMethod = (method: MethodPresentation) => {
    methods.push(method);
    for (const alias of method.aliases) aliases.set(key(method.projectId, alias), method);
    return method;
  };

  const groupedFindings: Set<string> = new Set();
  for (const group of dimension.methodGroups ?? dimension.operationGroups ?? []) {
    const symbol = symbolOf(group.after) ?? group.symbol ?? symbolOf(group.before) ?? group.id;
    const findingIds = (group.deltas ?? []).map((delta) => delta.findingId).filter(Boolean);
    findingIds.forEach((id) => groupedFindings.add(id));
    addMethod({
      symbol,
      projectId: group.projectId ?? group.after?.projectId ?? group.before?.projectId,
      name: group.after?.name
        ? `${group.after.clientName ?? symbol.split(".").at(-2)}.${group.after.name}`
        : shortName(symbol),
      aliases: unique([symbol, group.symbol, symbolOf(group.before), symbolOf(group.after)]),
      group,
      before: group.before,
      after: group.after,
      findingIds,
      rows: methodRows(group),
      types: [],
      semanticIds: unique([
        ...(group.relatedSemanticIntents ?? []),
        ...(dimension.findings ?? [])
          .filter((finding) => findingIds.includes(finding.id))
          .flatMap((finding) => finding.relatedSemanticIntents ?? []),
      ]),
    });
  }

  const types: TypePresentation[] = [];
  const represented = new Set(groupedFindings);
  for (const impact of impactsOf(dimension)) {
    for (const type of impact.type ? [impact.type] : (impact.types ?? [])) {
      const findings = (dimension.findings ?? []).filter(
        (finding) =>
          impact.findingIds?.includes(finding.id) &&
          finding.crossLanguageDefinitionId === type &&
          !groupedFindings.has(finding.id),
      );
      if (!findings.length) continue;
      findings.forEach((finding) => represented.add(finding.id));
      let mapped = mappedPaths(impact, type, raw);
      // Legacy locations are a root-wide union, not evidence of a method's path.
      // Preserve method associations, but never display that union as precise.
      const mappedSymbols = new Set(mapped.map((item) => item.symbol));
      mapped = [
        ...mapped,
        ...(impact.affectedMethods ?? [])
          .filter((item) => !mappedSymbols.has(item.symbol))
          .map((item) => ({
            symbol: item.symbol,
            projectId: impact.projectId,
            paths: [],
          })),
      ];
      const findingIntentIds = unique(
        findings.flatMap((finding) => finding.relatedSemanticIntents ?? []),
      );

      const item: TypePresentation = {
        id: impact.id,
        type,
        findings,
        rows: typeRows(type, findings),
        mapped,
        anchorId: `downstream-type-${anchor(`${impact.projectId ?? ""}:${type}`)}`,
        semanticIds: findingIntentIds.length
          ? findingIntentIds
          : unique(impact.relatedSemanticIntents ?? []),
      };
      types.push(item);
      for (const mapping of mapped) {
        const projectId = mapping.projectId ?? impact.projectId;
        const candidates = projectId
          ? []
          : methods.filter((candidate) => candidate.aliases.includes(mapping.symbol));
        const method =
          aliases.get(key(projectId, mapping.symbol)) ??
          (candidates.length === 1 ? candidates[0] : undefined) ??
          addMethod({
            symbol: mapping.symbol,
            projectId,
            name: shortName(mapping.symbol),
            aliases: [mapping.symbol],
            rows: [],
            types: [],
            semanticIds: [],
            findingIds: [],
          });
        const existing = method.types.find(
          (reference) => reference.type.id === item.id && reference.type.type === item.type,
        );
        if (existing) {
          existing.paths = [
            ...new Map(
              [...existing.paths, ...mapping.paths].map((path) => [JSON.stringify(path), path]),
            ).values(),
          ];
        } else {
          method.types.push({ type: item, paths: mapping.paths });
        }
        method.semanticIds = unique([...method.semanticIds, ...item.semanticIds]);
      }
    }
  }
  for (const finding of (dimension.findings ?? []).filter(
    (finding) => !represented.has(finding.id),
  )) {
    const type =
      finding.crossLanguageDefinitionId ?? finding.symbol ?? finding.rule ?? "Unmapped contract";
    types.push({
      id: finding.id,
      anchorId: `downstream-${anchor(finding.id)}`,
      type,
      findings: [finding],
      rows: typeRows(type, [finding]),
      mapped: [],
      semanticIds: finding.relatedSemanticIntents ?? [],
    });
  }
  if (raw) {
    for (const method of methods) {
      for (const role of ["baseline", "target"] as const) {
        const side = role === "baseline" ? "before" : "after";
        if (method[side]) continue;
        const matches = Object.values(raw.facts).filter(
          (fact) =>
            fact.factKind === "method" &&
            fact.comparisonRole === role &&
            (!method.projectId || fact.projectId === method.projectId) &&
            method.aliases.includes(symbolOf(fact) ?? ""),
        );
        if (matches.length === 1) method[side] = matches[0];
      }
    }
  }
  for (const method of methods) {
    method.cause = method.group ? (method.types.length ? "mixed" : "direct") : "indirect";
    method.id = `downstream-method-${anchor(key(method.projectId, method.symbol))}`;
  }
  return {
    methods: methods.sort((a, b) => a.name.localeCompare(b.name)),
    types,
    unmapped: types.filter((type) => !type.mapped.length),
  };
}

export function documentQualitySummary(
  dimension: DocumentQualityDimension = {
    status: "not-assessed",
    summary: "Documentation Completeness is not assessed.",
  },
) {
  const coverage = dimension.coverage;
  const findingCount = dimension.findings?.length ?? 0;
  const findingStatus = findingCount ? "failed" : "passed";
  const assessmentVersion = dimension.assessmentVersion ?? 0;
  const completeness = [4, 5].includes(assessmentVersion);
  const assessedCount = completeness ? coverage?.declarationCount : coverage?.assessedDocumentCount;
  const compactDetail = [
    `${findingCount} finding${findingCount === 1 ? "" : "s"}`,
    coverage
      ? `${assessedCount} ${completeness ? "declaration" : "description"}${assessedCount === 1 ? "" : "s"} ${completeness ? "checked" : "assessed"}`
      : "Assessment count unavailable",
  ];
  const status =
    dimension.status === "passed" && coverage?.documentCount === 0
      ? "not-applicable"
      : (dimension.status ?? "not-assessed");
  const label =
    status === "passed"
      ? "Passed"
      : status === "failed"
        ? "Failed"
        : status === "not-applicable"
          ? coverage?.inheritedDocumentCount
            ? "Inherited documentation not reviewed"
            : "No applicable documentation"
          : "Not assessed";
  if (!coverage)
    return {
      status,
      label,
      findingStatus,
      compactDetail,
      detail: (dimension.summary ?? "Documentation Completeness is not assessed.")
        .replaceAll("Document Quality and Agent Friendliness", "Documentation Completeness")
        .replaceAll("Agent Friendliness", "Documentation Completeness")
        .replaceAll("Documentation Correctness", "Documentation Completeness")
        .replaceAll("Doc Correctness", "Documentation Completeness"),
    };
  if (completeness) {
    const detail = [
      `${findingCount} findings`,
      `${coverage.documentedDeclarationCount}/${coverage.declarationCount} declarations documented`,
      `${coverage.assessedIntentCount}/${coverage.semanticIntentCount} intent scopes resolved`,
    ];
    if (coverage.unassessedIntentIds?.length) {
      detail.push(`${coverage.unassessedIntentIds.length} intent scopes incomplete`);
    }
    return { status, label, findingStatus, detail: detail.join(" · "), compactDetail };
  }
  const detail = [
    `${dimension.findings?.length ?? 0} findings`,
    ...(assessmentVersion >= 2
      ? [`${coverage.assessedDocumentCount}/${coverage.documentCount} descriptions assessed`]
      : [
          `${coverage.assessedCheckCount}/${coverage.checkCount} checks assessed`,
          `${coverage.assessedDocumentCount}/${coverage.documentCount} descriptions assessed`,
        ]),
    `${coverage.assessedIntentCount}/${coverage.semanticIntentCount} intent scopes resolved`,
  ];
  const units = dimension.intentAssessments ?? [];
  const checks = units.flatMap((item) => item.checks ?? []);
  const passes = checks.filter((check) => check.decision === "pass").length;
  detail.push(`${passes} ${assessmentVersion >= 2 ? "descriptions" : "legacy checks"} passed`);
  const unreviewed = units.reduce(
    (total, item) =>
      total +
      (item.documents ?? []).filter(
        (document) =>
          !(item.checks ?? []).some((check) => check.documentId === document.id) &&
          !(dimension.findings ?? []).some(
            (finding) =>
              finding.reviewUnitId === item.reviewUnitId && finding.documentId === document.id,
          ),
      ).length,
    0,
  );
  if (unreviewed) detail.push(`${unreviewed} retained descriptions not reviewed`);
  if (coverage.unassessedIntentIds?.length)
    detail.push(`${coverage.unassessedIntentIds.length} intent scopes incomplete`);
  if (coverage.inheritedDocumentCount)
    detail.push(`${coverage.inheritedDocumentCount} inherited descriptions not reviewed`);
  const inheritedOnlyIntents = (dimension.intentAssessments ?? []).filter(
    (item) => item.status === "not-applicable" && item.inheritedDocumentIds?.length,
  ).length;
  const noDocuments = (coverage.notApplicableIntentIds?.length ?? 0) - inheritedOnlyIntents;
  if (noDocuments > 0) detail.push(`${noDocuments} intents with no applicable description`);
  return { status, label, findingStatus, detail: detail.join(" · "), compactDetail };
}

function declarationIncludesDoc(source: string = "") {
  // Only leading decorator applications belong to this declaration, not nested or quoted @doc text.
  let position = 0;
  let depth = 0;
  while (position < source.length) {
    if (/\s/.test(source[position])) {
      position++;
      continue;
    }
    if (source.startsWith("//", position)) {
      const end = source.indexOf("\n", position + 2);
      if (end < 0) return false;
      position = end + 1;
      continue;
    }
    if (source.startsWith("/*", position)) {
      const end = source.indexOf("*/", position + 2);
      if (end < 0) return false;
      if (source.startsWith("/**", position)) return true;
      position = end + 2;
      continue;
    }
    if (depth === 0) {
      const decorator = /^@@?([A-Za-z_$][\w$]*(?:\s*\.\s*[A-Za-z_$][\w$]*)*)\s*\(/.exec(
        source.slice(position),
      );
      if (!decorator) return false;
      const name = decorator[1].replaceAll(/\s/g, "");
      if (name === "doc" || name === "TypeSpec.doc") return true;
      position += decorator[0].length;
      depth = 1;
      continue;
    }
    if (source[position] === '"' || source[position] === "`") {
      const delimiter = source.startsWith('"""', position) ? '"""' : source[position];
      position += delimiter.length;
      while (position < source.length && !source.startsWith(delimiter, position)) {
        position += source[position] === "\\" ? 2 : 1;
      }
      position += delimiter.length;
      continue;
    }
    if (source[position] === "(") depth++;
    if (source[position] === ")") depth--;
    position++;
  }
  return false;
}

export function renderDocumentQuality(
  dimension: DocumentQualityDimension,
  helpers: DocumentRenderHelpers,
) {
  const {
    escapeHtml: escape,
    sectionHead,
    status,
    summary,
    affectedIntents,
    intentLinks,
    intentTitle,
    intentSources,
  } = helpers;
  const presentation = documentQualitySummary(dimension);
  const assessmentVersion = dimension.assessmentVersion ?? 0;
  const findings = dimension.findings ?? [];
  const assessments = dimension.intentAssessments ?? [];
  if ([4, 5].includes(assessmentVersion)) {
    const cards = findings
      .map((finding) => {
        const declaration = finding.declaration;
        const source = declaration?.source;
        const location = source
          ? `${finding.sources?.[0]?.path ?? "Source"}:${source.startLine}-${source.endLine}`
          : "Source location unavailable";
        const snippet = finding.codeSnippet;
        const sourceCode = snippet?.lines?.length
          ? `<details class="report-subdetails document-quality-source"><summary>View TypeSpec declaration missing a description</summary><p class="sources"><code>${escape(`${snippet.path}:${snippet.startLine}-${snippet.endLine}`)}</code>${snippet.truncated ? " · first 40 lines shown" : ""}</p><pre><code>${escape(snippet.lines.join("\n"))}</code></pre></details>`
          : "";
        return `<details class="report-card document-quality-check" id="document-quality-${anchor(finding.id)}">${summary(
          escape(declaration?.qualifiedName ?? finding.title),
          escape(finding.title),
          status("failed"),
          affectedIntents(finding.semanticIntentIds ?? [finding.reviewUnitId]),
        )}<div class="report-card-body">${sourceCode}<div class="report-guideline-section document-quality-explanation"><h3>Why this needs attention</h3><p>${escape(finding.actual)}</p></div><div class="report-guideline-section document-quality-suggestion"><h3>Suggested change</h3><p>${escape(finding.expected)}</p></div>${sourceCode ? "" : `<details class="report-subdetails document-quality-source"><summary>View supporting TypeSpec location</summary><p class="sources"><code>${escape(location)}</code></p></details>`}</div></details>`;
      })
      .join("");
    const description =
      assessmentVersion >= 5
        ? "Checks only whether newly added operation, model, enum, and interface declarations have a nonempty effective TypeSpec description."
        : "Checks only whether each changed compiler declaration has a nonempty effective TypeSpec document. Documentation text is not compared with code.";
    return {
      html: `<section id="document-quality">${sectionHead("Documentation Completeness", description, status(presentation.findingStatus))}<p class="report-small">${escape(presentation.compactDetail.join(" · "))}</p>${cards ? `<div class="document-quality-scope">${cards}</div>` : ""}</section>`,
      appendixHtml: "",
    };
  }

  const checkName = (check: string | undefined) =>
    check === "description"
      ? "Description explains code"
      : check === "correctness"
        ? "Correctness (legacy)"
        : check === "meaning"
          ? "Meaning (legacy)"
          : "Recorded check";

  const identity = (document: DocumentationDocument | undefined) => {
    const name = document?.qualifiedName ?? "Document identity unavailable";
    const short = name
      .split(".")
      .slice(
        ["property", "operation", "enum-member", "union-variant", "scalar-constructor"].includes(
          document?.kind ?? "",
        )
          ? -2
          : -1,
      )
      .join(".");
    return `<span title="${escape(name)}">${escape(short)}</span>`;
  };

  const snapshot = (value: DocumentationSnapshot | null | undefined, side: string) => {
    if (!value)
      return `<div class="report-document-snapshot"><h4>${side}</h4><p class="report-small">No ${side.toLowerCase()} snapshot recorded.</p></div>`;
    const source = value.source;
    const location = source
      ? `${source.path}:${source.startLine}-${source.endLine} (${source.revision})`
      : "Source location not recorded.";
    const inherited = value.documentationOrigin === "inherited";
    const includesDoc = !inherited && declarationIncludesDoc(value.declaration);
    return `<div class="report-document-snapshot"><h4>${side}</h4><p class="sources"><code>${escape(location)}</code></p>${includesDoc ? "" : `<h5>${inherited ? "Compiler-resolved inherited description" : "Recorded description"}</h5><pre><code>${escape(value.doc)}</code></pre>`}<h5>${inherited ? "Exact associated declaration source" : includesDoc ? "Description and declaration" : "Declaration contract"}</h5><pre><code>${escape(value.declaration)}</code></pre></div>`;
  };

  const relatedTypes = (
    document: DocumentationDocument,
    side: "before" | "after",
    reviewUnitId: string,
  ) => {
    const documents =
      assessments.find((item) => item.reviewUnitId === reviewUnitId)?.documents ?? [];
    const sources = intentSources?.(reviewUnitId) ?? [];

    const declarationFor = (item: DocumentationDocument) => {
      const value = item[side];
      if (!value?.source) return;
      const matches = sources
        .filter((source) => source.id === item.sourceChangeId && source.path === value.source.path)
        .flatMap((source) => source.declarations ?? [])
        .filter(
          (declaration) =>
            declaration.compilerEvidence?.kind === "semantic-type" &&
            declaration.kind === item.kind &&
            declaration.source?.revision === value.source.revision &&
            declaration.source.startLine >= value.source.startLine &&
            declaration.source.endLine <= value.source.endLine &&
            (declaration.qualifiedName === item.qualifiedName ||
              item.qualifiedName?.endsWith(`.${declaration.qualifiedName}`)),
        );
      return matches.length === 1 ? matches[0] : undefined;
    };
    const references = new Set(declarationFor(document)?.compilerEvidence?.referencedNames ?? []);
    if (!references.size) return "";
    const documentSnapshot = document[side];
    if (!documentSnapshot) return "";
    const candidates = documents
      .filter(
        (item) =>
          item.id !== document.id &&
          item[side]?.source?.revision === documentSnapshot.source?.revision &&
          ["model", "enum", "union", "scalar", "alias"].includes(item.kind),
      )
      .flatMap((item) => {
        const declaration = declarationFor(item);
        return declaration ? [{ document: item, declaration }] : [];
      });
    // Compiler names in historical artifacts can omit namespaces. Never guess an ambiguous target.
    const related = candidates.filter((item) => {
      const itemSnapshot = item.document[side];
      return (
        references.has(item.declaration.qualifiedName) &&
        candidates.filter(
          (other) => other.declaration.qualifiedName === item.declaration.qualifiedName,
        ).length === 1 &&
        itemSnapshot !== null &&
        !(
          itemSnapshot.source.path === documentSnapshot.source.path &&
          itemSnapshot.source.startLine >= documentSnapshot.source.startLine &&
          itemSnapshot.source.endLine <= documentSnapshot.source.endLine
        )
      );
    });
    if (!related.length) return "";
    return `<div class="report-document-related"><h4>Related type definitions</h4><p class="report-small">Compiler-recorded type references from this declaration, using retained evidence from the same intent and revision.</p>${related
      .map(
        (item) =>
          `<div class="report-document-related-type"><h5>${escape(item.document.qualifiedName)}</h5>${snapshot(item.document[side], side === "before" ? "Referenced baseline declaration" : "Referenced current declaration")}</div>`,
      )
      .join("")}</div>`;
  };

  const renderCheck = (
    check: DocumentQualityCheck,
    document: DocumentationDocument | undefined,
    finding: DocumentQualityFinding | undefined,
    index: number,
  ) => {
    const decision = finding
      ? "failed"
      : check.decision === "pass"
        ? "passed"
        : check.decision === "fail"
          ? "failed"
          : "not-assessed";
    const id = finding ? `document-quality-${anchor(finding.id)}` : `document-check-${index}`;
    const title =
      finding?.title ??
      check.title ??
      `${checkName(check.check)}: ${document?.qualifiedName ?? "Documentation"}`;
    const expected = finding?.expected ?? check.expected;
    const rationale = finding?.rationale ?? check.rationale;
    const sides = document ? (["before", "after"] as const).filter((side) => document[side]) : [];

    const renderSide = (side: "before" | "after") => {
      if (!document) return "";
      return `<div class="report-document-context">${snapshot(document[side], side === "before" ? "Before" : sides.length === 1 ? "Current declaration" : "After")}${relatedTypes(document, side, finding?.reviewUnitId ?? check.reviewUnitId)}</div>`;
    };
    const actual = sides.length
      ? `<div class="report-document-snapshots${sides.length === 1 ? " single-snapshot" : ""}">${sides.map(renderSide).join("")}</div>`
      : `<p class="report-small">Document source snapshots unavailable.</p>${finding?.actual !== undefined ? `<h4>Recorded description evidence</h4><pre><code>${escape(finding.actual)}</code></pre>` : ""}`;
    const doc = document?.after?.doc;
    const quote = finding?.docQuote ?? check.docQuote;
    const position =
      typeof doc === "string" && typeof quote === "string" && quote.length
        ? doc.indexOf(quote)
        : -1;
    let description = '<p class="report-small">Current description evidence unavailable.</p>';
    if (typeof doc === "string") {
      description =
        position < 0 || typeof quote !== "string"
          ? `<blockquote>${escape(doc)}</blockquote>`
          : `<blockquote>${escape(doc.slice(0, position))}<mark>${escape(quote)}</mark>${escape(doc.slice(position + quote.length))}</blockquote>`;
    }
    const grouped = assessments.some(
      (item) => item.reviewUnitId === (finding?.reviewUnitId ?? check.reviewUnitId),
    );
    const relatedIntents = unique([
      finding?.reviewUnitId,
      check.reviewUnitId,
      ...(finding?.semanticIntentIds ?? []),
    ]).filter((id) => !grouped || id !== (finding?.reviewUnitId ?? check.reviewUnitId));
    return `<details class="report-card document-quality-check" id="${id}">${summary(
      identity(document),
      escape(`${title} · ${checkName(check.check)}`),
      status(decision),
      relatedIntents.length ? affectedIntents(relatedIntents) : "",
    )}<div class="report-card-body"><div class="document-quality-current document-quality-document-body"><div class="document-quality-description-heading"><h3>Current description</h3><span class="report-small">${document?.after?.documentationOrigin === "inherited" ? "Compiler-resolved inherited description" : "Compiler-resolved"}</span></div>${description}</div>${rationale ? `<div class="report-guideline-section document-quality-explanation"><h3>Why this needs attention</h3><p>${escape(rationale)}</p></div>` : ""}${expected ? `<div class="report-guideline-section document-quality-suggestion"><h3>Suggested change</h3><p>${escape(expected)}</p></div>` : ""}<details class="report-subdetails document-quality-source"><summary>View supporting TypeSpec and source evidence</summary>${actual}</details></div></details>`;
  };

  const checkedFindings: Set<string> = new Set();
  let index = 0;

  const card = (
    check: DocumentQualityCheck,
    document: DocumentationDocument | undefined,
    finding: DocumentQualityFinding | undefined,
  ) => {
    const reviewUnitId = finding?.reviewUnitId ?? check.reviewUnitId;
    return { reviewUnitId, html: renderCheck(check, document, finding, index++) };
  };
  const cards = assessments.flatMap((assessment) =>
    (assessment.checks ?? []).flatMap((check) => {
      const finding = findings.find(
        (item) =>
          item.reviewUnitId === assessment.reviewUnitId &&
          item.documentId === check.documentId &&
          item.check === check.check,
      );
      if (finding) checkedFindings.add(finding.id);
      const document =
        finding?.document ?? assessment.documents?.find((item) => item.id === check.documentId);
      if (finding || check.decision === "fail") {
        return [card({ ...check, reviewUnitId: assessment.reviewUnitId }, document, finding)];
      }
      return [];
    }),
  );
  for (const finding of findings.filter((item) => !checkedFindings.has(item.id))) {
    const document =
      finding.document ??
      assessments
        .find((item) => item.reviewUnitId === finding.reviewUnitId)
        ?.documents?.find((item) => item.id === finding.documentId);
    cards.push(card(finding, document, finding));
  }

  const counted = (value: number, noun: string) => `${value} ${noun}${value === 1 ? "" : "s"}`;
  const mainCards = assessments
    .map((item) => {
      const failures = cards.filter((entry) => entry.reviewUnitId === item.reviewUnitId);
      if (!failures.length) return "";
      return `<details class="report-card document-quality-intent" open>${summary(
        escape(intentTitle?.(item.reviewUnitId) ?? item.reviewUnitId),
        `${counted(failures.length, "documentation finding")}`,
        `<span class="report-badge remove">${failures.length} failed</span>`,
      )}<div class="report-card-body"><div class="document-quality-intent-link">${intentLinks([item.reviewUnitId])}</div>${failures.map((entry) => entry.html).join("")}</div></details>`;
    })
    .join("");
  const orphanCards = cards
    .filter((entry) => !assessments.some((item) => item.reviewUnitId === entry.reviewUnitId))
    .map((entry) => entry.html)
    .join("");
  const criterion = DOCUMENT_QUALITY_CRITERION.replace("@doc description", "description");
  const legacy =
    dimension.coverage && !(assessmentVersion >= 2)
      ? "Legacy assessment: separate description Correctness and Meaning checks. "
      : "";
  const description = `${criterion} ${legacy}Examples, external documentation, and agent execution are not assessed.`;
  return {
    html: `<section id="document-quality">${sectionHead("Documentation Completeness", description, status(presentation.findingStatus))}<p class="report-small">${escape(presentation.compactDetail.join(" · "))}</p>${mainCards ? `<div class="document-quality-scope">${mainCards}</div>` : ""}${orphanCards}</section>`,
    appendixHtml: "",
  };
}

export function renderReportSections(
  assessment: AssessmentOutput,
  helpers: ReportRenderHelpers,
  options: {
    downstreamAssessment?: AssessmentOutput;
    downstreamInput?: DownstreamAnalysis;
  } = {},
) {
  const {
    escapeHtml: escape,
    operationContractRows,
    restContractDelta,
    findingMatchesOperation,
    complianceFindingGroups,
    complianceCode,
    renderSourceHunks,
    sourceLinks,
    legacyEvidence,
    contractAreaParts,
  } = helpers;
  const { dimensions } = assessment;
  const items = dimensions.semantic.items ?? [];
  const intentById = new Map(items.map((item) => [item.id, item]));
  const downstream = downstreamMethodData(
    downstreamPresentationDimension(assessment, options),
    options.downstreamInput,
  );

  const status = (value: string | undefined) => {
    const label =
      value === "unknown" ? "verdict unknown" : (value?.replaceAll("-", " ") ?? "Not assessed");
    return `<span class="report-badge ${value === "passed" ? "add" : value === "failed" ? "remove" : "unknown"}">${escape(label)}</span>`;
  };
  const sectionHead = (title: string, description: string, metadata: string) =>
    `<div class="report-section-head"><div><h2>${escape(title)}</h2><p>${escape(description)}</p></div><div class="report-section-meta">${metadata}</div></div>`;

  const summary = (title: string, description: string, badges: string, links: string = "") =>
    `<summary><div class="report-card-title"><strong>${title}</strong><small>${description}</small>${links}</div><div class="report-badges">${badges}</div></summary>`;

  const count = (text: string) => `<span class="report-count">${escape(text)}</span>`;

  const intentLinks = (ids: string[]) =>
    unique(ids)
      .flatMap((id) => {
        const intent = intentById.get(id);
        return intent
          ? [`<a class="report-link" href="#intent-${anchor(id)}">${escape(intent.title)}</a>`]
          : [];
      })
      .join("");

  const affectedIntents = (ids: string[]) => {
    const known = unique(ids).filter((id) => intentById.has(id));
    return `<div class="report-intent-relations"><span class="report-relation-label">Affected intents (${known.length})</span><div class="report-link-row">${intentLinks(known) || '<span class="report-small">No linked semantic intent.</span>'}</div></div>`;
  };

  const table = (rows: ReportRow[]) => {
    const changed = rows.filter((row) => escape(row.before) !== escape(row.after));
    if (!changed.length) return "";
    return `<div class="report-table-wrap"><table class="report-table"><thead><tr><th>Contract area</th><th>Before</th><th>After</th></tr></thead><tbody>${changed.map((row) => `<tr><td><span class="contract-area-kind">${escape(row.area ?? row.areaKind ?? "Contract")}</span><strong>${escape(row.label ?? row.member)}</strong>${row.model ? `<span class="report-small">Affected model: <code>${escape(row.model)}</code></span>` : ""}${row.detail ? `<span class="report-detail">${escape(row.detail)}</span>` : ""}</td><td><pre>${escape(row.before)}</pre>${row.beforeDetail ? `<span class="report-detail">${escape(row.beforeDetail)}</span>` : ""}</td><td><pre>${escape(row.after)}</pre>${row.afterDetail ? `<span class="report-detail">${escape(row.afterDetail)}</span>` : ""}</td></tr>`).join("")}</tbody></table></div>`;
  };

  const emitted: Set<string> = new Set();

  const emitAnchor = (id: string) => {
    if (emitted.has(id)) return "";
    emitted.add(id);
    return `<span id="${escape(id)}"></span>`;
  };

  const findingAnchors = (
    findings: {
      id?: string;
    }[],
    prefix: string = "finding",
  ) => findings.map((finding) => emitAnchor(`${prefix}-${anchor(finding.id)}`)).join("");

  const rationale = (
    findings: {
      rationale?: string;
    }[],
    label: string = "Why this is breaking:",
  ) => {
    const reasons = unique(findings.map((finding) => finding.rationale));
    if (!reasons.length) return "";
    const body =
      reasons.length === 1
        ? escape(reasons[0])
        : `<ul>${reasons.map((reason) => `<li>${escape(reason)}</li>`).join("")}</ul>`;
    return `<div class="breaking-rationale"><strong>${escape(label)}</strong> ${body}</div>`;
  };

  const legacyCard = (finding: LegacyAssessmentFinding, downstream: boolean = false) =>
    `<details class="report-card legacy-finding" id="${downstream ? "downstream" : "finding"}-${anchor(finding.id)}">${summary(
      escape(finding.title),
      escape(finding.summary),
      status("failed"),
      affectedIntents(finding.relatedSemanticIntents ?? []),
    )}<div class="report-card-body"><p class="mapping-unavailable">${downstream ? "Normalized SDK method mapping" : "Normalized operation mapping"} unavailable in this historical finding; recorded evidence follows.</p>${legacyEvidence(finding.evidence ?? [])}</div></details>`;

  const restFindings = dimensions.rest.findings ?? [];

  const operations: Map<string, RestCard> = new Map();

  const operationKey = (operation: ReportOperation) =>
    `${operation.projectId ?? ""}:${operation.operationId}:${operation.apiVersion ?? ""}`;
  for (const item of items) {
    for (const operation of item.operations ?? []) {
      const findings = restFindings.filter((finding) =>
        findingMatchesOperation(finding, operation, item.id),
      );
      if (!findings.length) continue;
      const key = operationKey(operation);
      const entry = operations.get(key) ?? {
        operation,
        findings: [],
        semanticIds: [],
        key,
        id: `rest-operation-${anchor(key)}`,
      };
      entry.findings.push(...findings);
      entry.semanticIds.push(
        item.id,
        ...findings.flatMap((finding) => finding.relatedSemanticIntents ?? []),
      );
      operations.set(key, entry);
    }
  }
  const mappedRest = new Set(
    [...operations.values()].flatMap((entry) => entry.findings.map((finding) => finding.id)),
  );
  for (const finding of restFindings.filter((finding) => !mappedRest.has(finding.id))) {
    const facts = (finding.evidence ?? []).filter((fact) => fact.operationId);
    for (const operationId of finding.operationIds ?? []) {
      const fact =
        facts.find(
          (fact) => fact.operationId === operationId && fact.comparisonRole === "target",
        ) ?? facts.find((fact) => fact.operationId === operationId);

      const operation: ReportOperation = {
        operationId,
        projectId: fact?.projectId ?? finding.projectId,
        apiVersion: fact?.apiVersion,
        method: fact?.method,
        path: fact?.path,
      };
      const key = operationKey(operation);

      const entry: RestCard = operations.get(key) ?? {
        operation,
        findings: [],
        semanticIds: [],
        key,
        id: `rest-operation-${anchor(key)}`,
      };
      entry.findings.push(finding);
      entry.semanticIds.push(...(finding.relatedSemanticIntents ?? []));
      operations.set(key, entry);
      mappedRest.add(finding.id);
    }
  }
  const restCards = [...operations.values()];
  for (const entry of restCards) {
    entry.findings = [...new Map(entry.findings.map((finding) => [finding.id, finding])).values()];
    entry.semanticIds = unique(entry.semanticIds);
  }

  const restRows = (entry: RestCard) =>
    entry.findings.map((finding) => {
      const row = restContractDelta(finding);
      const parts = contractAreaParts(row);
      return {
        ...row,
        area: parts.areaKind,
        label: parts.member,
        model: row.identity !== entry.operation.operationId ? row.identity : undefined,
      };
    });
  const restBody =
    restCards
      .map(
        (entry) =>
          `<details class="report-card rest-contract-card" id="${entry.id}">${summary(
            escape(entry.operation.operationId),
            `<span class="report-http">${escape((entry.operation.method ?? "").toUpperCase())}</span> <code>${escape(entry.operation.path ?? "Operation path unavailable")}</code> · ${escape(entry.operation.apiVersion ?? "Version unavailable")}`,
            count(`${entry.findings.length} changes`),
            affectedIntents(entry.semanticIds),
          )}<div class="report-card-body">${findingAnchors(entry.findings)}${table(restRows(entry))}${rationale(entry.findings)}</div></details>`,
      )
      .join("") +
    restFindings
      .filter((finding) => !mappedRest.has(finding.id))
      .map(
        (finding) =>
          `<details class="report-card">${summary(escape(finding.rule), "Confirmed REST finding; operation mapping unavailable.", status("failed"), affectedIntents(finding.relatedSemanticIntents ?? []))}<div class="report-card-body">${findingAnchors([finding])}${table([{ area: "REST contract", label: finding.rule, before: finding.expected, after: finding.actual }])}${rationale([finding])}</div></details>`,
      )
      .join("") +
    (dimensions.rest.legacyFindings ?? []).map((finding) => legacyCard(finding)).join("");

  const referenceChains = (paths: ReferencePath[]) => {
    const groups = new Map<string, { path: ReferencePath; roles: string[] }>();
    for (const item of paths) {
      const key = JSON.stringify([item.location, item.path, item.steps]);
      const group = groups.get(key) ?? { path: item, roles: [] };
      group.roles = unique([...group.roles, item.role]);
      groups.set(key, group);
    }
    return `<div class="report-reference-chains"><p class="report-small"><strong>How this method connects to the changed type</strong></p>${[
      ...groups.values(),
    ]
      .map(({ path: item, roles }) => {
        const role =
          roles.includes("baseline") && roles.includes("target")
            ? "Baseline + target"
            : roles.includes("baseline")
              ? "Baseline"
              : roles.includes("target")
                ? "Target"
                : "Role unavailable";
        const added = item.steps.some((step) => step.added);
        return `<div class="report-reference-chain"><div class="report-chain-label">${escape(role)} SDK reference graph${added ? ' <span class="report-badge unknown">Target-only path</span>' : ""}</div><ol>${item.steps.map((step, index) => `<li style="--reference-depth:${index}"><code>${escape(step.name)}</code>${step.added ? '<span class="report-badge unknown">Target only</span>' : ""}${step.visibility ? `<span class="report-badge neutral">${escape(step.visibility)}</span>` : ""}${step.changed ? '<span class="report-badge remove">Type-level breaking change</span>' : ""}${step.detail ? `<span class="report-chain-detail">${escape(step.detail)}</span>` : ""}</li>`).join("")}</ol></div>`;
      })
      .join("")}<p class="report-path-scope"><strong>Why this method is listed:</strong> ${
      paths.some((item) => item.role === "baseline")
        ? "a recorded baseline parameter or return-type path reaches this changed SDK type. The type-level consequence is described below; the method signature can remain unchanged."
        : paths.some((item) => item.steps.some((step) => step.added))
          ? "the target SDK graph reaches this type through a newly added property. This type association does not establish a separate breaking change for an existing caller of this method."
          : "the recorded SDK graph reaches this changed type. Baseline reachability is not established by target evidence alone."
    }</p></div>`;
  };

  const typeContent = (
    type: TypePresentation,
    paths?: ReferencePath[],
    method?: MethodPresentation,
  ) => {
    const anchors = `${emitAnchor(type.anchorId)}${emitAnchor(`downstream-${anchor(type.id)}`)}${findingAnchors(type.findings, "downstream")}${findingAnchors(type.findings)}`;
    if (!method || !paths?.length) {
      return `<div class="report-type-impact">${anchors}<h4>${escape(type.type.split(".").at(-1))}</h4><p class="report-small"><code>${escape(type.type)}</code></p><p class="mapping-unavailable">Precise method path, location and baseline/target role unavailable. Aggregate root locations are not method-specific evidence.</p>${table(type.rows)}${rationale(type.findings, "Why the type change is breaking:")}</div>`;
    }
    const references = modelReferences(method, paths);
    const directions = unique(references.map((reference) => reference.direction));
    const direction =
      directions.includes("Input") && directions.includes("Output")
        ? "Input / output"
        : (directions[0] ?? "SDK");
    const names = unique(references.map((reference) => reference.name));
    const noun =
      references.length && references.every((reference) => reference.isModel) ? "model" : "type";
    const unchangedSignature =
      method.before &&
      method.after &&
      methodSignature(method.before) !== "Not recorded" &&
      methodSignature(method.before) === methodSignature(method.after);
    const scope = paths.some((reference) => reference.role === "baseline")
      ? "The table directly compares the affected fields inside the referenced SDK model or type."
      : paths.some((reference) => reference.steps.some((step) => step.added))
        ? "Target-only association through a newly added field; this does not establish a separate breaking change for an existing caller."
        : "Target evidence only. Baseline reachability is not established by target evidence alone.";
    const referenceRows = references
      .map((reference) => {
        const role =
          reference.roles.includes("baseline") && reference.roles.includes("target")
            ? "Baseline + target"
            : reference.roles.includes("baseline")
              ? "Baseline"
              : reference.roles.includes("target")
                ? "Target"
                : "Role unavailable";
        const destination = type.type.split(".").at(-1);
        const expression =
          reference.expression === destination
            ? reference.expression
            : `${reference.expression} → ${destination}`;
        return `<div class="report-reference-path"><span>${escape(reference.direction)} / ${reference.isModel ? "model" : "type"}</span><code>${escape(expression)}</code><span>${reference.unchangedName ? `${reference.isModel ? "Model" : "Type"} name unchanged` : `${escape(role)} evidence`}</span></div>`;
      })
      .join("");
    const title = `${direction} ${noun}: ${names.join(" / ") || type.type.split(".").at(-1)}`;
    return `<div class="report-type-impact report-model-change">${anchors}<h4>${escape(title)} <span class="report-badge indirect">Structure changed</span></h4><p class="report-small">${escape(scope)}</p><div class="report-reference-paths">${referenceRows}</div>${table(modelContextRows(type, method))}<div class="breaking-rationale"><strong>${escape(unchangedSignature ? `The ${direction.toLowerCase()} ${noun} changed, not the method signature.` : `The ${direction.toLowerCase()} ${noun} contract changed.`)}</strong> ${escape(names.length === 1 ? `The method uses ${names[0]}; fields or public contracts inside the referenced ${noun} differ.` : "Compare the model fields separately from the method's parameter list and return type.")}</div><p class="report-small report-model-scope">This compares language-neutral SDK model structure, not HTTP response fields. Language-specific compatibility conclusions require the corresponding public API evidence.</p><details class="report-model-evidence"><summary>Show reference paths and assessment evidence</summary><p class="report-small">Changed type: <code>${escape(type.type)}</code></p>${referenceChains(paths)}${rationale(type.findings, "Why the type change is breaking:")}<p class="report-small">A lifecycle badge does not prove that a property is absent from the REST response schema.</p></details></div>`;
  };
  const downstreamBody =
    downstream.methods
      .map((method) => {
        const groupAnchors = method.group
          ? emitAnchor(`downstream-${anchor(method.group.id)}`) +
            method.findingIds
              .map(
                (id) =>
                  emitAnchor(`downstream-${anchor(id)}`) + emitAnchor(`finding-${anchor(id)}`),
              )
              .join("")
          : "";
        const constants = (["before", "after"] as const).flatMap((side) =>
          (method[side]?.operation?.parameters ?? [])
            .filter(
              (parameter) =>
                parameter.kind === "header" &&
                typeof parameter.type !== "string" &&
                parameter.type?.kind === "constant",
            )
            .map(
              (parameter) =>
                `${side === "before" ? "Baseline" : "Target"}: ${parameter.serializedName ?? parameter.name} (header): ${JSON.stringify(typeof parameter.type === "string" ? undefined : parameter.type?.value)}`,
            ),
        );
        const description = method.group
          ? "The normalized SDK method contract changes directly."
          : method.before &&
              method.after &&
              methodSignature(method.before) === methodSignature(method.after)
            ? "Method signature unchanged. The input/output model changes are compared below."
            : "The method is associated with changed SDK types; recorded signature evidence is shown below.";
        const beforeSignature = methodSignature(method.before);
        const afterSignature = methodSignature(method.after);
        const complete = beforeSignature !== "Not recorded" && afterSignature !== "Not recorded";
        const signature = `<div class="report-method-signature"><p class="report-small"><strong>Method signature</strong> <span class="report-badge ${complete ? "neutral" : "unknown"}">${complete ? (beforeSignature === afterSignature ? "Unchanged" : "Changed") : "Evidence incomplete"}</span></p><div class="report-signature-lines"><div><span>Before</span><code>${escape(beforeSignature)}</code></div><div><span>After</span><code>${escape(afterSignature)}</code></div></div></div>`;
        const targetOnly = ({ paths }: MethodPresentation["types"][number]) =>
          paths.length > 0 &&
          !paths.some((reference) => reference.role === "baseline") &&
          paths.some((reference) => reference.steps.some((step) => step.added));
        const primaryTypes = method.types.filter((reference) => !targetOnly(reference));
        const relatedTypes = method.types.filter(targetOnly);
        return `<details class="report-card sdk-method-card" id="${method.id}">${summary(escape(method.name), escape(description), `<span class="report-badge ${method.cause}">${method.cause === "mixed" ? "Mixed: direct + type change" : method.cause === "direct" ? "Direct method change" : "Indirect type change"}</span>`, affectedIntents(method.semanticIds))}<div class="report-card-body">${groupAnchors}${signature}${method.rows.length ? table(method.rows) : ""}${method.group ? rationale(method.group.deltas ?? []) : ""}${primaryTypes.map(({ type, paths }) => typeContent(type, paths, method)).join("")}${relatedTypes.length ? `<details class="report-model-evidence report-related-models"><summary>Show target-only related type changes (${relatedTypes.length})</summary>${relatedTypes.map(({ type, paths }) => typeContent(type, paths, method)).join("")}</details>` : ""}<details class="report-model-evidence"><summary>Show recorded SDK method evidence</summary><p class="report-small"><strong>${method.group?.after ? "Target normalized SDK method" : "Recorded normalized SDK method"}:</strong> <code>${escape(method.symbol)}</code></p>${constants.length ? `<p class="report-small"><strong>Constant headers (not numbered caller inputs):</strong> ${constants.map(escape).join("; ")}</p>` : ""}<p class="report-small">Language-neutral TCGC evidence is shown; generated language signatures are not fabricated.</p></details></div></details>`;
      })
      .join("") +
    downstream.unmapped
      .map(
        (type) =>
          `<details class="report-card sdk-contract-card">${summary(escape(type.type.split(".").at(-1)), "Confirmed SDK type finding retained without a deterministic SDK method mapping.", '<span class="report-badge unknown">Method mapping unavailable</span>', affectedIntents(type.semanticIds))}<div class="report-card-body">${typeContent(type)}</div></details>`,
      )
      .join("");

  const compliance = dimensions.compliance;
  const complianceFindings = [...(compliance.findings ?? []), ...(compliance.legacyFindings ?? [])];
  const guidelineCards = complianceFindingGroups(complianceFindings)
    .map(({ findings }) => {
      const first = findings[0];
      if (!first) return "";
      const ids = unique(
        findings.flatMap((finding) => [
          finding.semanticIntentId,
          ...(finding.relatedSemanticIntents ?? []),
        ]),
      );
      const gaps = unique(findings.map((finding) => finding.gap ?? finding.summary));

      const guidance: Map<
        string,
        {
          url: string;
          title: string;
          section?: string;
          examples?: string[];
          excerpts?: string[];
          snippets?: unknown[];
        }
      > = new Map();
      for (const finding of findings) {
        const intent = compliance.intentAssessments?.find(
          (item) => item.semanticIntentId === finding.semanticIntentId,
        );
        for (const applicable of finding.applicableGuidance ?? []) {
          const document = (compliance.sharedSearch?.documents ?? intent?.documents ?? []).find(
            (item) => item.canonicalUrl === applicable.canonicalDocumentUrl,
          );
          const section = document?.guidance?.find(
            (item) => item.section === applicable.guidanceSection,
          );
          const key = `${applicable.canonicalDocumentUrl}#${applicable.guidanceSection}`;
          const previous = guidance.get(key);
          guidance.set(key, {
            url: applicable.canonicalDocumentUrl,
            title: document?.title ?? "Official guidance",
            section: applicable.guidanceSection,
            examples: unique([...(previous?.examples ?? []), ...(section?.examples ?? [])]),
            excerpts: unique([...(previous?.excerpts ?? []), section?.excerpt]),
          });
        }
        const url = finding.canonicalDocumentUrl ?? finding.documentationUrl;
        if (url) {
          const document = compliance.legacyDocuments?.find((item) => item.url === url);
          guidance.set(url, {
            url,
            title: document?.title ?? "Official guidance",
            section: finding.section ?? document?.section,
            excerpts: unique([document?.guidanceExcerpt]),
            snippets: document?.expectedCodeSnippets,
          });
        }
      }
      const expected = unique(findings.map((finding) => finding.expected))
        .map((text) => `<p>${escape(text)}</p>`)
        .join("");
      const references = [...guidance.values()]
        .map(
          (item) =>
            `<div class="report-type-impact"><a href="${escape(item.url)}">${escape(item.title)}${item.section ? ` — ${escape(item.section)}` : ""}</a>${(item.excerpts ?? []).map((excerpt) => `<blockquote>${escape(excerpt)}</blockquote>`).join("")}${complianceCode(item.snippets ?? (item.examples ?? []).map((example) => ({ caption: "Documented TypeSpec example", url: item.url, lines: String(example).split(/\r?\n/) })))}</div>`,
        )
        .join("");
      const actual = findings
        .map((finding) => {
          const sources = finding.sourceLinks ?? finding.sourceReferences ?? [];
          const snippets = [
            ...new Map(
              (finding.codeSnippets ?? []).map((snippet) => [JSON.stringify(snippet), snippet]),
            ).values(),
          ].map((snippet) => {
            const source = sources.find((item) => item.path === snippet.path);
            return {
              ...snippet,
              startLine: snippet.startLine ?? source?.startLine,
              endLine: snippet.endLine ?? source?.endLine,
              link: snippet.link ?? source?.link,
            };
          });
          const text =
            finding.actual ??
            (Array.isArray(finding.evidence)
              ? finding.evidence.filter((item) => typeof item === "string").join("; ")
              : "");
          const sameDiff =
            snippets.some((snippet) => (snippet.lines ?? []).join("\n").trim() === text.trim()) ||
            (snippets.length > 0 &&
              snippets
                .flatMap((snippet) => snippet.lines ?? [])
                .join("\n")
                .trim() === text.trim());
          const links = unique(
            sources.map((source) => {
              const label = `${source.path}:${source.startLine ?? "?"}-${source.endLine ?? "?"}`;
              return source.link
                ? `<a href="${escape(source.link)}">${escape(label)}</a>`
                : `<code>${escape(label)}</code>`;
            }),
          ).join(", ");
          return `<div class="report-type-impact" id="compliance-finding-${anchor(finding.id)}">${findings.length > 1 ? `<h4>${intentLinks([finding.semanticIntentId, ...(finding.relatedSemanticIntents ?? [])])}</h4>` : ""}${gaps.length > 1 ? `<p>${escape(finding.gap ?? finding.summary)}</p>` : ""}${sameDiff ? "" : `<p>${escape(text)}</p>`}${links ? `<p class="sources">${links}</p>` : ""}${complianceCode(snippets)}</div>`;
        })
        .join("");
      return `<details class="report-card compliance-finding${findings.length > 1 ? " compliance-finding-group" : ""}">${summary(escape(first.title), escape(gaps.length === 1 ? gaps[0] : `${ids.length} intents do not follow this guidance.`), status("failed"), affectedIntents(ids))}<div class="report-card-body"><div class="report-guideline-section expected-details"><h3>Expected</h3>${expected}${references}</div><div class="report-guideline-section actual-details"><h3>Actual</h3>${actual}</div></div></details>`;
    })
    .join("");
  const noGuidance = (compliance.intentAssessments ?? [])
    .filter((item) => item.decision === "no-applicable-guidance")
    .map((item) => item.semanticIntentId);
  const unassessed = compliance.coverage?.unassessedIntentIds ?? [];
  const guidelineBody =
    guidelineCards ||
    `<div class="report-empty">${compliance.status === "not-assessed" ? "Azure Guidelines could not be fully assessed." : "No Azure Guidelines findings."}</div>`;
  const coverage = compliance.coverage;
  const documentQuality = dimensions.documentQuality ?? {};
  const documentBody = renderDocumentQuality(documentQuality, {
    escapeHtml: escape,
    sectionHead,
    status,
    count,
    summary,
    affectedIntents,
    intentLinks,
    intentTitle: (id) => intentById.get(id)?.title ?? id,
    intentSources: (id) => intentById.get(id)?.sources ?? [],
  });

  const semanticBody = items
    .map((item) => {
      const related = item.relatedFindings ?? {};
      const restLinks = restCards
        .filter(
          (entry) =>
            entry.semanticIds.includes(item.id) ||
            entry.findings.some((finding) => related.rest?.includes(finding.id)),
        )
        .map(
          (entry) =>
            `<a class="report-link impact" href="#${entry.id}">REST: ${escape(entry.operation.operationId)}</a>`,
        );
      for (const finding of restFindings.filter(
        (finding) =>
          !mappedRest.has(finding.id) &&
          (finding.relatedSemanticIntents?.includes(item.id) || related.rest?.includes(finding.id)),
      )) {
        restLinks.push(
          `<a class="report-link impact" href="#finding-${anchor(finding.id)}">REST: ${escape(finding.rule)}</a>`,
        );
      }
      for (const finding of dimensions.rest.legacyFindings ?? []) {
        if (finding.relatedSemanticIntents?.includes(item.id) || related.rest?.includes(finding.id))
          restLinks.push(
            `<a class="report-link impact" href="#finding-${anchor(finding.id)}">REST: ${escape(finding.title ?? finding.rule)}</a>`,
          );
      }
      const downstreamLinks = downstream.methods
        .filter(
          (method) =>
            method.semanticIds.includes(item.id) ||
            (method.group !== undefined && related.downstream?.includes(method.group.id)),
        )
        .map(
          (method) =>
            `<a class="report-link impact" href="#${method.id}">Downstream: ${escape(method.name)}</a>`,
        );
      for (const type of downstream.unmapped.filter((type) => type.semanticIds.includes(item.id)))
        downstreamLinks.push(
          `<a class="report-link impact" href="#${type.anchorId}">Downstream: ${escape(type.type.split(".").at(-1))} (SDK type)</a>`,
        );
      const impactLinks = unique([...restLinks, ...downstreamLinks]);
      const guidelineIds = unique(
        complianceFindings
          .filter(
            (finding) =>
              finding.semanticIntentId === item.id ||
              finding.relatedSemanticIntents?.includes(item.id) ||
              related.compliance?.includes(finding.id),
          )
          .map((finding) => finding.id),
      );
      const documentFindings = (documentQuality.findings ?? []).filter(
        (finding) =>
          finding.reviewUnitId === item.id || finding.semanticIntentIds?.includes(item.id),
      );
      const documentLinks = unique(
        documentFindings.map(
          (finding) =>
            `<a class="report-link impact" href="#document-quality-${anchor(finding.id)}">Documentation Completeness: ${escape(finding.title)}</a>`,
        ),
      );
      const impactCount = impactLinks.length + documentLinks.length;
      const relations =
        impactCount || guidelineIds.length
          ? `<div class="report-intent-relations">${impactCount ? `<span class="report-relation-label" title="REST, downstream, and failed Documentation Completeness impacts">Impacts (${impactCount})</span>` : ""}${impactLinks.length ? `<div class="report-link-row" aria-label="Intent impacts">${impactLinks.join("")}</div>` : ""}${guidelineIds.length ? `<div class="report-link-row" aria-label="Guideline findings">${guidelineIds.map((id, index) => `<a class="report-link" href="#compliance-finding-${anchor(id)}">Azure Guidelines${guidelineIds.length > 1 ? ` (${index + 1})` : ""}</a>`).join("")}</div>` : ""}${documentLinks.length ? `<div class="report-link-row" aria-label="Documentation Completeness findings">${documentLinks.join("")}</div>` : ""}</div>`
          : "";
      const all = item.operations ?? [];
      const operations = all
        .slice(0, 10)
        .map((operation) => {
          const rows = operationContractRows(operation, restFindings, item.id);
          const displayRows = rows.map((row) => {
            const parts = contractAreaParts(row);
            return { ...row, area: parts.areaKind, label: parts.member };
          });
          return `<details class="operation"><summary><strong>${escape(operation.operationId)}</strong><span class="report-http">${escape((operation.method ?? "").toUpperCase())}</span><code>${escape(operation.path)}</code><span>${escape(operation.apiVersion ?? "")}</span></summary><div class="operation-body">${rows.length ? table(displayRows) : ""}<p>${escape(operation.outcome ?? (rows.length ? "Recorded contract changes." : "HTTP signature and represented payload contract unchanged."))}</p></div></details>`;
        })
        .join("");
      const remainder = all.slice(10);
      const grouping = semanticGroupingPresentation(item);
      const facts = item.changeFacts ?? [];
      const factRows = facts
        .map(
          (fact) =>
            `<tr><td><code>${escape(fact.qualifiedName ?? "(source/configuration)")}</code></td><td>${escape(fact.changeType)}</td><td>${escape(fact.action)}</td><td>${escape(fact.facets.join(", "))}</td><td><code>${escape(fact.sourceChangeId)}</code><br><span class="report-small">hunks: ${escape(fact.hunkIds.join(", ") || "none")}<br>declarations: ${escape(fact.declarationIds.join(", ") || "none")}</span></td></tr>`,
        )
        .join("");
      const changeBadges = (item.changeTypes ?? [])
        .map((changeType) => `<span class="report-badge">${escape(changeType)}</span>`)
        .join("");
      const groupingDetails = `<p class="report-small"><strong>Stable group:</strong> <code>${escape(item.id)}</code></p><p class="report-small"><strong>${escape(grouping.basis)}:</strong> deterministic coordinator grouping; later judgment and rendering preserve this identity and boundary. ${facts.length} normalized facts; ${item.hunkIds?.length ?? 0} source hunks; ${all.length} supporting operation mappings.</p>${grouping.notice ? `<p class="report-empty">${escape(grouping.notice)}</p>` : ""}${item.groupingEvidence?.reasons?.length ? `<p class="report-small"><strong>Grouping diagnostics:</strong> ${item.groupingEvidence.reasons.map((reason) => `<code>${escape(reason)}</code>`).join("; ")}</p>` : ""}${facts.length ? `<details class="report-subdetails"><summary>Change facts and provenance (${facts.length})</summary><table><thead><tr><th>Subject</th><th>Change type</th><th>Action</th><th>Facets</th><th>Evidence provenance</th></tr></thead><tbody>${factRows}</tbody></table></details>` : ""}`;
      const badges = `<span class="report-badge">${escape(grouping.label)}</span><span class="report-badge ${escape(item.action)}">${escape(item.action)}</span>${changeBadges}`;
      return `<details class="report-card intent" id="intent-${anchor(item.id)}">${summary(escape(item.title), escape(item.summary), badges, relations)}<div class="report-card-body">${groupingDetails}${item.sources?.length ? `<details class="report-source" open><summary>Changed TypeSpec source (${item.sources.length})</summary>${renderSourceHunks(item.sources)}<p class="sources">${sourceLinks(item.sources)}</p></details>` : '<p class="sources">Changed TypeSpec source unavailable.</p>'}<details class="report-subdetails" id="intent-${anchor(item.id)}-operations"><summary>Affected operations (${all.length})</summary>${remainder.length ? `<p class="report-small">Showing 10 operation cards; the remaining ${remainder.length} are listed below.</p>` : ""}${operations || '<p class="report-empty">No directly affected REST operation.</p>'}${remainder.length ? `<div class="report-operation-remainder"><p><strong>Other affected operations (${remainder.length})</strong></p><p>${remainder.map((operation) => `<span title="${escape(operation.path)}">${escape(operation.operationId)} (${escape((operation.method ?? "").toUpperCase())}${operation.apiVersion ? `, ${escape(operation.apiVersion)}` : ""})</span>`).join("; ")}.</p></div>` : ""}</details></div></details>`;
    })
    .join("");
  const restStatus =
    dimensions.rest.status ??
    (restFindings.length || dimensions.rest.legacyFindings?.length ? "failed" : "not-assessed");
  const downstreamStatus =
    dimensions.downstream.status ??
    (downstream.methods.length ||
    downstream.types.length ||
    dimensions.downstream.legacyFindings?.length
      ? "failed"
      : "not-assessed");
  const restCount =
    restCards.length +
    restFindings.filter((finding) => !mappedRest.has(finding.id)).length +
    (dimensions.rest.legacyFindings?.length ?? 0);
  const downstreamCount = downstream.methods.length + downstream.unmapped.length;
  // Semantic intents describe changes, not findings. Stable sorting preserves the header order within each group.
  const sections = [
    {
      findingCount: 0,
      html: `<section id="semantic-intents">${sectionHead("Semantic intents", "Impact links are visible at a glance; expand for changed TypeSpec source, followed by affected operations.", count(`${items.length} intents · ${items.filter((item) => item.action === "add").length} added · ${items.filter((item) => item.action === "modify").length} modified · ${items.filter((item) => item.action === "remove").length} removed`))}${semanticBody || '<div class="report-empty">No semantic intents.</div>'}</section>`,
    },
    {
      findingCount: complianceFindings.length,
      html: `<section id="azure-compliance">${sectionHead("Azure Guidelines", "Findings and affected intents at a glance; expand for expected guidance and actual changes.", status(compliance.status) + count(`${complianceFindings.length} findings`))}${coverage ? `<p class="report-small">${coverage.assessedIntentCount} of ${coverage.semanticIntentCount} semantic intents assessed · ${coverage.selectedDocumentCount} documents selected</p>` : ""}${guidelineBody}${noGuidance.length ? `<p class="report-small">No applicable guideline was found for: ${intentLinks(noGuidance)}.</p>` : ""}${unassessed.length ? `<div class="report-empty">Azure Guidelines not assessed for: ${intentLinks(unassessed)}</div>` : ""}</section>`,
    },
    {
      findingCount: restCount,
      html: `<section id="rest-breaking">${sectionHead("REST breaking changes", "Compatibility verdict and confirmed findings.", status(dimensions.rest.verdict ?? restStatus) + count(`${restCards.length} operations · ${restFindings.length + (dimensions.rest.legacyFindings?.length ?? 0)} findings`))}${restBody || `<div class="report-empty">${restStatus === "not-assessed" ? "No REST compatibility verdict is available for the covered scope." : "No confirmed REST breaking changes."}</div>`}</section>`,
    },
    {
      findingCount: downstreamCount,
      html: `<section id="downstream-breaking">${sectionHead("Downstream breaking changes", "Compatibility verdict and confirmed findings.", status(dimensions.downstream.verdict ?? downstreamStatus) + count(`${downstream.methods.length} mapped methods · ${downstream.types.length} changed types`))}${downstreamBody || `<div class="report-empty">${downstreamStatus === "not-assessed" ? "No downstream compatibility verdict is available for the covered scope." : "No downstream breaking changes detected."}</div>`}</section>`,
    },
    { findingCount: documentQuality.findings?.length ?? 0, html: documentBody.html },
  ];
  sections.sort((left, right) => Number(right.findingCount > 0) - Number(left.findingCount > 0));
  return {
    restCount,
    downstreamCount,
    hasFindings: sections.some((section) => section.findingCount > 0),
    appendixHtml: documentBody.appendixHtml,
    html: sections.map((section) => section.html).join("\n"),
  };
}
