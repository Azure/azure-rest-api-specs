import assert from "node:assert/strict";
import test from "node:test";
import {
  buildDocumentQualityInput,
  DOCUMENT_QUALITY_CRITERION,
} from "./document-quality-input.mjs";

/** @typedef {Parameters<typeof buildDocumentQualityInput>[0]} DocumentQualityArguments */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {import("./runtime-types.js").SourceDeclaration} SourceDeclaration */
/** @typedef {import("./runtime-types.js").SourceRevision} SourceRevision */

/**
 * @template T
 * @param {T | null | undefined} value
 * @returns {T}
 */
function required(value) {
  assert.ok(value);
  return value;
}

/** @returns {DocumentQualityArguments} */
function fixture(documentationPresent = true) {
  /** @type {SourceDeclaration} */
  const declaration = {
    id: "declaration-1",
    kind: "model",
    qualifiedName: "Widget",
    decorators: [],
    versionedMembers: [],
    documentationPresent,
    hunkIds: ["hunk-1"],
    source: { revision: "current", startLine: 1, endLine: 1 },
  };
  /** @type {SourceChange} */
  const source = {
    id: "source-1",
    path: "main.tsp",
    status: "modified",
    origins: [],
    hunks: [
      {
        id: "hunk-1",
        base: { startLine: 1, endLine: 1 },
        current: { startLine: 1, endLine: 1 },
        lines: [],
      },
    ],
    declarations: [declaration],
    documentEvidence: {
      schemaVersion: 4,
      status: "ready",
      blockers: [],
      declarations: [
        {
          declarationId: declaration.id,
          qualifiedName: declaration.qualifiedName,
          kind: declaration.kind,
          newDeclaration: true,
          documentationPresent,
          source: declaration.source,
        },
      ],
    },
  };
  /** @type {DocumentQualityArguments} */
  const args = {
    sourceIndex: { sourceChanges: [source] },
    semantic: {
      status: "ready",
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: [source.id],
          hunkIds: ["hunk-1"],
          declarationIds: [declaration.id],
        },
      ],
    },
  };
  return args;
}

void test("compiler-resolved documentation presence is retained without document text", () => {
  assert.equal(
    DOCUMENT_QUALITY_CRITERION,
    "Does the TypeSpec compiler return a nonempty effective document?",
  );
  const result = buildDocumentQualityInput(fixture(true));
  assert.equal(result.schemaVersion, 5);
  assert.equal(result.status, "ready");
  assert.equal(result.reviewUnits[0].status, "ready");
  assert.deepEqual(result.reviewUnits[0].declarations, [
    {
      declarationId: "declaration-1",
      qualifiedName: "Widget",
      kind: "model",
      documentationPresent: true,
      source: { revision: "current", startLine: 1, endLine: 1 },
      sourceChangeId: "source-1",
    },
  ]);
  assert.doesNotMatch(JSON.stringify(result), /docQuote|declaration source|description text/i);
});

void test("missing compiler documentation remains an assessable declaration", () => {
  const result = buildDocumentQualityInput(fixture(false));
  const reviewUnit = required(result.reviewUnits[0]);
  assert.equal(reviewUnit.status, "ready");
  assert.equal(required(required(reviewUnit.declarations)[0]).documentationPresent, false);
});

