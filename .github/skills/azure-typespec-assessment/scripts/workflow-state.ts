import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { isRecord, readJsonObject } from "./cli.ts";

export const WORKFLOW_STATE_FILE = "workflow-state.json";

type WorkflowModelInput = {
  context?: {
    sourceComparison?: unknown;
    projects?: {
      id: string;
      path: string;
      artifactComparison?: unknown;
    }[];
  };
};
type WorkflowDetails = {
  phaseComplete?: boolean;
  telemetry?: Record<string, unknown>;
  [key: string]: unknown;
};
type WorkflowState = {
  schemaVersion: number;
  state?: string;
  updatedAt?: string;
  phases: Record<string, WorkflowPhase>;
  telemetry: Record<string, unknown>;
  artifactHashes?: Record<string, string>;
  [key: string]: unknown;
};
type WorkflowPhase = {
  startedAt?: string;
  endedAt?: string;
  [key: string]: unknown;
};

export function sha256Buffer(value: string | NodeJS.ArrayBufferView): string {
  return `sha256:${crypto.createHash("sha256").update(value).digest("hex")}`;
}

export function sha256File(file: string): string {
  return sha256Buffer(fs.readFileSync(file));
}

export function atomicWriteFile(file: string, value: string | NodeJS.ArrayBufferView) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  const temporary = `${file}.${process.pid}.${Date.now()}.tmp`;
  fs.writeFileSync(temporary, value);
  fs.renameSync(temporary, file);
}

export function atomicWriteJson(file: string, value: unknown) {
  atomicWriteFile(file, `${JSON.stringify(value, null, 2)}\n`);
}

export function readWorkflowState(work: string): WorkflowState | undefined {
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
  return value as WorkflowState;
}

export function comparisonIdentity(modelInput: WorkflowModelInput) {
  return {
    sourceComparison: modelInput.context?.sourceComparison,
    projects: (modelInput.context?.projects ?? []).map((project) => ({
      id: project.id,
      path: project.path,
      artifactComparison: project.artifactComparison,
    })),
  };
}

export function resolveWorkPath(work: string, relativePath: string): string {
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

export function hashArtifacts(work: string, relativePaths: string[]): Record<string, string> {
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

export function verifyArtifactHashes(
  work: string,
  artifactHashes: Record<string, string> | undefined,
): string[] {
  const errors: string[] = [];
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

export function transitionWorkflowState(
  work: string,
  state: string,
  details: WorkflowDetails = {},
): WorkflowState {
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
