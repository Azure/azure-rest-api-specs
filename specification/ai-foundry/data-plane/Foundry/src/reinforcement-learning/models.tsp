import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

// A JSON object whose schema is supplied at runtime by each RLE environment.
// Observations, actions, info, metadata, health, and schema payloads are all
// environment-defined and therefore modeled as open records.
alias RLEJsonObject = Record<unknown>;

@doc("A hosted reinforcement-learning environment that sandboxes are leased from.")
@resource("environments")
model RLEEnvironment {
  @doc("Hosted RLE environment identifier.")
  @key("environmentId")
  @visibility(Lifecycle.Read)
  environmentId: string;
}

@doc("A sandbox leased from a hosted RLE environment.")
@parentResource(RLEEnvironment)
@resource("sandboxes")
model Sandbox {
  @doc("Sandbox identifier, assigned by the service.")
  @key("sandboxId")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  sandboxId: string;

  @doc("""
    Sandbox lifecycle status. The SDK treats `Running` as ready and `Failed` as
    failed; `Stopped` is also terminal.
    """)
  @visibility(Lifecycle.Read)
  status: string;

  @doc("Base URL for the sandbox runtime API. Present once the sandbox is `Running`.")
  @visibility(Lifecycle.Read)
  url?: string;

  @doc("Failure detail when the sandbox enters a failed state.")
  @visibility(Lifecycle.Read)
  error?: string;

  @doc("Optional environment image or package version to run.")
  @visibility(Lifecycle.Create)
  version?: string;

  @doc("Requested CPU allocation for the sandbox, in cores.")
  @visibility(Lifecycle.Create)
  cpu?: float64;

  @doc("Requested memory allocation, for example '2Gi'.")
  @visibility(Lifecycle.Create)
  memory?: string;

  @doc("Requested disk allocation, for example '10Gi'.")
  @visibility(Lifecycle.Create)
  disk?: string;

  @doc("Environment variables to inject into the sandbox.")
  @visibility(Lifecycle.Create)
  envVars?: Record<string>;
}

@doc("Request body for starting or restarting an RLE environment episode.")
model ResetRequest {
  @doc("Optional deterministic seed for the next episode.")
  seed?: int32;

  @doc("Optional caller-provided episode identifier.")
  episodeId?: string;
}

@doc("Request body for applying an action to the current RLE episode.")
model StepRequest {
  @doc("Environment-specific action payload.")
  action: RLEJsonObject;
}

@doc("Outcome returned by RLE `reset` and `step` in the OpenEnv / Gymnasium wire shape.")
model StepResult {
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
model EnvState {
  @doc("Current episode identifier, when one is active.")
  episodeId?: string;

  @doc("Number of completed steps in the current episode.")
  stepCount?: int32;
}
