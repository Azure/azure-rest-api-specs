import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

/**
 * Lifecycle operations for hosted reinforcement-learning environments.
 *
 * Environments are created from a container image (`acrImagePath`) and
 * versioned: every successful `updateEnvironment` produces a new immutable
 * version while preserving the environment identity. Instances are leased
 * from an environment under an `RLEInstanceGroup` via the `RLEInstances`
 * interface.
 */
@route("rle/environments")
@tag("ReinforcementLearning")
interface RLEnvironments {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a non-standard `create` collection action so a service-assigned id is returned without a client-supplied PUT."
  @doc("Create a new hosted RLE environment.")
  @route("create")
  @post
  createEnvironment is FoundryDataPlaneOperation<
    {
      @doc("The environment to create.")
      @body body: CreateRLEnvironmentRequest;
    },
    RLEnvironment
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple non-paged list with skip/top/name filters."
  @doc("List all hosted RLE environments in the project.")
  @get
  listEnvironments is FoundryDataPlaneOperation<
    {
      @doc("Optional environment name filter. When set, returns at most a single matching environment.")
      @query
      name?: string;

      @doc("Number of environments to skip. Defaults to 0.")
      @query
      skip?: int32;

      @doc("Maximum number of environments to return. Defaults to 50; valid range is [1, 200].")
      @query
      top?: int32;
    },
    ListRLEnvironmentsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Get a hosted RLE environment by name. Returns the latest version of the environment.")
  @route("{name}")
  @get
  getEnvironment is FoundryDataPlaneOperation<
    {
      @doc("Environment name.")
      @path
      name: string;
    },
    RLEnvironment
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Get a specific version of a hosted RLE environment by name and version.")
  @route("{name}/versions/{version}")
  @get
  getEnvironmentVersion is FoundryDataPlaneOperation<
    {
      @doc("Environment name.")
      @path
      name: string;

      @doc("Environment version identifier.")
      @path
      version: string;
    },
    RLEnvironment
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Delete a specific version of a hosted RLE environment.")
  @route("{name}/versions/{version}")
  @delete
  deleteEnvironmentVersion is FoundryDataPlaneOperation<
    {
      @doc("Environment name.")
      @path
      name: string;

      @doc("Environment version identifier.")
      @path
      version: string;
    },
    NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple non-paged array of versions."
  @doc("List historical versions of a hosted RLE environment.")
  @route("{name}/versions")
  @get
  listRLEnvironmentVersions is FoundryDataPlaneOperation<
    {
      @doc("Environment name.")
      @path
      name: string;
    },
    RLEnvironmentVersion[]
  >;
}

/**
 * RLEInstanceGroup lifecycle operations.
 *
 * An instance group is the first-class unit that groups the instances leased for
 * a single reinforcement-learning training job. It is created from a registered
 * environment (referenced by `environment_name` and `environment_version`); the
 * environment does not appear in the URI. `instance_count` is a reserved quota
 * (the maximum number of concurrently-active instances) and is reserved at create
 * time. Status follows an allocation lifecycle
 * (`Created → Active → Closed | Failed | Cancelled`); `Closed` is the normal
 * terminal and is signaled via `updateInstanceGroup` (`status: Closed`) or the
 * background reaper. Reaching any terminal status releases all owned instances.
 */
