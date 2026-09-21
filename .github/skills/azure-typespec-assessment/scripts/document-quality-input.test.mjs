import assert from "node:assert/strict";
import test from "node:test";
import {
  buildDocumentQualityInput,
  DOCUMENT_QUALITY_CRITERION,
} from "./document-quality-input.mjs";

function fixture(documentationPresent = true) {
  const declaration = {
    id: "declaration-1",
    kind: "model",
    qualifiedName: "Widget",
    documentationPresent,
    hunkIds: ["hunk-1"],
    source: { revision: "current", startLine: 1, endLine: 1 },
  };
  const source = {
    id: "source-1",
    path: "main.tsp",
    hunks: [{ id: "hunk-1" }],
    declarations: [declaration],
    documentEvidence: {
      schemaVersion: 4,
      status: "ready",
      blockers: [],
      declarations: [{
        declarationId: declaration.id,
        qualifiedName: declaration.qualifiedName,
        kind: declaration.kind,
        documentationPresent,
        source: declaration.source,
      }],
    },
  };
  const semantic = {
    status: "ready",
    reviewUnits: [{
      id: "semantic-1",
      sourceChangeIds: [source.id],
      hunkIds: ["hunk-1"],
      declarationIds: [declaration.id],
    }],
  };
  return { sourceIndex: { sourceChanges: [source] }, semantic };
}

test("compiler-resolved documentation presence is retained without document text", () => {
  assert.equal(
    DOCUMENT_QUALITY_CRITERION,
    "Does the TypeSpec compiler return a nonempty effective document?",
  );
  const result = buildDocumentQualityInput(fixture(true));
  assert.equal(result.schemaVersion, 5);
  assert.equal(result.status, "ready");
  assert.equal(result.reviewUnits[0].status, "ready");
  assert.deepEqual(result.reviewUnits[0].declarations, [{
    declarationId: "declaration-1",
    qualifiedName: "Widget",
    kind: "model",
    documentationPresent: true,
    source: { revision: "current", startLine: 1, endLine: 1 },
    sourceChangeId: "source-1",
  }]);
  assert.doesNotMatch(JSON.stringify(result), /docQuote|declaration source|description text/i);
});

test("missing compiler documentation remains an assessable declaration", () => {
  const result = buildDocumentQualityInput(fixture(false));
  assert.equal(result.reviewUnits[0].status, "ready");
  assert.equal(result.reviewUnits[0].declarations[0].documentationPresent, false);
});

test("v5 checks only newly added operation, model, enum, and interface declarations", () => {
  const args = fixture(false);
  const source = args.sourceIndex.sourceChanges[0];
  const declarations = [
    { id: "new-model", kind: "model", qualifiedName: "NewModel", revision: "current" },
    { id: "new-enum", kind: "enum", qualifiedName: "NewEnum", revision: "current" },
    { id: "new-interface", kind: "interface", qualifiedName: "NewInterface", revision: "current" },
    { id: "new-operation", kind: "operation", qualifiedName: "NewInterface.read", revision: "current" },
    { id: "modified-interface-base", kind: "interface", qualifiedName: "Existing", revision: "base" },
    { id: "modified-interface", kind: "interface", qualifiedName: "Existing", revision: "current" },
    { id: "new-property", kind: "property", qualifiedName: "NewModel.value", revision: "current" },
    { id: "new-namespace", kind: "namespace", qualifiedName: "Contoso", revision: "current" },
  ].map((item) => ({
    id: item.id,
    kind: item.kind,
    qualifiedName: item.qualifiedName,
    documentationPresent: false,
    hunkIds: ["hunk-1"],
    source: { revision: item.revision, startLine: 1, endLine: 1 },
  }));
  source.declarations = declarations;
  source.documentEvidence.declarations = declarations
    .filter((item) => item.source.revision === "current")
    .map((item) => ({
      declarationId: item.id,
      qualifiedName: item.qualifiedName,
      kind: item.kind,
      documentationPresent: false,
      source: item.source,
    }));
  args.semantic.reviewUnits[0].declarationIds = declarations.map((item) => item.id);
  const result = buildDocumentQualityInput(args);
  assert.deepEqual(
    result.reviewUnits[0].declarations.map((item) => item.qualifiedName).sort(),
    ["NewEnum", "NewInterface", "NewInterface.read", "NewModel"],
  );
});

test("v5 ignores compiler blockers on sources without eligible new declarations", () => {
  const args = fixture(false);
  const unrelated = {
    id: "source-unrelated",
    path: "client.tsp",
    hunks: [{ id: "hunk-unrelated" }],
    declarations: [{
      id: "existing-current",
      kind: "interface",
      qualifiedName: "Existing",
      hunkIds: ["hunk-unrelated"],
      source: { revision: "current", startLine: 1, endLine: 1 },
    }, {
      id: "existing-base",
      kind: "interface",
      qualifiedName: "Existing",
      hunkIds: ["hunk-unrelated"],
      source: { revision: "base", startLine: 1, endLine: 1 },
    }],
    documentEvidence: {
      schemaVersion: 4,
      status: "blocked",
      blockers: [{ message: "Changed source was not compiled." }],
      declarations: [],
    },
  };
  args.sourceIndex.sourceChanges.push(unrelated);
  args.semantic.reviewUnits[0].sourceChangeIds.push(unrelated.id);
  args.semantic.reviewUnits[0].hunkIds.push("hunk-unrelated");
  args.semantic.reviewUnits[0].declarationIds.push("existing-current");
  const result = buildDocumentQualityInput(args);
  assert.equal(result.status, "ready");
  assert.deepEqual(
    result.reviewUnits[0].declarations.map((item) => item.qualifiedName),
    ["Widget"],
  );
});

test("compiler evidence blockers remain not-assessed input", () => {
  const args = fixture();
  args.sourceIndex.sourceChanges[0].documentEvidence = {
    schemaVersion: 4,
    status: "blocked",
    blockers: [{ message: "Compiler failed." }],
    declarations: [],
  };
  const result = buildDocumentQualityInput(args);
  assert.equal(result.status, "blocked");
  assert.equal(result.reviewUnits[0].status, "blocked");
  assert.match(result.reviewUnits[0].reason, /Compiler failed/);
});

test("a semantic unit without changed compiler declarations is not applicable", () => {
  const args = fixture();
  args.sourceIndex.sourceChanges[0].documentEvidence.declarations = [];
  const result = buildDocumentQualityInput(args);
  assert.equal(result.status, "ready");
  assert.equal(result.reviewUnits[0].status, "not-applicable");
});

test("legacy documentation evidence must be recollected", () => {
  const args = fixture();
  args.sourceIndex.sourceChanges[0].documentEvidence.schemaVersion = 3;
  const result = buildDocumentQualityInput(args);
  assert.equal(result.status, "blocked");
  assert.match(result.reviewUnits[0].reason, /recollected/);
});
