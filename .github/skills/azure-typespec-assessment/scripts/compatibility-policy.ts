import type {
  ArtifactComparison,
  CompatibilityPolicy,
  PreparationBlocker,
  PreparationProject,
} from "./runtime-types.ts";

export const NO_STABLE_API_VERSION_MESSAGE =
  "Skipped by policy: no stable API version exists for this preview-only service.";

export const NO_STABLE_API_VERSION_REPORT =
  "Not assessed: breaking changes are evaluated against a stable API version, but none is available.";

export function isPreviewApiVersion(version: string): boolean {
  return /preview/i.test(version);
}

export function skipsCompatibility(
  comparison: Pick<ArtifactComparison, "compatibilityPolicy"> | undefined,
): boolean {
  return comparison?.compatibilityPolicy?.action === "skip";
}

export function skipsAllCompatibility(
  comparisons: Pick<ArtifactComparison, "compatibilityPolicy">[] = [],
): boolean {
  return (
    comparisons.length > 0 &&
    comparisons.every(
      (comparison) =>
        comparison.compatibilityPolicy?.action === "skip" &&
        comparison.compatibilityPolicy.reason === "no-stable-api-version",
    )
  );
}

export function previewCompatibilityPolicy(
  base: string[],
  current: string[],
  target: string | undefined,
): CompatibilityPolicy {
  return target &&
    isPreviewApiVersion(target) &&
    ![...base, ...current].some((version) => !isPreviewApiVersion(version))
    ? { action: "skip", reason: "no-stable-api-version" }
    : { action: "compare" };
}

export function usesTargetOnlyArtifacts(project: PreparationProject): boolean {
  return (
    skipsCompatibility(project.artifactComparison) ||
    project.classification === "new" ||
    project.artifactComparison?.mode === "new-project"
  );
}

export function compatibilitySkipReason(projectId: string): PreparationBlocker {
  return {
    code: "compatibility-skipped-no-stable-api-version",
    projectId,
    message: NO_STABLE_API_VERSION_MESSAGE,
  };
}
