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
 * versioned: every successful create against an existing name produces a new
 * immutable version (per `versionBump`) while preserving the environment
 * identity. Instance groups are created under a specific environment version,
 * and instances are leased from a group via the `RLEInstances` interface.
 */
@route("rl_environments")
@tag("ReinforcementLearning")
interface RLEnvironments {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a non-standard `create` collection action so a service-assigned id is returned without a client-supplied PUT."
  @doc("Create a new hosted RLE environment, or a new version of an existing one.")
  @route("create")
  @post
  createEnvironment is FoundryDataPlaneOperation<
    {
      @doc("The environment to create.")
      @body body: CreateRLEnvironmentRequest;
    },
    RLEnvironment
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple list with opaque cursor pagination."
  @doc("List all hosted RLE environments in the project.")
  @get
  listEnvironments is FoundryDataPlaneOperation<
    {
      @doc("Optional environment name filter. When set, returns at most a single matching environment.")
      @query
      name?: string;

      @doc("Maximum number of environments to return. Defaults to 100; valid range is [1, 100].")
      @query
      limit?: int32;

      @doc("Opaque cursor for paging forward. Returns items after the given cursor.")
      @query
      after?: string;

      @doc("Opaque cursor for paging backward. Returns items before the given cursor.")
      @query
      before?: string;

      @doc("Sort order for the page. Defaults to descending by creation time.")
      @query
      order?: RLEPaginationOrder;
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a list of versions with opaque cursor pagination."
  @doc("List historical versions of a hosted RLE environment.")
  @route("{name}/versions")
  @get
  listRLEnvironmentVersions is FoundryDataPlaneOperation<
    {
      @doc("Environment name.")
      @path
      name: string;

      @doc("Maximum number of versions to return. Defaults to 100; valid range is [1, 100].")
      @query
      limit?: int32;

      @doc("Opaque cursor for paging forward. Returns items after the given cursor.")
      @query
      after?: string;

      @doc("Opaque cursor for paging backward. Returns items before the given cursor.")
      @query
      before?: string;

      @doc("Sort order for the page. Defaults to ascending by version.")
      @query
      order?: RLEPaginationOrder;
    },
    ListRLEnvironmentVersionsResponse
  >;
}

/**
 * RLEInstanceGroup lifecycle operations.
 *
 * An instance group is the first-class unit that groups the instances leased for
 * a single reinforcement-learning training job. It is created under a specific
 * version of a registered environment; the environment name and version appear
 * in the request URI. `max_active_instances` bounds the number of
 * concurrently-active instances the group may hold.
 */
@route("rl_environments/{environmentName}/versions/{environmentVersion}/instance_groups")
@tag("ReinforcementLearning")
interface RLEInstanceGroups {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service mints the id, so create is a non-standard collection action rather than a client-supplied PUT."
  @doc("Create a new RLE instance group under the given environment version. The service mints `id`.")
  @post
  createInstanceGroup is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment to lease instances from.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment to lease instances from.")
      @path
      environmentVersion: string;

      @doc("The instance group to create.")
      @body body: CreateRLEInstanceGroupRequest;
    },
    RLEInstanceGroup
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple list with opaque cursor pagination."
  @doc("List RLE instance groups under the given environment version.")
  @get
  listInstanceGroups is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Maximum number of instance groups to return. Defaults to 100; valid range is [1, 100].")
      @query
      limit?: int32;

      @doc("Opaque cursor for paging forward. Returns items after the given cursor.")
      @query
      after?: string;

      @doc("Opaque cursor for paging backward. Returns items before the given cursor.")
      @query
      before?: string;

      @doc("Sort order for the page. Defaults to descending by creation time.")
      @query
      order?: RLEPaginationOrder;
    },
    ListRLEInstanceGroupsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Get an RLE instance group by identifier.")
  @route("{instanceGroupId}")
  @get
  getInstanceGroup is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier.")
      @path
      instanceGroupId: string;
    },
    RLEInstanceGroup
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Delete an RLE instance group. All instances owned by the group are released.")
  @route("{instanceGroupId}")
  @delete
  deleteInstanceGroup is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

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
 * creates a sandbox directly. `createInstance` takes no client body, mints the
 * `instance_id`, and returns `201` with the new instance (or `429` with a
 * `Retry-After` when the group is at its active-instance limit). `deleteInstance`
 * stops the backing runtime and removes the instance. Instances are also released
 * automatically when their instance group is deleted.
 */
@route("rl_environments/{environmentName}/versions/{environmentVersion}/instance_groups/{instanceGroupId}/instances")
@tag("ReinforcementLearning")
interface RLEInstances {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backend lease: create takes no client body, mints the id, and is non-idempotent, so it is a non-standard collection action rather than a PUT."
  @doc("""
    Lease a new RLE instance under the instance group. Returns `201` with the new
    instance, or `429` (with `Retry-After`) when the group is at its active-instance
    limit.
    """)
  @post
  createInstance is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier to lease the instance under.")
      @path
      instanceGroupId: string;
    },
    RLEInstance
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Get an RLE instance by identifier.")
  @route("{instanceId}")
  @get
  getInstance is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;
    },
    RLEInstance
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Delete an RLE instance: the backing runtime is stopped and the instance is removed.")
  @route("{instanceId}")
  @delete
  deleteInstance is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;
    },
    NoContentResponse
  >;
}

/**
 * RLEInstance runtime (data-plane) operations.
 *
 * These are the OpenEnv / Gymnasium runtime endpoints proxied verbatim through
 * RLE under a passthrough `openenv` segment, addressed by the full
 * environment/version/instance-group/instance path.
 */
@route("rl_environments/{environmentName}/versions/{environmentVersion}/instance_groups/{instanceGroupId}/instances/{instanceId}/openenv")
@tag("ReinforcementLearning")
interface RLEInstanceRuntime {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime episode control is a non-standard, environment-defined action."
  @doc("Start a new episode and return the initial observation.")
  @route("reset")
  @post
  reset is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;

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
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;

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
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;
    },
    RLEnvironmentState
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  @doc("Return environment health details.")
  @route("health")
  @get
  health is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;
    },
    RLEJsonObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  @doc("Return environment metadata.")
  @route("metadata")
  @get
  getMetadata is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;
    },
    RLEJsonObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  @doc("Return environment-provided action and observation schemas.")
  @route("schema")
  @get
  schema is FoundryDataPlaneOperation<
    {
      @doc("Name of the registered RLE environment.")
      @path
      environmentName: string;

      @doc("Version of the registered RLE environment.")
      @path
      environmentVersion: string;

      @doc("Instance group identifier the instance belongs to.")
      @path
      instanceGroupId: string;

      @doc("Instance identifier.")
      @path
      instanceId: string;
    },
    RLEJsonObject
  >;
}
