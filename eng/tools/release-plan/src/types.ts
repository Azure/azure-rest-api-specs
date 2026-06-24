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
  sdkReleaseType: "preview" | "stable";
  targetMonth: string;
  apiVersion: string;
  testReleasePlan: boolean;
}

export interface ReleasePlanData extends Record<string, unknown> {
  release_plan_link?: string;
  ReleasePlanId?: string | number;
}

export interface EnsureReleasePlanResult {
  outcome: "existing_by_pr" | "existing_by_path" | "created" | "not_found";
  releasePlan: ReleasePlanData | null;
  details: {
    prUrl: string;
    tspProjectPath: string;
    apiVersion: string;
    apiReleaseType: ApiReleaseType;
    sdkReleaseType: "preview" | "stable";
    targetReleaseMonth: string;
  };
}

export interface CommitProjectInfoResult {
  projectInfo: TypeSpecProjectInfo | null;
  prNumber?: number;
  hasNewApiVersionLabel: boolean;
}

export interface CliArguments {
  commitSha?: string;
  owner: string;
  repo: string;
  workspace: string;
  azsdkPath?: string;
  outputFile?: string;
  testReleasePlan: boolean;
}

export interface OctokitLike {
  rest: {
    pulls: {
      get: (params: { owner: string; repo: string; pull_number: number }) => Promise<{
        data: {
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
