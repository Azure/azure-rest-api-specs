import { readdir, readFile } from "node:fs/promises";
import path from "node:path";
import { simpleGit } from "simple-git";
import {
  extractInlineSuppressions,
  extractTspconfigSuppressions,
  isTypeSpecConfigFile,
  isTypeSpecSourceFile,
} from "./extract.ts";
import { normalizeRepoPath, toRepoRelativePath } from "./path-utils.ts";
import { enrichSuppressionChanges, enrichSuppressionRecords } from "./rule-metadata.ts";
import type {
  AnalyzeSuppressionsDirectoriesOptions,
  AnalyzeSuppressionsOptions,
  CheckedSuppressions,
  SpecSuppressionReport,
  SuppressionChange,
  SuppressionRecord,
  SuppressionReport,
} from "./types.ts";

function suppressionIdentityKey(suppression: SuppressionRecord): string {
  return [
    suppression.specPath,
    suppression.sourceKind,
    suppression.ruleName,
    suppression.anchorPath,
  ].join("|");
}

function compareSuppressions(left: SuppressionRecord, right: SuppressionRecord): number {
  return (
    left.specPath.localeCompare(right.specPath) ||
    left.sourceKind.localeCompare(right.sourceKind) ||
    left.ruleName.localeCompare(right.ruleName) ||
    left.anchorPath.localeCompare(right.anchorPath) ||
    left.sourceFile.localeCompare(right.sourceFile) ||
    left.location.line - right.location.line ||
    left.location.column - right.location.column
  );
}

function compareChanges(left: SuppressionChange, right: SuppressionChange): number {
  return compareSuppressions(left.after, right.after);
}

/**
 * Normalizes a list of check rules while preserving the distinction between
 * `undefined` (no `--check-rules-file` provided, i.e. legacy mode) and `[]`
 * (file provided but resolving to zero rules, i.e. checked-only mode with no
 * rules). The empty array must NOT be collapsed to `undefined`.
 */
function normalizeCheckRules(checkRules?: string[]): string[] | undefined {
  if (checkRules === undefined) {
    return undefined;
  }

  return Array.from(
    new Set(checkRules.map((rule) => rule.trim()).filter((rule) => rule.length > 0)),
  ).sort((left, right) => left.localeCompare(right));
}

/**
 * Builds the checked-only view of a suppression diff by filtering to exact
 * full rule-name matches. Returns `undefined` in legacy mode (checkRules
 * `undefined`); otherwise always returns a block, even when empty.
 */
function buildCheckedSuppressions(
  checkRules: string[] | undefined,
  newSuppressions: SuppressionRecord[],
  removedSuppressions: SuppressionRecord[],
  changedSuppressions: SuppressionChange[],
): CheckedSuppressions | undefined {
  if (checkRules === undefined) {
    return undefined;
  }

  const ruleSet = new Set(checkRules);
  const checkedNew = newSuppressions.filter((suppression) => ruleSet.has(suppression.ruleName));
  const checkedRemoved = removedSuppressions.filter((suppression) =>
    ruleSet.has(suppression.ruleName),
  );
  const checkedChanged = changedSuppressions.filter((change) => ruleSet.has(change.after.ruleName));

  return {
    checkRules,
    requiresApproval: checkedNew.length > 0 || checkedChanged.length > 0,
    counts: {
      new: checkedNew.length,
      removed: checkedRemoved.length,
      changed: checkedChanged.length,
    },
    newSuppressions: checkedNew,
    removedSuppressions: checkedRemoved,
    changedSuppressions: checkedChanged,
  };
}

async function listRevisionFiles(
  repoRoot: string,
  revision: string,
  specPath: string,
): Promise<string[]> {
  const git = simpleGit(repoRoot);
  const output = await git.raw(["ls-tree", "-r", "--name-only", revision, "--", specPath]);
  return output
    .split("\n")
    .map((file) => file.trim())
    .filter((file) => file.length > 0)
    .map(normalizeRepoPath);
}

