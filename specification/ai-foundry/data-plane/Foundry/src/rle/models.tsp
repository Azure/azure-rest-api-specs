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

@doc("Status of the asynchronous ACR image to disk image conversion. Serialized as its string name.")
union RLEnvironmentDiskImageConversionStatus {
  string,

  @doc("Disk image conversion has not been requested for this environment yet.")
  notRequested: "NotRequested",

  @doc("Disk image conversion is in progress.")
  pending: "Pending",

  @doc("Disk image conversion completed successfully and the disk image is ready for use.")
  ready: "Ready",

  @doc("Disk image conversion failed. See `diskImageConversionError` for details.")
  failed: "Failed",
}

@doc("Semantic-version component to bump when creating a new version of an existing RLE environment.")
union RLEnvironmentVersionBump {
  string,

  @doc("Increment the major version component.")
  major: "Major",

  @doc("Increment the minor version component.")
  minor: "Minor",

  @doc("Increment the patch version component.")
  patch: "Patch",
}

@doc("Sort order for opaque cursor pagination.")
union RLEPaginationOrder {
  string,

  @doc("Ascending order.")
  asc: "asc",

  @doc("Descending order.")
  desc: "desc",
}

@doc("A hosted reinforcement-learning environment that instances are leased from.")
@resource("environments")
model RLEnvironment {
  @doc("Hosted RLE environment identifier, assigned by the service.")
  @key("environmentId")
  @encodedName("application/json", "id")
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

  @doc("Status of the asynchronous conversion from the ACR container image to a disk image usable by leased instances.")
  @visibility(Lifecycle.Read)
  diskImageConversionStatus: RLEnvironmentDiskImageConversionStatus;

  @doc("Error details from the most recent disk image conversion attempt, when `diskImageConversionStatus` is `Failed`.")
  @visibility(Lifecycle.Read)
  diskImageConversionError?: string;

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

  @doc("Optional semantic-version bump to apply when a new version of an existing environment is created. Defaults to a patch bump when omitted.")
  versionBump?: RLEnvironmentVersionBump;
}

