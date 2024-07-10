/** Describes the schema of the Azure EventGrid events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** EventGrid MQTT Client State */
union EventGridMQTTClientState {
  /** Enabled */
  "Enabled",

  /** Disabled */
  "Disabled",

  string,
}

/** EventGrid MQTT Client Disconnection Reason */
union EventGridMQTTClientDisconnectionReason {
  /** The client got disconnected for any authentication reasons (for example, certificate expired, client got disabled, or client configuration changed). */
  "ClientAuthenticationError",

  /** The client got disconnected for any authorization reasons (for example, because of a change in the configuration of topic spaces, permission bindings, or client groups). */
  "ClientAuthorizationError",

  /** The client sent a bad request or used one of the unsupported features that resulted in a connection termination by the service. */
  "ClientError",

  /** The client initiated a graceful disconnect through a DISCONNECT packet for MQTT or a close frame for MQTT over WebSocket. */
  "ClientInitiatedDisconnect",

  /** The client-server connection is lost. (EXCHANGE ONLINE PROTECTION). */
  "ConnectionLost",

  /** The client's IP address is blocked by IP filter or Private links configuration. */
  "IpForbidden",

  /** The client exceeded one or more of the throttling limits that resulted in a connection termination by the service. */
  "QuotaExceeded",

  /** The connection got terminated due to an unexpected server error. */
  "ServerError",

  /** The server initiates a graceful disconnect for any operational reason. */
  "ServerInitiatedDisconnect",

  /** The client's queue for unacknowledged QoS1 messages reached its limit, which resulted in a connection termination by the server. */
  "SessionOverflow",

  /** The client reconnected with the same authentication name, which resulted in the termination of the previous connection. */
  "SessionTakenOver",

  string,
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.EventGrid.SubscriptionValidationEvent event. */
model SubscriptionValidationEventData {
  /** The validation code sent by Azure Event Grid to validate an event subscription.
   * To complete the validation handshake, the subscriber must either respond with this validation code as part of the validation response,
   * or perform a GET request on the validationUrl (available starting version 2018-05-01-preview). */
  validationCode?: string;

  /** The validation URL sent by Azure Event Grid (available starting version 2018-05-01-preview).
   * To complete the validation handshake, the subscriber must either respond with the validationCode as part of the validation response,
   * or perform a GET request on the validationUrl (available starting version 2018-05-01-preview). */
  validationUrl?: string;
}

/**
To complete an event subscription validation handshake, a subscriber can use
either the validationCode or the validationUrl received in a
SubscriptionValidationEvent. When the validationCode is used, the
SubscriptionValidationResponse can be used to build the response.
*/
model SubscriptionValidationResponse {
  /** The validation response sent by the subscriber to Azure Event Grid to complete the validation of an event subscription. */
  validationResponse?: string;
}

/** 
Schema of the Data property of an EventGridEvent for a
Microsoft.EventGrid.SubscriptionDeletedEvent event.
*/
model SubscriptionDeletedEventData {
  /** The Azure resource ID of the deleted event subscription. */
  eventSubscriptionId?: string;
}

/** Event data for Microsoft.EventGrid.MQTTClientCreatedOrUpdated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Following Swagger Inheritance"
#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
model EventGridMQTTClientCreatedOrUpdatedEventData
  extends EventGridMQTTClientEventData {
  /** Configured state of the client. The value could be Enabled or Disabled */
  state: EventGridMQTTClientState;

  /** Time the client resource is created based on the provider's UTC time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn: utcDateTime;

  /** 
Time the client resource is last updated based on the provider's UTC time. If
the client resource was never updated, this value is identical to the value of
the 'createdOn' property.
*/
  updatedOn: utcDateTime;

  /** The key-value attributes that are assigned to the client resource. */
  attributes: Record<string>;
}

/** Schema of the Data property of an EventGridEvent for MQTT Client state changes. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
model EventGridMQTTClientEventData {
  /** 
Unique identifier for the MQTT client that the client presents to the service
for authentication. This case-sensitive string can be up to 128 characters
long, and supports UTF-8 characters.
*/
  clientAuthenticationName?: string;

  /** Name of the client resource in the Event Grid namespace. */
  clientName?: string;

  /** Name of the Event Grid namespace where the MQTT client was created or updated. */
  namespaceName?: string;
}

/** Event data for Microsoft.EventGrid.MQTTClientDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Following Swagger Inheritance"
#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
model EventGridMQTTClientDeletedEventData
  extends EventGridMQTTClientEventData {}

/** Event data for Microsoft.EventGrid.MQTTClientSessionConnected event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Following Swagger Inheritance"
#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
model EventGridMQTTClientSessionConnectedEventData
  extends EventGridMQTTClientEventData {
  /** 
Unique identifier for the MQTT client's session. This case-sensitive string can
be up to 128 characters long, and supports UTF-8 characters.
*/
  clientSessionName?: string;

  /**
A number that helps indicate order of MQTT client session connected or
disconnected events. Latest event will have a sequence number that is higher
than the previous event.
*/
  sequenceNumber?: int64;
}

/** Event data for Microsoft.EventGrid.MQTTClientSessionDisconnected event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Following Swagger Inheritance"
#suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
model EventGridMQTTClientSessionDisconnectedEventData
  extends EventGridMQTTClientEventData {
  /**
Unique identifier for the MQTT client's session. This case-sensitive string can
be up to 128 characters long, and supports UTF-8 characters.
*/
  clientSessionName?: string;

  /**
A number that helps indicate order of MQTT client session connected or
disconnected events. Latest event will have a sequence number that is higher
than the previous event.
*/
  sequenceNumber?: int64;

  /**
Reason for the disconnection of the MQTT client's session. The value could be
one of the values in the disconnection reasons table.
*/
  disconnectionReason: EventGridMQTTClientDisconnectionReason;
}
