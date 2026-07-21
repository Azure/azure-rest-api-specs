export type ApiReleaseType = "Private Preview" | "Public Preview" | "GA";

export interface PullRequestChangedFile {
  filename: string;
  status?: string;
}

export interface TypeSpecProjectInfo {
  tspProjectPath: string;
  apiVersion: string;
  isPreview: boolean;
}

export interface CommandResult {
  exitCode: number;
  stdout: string;
  stderr: string;
}

export type AzsdkRunner = (args: string[]) => CommandResult;

export interface ReleasePlanCommandContext {
  prUrl?: string;
  tspProjectPath: string;
  apiReleaseType: ApiReleaseType;
  sdkReleaseType: "beta" | "stable";
  targetMonth: string;
  apiVersion: string;
  testReleasePlan: boolean;
}

export interface ReleasePlanData extends Record<string, unknown> {
  release_plan_link?: string;
  ReleasePlanId?: string | number;
  release_plan_details?: ReleasePlanDetails;
}

export interface SdkInfo {
  Language?: string;
  GenerationPipelineUrl?: string;
  SdkPullRequestUrl?: string;
  PackageName?: string;
  GenerationStatus?: string;
  ReleaseStatus?: string;
  PullRequestStatus?: string;
  ReleaseExclusionStatus?: string;
}

export interface ReleasePlanDetails extends Record<string, unknown> {
  ServiceTreeId?: string;
  ProductTreeId?: string;
  ProductName?: string;
  SpecPullRequests?: string[];
  SDKReleaseMonth?: string;
  ReleasePlanId?: string | number;
  IsManagementPlane?: boolean;
  IsDataPlane?: boolean;
  SpecAPIVersion?: string;
  SpecType?: string;
  ProductType?: string;
  ProductLifecycle?: string;
  ReleasePlanLink?: string;
  IsTestReleasePlan?: boolean;
  SDKReleaseType?: "beta" | "stable";
  SDKInfo?: SdkInfo[];
  ReleasePlanSubmittedByEmail?: string;
  ActiveSpecPullRequest?: string;
  SDKLanguages?: string;
  IsSpecApproved?: boolean;
  ApiSpecWorkItemId?: string | number;
  LanguageExclusionRequesterNote?: string;
  LanguageExclusionApproverNote?: string;
  APISpecProjectPath?: string;
  AttestationStatus?: string;
  ReleasePlanType?: string;
  ApiReleaseType?: string | number;
  WorkItemId?: string | number;
  WorkItemUrl?: string;
  WorkItemHtmlUrl?: string;
  CreatedDate?: string;
  ChangedDate?: string;
  IsCreatedByAgent?: boolean;
  AssignedTo?: string;
  Tag?: string;
  Title?: string;
  ParentId?: string | number;
  Description?: string;
  Status?: string;
  Owner?: string;
}

export interface EnsureReleasePlanResult {
  outcome: "existing_by_pr" | "existing_by_path" | "created" | "not_found";
  releasePlan: ReleasePlanData | null;
  details: {
    prUrl: string;
    tspProjectPath: string;
    apiVersion: string;
    apiReleaseType: ApiReleaseType;
    sdkReleaseType: "beta" | "stable";
    targetReleaseMonth: string;
  };
}

export interface CommitProjectInfoResult {
  projectInfo: TypeSpecProjectInfo | null;
  prNumber?: number;
  hasNewApiVersionLabel: boolean;
  isFolderMigration?: boolean;
}

export interface CliArguments {
  commitSha?: string;
  prNumber?: number;
  owner: string;
  repo: string;
  workspace: string;
  outputFile?: string;
  testReleasePlan: boolean;
}

export interface OctokitLike {
  rest: {
    pulls: {
      get: (params: { owner: string; repo: string; pull_number: number }) => Promise<{
        data: {
          state?: string;
          merged_at?: string | null;
          labels?: Array<{ name: string }>;
        };
      }>;
      listFiles: (params: {
        owner: string;
        repo: string;
        pull_number: number;
        per_page: number;
        page: number;
      }) => Promise<{
        data: Array<{ filename: string; status?: string }>;
      }>;
    };
    repos?: {
      listPullRequestsAssociatedWithCommit: (params: {
        owner: string;
        repo: string;
        commit_sha: string;
      }) => Promise<{
        data: Array<{ number: number }>;
      }>;
      getCommit: (params: { owner: string; repo: string; ref: string }) => Promise<{
        data: {
          files?: Array<{ filename: string; status?: string }>;
        };
      }>;
    };
    issues?: {
      createComment: (params: {
        owner: string;
        repo: string;
        issue_number: number;
        body: string;
      }) => Promise<unknown>;
    };
  };
}