async function readRevisionFile(
  repoRoot: string,
  revision: string,
  filePath: string,
): Promise<string | undefined> {
  const git = simpleGit(repoRoot);

  try {
    return await git.show([`${revision}:${filePath}`]);
  } catch (error) {
    if (error instanceof Error && error.message.includes("does not exist")) {
      return undefined;
    }
    throw error;
  }
}

async function collectRevisionSuppressions(
  repoRoot: string,
  revision: string,
  specPath: string,
): Promise<SuppressionRecord[]> {
  const files = await listRevisionFiles(repoRoot, revision, specPath);
  const relevantFiles = files.filter(
    (filePath) => isTypeSpecSourceFile(filePath) || isTypeSpecConfigFile(filePath),
  );

  const suppressions: SuppressionRecord[] = [];
  for (const filePath of relevantFiles) {
    const content = await readRevisionFile(repoRoot, revision, filePath);
    if (content === undefined) {
      continue;
    }

    if (isTypeSpecConfigFile(filePath)) {
      suppressions.push(...extractTspconfigSuppressions(specPath, filePath, content));
    } else if (isTypeSpecSourceFile(filePath)) {
      suppressions.push(...extractInlineSuppressions(specPath, filePath, content));
    }
  }

  return suppressions.sort(compareSuppressions);
}

async function listDirectoryFiles(repoRoot: string, specPath: string): Promise<string[]> {
  const normalizedRoot = normalizeRepoPath(repoRoot);
  const specDirectory = path.join(normalizedRoot, specPath);
  const files: string[] = [];

  async function walk(directory: string): Promise<void> {
    let entries;
    try {
      entries = await readdir(directory, { withFileTypes: true });
    } catch (error) {
      if (error instanceof Error && "code" in error && error.code === "ENOENT") {
        return;
      }
      throw error;
    }

    for (const entry of entries) {
      const entryPath = path.join(directory, entry.name);
      if (entry.isDirectory()) {
        await walk(entryPath);
      } else if (entry.isFile()) {
        files.push(normalizeRepoPath(path.relative(normalizedRoot, entryPath)));
      }
    }
  }

  await walk(specDirectory);
  return files.sort((left, right) => left.localeCompare(right));
}

async function readDirectoryFile(repoRoot: string, filePath: string): Promise<string | undefined> {
  try {
    return await readFile(path.join(repoRoot, filePath), "utf-8");
  } catch (error) {
    if (error instanceof Error && "code" in error && error.code === "ENOENT") {
      return undefined;
    }
    throw error;
  }
}

async function collectDirectorySuppressions(
  repoRoot: string,
  specPath: string,
): Promise<SuppressionRecord[]> {
  const files = await listDirectoryFiles(repoRoot, specPath);
  const relevantFiles = files.filter(
    (filePath) => isTypeSpecSourceFile(filePath) || isTypeSpecConfigFile(filePath),
  );

  const suppressions: SuppressionRecord[] = [];
  for (const filePath of relevantFiles) {
    const content = await readDirectoryFile(repoRoot, filePath);
    if (content === undefined) {
      continue;
    }

    if (isTypeSpecConfigFile(filePath)) {
      suppressions.push(...extractTspconfigSuppressions(specPath, filePath, content));
    } else if (isTypeSpecSourceFile(filePath)) {
      suppressions.push(...extractInlineSuppressions(specPath, filePath, content));
    }
  }

  return suppressions.sort(compareSuppressions);
}

function diffSuppressions(
  baseSuppressions: SuppressionRecord[],
  headSuppressions: SuppressionRecord[],
): Pick<
  SpecSuppressionReport,
  "newSuppressions" | "removedSuppressions" | "changedSuppressions" | "unchangedSuppressions"
