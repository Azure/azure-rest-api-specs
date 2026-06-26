import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias RLEOperations = FoundryAzureOperations<{}>;

/**
 * Sandbox lifecycle operations for hosted reinforcement-learning environments.
 *
 * `createSandbox` leases a sandbox, `getSandbox` polls it until it reports the
 * `Running` status, and `deleteSandbox` releases it. These operations are served
 * by the Foundry project endpoint.
 */
@route("rle")
@tag("ReinforcementLearning")
interface RLESandboxes {
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Create returns the leased sandbox with a service-assigned id."
  @doc("Lease a fresh sandbox for a hosted RLE environment.")
  createSandbox is RLEOperations.ResourceCreateWithServiceProvidedName<Sandbox>;

  @doc("Fetch the latest lifecycle state for a leased sandbox.")
  getSandbox is RLEOperations.ResourceRead<Sandbox>;

  @doc("List the sandboxes currently leased for an environment.")
  listSandboxes is RLEOperations.ResourceList<Sandbox>;

  @doc("Release a leased sandbox. The SDK treats this as best-effort teardown.")
  deleteSandbox is RLEOperations.ResourceDelete<Sandbox>;
}

/**
 * Per-sandbox runtime operations (OpenEnv / Gymnasium style).
 *
 * These operations act on a single `Running` sandbox. The SDK invokes them
 * against the sandbox `url` returned by `RLESandboxes.createSandbox`, which is a
 * different host from the Foundry project endpoint; they are modeled here as
 * sub-resource actions so they share the `Sandbox` resource contract.
 */
@route("rle")
@tag("ReinforcementLearning")
interface RLEEnvironmentRuntime {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime episode control is a non-standard, environment-defined action."
  @doc("Start a new episode and return the initial observation.")
  @Rest.action("reset")
  @Rest.actionSeparator("/")
  reset is RLEOperations.ResourceAction<Sandbox, ResetRequest, StepResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime episode control is a non-standard, environment-defined action."
  @doc("Apply an action and return the resulting transition.")
  @Rest.action("step")
  @Rest.actionSeparator("/")
  step is RLEOperations.ResourceAction<Sandbox, StepRequest, StepResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Runtime query is read-only and modeled as a GET action."
  @doc("Return the current environment state.")
  @Rest.action("state")
  @Rest.actionSeparator("/")
  @get
  state is RLEOperations.ResourceAction<Sandbox, {}, EnvState>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Runtime query is read-only and modeled as a GET action."
  @doc("Return environment health details.")
  @Rest.action("health")
  @Rest.actionSeparator("/")
  @get
  health is RLEOperations.ResourceAction<Sandbox, {}, RLEJsonObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Runtime query is read-only and modeled as a GET action."
  @doc("Return environment metadata.")
  @Rest.action("metadata")
  @Rest.actionSeparator("/")
  @get
  getMetadata is RLEOperations.ResourceAction<Sandbox, {}, RLEJsonObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Runtime query is an environment-defined read action."
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Runtime query is read-only and modeled as a GET action."
  @doc("Return environment-provided action and observation schemas.")
  @Rest.action("schema")
  @Rest.actionSeparator("/")
  @get
  schema is RLEOperations.ResourceAction<Sandbox, {}, RLEJsonObject>;
}
