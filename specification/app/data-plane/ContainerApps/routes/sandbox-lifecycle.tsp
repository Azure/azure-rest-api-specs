using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** The HTTP 200 response for the getSandboxesCount operation. */
model GetSandboxesCountResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned sandbox count. */
  @body body: SandboxCountResponse;
}

/** Error responses for the getSandboxesCount operation. */
alias GetSandboxesCountErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** The HTTP 200 response for the getSandboxStats operation. */
model GetSandboxStatsResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned sandbox statistics. */
  @body body: SandboxStatsResponse;
}

/** Error responses for the getSandboxStats operation. */
alias GetSandboxStatsErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** The HTTP 200 response for the postSandboxDisable operation. */
model PostSandboxDisableResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned sandbox. */
  @body body: Sandbox;
}

/** Error responses for the postSandboxDisable operation. */
alias PostSandboxDisableErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for disabling sandboxes. */
alias SandboxDisableOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxDisableErrors
>;

/** The HTTP 200 response for the postSandboxEnable operation. */
model PostSandboxEnableResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned sandbox. */
  @body body: Sandbox;
}

/** Error responses for the postSandboxEnable operation. */
alias PostSandboxEnableErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for enabling sandboxes. */
alias SandboxEnableOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxEnableErrors
>;

/** The HTTP 200 response for the postSandboxExecuteCommand operation. */
model PostSandboxExecuteCommandResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned command result. */
  @body body: SandboxExecuteCommandResponse;
}

/** Error responses for the postSandboxExecuteCommand operation. */
alias PostSandboxExecuteCommandErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for executing sandbox commands. */
alias SandboxExecuteCommandOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxExecuteCommandErrors
>;

/** The HTTP 200 response for the postSandboxExecuteShellCommand operation. */
model PostSandboxExecuteShellCommandResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned shell command result. */
  @body body: SandboxExecuteShellCommandResponse;
}

/** Error responses for the postSandboxExecuteShellCommand operation. */
alias PostSandboxExecuteShellCommandErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for executing sandbox shell commands. */
alias SandboxExecuteShellCommandOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxExecuteShellCommandErrors
>;

/** The HTTP 200 response for the postSandboxLifecycle operation. */
model PostSandboxLifecycleResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned sandbox. */
  @body body: Sandbox;
}

/** Error responses for the postSandboxLifecycle operation. */
alias PostSandboxLifecycleErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for setting sandbox lifecycle policies. */
alias SandboxLifecyclePolicyOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxLifecycleErrors
>;

/** The HTTP 200 response for the postSandboxResume operation. */
model PostSandboxResumeResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned sandbox. */
  @body body: Sandbox;
}

/** Error responses for the postSandboxResume operation. */
alias PostSandboxResumeErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult
  | ServiceUnavailableErrorResult;

/** Shared operation traits for resuming sandboxes. */
alias SandboxResumeOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxResumeErrors
>;

/** The HTTP 200 response for the postSandboxStop operation. */
model PostSandboxStopResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned snapshot. */
  @body body: Snapshot;
}

/** Error responses for the postSandboxStop operation. */
alias PostSandboxStopErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for stopping sandboxes. */
alias SandboxStopOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxStopErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The controller exposes /count and /stats GET routes plus POST actions with operation-specific bodies and results."
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

      /** The sandbox identifier. */
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
      /** The container where the command runs. */
      @query containerName?: string;

      /** The executable, arguments, and execution options. */
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
      /** The container where the shell command runs. */
      @query containerName?: string;

      /** The shell command and execution options. */
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
      /** The automatic suspension and deletion settings. */
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
