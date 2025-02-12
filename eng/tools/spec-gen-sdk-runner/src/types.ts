/**
 * Represents the input parameters required for spec-gen-sdk command execution.
 */
export interface SpecGenSdkCmdInput {
  workingFolder: string;
  isTriggeredByPipeline: string;
  localSpecRepoPath: string;
  localSdkRepoPath: string;
  tspConfigPath?: string;
  readmePath?: string;
  sdkRepoName: string;
  apiVersion?: string;
  prNumber?: string;
  specCommitSha: string;
  specRepoHttpsUrl: string;
  headRepoHttpsUrl?: string;
  headBranch?: string;
}
