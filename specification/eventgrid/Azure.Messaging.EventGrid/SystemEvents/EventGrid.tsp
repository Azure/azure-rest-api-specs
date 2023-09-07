@doc(""Describes the schema of the Azure EventGrid events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid;

@doc("EventGrid MQTT Client State")
enum EventGridMQTTClientState {
  @doc("Enabled")
  Enabled,

  @doc("Disabled")
  Disabled,
}

@doc("EventGrid MQTT Client Disconnection Reason")
enum EventGridMQTTClientDisconnectionReason {
  @doc("""
The client got disconnected for any authentication reasons (for example,
certificate expired, client got disabled, or client configuration changed).
""")
  ClientAuthenticationError,

  @doc("""
The client got disconnected for any authorization reasons (for example, because
of a change in the configuration of topic spaces, permission bindings, or
client groups).
""")
  ClientAuthorizationError,

  @doc("""
The client sent a bad request or used one of the unsupported features that
resulted in a connection termination by the service.
""")
  ClientError,

  @doc("""
The client initiates a graceful disconnect through a DISCONNECT packet for MQTT
or a close frame for MQTT over WebSocket.
""")
  ClientInitiatedDisconnect,

  @doc("The client-server connection is lost. (EXCHANGE ONLINE PROTECTION).")
  ConnectionLost,

  @doc("The client's IP address is blocked by IP filter or Private links configuration.")
  IpForbidden,

  @doc("""
The client exceeded one or more of the throttling limits that resulted in a
connection termination by the service.
""")
  QuotaExceeded,

  @doc("The connection got terminated due to an unexpected server error.")
  ServerError,

  @doc("The server initiates a graceful disconnect for any operational reason.")
  ServerInitiatedDisconnect,

  @doc("""
The client's queue for unacknowledged QoS1 messages reached its limit, which
resulted in a connection termination by the server.
""")
  SessionOverflow,

  @doc("""
The client reconnected with the same authentication name, which resulted in the
termination of the previous connection.
""")
  SessionTakenOver,
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.EventGrid.SubscriptionValidationEvent event.
""")
model SubscriptionValidationEventData {
  @doc("""
The validation code sent by Azure Event Grid to validate an event subscription.
To complete the validation handshake, the subscriber must either respond with
this validation code as part of the validation response, or perform a GET
request on the validationUrl (available starting version 2018-05-01-preview).
""")
  @visibility("read")
  validationCode?: string;

  @doc("""
The validation URL sent by Azure Event Grid (available starting version
2018-05-01-preview). To complete the validation handshake, the subscriber must
either respond with the validationCode as part of the validation response, or
perform a GET request on the validationUrl (available starting version
2018-05-01-preview).
""")
  @visibility("read")
  validationUrl?: string;
}

@doc("""
To complete an event subscription validation handshake, a subscriber can use
either the validationCode or the validationUrl received in a
SubscriptionValidationEvent. When the validationCode is used, the
SubscriptionValidationResponse can be used to build the response.
""")
model SubscriptionValidationResponse {
  @doc("""
The validation response sent by the subscriber to Azure Event Grid to complete
the validation of an event subscription.
""")
  validationResponse?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.EventGrid.SubscriptionDeletedEvent event.
""")
model SubscriptionDeletedEventData {
  @doc("The Azure resource ID of the deleted event subscription.")
  @visibility("read")
  eventSubscriptionId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
@doc("Event data for Microsoft.EventGrid.MQTTClientCreatedOrUpdated event.")
model EventGridMQTTClientCreatedOrUpdatedEventData {
  ...EventGridMQTTClientEventData;

  @doc("Configured state of the client. The value could be Enabled or Disabled")
  state?: EventGridMQTTClientState;

  @doc("Time the client resource is created based on the provider's UTC time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("""
Time the client resource is last updated based on the provider's UTC time. If
the client resource was never updated, this value is identical to the value of
the 'createdOn' property.
""")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedOn?: utcDateTime;

  @doc("The key-value attributes that are assigned to the client resource.")
  attributes?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
@doc("Schema of the Data property of an EventGridEvent for MQTT Client state changes.")
model EventGridMQTTClientEventData {
  @doc("""
Unique identifier for the MQTT client that the client presents to the service
for authentication. This case-sensitive string can be up to 128 characters
long, and supports UTF-8 characters.
""")
  clientAuthenticationName?: string;

  @doc("Name of the client resource in the Event Grid namespace.")
  clientName?: string;

  @doc("Name of the Event Grid namespace where the MQTT client was created or updated.")
  namespaceName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
@doc("Event data for Microsoft.EventGrid.MQTTClientDeleted event.")
model EventGridMQTTClientDeletedEventData {
  ...EventGridMQTTClientEventData;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
@doc("Event data for Microsoft.EventGrid.MQTTClientSessionConnected event.")
model EventGridMQTTClientSessionConnectedEventData {
  ...EventGridMQTTClientEventData;

  @doc("""
Unique identifier for the MQTT client's session. This case-sensitive string can
be up to 128 characters long, and supports UTF-8 characters.
""")
  clientSessionName?: string;

  @doc("""
A number that helps indicate order of MQTT client session connected or
disconnected events. Latest event will have a sequence number that is higher
than the previous event.
""")
  sequenceNumber?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
@doc("Event data for Microsoft.EventGrid.MQTTClientSessionDisconnected event.")
model EventGridMQTTClientSessionDisconnectedEventData {
  ...EventGridMQTTClientEventData;

  @doc("""
Unique identifier for the MQTT client's session. This case-sensitive string can
be up to 128 characters long, and supports UTF-8 characters.
""")
  clientSessionName?: string;

  @doc("""
A number that helps indicate order of MQTT client session connected or
disconnected events. Latest event will have a sequence number that is higher
than the previous event.
""")
  sequenceNumber?: int32;

  @doc("""
Reason for the disconnection of the MQTT client's session. The value could be
one of the values in the disconnection reasons table.
""")
  disconnectionReason?: EventGridMQTTClientDisconnectionReason;
}
