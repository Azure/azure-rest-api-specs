namespace EventGrid.EventGrid {
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
}
