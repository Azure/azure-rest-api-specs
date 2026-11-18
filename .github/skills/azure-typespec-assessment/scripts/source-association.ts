import fs from "node:fs";
import path from "node:path";
import { isDeepStrictEqual } from "node:util";
import { readJsonObject } from "./cli.ts";
import { stableId } from "./stable-id.ts";
import { restContractIdentity } from "./assessment-display.ts";
import { verifyAssessmentRuntime, verifyRuntimePhaseProvenance } from "./assessment-runtime.ts";
import {
  atomicWriteFile,
  atomicWriteJson,
  comparisonIdentity,
  hashArtifacts,
  readWorkflowState,
  resolveWorkPath,
  sha256File,
  transitionWorkflowState,
  verifyArtifactHashes,
} from "./workflow-state.ts";
import type {
  AssessmentFact,
  AssessmentInference,
  AssessmentJudgment,
  AssessmentModelInput,
  BreakingAnalysis,
  BreakingCandidate,
  DownstreamAnalysis,
  DownstreamCandidate,
  InferenceCandidate,
  SemanticAnalysis,
  SourceChange,
  SourceDeclaration,
  SourceIndex,
  SourceReviewDecision,
} from "./runtime-types.ts";

export const SOURCE_ASSOCIATION_INPUT = "agent-workspace/source-association-input.json";
export const SOURCE_ASSOCIATION_DECISIONS_DRAFT =
  "agent-workspace/source-association-decisions.draft.json";
export const SOURCE_ASSOCIATION_DECISIONS = "agent-workspace/source-association-decisions.json";
export const SOURCE_ASSOCIATION_OUTPUT = "source-association.json";
const SOURCE_QUERIES_DIR = "agent-workspace/source-queries";
const DEFAULT_KEEP_RATIONALE = "Kept deterministic source proposal.";

type Candidate = BreakingCandidate | DownstreamCandidate | InferenceCandidate;
type Outcome = "keep" | "refine" | "associate" | "unresolved";
type Selection = {
  itemId: string;
  outcome: Outcome;
  selectedDeclarationIds: string[];
  rationale: string;
};
export type SourceAssociationInput = {
  schemaVersion: 1;
  comparisonIdentity: ReturnType<typeof comparisonIdentity>;
  judgmentHash: string;
  sourceIndexHash: string;
  items: {
    id: string;
    dimension: "rest" | "downstream";
    findingIds: string[];
    contractIdentity: string;
    sourceContextId: string;
    deltas: {
      findingId: string;
      rule: string;
      actual: string;
      expected: string;
      rationale: string;
    }[];
    proposal: { status: "associated" | "unresolved"; declarationIds: string[]; basis: string };
    allowedSourceChangeIds: string[];
    availableDeclarationNames?: string[];
  }[];
  sourceContexts: Record<string, string[]>;
  declarations: Record<string, { sourceChangeId: string; declaration: SourceDeclaration }>;
  facts: Record<string, AssessmentFact>;
};
export type SourceAssociationResult = {
  schemaVersion: 1;
  judgmentHash: string;
  sourceIndexHash: string;
  inputHash?: string;
  status: "complete" | "partial" | "not-applicable";
  reviews: Record<string, SourceReviewDecision>;
};
export type SourceAssociationHandoff =
  | {
      status: "ready-for-finalization";
      sourceAssociationRequired: false;
      itemCount: 0;
      outputPath: string;
    }
  | {
      status: "awaiting-source-association";
      sourceAssociationRequired: true;
      itemCount: number;
      inputPath: string;
      decisionsPath: string;
      draftPath: string;
    };
export type SourceDeclarationQueryResult = {
  itemId: string;
  qualifiedName: string;
  judgmentHash: string;
  sourceIndexHash: string;
  status: "matched" | "unresolved";
  reason: string;
  declarations: { sourceChangeId: string; declaration: SourceDeclaration }[];
};

