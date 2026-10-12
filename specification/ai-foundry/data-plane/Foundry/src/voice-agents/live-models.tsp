import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/live";
// OpenAI TypeSpec 1.29.0's LiveCallReferRequest references target_uri from
// webhooks without importing it. Import models only, not native HTTP operations.
import "@azure-tools/openai-typespec/models/webhooks";

using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Reuse the native OpenAI delegation models without reparenting or changing their wire contract."
@doc("Delegation configured on a Foundry Live voice agent. Native client and Responses configurations are reused unchanged; Foundry may also execute a same-project prompt agent.")
@oneOf
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentLiveDelegation {
  client: OpenAI.LiveClientDelegationParam,
  responses: OpenAI.LiveResponsesDelegationParam,
  foundry_managed_agent: VoiceAgentLiveManagedAgentDelegation,
}

/** The current managed prompt-agent output contract. */
alias VoiceAgentLiveManagedResultFormat = "tagged_text";

@doc("""
  A same-project prompt agent executed by Foundry on behalf of the Live frontend. Foundry resolves
  and pins the target version once per voice connection, configures native client delegation upstream,
  and injects the target's validated output using native commentary/thinking messages.
  This is agent configuration, not an additional OpenAI inference-event variant.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedAgentDelegation {
  @doc("The Foundry-managed delegation type. Existing preview definitions may use the legacy managed_prompt_agent spelling; new definitions and returned definitions use foundry_managed_agent.")
  type: "foundry_managed_agent";

  @doc("The name of a prompt agent in the same Foundry project, not a URL or resource path. Hosted and voice agents are not supported targets.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,62}$")
  agent_name: string;

  @doc("A positive-integer agent version. Omission or null selects the active version, resolved once when the voice connection starts.")
  @pattern("^[1-9][0-9]{0,19}$")
  agent_version?: string | null;

  @doc("The target's output contract: plain text with explicit commentary and thinking section markers. Foundry validates the target and translates these sections to native Live messages.")
  result_format?: VoiceAgentLiveManagedResultFormat = "tagged_text";
}
