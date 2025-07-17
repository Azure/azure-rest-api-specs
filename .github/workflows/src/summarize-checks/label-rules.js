/*
    This file determines what labels are required for a given PR. It uses this context to obtain two key
    pieces of information:
    1. The labels that are currently present on the PR.
    2. The target branch of the PR.
*/

import {
  brchTsg,
  diagramTsg,
  href,
  notReadyForArmReviewReason,
  wrapInArmReviewMessage,
} from "./tsgs.js";

/**
 * This file is the single source of truth for the labels used by the SDK generation tooling
 * in the Azure/azure-rest-api-specs and Azure/azure-rest-api-specs-pr repositories.
 *
 * For additional context, see:
 * - https://gist.github.com/raych1/353949d19371b69fb82a10dd70032a51
 * - https://github.com/Azure/azure-sdk-tools/issues/6327
 * - https://microsoftapc-my.sharepoint.com/:w:/g/personal/raychen_microsoft_com/EbOAA9SkhQhGlgxtf7mc0kUB-25bFue0EFbXKXS3TFLTQA
 */

export const sdkLabels = {
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
    breakingChangeSuppressionApproved: "BreakingChange-Go-Sdk-Suppression-Approved",
    deprecatedBreakingChange: "CI-BreakingChange-Go",
    deprecatedBreakingChangeApproved: "Approved-SdkBreakingChange-Go",
  },
  "azure-sdk-for-java": {
    breakingChange: "BreakingChange-Java-Sdk",
    breakingChangeApproved: "BreakingChange-Java-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Java-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-Java-Sdk-Suppression-Approved",
    deprecatedBreakingChange: "CI-BreakingChange-Java",
    deprecatedBreakingChangeApproved: "Approved-SdkBreakingChange-Java",
  },
  "azure-sdk-for-js": {
    breakingChange: "BreakingChange-JavaScript-Sdk",
    breakingChangeApproved: "BreakingChange-JavaScript-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-JavaScript-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-JavaScript-Sdk-Suppression-Approved",
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
    breakingChangeSuppressionApproved: "BreakingChange-Python-Sdk-Suppression-Approved",
    deprecatedBreakingChange: "CI-BreakingChange-Python",
    deprecatedBreakingChangeApproved: "Approved-SdkBreakingChange-Python",
  },
  "azure-sdk-for-python-track2": {
    breakingChange: "BreakingChange-Python-Track2-Sdk",
    breakingChangeApproved: "BreakingChange-Python-Track2-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Python-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-Python-Sdk-Suppression-Approved",
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
// todo: pull this from eng/tools/openapi-diff-runner/src/types/breaking-change.ts
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
export function anyApprovalLabelPresent(approvalType, labels) {
  // todo: confirm property versus map syntax for accessing this.
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
 *   Note this independent of the CheckMetadata.precedence. That is,
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
  return (
    rule.allPrerequisiteAbsentLabels !== undefined && rule.allPrerequisiteAbsentLabels.length > 0
  );
}

export const verRev = breakingChangesCheckType.SameVersion.reviewRequiredLabel;
export const verRevApproval = breakingChangesCheckType.SameVersion.approvalPrefixLabel;
export const brChRev = breakingChangesCheckType.CrossVersion.reviewRequiredLabel;
export const brChRevApproval = breakingChangesCheckType.CrossVersion.approvalPrefixLabel;

/** @type {RequiredLabelRule[]} */
const rulesPri0dataPlane = [
  // For context on this rule see https://github.com/Azure/azure-sdk-tools/issues/7648.
  {
    precedence: 0,
    branches: ["azure-rest-api-specs/main", "azure-rest-api-specs-pr/RPSaaSMaster"],
    anyPrerequisiteLabels: ["data-plane", "resource-manager"],
    anyRequiredLabels: ["PublishToCustomers"],
    troubleshootingGuide:
      `This PR targets either the <code>main</code> branch of the public ` +
      `specs repo or the <code>RPSaaSMaster</code> branch of the private specs repo. These ` +
      `branches are not intended for iterative development. Therefore, you must acknowledge ` +
      `you understand that after this PR is merged, the APIs are considered shipped to ` +
      `Azure customers. Any further attempts at in-place modifications to the APIs will be ` +
      `subject to Azure's versioning and breaking change policies. <b>Additionally, for control ` +
      `plane APIs, you must acknowledge that you are following all the best practices ` +
      `documented by ARM at ` +
      `${href("aka.ms/armapibestpractices", "https://aka.ms/armapibestpractices")}.</b> ` +
      `If you do intend to release the APIs to your customers by merging this PR, ` +
      `add the <code>PublishToCustomers</code> label to your PR in acknowledgement ` +
      `of the above. ` +
      `Otherwise, retarget this PR onto a feature branch, i.e. with prefix <code>release-</code> ` +
      `(see ${href("aka.ms/azsdk/api-versions#release--branches", "https://aka.ms/azsdk/api-versions#release--branches")}).`,
  },
  // For context on this rule see https://github.com/Azure/azure-sdk-tools/issues/6184
  // and https://github.com/Azure/azure-sdk-tools/issues/6612
  // This rule says:
  //
  //   IF (the label APIStewardshipBoard-ReviewRequested is present)
  //   OR (both labels data-plane AND new-api-version are present),
  //   THEN (require label APIStewardshipBoard-SignedOff)
  //
  // TODO: need to implement, in the prSummary.ts, addition of the APIStewardshipBoard-ReviewRequested label
  // Once done, remove "data-plane" and "new-api-version" from here.
  {
    precedence: 0,
    anyPrerequisiteLabels: ["APIStewardshipBoard-ReviewRequested"],
    allPrerequisiteLabels: ["data-plane", "new-api-version"],
    anyRequiredLabels: ["APIStewardshipBoard-SignedOff"],
    troubleshootingGuide:
      `Your PR requires an API stewardship board review as it introduces a new API version (label: <code>new-api-version</code>). ` +
      `Schedule the review by following ` +
      `${href("aka.ms/azsdk/onboarding/restapischedule", "https://aka.ms/azsdk/onboarding/restapischedule")}.`,
  },
];

/** @type {RequiredLabelRule[]} */
const rulesPri0NotReadyForArmReview = [
  // Note this rule can be circumvented e.g. by adding approval mismatching the actual problem.
  // E.g. PR may not be ready for ARM review due to pending breaking changes review, but this rule
  // can be fulfilled by adding RPaaSException instead of breaking change approval.
  //
  // This rule provides a message that sets context for why PR is not ready for ARM review.
  // But the rule doesn't know the exact reason - it is provided by other, more specific rules.
  // This "general context" rule must be considered fulfilled once all the applicable fine-grained rules
  // for NotReadyForARMReview are fulfilled. But because this rule doesn't know the exact problem,
  // it considers itself fulfilled if any one of the fine-grained rules is fulfilled.
  {
    precedence: 0,
    anyPrerequisiteLabels: ["NotReadyForARMReview"],
    allPrerequisiteAbsentLabels: [verRevApproval, brChRevApproval, "RPaaSException"],
    anyRequiredLabels: ["ARMSignedOff"],
    troubleshootingGuide: wrapInArmReviewMessage(
      "This PR is not ready for ARM review (label: <code>NotReadyForARMReview</code>). " +
        "This PR will not be reviewed by ARM until relevant problems are fixed. " +
        "Consult the rest of this <code>Next Steps to Merge</code> comment for details.<br/>" +
        "Once the blocking problems are addressed, add to the PR a comment with contents <code>/azp run</code>. " +
        "Automation will re-evaluate this PR and if everything looks good, it will add <code>WaitForARMFeedback</code> label " +
        "which will put this PR on the ARM review queue.",
    ),
  },
  {
    precedence: 0,
    allPrerequisiteLabels: ["NotReadyForARMReview", "CI-NewRPNamespaceWithoutRPaaS"],
    anyRequiredLabels: ["RPaaSException"],
    troubleshootingGuide: notReadyForArmReviewReason("CI-NewRPNamespaceWithoutRPaaS"),
  },
  {
    precedence: 0,
    allPrerequisiteLabels: ["NotReadyForARMReview", "CI-RpaaSRPNotInPrivateRepo"],
    anyRequiredLabels: ["ARMSignedOff"],
    troubleshootingGuide: notReadyForArmReviewReason("CI-RpaaSRPNotInPrivateRepo"),
  },
  {
    precedence: 0,
    allPrerequisiteLabels: ["NotReadyForARMReview", verRev],
    anyRequiredLabels: [verRevApproval],
    troubleshootingGuide: notReadyForArmReviewReason(verRev),
  },
  {
    precedence: 0,
    allPrerequisiteLabels: ["NotReadyForARMReview", brChRev],
    anyRequiredLabels: [brChRevApproval],
    troubleshootingGuide: notReadyForArmReviewReason(brChRev),
  },
];

/** @type {RequiredLabelRule[]} */
const rulesPri0ArmRpaas = [
  {
    precedence: 0,
    anyPrerequisiteLabels: ["CI-NewRPNamespaceWithoutRPaaS"],
    anyRequiredLabels: ["RPaaSException"],
    troubleshootingGuide:
      "This PR has <code>CI-NewRPNamespaceWithoutRPaaS</code> label. " +
      "This means it is introducing a new RP (Resource Provider) namespace that has not been onboarded with " +
      `${href("RPaaS", "https://armwiki.azurewebsites.net/rpaas/overview.html")}. ` +
      "Merging this PR to the <code>main</code> branch is blocked as RPaaS is required for new RPs.<br/>" +
      `To resolve, ${href(
        "use RPaaS to onboard the new RP",
        "https://armwiki.azurewebsites.net/rpaas/gettingstarted.html",
      )}. ` +
      `To apply for exception, see ${href("aka.ms/RPaaSException", "https://aka.ms/RPaaSException")}.`,
  },
  {
    precedence: 0,
    anyPrerequisiteLabels: ["CI-RpaaSRPNotInPrivateRepo"],
    anyRequiredLabels: ["ARMSignedOff"],
    troubleshootingGuide:
      "This PR has <code>CI-RpaaSRPNotInPrivateRepo</code> label. " +
      "This means it is introducing a new RP (Resource Provider) namespace to the <code>main</code> branch " +
      "without first merging the new RP to the <code>RPSaaSMaster</code> branch. " +
      "To resolve, first submit and merge a PR with the new RP namespace to the <code>RPSaaSMaster</code>branch." +
      "This PR will remain blocked until then.",
  },
];

/** @type {RequiredLabelRule[]} */
const rulesPri0Changes = [
  {
    precedence: 0,
    allPrerequisiteLabels: [verRev],
    anyRequiredLabels: [verRevApproval],
    troubleshootingGuide:
      `This PR has at least one change violating Azure versioning policy (label: <code>${verRev}</code>).<br/>` +
      `To unblock this PR, either a) introduce a new API version with these changes instead of modifying an existing API version, ` +
      `or b) ${brchTsg.replace("To unblock this PR, ", "")}`,
  },
  {
    precedence: 0,
    allPrerequisiteLabels: [brChRev],
    anyRequiredLabels: [brChRevApproval],
    troubleshootingGuide:
      `This PR has at least one breaking change (label: <code>${brChRev}</code>).<br/>` + brchTsg,
  },
];

/** @type {RequiredLabelRule[]} */
const rulesPri0ArmRev = [
  {
    precedence: 0,
    anyPrerequisiteLabels: ["WaitForARMFeedback"],
    anyRequiredLabels: ["ARMSignedOff"],
    troubleshootingGuide: wrapInArmReviewMessage(
      `This PR is awaiting ARM reviewer feedback (label: <code>WaitForARMFeedback</code>).<br/>` +
        `To learn when this PR will get reviewed, see ARM review queue at ` +
        `${href("aka.ms/azsdk/pr-arm-review", "https://aka.ms/azsdk/pr-arm-review")}`,
    ),
  },
  {
    precedence: 0,
    anyPrerequisiteLabels: ["ARMChangesRequested"],
    anyRequiredLabels: ["ARMSignedOff"],
    troubleshootingGuide: wrapInArmReviewMessage(
      "This PR has <code>ARMChangesRequested</code> label. Please address or respond to feedback from the ARM API reviewer. <br/>" +
        "When you are ready to continue the ARM API review, please remove the <code>ARMChangesRequested</code> label. <br/>" +
        "Automation should then add <code>WaitForARMFeedback</code> label. <br/>" +
        "❗If you don't have permissions to remove the label, request <code>write access</code> per " +
        `${href("aka.ms/azsdk/access#request-access-to-rest-api-or-sdk-repositories", "https://aka.ms/azsdk/access#request-access-to-rest-api-or-sdk-repositories")}` +
        ".",
    ),
  },
];

/** @type {RequiredLabelRule[]} */
const rulesPri1ArmRev = [
  // This rule should never kick-in in normal flow, as there should always be one of rules for the ARM review workflow
  // labels active, and all of them have higher precedence than this rule.
  // However, we may still end up in this situation if someone manually tampered with the labels.
  {
    precedence: 1,
    anyPrerequisiteLabels: ["ARMReview"],
    anyRequiredLabels: ["ARMSignedOff"],
    troubleshootingGuide: wrapInArmReviewMessage(
      "❗❗❗ ARM review workflow label is missing! ❗❗❗" +
        "<strong>TO UNBLOCK THIS PR, add <code>/azp run</code> comment to this PR to allow automation to determine where this PR is in the ARM review workflow.</strong>",
    ),
  },
];

/** @type {RequiredLabelRule[]} */
const rulesPri1Suppressions = [
  {
    precedence: 1,
    anyPrerequisiteLabels: ["SuppressionReviewRequired"],
    anyRequiredLabels: ["Approved-Suppression"],
    troubleshootingGuide:
      `The suppressions added to the AutoRest config files (README.mds) require review. ${diagramTsg(1, true)}, ` +
      `or to step 3, depending on the kind of suppression you did.`,
  },
];

/** @type {RequiredLabelRule[]} */
const rulesPri1ArcReview = [
  {
    precedence: 1,
    anyPrerequisiteLabels: ["ArcReview"],
    anyRequiredLabels: ["ArcSignedOff"],
    troubleshootingGuide:
      "This PR is labelled with <code>ArcReview</code>. " +
      "For this PR to be merged, it must pass an ARC review and be labelled <code>ArcSignedOff</code>.<br/>" +
      "Email the ARC board to request review per " +
      `${href(
        "this Contact section",
        "https://msazure.visualstudio.com/One/_wiki/wikis/One.wiki/377428/Consistency-in-ARM-Modeling?anchor=contact",
      )}.`,
  },
];

/**
 * This collection has "SDK breaking changes" labels rules introduced in February 2024.
 * For description of the "SDK breaking changes" labels, see:
 * - https://gist.github.com/raych1/353949d19371b69fb82a10dd70032a51
 * - https://github.com/Azure/azure-sdk-tools/issues/6374#issuecomment-1897379880
 */

/** @type {RequiredLabelRule[]} */
const rulesPri2Sdk = [
  {
    precedence: 2,
    anyPrerequisiteLabels: [sdkLabels["azure-sdk-for-go"].breakingChange],
    anyRequiredLabels: [sdkLabels["azure-sdk-for-go"].breakingChangeApproved],
    troubleshootingGuide:
      `Your PR has breaking changes in the generated SDK for Go (label: <code>${
        sdkLabels["azure-sdk-for-go"].breakingChange
      }</code>). ` + `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: [sdkLabels["azure-sdk-for-js"].breakingChange],
    anyRequiredLabels: [sdkLabels["azure-sdk-for-js"].breakingChangeApproved],
    troubleshootingGuide:
      `Your PR has breaking changes in the generated SDK for JavaScript (label: <code>${
        sdkLabels["azure-sdk-for-js"].breakingChange
      }</code>). ` + `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: [sdkLabels["azure-sdk-for-python"].breakingChange],
    anyRequiredLabels: [sdkLabels["azure-sdk-for-python"].breakingChangeApproved],
    troubleshootingGuide:
      `Your PR has breaking changes in the generated SDK for Python (label: <code>${
        sdkLabels["azure-sdk-for-python"].breakingChange
      }</code>). ` + `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: [sdkLabels["azure-sdk-for-python-track2"].breakingChange],
    anyRequiredLabels: [sdkLabels["azure-sdk-for-python-track2"].breakingChangeApproved],
    troubleshootingGuide:
      `Your PR has breaking changes in the generated SDK for Python track-2 (label: <code>${
        sdkLabels["azure-sdk-for-python-track2"].breakingChange
      }</code>). ` + `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: [sdkLabels["azure-sdk-for-go"].breakingChangeSuppression],
    anyRequiredLabels: [sdkLabels["azure-sdk-for-go"].breakingChangeSuppressionApproved],
    troubleshootingGuide:
      `Your PR modified the suppressions for Go SDK breaking changes (label: ${
        sdkLabels["azure-sdk-for-go"].breakingChangeSuppression
      }).  ` + `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: [sdkLabels["azure-sdk-for-js"].breakingChangeSuppression],
    anyRequiredLabels: [sdkLabels["azure-sdk-for-js"].breakingChangeSuppressionApproved],
    troubleshootingGuide:
      `Your PR modified the suppressions for JavaScript SDK breaking changes (label: ${
        sdkLabels["azure-sdk-for-js"].breakingChangeSuppression
      }).  ` + `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: [sdkLabels["azure-sdk-for-python"].breakingChangeSuppression],
    anyRequiredLabels: [sdkLabels["azure-sdk-for-python"].breakingChangeSuppressionApproved],
    troubleshootingGuide:
      `Your PR modified the suppressions for Python SDK breaking changes (label: ${
        sdkLabels["azure-sdk-for-python"].breakingChangeSuppression
      }).  ` + `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: [sdkLabels["azure-sdk-for-python-track2"].breakingChangeSuppression],
    anyRequiredLabels: [sdkLabels["azure-sdk-for-python-track2"].breakingChangeSuppressionApproved],
    troubleshootingGuide:
      `Your PR modified the suppressions for Python track-2 SDK breaking changes (label: ${
        sdkLabels["azure-sdk-for-python-track2"].breakingChangeSuppression
      }).  ` + `${diagramTsg(3, true)}.`,
  },
];

/**
 * This collection has "legacy" rules that are to be removed once migration to new rules is done.
 * These rules have been marked as "legacy" in February 2024.
 */
/** @type {RequiredLabelRule[]} */
const rulesPri2LegacySdk = [
  // --------------------
  // LEGACY / OBSOLETE RULES
  // To be removed once migration to new rules is done
  // --------------------

  // CODESYNC These CI-BreakingChange-* rules must be in sync with
  // \private\azure-rest-api-specs-pipeline\config\production\Azure\azure-rest-api-specs.yml
  // \private\azure-rest-api-specs-pipeline\config\production\Azure\azure-rest-api-specs-pr.yml
  {
    precedence: 2,
    anyPrerequisiteLabels: ["CI-BreakingChange-Go"],
    anyRequiredLabels: ["Approved-SdkBreakingChange-Go"],
    troubleshootingGuide:
      `Your PR has breaking changes in the generated SDK for go (label: <code>CI-BreakingChange-Go</code>). ` +
      `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: ["CI-BreakingChange-Python-Track2"],
    anyRequiredLabels: ["Approved-SdkBreakingChange-Python"],
    troubleshootingGuide:
      `Your PR has breaking changes in the generated SDK for python (label: <code>CI-BreakingChange-Python-Track2</code>). ` +
      `${diagramTsg(3, true)}.`,
  },
  {
    precedence: 2,
    anyPrerequisiteLabels: ["CI-BreakingChange-JavaScript"],
    anyRequiredLabels: ["Approved-SdkBreakingChange-JavaScript"],
    troubleshootingGuide:
      `Your PR has breaking changes in the generated SDK for javascript (label: <code>CI-BreakingChange-JavaScript</code>). ` +
      `${diagramTsg(3, true)}.`,
  },
];

/** @type {RequiredLabelRule[]} */
const rulesPri3Blockers = [
  {
    precedence: 3,
    anyPrerequisiteLabels: ["Approved-OkToMerge"],
    anyRequiredLabels: [],
    troubleshootingGuide:
      "This PR has been approved with <code>Approved-OkToMerge</code> label.<br/>" +
      "This label should be used only to approve PRs targeting private specs repo <code>main</code> branch.<br/>" +
      "PRs targeting this branch cannot be merged, as this branch is a mirror of the public specs repo <code>main</code> branch.<br/>" +
      "If you want to publish changes in this PR to the public repo, see: " +
      `${href("aka.ms/azsdk/move-pr", "https://aka.ms/azsdk/move-pr")}.<br/>` +
      "If this label was applied erroneously to a different branch than private specs repo <code>main</code> branch, remove the label.",
  },
];

export const requiredLabelsRules = rulesPri0dataPlane
  .concat(rulesPri0NotReadyForArmReview)
  .concat(rulesPri0ArmRpaas)
  .concat(rulesPri0Changes)
  .concat(rulesPri0ArmRev)
  .concat(rulesPri1ArmRev)
  .concat(rulesPri1Suppressions)
  .concat(rulesPri1ArcReview)
  .concat(rulesPri2Sdk)
  .concat(rulesPri2LegacySdk)
  .concat(rulesPri3Blockers);

/**
 * @param {typeof import("@actions/core")} core
 * @param {string} repo
 * @param {string} owner
 * @param {string[]} existingLabels
 * @param {string} targetBranch
 *
 * @returns {Promise<{presentBlockingLabels: string[], missingRequiredLabels: string[]}>}
 */
export async function getPresentBlockingLabelsAndMissingRequiredLabels(
  core,
  repo,
  owner,
  existingLabels,
  targetBranch,
) {
  // this is a little bit of a strange looking branch format, but not going to touch this for now.
  const repoTargetBranch = `${repo}/${targetBranch}`;

  const violatedReqLabelsRules = await getViolatedRequiredLabelsRules(
    core,
    existingLabels,
    repoTargetBranch,
  );
  const presentBlockingLabels = getPresentBlockingLabels(violatedReqLabelsRules);

  const requiredLabelsFromRules = (
    await getViolatedRequiredLabelsRules(core, existingLabels, repoTargetBranch)
  )
    .filter((rule) => rule.anyRequiredLabels.length > 0)
    // See comment on RequiredLabelRule.anyRequiredLabels to understand why we pick [0] from rule.anyRequiredLabels here.
    .map((rule) => rule.anyRequiredLabels[0]);

  // Multiple rules may result in the same label being required, e.g. BreakingChange-Approved-*
  // Deduplicate the array
  const missingRequiredLabels = [...new Set(requiredLabelsFromRules)];

  return { presentBlockingLabels, missingRequiredLabels };
}

/**
 * @param {typeof import("@actions/core")} core
 * @param {string[]} labels
 * @param {string} targetBranch This function uses a special format {repo/branch}, e.g. "azure-rest-api-specs/main".
 * @returns {Promise<RequiredLabelRule[]>}
 */
export async function getViolatedRequiredLabelsRules(core, labels, targetBranch) {
  const violatedRules = [];
  for (const rule of requiredLabelsRules) {
    if (await requiredLabelRuleViolated(core, labels, targetBranch, rule)) {
      violatedRules.push(rule);
    }
  }
  return violatedRules;
}

/**
 * @param {typeof import("@actions/core")} core
 * @param {string[]} presentLabels
 * @param {string} targetBranch
 * @param {RequiredLabelRule} rule
 * @returns {Promise<boolean>}
 */
export async function requiredLabelRuleViolated(core, presentLabels, targetBranch, rule) {
  const branchIsApplicable = rule.branches === undefined || rule.branches.includes(targetBranch);

  const anyPrerequisiteLabelPresent =
    isAnyPrerequisiteLabelsNonempty(rule) &&
    anyLabelMatches(rule.anyPrerequisiteLabels || [], presentLabels);

  const allPrerequisiteLabelsPresent =
    isAllPrerequisiteLabelsNonempty(rule) &&
    (rule.allPrerequisiteLabels || []).every((label) => presentLabels.includes(label));

  const anyPrerequisiteAbsentLabelPresent =
    isAllPrerequisiteAbsentLabelsNonempty(rule) &&
    anyLabelMatches(rule.allPrerequisiteAbsentLabels || [], presentLabels);

  const ruleIsApplicable =
    branchIsApplicable &&
    (anyPrerequisiteLabelPresent || allPrerequisiteLabelsPresent) &&
    !anyPrerequisiteAbsentLabelPresent;

  const anyRequiredLabelPresent = anyLabelMatches(rule.anyRequiredLabels, presentLabels);

  const ruleIsViolated = ruleIsApplicable && !anyRequiredLabelPresent;

  core.debug(
    `RETURN definition requiredLabelRuleViolated: ` +
      `presentLabels: ${[...presentLabels].join(", ")}, ` +
      `targetBranch: ${targetBranch}, ` +
      `rule.precedence: ${rule.precedence}, ` +
      `rule.branches: ${[...(rule.branches ?? [])].join(", ")}, ` +
      `rule.anyPrerequisiteLabels: ${[...(rule.anyPrerequisiteLabels ?? [])].join(", ")}, ` +
      `rule.allPrerequisiteLabels: ${[...(rule.allPrerequisiteLabels ?? [])].join(", ")}, ` +
      `rule.allPrerequisiteAbsentLabels: ${[...(rule.allPrerequisiteAbsentLabels ?? [])].join(", ")}: ` +
      `ruleIsViolated: ${ruleIsViolated}, branchIsApplicable: ${branchIsApplicable}, ` +
      `ruleIsApplicable: ${ruleIsApplicable}, anyRequiredLabelPresent: ${anyRequiredLabelPresent}`,
  );

  return ruleIsViolated;
}

/**
 * @param {RequiredLabelRule[]} violatedReqLabelsRules
 * @returns {string[]}
 */
export function getPresentBlockingLabels(violatedReqLabelsRules) {
  return violatedReqLabelsRules
    .filter((rule) => rule.anyRequiredLabels.length === 0)
    .flatMap((rule) => rule.anyPrerequisiteLabels || []);
}

/**
 * Checks if any label in labelsToMatchAgainst matches any label in inputLabels
 * @param {string[]} labelsToMatchAgainst - Labels to match against (can include prefix patterns ending with *)
 * @param {string[]} inputLabels - Input labels to check
 * @returns {boolean} True if any match is found
 */
export function anyLabelMatches(labelsToMatchAgainst, inputLabels) {
  return getMatchingLabelIfAny(labelsToMatchAgainst, inputLabels) !== undefined;
}

/**
 * Gets the first matching label from labelsToMatchAgainst that matches any label in inputLabels
 * @param {string[]} labelsToMatchAgainst - Labels to match against (can include prefix patterns ending with *)
 * @param {string[]} inputLabels - Input labels to check
 * @returns {string | undefined} The first matching label or undefined if no match
 */
export function getMatchingLabelIfAny(labelsToMatchAgainst, inputLabels) {
  const matchingLabel = labelsToMatchAgainst.find((labelToMatchAgainstStr) => {
    return inputLabels.some((inputLabel) =>
      isEqualToOrPrefixOf(labelToMatchAgainstStr, inputLabel),
    );
  });

  return matchingLabel;
}
/**
 *
 * @param {string} inputstring
 * @param {string} label
 * @returns {boolean}
 */
export function isEqualToOrPrefixOf(inputstring, label) {
  return inputstring.endsWith("*")
    ? label.startsWith(inputstring.slice(0, -1))
    : inputstring === label;
}
