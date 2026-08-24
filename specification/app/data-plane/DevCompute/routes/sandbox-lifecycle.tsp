using Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace AzureDevCompute;

/** OK. */
model GetSandboxesCountResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: int32;
}

/** Errors returned by getSandboxesCount. */
alias GetSandboxesCountErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetSandboxesStatsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxStatsResponse;
}

/** Errors returned by getSandboxesStats. */
alias GetSandboxesStatsErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesDisableResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxFields;
}

/** Errors returned by postSandboxesDisable. */
alias PostSandboxesDisableErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesEnableResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxFields;
}

/** Errors returned by postSandboxesEnable. */
alias PostSandboxesEnableErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesExecuteCommandResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxExecuteCommandResponse;
}

/** Errors returned by postSandboxesExecuteCommand. */
alias PostSandboxesExecuteCommandErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesExecuteShellCommandResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxExecuteShellCommandResponse;
}

/** Errors returned by postSandboxesExecuteShellCommand. */
alias PostSandboxesExecuteShellCommandErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
@removed(ApiVersions.v2026_09_01)
model PostSandboxesGenerateSandboxTokenResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxExecutionTokenResponse;
}

/** Service Unavailable. */
@removed(ApiVersions.v2026_09_01)
@error
model PostSandboxesGenerateSandboxTokenError503 {
  /** HTTP response status code. */
  @statusCode statusCode: 503;
}

/** Errors returned by postSandboxesGenerateSandboxToken. */
alias PostSandboxesGenerateSandboxTokenErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody
  | PostSandboxesGenerateSandboxTokenError503;

/** OK. */
model PostSandboxesLifecycleResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxFields;
}

/** Errors returned by postSandboxesLifecycle. */
alias PostSandboxesLifecycleErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesResumeResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxFields;
}

/** Service Unavailable. */
@error
model PostSandboxesResumeError503 {
  /** HTTP response status code. */
  @statusCode statusCode: 503;
}

/** Errors returned by postSandboxesResume. */
alias PostSandboxesResumeErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody
  | PostSandboxesResumeError503;

/** OK. */
model PostSandboxesStopResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SnapshotResponse;
}

/** Errors returned by postSandboxesStop. */
alias PostSandboxesStopErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** Accepted. */
model PostSandboxesStopAsyncResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 202;

  /** Response body. */
  @body body: SandboxFields;
}

/** Errors returned by postSandboxesStopAsync. */
alias PostSandboxesStopAsyncErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** Created. */
@removed(ApiVersions.v2026_09_01)
model PutSandboxesBatchResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: BatchSandboxResponse;
}

/** Errors returned by putSandboxesBatch. */
alias PutSandboxesBatchErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxLifecycleOperations {
  /** Gets the total count of sandboxes. */
  @summary("Gets the total count of sandboxes.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/count")
  @get
  getSandboxesCount is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    GetSandboxesCountResponse,
    DataPlaneStandardTraits,
    GetSandboxesCountErrors
  >;

  /** Gets resource usage statistics for a sandbox. */
  @summary("Gets resource usage statistics for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/stats")
  @get
  getSandboxesStats is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSandboxesStatsResponse,
    DataPlaneStandardTraits,
    GetSandboxesStatsErrors
  >;

  /** Disables a sandbox, stopping it first if it is running. */
  @summary("Disables a sandbox, stopping it first if it is running.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/disable")
  @post
  postSandboxesDisable is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxesDisableResponse,
    DataPlaneStandardTraits,
    PostSandboxesDisableErrors
  >;

  /** Enables a disabled sandbox. */
  @summary("Enables a disabled sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/enable")
  @post
  postSandboxesEnable is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxesEnableResponse,
    DataPlaneStandardTraits,
    PostSandboxesEnableErrors
  >;

  /** Executes a command in a sandbox. */
  @summary("Executes a command in a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/executeCommand")
  @post
  postSandboxesExecuteCommand is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: SandboxExecuteCommandRequest;
    },
    PostSandboxesExecuteCommandResponse,
    DataPlaneStandardTraits,
    PostSandboxesExecuteCommandErrors
  >;

  /** Executes a shell command in a sandbox. */
  @summary("Executes a shell command in a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/executeShellCommand")
  @post
  postSandboxesExecuteShellCommand is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: SandboxExecuteShellCommandRequest;
    },
    PostSandboxesExecuteShellCommandResponse,
    DataPlaneStandardTraits,
    PostSandboxesExecuteShellCommandErrors
  >;

  /** Generates a sandbox execution token. */
  @removed(ApiVersions.v2026_09_01)
  @summary("Generates a sandbox execution token.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/generateSandboxToken")
  @post
  postSandboxesGenerateSandboxToken is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body?: SandboxGenerateTokenRequest;
    },
    PostSandboxesGenerateSandboxTokenResponse,
    DataPlaneStandardTraits,
    PostSandboxesGenerateSandboxTokenErrors
  >;

  /** Sets the lifecycle policy for a sandbox. */
  @summary("Sets the lifecycle policy for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/lifecycle")
  @post
  postSandboxesLifecycle is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: SandboxLifecyclePolicy;
    },
    PostSandboxesLifecycleResponse,
    DataPlaneStandardTraits,
    PostSandboxesLifecycleErrors
  >;

  /** Resumes a stopped sandbox from a snapshot. */
  @summary("Resumes a stopped sandbox from a snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/resume")
  @post
  postSandboxesResume is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body?: SandboxResumeRequest;
    },
    PostSandboxesResumeResponse,
    DataPlaneStandardTraits,
    PostSandboxesResumeErrors
  >;

  /** Stops a running sandbox and saves its state as a snapshot. */
  @summary("Stops a running sandbox and saves its state as a snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/stop")
  @post
  postSandboxesStop is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxesStopResponse,
    DataPlaneStandardTraits,
    PostSandboxesStopErrors
  >;

  /** Non-blocking stop: accepts the request, moves the sandbox to Stopping, and completes the snapshot/suspend asynchronously. Poll GET on the sandbox for Stopping → Stopped | Failed. */
  @summary("Non-blocking stop: accepts the request, moves the sandbox to Stopping, and completes the\nsnapshot/suspend asynchronously.\nPoll GET on the sandbox for Stopping → Stopped | Failed.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/stop/async")
  @post
  postSandboxesStopAsync is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxesStopAsyncResponse,
    DataPlaneStandardTraits,
    PostSandboxesStopAsyncErrors
  >;

  /** Creates multiple sandboxes in a single batch request. */
  @removed(ApiVersions.v2026_09_01)
  @summary("Creates multiple sandboxes in a single batch request.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/batch")
  @put
  putSandboxesBatch is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: BatchSandboxRequest;
    },
    PutSandboxesBatchResponse,
    DataPlaneStandardTraits,
    PutSandboxesBatchErrors
  >;
}
