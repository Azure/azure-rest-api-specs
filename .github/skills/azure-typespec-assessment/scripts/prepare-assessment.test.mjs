import assert from "node:assert/strict";
import test from "node:test";
import {
  prepareProjectRecords,
  typeSpecChangesForAnalysis,
} from "./prepare-assessment.mjs";

test("expands renamed TypeSpec evidence into analyzable paths", () => {
  assert.deepEqual(
    typeSpecChangesForAnalysis([
      {
        path: "specification/two/main.tsp",
        previousPath: "specification/one/main.tsp",
        status: "modified",
        origins: ["committed"],
      },
      {
        path: "specification/one/removed.txt",
        previousPath: "specification/one/removed.tsp",
        status: "removed",
        origins: ["committed"],
      },
      {
        path: "specification/two/promoted.tsp",
        previousPath: "specification/two/promoted.txt",
        status: "added",
        origins: ["committed"],
      },
    ]),
    [
      {
        path: "specification/one/main.tsp",
        previousPath: "specification/one/main.tsp",
        status: "removed",
        origins: ["committed"],
      },
      {
        path: "specification/one/removed.tsp",
        previousPath: "specification/one/removed.tsp",
        status: "removed",
        origins: ["committed"],
      },
      {
        path: "specification/two/main.tsp",
        previousPath: "specification/one/main.tsp",
        status: "added",
        origins: ["committed"],
      },
      {
        path: "specification/two/promoted.tsp",
        previousPath: "specification/two/promoted.txt",
        status: "added",
        origins: ["committed"],
      },
    ],
  );
});

test("compiler blockers remain scoped to their project", () => {
  const projects = ["specification/one", "specification/two"];
  const blockers = [];
  const compilerCalls = [];
  const comparison = {
    baseline: {
      sourceRevision: "base",
      commit: "base-sha",
      apiVersion: "2025-01-01",
      reason: "affected-existing-version",
    },
    target: {
      sourceRevision: "current",
      commit: "head-sha",
      apiVersion: "2025-01-01",
      reason: "affected-existing-version",
    },
    addedCurrentVersions: [],
    available: {
      base: ["2025-01-01"],
      current: ["2025-01-01"],
    },
  };

  const records = prepareProjectRecords({
    projects,
    sourceIndex: {
      sourceChanges: projects.map((project, index) => ({
        id: `source-${index}`,
        path: `${project}/main.tsp`,
      })),
    },
    blockers,
    baseWorktree: "base",
    currentWorktree: "current",
    baseCommit: "base-sha",
    headCommit: "head-sha",
    workRoot: "work",
    resolveApiVersions: () => comparison,
    runCompilers: ({ project, comparisonRole }) => {
      compilerCalls.push([project, comparisonRole]);
      const status =
        project === "specification/one" && comparisonRole === "baseline"
          ? "failed"
          : "succeeded";
      return { autorest: { status }, tcgc: { status: "succeeded" } };
    },
  });

  assert.deepEqual(compilerCalls, [
    ["specification/one", "baseline"],
    ["specification/one", "target"],
    ["specification/two", "baseline"],
    ["specification/two", "target"],
  ]);
  assert.equal(records[0].blockers.length, 1);
  assert.equal(records[1].blockers.length, 0);
  assert.equal(blockers.length, 1);
  assert.equal(blockers[0].projectId, records[0].id);
});
