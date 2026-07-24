import path from "node:path";

export function normalizeSlashes(value: string): string {
  return value.replaceAll("\\", "/");
}

export function normalizeRepoPath(value: string): string {
  return normalizeSlashes(path.normalize(value)).replace(/\/$/, "");
}

export function toRepoRelativePath(repoRoot: string, candidatePath: string): string {
  const absoluteCandidate = path.isAbsolute(candidatePath)
    ? candidatePath
    : path.resolve(repoRoot, candidatePath);
  const relativePath = path.relative(repoRoot, absoluteCandidate);
  return normalizeRepoPath(relativePath);
}
