import path from "node:path";

export function toStringValue(value: unknown): string {
  if (value === null || value === undefined) {
    return "";
  }
  if (
    typeof value === "string" ||
    typeof value === "number" ||
    typeof value === "boolean" ||
    typeof value === "bigint"
  ) {
    return String(value);
  }
  return "";
}

/**
 * Resolves a TypeSpec project path from release-plan data against the workspace root.
 */
export function resolveTypespecProjectPath(rawPath: string, workspace: string): string {
  const trimmed = rawPath.trim();
  if (!trimmed) {
    return "";
  }
  if (path.isAbsolute(trimmed)) {
    return trimmed;
  }
  return path.resolve(workspace, trimmed);
}
