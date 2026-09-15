using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** OK. */
model GetSandboxesCountResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxCountResponse;
}

/** Errors returned by getSandboxesCount. */
alias GetSandboxesCountErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetSandboxStatsResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxStatsResponse;
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

/** Standard resource operations for disabling sandboxes. */
alias SandboxDisableOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxDisableErrors
>;

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

/** Standard resource operations for enabling sandboxes. */
alias SandboxEnableOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxEnableErrors
>;

/** OK. */
model PostSandboxExecuteCommandResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxExecuteCommandResponse;
}

/** Errors returned by postSandboxExecuteCommand. */
alias PostSandboxExecuteCommandErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Standard resource operations for executing sandbox commands. */
alias SandboxExecuteCommandOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxExecuteCommandErrors
>;

/** OK. */
model PostSandboxExecuteShellCommandResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxExecuteShellCommandResponse;
}

/** Errors returned by postSandboxExecuteShellCommand. */
alias PostSandboxExecuteShellCommandErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** Standard resource operations for executing sandbox shell commands. */
alias SandboxExecuteShellCommandOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxExecuteShellCommandErrors
>;

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

/** Standard resource operations for setting sandbox lifecycle policies. */
alias SandboxLifecyclePolicyOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxLifecycleErrors
>;

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

/** Standard resource operations for resuming sandboxes. */
alias SandboxResumeOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxResumeErrors
>;

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

/** Standard resource operations for stopping sandboxes. */
alias SandboxStopOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxStopErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
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
      @path id: SandboxId;
    },
    GetSandboxStatsResult,
    DataPlaneStandardTraits,
    GetSandboxStatsErrors
  >;

  /** Disables a sandbox, stopping it first if it is running. */
  @summary("Disables a sandbox, stopping it first if it is running.")
  @action("disable")
  @actionSeparator("/")
  postSandboxDisable is SandboxDisableOperations.ResourceAction<
    Sandbox,
    {},
    PostSandboxDisableResult
  >;

  /** Enables a disabled sandbox. */
  @summary("Enables a disabled sandbox.")
  @action("enable")
  @actionSeparator("/")
  postSandboxEnable is SandboxEnableOperations.ResourceAction<
    Sandbox,
    {},
    PostSandboxEnableResult
  >;

  /** Executes a command in a sandbox. */
  @summary("Executes a command in a sandbox.")
  @action("executeCommand")
  @actionSeparator("/")
  postSandboxExecuteCommand is SandboxExecuteCommandOperations.ResourceAction<
    Sandbox,
    {
      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: ExecuteSandboxCommandContent;
    },
    PostSandboxExecuteCommandResult
  >;

  /** Executes a shell command in a sandbox. */
  @summary("Executes a shell command in a sandbox.")
  @action("executeShellCommand")
  @actionSeparator("/")
  postSandboxExecuteShellCommand is SandboxExecuteShellCommandOperations.ResourceAction<
    Sandbox,
    {
      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: ExecuteSandboxShellCommandContent;
    },
    PostSandboxExecuteShellCommandResult
  >;

  /** Sets the lifecycle policy for a sandbox. */
  @summary("Sets the lifecycle policy for a sandbox.")
  @action("lifecycle")
  @actionSeparator("/")
  postSandboxLifecycle is SandboxLifecyclePolicyOperations.ResourceAction<
    Sandbox,
    {
      /** Request body. */
      @body body: SandboxLifecyclePolicy;
    },
    PostSandboxLifecycleResult
  >;

  /** Resumes a stopped sandbox from a snapshot. */
  @summary("Resumes a stopped sandbox from a snapshot.")
  @action("resume")
  @actionSeparator("/")
  postSandboxResume is SandboxResumeOperations.ResourceAction<
    Sandbox,
    {},
    PostSandboxResumeResult
  >;

  /** Stops a running sandbox and saves its state as a snapshot. */
  @summary("Stops a running sandbox and saves its state as a snapshot.")
  @action("stop")
  @actionSeparator("/")
  postSandboxStop is SandboxStopOperations.ResourceAction<
    Sandbox,
    {},
    PostSandboxStopResult
  >;
}
