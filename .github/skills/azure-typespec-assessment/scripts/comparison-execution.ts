import type { ArtifactComparison, ArtifactSelection, PreparationProject } from "./runtime-types.ts";

export const UNAVAILABLE_HEAD_BASELINE_MESSAGE =
  "Not assessed: the baseline API version is not available in head.";

export function hasUnavailableHeadBaseline(
  comparison: { mode?: string; baseline?: ArtifactSelection } | undefined,
): boolean {
  return (
    comparison?.mode === "new-api-version" &&
    comparison.baseline?.availability === "unavailable-in-head"
  );
}

export function usesTargetOnlyArtifacts(
  project: Pick<PreparationProject, "classification" | "artifactComparison">,
): boolean {
  return (
    project.classification === "new" ||
    project.artifactComparison?.mode === "new-project" ||
    hasUnavailableHeadBaseline(project.artifactComparison)
  );
}

export function unavailableHeadBaselineBlocker(project: {
  id: string;
  artifactComparison?: Pick<ArtifactComparison, "mode" | "baseline">;
}) {
  return hasUnavailableHeadBaseline(project.artifactComparison)
    ? {
        code: "baseline-api-version-unavailable-in-head",
        projectId: project.id,
        comparisonRole: "baseline",
        sourceRevision: "current",
        message:
          `Baseline API version ${project.artifactComparison?.baseline.apiVersion} is not available in head. ` +
          "REST and downstream compatibility were not assessed; no cross-revision comparison was performed.",
      }
    : undefined;
}
