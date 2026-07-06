import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

// A JSON object whose schema is supplied at runtime by each RL environment.
// Observations, actions, info, metadata, health, and schema payloads are all
// environment-defined and therefore modeled as open records.
alias RLEJsonObject = Record<unknown>;

// ============================================================================
// Environments
// ============================================================================

@doc("A hosted reinforcement-learning environment that sandboxes are leased from.")
@resource("environments")
model RLEnvironment {
  @doc("Hosted RLE environment identifier, assigned by the service.")
  @key("environmentId")
  @visibility(Lifecycle.Read)
  environmentId: string;

  @doc("Foundry project identifier that owns this environment.")
  @visibility(Lifecycle.Read)
  projectId: string;

  @doc("Caller-provided display name for the environment. Optional on create.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Container image reference (Azure Container Registry path) that backs the environment.")
  @visibility(Lifecycle.Read)
  acrImagePath: string;

  @doc("Latest version identifier for the environment image.")
  @visibility(Lifecycle.Read)
  version: string;

  @doc("Timestamp the environment was first created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAtUtc: utcDateTime;

  @doc("Timestamp the environment was last updated, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAtUtc: utcDateTime;
}

@doc("Request body for creating a hosted RLE environment.")
model CreateRLEnvironmentRequest {
  @doc("Optional caller-provided display name for the environment.")
  name?: string;

  @doc("Container image reference (Azure Container Registry path) that backs the environment.")
  acrImagePath: string;
}

@doc("Request body for updating a hosted RLE environment. Produces a new version.")
model UpdateRLEnvironmentRequest {
  @doc("New container image reference (Azure Container Registry path) for the environment.")
  acrImagePath: string;
}

@doc("A historical version snapshot of a hosted RLE environment.")
model RLEnvironmentVersion {
  @doc("Identifier of the parent RLE environment.")
  environmentId: string;

  @doc("Foundry project identifier that owns the parent environment.")
  projectId: string;

  @doc("Version identifier for this snapshot.")
  version: string;

  @doc("Container image reference (Azure Container Registry path) for this version.")
  acrImagePath: string;

  @doc("Timestamp this version was created, in UTC.")
  createdAtUtc: utcDateTime;
}

@doc("Paged list response of hosted RLE environments.")
model ListRLEnvironmentsResponse {
  @doc("Environments on this page.")
  @pageItems
  value: RLEnvironment[];

  @doc("Number of environments returned on this page.")
  count: int32;
}

@doc("Paged list response of historical environment versions.")
model ListRLEnvironmentVersionsResponse {
  @doc("Environment versions on this page.")
  @pageItems
  value: RLEnvironmentVersion[];

  @doc("Number of versions returned on this page.")
  count: int32;
}

// ============================================================================
// Sandboxes
// ============================================================================

@doc("Lifecycle status of an RLE sandbox.")
union RLSandboxStatus {
  string,

  @doc("RLSandbox is being provisioned.")
  creating: "Creating",

  @doc("RLSandbox is ready to accept runtime requests at `url`.")
  running: "Running",

  @doc("RLSandbox is stopped but retained and may be resumed.")
  stopped: "Stopped",

  @doc("RLSandbox has been released and can no longer be used.")
  released: "Released",

  @doc("RLSandbox entered a terminal failure state. See `error` for details.")
  failed: "Failed",
}

@doc("A sandbox leased from a hosted RLE environment.")
@parentResource(RLEnvironment)
@resource("sandboxes")
model RLSandbox {
  @doc("RLSandbox identifier, assigned by the service.")
  @key("sandboxId")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  sandboxId: string;

  @doc("Foundry project identifier that owns the sandbox.")
  @visibility(Lifecycle.Read)
  projectId: string;

  @doc("Identifier of the parent RLE environment from which the sandbox was leased.")
  @visibility(Lifecycle.Read)
  environmentId: string;

  @doc("Environment image version the sandbox is running.")
  @visibility(Lifecycle.Read)
  version: string;

  @doc("Identifier of the disk image backing the sandbox.")
  @visibility(Lifecycle.Read)
  diskImageId: string;

  @doc("Underlying ADC sandbox identifier, when one has been provisioned.")
  @visibility(Lifecycle.Read)
  adcSandboxId?: string;

  @doc("Base URL for the sandbox runtime API. Present once the sandbox is `Running`.")
  @visibility(Lifecycle.Read)
  url?: string;

  @doc("""
    RLSandbox lifecycle status. The SDK treats `Running` as ready and `Failed` as
    failed; `Stopped` is a non-terminal pause and `Released` is terminal.
    """)
  @visibility(Lifecycle.Read)
  status: RLSandboxStatus;

  @doc("Failure detail when the sandbox enters a failed state.")
  @visibility(Lifecycle.Read)
  error?: string;

  @doc("Timestamp the sandbox was first leased, in UTC.")
  @visibility(Lifecycle.Read)
  createdAtUtc: utcDateTime;

  @doc("Timestamp the sandbox was last updated, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAtUtc: utcDateTime;
}

@doc("Request body for leasing a new sandbox from an RLE environment.")
model CreateRLSandboxRequest {
  @doc("Optional environment image version to lease. Defaults to the latest version.")
  version?: string;

  @doc("Requested CPU allocation. Encoded as a string (e.g. \"1\", \"2\", \"500m\").")
  cpu?: string;

  @doc("Requested memory allocation, for example \"2Gi\".")
  memory?: string;

  @doc("Requested disk allocation, for example \"10Gi\".")
  disk?: string;

  @doc("Environment variables to inject into the sandbox.")
  envVars?: Record<string>;
}

@doc("Paged list response of leased sandboxes for an environment.")
model ListRLSandboxesResponse {
  @doc("Sandboxes on this page.")
  @pageItems
  value: RLSandbox[];

  @doc("Number of sandboxes returned on this page.")
  count: int32;
}

// ============================================================================
// Runtime (data-plane) request and response shapes
// ============================================================================

@doc("Request body for starting or restarting an RLE environment episode.")
model RLResetRequest {
  @doc("Optional deterministic seed for the next episode.")
  seed?: int32;

  @doc("Optional caller-provided episode identifier.")
  episodeId?: string;
}

@doc("Request body for applying an action to the current RLE episode.")
model RLStepRequest {
  @doc("Environment-specific action payload.")
  action: RLEJsonObject;
}

@doc("Outcome returned by RLE `reset` and `step` in the OpenEnv / Gymnasium wire shape.")
model RLStepResult {
  @doc("Environment-specific observation payload.")
  observation?: RLEJsonObject;

  @doc("Reward for the transition, when the environment provides one.")
  reward?: float64;

  @doc("True when the episode reached a natural terminal state.")
  terminated?: boolean;

  @doc("True when an external limit ended the episode.")
  truncated?: boolean;

  @doc("Legacy single terminal flag. New payloads should prefer `terminated` and `truncated`.")
  done?: boolean;

  @doc("Gymnasium info payload.")
  info?: RLEJsonObject;

  @doc("Legacy metadata payload. The SDK maps it to `info` when `info` is absent.")
  metadata?: RLEJsonObject;
}

@doc("Snapshot returned by the RLE environment `state` endpoint.")
model RLEnvironmentState {
  @doc("Current episode identifier, when one is active.")
  episodeId?: string;

  @doc("Number of completed steps in the current episode.")
  stepCount?: int32;
}