function exact(expected: string[], actual: string[], label: string) {
  if (
    new Set(actual).size !== actual.length ||
    actual.some((id) => !expected.includes(id)) ||
    expected.some((id) => !actual.includes(id))
  ) {
    throw new Error(`${label} coverage mismatch.`);
  }
}
function keys(value: Record<string, unknown>, allowed: string[], label: string) {
  if (Object.keys(value).some((key) => !allowed.includes(key)))
    throw new Error(`${label} contains unknown fields.`);
}
function checkedSelection(value: unknown): Selection {
  if (!value || typeof value !== "object" || Array.isArray(value))
    throw new Error("Invalid source selection.");
  const entry = value as Record<string, unknown>;
  keys(entry, ["itemId", "outcome", "selectedDeclarationIds", "rationale"], "Source selection");
  const outcome = String(entry.outcome);
  if (
    typeof entry.itemId !== "string" ||
    !entry.itemId ||
    !Array.isArray(entry.selectedDeclarationIds) ||
    !["keep", "refine", "associate", "unresolved"].includes(outcome)
  ) {
    throw new Error("Invalid source selection fields.");
  }
  const selectedDeclarationIds = entry.selectedDeclarationIds.filter(
    (id): id is string => typeof id === "string" && id.length > 0,
  );
  if (selectedDeclarationIds.length !== entry.selectedDeclarationIds.length) {
    throw new Error("Invalid source selection fields.");
  }
  let rationale: string;
  if (entry.rationale === undefined) {
    if (outcome !== "keep") {
      throw new Error(`Source selection ${entry.itemId} (${outcome}) requires a rationale.`);
    }
    rationale = DEFAULT_KEEP_RATIONALE;
  } else if (typeof entry.rationale === "string" && entry.rationale.trim()) {
    rationale = entry.rationale;
  } else {
    throw new Error("Invalid source selection rationale.");
  }
  return {
    itemId: entry.itemId,
    outcome: outcome as Outcome,
    selectedDeclarationIds,
    rationale,
  };
}
function canonical(work: string) {
  const state = readWorkflowState(work);
  const frozen = state?.judgmentArtifactHashes;
  if (
    !frozen ||
    typeof frozen !== "object" ||
    Array.isArray(frozen) ||
    !Object.values(frozen).every((value) => typeof value === "string")
  ) {
    throw new Error("Missing frozen judgment hashes; materialize judgment first.");
  }
  const errors = [
    ...verifyArtifactHashes(work, state?.artifactHashes),
    ...verifyArtifactHashes(work, frozen as Record<string, string>),
  ];
  const queries = state?.sourceQueryHashes;
  if (queries !== undefined) {
    if (
      !queries ||
      typeof queries !== "object" ||
      Array.isArray(queries) ||
      !Object.values(queries).every((value) => typeof value === "string")
    ) {
      throw new Error("Invalid registered source query hashes.");
    }
    errors.push(...verifyArtifactHashes(work, queries as Record<string, string>));
  }
  if (errors.length) throw new Error(`Frozen assessment inputs changed.\n${errors.join("\n")}`);
  const runtime = verifyAssessmentRuntime(work, import.meta.url);
  verifyRuntimePhaseProvenance(work, "materialization", runtime);
  const judgment = readJsonObject(
    resolveWorkPath(work, "assessment-judgment.json"),
  ) as unknown as AssessmentJudgment;
  const model = readJsonObject(
    resolveWorkPath(work, "model-input.json"),
  ) as unknown as AssessmentModelInput;
  if (judgment.pipelineVersion !== 2 || model.pipelineVersion !== 2) {
    throw new Error("Source association requires pipelineVersion 2.");
  }
  const sourcePath = model.artifactReferences.sourceIndex;
  const source = readJsonObject(resolveWorkPath(work, sourcePath)) as unknown as SourceIndex;
  return {
    state,
    judgment,
    model,
    source,
    judgmentHash: sha256File(resolveWorkPath(work, "assessment-judgment.json")),
    sourceIndexHash: sha256File(resolveWorkPath(work, sourcePath)),
  };
}
function declarationRecord(sources: SourceChange[]) {
  return new Map(
    sources.flatMap((source) =>
      source.declarations.map(
        (declaration) => [declaration.id, { sourceChangeId: source.id, declaration }] as const,
      ),
    ),
  );
}

