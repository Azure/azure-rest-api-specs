using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** OK. */
model GetSandboxesCountResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: int32;
}

/** Errors returned by getSandboxesCount. */
alias GetSandboxesCountErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetSandboxStatsResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxStatsResult;
}

/** Errors returned by getSandboxStats. */
alias GetSandboxStatsErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PostSandboxDisableResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Sandbox;
}

/** Errors returned by postSandboxDisable. */
alias PostSandboxDisableErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PostSandboxEnableResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Sandbox;
}

/** Errors returned by postSandboxEnable. */
alias PostSandboxEnableErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model PostSandboxExecuteCommandResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxExecuteCommand;
}

/** Errors returned by postSandboxExecuteCommand. */
alias PostSandboxExecuteCommandErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model PostSandboxExecuteShellCommandResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxExecuteShellCommandResult;
}

/** Errors returned by postSandboxExecuteShellCommand. */
alias PostSandboxExecuteShellCommandErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PostSandboxLifecycleResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Sandbox;
}

/** Errors returned by postSandboxLifecycle. */
alias PostSandboxLifecycleErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model PostSandboxResumeResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Sandbox;
}

/** Service Unavailable. */
@error
model PostSandboxResumeError503 {
  /** HTTP response status code. */
  @statusCode statusCode: 503;
}

/** Errors returned by postSandboxResume. */
alias PostSandboxResumeErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>
  | PostSandboxResumeError503;

/** OK. */
model PostSandboxStopResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Snapshot;
}

/** Errors returned by postSandboxStop. */
alias PostSandboxStopErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** Accepted. */
model PostSandboxStopAsyncResult {
  /** HTTP response status code. */
  @statusCode statusCode: 202;

  /** Response body. */
  @body body: Sandbox;
}

/** Errors returned by postSandboxStopAsync. */
alias PostSandboxStopAsyncErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

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
    GetSandboxesCountResult,
    DataPlaneStandardTraits,
    GetSandboxesCountErrors
  >;

  /** Gets resource usage statistics for a sandbox. */
  @summary("Gets resource usage statistics for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/stats")
  @get
  getSandboxStats is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSandboxStatsResult,
    DataPlaneStandardTraits,
    GetSandboxStatsErrors
  >;

  /** Disables a sandbox, stopping it first if it is running. */
  @summary("Disables a sandbox, stopping it first if it is running.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/disable")
  @post
  postSandboxDisable is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxDisableResult,
    DataPlaneStandardTraits,
    PostSandboxDisableErrors
  >;

  /** Enables a disabled sandbox. */
  @summary("Enables a disabled sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/enable")
  @post
  postSandboxEnable is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxEnableResult,
    DataPlaneStandardTraits,
    PostSandboxEnableErrors
  >;

  /** Executes a command in a sandbox. */
  @summary("Executes a command in a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/executeCommand")
  @post
  postSandboxExecuteCommand is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: SandboxExecuteCommandContent;
    },
    PostSandboxExecuteCommandResult,
    DataPlaneStandardTraits,
    PostSandboxExecuteCommandErrors
  >;

  /** Executes a shell command in a sandbox. */
  @summary("Executes a shell command in a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/executeShellCommand")
  @post
  postSandboxExecuteShellCommand is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: SandboxExecuteShellCommandContent;
    },
    PostSandboxExecuteShellCommandResult,
    DataPlaneStandardTraits,
    PostSandboxExecuteShellCommandErrors
  >;

  /** Sets the lifecycle policy for a sandbox. */
  @summary("Sets the lifecycle policy for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/lifecycle")
  @post
  postSandboxLifecycle is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: SandboxLifecyclePolicy;
    },
    PostSandboxLifecycleResult,
    DataPlaneStandardTraits,
    PostSandboxLifecycleErrors
  >;

  /** Resumes a stopped sandbox from a snapshot. */
  @summary("Resumes a stopped sandbox from a snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/resume")
  @post
  postSandboxResume is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxResumeResult,
    DataPlaneStandardTraits,
    PostSandboxResumeErrors
  >;

  /** Stops a running sandbox and saves its state as a snapshot. */
  @summary("Stops a running sandbox and saves its state as a snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/stop")
  @post
  postSandboxStop is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxStopResult,
    DataPlaneStandardTraits,
    PostSandboxStopErrors
  >;

  /** Non-blocking stop: accepts the request, moves the sandbox to Stopping, and completes the snapshot/suspend asynchronously. Poll GET on the sandbox for Stopping → Stopped | Failed. */
  @summary("Non-blocking stop: accepts the request, moves the sandbox to Stopping, and completes the\nsnapshot/suspend asynchronously.\nPoll GET on the sandbox for Stopping → Stopped | Failed.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/stop/async")
  @post
  postSandboxStopAsync is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    PostSandboxStopAsyncResult,
    DataPlaneStandardTraits,
    PostSandboxStopAsyncErrors
  >;
}
