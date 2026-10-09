import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { resolveProjectApiVersions } from "./api-version-selection.ts";
import { isMain, parseArgs, runMain, writeJson } from "./cli.ts";
import { runProjectCompilers } from "./compiler-runner.ts";
import {
  collectChanges,
  createSparseWorktree,
  discoverProjects,
  normalizeSparseRoots,
  normalizeSpecification,
  resolveComparison,
} from "./git-evidence.ts";
import { ensureDependencies } from "./package-manager.ts";
import { addCompilerEvidence, buildSourceIndex } from "./source-index.ts";

type ChangedFile = import("./runtime-types.ts").ChangedFile;

type PreparationBlocker = import("./runtime-types.ts").PreparationBlocker;

type PreparationManifest = import("./runtime-types.ts").PreparationManifest;

type PreparationProject = import("./runtime-types.ts").PreparationProject;

type SourceIndex = import("./runtime-types.ts").SourceIndex;

function stableProjectId(project: string) {
  return `project-${crypto.createHash("sha256").update(project).digest("hex").slice(0, 12)}`;
}

function isTypeSpecPath(file: string | undefined) {
  return file?.endsWith(".tsp") || path.basename(file ?? "") === "tspconfig.yaml";
}

function changeTouchesRoot(change: ChangedFile, root: string) {
  return [change.path, change.previousPath].some(
    (file) => file === root || file?.startsWith(`${root}/`),
  );
}

export function typeSpecChangesForAnalysis(changes: ChangedFile[]): ChangedFile[] {
  return changes
    .flatMap((change): ChangedFile[] => {
      if (!change.previousPath || change.previousPath === change.path) return [change];
      const previousRelevant = isTypeSpecPath(change.previousPath);
      const currentRelevant = isTypeSpecPath(change.path);
      return [
        ...(previousRelevant && change.status !== "added"
          ? [
              {
                ...change,
                path: change.previousPath,
                status: "removed" as const,
              },
            ]
          : []),
        ...(currentRelevant ? [{ ...change, status: "added" as const }] : []),
      ];
    })
    .sort((left, right) => left.path.localeCompare(right.path));
}

