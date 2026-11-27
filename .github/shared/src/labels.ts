import type { SdkName } from "./sdk-types.ts";

/**
 * Single source of truth for repository pull-request label constants across
 * `.github/packages/*`, `.github/workflows/*`, and `eng/tools/*`.
 *
 * This module has zero runtime dependencies so zero-dependency workflows can
 * import it via relative paths before `pnpm install`.
 */

/** Versioning approval labels for same-version spec changes. */
export const VERSIONING_APPROVALS = Object.freeze({
  BENIGN: "Versioning-Approved-Benign",
  BUG_FIX: "Versioning-Approved-BugFix",
  PRIVATE_PREVIEW: "Versioning-Approved-PrivatePreview",
  BRANCH_POLICY_EXCEPTION: "Versioning-Approved-BranchPolicyException",
  PREVIOUSLY: "Versioning-Approved-Previously",
  RETIRED: "Versioning-Approved-Retired",
});
export type ValidVersioningApproval =
  (typeof VERSIONING_APPROVALS)[keyof typeof VERSIONING_APPROVALS];

/** Breaking-change approval labels for cross-version spec changes. */
export const BREAKING_CHANGE_APPROVALS = Object.freeze({
  BENIGN: "BreakingChange-Approved-Benign",
  BUG_FIX: "BreakingChange-Approved-BugFix",
  USER_IMPACT: "BreakingChange-Approved-UserImpact",
  BRANCH_POLICY_EXCEPTION: "BreakingChange-Approved-BranchPolicyException",
  PREVIOUSLY: "BreakingChange-Approved-Previously",
  SECURITY: "BreakingChange-Approved-Security",
});
export type ValidBreakingChangeApproval =
  (typeof BREAKING_CHANGE_APPROVALS)[keyof typeof BREAKING_CHANGE_APPROVALS];

/** Breaking-change and versioning review-required labels. */
export const REVIEW_REQUIRED_LABELS = Object.freeze({
  BREAKING_CHANGE: "BreakingChangeReviewRequired",
  VERSIONING: "VersioningReviewRequired",
});
export type ReviewRequiredLabel =
  (typeof REVIEW_REQUIRED_LABELS)[keyof typeof REVIEW_REQUIRED_LABELS];

/** Wildcard prefix patterns matching breaking-change and versioning approval labels. */
export const APPROVAL_PREFIX_LABELS = Object.freeze({
  BREAKING_CHANGE: "BreakingChange-Approved-*",
  VERSIONING: "Versioning-Approved-*",
});
export type ReviewApprovalPrefixLabel =
  (typeof APPROVAL_PREFIX_LABELS)[keyof typeof APPROVAL_PREFIX_LABELS];

export type SdkLabelInfo = {
  breakingChange: string | undefined;
  breakingChangeApproved: string | undefined;
  breakingChangeSuppression: string | undefined;
  breakingChangeSuppressionApproved: string | undefined;
  /** Applied to generated SDK PRs in the target SDK repo, not in this specs repo. */
  buildFailed: string | undefined;
};

export type SdkLabels = Record<SdkName, SdkLabelInfo>;

/**
 * SDK labels mapping for breaking-change, suppression, and build-failure labels.
 */
export const sdkLabels = {
  "azure-sdk-for-go": {
    breakingChange: "BreakingChange-Go-Sdk",
    breakingChangeApproved: "BreakingChange-Go-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Go-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-Go-Sdk-Suppression-Approved",
    buildFailed: undefined,
  },
  "azure-sdk-for-java": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    buildFailed: undefined,
  },
  "azure-sdk-for-js": {
    breakingChange: "BreakingChange-JavaScript-Sdk",
    breakingChangeApproved: "BreakingChange-JavaScript-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-JavaScript-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-JavaScript-Sdk-Suppression-Approved",
    buildFailed: undefined,
  },
  "azure-sdk-for-net": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    buildFailed: "auto-sdk-build-fix",
  },
  "azure-sdk-for-python": {
    breakingChange: "BreakingChange-Python-Sdk",
    breakingChangeApproved: "BreakingChange-Python-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Python-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-Python-Sdk-Suppression-Approved",
    buildFailed: undefined,
  },
  "azure-sdk-for-rust": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    buildFailed: undefined,
  },
} satisfies SdkLabels;

/** TypeSpec suppression review labels. */
export const TypeSpecSuppressionLabel = Object.freeze({
  ReviewRequired: "typespec-suppressions-review-required",
  Approved: "typespec-suppressions-approved",
});
export type TypeSpecSuppressionLabel =
  (typeof TypeSpecSuppressionLabel)[keyof typeof TypeSpecSuppressionLabel];

