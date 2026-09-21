import assert from "node:assert/strict";
import path from "node:path";
import test from "node:test";
import { addCompilerEvidence, buildSourceIndex, parseUnifiedHunks } from "./source-index.mjs";

test("parseUnifiedHunks retains base and current ranges", () => {
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
  assert.deepEqual(hunks[0].base, { startLine: 2, endLine: 3 });
  assert.deepEqual(hunks[0].current, { startLine: 2, endLine: 4 });
  assert.match(hunks[0].id, /^hunk-/);
});

test("indexes changed interface operation members", () => {
  const files = {
    base: "interface Widgets {\n  get is ArmResourceRead<Widget>;\n}\n",
    working: "interface Widgets {\n  get is ArmResourceRead<Widget>;\n  cancel is ArmResourceActionAsync<Widget>;\n}\n",
  };
  const index = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{
      path: "specification/widgets/main.tsp",
      status: "modified",
      origins: ["committed"],
    }],
    remoteUrl: "",
    readFile: (revision) => files[revision] ?? files.working,
    diffFile: () => `@@ -1,3 +1,4 @@
 interface Widgets {
   get is ArmResourceRead<Widget>;
+  cancel is ArmResourceActionAsync<Widget>;
 }`,
  });
  assert.ok(index.sourceChanges[0].declarations.some(
    (item) => item.kind === "operation" && item.qualifiedName === "Widgets.cancel",
  ));
});

test("does not classify inline operation response fields as interface properties", () => {
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
    changedFiles: [{
      path: "specification/widgets/main.tsp",
      status: "modified",
      origins: ["committed"],
    }],
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

  assert.ok(!index.sourceChanges[0].declarations.some(
    (item) => item.kind === "property" && item.qualifiedName === "Widgets.location",
  ));
});

test("raw revision sources are not serialized and unavailable compilers block documentation presence", async () => {
  const sourceIndex = buildSourceIndex({
    repo: "repo", mergeBase: "base", headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified", origins: ["working"] }],
    readFile: () => '@doc("private raw marker") model Widget {}',
    diffFile: () => "@@ -1 +1 @@\n-model Widget {}\n+model Widget { x: string; }",
  });
  assert.ok(!JSON.stringify(sourceIndex).includes("private raw marker"));
  await addCompilerEvidence({
    sourceIndex, baseWorktree: ".", currentWorktree: ".", projects: ["main.tsp"],
    loadCompiler: async () => { throw new Error("Compiler missing"); },
  });
  assert.equal(sourceIndex.analysis.status, "blocked");
  assert.equal(sourceIndex.sourceChanges[0].documentEvidence.status, "blocked");
  assert.equal(sourceIndex.sourceChanges[0].documentEvidence.schemaVersion, 4);
  assert.equal(sourceIndex.sourceChanges[0].documentEvidence.blockers.length, 1);
  assert.deepEqual(sourceIndex.sourceChanges[0].documentEvidence.declarations, []);
});

test("failed compiler programs never report @doc evidence ready", async () => {
  const sourceIndex = buildSourceIndex({
    repo: "repo", mergeBase: "base", headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified" }],
    readFile: () => '@doc("A model") model Widget {}',
    diffFile: () => "@@ -1 +1 @@\n-model Widget {}\n+model Widget { x: string; }",
  });
  await addCompilerEvidence({
    sourceIndex, baseWorktree: ".", currentWorktree: ".", projects: ["main.tsp"],
    loadCompiler: async () => ({
      NodeHost: {},
      compile: async () => ({ diagnostics: [{ severity: "error" }] }),
    }),
  });
  assert.equal(sourceIndex.analysis.status, "blocked");
  assert.equal(sourceIndex.sourceChanges[0].documentEvidence.status, "blocked");
});

