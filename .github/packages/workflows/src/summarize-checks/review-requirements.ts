import type { ImpactAssessment } from "@azure-tools/specs-shared/impact";

export type ReviewContext = {
  isDraft: boolean;
  targetBranch: string;
};

export type ReviewRequirements = {
  arm: boolean;
  dataPlane: boolean;
  suppressions: boolean;
};

function isReleaseBranch(branchName: string): boolean {
  const branchRegex = [/^main$/, /^RPSaaSMaster$/, /^release.*$/, /^ARMCoreRPDev$/];
  return branchRegex.some((branch) => branch.test(branchName));
}

export function specReviewApplies(context: ReviewContext): boolean {
  return !context.isDraft && isReleaseBranch(context.targetBranch);
}

export function evaluateReviewRequirements(
  impact: ImpactAssessment,
  context: ReviewContext,
): ReviewRequirements {
  const active = specReviewApplies(context);
  const managementServices = impact.services.filter(
    (service) => service.plane === "resource-manager",
  );
  const arm =
    active &&
    managementServices.some(
      (service) =>
        service.hasAffectedReadme ||
        service.changes.some((kind) => kind === "api" || kind === "examples" || kind === "readme"),
    );
  return {
    arm,
    dataPlane:
      active &&
      impact.services.some(
        (service) =>
          service.plane === "data-plane" &&
          // In-flight older artifacts retain their original new-version-only behavior.
          (service.hasApiDefinitionChanges ?? service.newApiVersions.length > 0),
      ),
    suppressions: impact.services.some(
      (service) => service.plane === "resource-manager" && service.suppressionsChanged,
    ),
  };
}
