/**
 * Breaking change configuration and constants for Azure REST API specs.
 * Label constants are sourced from `./labels.ts` and re-exported here for compatibility.
 */

import {
  APPROVAL_PREFIX_LABELS,
  BREAKING_CHANGE_APPROVALS,
  REVIEW_REQUIRED_LABELS,
  VERSIONING_APPROVALS,
  type ReviewApprovalPrefixLabel,
  type ReviewRequiredLabel,
  type ValidBreakingChangeApproval,
  type ValidVersioningApproval,
} from "./labels.ts";

export {
  APPROVAL_PREFIX_LABELS,
  BREAKING_CHANGE_APPROVALS,
  REVIEW_REQUIRED_LABELS,
  VERSIONING_APPROVALS,
  type ReviewApprovalPrefixLabel,
  type ReviewRequiredLabel,
  type ValidBreakingChangeApproval,
  type ValidVersioningApproval,
};

export type SpecsBreakingChangesLabel =
  | ReviewRequiredLabel
  | ReviewApprovalPrefixLabel
  | ValidBreakingChangeApproval
  | ValidVersioningApproval;

// Check types
export const BREAKING_CHANGES_CHECK_TYPES = Object.freeze({
  SAME_VERSION: "SameVersion",
  CROSS_VERSION: "CrossVersion",
});
export type BreakingChangesCheckType =
  (typeof BREAKING_CHANGES_CHECK_TYPES)[keyof typeof BREAKING_CHANGES_CHECK_TYPES];

export type BreakingChangesCheckConfig = {
  readonly reviewRequiredLabel: ReviewRequiredLabel;
  readonly approvalPrefixLabel: ReviewApprovalPrefixLabel;
  readonly approvalLabels: readonly (ValidVersioningApproval | ValidBreakingChangeApproval)[];
  readonly deprecatedReviewRequiredLabel?: string;
};

// Extract values as arrays for validation and configuration
export const versioningApprovalValues: readonly ValidVersioningApproval[] =
  Object.values(VERSIONING_APPROVALS);
export const breakingChangeApprovalValues: readonly ValidBreakingChangeApproval[] =
  Object.values(BREAKING_CHANGE_APPROVALS);
export const reviewRequiredLabelValues: readonly ReviewRequiredLabel[] =
  Object.values(REVIEW_REQUIRED_LABELS);

// Type guard functions for runtime validation

export function isValidVersioningApproval(value: string): value is ValidVersioningApproval {
  return (versioningApprovalValues as readonly string[]).includes(value);
}

export function isValidBreakingChangeApproval(value: string): value is ValidBreakingChangeApproval {
  return (breakingChangeApprovalValues as readonly string[]).includes(value);
}

export function isReviewRequiredLabel(value: string): value is ReviewRequiredLabel {
  return (reviewRequiredLabelValues as readonly string[]).includes(value);
}

// Configuration for different check types
export const breakingChangesCheckType: Readonly<
  Record<BreakingChangesCheckType, BreakingChangesCheckConfig>
> = Object.freeze({
  SameVersion: Object.freeze({
    reviewRequiredLabel: REVIEW_REQUIRED_LABELS.VERSIONING,
    approvalPrefixLabel: APPROVAL_PREFIX_LABELS.VERSIONING,
    approvalLabels: versioningApprovalValues,
  }),
  CrossVersion: Object.freeze({
    reviewRequiredLabel: REVIEW_REQUIRED_LABELS.BREAKING_CHANGE,
    approvalPrefixLabel: APPROVAL_PREFIX_LABELS.BREAKING_CHANGE,
    approvalLabels: breakingChangeApprovalValues,
  }),
});
