import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias RLEOperations = FoundryAzureOperations<{}>;

/**
 * Lifecycle operations for hosted reinforcement-learning environments.
 *
 * Environments are created from a container image (`acrImagePath`) and
 * versioned: every successful `updateEnvironment` produces a new immutable
 * version while preserving the environment identity. Sandboxes are leased
 * against an environment via the `RLESandboxes` interface.
 */
@route("fine_tuning/environments")
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple non-paged list."
  @doc("List all hosted RLE environments in the project.")
  @get
  @list
  listEnvironments is FoundryDataPlaneOperation<{}, ListRLEnvironmentsResponse>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Get a hosted RLE environment by id.")
  @route("{environmentId}")
  @get
  getEnvironment is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier.")
      @path
      environmentId: string;
    },
    RLEnvironment
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service uses PUT with a partial update body rather than full-resource replace."
  @doc("Update a hosted RLE environment. Produces a new version pointing at the supplied image.")
  @route("{environmentId}")
  @put
  updateEnvironment is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier.")
      @path
      environmentId: string;

      @doc("The update to apply.")
      @body body: UpdateRLEnvironmentRequest;
    },
    RLEnvironment
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Delete a hosted RLE environment and all of its versions.")
  @route("{environmentId}")
  @delete
  deleteEnvironment is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier.")
      @path
      environmentId: string;
    },
    NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple non-paged list."
  @doc("List historical versions of a hosted RLE environment.")
  @route("{environmentId}/versions")
  @get
  @list
  listRLEnvironmentVersions is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier.")
      @path
      environmentId: string;
    },
    ListRLEnvironmentVersionsResponse
  >;
}

/**
 * RLSandbox lifecycle operations for hosted reinforcement-learning environments.
 *
 * `lease` provisions a fresh sandbox, `getSandbox` polls it until it reports
 * the `Running` status, `stop`/`resume` pause and resume a running sandbox,
 * and `release` tears it down. These operations are served by the Foundry
 * project endpoint.
 */
@route("fine_tuning/environments/{environmentId}/sandboxes")
@tag("ReinforcementLearning")
interface RLESandboxes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a `lease` collection action rather than a standard create."
  @doc("Lease a fresh sandbox from a hosted RLE environment.")
  @route("lease")
  @post
  lease is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier to lease the sandbox from.")
      @path
      environmentId: string;

      @doc("RLSandbox lease request.")
      @body body: CreateRLSandboxRequest;
    },
    RLSandbox
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a simple non-paged list."
  @doc("List sandboxes currently leased for an environment.")
  @get
  @list
  listSandboxes is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier whose sandboxes to list.")
      @path
      environmentId: string;
    },
    ListRLSandboxesResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes resource-level operations under a flat route shape."
  @doc("Fetch the latest lifecycle state for a leased sandbox.")
  @route("{sandboxId}")
  @get
  getSandbox is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier the sandbox belongs to.")
      @path
      environmentId: string;

      @doc("RLSandbox identifier.")
      @path
      sandboxId: string;
    },
    RLSandbox
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a `stop` action on the sandbox."
  @doc("Stop a running sandbox. The sandbox enters the `Stopped` state and may be resumed.")
  @route("{sandboxId}/stop")
  @post
  stop is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier the sandbox belongs to.")
      @path
      environmentId: string;

      @doc("RLSandbox identifier.")
      @path
      sandboxId: string;
    },
    RLSandbox
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a `resume` action on the sandbox."
  @doc("Resume a previously stopped sandbox. The sandbox transitions back toward `Running`.")
  @route("{sandboxId}/resume")
  @post
  resume is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier the sandbox belongs to.")
      @path
      environmentId: string;

      @doc("RLSandbox identifier.")
      @path
      sandboxId: string;
    },
    RLSandbox
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Service exposes a `release` action that tears down the sandbox via DELETE."
  @doc("Release a leased sandbox. The SDK treats this as best-effort teardown.")
  @route("{sandboxId}/release")
  @delete
  release is FoundryDataPlaneOperation<
    {
      @doc("Environment identifier the sandbox belongs to.")
      @path
      environmentId: string;

      @doc("RLSandbox identifier.")
      @path
      sandboxId: string;
    },
    NoContentResponse
  >;
}

/**
 * Per-sandbox runtime operations (OpenEnv / Gymnasium style).
 *
 * These operations act on a single `Running` sandbox. The SDK invokes them
 * against the sandbox `url` returned by `RLESandboxes.lease`, which is a
 * different host from the Foundry project endpoint; they are modeled here as
 * sub-resource actions so they share the `RLSandbox` resource contract.
 */
@route("fine_tuning")
@tag("ReinforcementLearning")
interface RLEnvironmentRuntime {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime episode control is a non-standard, environment-defined action."
  @doc("Start a new episode and return the initial observation.")
  @Rest.action("reset")
  @Rest.actionSeparator("/")
  reset is RLEOperations.ResourceAction<RLSandbox, RLResetRequest, RLStepResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime episode control is a non-standard, environment-defined action."
  @doc("Apply an action and return the resulting transition.")
  @Rest.action("step")
  @Rest.actionSeparator("/")
  step is RLEOperations.ResourceAction<RLSandbox, RLStepRequest, RLStepResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Runtime query is read-only and modeled as a GET action."
  @doc("Return the current environment state.")
  @Rest.action("state")
  @Rest.actionSeparator("/")
  @get
  state is RLEOperations.ResourceAction<RLSandbox, {}, RLEnvironmentState>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Runtime query is read-only and modeled as a GET action."
  @doc("Return environment health details.")
  @Rest.action("health")
  @Rest.actionSeparator("/")
  @get
  health is RLEOperations.ResourceAction<RLSandbox, {}, RLEJsonObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Runtime query is read-only and modeled as a GET action."
  @doc("Return environment metadata.")
  @Rest.action("metadata")
  @Rest.actionSeparator("/")
  @get
  getMetadata is RLEOperations.ResourceAction<RLSandbox, {}, RLEJsonObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Runtime query is read-only and modeled as a GET action."
  @doc("Return environment-provided action and observation schemas.")
  @Rest.action("schema")
  @Rest.actionSeparator("/")
  @get
  schema is RLEOperations.ResourceAction<RLSandbox, {}, RLEJsonObject>;
}
