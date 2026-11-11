import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { assert, test } from "vitest";
import {
  buildSourceAssociation,
  loadSourceAssociation,
  materializeSourceAssociation,
  querySourceAssociation,
  type SourceAssociationInput,
} from "../scripts/source-association.ts";
import {
  atomicWriteJson,
  hashArtifacts,
  transitionWorkflowState,
} from "../scripts/workflow-state.ts";
import { validateCompactDecisions } from "../scripts/materialize-assessment-results.ts";
import {
  captureAssessmentRuntime,
  createRuntimePhaseProvenance,
} from "../scripts/assessment-runtime.ts";

function freeze(root: string) {
  const runtime = captureAssessmentRuntime(
    new URL("../scripts/source-association.ts", import.meta.url).href,
  );
  atomicWriteJson(path.join(root, "agent-workspace/agent-index.json"), { runtime });
  atomicWriteJson(path.join(root, "compliance-search-evidence.json"), {});
  transitionWorkflowState(root, "judgment-materialized", {
    runtime,
    artifactHashes: hashArtifacts(root, [
      "model-input.json",
      "source/source-index.json",
      "dimensions/rest-breaking-input.json",
      "dimensions/downstream-breaking-input.json",
      "dimensions/semantic-intents-input.json",
    ]),
    judgmentArtifactHashes: hashArtifacts(root, ["assessment-judgment.json"]),
    runtimePhases: {
      materialization: createRuntimePhaseProvenance(
        root,
        runtime,
        ["agent-workspace/agent-index.json"],
        ["assessment-judgment.json", "compliance-search-evidence.json"],
      ),
    },
  });
}

function fixture(context: { onTestFinished: (fn: () => void) => void }, approvals = true) {
  const root = fs.mkdtempSync(path.join(process.cwd(), ".source-association-test-"));
  context.onTestFinished(() => fs.rmSync(root, { recursive: true, force: true }));
  const write = (file: string, value: unknown) => atomicWriteJson(path.join(root, file), value);
  const declaration = (id: string, kind: string, name: string) => ({
    id,
    kind,
    qualifiedName: name,
    decorators: [],
    versionedMembers: [],
    hunkIds: ["hunk-op"],
    source: { revision: "current", startLine: 1, endLine: 3 },
    sourceSnippet: {
      startLine: 1,
      endLine: 3,
      lines: [`${kind} ${name} {`, "}", ""],
      truncated: false,
    },
  });
  write("source/source-index.json", {
    sourceChanges: [
      {
        id: "source-op",
        path: "Service.tsp",
        declarations: [
          declaration("decl-operation", "operation", "Service.update"),
          declaration("decl-helper", "model", "Service.Helper"),
        ],
        hunks: [],
      },
      {
        id: "source-unrelated",
        path: "models.tsp",
        declarations: Array.from({ length: 100 }, (_, i) =>
          declaration(`unrelated-${i}`, "model", `Unrelated${i}`),
        ),
        hunks: [],
      },
    ],
  });
  const candidate = (id: string) => ({
    id,
    rule: "lro-behavior-changed",
    defaultSeverity: "medium",
    actual: "LRO changed",
    expected: "Preserve LRO",
    operationIds: ["Service_Update"],
    sourceChangeIds: ["source-op", "source-unrelated"],
    evidenceFactIds: ["operation-fact"],
    reviewRequired: true,
  });
  write("dimensions/rest-breaking-input.json", {
    facts: {
      "operation-fact": {
        id: "operation-fact",
        projectId: "project",
        comparisonRole: "target",
        operationId: "Service_Update",
      },
    },
    candidates: ["rest-1", "rest-2", "rest-rejected"].map(candidate),
    blockers: [],
  });
  write("dimensions/downstream-breaking-input.json", { facts: {}, candidates: [], blockers: [] });
  write("dimensions/semantic-intents-input.json", {
    reviewUnits: [
      {
        projectId: "project",
        operations: [
          {
            operationId: "Service_Update",
            sourceChangeIds: ["source-op"],
            hunkIds: ["hunk-op"],
            declarationIds: ["decl-operation"],
          },
        ],
      },
    ],
  });
  write("model-input.json", {
    pipelineVersion: 2,
    facts: {
      "operation-fact": {
        id: "operation-fact",
        projectId: "project",
        comparisonRole: "target",
        operationId: "Service_Update",
      },
    },
    artifactReferences: {
      sourceIndex: "source/source-index.json",
      restCandidates: "dimensions/rest-breaking-input.json",
      downstreamCandidates: "dimensions/downstream-breaking-input.json",
      semanticReviewUnits: "dimensions/semantic-intents-input.json",
    },
  });
  write("assessment-judgment.json", {
    schemaVersion: 1,
    pipelineVersion: 2,
    semanticIntents: [],
    complianceDecisions: [],
    downstreamDecisions: [],
    restDecisions: ["rest-1", "rest-2", "rest-rejected"].map((id, i) => ({
      candidateId: id,
      decision: approvals && i < 2 ? "approve" : "reject",
      ...(approvals && i < 2 ? { severity: "medium" } : {}),
      rationale: "Evidence checked.",
    })),
    overallConfidence: "high",
    blockers: [],
  });
  freeze(root);
  return { root, write };
}
function input(work: string) {
  return JSON.parse(
    fs.readFileSync(path.join(work, "source-association-input.json"), "utf8"),
  ) as SourceAssociationInput;
}
function decisions(work: string, selection: unknown[]) {
  const model = input(work);
  atomicWriteJson(path.join(work, "source-association/agent-decisions.json"), {
    schemaVersion: 1,
    judgmentHash: model.judgmentHash,
    sourceIndexHash: model.sourceIndexHash,
    selections: selection,
  });
}

