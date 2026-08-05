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
}

@doc("Response for listing hosted RLE environments.")
model ListRLEnvironmentsResponse {
  @doc("Environments on this page.")
  value: RLEnvironment[];

  @doc("Number of environments returned on this page.")
  count: int32;
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

// ============================================================================
// Instance groups
// ============================================================================

@doc("""
  Allocation lifecycle status of an RLE instance group. This tracks allocation, not
  ML outcome: RLE does not run the training, so there is no group-level `Succeeded`
  status. `Closed` is the normal (success-equivalent) terminal and `Failed` is an
  infrastructure/allocation verdict only (RLE could not serve the environment).
  """)
union RLEInstanceGroupStatus {
  string,

  @doc("Instance-group record exists; no instance has been leased yet.")
  created: "Created",

  @doc("At least one instance has been leased for the group.")
  active: "Active",

  @doc("Ended normally; all instances released. Success-equivalent terminal state.")
  closed: "Closed",

  @doc("RLE could not serve the environment (invalid version, broken image, or all instances failed). Infrastructure verdict only.")
  failed: "Failed",

  @doc("Aborted early by an explicit cancel or delete.")
  cancelled: "Cancelled",
}

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
  training job. Created from a registered environment (referenced by name and
  version); the environment does not appear in the instance-group URI.
  """)
@resource("instance-groups")
model RLEInstanceGroup {
  @doc("Instance group identifier, assigned by the service.")
  @key("instanceGroupId")
  @encodedName("application/json", "instance_group_id")
  @visibility(Lifecycle.Read)
  instanceGroupId: string;

  @doc("Foundry project identifier that owns this instance group.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "project_id")
  projectId: string;

  @doc("Display name for the instance group. Supplied by the caller or generated by the service.")
  name: string;

  @doc("Name of the registered RLE environment the group's instances are leased from.")
  @encodedName("application/json", "environment_name")
  @visibility(Lifecycle.Read)
  environmentName: string;

  @doc("Version of the registered RLE environment the group's instances are leased from.")
  @encodedName("application/json", "environment_version")
  @visibility(Lifecycle.Read)
  environmentVersion: string;

  @doc("Reserved quota: the maximum number of concurrently-active instances the group may hold. Defaults to 1 when omitted on create.")
  @encodedName("application/json", "instance_count")
  @visibility(Lifecycle.Read)
  instanceCount: int32;

  @doc("Allocation lifecycle status of the instance group.")
  @visibility(Lifecycle.Read)
  status: RLEInstanceGroupStatus;

  @doc("Failure detail when the instance group enters the `Failed` state.")
  @visibility(Lifecycle.Read)
  error?: string;

  @doc("""
    Free-form correlation/tag key-values, persisted opaquely by RLE and echoed on
    responses. `external_job_id` is a reserved well-known key that carries the
    upstream Training API job / AML run this group backs.
    """)
  metadata?: Record<string>;

  @doc("Forward-compatible resource allocation hints. Recorded but not scheduled against in this version.")
  @encodedName("application/json", "resource_profile")
  resourceProfile?: RLEInstanceGroupResourceProfile;

  @doc("Forward-compatible scheduling priority hint. Recorded but not scheduled against in this version.")
  priority?: int32;

  @doc("Timestamp the instance group was created, in UTC.")
  @encodedName("application/json", "created_at_utc")
  @visibility(Lifecycle.Read)
  createdAtUtc: utcDateTime;

  @doc("Timestamp the instance group was last updated, in UTC.")
  @encodedName("application/json", "updated_at_utc")
  @visibility(Lifecycle.Read)
  updatedAtUtc: utcDateTime;
}

@doc("Request body for creating an RLE instance group.")
model CreateRLEInstanceGroupRequest {
  @doc("Name of the registered RLE environment to lease instances from.")
  @encodedName("application/json", "environment_name")
  environmentName: string;

  @doc("Version of the registered RLE environment to lease instances from.")
  @encodedName("application/json", "environment_version")
  environmentVersion: string;

  @doc("Reserved quota: the maximum number of concurrently-active instances. Optional; defaults to 1 when omitted.")
  @encodedName("application/json", "instance_count")
  instanceCount?: int32;

  @doc("Optional caller-provided display name. The service generates one when omitted.")
  name?: string;

  @doc("Optional free-form correlation/tag key-values. `external_job_id` is a reserved well-known key for the upstream Training API job / AML run.")
  metadata?: Record<string>;

  @doc("Optional forward-compatible resource allocation hints. Recorded only in this version.")
  @encodedName("application/json", "resource_profile")
  resourceProfile?: RLEInstanceGroupResourceProfile;
}

@doc("Request body for updating an RLE instance group. Used to signal completion by setting `status` to `Closed`.")
model UpdateRLEInstanceGroupRequest {
  @doc("New allocation lifecycle status. Setting `Closed` signals normal completion and releases all owned instances.")
  status?: RLEInstanceGroupStatus;
}

@doc("Response for listing RLE instance groups.")
model ListRLEInstanceGroupsResponse {
  @doc("Instance groups on this page.")
  value: RLEInstanceGroup[];

  @doc("Number of instance groups returned on this page.")
  count: int32;
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

  @doc("The instance's task finished and RLE stopped the backing runtime. Not reused in this version.")
  stopped: "Stopped",

  @doc("The instance errored during provisioning or at runtime. See `error` for details.")
  failed: "Failed",

  @doc("The backing runtime has been torn down / removed.")
  deleted: "Deleted",

  @doc("The instance was released before its task completed (e.g. the instance group was cancelled).")
  cancelled: "Cancelled",
}

@doc("Allocation (lease) state of an RLE instance, orthogonal to its runtime `status`.")
union RLEInstanceLeaseState {
  string,

  @doc("The instance is actively leased and counts against the group's reserved quota.")
  leased: "Leased",

  @doc("Reserved for future instance reuse. Not used in this version.")
  idle: "Idle",

  @doc("The lease has been released; the instance no longer counts against quota and is not reused.")
  released: "Released",
}

@doc("""
  A leased runtime unit owned by an RLE instance group (replaces the former
  \"sandbox\" concept). Combines the owning instance-group identity, the runtime
  identity, internal backing details, runtime status, and lease bookkeeping.
  """)
@parentResource(RLEInstanceGroup)
@resource("instances")
model RLEInstance {
  @doc("Instance identifier, assigned by the service. Globally unique.")
  @key("instanceId")
  @encodedName("application/json", "instance_id")
  @visibility(Lifecycle.Read)
  instanceId: string;

  @doc("Identifier of the owning RLE instance group.")
  @encodedName("application/json", "instance_group_id")
  @visibility(Lifecycle.Read)
  instanceGroupId: string;

  @doc("Internal identifier of the backing runtime sandbox. Surfaced for diagnostics only.")
  @encodedName("application/json", "adc_sandbox_id")
  @visibility(Lifecycle.Read)
  adcSandboxId?: string;

  @doc("Runtime status of the instance.")
  @visibility(Lifecycle.Read)
  status: RLEInstanceStatus;

  @doc("Allocation (lease) state of the instance.")
  @encodedName("application/json", "lease_state")
  @visibility(Lifecycle.Read)
  leaseState: RLEInstanceLeaseState;

  @doc("Timestamp the instance was leased, in UTC.")
  @encodedName("application/json", "leased_at_utc")
  @visibility(Lifecycle.Read)
  leasedAtUtc?: utcDateTime;

  @doc("Timestamp the instance was released, in UTC.")
  @encodedName("application/json", "released_at_utc")
  @visibility(Lifecycle.Read)
  releasedAtUtc?: utcDateTime;

  @doc("Timestamp of the most recent data-plane activity on the instance, in UTC. Bumped on every data-plane call.")
  @encodedName("application/json", "last_activity_utc")
  @visibility(Lifecycle.Read)
  lastActivityUtc?: utcDateTime;

  @doc("Idle-timeout deadline, in UTC. Computed as `last_activity_utc` plus the idle TTL.")
  @encodedName("application/json", "lease_expires_at_utc")
  @visibility(Lifecycle.Read)
  leaseExpiresAtUtc?: utcDateTime;

  @doc("CPU allocation of the instance, encoded as a string.")
  @visibility(Lifecycle.Read)
  cpu?: string;

  @doc("Memory allocation of the instance, for example \"2Gi\".")
  @visibility(Lifecycle.Read)
  memory?: string;

  @doc("Disk allocation of the instance, for example \"10Gi\".")
  @visibility(Lifecycle.Read)
  disk?: string;

  @doc("Failure detail when the instance enters the `Failed` state.")
  @visibility(Lifecycle.Read)
  error?: string;

  @doc("Timestamp the instance was created, in UTC.")
  @encodedName("application/json", "created_at_utc")
  @visibility(Lifecycle.Read)
  createdAtUtc: utcDateTime;

  @doc("Timestamp the instance was last updated, in UTC.")
  @encodedName("application/json", "updated_at_utc")
  @visibility(Lifecycle.Read)
  updatedAtUtc: utcDateTime;
}

@doc("Response for listing instances owned by an RLE instance group.")
model ListRLEInstancesResponse {
  @doc("Instances on this page.")
  value: RLEInstance[];

  @doc("Number of instances returned on this page.")
  count: int32;
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