export function prepareSourceAssociation({ work }: { work: string }): SourceAssociationHandoff {
  const started = performance.now();
  const root = path.resolve(work);
  const frozen = canonical(root);
  fs.rmSync(resolveWorkPath(root, SOURCE_QUERIES_DIR), { recursive: true, force: true });
  fs.rmSync(resolveWorkPath(root, SOURCE_ASSOCIATION_INPUT), { force: true });
  fs.rmSync(resolveWorkPath(root, SOURCE_ASSOCIATION_DECISIONS_DRAFT), { force: true });
  fs.rmSync(resolveWorkPath(root, SOURCE_ASSOCIATION_OUTPUT), { force: true });

  const approvedDecisions = [
    ...frozen.judgment.restDecisions,
    ...frozen.judgment.downstreamDecisions,
  ].filter((entry) => entry.decision === "approve");
  const priorArtifacts =
    frozen.state?.artifacts && typeof frozen.state.artifacts === "object"
      ? (frozen.state.artifacts as Record<string, unknown>)
      : {};

  if (!approvedDecisions.length) {
    fs.rmSync(resolveWorkPath(root, SOURCE_ASSOCIATION_DECISIONS), { force: true });
    const outputPath = resolveWorkPath(root, SOURCE_ASSOCIATION_OUTPUT);
    const result: SourceAssociationResult = {
      schemaVersion: 1,
      judgmentHash: frozen.judgmentHash,
      sourceIndexHash: frozen.sourceIndexHash,
      status: "not-applicable",
      reviews: {},
    };
    atomicWriteJson(outputPath, result);
    transitionWorkflowState(root, "ready-for-finalization", {
      sourceInputHash: undefined,
      sourceQueryHashes: {},
      sourceResultHash: sha256File(outputPath),
      artifacts: {
        ...priorArtifacts,
        sourceAssociationInput: null,
        sourceAssociationDecisionsDraft: null,
        sourceAssociationDecisions: null,
        sourceAssociation: SOURCE_ASSOCIATION_OUTPUT,
      },
      failure: undefined,
      telemetry: {
        sourceInputBuildMs: Math.round(performance.now() - started),
        sourceInputBytes: 0,
        sourceItems: 0,
        sourceMaterializationMs: 0,
        sourceAssociationStatus: "not-applicable",
      },
    });
    return {
      status: "ready-for-finalization",
      sourceAssociationRequired: false,
      itemCount: 0,
      outputPath,
    };
  }

  const rest = readJsonObject(
    resolveWorkPath(root, frozen.model.artifactReferences.restCandidates),
  ) as unknown as BreakingAnalysis;
  const downstream = readJsonObject(
    resolveWorkPath(root, frozen.model.artifactReferences.downstreamCandidates),
  ) as unknown as DownstreamAnalysis;
  const semantic = readJsonObject(
    resolveWorkPath(root, frozen.model.artifactReferences.semanticReviewUnits),
  ) as unknown as SemanticAnalysis;
  const inferencePath = resolveWorkPath(root, "inference.json");
  const inference = fs.existsSync(inferencePath)
    ? (readJsonObject(inferencePath) as unknown as AssessmentInference)
    : undefined;
  const inferred = (inference?.results ?? []).flatMap((result) => result.candidates);
  const candidates = new Map<string, Candidate>(
    [...rest.candidates, ...downstream.candidates, ...inferred].map((candidate) => [
      candidate.id,
      candidate,
    ]),
  );
  const facts = { ...frozen.model.facts, ...rest.facts, ...downstream.facts };
  const registered = declarationRecord(frozen.source.sourceChanges);
  const groups = new Map<
    string,
    {
      dimension: "rest" | "downstream";
      identity: string;
      findings: Candidate[];
      allowedSourceIds: Set<string>;
      proposalIds: Set<string>;
      basis: string;
    }
  >();

  for (const dimension of ["rest", "downstream"] as const) {
    const decisions =
      dimension === "rest" ? frozen.judgment.restDecisions : frozen.judgment.downstreamDecisions;
    for (const decision of decisions.filter((entry) => entry.decision === "approve")) {
      const candidate = candidates.get(decision.candidateId);
      if (!candidate) throw new Error(`Unknown frozen finding ${decision.candidateId}.`);
      const evidence = candidate.evidenceFactIds
        .map((id) => facts[id])
        .filter((fact): fact is AssessmentFact => Boolean(fact));
      const fact = evidence.find((fact) => fact.comparisonRole === "target") ?? evidence[0];
      const reportedIdentity =
        dimension === "rest"
          ? restContractIdentity({
              operationIds: candidate.operationIds,
              evidence,
              rule: candidate.rule,
              contractChange: "contractChange" in candidate ? candidate.contractChange : undefined,
            })
          : (candidate.crossLanguageDefinitionId ?? candidate.id);
      const identity =
        reportedIdentity === "Unmapped REST contract change" ? candidate.id : reportedIdentity;
      const key = `${dimension}:${fact?.projectId ?? ""}:${identity}`;
      const group = groups.get(key) ?? {
        dimension,
        identity,
        findings: [],
        allowedSourceIds: new Set<string>(),
        proposalIds: new Set<string>(),
        basis: "rule-aware owner from canonical contract evidence; source proposal is reviewable",
      };
      group.findings.push(candidate);
      const operations = semantic.reviewUnits
        .filter(
          (unit) =>
            !fact?.projectId ||
            unit.projectId === fact.projectId ||
            unit.projectIds?.includes(fact.projectId),
        )
        .flatMap((unit) =>
          (unit.operations ?? []).filter(
            (operation) =>
              !fact?.projectId ||
              operation.projectId === fact.projectId ||
              (!operation.projectId &&
                unit.projectId === fact.projectId &&
                (!unit.projectIds?.length ||
                  unit.projectIds.every((projectId) => projectId === fact.projectId))),
          ),
        )
        .filter((operation) => candidate.operationIds?.includes(operation.operationId));
      const operationSources = new Set(
        operations.flatMap((operation) => operation.sourceChangeIds),
      );
      const operationHunks = new Set(operations.flatMap((operation) => operation.hunkIds));
      const exactNamed = [...registered.values()].filter(
        ({ sourceChangeId, declaration }) =>
          (!candidate.sourceChangeIds.length ||
            candidate.sourceChangeIds.includes(sourceChangeId)) &&
          declaration.kind !== "property" &&
          (declaration.qualifiedName === identity ||
            declaration.qualifiedName === identity.split(".").at(-1)),
      );
      const selected =
        !candidate.operationIds?.includes(identity) && exactNamed.length
          ? exactNamed
          : [...registered.values()].filter(
              ({ sourceChangeId, declaration }) =>
                operationSources.has(sourceChangeId) &&
                declaration.kind === "operation" &&
                declaration.hunkIds.some((id) => operationHunks.has(id)),
            );
      if (
        !selected.length &&
        dimension === "downstream" &&
        candidate.rule === "public-surface-changed" &&
        evidence.some((item) => item.comparisonRole === "baseline") &&
        !evidence.some((item) => item.comparisonRole === "target")
      ) {
        const declarationIds = new Set(candidate.declarationIds ?? []);
        const hunkIds = new Set(candidate.hunkIds ?? []);
        selected.push(
          ...[...registered.values()].filter(
            ({ sourceChangeId, declaration }) =>
              candidate.sourceChangeIds.includes(sourceChangeId) &&
              declarationIds.has(declaration.id) &&
              declaration.kind === "operation" &&
              declaration.hunkIds.some((id) => hunkIds.has(id)),
          ),
        );
      }
      if (!selected.length && candidate.id.startsWith("inferred-") && candidate.hunkIds?.length) {
        const hunkIds = new Set(candidate.hunkIds);
        selected.push(
          ...[...registered.values()].filter(
            ({ sourceChangeId, declaration }) =>
              candidate.sourceChangeIds.includes(sourceChangeId) &&
              declaration.kind !== "property" &&
              declaration.hunkIds.some((id) => hunkIds.has(id)),
          ),
        );
      }
      for (const entry of selected) {
        group.proposalIds.add(entry.declaration.id);
        group.allowedSourceIds.add(entry.sourceChangeId);
      }
      if (!selected.length) {
        for (const id of candidate.sourceChangeIds) group.allowedSourceIds.add(id);
      }
      if (operations.length)
        group.basis = "canonical Semantic operation mapping and declaration spans";
      groups.set(key, group);
    }
  }
  const sourcesById = new Map(frozen.source.sourceChanges.map((source) => [source.id, source]));
  const input: SourceAssociationInput = {
    schemaVersion: 1,
    comparisonIdentity: comparisonIdentity(frozen.model),
    judgmentHash: frozen.judgmentHash,
    sourceIndexHash: frozen.sourceIndexHash,
    items: [],
    sourceContexts: {},
    declarations: {},
    facts: {},
  };
  for (const group of groups.values()) {
    const ids = [...group.proposalIds].sort();
    const contextId = stableId("source-context", ids);
    input.sourceContexts[contextId] = ids;
    for (const id of ids) {
      const declaration = registered.get(id);
      if (!declaration) throw new Error(`Unknown canonical declaration ${id}.`);
      input.declarations[id] = declaration;
    }
    const findingIds = group.findings.map((finding) => finding.id).sort();
    for (const finding of group.findings) {
      for (const id of finding.evidenceFactIds) {
        const fact = frozen.model.facts?.[id];
        if (!fact)
          throw new Error(`Confirmed finding ${finding.id} is missing compact evidence ${id}.`);
        input.facts[id] = fact;
      }
    }
    const allowedSourceChangeIds = [...group.allowedSourceIds].sort();
    let availableDeclarationNames: string[] | undefined;
    if (!ids.length && allowedSourceChangeIds.length) {
      const allowedDeclarations = allowedSourceChangeIds.flatMap(
        (sourceId) => sourcesById.get(sourceId)?.declarations ?? [],
      );
      const nonPropertyNames = [
        ...new Set(
          allowedDeclarations
            .filter((declaration) => declaration.kind !== "property")
            .map((declaration) => declaration.qualifiedName),
        ),
      ].sort();
      const candidateNames = nonPropertyNames.length
        ? nonPropertyNames
        : [...new Set(allowedDeclarations.map((declaration) => declaration.qualifiedName))].sort();
      if (candidateNames.length && candidateNames.length <= 64) {
        availableDeclarationNames = candidateNames;
      }
    }
    input.items.push({
      id: stableId("source-association", { dimension: group.dimension, findingIds }),
      dimension: group.dimension,
      findingIds,
      contractIdentity: group.identity,
      sourceContextId: contextId,
      proposal: {
        status: ids.length ? "associated" : "unresolved",
        declarationIds: ids,
        basis: group.basis,
      },
      allowedSourceChangeIds,
      ...(availableDeclarationNames ? { availableDeclarationNames } : {}),
      deltas: group.findings.map((finding) => {
        const decision = [
          ...frozen.judgment.restDecisions,
          ...frozen.judgment.downstreamDecisions,
        ].find((decision) => decision.candidateId === finding.id);
        if (!decision) throw new Error(`Missing frozen decision ${finding.id}.`);
        return {
          findingId: finding.id,
          rule: finding.rule,
          actual: finding.actual,
          expected: finding.expected,
          rationale: decision.rationale,
        };
      }),
    });
  }
  input.items.sort((a, b) => a.id.localeCompare(b.id));
  const serializedInput = JSON.stringify(input);
  if (Buffer.byteLength(serializedInput) > 1024 * 1024) {
    throw new Error(
      "Source association input exceeds the 1 MiB bound; narrow proven contexts before invoking source AI.",
    );
  }
  const inputPath = resolveWorkPath(root, SOURCE_ASSOCIATION_INPUT);
  const draftPath = resolveWorkPath(root, SOURCE_ASSOCIATION_DECISIONS_DRAFT);
  const decisionsPath = resolveWorkPath(root, SOURCE_ASSOCIATION_DECISIONS);
  atomicWriteFile(inputPath, serializedInput);
  atomicWriteJson(draftPath, {
    schemaVersion: 1,
    judgmentHash: input.judgmentHash,
    sourceIndexHash: input.sourceIndexHash,
    selections: input.items.map((item) => ({
      itemId: item.id,
      outcome: "__UNRESOLVED__",
      selectedDeclarationIds: item.proposal.declarationIds,
      ...(item.proposal.status === "unresolved" ? { rationale: "" } : {}),
    })),
  });
  const inputHash = sha256File(inputPath);
  transitionWorkflowState(root, "awaiting-source-association", {
    sourceInputHash: inputHash,
    sourceQueryHashes: {},
    sourceResultHash: undefined,
    artifacts: {
      ...priorArtifacts,
      sourceAssociationInput: SOURCE_ASSOCIATION_INPUT,
      sourceAssociationDecisionsDraft: SOURCE_ASSOCIATION_DECISIONS_DRAFT,
      sourceAssociationDecisions: null,
      sourceAssociation: null,
    },
    failure: undefined,
    telemetry: {
      sourceInputBuildMs: Math.round(performance.now() - started),
      sourceInputBytes: Buffer.byteLength(JSON.stringify(input)),
      sourceItems: input.items.length,
    },
  });
  return {
    status: "awaiting-source-association",
    sourceAssociationRequired: true,
    itemCount: input.items.length,
    inputPath,
    decisionsPath,
    draftPath,
  };
}

