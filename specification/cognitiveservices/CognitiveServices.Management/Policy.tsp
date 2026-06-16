import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Agent Guardrails resource for controlling sandbox traffic at the account level.
 * Account-level policies are shared across all projects, aligning with
 * RAI policies and networking which are also account-scoped.
 */
@added(Versions.v2026_05_15_preview)
@parentResource(Account)
model AgentGuardrailsResource
  is Azure.ResourceManager.ProxyResource<AgentGuardrailsProperties, false> {
  ...ResourceNameParameter<
    Resource = AgentGuardrailsResource,
    KeyName = "agentGuardrailsName",
    SegmentName = "agentGuardrails",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,62}$"
  >;
}

// --- Account-level operations ---

@added(Versions.v2026_05_15_preview)
@armResourceOperations
interface AccountAgentGuardrailsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,
      },
      {
        /** The name of the agent guardrails policy. */
        @path
        @segment("agentGuardrails")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,62}$")
        agentGuardrailsName: string,
      },
      ResourceName = "CognitiveServicesAccountAgentGuardrails"
    > {}

@added(Versions.v2026_05_15_preview)
@armResourceOperations(#{ omitTags: true })
interface AccountAgentGuardrails {
  /**
   * Gets the specified agent guardrails policy associated with the Cognitive Services account.
   */
  @tag("AccountAgentGuardrailsResource")
  get is AccountAgentGuardrailsOps.Read<AgentGuardrailsResource>;

  /**
   * Creates or updates an agent guardrails policy under the specified Cognitive Services account.
   */
  @tag("AccountAgentGuardrailsResource")
  createOrUpdate is AccountAgentGuardrailsOps.CreateOrUpdateSync<AgentGuardrailsResource>;

  /**
   * Deletes the specified agent guardrails policy from the Cognitive Services account.
   */
  @tag("AccountAgentGuardrailsResource")
  delete is AccountAgentGuardrailsOps.DeleteSync<AgentGuardrailsResource>;

  /**
   * Lists all agent guardrails policies under the specified Cognitive Services account.
   */
  @tag("AccountAgentGuardrailsResource")
  list is AccountAgentGuardrailsOps.List<
    AgentGuardrailsResource,
    Response = AgentGuardrailsListResult
  >;
}

// --- Documentation annotations ---

@@doc(AgentGuardrailsResource.name, "The name of the agent guardrails policy.");
@@doc(
  AgentGuardrailsResource.properties,
  "Properties of the agent guardrails policy resource."
);
@@doc(
  AccountAgentGuardrails.createOrUpdate::parameters.resource,
  "The agent guardrails policy resource to create or update."
);
@@summary(
  AccountAgentGuardrails.list,
  "Lists all agent guardrails policies under the specified Cognitive Services account."
);
@@summary(
  AccountAgentGuardrails.get,
  "Gets the specified agent guardrails policy associated with the Cognitive Services account."
);
@@summary(
  AccountAgentGuardrails.createOrUpdate,
  "Creates or updates an agent guardrails policy under the specified Cognitive Services account."
);
@@summary(
  AccountAgentGuardrails.delete,
  "Deletes the specified agent guardrails policy from the Cognitive Services account."
);
