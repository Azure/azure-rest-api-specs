import assert from "node:assert/strict";
import path from "node:path";
import test from "node:test";
import { addCompilerEvidence, buildSourceIndex, parseUnifiedHunks } from "./source-index.mjs";

/** @typedef {import("./runtime-types.js").CompilerApi} CompilerApi */

/**
 * @template T
 * @param {T | undefined} value
 * @returns {T}
 */
function required(value) {
  if (value === undefined) {
    assert.fail("Expected value to be defined.");
  }
  return value;
}

void test("parseUnifiedHunks retains base and current ranges", () => {
  const hunks = parseUnifiedHunks(`diff --git a/main.tsp b/main.tsp
--- a/main.tsp
+++ b/main.tsp
@@ -2,2 +2,3 @@
 model Widget {
-  name: string;
+  name: string;
+  mode?: string;
 }`);
  assert.equal(hunks.length, 1);
  const hunk = required(hunks[0]);
  assert.deepEqual(hunk.base, { startLine: 2, endLine: 3 });
  assert.deepEqual(hunk.current, { startLine: 2, endLine: 4 });
  assert.match(hunk.id, /^hunk-/);
});

void test("indexes changed interface operation members", () => {
  const files = {
    base: "interface Widgets {\n  get is ArmResourceRead<Widget>;\n}\n",
    working:
      "interface Widgets {\n  get is ArmResourceRead<Widget>;\n  cancel is ArmResourceActionAsync<Widget>;\n}\n",
  };
  const index = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [
      {
        path: "specification/widgets/main.tsp",
        status: "modified",
        origins: ["committed"],
      },
    ],
    remoteUrl: "",
    readFile: (revision) => files[/** @type {keyof typeof files} */ (revision)] ?? files.working,
    diffFile: () => `@@ -1,3 +1,4 @@
 interface Widgets {
   get is ArmResourceRead<Widget>;
+  cancel is ArmResourceActionAsync<Widget>;
 }`,
  });
  assert.ok(
    required(index.sourceChanges[0]).declarations.some(
      (item) => item.kind === "operation" && item.qualifiedName === "Widgets.cancel",
    ),
  );
});

void test("does not classify inline operation response fields as interface properties", () => {
  const content = `interface Widgets {
  get(...ResourceParameters<Widget>):
    | OkResponse
    | {
        location: string;
      };
}
`;
  const index = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [
      {
        path: "specification/widgets/main.tsp",
        status: "modified",
        origins: ["committed"],
      },
    ],
    remoteUrl: "",
    readFile: () => content,
    diffFile: () => `@@ -1,7 +1,7 @@
 interface Widgets {
   get(...ResourceParameters<Widget>):
     | OkResponse
     | {
-        location: string;
+        location: url;
       };
 }`,
  });

  assert.ok(
    !required(index.sourceChanges[0]).declarations.some(
      (item) => item.kind === "property" && item.qualifiedName === "Widgets.location",
    ),
  );
});

void test("raw revision sources are not serialized and unavailable compilers block documentation presence", async () => {
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified", origins: ["working"] }],
    readFile: () => '@doc("private raw marker") model Widget {}',
    diffFile: () => "@@ -1 +1 @@\n-model Widget {}\n+model Widget { x: string; }",
  });
  assert.ok(!JSON.stringify(sourceIndex).includes("private raw marker"));
  await addCompilerEvidence({
    sourceIndex,
    baseWorktree: ".",
    currentWorktree: ".",
    projects: ["main.tsp"],
    loadCompiler: () => {
      throw new Error("Compiler missing");
    },
  });
  assert.equal(sourceIndex.analysis.status, "blocked");
  const evidence = required(required(sourceIndex.sourceChanges[0]).documentEvidence);
  assert.equal(evidence.status, "blocked");
  assert.equal(evidence.schemaVersion, 4);
  assert.equal(evidence.blockers.length, 1);
  assert.deepEqual(evidence.declarations, []);
});

