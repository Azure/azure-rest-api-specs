# Hosted conversation-engine session allocation

`VoiceHostedAgentConversationEngine` supports two optional, nullable policy
objects under `conversation_engine.type: hosted_agent`:

- `session_warmup` permits eligible calls to use service-managed prewarmed Hosted
  Sessions. It does not enable multiplexing, Agent startup model warmup, or
  language-model inference warmup.
- `session_multiplexing` permits independent calls to share a compatible Hosted
  Session. The application must support concurrent connections and isolate mutable
  state per call.

For each property, omission or `null` disables the optimization;
`{"type": "auto"}` permits the service-managed optimization using existing
service and authorized target settings. The policies default to `null` and are
independent. Omission, explicit `null`, and policy objects remain distinct through
definition/version round-trips.

The named policy models have a required `type` property whose only supported value
is `auto`. Empty objects, booleans, bare strings (including `"auto"`), unsupported
types, and additional object properties are rejected. Pool size and maximum
concurrent calls are not configurable through these objects in this revision.
The object shape leaves room for future reviewed settings and policy types; it
does not make unspecified properties valid now.

Neither property belongs on the Voice Agent root, the generic conversation-engine
base, a model-backed/native Live definition, a Hosted Agent manifest/protocol
record, or a Bridge message. The service rejects misplaced root properties even
when `null`. The earlier draft's boolean property names are not public aliases;
private runtime features are not public configuration properties.

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
The revised names and nullable-object shape require matching TypeSpec-derived
SDKs, Vienna serialization/materialization and policy-to-feature mapping, and
Voice Live definition recognition and independent allocation support. Earlier
boolean implementations do not establish support for this contract. Deploy and
verify compatible receivers before sending revised definitions; schema
recognition alone does not establish runtime support. Matching nested-field
recognition also avoids advisory definition-validation errors.

Before enabling either optimization, verify existing target eligibility,
authorization/RBAC, networking, quota/capacity, and coordination TTL/index settings,
including the shared-candidate composite index
`used_slots DESC, created_at ASC, id ASC`. No new infrastructure configuration is
introduced here, and local schema validation is not deployment validation.
