import fs from "node:fs";
import path from "node:path";
import { analyzeRestBreaking } from "./analyze-rest-breaking.ts";
import { isMain, parseArgs, readJsonObject, runMain } from "./cli.ts";
import { finalizeAssessment } from "./finalize-assessment.ts";
import {
  atomicWriteFile,
  atomicWriteJson,
  hashArtifacts,
  sha256File,
  verifyArtifactHashes,
} from "./workflow-state.ts";

type BreakingAnalysis = import("./runtime-types.ts").BreakingAnalysis;

type BreakingCandidate = import("./runtime-types.ts").BreakingCandidate;

type AssessmentOutput = import("./runtime-types.ts").AssessmentOutput;

type Judgment = {
  restDecisions: {
    candidateId: string;
    decision: string;
    severity?: string;
    rationale: string;
  }[];
  blockers: string[];
  [key: string]: unknown;
};

type WorkflowState = {
  artifactHashes?: Record<string, string>;
  invocation?: {
    pullRequest?: {
      number?: number;
      headCommit?: string;
    };
  };
  comparisonIdentity?: {
    projects?: {
      artifactComparison?: {
        mode?: string;
        baseline?: { apiVersion?: string };
        target?: { apiVersion?: string };
      };
    }[];
  };
  telemetry?: Record<string, unknown>;
  artifacts?: Record<string, unknown>;
  [key: string]: unknown;
};

type ReferenceEvidence = {
  sourceCommit?: string;
  inputs?: { role?: string; sha256?: string; hashMatched?: boolean }[];
  counts?: {
    referenceOccurrences?: number;
    matchedOccurrences?: number;
    missingOccurrences?: number;
  };
};

const FIXTURE = {
  pullRequest: 46679,
  headCommit: "75c564b29d32d4da78bc5e8f6e38cbd8cb553b08",
  comparisonMode: "new-api-version",
  baselineApiVersion: "2026-07-03-preview",
  targetApiVersion: "2026-08-01-preview",
  historicalRestHash: "sha256:e009816d02244e175dba05976a3109ae8294aa19a1c44b8bfc4ab8a8a627063c",
  baselineArtifactHash: "6c3b069b00339b3ff37f24a11f4cf63afc68fc02f9432d22ff888b8e0ff39dea",
  targetArtifactHash: "11da644102782119aba70147e04855d9575135cb708e18da85d7161d6289da97",
  referenceOccurrences: 303,
} as const;

function assert(condition: unknown, message: string): asserts condition {
  if (!condition) throw new Error(message);
}

function elapsed(started: number) {
  return Math.round((performance.now() - started) * 1000) / 1000;
}

function blockerCode(blocker: unknown) {
  return typeof blocker === "object" &&
    blocker !== null &&
    "code" in blocker &&
    typeof blocker.code === "string"
    ? blocker.code
    : undefined;
}

export function semanticRestCandidateKey(candidate: BreakingCandidate): string {
  return JSON.stringify({
    operationIds: [...(candidate.operationIds ?? [])].sort(),
    rule: candidate.rule,
    location: candidate.contractChange?.location,
    actual: candidate.actual,
    expected: candidate.expected,
  });
}

function uniqueCandidates(candidates: BreakingCandidate[], label: string) {
  const result = new Map<string, BreakingCandidate>();
  for (const candidate of candidates) {
    const key = semanticRestCandidateKey(candidate);
    if (result.has(key)) {
      throw new Error(`Duplicate semantic REST candidate in ${label}: ${key}`);
    }
    result.set(key, candidate);
  }
  return result;
}

export function compareRestCandidates(
  historical: BreakingCandidate[],
  current: BreakingCandidate[],
) {
  const historicalByKey = uniqueCandidates(historical, "historical analysis");
  const currentByKey = uniqueCandidates(current, "current analysis");
  const removed = [...historicalByKey.keys()].filter((key) => !currentByKey.has(key));
  const added = [...currentByKey.keys()].filter((key) => !historicalByKey.has(key));
  return { historicalByKey, currentByKey, removed, added };
}