void test("failed compiler programs never report @doc evidence ready", async () => {
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified", origins: [] }],
    readFile: () => '@doc("A model") model Widget {}',
    diffFile: () => "@@ -1 +1 @@\n-model Widget {}\n+model Widget { x: string; }",
  });
  await addCompilerEvidence({
    sourceIndex,
    baseWorktree: ".",
    currentWorktree: ".",
    projects: ["main.tsp"],
    loadCompiler: () => ({
      NodeHost: {},
      compile: () => ({
        diagnostics: [{ severity: "error" }],
        sourceFiles: new Map(),
      }),
      navigateProgram: () => {},
      getSourceLocation: () => ({ pos: 0, end: 0 }),
    }),
  });
  assert.equal(sourceIndex.analysis.status, "blocked");
  assert.equal(required(required(sourceIndex.sourceChanges[0]).documentEvidence).status, "blocked");
});

void test("compiler evidence records only documentation presence on changed declarations", async () => {
  const sourceText = "model Widget { value: string; }";
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified", origins: [] }],
    readFile: () => sourceText,
    diffFile: () => "@@ -1 +1 @@\n-model Widget {}\n+model Widget { value: string; }",
  });
  const filePath = path.resolve("main.tsp");
  let revision = 0;
  await addCompilerEvidence({
    sourceIndex,
    baseWorktree: ".",
    currentWorktree: ".",
    projects: ["main.tsp"],
    loadCompiler: /** @returns {CompilerApi} */ () => {
      const documentation = revision++ ? "A widget." : "";
      const file = {
        path: filePath,
        text: sourceText,
        getLineAndCharacterOfPosition: () => ({ line: 0, character: 0 }),
      };
      const type = { kind: "Model", name: "Widget" };
      return {
        compilerVersion: "test",
        NodeHost: {},
        compile: () => ({
          diagnostics: [],
          sourceFiles: new Map([["main.tsp", { file }]]),
        }),
        navigateProgram: (_program, listeners) => listeners.model(type),
        getSourceLocation: () => ({ file, pos: 0, end: sourceText.length }),
        getDoc: () => documentation,
      };
    },
  });
  const source = required(sourceIndex.sourceChanges[0]);
  const evidence = required(source.documentEvidence);
  assert.equal(evidence.schemaVersion, 4);
  assert.equal(evidence.status, "ready");
  assert.deepEqual(
    evidence.declarations.map((item) => ({
      qualifiedName: item.qualifiedName,
      documentationPresent: item.documentationPresent,
    })),
    [{ qualifiedName: "Widget", documentationPresent: true }],
  );
  assert.equal(JSON.stringify(evidence).includes("A widget."), false);
  assert.deepEqual(
    required(source.declarations.find((item) => item.source.revision === "current")).sourceSnippet,
    {
      startLine: 1,
      endLine: 1,
      lines: ["model Widget { value: string; }"],
      truncated: false,
    },
  );
});

void test("compiler evidence excludes unchanged declarations that are only diff context", async () => {
  const baseText = "interface Unchanged {}\ninterface Changed {}\n";
  const currentText = "interface Unchanged {}\ninterface Changed {\n  added(): void;\n}\n";
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified", origins: [] }],
    readFile: (revision) => (revision === "base" ? baseText : currentText),
    diffFile: () => `@@ -1,2 +1,4 @@
 interface Unchanged {}
-interface Changed {}
+interface Changed {
+  added(): void;
+}`,
  });
  const filePath = path.resolve("main.tsp");
  let revision = 0;
  await addCompilerEvidence({
    sourceIndex,
    baseWorktree: ".",
    currentWorktree: ".",
    projects: ["main.tsp"],
    loadCompiler: /** @returns {CompilerApi} */ () => {
      const text = revision++ ? currentText : baseText;
      const file = {
        path: filePath,
        text,
        getLineAndCharacterOfPosition: (/** @type {number} */ position) => ({
          line: text.slice(0, position).split("\n").length - 1,
          character: 0,
        }),
      };
      const unchanged = { kind: "Interface", name: "Unchanged" };
      const changed = { kind: "Interface", name: "Changed" };
      return {
        compilerVersion: "test",
        NodeHost: {},
        compile: () => ({
          diagnostics: [],
          sourceFiles: new Map([["main.tsp", { file }]]),
        }),
        navigateProgram: (_program, listeners) => {
          listeners.interface(unchanged);
          listeners.interface(changed);
        },
        getSourceLocation: (type) => {
          const marker = `interface ${type.name}`;
          const pos = text.indexOf(marker);
          const end =
            type === changed && text.includes("added")
              ? text.length - 1
              : pos + text.slice(pos).split("\n")[0].length;
          return { file, pos, end };
        },
        getDoc: () => "",
      };
    },
  });
  assert.deepEqual(
    required(required(sourceIndex.sourceChanges[0]).documentEvidence).declarations.map(
      (item) => item.qualifiedName,
    ),
    ["Changed"],
  );
});