export const buildSourceAssociation = prepareSourceAssociation;

function checkedInput(work: string) {
  const frozen = canonical(work);
  const inputPath = resolveWorkPath(work, SOURCE_ASSOCIATION_INPUT);
  const input = readJsonObject(inputPath) as unknown as SourceAssociationInput;
  if (
    input.schemaVersion !== 1 ||
    input.judgmentHash !== frozen.judgmentHash ||
    input.sourceIndexHash !== frozen.sourceIndexHash ||
    sha256File(inputPath) !== frozen.state?.sourceInputHash
  ) {
    throw new Error("Source association input does not match frozen judgment/source hashes.");
  }
  return { frozen, input };
}

function matchScopedDeclarations(
  sources: SourceChange[],
  allowedSourceChangeIds: string[],
  qualifiedName: string,
): {
  matches: { sourceChangeId: string; declaration: SourceDeclaration }[];
  reason: string;
} {
  const allowedSources = sources.filter((source) => allowedSourceChangeIds.includes(source.id));
  const exactMatches = allowedSources.flatMap((source) =>
    source.declarations
      .filter((declaration) => declaration.qualifiedName === qualifiedName)
      .map((declaration) => ({ sourceChangeId: source.id, declaration })),
  );
  if (exactMatches.length) {
    return {
      matches: exactMatches,
      reason: "Exact canonical declaration name within the item source scope.",
    };
  }
  if (qualifiedName.includes(".")) {
    const shortName = qualifiedName.split(".").at(-1);
    const memberSuffix = qualifiedName.split(".").slice(-2).join(".");
    const fallbackMatches = allowedSources.flatMap((source) =>
      source.declarations
        .filter((declaration) =>
          declaration.kind === "operation" || declaration.kind === "property"
            ? declaration.qualifiedName === memberSuffix
            : !["enum-member", "union-variant"].includes(declaration.kind) &&
              declaration.qualifiedName === shortName,
        )
        .map((declaration) => ({ sourceChangeId: source.id, declaration })),
    );
    if (fallbackMatches.length) {
      return {
        matches: fallbackMatches,
        reason:
          "Namespace-qualified suffix matched canonical declaration within the item source scope.",
      };
    }
  } else {
    const shortMatches = allowedSources.flatMap((source) =>
      source.declarations
        .filter(
          (declaration) =>
            !["enum-member", "union-variant", "property"].includes(declaration.kind) &&
            declaration.qualifiedName.endsWith(`.${qualifiedName}`),
        )
        .map((declaration) => ({ sourceChangeId: source.id, declaration })),
    );
    if (shortMatches.length) {
      return {
        matches: shortMatches,
        reason:
          "Unqualified declaration name matched canonical declaration within the item source scope.",
      };
    }
  }
  return {
    matches: [],
    reason: "No matching canonical declaration found within the item source scope.",
  };
}