test("REST source ownership uses canonical schemas, not lossy compact summaries", (context) => {
  const { root, write } = fixture(context);
  const rest = JSON.parse(
    fs.readFileSync(path.join(root, "dimensions/rest-breaking-input.json"), "utf8"),
  );
  rest.facts["operation-fact"].request = {
    kind: "body",
    schema: {
      kind: "object",
      reference: "#/definitions/Service.Helper",
      properties: [{ name: "name", required: true, schema: { kind: "string", type: "string" } }],
    },
  };
  for (const candidate of rest.candidates) {
    candidate.rule = "property-required";
    candidate.contractChange = { rule: "property-required", location: "request body.name" };
  }
  write("dimensions/rest-breaking-input.json", rest);
  const model = JSON.parse(fs.readFileSync(path.join(root, "model-input.json"), "utf8"));
  model.facts["operation-fact"].request = { kind: "body", schema: { kind: "object" } };
  write("model-input.json", model);
  freeze(root);
  buildSourceAssociation({ work: root });
  const source = input(root);
  assert.equal(source.items[0].contractIdentity, "Service.Helper");
  assert.deepEqual(source.items[0].proposal.declarationIds, ["decl-helper"]);
});

test("the advertised valueless --materialize CLI flag succeeds", (context) => {
  const { root } = fixture(context);
  buildSourceAssociation({ work: root });
  decisions(root, [
    {
      itemId: input(root).items[0].id,
      outcome: "keep",
      selectedDeclarationIds: ["decl-operation"],
      rationale: "Complete operation.",
    },
  ]);
  const entry = fileURLToPath(new URL("../scripts/source-association.ts", import.meta.url));
  const result = spawnSync(process.execPath, [entry, "--work", root, "--materialize"], {
    encoding: "utf8",
  });
  assert.equal(result.status, 0, result.stderr);
  assert.equal(loadSourceAssociation(root).status, "complete");
});

test("judgment-only decisions omit source reviews and reject joint-phase input", () => {
  const value = {
    schemaVersion: 2,
    semanticSummaries: [],
    restDecisions: [],
    downstreamDecisions: [],
    catalogScores: [],
    fetchedDocuments: [],
    failedRetrievals: [],
    searchBlockers: [],
    complianceJudgments: [],
    overallConfidence: "high",
    blockers: [],
  };
  assert.doesNotThrow(() => validateCompactDecisions(value));
  assert.throws(
    () => validateCompactDecisions({ ...value, sourceReviews: [] }),
    /must not contain/,
  );
});

test("source stage rejects a mismatched pinned assessment runtime", (context) => {
  const { root } = fixture(context);
  const file = path.join(root, "agent-workspace/agent-index.json");
  const index = JSON.parse(fs.readFileSync(file, "utf8"));
  index.runtime.fingerprint = `sha256:${"0".repeat(64)}`;
  atomicWriteJson(file, index);
  assert.throws(() => buildSourceAssociation({ work: root }), /runtime tooling error/);
});

test("only approved findings receive shared, narrow operation source contexts", (context) => {
  const { root } = fixture(context);
  const built = buildSourceAssociation({ work: root });
  const model = input(root);
  assert.equal(built.itemCount, 1);
  assert.deepEqual(model.items[0].findingIds, ["rest-1", "rest-2"]);
  assert.deepEqual(Object.keys(model.declarations), ["decl-operation"]);
  assert.deepEqual(model.items[0].allowedSourceChangeIds, ["source-op"]);
  assert.throws(() => loadSourceAssociation(root));
  const frozenBefore = fs.readFileSync(path.join(root, "assessment-judgment.json"), "utf8");
  decisions(root, [
    {
      itemId: model.items[0].id,
      outcome: "keep",
      selectedDeclarationIds: ["decl-operation"],
      rationale: "Complete operation.",
    },
  ]);
  const result = materializeSourceAssociation({ work: root });
  assert.equal(result.status, "complete");
  assert.deepEqual(Object.keys(result.reviews).sort(), ["rest-1", "rest-2"]);
  assert.equal(fs.readFileSync(path.join(root, "assessment-judgment.json"), "utf8"), frozenBefore);
  assert.deepEqual(loadSourceAssociation(root), result);
});

