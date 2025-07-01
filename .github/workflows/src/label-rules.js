/*
    This file determines what labels are required for a given PR. It uses this context to obtain two key
    pieces of information:
    1. The labels that are currently present on the PR.
    2. The target branch of the PR.
*/

import { anyLabelMatches, brchTsg, breakingChangesCheckType, diagramTsg, href,
  notReadyForArmReviewReason, sdkLabels, wrapInArmReviewMessage } from "./tsgs.js";

/**
 * This file is the single source of truth for the labels used by the SDK generation tooling
 * in the Azure/azure-rest-api-specs and Azure/azure-rest-api-specs-pr repositories.
 *
 * For additional context, see:
 * - https://gist.github.com/raych1/353949d19371b69fb82a10dd70032a51
 * - https://github.com/Azure/azure-sdk-tools/issues/6327
 * - https://microsoftapc-my.sharepoint.com/:w:/g/personal/raychen_microsoft_com/EbOAA9SkhQhGlgxtf7mc0kUB-25bFue0EFbXKXS3TFLTQA
 */

export const sdkLabels ={
  "azure-cli-extensions": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    deprecatedBreakingChange: undefined,
    deprecatedBreakingChangeApproved: undefined,
  },
  "azure-resource-manager-schemas": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    deprecatedBreakingChange: undefined,
    deprecatedBreakingChangeApproved: undefined,
  },
  "azure-sdk-for-go": {
    breakingChange: "BreakingChange-Go-Sdk",
    breakingChangeApproved: "BreakingChange-Go-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Go-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Go-Sdk-Suppression-Approved",
    deprecatedBreakingChange: "CI-BreakingChange-Go",
    deprecatedBreakingChangeApproved: "Approved-SdkBreakingChange-Go",
  },
  "azure-sdk-for-java": {
    breakingChange: "BreakingChange-Java-Sdk",
    breakingChangeApproved: "BreakingChange-Java-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Java-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Java-Sdk-Suppression-Approved",
    deprecatedBreakingChange: "CI-BreakingChange-Java",
    deprecatedBreakingChangeApproved: "Approved-SdkBreakingChange-Java",
  },
  "azure-sdk-for-js": {
    breakingChange: "BreakingChange-JavaScript-Sdk",
    breakingChangeApproved: "BreakingChange-JavaScript-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-JavaScript-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-JavaScript-Sdk-Suppression-Approved",
    deprecatedBreakingChange: "CI-BreakingChange-JavaScript",
    deprecatedBreakingChangeApproved: "Approved-SdkBreakingChange-JavaScript",
  },
  "azure-sdk-for-net": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    deprecatedBreakingChange: undefined,
    deprecatedBreakingChangeApproved: undefined,
  },
  "azure-sdk-for-python": {
    breakingChange: "BreakingChange-Python-Sdk",
    breakingChangeApproved: "BreakingChange-Python-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Python-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Python-Sdk-Suppression-Approved",
    deprecatedBreakingChange: "CI-BreakingChange-Python",
    deprecatedBreakingChangeApproved: "Approved-SdkBreakingChange-Python",
  },
  "azure-sdk-for-python-track2": {
    breakingChange: "BreakingChange-Python-Track2-Sdk",
    breakingChangeApproved: "BreakingChange-Python-Track2-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Python-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Python-Sdk-Suppression-Approved",
    deprecatedBreakingChange: "CI-BreakingChange-Python-Track2",
    // Note that deprecatedBreakingChangeApproved is the same for python and python-track2
    deprecatedBreakingChangeApproved: "Approved-SdkBreakingChange-Python",
  },
  "azure-sdk-for-trenton": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    deprecatedBreakingChange: undefined,
    deprecatedBreakingChangeApproved: undefined,
  },
};

/**
 * This file is the single source of truth for types used by the OpenAPI specification breaking change checks
 * in the Azure/azure-rest-api-specs and Azure/azure-rest-api-specs-pr repositories.
 *
 * For additional context, see:
 *
 * - "Deep-dive into breaking changes on spec PRs"
 *   https://aka.ms/azsdk/pr-brch-deep
 *
 * - "[Breaking Change][PR Workflow] Use more granular labels for Breaking Changes approvals"
 *   https://github.com/Azure/azure-sdk-tools/issues/6374
 */
/**
 * @typedef {"SameVersion" | "CrossVersion"} BreakingChangesCheckType
 * @typedef {"VersioningReviewRequired" | "BreakingChangeReviewRequired"} ReviewRequiredLabel
 * @typedef {"Versioning-Approved-*" | "BreakingChange-Approved-*"} ReviewApprovalPrefixLabel
 * @typedef {"Versioning-Approved-Benign" | "Versioning-Approved-BugFix" | "Versioning-Approved-PrivatePreview" | "Versioning-Approved-BranchPolicyException" | "Versioning-Approved-Previously" | "Versioning-Approved-Retired"} ValidVersioningApproval
 * @typedef {"BreakingChange-Approved-Benign" | "BreakingChange-Approved-BugFix" | "BreakingChange-Approved-UserImpact" | "BreakingChange-Approved-BranchPolicyException" | "BreakingChange-Approved-Previously" | "BreakingChange-Approved-Security"} ValidBreakingChangeApproval
 * @typedef {ReviewRequiredLabel | ReviewApprovalPrefixLabel | ValidBreakingChangeApproval | ValidVersioningApproval} SpecsBreakingChangesLabel
 */
