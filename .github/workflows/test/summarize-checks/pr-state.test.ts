import { describe, expect, it } from "vitest";
import type { ImpactAssessment } from "../../src/summarize-checks/labelling.ts";
import { evaluatePrState } from "../../src/summarize-checks/pr-state.ts";

const impact: ImpactAssessment = {
  resourceManagerRequired: true,
  dataPlaneRequired: false,
  suppressionReviewRequired: false,
  isNewApiVersion: false,
  rpaasRpNotInPrivateRepo: false,
  rpaasChange: false,
  newRP: false,
  rpaasRPMissing: false,
  typeSpecChanged: true,
  isDraft: false,
  targetBranch: "main",
};
const passed = [
  {
    context: "ARM Semantic Review",
    state: "success",
    description: "Passed: full review completed with no Blocking findings",
    updated_at: "2026-01-01",
  },
  ...["Swagger Avocado", "Swagger LintDiff"].map((context) => ({
    context,
    state: "success",
    updated_at: "2026-01-01",
  })),
];

describe("PR state plan", () => {
  it("classifies and signs off in one evaluation, without publishing an intermediate queue label", () => {
    const plan = evaluatePrState([], impact, passed);
    expect(plan.labels).toEqual(
      expect.arrayContaining(["ARMReview", "ARMSignedOff", "ARMAutoSignedOff"]),
    );
    expect(plan.labelsToAdd).not.toContain("WaitForARMFeedback");
    expect(plan.requestInitialArmReview).toBe(false);
    const repeated = evaluatePrState(plan.labels, impact, passed);
    expect(repeated.labelsToAdd).toEqual([]);
    expect(repeated.labelsToRemove).toEqual([]);
  });

  it("revokes an obsolete automatic approval and reopens the queue in the same plan", () => {
    const plan = evaluatePrState(
      ["ARMReview", "ARMSignedOff", "ARMAutoSignedOff", "ARMInitialReviewRequested"],
      impact,
      [],
    );
    expect(plan.labelsToRemove).toEqual(["ARMSignedOff", "ARMAutoSignedOff"]);
    expect(plan.labelsToAdd).toContain("WaitForARMFeedback");
    expect(plan.requestInitialArmReview).toBe(false);
  });

  it("preserves human approval and unrelated labels", () => {
    const plan = evaluatePrState(["ARMSignedOff", "custom-label"], impact, []);
    expect(plan.labels).toContain("ARMSignedOff");
    expect(plan.labels).toContain("custom-label");
    expect(plan.labels).not.toContain("ARMAutoSignedOff");
    expect(plan.requestInitialArmReview).toBe(false);
  });

  it("retains the existing signed-off precedence over changes requested", () => {
    const plan = evaluatePrState(
      ["ARMReview", "ARMSignedOff", "ARMAutoSignedOff", "ARMChangesRequested"],
      impact,
      passed,
    );
    expect(plan.labels).toContain("ARMSignedOff");
    expect(plan.labelsToRemove).toContain("ARMChangesRequested");
  });

  it.each(["ARMInitialReviewRequested", "ARMManualSignoffRequired", "skip-arm-review"])(
    "does not allocate an initial-review job when %s is already known",
    (label) => {
      expect(evaluatePrState([label], impact, []).requestInitialArmReview).toBe(false);
    },
  );

  it("requests the first eligible review, but not a draft or a PR with unknown impact", () => {
    expect(evaluatePrState([], impact, []).requestInitialArmReview).toBe(true);
    expect(evaluatePrState([], { ...impact, isDraft: true }, []).requestInitialArmReview).toBe(
      false,
    );
    expect(evaluatePrState(["ARMReview"], undefined, []).requestInitialArmReview).toBe(false);
  });
});