export function querySourceAssociationBatch({
  work,
  queries,
}: {
  work: string;
  queries: { itemId: string; qualifiedName: string }[];
}): { queries: SourceDeclarationQueryResult[] } {
  const root = path.resolve(work);
  if (!queries.length) {
    throw new Error("At least one source declaration query is required.");
  }
  const { input, frozen } = checkedInput(root);
  const results: SourceDeclarationQueryResult[] = [];
  const writtenPaths: string[] = [];

  for (const request of queries) {
    const itemId = request.itemId?.trim();
    const qualifiedName = request.qualifiedName?.trim();
    const item = input.items.find((entry) => entry.id === itemId);
    if (!item || !qualifiedName) {
      throw new Error("Unknown source item or empty declaration name.");
    }
    const { matches, reason } = matchScopedDeclarations(
      frozen.source.sourceChanges,
      item.allowedSourceChangeIds,
      qualifiedName,
    );
    const entry: SourceDeclarationQueryResult = {
      itemId: item.id,
      qualifiedName,
      judgmentHash: input.judgmentHash,
      sourceIndexHash: input.sourceIndexHash,
      status: matches.length ? "matched" : "unresolved",
      reason,
      declarations: matches,
    };
    const relative = `${SOURCE_QUERIES_DIR}/${stableId("source-query", { itemId: item.id, qualifiedName })}.json`;
    atomicWriteJson(resolveWorkPath(root, relative), entry);
    writtenPaths.push(relative);
    results.push(entry);
  }

  const previous = readWorkflowState(root);
  const queryHashes =
    previous?.sourceQueryHashes && typeof previous.sourceQueryHashes === "object"
      ? (previous.sourceQueryHashes as Record<string, string>)
      : {};
  transitionWorkflowState(root, "awaiting-source-association", {
    sourceQueryHashes: { ...queryHashes, ...hashArtifacts(root, writtenPaths) },
  });
  return { queries: results };
}