> {
  const baseMap = new Map(
    baseSuppressions.map((suppression) => [suppressionIdentityKey(suppression), suppression]),
  );
  const headMap = new Map(
    headSuppressions.map((suppression) => [suppressionIdentityKey(suppression), suppression]),
  );

  const newSuppressions: SuppressionRecord[] = [];
  const removedSuppressions: SuppressionRecord[] = [];
  const changedSuppressions: SuppressionChange[] = [];
  const unchangedSuppressions: SuppressionRecord[] = [];

  for (const [identity, headSuppression] of headMap) {
    const baseSuppression = baseMap.get(identity);
    if (!baseSuppression) {
      newSuppressions.push(headSuppression);
      continue;
    }

    if (baseSuppression.justification !== headSuppression.justification) {
      changedSuppressions.push({ before: baseSuppression, after: headSuppression });
    } else {
      unchangedSuppressions.push(headSuppression);
    }
  }

  for (const [identity, baseSuppression] of baseMap) {
    if (!headMap.has(identity)) {
      removedSuppressions.push(baseSuppression);
    }
  }

  return {
    newSuppressions: newSuppressions.sort(compareSuppressions),
    removedSuppressions: removedSuppressions.sort(compareSuppressions),
    changedSuppressions: changedSuppressions.sort(compareChanges),
    unchangedSuppressions: unchangedSuppressions.sort(compareSuppressions),
  };
}

export async function analyzeTypeSpecSuppressions(
  options: AnalyzeSuppressionsOptions,
): Promise<SuppressionReport> {
  const cwd = options.cwd ?? process.cwd();
  const git = simpleGit(cwd);
  const repoRoot = normalizeRepoPath((await git.revparse(["--show-toplevel"])).trim());

  const specPaths = Array.from(
    new Set(
      options.specPaths
        .map((specPath) => toRepoRelativePath(repoRoot, specPath))
        .filter((specPath) => specPath.length > 0),
    ),
  ).sort((left, right) => left.localeCompare(right));

  const specReports: SpecSuppressionReport[] = [];

  for (const specPath of specPaths) {
    const [baseFiles, headFiles] = await Promise.all([
      listRevisionFiles(repoRoot, options.baseRevision, specPath),
      listRevisionFiles(repoRoot, options.headRevision, specPath),
    ]);

    const hasConfig = [...baseFiles, ...headFiles].some(
      (filePath) => path.posix.basename(filePath) === "tspconfig.yaml",
    );
    if (!hasConfig) {
      throw new Error(
        `Spec path '${specPath}' does not contain tspconfig.yaml in ${options.baseRevision} or ${options.headRevision}.`,
      );
    }

    const [baseSuppressions, headSuppressions] = await Promise.all([
      collectRevisionSuppressions(repoRoot, options.baseRevision, specPath),
      collectRevisionSuppressions(repoRoot, options.headRevision, specPath),
    ]);

    specReports.push({
      specPath,
      baseSuppressions,
      headSuppressions,
      ...diffSuppressions(baseSuppressions, headSuppressions),
    });
  }

  const newSuppressions = specReports
    .flatMap((spec) => spec.newSuppressions)
    .sort(compareSuppressions);
  const removedSuppressions = specReports
    .flatMap((spec) => spec.removedSuppressions)
    .sort(compareSuppressions);
  const changedSuppressions = specReports
    .flatMap((spec) => spec.changedSuppressions)
    .sort(compareChanges);

  const counts = {
    specs: specReports.length,
    base: specReports.reduce((total, spec) => total + spec.baseSuppressions.length, 0),
    head: specReports.reduce((total, spec) => total + spec.headSuppressions.length, 0),
    new: newSuppressions.length,
    removed: removedSuppressions.length,
    changed: changedSuppressions.length,
    unchanged: specReports.reduce((total, spec) => total + spec.unchangedSuppressions.length, 0),
  };

  const enrichedNewSuppressions = await enrichSuppressionRecords(newSuppressions);
  const enrichedChangedSuppressions = await enrichSuppressionChanges(changedSuppressions);

  const checkRules = normalizeCheckRules(options.checkRules);
  const checkedSuppressions = buildCheckedSuppressions(
    checkRules,
    enrichedNewSuppressions,
    removedSuppressions,
    enrichedChangedSuppressions,
  );

  return {
    repoRoot,
    baseRevision: options.baseRevision,
    headRevision: options.headRevision,
    specPaths,
    checkRules,
    requiresApproval: newSuppressions.length > 0 || changedSuppressions.length > 0,
    counts,
    specs: specReports,
    newSuppressions: enrichedNewSuppressions,
    removedSuppressions,
    changedSuppressions: enrichedChangedSuppressions,
    checkedSuppressions,
  };
}

