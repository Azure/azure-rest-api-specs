import { OadMessageProcessorContext } from "../utils/oad-message-processor.js";
import { PullRequestProperties } from "../utils/pull-request.js";

/**
 * This file contains types used by the OpenAPI specification breaking change checks
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

export type BreakingChangesCheckType = "SameVersion" | "CrossVersion";
export type SpecsBreakingChangesLabel =
  | ReviewRequiredLabel
  | ReviewApprovalPrefixLabel
  | ValidBreakingChangeApproval
  | ValidVersioningApproval;

export const BreakingChangeReviewRequiredLabel = "BreakingChangeReviewRequired";
export const VersioningReviewRequiredLabel = "VersioningReviewRequired";
export type ReviewRequiredLabel =
  | typeof BreakingChangeReviewRequiredLabel
  | typeof VersioningReviewRequiredLabel;
export type ReviewApprovalPrefixLabel = "Versioning-Approved-*" | "BreakingChange-Approved-*";

export type ValidVersioningApproval =
  | "Versioning-Approved-Benign"
  | "Versioning-Approved-BugFix"
  | "Versioning-Approved-PrivatePreview"
  | "Versioning-Approved-BranchPolicyException"
  | "Versioning-Approved-Previously"
  | "Versioning-Approved-Retired";

export type ValidBreakingChangeApproval =
  | "BreakingChange-Approved-Benign"
  | "BreakingChange-Approved-BugFix"
  | "BreakingChange-Approved-UserImpact"
  | "BreakingChange-Approved-BranchPolicyException"
  | "BreakingChange-Approved-Previously"
  | "BreakingChange-Approved-Security";

/** Corresponds to specs in "*\preview\*" or "*\stable\*" directories in the specs repos.
 * Scheduled to replace type SwaggerVersionType and type ComparedApiVersion.
 * Read more at https://aka.ms/azsdk/spec-dirs
 */
export type ApiVersionLifecycleStage = "preview" | "stable";

/**
 * Represents the input parameters for runner execution.
 */
export interface Context {
  localSpecRepoPath: string;
  workingFolder: string;
  logFileFolder: string;
  swaggerDirs: string[];
  baseBranch: string;
  headCommit: string;
  runType: BreakingChangesCheckType;
  checkName: string;
  repo: string; // The format is: "owner/repoName"
  prNumber: string;
  prSourceBranch: string;
  prTargetBranch: string;
  oadMessageProcessorContext: OadMessageProcessorContext;
  prUrl: string;
  prInfo?: PullRequestProperties;
}
