namespace EventGrid {
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.EventGrid.SubscriptionValidationEvent event.")
  model SubscriptionValidationEventData {
    @doc("The validation code sent by Azure Event Grid to validate an event subscription. To complete the validation handshake, the subscriber must either respond with this validation code as part of the validation response, or perform a GET request on the validationUrl (available starting version 2018-05-01-preview).")
    @visibility("read")
    validationCode?: string;

    @doc("The validation URL sent by Azure Event Grid (available starting version 2018-05-01-preview). To complete the validation handshake, the subscriber must either respond with the validationCode as part of the validation response, or perform a GET request on the validationUrl (available starting version 2018-05-01-preview).")
    @visibility("read")
    validationUrl?: string;
  }

  @doc("To complete an event subscription validation handshake, a subscriber can use either the validationCode or the validationUrl received in a SubscriptionValidationEvent. When the validationCode is used, the SubscriptionValidationResponse can be used to build the response.")
  model SubscriptionValidationResponse {
    @doc("The validation response sent by the subscriber to Azure Event Grid to complete the validation of an event subscription.")
    validationResponse?: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.EventGrid.SubscriptionDeletedEvent event.")
  model SubscriptionDeletedEventData {
    @doc("The Azure resource ID of the deleted event subscription.")
    @visibility("read")
    eventSubscriptionId?: string;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
  @doc("Schema of the Data property of an EventGridEvent for MQTT Client Session Disconnected.")
  model MQTTClientSessionDisconnectedEventProperties {
    @doc("Unique identifier for the MQTT client that the client presents to the service for authentication. This case-insensitive string can be up to 128 characters long, and supports UTF-8 characters.")
    clientAuthenticationName ?: string;

    @doc("Unique identifier for the MQTT client's session. This case-sensitive string can be up to 128 characters long, and supports UTF-8 characters.")
    clientSessionName ?: string;

    @doc("Name of the Event Grid namespace where the MQTT client was disconnected.")
    namespaceName ?: string;

    @doc("A number that helps indicate order of MQTT client session connected or disconnected events. Latest event will have a sequence number that is higher than the previous event.")
    sequenceNumber ?: string;

    @doc("Reason for the disconnection of the MQTT client's session. The value could be one of the values in the disconnection reasons table.")
    disconnectionReason: string;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
  @doc("Schema of the Data property of an EventGridEvent for MQTT Client Session Connected event.")
  model MQTTClientSessionConnectedEventProperties {
    @doc("Unique identifier for the MQTT client that the client presents to the service for authentication. This case-insensitive string can be up to 128 characters long, and supports UTF-8 characters.")
    clientAuthenticationName ?: string;

    @doc("Unique identifier for the MQTT client's session. This case-sensitive string can be up to 128 characters long, and supports UTF-8 characters.")
    clientSessionName ?: string;

    @doc("Name of the Event Grid namespace where the MQTT client was connected.")
    namespaceName ?: string;

    @doc("A number that helps indicate order of MQTT client session connected or disconnected events. Latest event will have a sequence number that is higher than the previous event.")
    sequenceNumber ?: string;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
  @doc("Schema of the Data property of an EventGridEvent for MQTT Client Deleted event.")
  model MQTTClientDeletedEventProperties {
    @doc("Unique identifier for the MQTT client that the client presents to the service for authentication. This case-insensitive string can be up to 128 characters long, and supports UTF-8 characters.")
    clientAuthenticationName ?: string;

    @doc("Name of the client resource in the Event Grid namespace.")
    clientName ?: string;

    @doc("Name of the Event Grid namespace where the MQTT client was deleted.")
    namespaceName ?: string;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
  @doc("Schema of the Data property of an EventGridEvent for MQTT Client Created Or Updated event.")
  model MQTTClientCreatedOrUpdatedEventProperties {
    @doc("Unique identifier for the MQTT client that the client presents to the service for authentication. This case-insensitive string can be up to 128 characters long, and supports UTF-8 characters.")
    clientAuthenticationName ?: string;

    @doc("Name of the client resource in the Event Grid namespace.")
    clientName ?: string;

    @doc("Name of the Event Grid namespace where the MQTT client was created or updated.")
    namespaceName ?: string;

    @doc("Configured state of the client. The value could be Enabled or Disabled.")
    state ?: string;

    @doc("Time the client resource is created based on the provider's UTC time.")
    createdOn ?: string;

    @doc("Time the client resource is last updated based on the provider's UTC time. If the client resource was never updated, this value is identical to the value of the `createdOn` property.")
    updatedOn ?: string;

    @doc("The key-value attributes that are assigned to the client resource.")
    attributes ?: Record<string>;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
  @doc("Event data for Microsoft.EventGrid.MQTTClientSessionDisconnected event.")
  model EventGridNamespaceMQTTClientSessionDisconnectedEventData {
    ...MQTTClientSessionDisconnectedEventProperties;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
  @doc("Event data for Microsoft.EventGrid.MQTTClientSessionConnected event.")
  model EventGridNamespaceMQTTClientSessionConnectedEventData {
    ...MQTTClientSessionConnectedEventProperties;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
  @doc("Event data for Microsoft.EventGrid.MQTTClientDeleted event.")
  model EventGridNamespaceMQTTClientDeletedEventData {
    ...MQTTClientDeletedEventProperties;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MQTT is an acronym and should be all caps"
  @doc("Event data for Microsoft.EventGrid.MQTTClientCreatedOrUpdated event.")
  model EventGridNamespaceMQTTClientCreatedOrUpdatedEventData {
    ...MQTTClientCreatedOrUpdatedEventProperties;
  }


}
