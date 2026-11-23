# External conversation engines

For `v1`, a Realtime Voice Agent can select a customer-hosted conversation engine
with `conversation_engine.type: external_endpoint` and the required
`project_connection_id`. Use a Connection name, or a full Connection ARM resource
ID in the Voice Agent's own project. The supplied reference is preserved on readback.

The Connection must already exist and bind the complete public WSS endpoint to
its external-service credential. The service must authorize Connection use and
reject malformed or out-of-project references. These scope checks require runtime
validation; the schema alone cannot verify them.

The external variant accepts only `type` and `project_connection_id`. It does not
accept Hosted Agent `name`/`version`, inline URLs or headers, credentials, or Hosted
Session allocation policies. Existing model/engine exclusivity rules still apply;
the external engine owns reasoning and application state while Voice Live owns speech.

Examples show a [Connection name](../../examples/v1/Agents_CreateVoiceAgent_ExternalEndpoint.json)
and a [full same-project ARM ID](../../examples/v1/Agents_CreateVoiceAgent_ExternalEndpointConnectionId.json).
Both assume an authorized `customer-ce` Connection and preserve the reference in
the complete request and response.

This contract does not deploy the external service or platform support. Matching
Vienna Connection resolution and Voice Live external transport support must be
available before use; Connection configuration is not a network proxy or proof of
reachability. Verify authorization, egress/TLS, endpoint authentication, and per-call
isolation in the target environment. No infrastructure or deployment configuration
is changed here.
