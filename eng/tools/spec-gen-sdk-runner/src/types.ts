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
  sdkLanguage: string;
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
 * Represents the result of the spec-gen-sdk generation process.
 */
export interface SpecGenSdkArtifactInfo {
  managementPlane: boolean;
  dataPlane: boolean;
  language?: string;
  labelAction?: boolean;
  isSpecGenSdkCheckRequired?: boolean;
}