export function querySourceAssociation({
  work,
  itemId,
  qualifiedName,
}: {
  work: string;
  itemId: string;
  qualifiedName: string;
}): SourceDeclarationQueryResult {
  return querySourceAssociationBatch({
    work,
    queries: [{ itemId, qualifiedName }],
  }).queries[0];
}

export function materializeSourceAssociation({
  work,
  decisions = SOURCE_ASSOCIATION_DECISIONS,
}: {
  work: string;
  decisions?: string;
}) {
  const root = path.resolve(work);
  const started = performance.now();
  try {
    const { frozen, input } = checkedInput(root);
    const decisionsFile = resolveWorkPath(root, decisions);
    const raw = readJsonObject(decisionsFile);
    keys(
      raw,
      ["schemaVersion", "judgmentHash", "sourceIndexHash", "selections"],
      "Source decisions",
    );
    if (
      raw.schemaVersion !== 1 ||
      raw.judgmentHash !== input.judgmentHash ||
      raw.sourceIndexHash !== input.sourceIndexHash ||
      !Array.isArray(raw.selections)
    )
      throw new Error("Source decisions do not match frozen inputs.");
    const selections = raw.selections.map(checkedSelection);
    exact(
      input.items.map((item) => item.id),
      selections.map((selection) => selection.itemId),
      "Source item",
    );
    const registered = declarationRecord(frozen.source.sourceChanges);
    const queryHashes = frozen.state?.sourceQueryHashes ?? {};
    if (
      !queryHashes ||
      typeof queryHashes !== "object" ||
      Array.isArray(queryHashes) ||
      !Object.values(queryHashes).every((value) => typeof value === "string")
    )
      throw new Error("Invalid source query hashes.");
    const queryErrors = verifyArtifactHashes(root, queryHashes as Record<string, string>);
    if (queryErrors.length) throw new Error(queryErrors.join("\n"));
    const queries = Object.keys(queryHashes).map((relative) =>
      readJsonObject(resolveWorkPath(root, relative)),
    );
    const reviews: Record<string, SourceReviewDecision> = {};
    for (const item of input.items) {
      const selection = selections.find((selection) => selection.itemId === item.id);
      if (!selection) throw new Error(`Missing source selection ${item.id}.`);
      const allowed = new Set(input.sourceContexts[item.sourceContextId]);
      for (const query of queries.filter((query) => query.itemId === item.id)) {
        if (
          query.judgmentHash !== input.judgmentHash ||
          query.sourceIndexHash !== input.sourceIndexHash ||
          !Array.isArray(query.declarations)
        )
          throw new Error("Source query provenance mismatch.");
        for (const rawEntry of query.declarations as unknown[]) {
          if (!rawEntry || typeof rawEntry !== "object") {
            throw new Error("Invalid source query declaration.");
          }
          const entryRecord = rawEntry as Record<string, unknown>;
          const decl = entryRecord.declaration;
          if (!decl || typeof decl !== "object") {
            throw new Error("Invalid source query declaration.");
          }
          const declId = (decl as Record<string, unknown>).id;
          if (typeof declId !== "string") {
            throw new Error("Invalid source query declaration.");
          }
          const canonicalEntry = registered.get(declId);
          if (
            !canonicalEntry ||
            !item.allowedSourceChangeIds.includes(canonicalEntry.sourceChangeId) ||
            !isDeepStrictEqual(canonicalEntry, rawEntry)
          )
            throw new Error("Source query canonical declaration mismatch.");
          allowed.add(declId);
        }
      }
      if (
        new Set(selection.selectedDeclarationIds).size !==
          selection.selectedDeclarationIds.length ||
        selection.selectedDeclarationIds.some((id) => !allowed.has(id))
      )
        throw new Error(`Source selection ${item.id} is outside its canonical context.`);
      if ((selection.outcome === "unresolved") !== (selection.selectedDeclarationIds.length === 0))
        throw new Error("Unresolved source requires no selected declarations.");
      if (selection.outcome === "keep")
        exact(
          item.proposal.declarationIds,
          selection.selectedDeclarationIds,
          "Kept source proposal",
        );
      if (
        (selection.outcome === "keep" || selection.outcome === "refine") &&
        item.proposal.status !== "associated"
      )
        throw new Error("Cannot keep/refine a missing source proposal.");
      if (selection.outcome === "associate" && item.proposal.status === "associated")
        throw new Error("Use refine for an existing source proposal.");
      const review: SourceReviewDecision = {
        outcome: selection.outcome,
        rationale: selection.rationale,
        selectedDeclarations: selection.selectedDeclarationIds.map((id) => {
          const entry = registered.get(id);
          if (!entry) throw new Error(`Unknown source declaration ${id}.`);
          const supplied = input.declarations[id];
          if (supplied && !isDeepStrictEqual(supplied, entry))
            throw new Error("Source input canonical declaration mismatch.");
          const declaration = entry.declaration;
          return {
            declarationId: id,
            sourceChangeId: entry.sourceChangeId,
            qualifiedName: declaration.qualifiedName,
            kind: declaration.kind,
            revision: declaration.source.revision,
            startLine: declaration.source.startLine,
            endLine: declaration.source.endLine,
            hunkIds: declaration.hunkIds,
          };
        }),
      };
      for (const findingId of item.findingIds) reviews[findingId] = review;
    }
    const approvedIds = [...frozen.judgment.restDecisions, ...frozen.judgment.downstreamDecisions]
      .filter((decision) => decision.decision === "approve")
      .map((decision) => decision.candidateId);
    exact(approvedIds, Object.keys(reviews), "Confirmed finding source");
    const outputPath = resolveWorkPath(root, SOURCE_ASSOCIATION_OUTPUT);
    const result: SourceAssociationResult = {
      schemaVersion: 1,
      judgmentHash: input.judgmentHash,
      sourceIndexHash: input.sourceIndexHash,
      inputHash: sha256File(resolveWorkPath(root, SOURCE_ASSOCIATION_INPUT)),
      status: !input.items.length
        ? "not-applicable"
        : selections.some((selection) => selection.outcome === "unresolved")
          ? "partial"
          : "complete",
      reviews,
    };
    atomicWriteJson(outputPath, result);
    const priorArtifacts =
      frozen.state?.artifacts && typeof frozen.state.artifacts === "object"
        ? (frozen.state.artifacts as Record<string, unknown>)
        : {};
    transitionWorkflowState(root, "ready-for-finalization", {
      sourceResultHash: sha256File(outputPath),
      artifacts: {
        ...priorArtifacts,
        sourceAssociationDecisions: decisions,
        sourceAssociation: SOURCE_ASSOCIATION_OUTPUT,
      },
      failure: undefined,
      telemetry: {
        sourceMaterializationMs: Math.round(performance.now() - started),
        sourceAssociationStatus: result.status,
        sourceDecisionBytes: fs.statSync(decisionsFile).size,
      },
    });
    return result;
  } catch (error) {
    transitionWorkflowState(root, "awaiting-source-association", {
      failure: {
        code: "source-association-failed",
        message: error instanceof Error ? error.message : String(error),
        recordedAt: new Date().toISOString(),
      },
    });
    throw error;
  }
}

