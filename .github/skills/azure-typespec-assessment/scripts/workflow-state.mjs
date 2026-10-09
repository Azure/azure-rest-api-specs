import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { isRecord, readJsonObject } from "./cli.mjs";

export const WORKFLOW_STATE_FILE = "workflow-state.json";

/**
 * @typedef {{startedAt?: string, endedAt?: string, [key: string]: unknown}} WorkflowPhase
 * @typedef {{
 *   schemaVersion: number,
 *   state?: string,
 *   updatedAt?: string,
 *   phases: Record<string, WorkflowPhase>,
 *   telemetry: Record<string, unknown>,
 *   artifactHashes?: Record<string, string>,
 *   [key: string]: unknown
 * }} WorkflowState
 * @typedef {{
 *   phaseComplete?: boolean,
 *   telemetry?: Record<string, unknown>,
 *   [key: string]: unknown
 * }} WorkflowDetails
 * @typedef {{
 *   context?: {
 *     sourceComparison?: unknown,
 *     projects?: {id: string, path: string, artifactComparison?: unknown}[]
 *   }
 * }} WorkflowModelInput
 */

/**
 * @param {string | NodeJS.ArrayBufferView} value
 * @returns {string}
 */
export function sha256Buffer(value) {
  return `sha256:${crypto.createHash("sha256").update(value).digest("hex")}`;
}

/**
 * @param {string} file
 * @returns {string}
 */
export function sha256File(file) {
  return sha256Buffer(fs.readFileSync(file));
}

/**
 * @param {string} file
 * @param {string | NodeJS.ArrayBufferView} value
 */
export function atomicWriteFile(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  const temporary = `${file}.${process.pid}.${Date.now()}.tmp`;
  fs.writeFileSync(temporary, value);
  fs.renameSync(temporary, file);
}

/**
 * @param {string} file
 * @param {unknown} value
 */
export function atomicWriteJson(file, value) {
  atomicWriteFile(file, `${JSON.stringify(value, null, 2)}\n`);
}

/**
 * @param {string} work
 * @returns {WorkflowState | undefined}
 */
export function readWorkflowState(work) {
  const file = path.join(work, WORKFLOW_STATE_FILE);
  if (!fs.existsSync(file)) return undefined;
  const value = readJsonObject(file);
  if (
    typeof value.schemaVersion !== "number" ||
    (value.state !== undefined && typeof value.state !== "string") ||
    (value.updatedAt !== undefined && typeof value.updatedAt !== "string") ||
    !isRecord(value.phases) ||
    !isRecord(value.telemetry)
  ) {
    throw new TypeError(`Invalid workflow state in ${file}.`);
  }
  return /** @type {WorkflowState} */ (value);
}

/**
 * @param {WorkflowModelInput} modelInput
 */
export function comparisonIdentity(modelInput) {
  return {
    sourceComparison: modelInput.context?.sourceComparison,
    projects: (modelInput.context?.projects ?? []).map((project) => ({
      id: project.id,
      path: project.path,
      artifactComparison: project.artifactComparison,
    })),
  };
}

/**
 * @param {string} work
 * @param {string} relativePath
 * @returns {string}
 */
export function resolveWorkPath(work, relativePath) {
  if (!relativePath || path.isAbsolute(relativePath)) {
    throw new Error(`Artifact path must be relative: ${relativePath ?? "<missing>"}.`);
  }
  const root = path.resolve(work);
  const resolved = path.resolve(root, relativePath);
  if (resolved !== root && !resolved.startsWith(`${root}${path.sep}`)) {
    throw new Error(`Artifact path escapes the work directory: ${relativePath}.`);
  }
  return resolved;
}

/**
 * @param {string} work
 * @param {string[]} relativePaths
 * @returns {Record<string, string>}
 */
export function hashArtifacts(work, relativePaths) {
  return Object.fromEntries(
    [...new Set(relativePaths)].sort().map((relativePath) => {
      const file = resolveWorkPath(work, relativePath);
      if (!fs.existsSync(file)) {
        throw new Error(`Missing canonical artifact: ${relativePath}.`);
      }
      return [relativePath.replaceAll("\\", "/"), sha256File(file)];
    }),
  );
}

/**
 * @param {string} work
 * @param {Record<string, string> | undefined} artifactHashes
 * @returns {string[]}
 */
export function verifyArtifactHashes(work, artifactHashes) {
  /** @type {string[]} */
  const errors = [];
  for (const [relativePath, expected] of Object.entries(artifactHashes ?? {})) {
    const file = resolveWorkPath(work, relativePath);
    if (!fs.existsSync(file)) {
      errors.push(`Missing artifact ${relativePath}.`);
    } else {
      const actual = sha256File(file);
      if (actual !== expected) {
        errors.push(`Artifact hash changed for ${relativePath}.`);
      }
    }
  }
  return errors;
}

/**
 * @param {string} work
 * @param {string} state
 * @param {WorkflowDetails} [details]
 * @returns {WorkflowState}
 */
export function transitionWorkflowState(work, state, details = {}) {
  const now = new Date().toISOString();
  const previous = readWorkflowState(work) ?? {
    schemaVersion: 1,
    phases: {},
    telemetry: {},
  };
  const phases = { ...previous.phases };
  if (previous.state && previous.state !== state) {
    const prior = phases[previous.state] ?? {};
    phases[previous.state] = {
      ...prior,
      startedAt: prior.startedAt ?? previous.updatedAt ?? now,
      endedAt: prior.endedAt ?? now,
    };
  }
  const current = phases[state] ?? {};
  phases[state] = {
    ...current,
    startedAt: current.startedAt ?? now,
    ...(details.phaseComplete ? { endedAt: now } : {}),
  };
  const next = {
    ...previous,
    ...details,
    schemaVersion: 1,
    state,
    phases,
    telemetry: {
      ...previous.telemetry,
      ...(details.telemetry ?? {}),
    },
    updatedAt: now,
  };
  delete next.phaseComplete;
  atomicWriteJson(path.join(work, WORKFLOW_STATE_FILE), next);
  return next;
}
