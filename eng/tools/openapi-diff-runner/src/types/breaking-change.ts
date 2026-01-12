import {
  BREAKING_CHANGE_APPROVALS,
  BREAKING_CHANGES_CHECK_TYPES,
  REVIEW_REQUIRED_LABELS,
  VERSIONING_APPROVALS,
} from "@azure-tools/specs-shared/breaking-change";
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

// Derive TypeScript types from the JavaScript constants
export type BreakingChangesCheckType =
  (typeof BREAKING_CHANGES_CHECK_TYPES)[keyof typeof BREAKING_CHANGES_CHECK_TYPES];

// Export the constant values for use in TypeScript
export const BreakingChangeReviewRequiredLabel = REVIEW_REQUIRED_LABELS.BREAKING_CHANGE;
export const VersioningReviewRequiredLabel = REVIEW_REQUIRED_LABELS.VERSIONING;

// Derive types from constants
export type ReviewRequiredLabel =
  (typeof REVIEW_REQUIRED_LABELS)[keyof typeof REVIEW_REQUIRED_LABELS];
export type ValidVersioningApproval =
  (typeof VERSIONING_APPROVALS)[keyof typeof VERSIONING_APPROVALS];
export type ValidBreakingChangeApproval =
  (typeof BREAKING_CHANGE_APPROVALS)[keyof typeof BREAKING_CHANGE_APPROVALS];
export type ReviewApprovalPrefixLabel = "Versioning-Approved-*" | "BreakingChange-Approved-*";

export type SpecsBreakingChangesLabel =
  | ReviewRequiredLabel
  | ReviewApprovalPrefixLabel
  | ValidBreakingChangeApproval
  | ValidVersioningApproval;

/** Corresponds to specs in "*\preview\*" or "*\stable\*" directories in the specs repos.
 * Scheduled to replace type SwaggerVersionType and type ComparedApiVersion.
 * Read more at https://aka.ms/azsdk/spec-dirs
 */
export enum ApiVersionLifecycleStage {
  PREVIEW = "preview",
  STABLE = "stable",
}

/** The name of the log file used by the openapi-diff-runner utility. */
export const logFileName = "openapi-diff-runner.log";

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
  targetRepo: string; // The format is: "owner/repoName"
  sourceRepo: string; // The format is: "owner/repoName"
  prNumber: string;
  prSourceBranch: string;
  prTargetBranch: string;
  oadMessageProcessorContext: OadMessageProcessorContext;
  prUrl: string;
  prInfo?: PullRequestProperties;
}
