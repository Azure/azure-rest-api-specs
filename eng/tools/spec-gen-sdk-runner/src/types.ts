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

/**
 * Data for the API view request.
 */
export interface APIViewRequestData {
  packageName: string;
  filePath: string;
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
  language: string;
  result: string;
  prNumber?: string;
  labelAction?: boolean;
  isSpecGenSdkCheckRequired: boolean;
  apiViewRequestData: APIViewRequestData[];
}

/**
 * Represents supported SDK language identifiers.
 */
export type SdkName =
  | "azure-sdk-for-go"
  | "azure-sdk-for-java"
  | "azure-sdk-for-js"
  | "azure-sdk-for-net"
  | "azure-sdk-for-python";

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
    dataPlane: false,
    managementPlane: true,
  },
  "azure-sdk-for-js": {
    dataPlane: false,
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
