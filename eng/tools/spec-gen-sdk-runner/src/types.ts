import { SdkName } from "@azure-tools/specs-shared/sdk-types";

/**
 * SDK automation execution state.
 * Matches SDKAutomationState from spec-gen-sdk.
 *
 * - pending: The generation process has not yet begun.
 * - inProgress: The generation process is in-progress.
 * - failed: The generation process has failed.
 * - succeeded: The generation process has succeeded.
 * - warning: The generation process has warnings.
 * - notEnabled: The generation process exited due to missing language configuration.
 */
export type ExecutionResult =
  | "pending"
  | "inProgress"
  | "failed"
  | "succeeded"
  | "warning"
  | "notEnabled";

/**
 * Represents a package entry in the execution report.
 */
export interface ExecutionReportPackage {
  packageName?: string;
  installationInstructions?: string;
  apiViewArtifact?: string;
  shouldLabelBreakingChange?: boolean;
}

/**
 * Represents the execution report from spec-gen-sdk command.
 */
export interface ExecutionReport {
  packages: ExecutionReportPackage[];
  executionResult: ExecutionResult;
  fullLogPath?: string;
  filteredLogPath?: string;
  vsoLogPath?: string;
  stagedArtifactsFolder?: string;
  sdkArtifactFolder?: string;
  sdkApiViewArtifactFolder?: string;
  isSdkConfigDuplicated?: boolean;
  generateFromTypeSpec?: boolean;
}

/**
 * Represents the input parameters required for spec-gen-sdk command execution.
 */
export interface SpecGenSdkCmdInput {
  workingFolder: string;
  runMode: string;
  localSpecRepoPath: string;
  localSdkRepoPath: string;
  tspConfigPath?: string;
  readmePath?: string;
  sdkRepoName: string;
  sdkLanguage: SdkName;
  apiVersion?: string;
  prNumber?: string;
  sdkReleaseType?: string;
  specCommitSha: string;
  specRepoHttpsUrl: string;
  headRepoHttpsUrl?: string;
  headBranch?: string;
}

/*
 * VsoLogs is a map of task names to log entries. Each log entry contains an array of errors and warnings.
 */
export type VsoLogs = Map<
  string,
  {
    errors?: string[];
    warnings?: string[];
  }
>;

/**
 * Represents the plane types for SDK generation settings
 */
export interface PlaneTypeSettings {
  /**
   * Whether spec-gen-sdk check is required for data plane
   */
  dataPlane: boolean;

  /**
   * Whether spec-gen-sdk check is required for management plane
   */
  managementPlane: boolean;
}

/**
 * Required check settings for all languages.
 */
export const SpecGenSdkRequiredSettings: Record<SdkName, PlaneTypeSettings> = {
  "azure-sdk-for-go": {
    dataPlane: true,
    managementPlane: true,
  },
  "azure-sdk-for-java": {
    dataPlane: true,
    managementPlane: true,
  },
  "azure-sdk-for-js": {
    dataPlane: true,
    managementPlane: true,
  },
  "azure-sdk-for-net": {
    dataPlane: false,
    managementPlane: true,
  },
  "azure-sdk-for-python": {
    dataPlane: true,
    managementPlane: true,
  },
};