export function prepareProjectRecords({
  projects,
  sourceIndex,
  blockers,
  baseWorktree,
  currentWorktree,
  baseCommit,
  headCommit,
  workRoot,
  enabled = true,
  resolveApiVersions = resolveProjectApiVersions,
  runCompilers = runProjectCompilers,
}: {
  projects: string[];
  sourceIndex: SourceIndex;
  blockers: PreparationBlocker[];
  baseWorktree: string;
  currentWorktree: string;
  baseCommit: string;
  headCommit: string;
  workRoot: string;
  enabled?: boolean;
  resolveApiVersions?: typeof resolveProjectApiVersions;
  runCompilers?: typeof runProjectCompilers;
}): PreparationProject[] {
  const records: PreparationProject[] = [];
  for (const project of projects) {
    const projectId = stableProjectId(project);
    const projectSourceIds = sourceIndex.sourceChanges
      .filter(
        (change) =>
          change.path.startsWith(`${project}/`) ||
          change.path === project ||
          !projects.some(
            (candidate) => change.path.startsWith(`${candidate}/`) || change.path === candidate,
          ),
      )
      .map((change) => change.id);

    const projectBlockers: PreparationBlocker[] = [];

    const addBlocker = (blocker: PreparationBlocker) => {
      projectBlockers.push(blocker);
      blockers.push(blocker);
    };

    const record: PreparationProject = {
      id: projectId,
      path: project,
      sourceChangeIds: projectSourceIds,
      artifacts: {},
      blockers: projectBlockers,
    };
    if (enabled) {
      try {
        record.artifactComparison = resolveApiVersions({
          baseWorktree,
          currentWorktree,
          project,
          baseCommit,
          headCommit,
        });
        record.apiVersions = {
          base: record.artifactComparison.baseline.apiVersion,
          current: record.artifactComparison.target.apiVersion,
          baseReason: record.artifactComparison.baseline.reason,
          currentReason: record.artifactComparison.target.reason,
          addedCurrentVersions: record.artifactComparison.addedCurrentVersions,
          available: record.artifactComparison.available,
        };
      } catch (error) {
        addBlocker({
          code: "api-version-resolution-failed",
          projectId,
          message: error instanceof Error ? error.message : String(error),
        });
      }
    }
    if (enabled && !projectBlockers.length) {
      for (const comparisonRole of ["baseline", "target"] as const) {
        const selection = record.artifactComparison?.[comparisonRole];
        if (!selection) throw new Error(`Missing ${comparisonRole} artifact selection.`);
        if (!selection.commit) {
          throw new Error(`Missing ${comparisonRole} source commit.`);
        }
        const worktree = selection.sourceRevision === "base" ? baseWorktree : currentWorktree;
        try {
          record.artifacts[comparisonRole] = runCompilers({
            worktree,
            project,
            projectId,
            comparisonRole,
            sourceRevision: selection.sourceRevision,
            sourceCommit: selection.commit,
            workRoot,
            apiVersion: selection.apiVersion,
          });
          for (const emitter of ["autorest", "tcgc"] as const) {
            if (record.artifacts[comparisonRole][emitter].status === "failed") {
              addBlocker({
                code: `${emitter}-compile-failed`,
                projectId,
                comparisonRole,
                sourceRevision: selection.sourceRevision,
                message: `${emitter} compilation failed for ${project} (${comparisonRole}: ${selection.sourceRevision}@${selection.apiVersion ?? "unversioned"}).`,
              });
            }
          }
        } catch (error) {
          addBlocker({
            code: "compiler-runner-failed",
            projectId,
            comparisonRole,
            sourceRevision: selection.sourceRevision,
            message: error instanceof Error ? error.message : String(error),
          });
        }
      }
    }
    records.push(record);
  }
  return records;
}

function copyOverlay(repo: string, currentWorktree: string, changedFiles: ChangedFile[]) {
  for (const file of changedFiles) {
    const source = path.join(repo, file.path);
    const target = path.join(currentWorktree, file.path);
    if (fs.existsSync(source)) {
      fs.mkdirSync(path.dirname(target), { recursive: true });
      fs.copyFileSync(source, target);
    } else if (fs.existsSync(target)) {
      fs.rmSync(target);
    }
  }
}

function findExternalLocalImports(repo: string, projects: string[], sparseRoots: string[]) {
  const serviceBoundaries = sparseRoots.map((root) => path.resolve(repo, root));

  const failures: {
    file: string;
    import: string;
  }[] = [];

  const visit = (directory: string) => {
    if (!fs.existsSync(directory)) return;
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
      const file = path.join(directory, entry.name);
      if (entry.isDirectory()) visit(file);
      else if (entry.name.endsWith(".tsp")) {
        const content = fs.readFileSync(file, "utf8");
        for (const match of content.matchAll(/\bimport\s+["']([^"']+)["']/g)) {
          if (!match[1].startsWith(".")) continue;
          const resolved = path.resolve(path.dirname(file), match[1]);
          const insideSparseRoots = serviceBoundaries.some(
            (boundary) => resolved === boundary || resolved.startsWith(`${boundary}${path.sep}`),
          );
          if (!insideSparseRoots) {
            failures.push({
              file: path.relative(repo, file).replaceAll("\\", "/"),
              import: match[1],
            });
          }
        }
      }
    }
  };
  for (const project of projects) visit(path.join(repo, project));
  return failures;
}