export function reconcileRestDecisions(
  judgment: Judgment,
  historicalCandidates: BreakingCandidate[],
  currentCandidates: BreakingCandidate[],
  allowedRemovedCandidateKeys: Set<string> = new Set(),
): Judgment {
  const historicalById = new Map(
    historicalCandidates.map((candidate) => [candidate.id, candidate]),
  );
  const currentByKey = uniqueCandidates(currentCandidates, "current analysis");
  const restDecisions = judgment.restDecisions
    .map((decision) => {
      const historicalCandidate = historicalById.get(decision.candidateId);
      if (!historicalCandidate) {
        throw new Error(
          `Historical judgment references unknown REST candidate ${decision.candidateId}.`,
        );
      }
      const currentCandidate = currentByKey.get(semanticRestCandidateKey(historicalCandidate));
      if (!currentCandidate) {
        if (allowedRemovedCandidateKeys.has(semanticRestCandidateKey(historicalCandidate))) {
          return undefined;
        }
        throw new Error(
          `No current REST candidate matches historical decision ${decision.candidateId}.`,
        );
      }
      return { ...decision, candidateId: currentCandidate.id };
    })
    .filter((decision) => decision !== undefined);
  return { ...judgment, restDecisions };
}

export function removeObsoleteCommonTypeJudgmentBlocker(judgment: Judgment) {
  const removed: string[] = [];
  const blockers = judgment.blockers.filter((blocker) => {
    const obsolete =
      blocker.includes("CloudAccounts_Update") &&
      blocker.includes("unresolved AutoRest references") &&
      blocker.includes("REST request contract");
    if (obsolete) removed.push(blocker);
    return !obsolete;
  });
  return { judgment: { ...judgment, blockers }, removed };
}

function candidateReferenceId(value: unknown): string | undefined {
  if (value === null || typeof value !== "object" || Array.isArray(value)) return undefined;
  const record = value as Record<string, unknown>;
  return typeof record.id === "string" ? record.id : undefined;
}

export function reconcileModelInputCandidateReferences(
  value: unknown,
  candidateIdMap: Map<string, string>,
  removedCandidateIds: Set<string>,
): unknown {
  if (Array.isArray(value)) {
    return value
      .filter(
        (item) =>
          !(typeof item === "string" && removedCandidateIds.has(item)) &&
          !removedCandidateIds.has(candidateReferenceId(item) ?? ""),
      )
      .map((item) =>
        reconcileModelInputCandidateReferences(item, candidateIdMap, removedCandidateIds),
      );
  }
  if (typeof value === "string") return candidateIdMap.get(value) ?? value;
  if (value === null || typeof value !== "object") return value;
  const result: Record<string, unknown> = {};
  for (const [key, nested] of Object.entries(value)) {
    if (key === "evidenceRef" && removedCandidateIds.has(candidateReferenceId(nested) ?? "")) {
      continue;
    }
    result[key] = reconcileModelInputCandidateReferences(
      nested,
      candidateIdMap,
      removedCandidateIds,
    );
  }
  return result;
}

export function validateReferenceEvidence(evidence: ReferenceEvidence) {
  assert(
    evidence.sourceCommit === FIXTURE.headCommit,
    `Reference evidence must use source commit ${FIXTURE.headCommit}.`,
  );
  const inputs = new Map((evidence.inputs ?? []).map((input) => [input.role, input]));
  assert(
    inputs.get("baseline")?.sha256 === FIXTURE.baselineArtifactHash &&
      inputs.get("baseline")?.hashMatched === true,
    "Reference evidence does not match the pinned baseline AutoRest artifact.",
  );
  assert(
    inputs.get("target")?.sha256 === FIXTURE.targetArtifactHash &&
      inputs.get("target")?.hashMatched === true,
    "Reference evidence does not match the pinned target AutoRest artifact.",
  );
  assert(
    evidence.counts?.referenceOccurrences === FIXTURE.referenceOccurrences &&
      evidence.counts.matchedOccurrences === FIXTURE.referenceOccurrences &&
      evidence.counts.missingOccurrences === 0,
    "Reference evidence must match all 303 common-type references with no missing targets.",
  );
}

