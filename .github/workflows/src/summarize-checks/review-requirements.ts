import type { ImpactAssessment } from "../../../shared/src/impact.ts";

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
  return {
    arm:
      active &&
      impact.services.some(
        (service) =>
          service.plane === "resource-manager" &&
          (service.hasAffectedReadme ||
            service.changes.some(
              (kind) => kind === "api" || kind === "examples" || kind === "readme",
            )),
      ),
    dataPlane:
      active &&
      impact.services.some(
        (service) => service.plane === "data-plane" && service.newApiVersions.length > 0,
      ),
    suppressions: impact.services.some(
      (service) => service.plane === "resource-manager" && service.suppressionsChanged,
    ),
  };
}