void test("v5 checks only newly added operation, model, enum, and interface declarations", () => {
  const args = fixture(false);
  const source = required(args.sourceIndex.sourceChanges[0]);
  /** @type {{id: string, kind: string, qualifiedName: string, revision: SourceRevision}[]} */
  const declarationDefinitions = [
    { id: "new-model", kind: "model", qualifiedName: "NewModel", revision: "current" },
    { id: "new-enum", kind: "enum", qualifiedName: "NewEnum", revision: "current" },
    { id: "new-interface", kind: "interface", qualifiedName: "NewInterface", revision: "current" },
    {
      id: "new-operation",
      kind: "operation",
      qualifiedName: "NewInterface.read",
      revision: "current",
    },
    {
      id: "modified-interface-base",
      kind: "interface",
      qualifiedName: "Existing",
      revision: "base",
    },
    { id: "modified-interface", kind: "interface", qualifiedName: "Existing", revision: "current" },
    { id: "new-property", kind: "property", qualifiedName: "NewModel.value", revision: "current" },
    { id: "new-namespace", kind: "namespace", qualifiedName: "Contoso", revision: "current" },
  ];
  const declarations = declarationDefinitions.map(
    /** @returns {SourceDeclaration} */ (item) => ({
      id: item.id,
      kind: item.kind,
      qualifiedName: item.qualifiedName,
      decorators: [],
      versionedMembers: [],
      documentationPresent: false,
      hunkIds: ["hunk-1"],
      source: { revision: item.revision, startLine: 1, endLine: 1 },
    }),
  );
  source.declarations = declarations;
  required(source.documentEvidence).declarations = declarations
    .filter((item) => item.source.revision === "current")
    .map((item) => ({
      declarationId: item.id,
      qualifiedName: item.qualifiedName,
      kind: item.kind,
      newDeclaration: item.qualifiedName !== "Existing",
      documentationPresent: false,
      source: item.source,
    }));
  required(args.semantic.reviewUnits[0]).declarationIds = declarations.map((item) => item.id);
  const result = buildDocumentQualityInput(args);
  assert.deepEqual(
    required(required(result.reviewUnits[0]).declarations)
      .map((item) => item.qualifiedName)
      .sort(),
    ["NewEnum", "NewInterface", "NewInterface.read", "NewModel"],
  );
});

void test("v5 ignores compiler blockers on sources without eligible new declarations", () => {
  const args = fixture(false);
  /** @type {SourceChange} */
  const unrelated = {
    id: "source-unrelated",
    path: "client.tsp",
    status: "modified",
    origins: [],
    hunks: [
      {
        id: "hunk-unrelated",
        base: { startLine: 1, endLine: 1 },
        current: { startLine: 1, endLine: 1 },
        lines: [],
      },
    ],
    declarations: [
      {
        id: "existing-current",
        kind: "interface",
        qualifiedName: "Existing",
        decorators: [],
        versionedMembers: [],
        hunkIds: ["hunk-unrelated"],
        source: { revision: "current", startLine: 1, endLine: 1 },
      },
      {
        id: "existing-base",
        kind: "interface",
        qualifiedName: "Existing",
        decorators: [],
        versionedMembers: [],
        hunkIds: ["hunk-unrelated"],
        source: { revision: "base", startLine: 1, endLine: 1 },
      },
    ],
    documentEvidence: {
      schemaVersion: 4,
      status: "blocked",
      blockers: [{ revision: "current", message: "Changed source was not compiled." }],
      declarations: [],
    },
  };
  args.sourceIndex.sourceChanges.push(unrelated);
  const semanticUnit = required(args.semantic.reviewUnits[0]);
  semanticUnit.sourceChangeIds.push(unrelated.id);
  required(semanticUnit.hunkIds).push("hunk-unrelated");
  required(semanticUnit.declarationIds).push("existing-current");
  const result = buildDocumentQualityInput(args);
  assert.equal(result.status, "ready");
  assert.deepEqual(
    required(required(result.reviewUnits[0]).declarations).map((item) => item.qualifiedName),
    ["Widget"],
  );
});

void test("compiler evidence blockers remain not-assessed input", () => {
  const args = fixture();
  required(args.sourceIndex.sourceChanges[0]).documentEvidence = {
    schemaVersion: 4,
    status: "blocked",
    blockers: [{ revision: "current", message: "Compiler failed." }],
    declarations: [],
  };
  const result = buildDocumentQualityInput(args);
  assert.equal(result.status, "blocked");
  const reviewUnit = required(result.reviewUnits[0]);
  assert.equal(reviewUnit.status, "blocked");
  assert.match(required(reviewUnit.reason), /Compiler failed/);
});

void test("a semantic unit without changed compiler declarations is not applicable", () => {
  const args = fixture();
  const source = required(args.sourceIndex.sourceChanges[0]);
  required(source.documentEvidence).declarations = [];
  const result = buildDocumentQualityInput(args);
  assert.equal(result.status, "ready");
  assert.equal(required(result.reviewUnits[0]).status, "not-applicable");
});

void test("legacy documentation evidence must be recollected", () => {
  const args = fixture();
  const source = required(args.sourceIndex.sourceChanges[0]);
  required(source.documentEvidence).schemaVersion = 3;
  const result = buildDocumentQualityInput(args);
  assert.equal(result.status, "blocked");
  assert.match(required(required(result.reviewUnits[0]).reason), /recollected/);
});