export async function prepareAssessment({
  repo,
  base,
  head,
  mergeBaseCommit,
  includeWorkingTree = head === undefined,
  specification,
  output,
  sparse_root,
  sparseRoots: requestedSparseRoots,
  pullRequest,
  invocation,
}: {
  repo?: string;
  base?: string;
  head?: string;
  mergeBaseCommit?: string;
  includeWorkingTree?: boolean;
  specification?: string;
  output: string;
  sparse_root?: string | string[];
  sparseRoots?: string | string[];
  pullRequest?: unknown;
  invocation?: {
    timings?: Record<string, number>;
    [key: string]: unknown;
  };
}): Promise<PreparationManifest> {
  const started = performance.now();
  const repository = path.resolve(repo ?? process.cwd());
  if (!specification) {
    throw new Error("--specification is required when no TypeSpec scope can be derived.");
  }
  const scope = normalizeSpecification(repository, specification);
  const work = path.resolve(output);
  fs.mkdirSync(work, { recursive: true });
  const comparisonStarted = performance.now();
  const comparison = resolveComparison(
    repository,
    base ?? "origin/main",
    head ?? "HEAD",
    mergeBaseCommit,
  );
  const comparisonMs = Math.round(performance.now() - comparisonStarted);
  const rawSparseRoots = requestedSparseRoots ?? sparse_root;
  const sparseRoots = normalizeSparseRoots(
    typeof rawSparseRoots === "string" ? [rawSparseRoots] : rawSparseRoots,
    scope,
  );
  const changeDiscoveryStarted = performance.now();
  const changedFiles = collectChanges(repository, comparison.mergeBaseCommit, sparseRoots, {
    headRef: comparison.headCommit,
    includeWorkingTree,
  }).filter((file) => sparseRoots.some((root) => changeTouchesRoot(file, root)));
  const changeDiscoveryMs = Math.round(performance.now() - changeDiscoveryStarted);

  const blockers: PreparationBlocker[] = [];

  const manifest: PreparationManifest = {
    schemaVersion: 1,
    repository: { root: repository, remoteUrl: comparison.remoteUrl },
    ...(pullRequest ? { pullRequest } : {}),
    ...(invocation ? { invocation } : {}),
    comparison: {
      baseRef: comparison.baseRef,
      headRef: comparison.headRef,
      mergeBaseCommit: comparison.mergeBaseCommit,
      headCommit: comparison.headCommit,
      workingTree: {
        staged: changedFiles.some((file) => file.origins.includes("staged")),
        unstaged: changedFiles.some((file) => file.origins.includes("unstaged")),
        untracked: changedFiles.some((file) => file.origins.includes("untracked")),
      },
    },
    sparseCheckout: { mode: "cone", roots: sparseRoots, verified: false },
    changedFiles,
    projects: [],
    blockers,
    timings: {
      ...(invocation?.timings ?? {}),
      comparisonMs,
      changeDiscoveryMs,
    },
  };
  manifest.timings.setupExcludingFetchMs =
    (manifest.timings.setupExcludingFetchMs ?? 0) + comparisonMs + changeDiscoveryMs;
  if (!changedFiles.length) {
    manifest.status = "no-changes";
    manifest.timings.totalMs = Math.round(performance.now() - started);
    writeJson(path.join(work, "preparation-manifest.json"), manifest);
    return manifest;
  }
  const analysisFiles = typeSpecChangesForAnalysis(changedFiles);

  const sourceIndex = buildSourceIndex({
    repo: repository,
    mergeBase: comparison.mergeBaseCommit,
    headCommit: comparison.headCommit,
    changedFiles: analysisFiles,
    remoteUrl: comparison.remoteUrl,
    currentRevision: includeWorkingTree ? "working" : comparison.headCommit,
  });
  writeJson(path.join(work, "source", "changed-files.json"), analysisFiles);
  writeJson(path.join(work, "source", "source-index.json"), sourceIndex);
  writeJson(
    path.join(work, "source", "typespec-diff.json"),
    sourceIndex.sourceChanges.map(({ id, path: file, hunks }) => ({ id, path: file, hunks })),
  );

  const baseWorktree = path.join(work, "worktrees", "base");
  const currentWorktree = path.join(work, "worktrees", "current");
  const workspaceStarted = performance.now();
  try {
    createSparseWorktree(repository, comparison.mergeBaseCommit, sparseRoots, baseWorktree);
    createSparseWorktree(repository, comparison.headCommit, sparseRoots, currentWorktree);
    manifest.sparseCheckout.verified = true;
    if (includeWorkingTree) {
      copyOverlay(repository, currentWorktree, analysisFiles);
    }
  } catch (error) {
    blockers.push({
      code: "workspace-preparation-failed",
      message: error instanceof Error ? error.message : String(error),
    });
  }
  manifest.timings.workspacePreparationMs = Math.round(performance.now() - workspaceStarted);

  const projectDiscoveryStarted = performance.now();
  const discoveredProjects = [
    ...new Set(
      sparseRoots.flatMap((root) =>
        discoverProjects(
          currentWorktree,
          analysisFiles.filter((file) => file.path === root || file.path.startsWith(`${root}/`)),
          root,
        ),
      ),
    ),
  ].sort();
  const projects = discoveredProjects.filter(
    (project) =>
      !discoveredProjects.some(
        (candidate) => candidate !== project && candidate.startsWith(`${project}/`),
      ),
  );
  if (!projects.length) {
    blockers.push({
      code: "project-not-found",
      message: `No affected tspconfig.yaml was found under ${scope}.`,
    });
  }
  const externalImports = findExternalLocalImports(currentWorktree, projects, sparseRoots);
  if (externalImports.length) {
    blockers.push({
      code: "unsupported-import-outside-service",
      message: `Local imports leave ${sparseRoots.join(", ")}: ${externalImports
        .map((item) => `${item.file} -> ${item.import}`)
        .join(", ")}`,
    });
  }
  manifest.timings.projectDiscoveryMs = Math.round(performance.now() - projectDiscoveryStarted);
  manifest.timings.setupExcludingFetchMs =
    (manifest.timings.setupExcludingFetchMs ?? 0) +
    manifest.timings.workspacePreparationMs +
    manifest.timings.projectDiscoveryMs;
  try {
    if (!blockers.length) {
      manifest.dependencySetup = {
        baseline: ensureDependencies({
          worktree: baseWorktree,
          work,
          reuseRoot: repository,
        }),
        target: ensureDependencies({
          worktree: currentWorktree,
          work,
          reuseRoot: repository,
        }),
      };
    }
  } catch (error) {
    blockers.push({
      code: "dependency-setup-failed",
      message: error instanceof Error ? error.message : String(error),
    });
  }
  if (!blockers.length && projects.length) {
    await addCompilerEvidence({
      sourceIndex,
      baseWorktree,
      currentWorktree,
      projects,
    });
    writeJson(path.join(work, "source", "source-index.json"), sourceIndex);
  }
  manifest.projects.push(
    ...prepareProjectRecords({
      projects,
      sourceIndex,
      blockers,
      baseWorktree,
      currentWorktree,
      baseCommit: comparison.mergeBaseCommit,
      headCommit: comparison.headCommit,
      workRoot: work,
      enabled: !blockers.length,
    }),
  );
  manifest.status = blockers.length ? "blocked" : "ready";
  manifest.timings.totalMs = Math.round(performance.now() - started);
  writeJson(path.join(work, "preparation-manifest.json"), manifest);
  return manifest;
}

if (isMain(import.meta.url)) {
  void runMain(async () => {
    const args = parseArgs(process.argv.slice(2), {
      required: ["specification", "output"],
      defaults: { repo: process.cwd(), base: "origin/main" },
      arrays: ["sparse-root"],
    });
    const specification = args.specification;
    const output = args.output;
    if (typeof specification !== "string" || typeof output !== "string") {
      throw new Error("--specification and --output must be paths.");
    }
    const options = { ...args, specification, output } as unknown as Parameters<
      typeof prepareAssessment
    >[0];
    const result = await prepareAssessment(options);
    console.log(path.join(path.resolve(output), "preparation-manifest.json"));
    if (result.status === "blocked") process.exitCode = 1;
  });
}