function validateFixtureState(state: WorkflowState) {
  assert(
    state.invocation?.pullRequest?.number === FIXTURE.pullRequest,
    `Expected PR #${FIXTURE.pullRequest} fixture.`,
  );
  assert(
    state.invocation.pullRequest.headCommit === FIXTURE.headCommit,
    `Expected PR head ${FIXTURE.headCommit}.`,
  );
  const comparison = state.comparisonIdentity?.projects?.[0]?.artifactComparison;
  assert(comparison?.mode === FIXTURE.comparisonMode, "Expected a new-api-version comparison.");
  assert(
    comparison.baseline?.apiVersion === FIXTURE.baselineApiVersion,
    `Expected baseline ${FIXTURE.baselineApiVersion}.`,
  );
  assert(
    comparison.target?.apiVersion === FIXTURE.targetApiVersion,
    `Expected target ${FIXTURE.targetApiVersion}.`,
  );
  assert(
    state.artifactHashes?.["dimensions/rest-breaking-input.json"] === FIXTURE.historicalRestHash,
    "Historical REST analysis hash does not match the accepted PR #46679 fixture.",
  );
}

function prepareOutputWorkspace(fixtureWork: string, output: string, state: WorkflowState) {
  if (fs.existsSync(output) && fs.readdirSync(output).length > 0) {
    throw new Error(`Output directory must be absent or empty: ${output}`);
  }
  fs.mkdirSync(output, { recursive: true });
  const canonicalPaths = Object.keys(state.artifactHashes ?? {});
  for (const relativePath of canonicalPaths) {
    if (relativePath === "dimensions/rest-breaking-input.json") continue;
    const source = path.join(fixtureWork, relativePath);
    const target = path.join(output, relativePath);
    fs.mkdirSync(path.dirname(target), { recursive: true });
    fs.copyFileSync(source, target);
  }
  for (const relativePath of [
    "assessment-judgment.json",
    "compliance-search-evidence.json",
    "inference.json",
  ]) {
    fs.copyFileSync(path.join(fixtureWork, relativePath), path.join(output, relativePath));
  }
  return canonicalPaths;
}

function reportMarkdown(result: Record<string, unknown>) {
  const timing = result.timingMs as Record<string, number>;
  const acceptance = result.acceptance as Record<string, boolean>;
  return `# PR #46679 common-type acceptance validation

**Result:** ${result.status === "passed" ? "Passed" : "Failed"}

The pinned PR #46679 fixture preserves ${String(result.currentRestCandidateCount)} supported semantic REST candidates, removes the obsolete common-type-derived unresolved-contract blocker, and removes the representation-only CloudAccounts_Update candidate after comparing its effective JSON wire properties across object and allOf forms. Normal assessment execution did not load or resolve common-type files; exact lookup evidence was verified separately against the pinned artifacts.

## Acceptance

| Check | Result |
| --- | --- |
| Pinned provenance and artifact hashes | ${acceptance.provenance ? "Pass" : "Fail"} |
| 303 / 303 common-type references found by exact lookup | ${acceptance.referenceLookup ? "Pass" : "Fail"} |
| REST candidate changes are limited to the representation-only finding | ${acceptance.restCandidateChangesExplained ? "Pass" : "Fail"} |
| Common-type unresolved REST blocker removed | ${acceptance.commonTypeBlockerRemoved ? "Pass" : "Fail"} |
| Independent inference and downstream blockers preserved | ${acceptance.independentBlockersPreserved ? "Pass" : "Fail"} |
| Final assessment and HTML generated | ${acceptance.finalization ? "Pass" : "Fail"} |
| Coverage labels absent from rendered report | ${acceptance.coverageLabelsHidden ? "Pass" : "Fail"} |

## Timing

| Phase | Time |
| --- | ---: |
| Provenance and reference-evidence verification | ${timing.provenanceAndReferenceEvidence} ms |
| Current REST analysis | ${timing.restAnalysis} ms |
| Judgment reconciliation and workspace preparation | ${timing.workspacePreparationAndReconciliation} ms |
| Finalization and HTML rendering | ${timing.finalizationAndRendering} ms |
| Total elapsed | ${timing.total} ms |

Compilation, dependency setup, network retrieval, and agent judgment were not executed by this acceptance rerun. The separately supplied lookup evidence measured common-type retrieval and pointer validation.
`;
}