@doc("Response for listing hosted RLE environments, using opaque cursor pagination.")
model ListRLEnvironmentsResponse {
  @doc("Environments on this page.")
  data: RLEnvironment[];

  @doc("Opaque cursor of the first item on this page, for paging backward.")
  @encodedName("application/json", "first_id")
  firstId?: string;

  @doc("Opaque cursor of the last item on this page, for paging forward.")
  @encodedName("application/json", "last_id")
  lastId?: string;

  @doc("True when more environments are available beyond this page.")
  @encodedName("application/json", "has_more")
  hasMore: boolean;
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

@doc("Response for listing versions of a hosted RLE environment, using opaque cursor pagination.")
model ListRLEnvironmentVersionsResponse {
  @doc("Environment versions on this page.")
  data: RLEnvironmentVersion[];

  @doc("Opaque cursor of the first item on this page, for paging backward.")
  @encodedName("application/json", "first_id")
  firstId?: string;

  @doc("Opaque cursor of the last item on this page, for paging forward.")
  @encodedName("application/json", "last_id")
  lastId?: string;

  @doc("True when more versions are available beyond this page.")
  @encodedName("application/json", "has_more")
  hasMore: boolean;
}

// ============================================================================
// Instance groups
// ============================================================================

@doc("Forward-compatible resource allocation hints for an instance group. Recorded but not scheduled against in this version.")
model RLEInstanceGroupResourceProfile {
  @doc("Requested CPU allocation hint, encoded as a string (e.g. \"1\", \"2\", \"500m\").")
  cpu?: string;

  @doc("Requested memory allocation hint, for example \"2Gi\".")
  memory?: string;

  @doc("Requested disk allocation hint, for example \"10Gi\".")
  disk?: string;
}

@doc("""
  A first-class group of RLE instances leased for a single reinforcement-learning
  training job. Created under a specific version of a registered environment; the
  environment name and version are carried in the request URI.
  """)
@parentResource(RLEnvironment)
@resource("instance_groups")
model RLEInstanceGroup {
  @doc("Instance group identifier, assigned by the service.")
  @key("instanceGroupId")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  instanceGroupId: string;

  @doc("Foundry project identifier that owns this instance group.")
  @visibility(Lifecycle.Read)
  projectId: string;

  @doc("Name of the registered RLE environment the group's instances are leased from.")
  @visibility(Lifecycle.Read)
  environmentName: string;

  @doc("Version of the registered RLE environment the group's instances are leased from.")
  @visibility(Lifecycle.Read)
  environmentVersion: string;

  @doc("Maximum number of concurrently-active instances the group may hold. Defaults to 1 when omitted on create.")
  @visibility(Lifecycle.Read)
  maxActiveInstances: int32;

  @doc("""
    Free-form correlation/tag key-values, persisted opaquely by RLE and echoed on
    responses. `external_job_id` is a reserved well-known key that carries the
    upstream Training API job / AML run this group backs.
    """)
  metadata?: Record<string>;

  @doc("Forward-compatible resource allocation hints. Recorded but not scheduled against in this version.")
  resourceProfile?: RLEInstanceGroupResourceProfile;

  @doc("Timestamp the instance group was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAtUtc: utcDateTime;

  @doc("Timestamp the instance group was last updated, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAtUtc: utcDateTime;
}

@doc("Request body for creating an RLE instance group. The environment name and version are supplied in the request URI.")
model CreateRLEInstanceGroupRequest {
  @doc("Maximum number of concurrently-active instances the group may hold. Optional; defaults to 1 when omitted.")
  maxActiveInstances?: int32;

  @doc("Optional free-form correlation/tag key-values. `external_job_id` is a reserved well-known key for the upstream Training API job / AML run.")
  metadata?: Record<string>;

  @doc("Optional forward-compatible resource allocation hints. Recorded only in this version.")
  resourceProfile?: RLEInstanceGroupResourceProfile;
}

@doc("Response for listing RLE instance groups, using opaque cursor pagination.")
model ListRLEInstanceGroupsResponse {
  @doc("Instance groups on this page.")
  data: RLEInstanceGroup[];

  @doc("Opaque cursor of the first item on this page, for paging backward.")
  @encodedName("application/json", "first_id")
  firstId?: string;

  @doc("Opaque cursor of the last item on this page, for paging forward.")
  @encodedName("application/json", "last_id")
  lastId?: string;

  @doc("True when more instance groups are available beyond this page.")
  @encodedName("application/json", "has_more")
  hasMore: boolean;
}

// ============================================================================
// Instances
// ============================================================================

@doc("Runtime status of an RLE instance, as observed by RLE from the backing runtime.")
union RLEInstanceStatus {
  string,

  @doc("The backing runtime is being provisioned.")
  creating: "Creating",

  @doc("The instance is up and serving data-plane calls.")
  running: "Running",

  @doc("The instance's task finished and RLE stopped the backing runtime.")
  stopped: "Stopped",

  @doc("The instance errored during provisioning or at runtime. See `error` for details.")
  failed: "Failed",

  @doc("The backing runtime has been torn down / removed.")
  deleted: "Deleted",
}

@doc("""
  A leased runtime unit owned by an RLE instance group (replaces the former
  "sandbox" concept). Combines the owning instance-group identity, the runtime
  identity, runtime status, and the base URL used to reach its data-plane
  (OpenEnv) endpoints.
  """)
@parentResource(RLEInstanceGroup)
@resource("instances")
model RLEInstance {
  @doc("Instance identifier, assigned by the service. Globally unique.")
  @key("instanceId")
  @visibility(Lifecycle.Read)
  instanceId: string;

  @doc("Identifier of the owning RLE instance group.")
  @visibility(Lifecycle.Read)
  instanceGroupId: string;

  @doc("Runtime status of the instance.")
  @visibility(Lifecycle.Read)
  status: RLEInstanceStatus;

  @doc("Base URL clients use to reach the instance's data-plane (OpenEnv) endpoints, when running.")
  @visibility(Lifecycle.Read)
  baseUrl?: string;

  @doc("Failure detail when the instance enters the `Failed` state.")
  @visibility(Lifecycle.Read)
  error?: string;

  @doc("Timestamp the instance was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAtUtc: utcDateTime;

  @doc("Timestamp the instance was last updated, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAtUtc: utcDateTime;
}

// ============================================================================
// Runtime (data-plane) request and response shapes
// ============================================================================

@doc("Request body for starting or restarting an RLE environment episode.")
model RLEResetRequest {
  @doc("Optional deterministic seed for the next episode.")
  seed?: int32;

  @doc("Optional caller-provided episode identifier.")
  episodeId?: string;
}

@doc("Request body for applying an action to the current RLE episode.")
model RLEStepRequest {
  @doc("Environment-specific action payload.")
  action: RLEJsonObject;
}

@doc("Outcome returned by RLE `reset` and `step` in the OpenEnv / Gymnasium wire shape.")
model RLEStepResult {
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
  @encodedName("application/json", "episode_id")
  episodeId?: string;

  @doc("Number of completed steps in the current episode.")
  @encodedName("application/json", "step_count")
  stepCount?: int32;
}
