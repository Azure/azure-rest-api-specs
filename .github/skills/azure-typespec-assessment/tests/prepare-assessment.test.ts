import { assert, test } from "vitest";
import { selectApiVersionPair } from "../scripts/api-version-selection.ts";
import type { runProjectCompilers } from "../scripts/compiler-runner.ts";
import {
  prepareProjectRecords,
  typeSpecChangesForAnalysis,
} from "../scripts/prepare-assessment.ts";

type PreparationBlocker = import("../scripts/runtime-types.ts").PreparationBlocker;

type SourceIndex = import("../scripts/runtime-types.ts").SourceIndex;

void test.each([true, false])(
  "both emitters receive the selected previous-preview revision, without retry on failure (retained: %s)",
  (retained) => {
    const calls: Parameters<typeof runProjectCompilers>[0][] = [];
    const blockers: PreparationBlocker[] = [];
    const records = prepareProjectRecords({
      projects: ["specification/preview/Service"],
      sourceIndex: { sourceChanges: [] } as unknown as SourceIndex,
      blockers,
      baseWorktree: "historical-base-worktree",
      currentWorktree: "head-worktree",
      baseCommit: "historical-base-sha",
      headCommit: "head-sha",
      workRoot: "work",
      resolveApiVersions: ({ baseCommit, headCommit }) =>
        selectApiVersionPair({
          base: {
            versioned: true,
            versions: ["2026-01-01-preview", "2026-05-01-preview"],
          },
          current: {
            versioned: true,
            versions: [
              "2026-01-01-preview",
              ...(retained ? ["2026-05-01-preview"] : []),
              "2026-08-01-preview",
            ],
          },
          baseCommit,
          headCommit,
        }),
      runCompilers: (options) => {
        calls.push(options);
        const { comparisonRole, sourceRevision, sourceCommit, apiVersion } = options;
        const metadata = {
          comparisonRole,
          sourceRevision,
          sourceCommit,
          selectedApiVersion: apiVersion,
          command: { executable: "fixture", args: [] },
          exitCode: 0,
          durationMs: 0,
          configPath: "fixture-config",
          configHash: "fixture-hash",
          logPath: "fixture-log",
          files: [],
        };
        return {
          comparisonRole,
          sourceRevision,
          sourceCommit,
          apiVersion,
          autorest: {
            ...metadata,
            status: comparisonRole === "baseline" ? "failed" : "succeeded",
            format: "swagger-2.0",
            serviceManifestPath: "",
          },
          tcgc: {
            ...metadata,
            status: "succeeded",
            format: "tcgc-yaml",
            provenanceFile: { path: "fixture-provenance.json", contentHash: "fixture-hash" },
          },
        };
      },
    });
    assert.deepEqual(
      calls.map(({ worktree, comparisonRole, sourceRevision, sourceCommit, apiVersion }) => ({
        worktree,
        comparisonRole,
        sourceRevision,
        sourceCommit,
        apiVersion,
      })),
      [
        {
          worktree: retained ? "head-worktree" : "historical-base-worktree",
          comparisonRole: "baseline",
          sourceRevision: retained ? "current" : "base",
          sourceCommit: retained ? "head-sha" : "historical-base-sha",
          apiVersion: "2026-05-01-preview",
        },
        {
          worktree: "head-worktree",
          comparisonRole: "target",
          sourceRevision: "current",
          sourceCommit: "head-sha",
          apiVersion: "2026-08-01-preview",
        },
      ],
    );
    for (const role of ["baseline", "target"] as const) {
      for (const emitter of ["autorest", "tcgc"] as const) {
        const artifact = records[0].artifacts[role]?.[emitter];
        assert.equal(artifact?.sourceCommit, records[0].artifactComparison?.[role].commit);
        assert.equal(
          artifact?.selectedApiVersion,
          records[0].artifactComparison?.[role].apiVersion,
        );
      }
    }
    assert.equal(records[0].classification, "existing");
    assert.deepEqual(
      blockers.map(({ code, comparisonRole }) => [code, comparisonRole]),
      [["autorest-compile-failed", "baseline"]],
    );
  },
);

void test("discovery failure blocks compilation instead of using target-only artifacts", () => {
  const blockers: PreparationBlocker[] = [];
  const records = prepareProjectRecords({
    projects: ["specification/preview/Service"],
    sourceIndex: { sourceChanges: [] } as unknown as SourceIndex,
    blockers,
    baseWorktree: "base",
    currentWorktree: "head",
    baseCommit: "base-sha",
    headCommit: "head-sha",
    workRoot: "work",
    resolveApiVersions: () => {
      throw new Error("Unresolved service version enum.");
    },
    runCompilers: () => {
      throw new Error("Compilation must not run.");
    },
  });
  assert.equal(records[0].artifactComparison, undefined);
  assert.deepEqual(records[0].artifacts, {});
  assert.deepEqual(
    blockers.map(({ code }) => code),
    ["api-version-resolution-failed"],
  );
});

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
    resolveNewApiVersions: () => ({
      mode: "new-project",
      baseline: {
        sourceRevision: "absent",
        reason: "No pre-existing contract exists because the project is absent from the baseline.",
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
    }),
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
    resolveApiVersions: () => ({
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
    }),
    resolveNewApiVersions: () => ({
      mode: "new-project",
      baseline: {
        sourceRevision: "absent",
        reason: "No pre-existing contract exists because the project is absent from the baseline.",
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
    }),
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
