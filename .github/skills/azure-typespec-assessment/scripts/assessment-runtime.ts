import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { isRecord, readJsonObject } from "./cli.ts";
import {
  hashArtifacts,
  readWorkflowState,
  resolveWorkPath,
  sha256Buffer,
  verifyArtifactHashes,
} from "./workflow-state.ts";

export const AGENT_INDEX_FILE = "agent-workspace/agent-index.json";

export type AssessmentRuntime = {
  schemaVersion: 1;
  root: string;
  fingerprint: string;
};

export type RuntimeCommand = {
  executable: string;
  args: string[];
};

export type RuntimePhaseProvenance = {
  schemaVersion: 1;
  runtime: AssessmentRuntime;
  recordedAt: string;
  inputHashes: Record<string, string>;
  outputHashes: Record<string, string>;
};

export class AssessmentRuntimeError extends Error {
  constructor(detail: string) {
    super(
      `Assessment runtime tooling error: ${detail}\n` +
        "Rerun preparation with the intended assessment runtime, then use the exact structured " +
        "commands in agent-workspace/agent-index.json to materialize and finalize. " +
        "Do not change compatibility judgments to repair a tooling mismatch.",
    );
    this.name = "AssessmentRuntimeError";
  }
}

export function captureAssessmentRuntime(metaUrl: string): AssessmentRuntime {
  const root = fs.realpathSync(path.resolve(path.dirname(fileURLToPath(metaUrl)), ".."));
  // Only assessment code, schemas, presentation assets, and the guidance catalog are pinned.
  const files = fs
    .readdirSync(path.join(root, "scripts"), { withFileTypes: true })
    .filter((entry) => entry.isFile() && /\.(?:ts|json|css)$/.test(entry.name))
    .map((entry) => `scripts/${entry.name}`);
  files.push("package.json", "references/reference-document-links.md");
  return {
    schemaVersion: 1,
    root,
    fingerprint: sha256Buffer(JSON.stringify(hashArtifacts(root, files))),
  };
}

export function resolvedRuntimeCommand(
  runtime: AssessmentRuntime,
  script: string,
  args: string[],
): RuntimeCommand {
  return {
    executable: process.execPath,
    args: [resolveWorkPath(runtime.root, script), ...args],
  };
}

function assertRuntime(value: unknown, label: string): asserts value is AssessmentRuntime {
  if (
    !isRecord(value) ||
    value.schemaVersion !== 1 ||
    typeof value.root !== "string" ||
    !path.isAbsolute(value.root) ||
    typeof value.fingerprint !== "string" ||
    !/^sha256:[a-f0-9]{64}$/.test(value.fingerprint)
  ) {
    throw new AssessmentRuntimeError(`Missing or unsupported runtime binding in ${label}.`);
  }
}

function verifyRuntime(expected: unknown, actual: AssessmentRuntime, label: string) {
  assertRuntime(expected, label);
  if (expected.root !== actual.root) {
    throw new AssessmentRuntimeError(
      `Wrong runtime origin for ${label}: expected ${expected.root}; executing ${actual.root}.`,
    );
  }
  if (expected.fingerprint !== actual.fingerprint) {
    throw new AssessmentRuntimeError(
      `Runtime fingerprint changed for ${label}: expected ${expected.fingerprint}; ` +
        `executing ${actual.fingerprint}.`,
    );
  }
}

export function verifyAssessmentRuntime(work: string, metaUrl: string): AssessmentRuntime {
  const indexFile = resolveWorkPath(work, AGENT_INDEX_FILE);
  if (!fs.existsSync(indexFile)) {
    throw new AssessmentRuntimeError("Missing runtime-pinned agent-workspace/agent-index.json.");
  }
  const index = readJsonObject(indexFile);
  let actual: AssessmentRuntime;
  try {
    actual = captureAssessmentRuntime(metaUrl);
  } catch (error) {
    throw new AssessmentRuntimeError(
      `Cannot fingerprint the executing runtime: ${error instanceof Error ? error.message : String(error)}`,
    );
  }
  verifyRuntime(index.runtime, actual, "agent-index.json");
  verifyRuntime(readWorkflowState(work)?.runtime, actual, "workflow-state.json");
  return actual;
}

export function createRuntimePhaseProvenance(
  work: string,
  runtime: AssessmentRuntime,
  inputs: string[],
  outputs: string[],
): RuntimePhaseProvenance {
  return {
    schemaVersion: 1,
    runtime,
    recordedAt: new Date().toISOString(),
    inputHashes: hashArtifacts(work, inputs),
    outputHashes: hashArtifacts(work, outputs),
  };
}

function isHashMap(value: unknown): value is Record<string, string> {
  return (
    isRecord(value) &&
    Object.values(value).every(
      (hash) => typeof hash === "string" && /^sha256:[a-f0-9]{64}$/.test(hash),
    )
  );
}

export function verifyRuntimePhaseProvenance(
  work: string,
  phase: "preparation" | "materialization",
  runtime: AssessmentRuntime,
): RuntimePhaseProvenance {
  const value = readWorkflowState(work)?.runtimePhases?.[phase];
  const requiredOutputs =
    phase === "preparation"
      ? [AGENT_INDEX_FILE]
      : ["assessment-judgment.json", "compliance-search-evidence.json"];
  if (
    !value ||
    value.schemaVersion !== 1 ||
    typeof value.recordedAt !== "string" ||
    !Number.isFinite(Date.parse(value.recordedAt)) ||
    !isHashMap(value.inputHashes) ||
    !isHashMap(value.outputHashes) ||
    requiredOutputs.some((file) => !value.outputHashes[file]) ||
    (phase === "materialization" && !value.inputHashes[AGENT_INDEX_FILE])
  ) {
    throw new AssessmentRuntimeError(
      `Missing or unsupported successful ${phase} runtime provenance. ` +
        "Output from an unrecorded or older script cannot be accepted.",
    );
  }
  verifyRuntime(value.runtime, runtime, `${phase} phase`);
  let errors: string[];
  try {
    errors = [
      ...verifyArtifactHashes(work, value.inputHashes),
      ...verifyArtifactHashes(work, value.outputHashes),
    ];
  } catch (error) {
    throw new AssessmentRuntimeError(
      `Invalid ${phase} runtime provenance: ${error instanceof Error ? error.message : String(error)}`,
    );
  }
  if (errors.length) {
    throw new AssessmentRuntimeError(`Stale ${phase} runtime provenance.\n${errors.join("\n")}`);
  }
  return value;
}
