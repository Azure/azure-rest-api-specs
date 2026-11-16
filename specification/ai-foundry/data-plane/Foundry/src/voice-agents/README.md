# Hosted conversation-engine session allocation

`VoiceHostedAgentConversationEngine` supports two optional, non-null boolean
properties under `conversation_engine.type: hosted_agent`:

- `hosted_session_warmup` permits eligible calls to use service-managed prewarmed
  Hosted Sessions. It does not enable session sharing, Agent startup model warmup,
  or language-model inference warmup.
- `hosted_session_multiplexing` permits independent calls to share a compatible
  Hosted Session. The application must support concurrent connections and isolate
  mutable state per call.

Both default to `false`. Omission and explicit `false` have the same effective
behavior but remain distinct through definition/version round-trips. The options
are independent and can each be enabled or disabled.

Neither property belongs on the Voice Agent root, the generic conversation-engine
base, a model-backed/native Live definition, a Hosted Agent manifest/protocol
record, or a Bridge message. The service rejects misplaced root properties even
when `false`, and rejects explicit `null` or non-boolean values without coercion.
The private runtime feature `hosted_session_shared` is not a public alias.

These are versioned definition settings selected before session acquisition.
Neither connection-time session overrides nor `session.update` may change them.
Saving a definition creates no Hosted Sessions; eligible runtime traffic drives
allocation. Updating the choices creates a new Voice Agent version and affects
new calls without terminating calls using older versions. Opt-in is not a
reservation, latency SLA, or guarantee of a warm/shared allocation. Existing
endpoint selection and protocol eligibility are unchanged.

Examples show [explicit allocation options](../../examples/v1/Agents_CreateVoiceAgent_HostedAgent_Gen.json),
[both options enabled](../../examples/v1/Agents_CreateVoiceAgent_HostedAgentSessionOptions.json),
and [omitted options](../../examples/v1/Agents_CreateVoiceAgent_HostedAgentLatest_Gen.json).
Request and response examples preserve explicit values and omission respectively.

## Runtime and rollout dependencies

This specification does not deploy Vienna, Voice Live, SDKs, or infrastructure.
The selected options require matching deployed Vienna and Voice Live support;
schema recognition alone does not establish runtime support. Matching nested-field
recognition also avoids advisory definition-validation errors.

Before enabling either optimization, verify existing target eligibility,
authorization/RBAC, networking, quota/capacity, and coordination TTL/index settings,
including the shared-candidate composite index
`used_slots DESC, created_at ASC, id ASC`. No new infrastructure configuration is
introduced here, and local schema validation is not deployment validation.
