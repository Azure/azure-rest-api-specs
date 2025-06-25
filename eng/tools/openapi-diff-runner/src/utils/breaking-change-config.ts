import {
  BreakingChangesCheckType,
  ReviewRequiredLabel,
  ReviewApprovalPrefixLabel,
  ValidVersioningApproval,
  ValidBreakingChangeApproval,
} from "../types/breaking-change.js";

/**
 * Configuration and utility functions for breaking change checks.
 * This file contains the business logic and configuration data for breaking change validation.
 */

export const breakingChangesCheckType: {
  [checkType in BreakingChangesCheckType]: {
    reviewRequiredLabel: ReviewRequiredLabel;
    approvalPrefixLabel: ReviewApprovalPrefixLabel;
    approvalLabels: (ValidVersioningApproval | ValidBreakingChangeApproval)[];
    deprecatedReviewRequiredLabel?: string;
  };
} = {
  SameVersion: {
    reviewRequiredLabel: "VersioningReviewRequired",
    approvalPrefixLabel: "Versioning-Approved-*",
    approvalLabels: [
      "Versioning-Approved-Benign",
      "Versioning-Approved-BugFix",
      "Versioning-Approved-PrivatePreview",
      "Versioning-Approved-BranchPolicyException",
      "Versioning-Approved-Previously",
      "Versioning-Approved-Retired",
    ],
  },
  CrossVersion: {
    reviewRequiredLabel: "BreakingChangeReviewRequired",
    approvalPrefixLabel: "BreakingChange-Approved-*",
    approvalLabels: [
      "BreakingChange-Approved-Benign",
      "BreakingChange-Approved-BugFix",
      "BreakingChange-Approved-UserImpact",
      "BreakingChange-Approved-BranchPolicyException",
      "BreakingChange-Approved-Previously",
      "BreakingChange-Approved-Security",
    ],
  },
};

/** The name of the log file used by the openapi-diff-runner utility. */
export const logFileName = "openapi-diff-runner.log";