export function loadSourceAssociation(work: string): SourceAssociationResult {
  const root = path.resolve(work);
  const frozen = canonical(root);
  const outputPath = resolveWorkPath(root, SOURCE_ASSOCIATION_OUTPUT);
  if (!fs.existsSync(outputPath)) {
    throw new Error(
      "Missing source-association.json; complete Step 2b source association before finalization.",
    );
  }
  const output = readJsonObject(outputPath) as unknown as SourceAssociationResult;
  if (
    output.schemaVersion !== 1 ||
    output.judgmentHash !== frozen.judgmentHash ||
    output.sourceIndexHash !== frozen.sourceIndexHash ||
    sha256File(outputPath) !== frozen.state?.sourceResultHash
  ) {
    throw new Error("Source association result hashes do not match frozen assessment.");
  }
  const approved = [...frozen.judgment.restDecisions, ...frozen.judgment.downstreamDecisions]
    .filter((decision) => decision.decision === "approve")
    .map((decision) => decision.candidateId);
  if (!approved.length) {
    if (
      output.status !== "not-applicable" ||
      output.inputHash !== undefined ||
      Object.keys(output.reviews ?? {}).length !== 0
    ) {
      throw new Error(
        "Zero-breaking assessment requires a clean not-applicable source-association.json.",
      );
    }
    return output;
  }
  if (output.status !== "complete" && output.status !== "partial") {
    throw new Error("Confirmed breaking findings require complete or partial source association.");
  }
  const { input } = checkedInput(root);
  if (output.inputHash !== sha256File(resolveWorkPath(root, SOURCE_ASSOCIATION_INPUT))) {
    throw new Error(
      "Source association result inputHash does not match source-association-input.json.",
    );
  }
  exact(approved, Object.keys(output.reviews), "Final source finding");
  exact(
    approved,
    input.items.flatMap((item) => item.findingIds),
    "Final source input finding",
  );
  return output;
}
