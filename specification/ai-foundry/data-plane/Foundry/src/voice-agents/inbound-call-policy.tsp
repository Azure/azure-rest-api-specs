import "./agents.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@doc("Telephony settings for a Voice Agent version.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentTelephonyConfig {
  @doc("Decides whether to admit an eligible inbound telephone call before provider answer or media admission. Omit to keep the default accept behavior.")
  inbound_call_policy?: VoiceAgentInboundCallPolicy;
}

@doc("The policy used to decide whether to admit an inbound call. Unknown values are invalid.")
union VoiceAgentInboundCallPolicyType {
  always_accept: "always_accept",
  always_decline: "always_decline",
  webhook: "webhook",
}

@doc("A decision policy for inbound calls. Existing provider authorization, routing, and caller allowlists apply to every policy.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentInboundCallPolicy {
  @doc("The decision policy type.")
  type: VoiceAgentInboundCallPolicyType;
}

@doc("Continue through normal setup for an eligible incoming call.")
model VoiceAgentAlwaysAcceptInboundCallPolicy
  extends VoiceAgentInboundCallPolicy {
  @doc("Always `always_accept`.")
  type: VoiceAgentInboundCallPolicyType.always_accept;
}

@doc("Decline an eligible incoming call before the Agent answers or accepts media.")
model VoiceAgentAlwaysDeclineInboundCallPolicy
  extends VoiceAgentInboundCallPolicy {
  @doc("Always `always_decline`.")
  type: VoiceAgentInboundCallPolicyType.always_decline;
}

@doc("""
  Request a synchronous decision from a customer HTTPS endpoint. A timeout, unsuccessful
  request, or invalid response declines the call. For ACS/Teams Phone Extensibility, both
  Event Grid delivery identity and the configured ACS source must be verified before sending.
  """)
model VoiceAgentWebhookInboundCallPolicy extends VoiceAgentInboundCallPolicy {
  @doc("Always `webhook`.")
  type: VoiceAgentInboundCallPolicyType.webhook;

  @doc("Name of an authorized same-project Foundry connection containing the HTTPS endpoint and a write-only signing secret.")
  @minLength(1)
  @example("support-call-admission")
  connection_name: string;

  @doc("Names of call signaling headers to include in the payload if the provider permits them. Omit to forward no headers.")
  @maxItems(8)
  forward_headers?: string[];
}

@doc("The provider that delivered the inbound call.")
union VoiceAgentInboundCallProvider {
  string,
  twilio: "twilio",
  azure_communication_service: "azure-communication-service",
  sip: "sip",
  genesys_audiohook: "genesys-audiohook",
}

@doc("The Voice Agent version selected for this inbound call.")
model VoiceAgentInboundCallWebhookAgent {
  @doc("The resolved Foundry project ID.")
  project_id: string;

  @doc("The resolved Agent name.")
  name: string;

  @doc("The resolved Agent version.")
  version: string;
}

@doc("""
  JSON body sent by Foundry to the customer's inbound call decision endpoint. The exact body is
  signed with the connection secret. This is a callback payload, not a Foundry operation.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentInboundCallWebhookContent {
  @doc("Identifies the event as a synchronous inbound call decision request.")
  type: "telephony.inbound_call";

  @doc("The webhook payload schema version.")
  schema_version: 1;

  @doc("Opaque identifier stable across duplicate deliveries for the same admission.")
  event_id: string;

  @doc("The provider that delivered the call.")
  provider: VoiceAgentInboundCallProvider;

  @doc("The provider call correlation ID. It is not a call control capability.")
  provider_call_id: string;

  @doc("Provider-reported caller identifier, or null if unavailable or withheld.")
  from: string | null;

  @doc("Provider-reported callee identifier, or null if unavailable or withheld.")
  to: string | null;

  @doc("The Agent version whose inbound policy is being evaluated.")
  agent: VoiceAgentInboundCallWebhookAgent;

  @doc("Allowed call signaling headers as lower-case names with arrays of values. Empty when none are forwarded. Credentials and transport headers are excluded.")
  headers: Record<string[]>;
}

@doc("A case-sensitive inbound call decision. Other values are invalid.")
union VoiceAgentInboundCallWebhookDecision {
  accept: "accept",
  decline: "decline",
}

@doc("JSON body returned by the customer endpoint with HTTP 200. Only the decision property is allowed. The decoded response must not exceed 1 KiB.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentInboundCallWebhookResult {
  @doc("Whether Foundry should continue with the selected Agent version or decline the call.")
  decision: VoiceAgentInboundCallWebhookDecision;
}