export function validatePr46679CommonTypes({
  fixtureWork,
  referenceEvidence,
  output,
}: {
  fixtureWork: string;
  referenceEvidence: string;
  output: string;
}) {
  const totalStarted = performance.now();
  const fixtureRoot = path.resolve(fixtureWork);
  const outputRoot = path.resolve(output);

  const provenanceStarted = performance.now();
  const state = readJsonObject(path.join(fixtureRoot, "workflow-state.json")) as WorkflowState;
  validateFixtureState(state);
  const hashErrors = verifyArtifactHashes(fixtureRoot, state.artifactHashes);
  assert(hashErrors.length === 0, hashErrors.join("\n"));
  const lookupEvidence = readJsonObject(referenceEvidence) as ReferenceEvidence;
  validateReferenceEvidence(lookupEvidence);
  const provenanceAndReferenceEvidence = elapsed(provenanceStarted);

  const historical = readJsonObject(
    path.join(fixtureRoot, "dimensions", "rest-breaking-input.json"),
  ) as unknown as BreakingAnalysis;
  const restStarted = performance.now();
  const current = analyzeRestBreaking({
    manifest: path.join(fixtureRoot, "preparation-manifest.json"),
  });
  const restAnalysis = elapsed(restStarted);
  const comparison = compareRestCandidates(historical.candidates, current.candidates);
  const removedCandidates = comparison.removed.map((key) => comparison.historicalByKey.get(key)!);
  const removedWireRepresentationCandidates = removedCandidates.filter(
    (candidate) =>
      candidate.rule === "wire-type-changed" &&
      candidate.operationIds?.includes("CloudAccounts_Update") &&
      candidate.contractChange?.location === "request body",
  );
  assert(
    comparison.removed.length === 1 &&
      removedWireRepresentationCandidates.length === 1 &&
      comparison.added.length === 0,
    `REST semantic candidates changed unexpectedly: removed ${comparison.removed.length}, added ${comparison.added.length}.`,
  );
  assert(
    historical.blockers.some((blocker) => blocker.code === "autorest-contract-unresolved"),
    "Historical fixture is missing the expected unresolved-contract blocker.",
  );
  assert(
    !current.blockers.some((blocker) => blocker.code === "autorest-contract-unresolved"),
    "Current analysis still contains an unresolved-contract blocker.",
  );
  assert(
    !current.candidates.some(
      (candidate) =>
        candidate.rule === "wire-type-changed" &&
        candidate.operationIds?.includes("CloudAccounts_Update"),
    ),
    "CloudAccounts_Update still has a representation-only request-body finding.",
  );
  for (const operationId of [
    "RoleMappings_CreateOrUpdate",
    "ProtectionGroups_Get",
    "SaaSOperationGroup_ActivateResource",
  ]) {
    assert(
      current.candidates.some((candidate) => candidate.operationIds?.includes(operationId)),
      `Expected genuine REST findings for ${operationId}.`,
    );
  }

  const workspaceStarted = performance.now();
  const canonicalPaths = prepareOutputWorkspace(fixtureRoot, outputRoot, state);
  atomicWriteJson(path.join(outputRoot, "dimensions", "rest-breaking-input.json"), current);
  const removedCandidateIds = new Set(
    removedWireRepresentationCandidates.map((candidate) => candidate.id),
  );
  const candidateIdMap = new Map<string, string>();
  for (const [key, historicalCandidate] of comparison.historicalByKey) {
    const currentCandidate = comparison.currentByKey.get(key);
    if (currentCandidate && historicalCandidate.id !== currentCandidate.id) {
      candidateIdMap.set(historicalCandidate.id, currentCandidate.id);
    }
  }
  const modelInputPath = path.join(outputRoot, "model-input.json");
  atomicWriteJson(
    modelInputPath,
    reconcileModelInputCandidateReferences(
      readJsonObject(modelInputPath),
      candidateIdMap,
      removedCandidateIds,
    ),
  );
  const originalJudgment = readJsonObject(
    path.join(fixtureRoot, "assessment-judgment.json"),
  ) as Judgment;
  const reconciled = reconcileRestDecisions(
    originalJudgment,
    historical.candidates,
    current.candidates,
    new Set(comparison.removed),
  );
  const blockerResult = removeObsoleteCommonTypeJudgmentBlocker(reconciled);
  assert(
    blockerResult.removed.length === 1,
    `Expected to remove one obsolete judgment blocker, removed ${blockerResult.removed.length}.`,
  );
  atomicWriteJson(path.join(outputRoot, "assessment-judgment.json"), blockerResult.judgment);
  const validationState: WorkflowState = {
    ...state,
    state: "awaiting-finalization",
    updatedAt: new Date().toISOString(),
    telemetry: {
      ...(state.telemetry ?? {}),
      validationFixture: "Azure/azure-rest-api-specs#46679",
    },
    artifactHashes: hashArtifacts(outputRoot, canonicalPaths),
  };
  delete validationState.resultHashes;
  atomicWriteJson(path.join(outputRoot, "workflow-state.json"), validationState);
  const workspacePreparationAndReconciliation = elapsed(workspaceStarted);

  const finalizationStarted = performance.now();
  const finalized = finalizeAssessment({ work: outputRoot });
  const finalizationAndRendering = elapsed(finalizationStarted);
  const assessment = readJsonObject(finalized.assessmentPath) as unknown as AssessmentOutput;
  const html = fs.readFileSync(finalized.reportPath, "utf8");
  const restBlockers = assessment.dimensions.rest.blockers ?? [];
  const downstreamBlockers = assessment.dimensions.downstream.blockers ?? [];
  assert(
    !restBlockers.some((blocker) => blockerCode(blocker) === "autorest-contract-unresolved"),
    "Final assessment still contains the common-type unresolved REST blocker.",
  );
  assert(
    restBlockers.some((blocker) => blockerCode(blocker) === "inference-blocked") &&
      downstreamBlockers.some((blocker) => blockerCode(blocker) === "inference-blocked") &&
      downstreamBlockers.some(
        (blocker) => blockerCode(blocker) === "downstream-identity-unresolved",
      ),
    "Final assessment did not preserve independent inference and downstream blockers.",
  );
  const forbiddenCoverageLabels = [
    "Partial coverage",
    "Complete coverage",
    "Blocked coverage",
    "Evidence coverage",
  ];
  assert(
    forbiddenCoverageLabels.every((label) => !html.includes(label)),
    "Rendered report contains a forbidden coverage label.",
  );

  const result = {
    schemaVersion: 1,
    status: "passed",
    fixture: {
      pullRequest: FIXTURE.pullRequest,
      headCommit: FIXTURE.headCommit,
      baselineApiVersion: FIXTURE.baselineApiVersion,
      targetApiVersion: FIXTURE.targetApiVersion,
      historicalRestHash: FIXTURE.historicalRestHash,
      currentRestHash: sha256File(path.join(outputRoot, "dimensions", "rest-breaking-input.json")),
    },
    historicalRestCandidateCount: historical.candidates.length,
    currentRestCandidateCount: current.candidates.length,
    removedRestCandidates: removedWireRepresentationCandidates.map((candidate) => ({
      id: candidate.id,
      rule: candidate.rule,
      operationIds: candidate.operationIds,
      location: candidate.contractChange?.location,
      reason:
        "The effective JSON properties are compatible after flattening resolved allOf objects and treating unresolved ARM common types as opaque.",
    })),
    removedRestBlockers: historical.blockers.filter(
      (blocker) => !current.blockers.some((currentBlocker) => currentBlocker.code === blocker.code),
    ),
    removedJudgmentBlockers: blockerResult.removed,
    preservedJudgmentBlockerCount: blockerResult.judgment.blockers.length,
    acceptance: {
      provenance: true,
      referenceLookup: true,
      restCandidateChangesExplained: true,
      commonTypeBlockerRemoved: true,
      independentBlockersPreserved: true,
      finalization: true,
      coverageLabelsHidden: true,
    },
    timingMs: {
      provenanceAndReferenceEvidence,
      restAnalysis,
      workspacePreparationAndReconciliation,
      finalizationAndRendering,
      total: elapsed(totalStarted),
      dependencySetup: "not measured",
      compilation: "not measured",
      networkRetrieval: "not measured",
      agentJudgment: "not measured",
    },
    outputs: {
      assessment: finalized.assessmentPath,
      report: finalized.reportPath,
    },
  };
  atomicWriteJson(path.join(outputRoot, "pr-46679-validation.json"), result);
  atomicWriteFile(path.join(outputRoot, "pr-46679-validation.md"), reportMarkdown(result));
  return result;
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2), {
      required: ["fixture-work", "reference-evidence", "output"],
    });
    const fixtureWork = args.fixture_work;
    const referenceEvidence = args.reference_evidence;
    const output = args.output;
    if (
      typeof fixtureWork !== "string" ||
      typeof referenceEvidence !== "string" ||
      typeof output !== "string"
    ) {
      throw new TypeError("--fixture-work, --reference-evidence, and --output must be paths.");
    }
    const result = validatePr46679CommonTypes({ fixtureWork, referenceEvidence, output });
    console.log(JSON.stringify(result));
  });
}
