import fs from "node:fs";
import path from "node:path";
import { isDeepStrictEqual } from "node:util";
import { isMain, parseArgs, readJsonObject, runMain } from "./cli.ts";
import { stableId } from "./stable-id.ts";
import { restContractIdentity } from "./assessment-display.ts";
import {
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

const INPUT = "source-association-input.json";
const OUTPUT = "source-association.json";
const INDEX = "source-association/agent-index.json";
const DECISIONS = "source-association/agent-decisions.json";
const DRAFT = "source-association/agent-decisions.draft.json";
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
  }[];
  sourceContexts: Record<string, string[]>;
  declarations: Record<string, { sourceChangeId: string; declaration: SourceDeclaration }>;
  facts: Record<string, AssessmentFact>;
};
export type SourceAssociationResult = {
  schemaVersion: 1;
  judgmentHash: string;
  sourceIndexHash: string;
  inputHash: string;
  status: "complete" | "partial" | "not-applicable";
  reviews: Record<string, SourceReviewDecision>;
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
  if (
    typeof entry.itemId !== "string" ||
    !entry.itemId ||
    typeof entry.rationale !== "string" ||
    !entry.rationale.trim() ||
    !Array.isArray(entry.selectedDeclarationIds) ||
    !entry.selectedDeclarationIds.every((id) => typeof id === "string") ||
    !["keep", "refine", "associate", "unresolved"].includes(String(entry.outcome))
  ) {
    throw new Error("Invalid source selection fields.");
  }
  return entry as Selection;
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

export function buildSourceAssociation({ work }: { work: string }) {
  const started = performance.now();
  const root = path.resolve(work);
  const frozen = canonical(root);
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
        .flatMap((unit) => unit.operations ?? [])
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
      allowedSourceChangeIds: [...group.allowedSourceIds].sort(),
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
  if (Buffer.byteLength(JSON.stringify(input)) > 1024 * 1024) {
    throw new Error(
      "Source association input exceeds the 1 MiB bound; narrow proven contexts before invoking source AI.",
    );
  }
  atomicWriteJson(resolveWorkPath(root, INPUT), input);
  atomicWriteJson(resolveWorkPath(root, DRAFT), {
    schemaVersion: 1,
    judgmentHash: input.judgmentHash,
    sourceIndexHash: input.sourceIndexHash,
    selections: input.items.map((item) => ({
      itemId: item.id,
      outcome: "__UNRESOLVED__",
      selectedDeclarationIds: item.proposal.declarationIds,
      rationale: "",
    })),
  });
  const inputHash = sha256File(resolveWorkPath(root, INPUT));
  atomicWriteJson(resolveWorkPath(root, INDEX), {
    schemaVersion: 1,
    input: INPUT,
    inputHash,
    decisions: DECISIONS,
    draft: DRAFT,
    schema: "scripts/source-association-decisions.schema.json",
    itemCount: input.items.length,
    findingCount: input.items.reduce((n, item) => n + item.findingIds.length, 0),
    query:
      "node <skill-directory>/scripts/source-association.ts --work <work> --item <item-id> --name <qualified-declaration-name>",
    materialization:
      "node <skill-directory>/scripts/source-association.ts --work <work> --materialize",
    instructions:
      "Read this bounded input once in a separate source-only AI context. Review the proposed owner against the concrete delta, distinguishing a member's declaring model from its value type. Select canonical IDs only; run targeted queries serially because they update shared registrations. Report contradictory ownership evidence rather than treating a derived proposal as immutable. Do not revise frozen judgment.",
  });
  transitionWorkflowState(root, "awaiting-source-association", {
    sourceInputHash: inputHash,
    sourceQueryHashes: {},
    sourceResultHash: undefined,
    telemetry: {
      sourceInputBuildMs: Math.round(performance.now() - started),
      sourceInputBytes: Buffer.byteLength(JSON.stringify(input)),
      sourceItems: input.items.length,
    },
  });
  if (!input.items.length) {
    atomicWriteJson(resolveWorkPath(root, DECISIONS), {
      schemaVersion: 1,
      judgmentHash: input.judgmentHash,
      sourceIndexHash: input.sourceIndexHash,
      selections: [],
    });
    materializeSourceAssociation({ work: root });
  }
  return {
    indexPath: resolveWorkPath(root, INDEX),
    inputPath: resolveWorkPath(root, INPUT),
    itemCount: input.items.length,
  };
}

function checkedInput(work: string) {
  const frozen = canonical(work);
  const input = readJsonObject(resolveWorkPath(work, INPUT)) as unknown as SourceAssociationInput;
  if (
    input.schemaVersion !== 1 ||
    input.judgmentHash !== frozen.judgmentHash ||
    input.sourceIndexHash !== frozen.sourceIndexHash ||
    sha256File(resolveWorkPath(work, INPUT)) !== frozen.state?.sourceInputHash
  ) {
    throw new Error("Source association input does not match frozen judgment/source hashes.");
  }
  return { frozen, input };
}

export function querySourceAssociation({
  work,
  itemId,
  qualifiedName,
}: {
  work: string;
  itemId: string;
  qualifiedName: string;
}) {
  const root = path.resolve(work);
  const { input, frozen } = checkedInput(root);
  const item = input.items.find((item) => item.id === itemId);
  if (!item || !qualifiedName.trim())
    throw new Error("Unknown source item or empty declaration name.");
  const matches = frozen.source.sourceChanges
    .filter((source) => item.allowedSourceChangeIds.includes(source.id))
    .flatMap((source) =>
      source.declarations
        .filter((declaration) => declaration.qualifiedName === qualifiedName)
        .map((declaration) => ({ sourceChangeId: source.id, declaration })),
    );
  const entry = {
    itemId,
    qualifiedName,
    judgmentHash: input.judgmentHash,
    sourceIndexHash: input.sourceIndexHash,
    status: matches.length ? "matched" : "unresolved",
    reason: matches.length
      ? "Exact canonical declaration name within the item source scope."
      : "No exact canonical declaration found within the item source scope.",
    declarations: matches,
  };
  const relative = `source-association/queries/${stableId("source-query", { itemId, qualifiedName })}.json`;
  atomicWriteJson(resolveWorkPath(root, relative), entry);
  const previous = readWorkflowState(root);
  const queryHashes =
    previous?.sourceQueryHashes && typeof previous.sourceQueryHashes === "object"
      ? previous.sourceQueryHashes
      : {};
  transitionWorkflowState(root, "awaiting-source-association", {
    sourceQueryHashes: { ...queryHashes, ...hashArtifacts(root, [relative]) },
  });
  return entry;
}

export function materializeSourceAssociation({ work }: { work: string }) {
  const root = path.resolve(work);
  const started = performance.now();
  try {
    const { frozen, input } = checkedInput(root);
    const raw = readJsonObject(resolveWorkPath(root, DECISIONS));
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
        for (const entry of query.declarations) {
          if (
            !entry ||
            typeof entry !== "object" ||
            !("declaration" in entry) ||
            !entry.declaration ||
            typeof entry.declaration !== "object" ||
            !("id" in entry.declaration) ||
            typeof entry.declaration.id !== "string"
          )
            throw new Error("Invalid source query declaration.");
          const canonicalEntry = registered.get(entry.declaration.id);
          if (
            !canonicalEntry ||
            !item.allowedSourceChangeIds.includes(canonicalEntry.sourceChangeId) ||
            !isDeepStrictEqual(canonicalEntry, entry)
          )
            throw new Error("Source query canonical declaration mismatch.");
          allowed.add(entry.declaration.id);
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
    const result: SourceAssociationResult = {
      schemaVersion: 1,
      judgmentHash: input.judgmentHash,
      sourceIndexHash: input.sourceIndexHash,
      inputHash: sha256File(resolveWorkPath(root, INPUT)),
      status: !input.items.length
        ? "not-applicable"
        : selections.some((selection) => selection.outcome === "unresolved")
          ? "partial"
          : "complete",
      reviews,
    };
    atomicWriteJson(resolveWorkPath(root, OUTPUT), result);
    transitionWorkflowState(root, "source-association-materialized", {
      sourceResultHash: sha256File(resolveWorkPath(root, OUTPUT)),
      failure: undefined,
      telemetry: {
        sourceMaterializationMs: Math.round(performance.now() - started),
        sourceAssociationStatus: result.status,
      },
    });
    return result;
  } catch (error) {
    transitionWorkflowState(root, "awaiting-source-association", {
      failure: {
        code: "source-association-failed",
        message: error instanceof Error ? error.message : String(error),
      },
    });
    throw error;
  }
}

export function loadSourceAssociation(work: string): SourceAssociationResult {
  const { frozen, input } = checkedInput(work);
  const output = readJsonObject(
    resolveWorkPath(work, OUTPUT),
  ) as unknown as SourceAssociationResult;
  if (
    output.schemaVersion !== 1 ||
    output.judgmentHash !== frozen.judgmentHash ||
    output.sourceIndexHash !== frozen.sourceIndexHash ||
    output.inputHash !== sha256File(resolveWorkPath(work, INPUT)) ||
    sha256File(resolveWorkPath(work, OUTPUT)) !== frozen.state?.sourceResultHash
  ) {
    throw new Error("Source association result hashes do not match frozen assessment.");
  }
  const approved = [...frozen.judgment.restDecisions, ...frozen.judgment.downstreamDecisions]
    .filter((decision) => decision.decision === "approve")
    .map((decision) => decision.candidateId);
  exact(approved, Object.keys(output.reviews), "Final source finding");
  exact(
    approved,
    input.items.flatMap((item) => item.findingIds),
    "Final source input finding",
  );
  return output;
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2), {
      required: ["work"],
      booleans: ["materialize"],
    });
    if (typeof args.work !== "string") throw new Error("--work must be a path.");
    if (args.materialize)
      return console.log(JSON.stringify(materializeSourceAssociation({ work: args.work })));
    if (args.item !== undefined || args.name !== undefined) {
      if (typeof args.item !== "string" || typeof args.name !== "string")
        throw new Error("--item and --name are required for source queries.");
      return console.log(
        JSON.stringify(
          querySourceAssociation({ work: args.work, itemId: args.item, qualifiedName: args.name }),
        ),
      );
    }
    console.log(JSON.stringify(buildSourceAssociation({ work: args.work })));
  });
}