/** AutoRest / Swagger suppression review labels. */
export const SwaggerSuppressionLabel = Object.freeze({
  ReviewRequired: "SuppressionReviewRequired",
  Approved: "Approved-Suppression",
});
export type SwaggerSuppressionLabel =
  (typeof SwaggerSuppressionLabel)[keyof typeof SwaggerSuppressionLabel];

/** ARM auto-signoff label names managed by Universal Auto-Signoff. */
export const ArmAutoSignoffLabel = Object.freeze({
  ArmSignedOff: "ARMSignedOff",
  ArmManualSignoffRequired: "ARMManualSignoffRequired",
  ArmAutoSignedOff: "ARMAutoSignedOff",
  ArmAutoSignedOffIncrementalTSP: "ARMAutoSignedOff-IncrementalTSP",
  ArmAutoSignedOffTrivial: "ARMAutoSignedOff-Trivial",
});
export type ArmAutoSignoffLabel = (typeof ArmAutoSignoffLabel)[keyof typeof ArmAutoSignoffLabel];

/** Legacy markers from the retired auto-signoff workflow; replaced by `ARMAutoSignedOff`. */
export const legacyAutoSignoffMarkers: readonly ArmAutoSignoffLabel[] = Object.freeze([
  ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP,
  ArmAutoSignoffLabel.ArmAutoSignedOffTrivial,
]);

/**
 * Markers that make `ARMSignedOff` automation-owned. `ARMSignedOff` without any marker is a human
 * approval.
 */
export const autoSignoffMarkers: readonly ArmAutoSignoffLabel[] = Object.freeze([
  ArmAutoSignoffLabel.ArmAutoSignedOff,
  ...legacyAutoSignoffMarkers,
]);

/** ARM review workflow labels. */
export const ArmReviewLabel = Object.freeze({
  ArmReview: "ARMReview",
  WaitForArmFeedback: "WaitForARMFeedback",
  NotReadyForArmReview: "NotReadyForARMReview",
  ArmChangesRequested: "ARMChangesRequested",
  ArmSignedOff: ArmAutoSignoffLabel.ArmSignedOff,
  ArmManualSignoffRequired: ArmAutoSignoffLabel.ArmManualSignoffRequired,
  ArmInitialReviewRequested: "ARMInitialReviewRequested",
  /** Optional opt-out label checked by ARM review dispatch; not synced in `.github/labels.yaml`. */
  SkipArmReview: "skip-arm-review",
});
export type ArmReviewLabel = (typeof ArmReviewLabel)[keyof typeof ArmReviewLabel];

/** ARM modeling / lease validation labels. */
export const ArmModelingLabel = Object.freeze({
  ReviewRequired: "ARMModelingReviewRequired",
  SignedOff: "ARMModelingSignedOff",
  AutoSignedOff: "ARMModelingAutoSignedOff",
});
export type ArmModelingLabel = (typeof ArmModelingLabel)[keyof typeof ArmModelingLabel];

/** Spec plane classification labels. */
export const SpecPlaneLabel = Object.freeze({
  ResourceManager: "resource-manager",
  DataPlane: "data-plane",
  Mgmt: "Mgmt",
});
export type SpecPlaneLabel = (typeof SpecPlaneLabel)[keyof typeof SpecPlaneLabel];

/** Data-plane API stewardship review labels. */
export const DataPlaneReviewLabel = Object.freeze({
  Requested: "data-plane-review-requested",
  Signoff: "data-plane-review-signoff",
});
export type DataPlaneReviewLabel = (typeof DataPlaneReviewLabel)[keyof typeof DataPlaneReviewLabel];

/** SDK package-name / namespace review labels. */
export const PackageNameLabel = Object.freeze({
  ReviewRequired: "package-name-review-required",
  Approved: "package-name-approved",
  ApprovedAll: "package-name-approved-all",
});
export type PackageNameLabel = (typeof PackageNameLabel)[keyof typeof PackageNameLabel];

/** General spec PR classification, RPaaS, publication, and release-plan labels. */
export const SpecPrLabel = Object.freeze({
  TypeSpec: "TypeSpec",
  NewApiVersion: "new-api-version",
  NewRpNamespace: "new-rp-namespace",
  Rpaas: "RPaaS",
  RpaasException: "RPaaSException",
  CiNewRpNamespaceWithoutRpaas: "CI-NewRPNamespaceWithoutRPaaS",
  CiRpaasRpNotInPrivateRepo: "CI-RpaaSRPNotInPrivateRepo",
  PublishToCustomers: "PublishToCustomers",
  ApprovedOkToMerge: "Approved-OkToMerge",
  FolderMigrationV2: "FolderMigrationV2",
  SkipReleasePlanAutomation: "skip-releaseplan-automation",
});
export type SpecPrLabel = (typeof SpecPrLabel)[keyof typeof SpecPrLabel];
