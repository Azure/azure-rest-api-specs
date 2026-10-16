export function getBlockedOnVersioningPolicy(labels: readonly string[]): boolean {
  return (
    (labels.includes("VersioningReviewRequired") &&
      !labels.some((label) => label.startsWith("Versioning-Approved-"))) ||
    (labels.includes("BreakingChangeReviewRequired") &&
      !labels.some((label) => label.startsWith("BreakingChange-Approved-")))
  );
}

export function getBlockedOnRpaas(
  missingRp: boolean,
  hasException: boolean,
  rpNotInPrivateRepo: boolean,
): boolean {
  return (missingRp || rpNotInPrivateRepo) && !hasException;
}

/** Read raw policy holds as well as readiness: summary labels may still be catching up. */
export function armReviewAllowed(labels: readonly string[]): boolean {
  return (
    labels.includes("ARMReview") &&
    ![
      "NotReadyForARMReview",
      "skip-arm-review",
      "ARMChangesRequested",
      "ARMManualSignoffRequired",
      "ARMModelingReviewRequired",
    ].some((label) => labels.includes(label)) &&
    !getBlockedOnVersioningPolicy(labels) &&
    !getBlockedOnRpaas(
      labels.includes("CI-NewRPNamespaceWithoutRPaaS"),
      labels.includes("RPaaSException"),
      labels.includes("CI-RpaaSRPNotInPrivateRepo"),
    ) &&
    (!labels.includes("SuppressionReviewRequired") || labels.includes("Approved-Suppression")) &&
    (!labels.includes("typespec-suppressions-review-required") ||
      labels.includes("typespec-suppressions-approved"))
  );
}
