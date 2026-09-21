import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { readJson } from "./cli.mjs";

export const WORKFLOW_STATE_FILE = "workflow-state.json";

export function sha256Buffer(value) {
  return `sha256:${crypto.createHash("sha256").update(value).digest("hex")}`;
}

export function sha256File(file) {
  return sha256Buffer(fs.readFileSync(file));
}

export function atomicWriteFile(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  const temporary = `${file}.${process.pid}.${Date.now()}.tmp`;
  fs.writeFileSync(temporary, value);
  fs.renameSync(temporary, file);
}

export function atomicWriteJson(file, value) {
  atomicWriteFile(file, `${JSON.stringify(value, null, 2)}\n`);
}

export function readWorkflowState(work) {
  const file = path.join(work, WORKFLOW_STATE_FILE);
  return fs.existsSync(file) ? readJson(file) : undefined;
}

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

export function hashArtifacts(work, relativePaths) {
  return Object.fromEntries(
    [...new Set(relativePaths)]
      .sort()
      .map((relativePath) => {
        const file = resolveWorkPath(work, relativePath);
        if (!fs.existsSync(file)) {
          throw new Error(`Missing canonical artifact: ${relativePath}.`);
        }
        return [relativePath.replaceAll("\\", "/"), sha256File(file)];
      }),
  );
}

export function verifyArtifactHashes(work, artifactHashes) {
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