void test("compiler evidence includes a declaration when only its documentation prefix changes", async () => {
  const baseText = "model Widget {}\n";
  const currentText = "/** A widget. */\nmodel Widget {}\n";
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified", origins: [] }],
    readFile: (revision) => (revision === "base" ? baseText : currentText),
    diffFile: () => `@@ -1 +1,2 @@
+/** A widget. */
 model Widget {}`,
  });
  const filePath = path.resolve("main.tsp");
  let revision = 0;
  await addCompilerEvidence({
    sourceIndex,
    baseWorktree: ".",
    currentWorktree: ".",
    projects: ["main.tsp"],
    loadCompiler: () => {
      const current = revision++ === 1;
      const text = current ? currentText : baseText;
      const file = {
        path: filePath,
        text,
        getLineAndCharacterOfPosition: (/** @type {number} */ position) => ({
          line: text.slice(0, position).split("\n").length - 1,
          character: 0,
        }),
      };
      const type = { kind: "Model", name: "Widget" };
      return {
        compilerVersion: "test",
        NodeHost: {},
        compile: () => ({
          diagnostics: [],
          sourceFiles: new Map([["main.tsp", { file }]]),
        }),
        navigateProgram: (_program, listeners) => listeners.model(type),
        getSourceLocation: () => {
          const pos = text.indexOf("model Widget");
          return { file, pos, end: pos + "model Widget {}".length };
        },
        getDoc: () => (current ? "A widget." : ""),
      };
    },
  });
  assert.deepEqual(
    required(required(sourceIndex.sourceChanges[0]).documentEvidence).declarations.map((item) => ({
      qualifiedName: item.qualifiedName,
      documentationPresent: item.documentationPresent,
    })),
    [{ qualifiedName: "Widget", documentationPresent: true }],
  );
});

void test("compiler evidence preserves parsed decorators and source links", async () => {
  const baseText = '@clientName("OldWidget")\nmodel Widget {}\n';
  const currentText = '@clientName("Widget")\nmodel Widget {}\n';
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified", origins: [] }],
    remoteUrl: "https://github.com/contoso/widgets.git",
    readFile: (revision) => (revision === "base" ? baseText : currentText),
    diffFile: () => `@@ -1,2 +1,2 @@
-@clientName("OldWidget")
+@clientName("Widget")
 model Widget {}`,
  });
  const filePath = path.resolve("main.tsp");
  let revision = 0;
  await addCompilerEvidence({
    sourceIndex,
    baseWorktree: ".",
    currentWorktree: ".",
    projects: ["main.tsp"],
    loadCompiler: () => {
      const text = revision++ ? currentText : baseText;
      const file = {
        path: filePath,
        text,
        getLineAndCharacterOfPosition: (/** @type {number} */ position) => ({
          line: text.slice(0, position).split("\n").length - 1,
          character: 0,
        }),
      };
      const type = { kind: "Model", name: "Widget" };
      return {
        compilerVersion: "test",
        NodeHost: {},
        compile: () => ({
          diagnostics: [],
          sourceFiles: new Map([["main.tsp", { file }]]),
        }),
        navigateProgram: (_program, listeners) => listeners.model(type),
        getSourceLocation: () => {
          const pos = text.indexOf("model Widget");
          return { file, pos, end: pos + "model Widget {}".length };
        },
        getDoc: () => "A widget.",
      };
    },
  });

  const declaration = required(
    required(sourceIndex.sourceChanges[0]).declarations.find(
      (item) => item.source.revision === "current",
    ),
  );
  assert.deepEqual(declaration.decorators, ['@clientName("Widget")']);
  assert.equal(
    declaration.source.link,
    "https://github.com/contoso/widgets/blob/head/main.tsp#L2-L2",
  );
  assert.equal(required(declaration.compilerEvidence).kind, "semantic-type");
});
