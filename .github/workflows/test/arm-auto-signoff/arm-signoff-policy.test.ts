import { describe, expect, it } from "vitest";
import { evaluateArmSignoff } from "../../src/arm-auto-signoff/arm-signoff-policy.ts";
import type { CommitStatus } from "../../src/arm-auto-signoff/arm-semantic-review.ts";

const passed: CommitStatus = {
  context: "ARM Semantic Review",
  state: "success",
  description: "Passed: full review completed with no Blocking findings",
  updated_at: "2026-01-01",
};
const deterministic = ["Swagger LintDiff", "Swagger Avocado"].map((context) => ({
  context,
  state: "success",
  updated_at: "2026-01-01",
}));
const statuses = [passed, ...deterministic];
const owned = ["ARMSignedOff", "ARMAutoSignedOff"];

describe("ARM signoff policy", () => {
  it("grants automation-owned approval only with all three successful results", () => {
    expect(evaluateArmSignoff(["ARMReview"], statuses)).toEqual(["ARMReview", ...owned]);
    expect(evaluateArmSignoff(["ARMReview"], deterministic)).toEqual(["ARMReview"]);
    expect(evaluateArmSignoff(["ARMReview"], [passed])).toEqual(["ARMReview"]);
  });

  it.each([
    ["ARMReview", "ARMChangesRequested"],
    ["ARMReview", "ARMManualSignoffRequired"],
    ["ARMReview", "NotReadyForARMReview"],
    ["ARMReview", "SuppressionReviewRequired"],
    [],
  ])("revokes owned approval when label policy blocks it: %j", (...labels) => {
    expect(evaluateArmSignoff([...labels, ...owned], statuses)).toEqual(labels);
  });

  it.each([
    { state: "pending", description: "ARM API semantic review is pending" },
    { state: "failure", description: "Changes requested: 1 Blocking finding(s)" },
    { state: "error", description: "Review incomplete: tool-failure" },
  ])("revokes rather than trusting a $state result: $description", (result) => {
    expect(
      evaluateArmSignoff(["ARMReview", ...owned], [{ ...passed, ...result }, ...deterministic]),
    ).toEqual(["ARMReview"]);
  });

  it("preserves human approval, even when automatic approval would be withheld", () => {
    const labels = ["ARMReview", "ARMSignedOff", "ARMManualSignoffRequired"];
    expect(evaluateArmSignoff(labels, [])).toEqual(labels);
  });

  it("revokes while a deterministic check is pending despite a passing semantic verdict", () => {
    expect(
      evaluateArmSignoff(
        ["ARMReview", ...owned],
        statuses.map((status) =>
          status.context === "Swagger Avocado" ? { ...status, state: "pending" } : status,
        ),
      ),
    ).toEqual(["ARMReview"]);
  });

  it("requires a sticky manual signoff for scoped review, not for transient failure", () => {
    expect(
      evaluateArmSignoff(
        ["ARMReview", ...owned],
        [{ ...passed, state: "error", description: "Manual review required: scoped review" }],
      ),
    ).toEqual(["ARMReview", "ARMManualSignoffRequired"]);
  });

  it("uses the newest semantic result and accepts approved suppressions", () => {
    expect(
      evaluateArmSignoff(
        ["ARMReview", "SuppressionReviewRequired", "Approved-Suppression"],
        [{ ...passed, state: "pending", updated_at: "2025-12-01" }, ...statuses],
      ),
    ).toEqual(["ARMReview", "SuppressionReviewRequired", "Approved-Suppression", ...owned]);
  });

  it.each(["ARMAutoSignedOff-Trivial", "ARMAutoSignedOff-IncrementalTSP"])(
    "migrates %s without preserving an unearned approval",
    (marker) => {
      const labels = ["ARMReview", "ARMSignedOff", marker];
      expect(evaluateArmSignoff(labels, statuses)).toEqual(["ARMReview", ...owned]);
      expect(evaluateArmSignoff(labels, [])).toEqual(["ARMReview"]);
    },
  );

  it("self-heals a partial removal and is idempotent", () => {
    const labels = evaluateArmSignoff(["ARMReview", "ARMAutoSignedOff"], statuses);
    expect(labels).toContain("ARMSignedOff");
    expect(evaluateArmSignoff(labels, statuses)).toEqual(labels);
  });
});
