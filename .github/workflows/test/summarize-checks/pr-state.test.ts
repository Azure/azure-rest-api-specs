import { describe, expect, it } from "vitest";
import type { ImpactAssessment } from "../../src/summarize-checks/labelling.ts";
import { evaluatePrState } from "../../src/summarize-checks/pr-state.ts";

const impact: ImpactAssessment = {
  schemaVersion: 2,
  services: [
    {
      path: "specification/example/resource-manager",
      plane: "resource-manager",
      changes: ["api"],
      hasAffectedReadme: false,
      typeSpec: true,
      newApiVersions: [],
      suppressionsChanged: false,
      resourceProvider: {
        newNamespaces: [],
        usesRpaas: false,
        hasAddedDefinitions: false,
        registered: true,
      },
    },
  ],
};
const context = { isDraft: false, targetBranch: "main" };
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
    const plan = evaluatePrState([], impact, passed, context);
    expect(plan.labels).toEqual(
      expect.arrayContaining(["ARMReview", "ARMSignedOff", "ARMAutoSignedOff"]),
    );
    expect(plan.labelsToAdd).not.toContain("WaitForARMFeedback");
    expect(plan.requestInitialArmReview).toBe(false);
    const repeated = evaluatePrState(plan.labels, impact, passed, context);
    expect(repeated.labelsToAdd).toEqual([]);
    expect(repeated.labelsToRemove).toEqual([]);
  });

  it("revokes an obsolete automatic approval and reopens the queue in the same plan", () => {
    const plan = evaluatePrState(
      ["ARMReview", "ARMAutoSignedOff", "ARMSignedOff", "ARMInitialReviewRequested"],
      impact,
      [],
      context,
    );
    expect(plan.labelsToRemove).toEqual(["ARMSignedOff", "ARMAutoSignedOff"]);
    expect(plan.labelsToAdd).toContain("WaitForARMFeedback");
    expect(plan.requestInitialArmReview).toBe(false);
  });

  it("preserves human approval and unrelated labels", () => {
    const plan = evaluatePrState(["ARMSignedOff", "custom-label"], impact, [], context);
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
      context,
    );
    expect(plan.labels).toContain("ARMSignedOff");
    expect(plan.labelsToRemove).toContain("ARMChangesRequested");
  });

  it.each(["ARMInitialReviewRequested", "ARMManualSignoffRequired", "skip-arm-review"])(
    "does not allocate an initial-review job when %s is already known",
    (label) => {
      expect(evaluatePrState([label], impact, [], context).requestInitialArmReview).toBe(false);
    },
  );

  it("requests the first eligible review, but not a draft or a PR with unknown impact", () => {
    expect(evaluatePrState([], impact, [], context).requestInitialArmReview).toBe(true);
    expect(
      evaluatePrState([], impact, [], { ...context, isDraft: true }).requestInitialArmReview,
    ).toBe(false);
    expect(evaluatePrState(["ARMReview"], undefined, [], context).requestInitialArmReview).toBe(
      false,
    );
  });

  it("revokes approval without queueing a review when the live PR targets a feature branch", () => {
    const plan = evaluatePrState(
      ["ARMReview", "ARMSignedOff", "ARMAutoSignedOff"],
      impact,
      passed,
      { ...context, targetBranch: "feature/example" },
    );
    expect(plan.labels).not.toContain("ARMReview");
    expect(plan.labels).not.toContain("ARMSignedOff");
    expect(plan.labels).not.toContain("ARMAutoSignedOff");
    expect(plan.labels).not.toContain("WaitForARMFeedback");
    expect(plan.requestInitialArmReview).toBe(false);
  });

  it("does not use a data-plane API change to make an ARM SDK-configuration change reviewable", () => {
    const armService = impact.services[0];
    const plan = evaluatePrState(
      [],
      {
        schemaVersion: 2,
        services: [
          { ...armService, changes: ["sdk-configuration"] },
          {
            ...armService,
            path: "specification/other/data-plane",
            plane: "data-plane",
            newApiVersions: ["2026-10-01"],
          },
        ],
      },
      passed,
      context,
    );
    expect(plan.labels).toContain("data-plane-review-requested");
    expect(plan.labels).not.toContain("ARMReview");
    expect(plan.labels).not.toContain("ARMSignedOff");
    expect(plan.requestInitialArmReview).toBe(false);
  });
});