test("compiler evidence records only documentation presence on changed declarations", async () => {
  const sourceText = "model Widget { value: string; }";
  const sourceIndex = buildSourceIndex({
    repo: "repo", mergeBase: "base", headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified" }],
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
    loadCompiler: async () => {
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
        compile: async () => ({
          diagnostics: [],
          sourceFiles: new Map([["main.tsp", { file }]]),
        }),
        navigateProgram: (_program, listeners) => listeners.model(type),
        getSourceLocation: () => ({ file, pos: 0, end: sourceText.length }),
        getDoc: () => documentation,
      };
    },
  });
  const source = sourceIndex.sourceChanges[0];
  assert.equal(source.documentEvidence.schemaVersion, 4);
  assert.equal(source.documentEvidence.status, "ready");
  assert.deepEqual(source.documentEvidence.declarations.map((item) => ({
    qualifiedName: item.qualifiedName,
    documentationPresent: item.documentationPresent,
  })), [{ qualifiedName: "Widget", documentationPresent: true }]);
  assert.equal(JSON.stringify(source.documentEvidence).includes("A widget."), false);
  assert.deepEqual(
    source.declarations.find((item) => item.source.revision === "current").sourceSnippet,
    {
      startLine: 1,
      endLine: 1,
      lines: ["model Widget { value: string; }"],
      truncated: false,
    },
  );
});

test("compiler evidence excludes unchanged declarations that are only diff context", async () => {
  const baseText = "interface Unchanged {}\ninterface Changed {}\n";
  const currentText =
    "interface Unchanged {}\ninterface Changed {\n  added(): void;\n}\n";
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified" }],
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
    loadCompiler: async () => {
      const text = revision++ ? currentText : baseText;
      const file = {
        path: filePath,
        text,
        getLineAndCharacterOfPosition: (position) => ({
          line: text.slice(0, position).split("\n").length - 1,
          character: 0,
        }),
      };
      const unchanged = { kind: "Interface", name: "Unchanged" };
      const changed = { kind: "Interface", name: "Changed" };
      return {
        compilerVersion: "test",
        NodeHost: {},
        compile: async () => ({
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
    sourceIndex.sourceChanges[0].documentEvidence.declarations.map(
      (item) => item.qualifiedName,
    ),
    ["Changed"],
  );
});

test("compiler evidence includes a declaration when only its documentation prefix changes", async () => {
  const baseText = "model Widget {}\n";
  const currentText = "/** A widget. */\nmodel Widget {}\n";
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified" }],
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
    loadCompiler: async () => {
      const current = revision++ === 1;
      const text = current ? currentText : baseText;
      const file = {
        path: filePath,
        text,
        getLineAndCharacterOfPosition: (position) => ({
          line: text.slice(0, position).split("\n").length - 1,
          character: 0,
        }),
      };
      const type = { kind: "Model", name: "Widget" };
      return {
        compilerVersion: "test",
        NodeHost: {},
        compile: async () => ({
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
    sourceIndex.sourceChanges[0].documentEvidence.declarations.map((item) => ({
      qualifiedName: item.qualifiedName,
      documentationPresent: item.documentationPresent,
    })),
    [{ qualifiedName: "Widget", documentationPresent: true }],
  );
});

test("compiler evidence preserves parsed decorators and source links", async () => {
  const baseText = '@clientName("OldWidget")\nmodel Widget {}\n';
  const currentText = '@clientName("Widget")\nmodel Widget {}\n';
  const sourceIndex = buildSourceIndex({
    repo: "repo",
    mergeBase: "base",
    headCommit: "head",
    changedFiles: [{ path: "main.tsp", status: "modified" }],
    remoteUrl: "https://github.com/contoso/widgets.git",
    readFile: (revision) => revision === "base" ? baseText : currentText,
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
    loadCompiler: async () => {
      const text = revision++ ? currentText : baseText;
      const file = {
        path: filePath,
        text,
        getLineAndCharacterOfPosition: (position) => ({
          line: text.slice(0, position).split("\n").length - 1,
          character: 0,
        }),
      };
      const type = { kind: "Model", name: "Widget" };
      return {
        compilerVersion: "test",
        NodeHost: {},
        compile: async () => ({
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

  const declaration = sourceIndex.sourceChanges[0].declarations.find(
    (item) => item.source.revision === "current",
  );
  assert.deepEqual(declaration.decorators, ['@clientName("Widget")']);
  assert.equal(
    declaration.source.link,
    "https://github.com/contoso/widgets/blob/head/main.tsp#L2-L2",
  );
  assert.equal(declaration.compilerEvidence.kind, "semantic-type");
});