@route("rle/instance-groups")
@tag("ReinforcementLearning")
interface RLEInstanceGroups {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service mints the id and reserves quota, so create is a non-standard collection action rather than a client-supplied PUT."
  @doc("""
    Create a new RLE instance group. The service mints `instance_group_id` and
    reserves `instance_count` slots of quota. Returns `403` with code
    `QuotaExceeded` when the requested quota cannot be reserved.
    """)
  @post
  createInstanceGroup is FoundryDataPlaneOperation<
    {
      @doc("The instance group to create.")
      @body body: CreateRLEInstanceGroupRequest;
    },
    RLEInstanceGroup
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple non-paged list with skip/top and status/environment filters."
  @doc("List RLE instance groups in the project.")
  @get
  listInstanceGroups is FoundryDataPlaneOperation<
    {
      @doc("Optional instance group status filter.")
      @query
      status?: RLEInstanceGroupStatus;

      @doc("Optional environment name filter.")
      @query
      environmentName?: string;

      @doc("Number of instance groups to skip. Defaults to 0.")
      @query
      skip?: int32;

      @doc("Maximum number of instance groups to return. Defaults to 50; valid range is [1, 200].")
      @query
      top?: int32;
    },
    ListRLEInstanceGroupsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Get an RLE instance group by identifier.")
  @route("{instanceGroupId}")
  @get
  getInstanceGroup is FoundryDataPlaneOperation<
    {
      @doc("Instance group identifier.")
      @path
      instanceGroupId: string;
    },
    RLEInstanceGroup
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a status-update completion signal via a non-standard flat route shape."
  @doc("""
    Update an RLE instance group. Setting `status` to `Closed` signals normal
    completion and releases all instances owned by the group.
    """)
  @route("{instanceGroupId}")
  @patch(#{ implicitOptionality: true })
  updateInstanceGroup is FoundryDataPlaneOperation<
    {
      @doc("Instance group identifier.")
      @path
      instanceGroupId: string;

      @doc("The update to apply.")
      @body body: UpdateRLEInstanceGroupRequest;
    },
    RLEInstanceGroup
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Cancel an RLE instance group. The group is marked `Cancelled` and all owned instances are released.")
  @route("{instanceGroupId}")
  @delete
  deleteInstanceGroup is FoundryDataPlaneOperation<
    {
      @doc("Instance group identifier.")
      @path
      instanceGroupId: string;
    },
    NoContentResponse
  >;
}

/**
 * RLEInstance lifecycle operations (replaces the former sandbox surface).
 *
 * Instances are leased by the backend under an instance group; the client never
 * creates a sandbox directly. `createInstance` is a synchronous, non-LRO
 * collection-create that always leases a brand-new instance from a warm pool
 * (no reuse): it returns `201` with the new instance, `429` with a `Retry-After`
 * when the group is at its reserved capacity, `202` with a `Retry-After` when
 * under cap but no warm instance is available yet, and `503` on a hard backend
 * failure. `releaseInstance` is a soft delete that stops the backing runtime and
 * marks the instance `Stopped`/`Released` while retaining the ledger row; it is
 * idempotent. Instances are also released automatically on instance-group
 * terminal status and by an idle timeout.
 */
@route("rle/instance-groups/{instanceGroupId}/instances")
@tag("ReinforcementLearning")
interface RLEInstances {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backend lease: create takes no client body, mints the id, and is non-idempotent, so it is a non-standard collection action rather than a PUT."
  @doc("""
    Lease a new RLE instance under the instance group. Synchronous and non-LRO:
    returns `201` with the new instance, `429` (with `Retry-After`) at the group's
    reserved capacity, `202` (with `Retry-After`, status `Pending`) when under cap
    but no warm instance is available yet, or `503` on a hard backend failure.
    """)
  @post
  createInstance is FoundryDataPlaneOperation<
    {
      @doc("Instance group identifier to lease the instance under.")
      @path
      instanceGroupId: string;
    },
    RLEInstance
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple non-paged list with skip/top and lease-state filters."
  @doc("List instances owned by an RLE instance group.")
  @get
  listInstances is FoundryDataPlaneOperation<
    {
      @doc("Instance group identifier whose instances to list.")
      @path
      instanceGroupId: string;

      @doc("Optional lease-state filter.")
      @query
      leaseState?: RLEInstanceLeaseState;

      @doc("Number of instances to skip. Defaults to 0.")
      @query
      skip?: int32;

      @doc("Maximum number of instances to return. Defaults to 50; valid range is [1, 200].")
      @query
      top?: int32;
    },
    ListRLEInstancesResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Get an RLE instance by identifier.")
  @route("{instanceId}")
  @get
  getInstance is FoundryDataPlaneOperation<
    {
      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;
    },
    RLEInstance
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Release is a soft delete that returns the final instance state; idempotent."
  @doc("""
    Release an RLE instance (soft delete): the backing runtime is stopped and the
    instance is marked `Stopped`/`Released` while the ledger row is retained.
    Idempotent — re-releasing an already-released instance is a no-op. Returns the
    final instance state.
    """)
  @route("{instanceId}")
  @delete
  releaseInstance is FoundryDataPlaneOperation<
    {
      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;
    },
    RLEInstance
  >;
}

/**
 * RLEInstance runtime (data-plane) operations, addressed by the globally-unique
 * `instance_id`.
 *
 * These are the OpenEnv / Gymnasium runtime endpoints proxied verbatim through
 * RLE under a passthrough `openenv` segment. The route is flat and group-less:
 * RLE resolves the owning instance group internally from `instance_id`. Each call
 * bumps the instance's `last_activity_utc` and extends its lease. A caller may
 * supply an `x-rle-session-id` header, which RLE echoes to the runtime and logs
 * for the caller's own correlation without storing it.
 */
@route("rle/instances/{instanceId}/openenv")
@tag("ReinforcementLearning")
interface RLEInstanceRuntime {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime episode control is a non-standard, environment-defined action."
  @doc("Start a new episode and return the initial observation.")
  @route("reset")
  @post
  reset is FoundryDataPlaneOperation<
    {
      @doc("Instance identifier.")
      @path
      instanceId: string;

      @doc("Optional client-supplied session identifier, echoed to the runtime and logs for correlation only.")
      @header("x-rle-session-id")
      sessionId?: string;

      @doc("Reset request body.")
      @body body: RLEResetRequest;
    },
    RLEStepResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime episode control is a non-standard, environment-defined action."
  @doc("Apply an action and return the resulting transition.")
  @route("step")
  @post
  step is FoundryDataPlaneOperation<
    {
      @doc("Instance identifier.")
      @path
      instanceId: string;

      @doc("Optional client-supplied session identifier, echoed to the runtime and logs for correlation only.")
      @header("x-rle-session-id")
      sessionId?: string;

      @doc("Step request body.")
      @body body: RLEStepRequest;
    },
    RLEStepResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  @doc("Return the current environment state.")
  @route("state")
  @get
  state is FoundryDataPlaneOperation<
    {
      @doc("Instance identifier.")
      @path
      instanceId: string;

      @doc("Optional client-supplied session identifier, echoed to the runtime and logs for correlation only.")
      @header("x-rle-session-id")
      sessionId?: string;
    },
    RLEnvironmentState
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  @doc("Return environment health details.")
  @route("health")
  @get
  health is FoundryDataPlaneOperation<
    {
      @doc("Instance identifier.")
      @path
      instanceId: string;

      @doc("Optional client-supplied session identifier, echoed to the runtime and logs for correlation only.")
      @header("x-rle-session-id")
      sessionId?: string;
    },
    RLEJsonObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  @doc("Return environment metadata.")
  @route("metadata")
  @get
  getMetadata is FoundryDataPlaneOperation<
    {
      @doc("Instance identifier.")
      @path
      instanceId: string;

      @doc("Optional client-supplied session identifier, echoed to the runtime and logs for correlation only.")
      @header("x-rle-session-id")
      sessionId?: string;
    },
    RLEJsonObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  @doc("Return environment-provided action and observation schemas.")
  @route("schema")
  @get
  schema is FoundryDataPlaneOperation<
    {
      @doc("Instance identifier.")
      @path
      instanceId: string;

      @doc("Optional client-supplied session identifier, echoed to the runtime and logs for correlation only.")
      @header("x-rle-session-id")
      sessionId?: string;
    },
    RLEJsonObject
  >;
}
