import { assert, test } from "vitest";
import {
  prepareProjectRecords,
  typeSpecChangesForAnalysis,
} from "../scripts/prepare-assessment.ts";

type PreparationBlocker = import("../scripts/runtime-types.ts").PreparationBlocker;

type SourceIndex = import("../scripts/runtime-types.ts").SourceIndex;

void test("expands renamed TypeSpec evidence into analyzable paths", () => {
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

void test("compiler blockers remain scoped to their project", () => {
  const projects = ["specification/one", "specification/two"];

  const blockers: PreparationBlocker[] = [];

  const compilerCalls: string[][] = [];
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
  } as unknown as ReturnType<
    NonNullable<Parameters<typeof prepareProjectRecords>[0]["resolveApiVersions"]>
  >;

  const records = prepareProjectRecords({
    projects,
    sourceIndex: {
      sourceChanges: projects.map((project, index) => ({
        id: `source-${index}`,
        path: `${project}/main.tsp`,
      })),
    } as unknown as SourceIndex,
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
        project === "specification/one" && comparisonRole === "baseline" ? "failed" : "succeeded";
      return {
        autorest: { status },
        tcgc: { status: "succeeded" },
      } as unknown as ReturnType<
        NonNullable<Parameters<typeof prepareProjectRecords>[0]["runCompilers"]>
      >;
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

void test("new projects resolve and compile only the target", () => {
  const blockers: PreparationBlocker[] = [];
  const compilerCalls: string[] = [];
  const records = prepareProjectRecords({
    projects: ["specification/new/Widget"],
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-new",
          path: "specification/new/Widget/main.tsp",
        },
      ],
    } as unknown as SourceIndex,
    blockers,
    baseWorktree: "base",
    currentWorktree: "current",
    baseCommit: "base-sha",
    headCommit: "head-sha",
    workRoot: "work",
    projectClassifications: { "specification/new/Widget": "new" },
    resolveApiVersions: () => {
      throw new Error("existing-project resolver must not run");
    },
    resolveNewApiVersions: () =>
      ({
        mode: "new-project",
        baseline: {
          sourceRevision: "absent",
          reason:
            "No pre-existing contract exists because the project is absent from the baseline.",
        },
        target: {
          sourceRevision: "current",
          commit: "head-sha",
          apiVersion: "2026-01-01",
          reason: "latest-version",
        },
        base: undefined,
        current: "2026-01-01",
        baseReason: "project-absent-from-baseline",
        currentReason: "latest-version",
        addedCurrentVersions: ["2026-01-01"],
        available: { base: [], current: ["2026-01-01"] },
      }) as ReturnType<
        NonNullable<Parameters<typeof prepareProjectRecords>[0]["resolveNewApiVersions"]>
      >,
    runCompilers: ({ comparisonRole }) => {
      compilerCalls.push(comparisonRole);
      return {
        autorest: { status: "succeeded" },
        tcgc: { status: "succeeded" },
      } as unknown as ReturnType<
        NonNullable<Parameters<typeof prepareProjectRecords>[0]["runCompilers"]>
      >;
    },
  });

  assert.deepEqual(compilerCalls, ["target"]);
  assert.equal(records[0].classification, "new");
  assert.equal(records[0].artifactComparison?.mode, "new-project");
  assert.deepEqual(records[0].artifacts.baseline, undefined);
  assert.equal(blockers.length, 0);
});

void test("mixed changes compare existing projects and classify only target-only projects", () => {
  const projects = ["specification/existing/Widget", "specification/new/Gadget"];
  const compilerCalls: string[] = [];
  const records = prepareProjectRecords({
    projects,
    sourceIndex: {
      sourceChanges: projects.map((project, index) => ({
        id: `source-${index}`,
        path: `${project}/main.tsp`,
      })),
    } as unknown as SourceIndex,
    blockers: [],
    baseWorktree: "base",
    currentWorktree: "current",
    baseCommit: "base-sha",
    headCommit: "head-sha",
    workRoot: "work",
    projectClassifications: {
      "specification/existing/Widget": "existing",
      "specification/new/Gadget": "new",
    },
    resolveApiVersions: () =>
      ({
        mode: "existing-api-version",
        baseline: {
          sourceRevision: "base",
          commit: "base-sha",
          apiVersion: undefined,
          reason: "affected-existing-version",
        },
        target: {
          sourceRevision: "current",
          commit: "head-sha",
          apiVersion: undefined,
          reason: "affected-existing-version",
        },
        base: undefined,
        current: undefined,
        baseReason: "affected-existing-version",
        currentReason: "unversioned",
        addedCurrentVersions: [],
        available: { base: [], current: [] },
      }) as ReturnType<
        NonNullable<Parameters<typeof prepareProjectRecords>[0]["resolveApiVersions"]>
      >,
    resolveNewApiVersions: () =>
      ({
        mode: "new-project",
        baseline: {
          sourceRevision: "absent",
          reason:
            "No pre-existing contract exists because the project is absent from the baseline.",
        },
        target: {
          sourceRevision: "current",
          commit: "head-sha",
          apiVersion: undefined,
          reason: "unversioned",
        },
        base: undefined,
        current: undefined,
        baseReason: "project-absent-from-baseline",
        currentReason: "unversioned",
        addedCurrentVersions: [],
        available: { base: [], current: [] },
      }) as ReturnType<
        NonNullable<Parameters<typeof prepareProjectRecords>[0]["resolveNewApiVersions"]>
      >,
    runCompilers: ({ project, comparisonRole }) => {
      compilerCalls.push(`${project}:${comparisonRole}`);
      return {
        autorest: { status: "succeeded" },
        tcgc: { status: "succeeded" },
      } as unknown as ReturnType<
        NonNullable<Parameters<typeof prepareProjectRecords>[0]["runCompilers"]>
      >;
    },
  });

  assert.deepEqual(compilerCalls, [
    "specification/existing/Widget:baseline",
    "specification/existing/Widget:target",
    "specification/new/Gadget:target",
  ]);
  assert.deepEqual(
    records.map(({ classification, artifactComparison }) => [
      classification,
      artifactComparison?.mode,
    ]),
    [
      ["existing", "existing-api-version"],
      ["new", "new-project"],
    ],
  );
});