/**
 * @typedef {Object} BreakingChangesCheckConfig
 * @property {ReviewRequiredLabel} reviewRequiredLabel
 * @property {ReviewApprovalPrefixLabel} approvalPrefixLabel
 * @property {(ValidVersioningApproval | ValidBreakingChangeApproval)[]} approvalLabels
 * @property {string} [deprecatedReviewRequiredLabel]
 */

/**
 * @type {Record<BreakingChangesCheckType, BreakingChangesCheckConfig>}
 */
export const breakingChangesCheckType = {
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

/**
 * @param {BreakingChangesCheckType} approvalType
 * @param {string[]} labels
 * @returns {boolean}
 */
export function anyApprovalLabelPresent(
  approvalType,
  labels
) {
  const labelsToMatchAgainst = [breakingChangesCheckType[approvalType].approvalPrefixLabel];
  return anyLabelMatches(labelsToMatchAgainst, labels);
}

/**
 * RequiredLabelRule:
 * IF ((any of the anyPrerequisiteLabels is present
 *     OR all of the allPrerequisiteLabels are present)
 *     AND none of the allPrerequisiteAbsentLabels is present)
 * THEN any of the anyRequiredLabels is required.
 *
 * IF any of the anyRequiredLabels is required
 * THEN display the troubleshootingGuide in "Next Steps to Merge" comment.
 *
 * @typedef {Object} RequiredLabelRule
 * @property {number} precedence - If multiple RequiredLabelRules are violated, the one with lowest
 *   precedence should be displayed to the user first. If multiple rules have
 *   the same precedence, and one of them should be displayed,
 *   then all of them should be displayed.
 *
 *   Note this independent of the CheckWorkflowInfo.precedence. That is,
 *   if there are failing checks, and failing required label rules,
 *   both of them will be shown, both taking appropriate lowest precedence.
 * @property {string[]} [branches] - Branches, in format "repo/branch", e.g. "azure-rest-api-specs/main",
 *   to which this required label rule applies.
 *
 *   To be exact:
 *   - If there is at least one branch defined, and the evaluated PR is
 *     not targeting any of the branches defined, then the rule is not applicable (it implicitly passes).
 *   - If "branches" is empty or undefined, then the rule applies to all branches in all repos.
 * @property {string[]} [anyPrerequisiteLabels] - If any of anyPrerequisiteLabels is present, the requiredLabel is required.
 *   This condition is ORed with allPrerequisiteLabels.
 *
 *   If the anyRequiredLabels collection is empty or undefined, anyPrerequisiteLabels must have exactly one entry.
 * @property {string[]} [allPrerequisiteLabels] - If all of allPrerequisiteLabels are present, the requiredLabel is required.
 *   This condition is ORed with anyPrerequisiteLabels.
 *
 *   If the anyRequiredLabels collection is empty or undefined, allPrerequisiteLabels must be empty or undefined.
 * @property {string[]} [allPrerequisiteAbsentLabels] - If any of the allPrerequisiteAbsentLabels is present,
 *   the requiredLabel is not required.
 * @property {string[]} anyRequiredLabels - If any of the labels in anyRequiredLabels is present,
 *   then the rule prerequisites, as expressed by anyPrerequisiteLabels and allPrerequisiteLabels, are met.
 *   Conversely, if none of anyRequiredLabels are present, then the rule is violated.
 *
 *   For the purposes of determining which label to display as required in the 'automated merging requirements met' check and
 *   'Next Steps to Merge" comments, the first label in anyRequiredLabels is used.
 *   The assumption here is that anyRequiredLabels[0] is the 'current' label,
 *   while the remaining required label options are 'legacy' labels.
 *
 *   If given required label string ends with an asterisk, it is treated as a prefix substring match.
 *   For example, requiredLabel of 'Foo-Approved-*' means that any label with prefix 'Foo-Approved-' will satisfy the rule.
 *   For example, 'Foo-Approved-Bar' or 'Foo-Approved-Qux', but not 'Foo-Approved' nor 'Foo-Approved-'.
 *
 *   If anyRequiredLabels is an empty array, then if the rule is violated, there is no way to meet the rule prerequisites.
 * @property {string} troubleshootingGuide - The doc to display to the user if the required label is required, but missing.
 */

/**
 * @param {RequiredLabelRule} rule
 * @returns {boolean}
 */
export function isAnyPrerequisiteLabelsNonempty(rule) {
  return rule.anyPrerequisiteLabels !== undefined && rule.anyPrerequisiteLabels.length > 0;
}

/**
 * @param {RequiredLabelRule} rule
 * @returns {boolean}
 */
export function isAllPrerequisiteLabelsNonempty(rule) {
  return rule.allPrerequisiteLabels !== undefined && rule.allPrerequisiteLabels.length > 0;
}

/**
 * @param {RequiredLabelRule} rule
 * @returns {boolean}
 */
export function isAllPrerequisiteAbsentLabelsNonempty(rule) {
  return rule.allPrerequisiteAbsentLabels !== undefined && rule.allPrerequisiteAbsentLabels.length > 0;
}