test("no approved breakings skips source AI with a validated not-applicable result", (context) => {
  const { root } = fixture(context, false);
  assert.equal(buildSourceAssociation({ work: root }).itemCount, 0);
  assert.equal(loadSourceAssociation(root).status, "not-applicable");
});

test("removed generated type uses its proven operation declarations without consumer enumeration", (context) => {
  const { root, write } = fixture(context);
  const raw = JSON.parse(
    fs.readFileSync(path.join(root, "dimensions/rest-breaking-input.json"), "utf8"),
  );
  const generated = {
    ...raw.candidates[0],
    id: "generated-removal",
    rule: "public-surface-changed",
    crossLanguageDefinitionId: "Contoso.GenericUpdate",
    operationIds: undefined,
    sourceChangeIds: ["source-op"],
    declarationIds: ["decl-operation"],
    hunkIds: ["hunk-op"],
  };
  write("dimensions/downstream-breaking-input.json", {
    facts: {},
    candidates: [generated],
    blockers: [],
  });
  const judgment = JSON.parse(fs.readFileSync(path.join(root, "assessment-judgment.json"), "utf8"));
  judgment.restDecisions = [];
  judgment.downstreamDecisions = [
    {
      candidateId: generated.id,
      decision: "approve",
      severity: "high",
      rationale: "Public generated type removed.",
    },
  ];
  write("assessment-judgment.json", judgment);
  const model = JSON.parse(fs.readFileSync(path.join(root, "model-input.json"), "utf8"));
  model.facts["operation-fact"].comparisonRole = "baseline";
  write("model-input.json", model);
  raw.facts["operation-fact"].comparisonRole = "baseline";
  write("dimensions/rest-breaking-input.json", raw);
  freeze(root);
  buildSourceAssociation({ work: root });
  assert.deepEqual(input(root).items[0].proposal.declarationIds, ["decl-operation"]);
  assert.deepEqual(input(root).items[0].allowedSourceChangeIds, ["source-op"]);
});

test("targeted queries add canonical support without opening unrelated model inventory", (context) => {
  const { root } = fixture(context);
  buildSourceAssociation({ work: root });
  const model = input(root);
  const itemId = model.items[0].id;
  assert.equal(
    querySourceAssociation({ work: root, itemId, qualifiedName: "Unrelated1" }).declarations.length,
    0,
  );
  assert.equal(
    querySourceAssociation({ work: root, itemId, qualifiedName: "Service.Helper" }).declarations
      .length,
    1,
  );
  decisions(root, [
    {
      itemId,
      outcome: "refine",
      selectedDeclarationIds: ["decl-operation", "decl-helper"],
      rationale: "Helper explains the contract.",
    },
  ]);
  assert.equal(
    materializeSourceAssociation({ work: root }).reviews["rest-1"].selectedDeclarations.length,
    2,
  );
});

test("source insufficiency preserves breakings as explicit partial source coverage", (context) => {
  const { root } = fixture(context);
  buildSourceAssociation({ work: root });
  decisions(root, [
    {
      itemId: input(root).items[0].id,
      outcome: "unresolved",
      selectedDeclarationIds: [],
      rationale: "Cannot prove exact source.",
    },
  ]);
  assert.equal(materializeSourceAssociation({ work: root }).status, "partial");
  assert.equal(loadSourceAssociation(root).reviews["rest-1"].outcome, "unresolved");
});

test("unknown, duplicate, missing and unregistered source selections fail validation", (context) => {
  const { root } = fixture(context);
  buildSourceAssociation({ work: root });
  const selection = {
    itemId: input(root).items[0].id,
    outcome: "refine",
    selectedDeclarationIds: ["unrelated-1"],
    rationale: "Not allowed.",
  };
  decisions(root, [selection]);
  assert.throws(
    () => materializeSourceAssociation({ work: root }),
    /outside its canonical context/,
  );
  decisions(root, []);
  assert.throws(() => materializeSourceAssociation({ work: root }), /coverage mismatch/);
  decisions(root, [selection, selection]);
  assert.throws(() => materializeSourceAssociation({ work: root }), /coverage mismatch/);
});

test("changed frozen judgment or source payload cannot be reused", (context) => {
  const { root, write } = fixture(context);
  buildSourceAssociation({ work: root });
  write("assessment-judgment.json", { pipelineVersion: 2, restDecisions: [] });
  assert.throws(
    () =>
      querySourceAssociation({
        work: root,
        itemId: input(root).items[0].id,
        qualifiedName: "Service.Helper",
      }),
    /Frozen assessment inputs changed/,
  );
});
