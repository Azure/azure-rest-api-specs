import { assert, test } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { pathToFileURL } from "node:url";
import {
  AGENT_INDEX_FILE,
  captureAssessmentRuntime,
  resolvedRuntimeCommand,
  verifyAssessmentRuntime,
} from "../scripts/assessment-runtime.ts";
import { writeJson } from "../scripts/cli.ts";
import { transitionWorkflowState } from "../scripts/workflow-state.ts";

function fixture() {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".runtime binding & ' test-"));
  const root = path.join(work, "runtime origin");
  const script = path.join(root, "scripts", "phase.ts");
  fs.mkdirSync(path.dirname(script), { recursive: true });
  fs.writeFileSync(script, "export const phase = 1;\n");
  writeJson(path.join(root, "scripts", "phase.schema.json"), { type: "object" });
  writeJson(path.join(root, "package.json"), { name: "assessment-runtime-test" });
  fs.mkdirSync(path.join(root, "references"), { recursive: true });
  fs.writeFileSync(path.join(root, "references", "reference-document-links.md"), "Catalog\n");
  const metaUrl = pathToFileURL(script).href;
  const runtime = captureAssessmentRuntime(metaUrl);
  writeJson(path.join(work, AGENT_INDEX_FILE), { runtime });
  transitionWorkflowState(work, "awaiting-agent-judgment", { runtime });
  return { work, root, script, metaUrl, runtime };
}

void test("fingerprints only bounded assessment code and contracts, not compilation environments", () => {
  const { work, root, metaUrl, runtime } = fixture();
  try {
    writeJson(path.join(root, "node_modules", "compiler", "package.json"), { version: "1.0.0" });
    writeJson(path.join(root, "specification", "synthetic-input.json"), { version: "base" });
    writeJson(path.join(root, "tests", "output.json"), { generated: true });
    writeJson(path.join(work, "projects", "head", "package.json"), { compiler: "2.0.0" });
    assert.deepEqual(captureAssessmentRuntime(metaUrl), runtime);

    const schema = path.join(root, "scripts", "phase.schema.json");
    writeJson(schema, { type: "string" });
    assert.notEqual(captureAssessmentRuntime(metaUrl).fingerprint, runtime.fingerprint);
    writeJson(schema, { type: "object" });
    assert.deepEqual(captureAssessmentRuntime(metaUrl), runtime);

    const newScript = path.join(root, "scripts", "new-contract.ts");
    fs.writeFileSync(newScript, "export const newContract = true;\n");
    assert.notEqual(captureAssessmentRuntime(metaUrl).fingerprint, runtime.fingerprint);
    fs.rmSync(newScript);
    fs.writeFileSync(path.join(root, "references", "reference-document-links.md"), "New catalog\n");
    assert.notEqual(captureAssessmentRuntime(metaUrl).fingerprint, runtime.fingerprint);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("verifies the originating runtime and preserves shell-sensitive paths as argument tokens", () => {
  const { work, metaUrl, runtime, script } = fixture();
  try {
    assert.deepEqual(verifyAssessmentRuntime(work, metaUrl), runtime);
    assert.deepEqual(resolvedRuntimeCommand(runtime, "scripts/phase.ts", ["--work", work]), {
      executable: process.execPath,
      args: [script, "--work", work],
    });
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("rejects a different executing origin even with identical code and contracts", () => {
  const { work, root, metaUrl, runtime } = fixture();
  try {
    const otherRoot = path.join(work, "other runtime");
    fs.cpSync(root, otherRoot, { recursive: true });
    const otherUrl = pathToFileURL(path.join(otherRoot, "scripts", "phase.ts")).href;
    assert.equal(captureAssessmentRuntime(otherUrl).fingerprint, runtime.fingerprint);
    assert.throws(() => verifyAssessmentRuntime(work, otherUrl), /Wrong runtime origin/);
    assert.deepEqual(verifyAssessmentRuntime(work, metaUrl), runtime);
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("rejects changed runtime code with explicit recovery instructions", () => {
  const { work, script, metaUrl } = fixture();
  try {
    fs.appendFileSync(script, "export const changed = true;\n");
    assert.throws(
      () => verifyAssessmentRuntime(work, metaUrl),
      /Runtime fingerprint changed[\s\S]*Rerun preparation[\s\S]*Do not change compatibility judgments/,
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});

void test("rejects missing and unsupported bindings rather than treating them as Agent judgments", () => {
  const { work, metaUrl, runtime } = fixture();
  try {
    writeJson(path.join(work, AGENT_INDEX_FILE), {});
    assert.throws(() => verifyAssessmentRuntime(work, metaUrl), /Missing or unsupported runtime/);
    writeJson(path.join(work, AGENT_INDEX_FILE), { runtime: { ...runtime, schemaVersion: 2 } });
    assert.throws(() => verifyAssessmentRuntime(work, metaUrl), /Missing or unsupported runtime/);
    writeJson(path.join(work, AGENT_INDEX_FILE), { runtime });
    transitionWorkflowState(work, "awaiting-agent-judgment", { runtime: undefined });
    assert.throws(
      () => verifyAssessmentRuntime(work, metaUrl),
      /Missing or unsupported runtime binding in workflow-state/,
    );
  } finally {
    fs.rmSync(work, { recursive: true, force: true });
  }
});