export async function analyzeTypeSpecSuppressionsFromDirectories(
  options: AnalyzeSuppressionsDirectoriesOptions,
): Promise<SuppressionReport> {
  const baseRoot = normalizeRepoPath(options.baseRoot);
  const headRoot = normalizeRepoPath(options.headRoot);
  const specPaths = Array.from(new Set(options.specPaths.map(normalizeRepoPath))).sort((a, b) =>
    a.localeCompare(b),
  );

  const specReports: SpecSuppressionReport[] = [];

  for (const specPath of specPaths) {
    const [baseFiles, headFiles] = await Promise.all([
      listDirectoryFiles(baseRoot, specPath),
      listDirectoryFiles(headRoot, specPath),
    ]);

    const hasConfig = [...baseFiles, ...headFiles].some(
      (filePath) => path.posix.basename(filePath) === "tspconfig.yaml",
    );
    if (!hasConfig) {
      throw new Error(
        `Spec path '${specPath}' does not contain tspconfig.yaml under '${baseRoot}' or '${headRoot}'.`,
      );
    }

    const [baseSuppressions, headSuppressions] = await Promise.all([
      collectDirectorySuppressions(baseRoot, specPath),
      collectDirectorySuppressions(headRoot, specPath),
    ]);

    specReports.push({
      specPath,
      baseSuppressions,
      headSuppressions,
      ...diffSuppressions(baseSuppressions, headSuppressions),
    });
  }

  const newSuppressions = specReports
    .flatMap((spec) => spec.newSuppressions)
    .sort(compareSuppressions);
  const removedSuppressions = specReports
    .flatMap((spec) => spec.removedSuppressions)
    .sort(compareSuppressions);
  const changedSuppressions = specReports
    .flatMap((spec) => spec.changedSuppressions)
    .sort(compareChanges);

  const counts = {
    specs: specReports.length,
    base: specReports.reduce((total, spec) => total + spec.baseSuppressions.length, 0),
    head: specReports.reduce((total, spec) => total + spec.headSuppressions.length, 0),
    new: newSuppressions.length,
    removed: removedSuppressions.length,
    changed: changedSuppressions.length,
    unchanged: specReports.reduce((total, spec) => total + spec.unchangedSuppressions.length, 0),
  };

  const enrichedNewSuppressions = await enrichSuppressionRecords(newSuppressions);
  const enrichedChangedSuppressions = await enrichSuppressionChanges(changedSuppressions);

  const checkRules = normalizeCheckRules(options.checkRules);
  const checkedSuppressions = buildCheckedSuppressions(
    checkRules,
    enrichedNewSuppressions,
    removedSuppressions,
    enrichedChangedSuppressions,
  );

  return {
    repoRoot: headRoot,
    baseRevision: baseRoot,
    headRevision: headRoot,
    specPaths,
    checkRules,
    requiresApproval: newSuppressions.length > 0 || changedSuppressions.length > 0,
    counts,
    specs: specReports,
    newSuppressions: enrichedNewSuppressions,
    removedSuppressions,
    changedSuppressions: enrichedChangedSuppressions,
    checkedSuppressions,
  };
}
