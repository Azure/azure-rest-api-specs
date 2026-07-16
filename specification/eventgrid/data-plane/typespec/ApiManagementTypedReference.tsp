@doc("Describes the schema of the Azure API Management events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid.ApiManagement {
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserCreated event.")
  model ApiManagementUserCreatedEventData {
    ...BaseEventData;
  }

  model ApiManagementUserCreatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.UserCreated",
      ApiManagementUserCreatedEventData
    >;
  model ApiManagementUserCreatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.UserCreated",
      ApiManagementUserCreatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserUpdated event.")
  model ApiManagementUserUpdatedEventData {
    ...BaseEventData;
  }

  model ApiManagementUserUpdatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.UserUpdated",
      ApiManagementUserUpdatedEventData
    >;
  model ApiManagementUserUpdatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.UserUpdated",
      ApiManagementUserUpdatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserDeleted event.")
  model ApiManagementUserDeletedEventData {
    ...BaseEventData;
  }

  model ApiManagementUserDeletedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.UserDeleted",
      ApiManagementUserDeletedEventData
    >;
  model ApiManagementUserDeletedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.UserDeleted",
      ApiManagementUserDeletedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionCreated event.")
  model ApiManagementSubscriptionCreatedEventData {
    ...BaseEventData;
  }

  model ApiManagementSubscriptionCreatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.SubscriptionCreated",
      ApiManagementSubscriptionCreatedEventData
    >;
  model ApiManagementSubscriptionCreatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.SubscriptionCreated",
      ApiManagementSubscriptionCreatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionUpdated event.")
  model ApiManagementSubscriptionUpdatedEventData {
    ...BaseEventData;
  }

  model ApiManagementSubscriptionUpdatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.SubscriptionUpdated",
      ApiManagementSubscriptionUpdatedEventData
    >;
  model ApiManagementSubscriptionUpdatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.SubscriptionUpdated",
      ApiManagementSubscriptionUpdatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionDeleted event.")
  model ApiManagementSubscriptionDeletedEventData {
    ...BaseEventData;
  }

  model ApiManagementSubscriptionDeletedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.SubscriptionDeleted",
      ApiManagementSubscriptionDeletedEventData
    >;
  model ApiManagementSubscriptionDeletedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.SubscriptionDeleted",
      ApiManagementSubscriptionDeletedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductCreated event.")
  model ApiManagementProductCreatedEventData {
    ...BaseEventData;
  }

  model ApiManagementProductCreatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ProductCreated",
      ApiManagementProductCreatedEventData
    >;
  model ApiManagementProductCreatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ProductCreated",
      ApiManagementProductCreatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductUpdated event.")
  model ApiManagementProductUpdatedEventData {
    ...BaseEventData;
  }

  model ApiManagementProductUpdatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ProductUpdated",
      ApiManagementProductUpdatedEventData
    >;
  model ApiManagementProductUpdatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ProductUpdated",
      ApiManagementProductUpdatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductDeleted event.")
  model ApiManagementProductDeletedEventData {
    ...BaseEventData;
  }

  model ApiManagementProductDeletedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ProductDeleted",
      ApiManagementProductDeletedEventData
    >;
  model ApiManagementProductDeletedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ProductDeleted",
      ApiManagementProductDeletedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APICreated event.")
  model ApiManagementApiCreatedEventData {
    ...BaseEventData;
  }

  model ApiManagementApiCreatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ApiCreated",
      ApiManagementApiCreatedEventData
    >;
  model ApiManagementApiCreatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ApiCreated",
      ApiManagementApiCreatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIUpdated event.")
  model ApiManagementApiUpdatedEventData {
    ...BaseEventData;
  }

  model ApiManagementApiUpdatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ApiUpdated",
      ApiManagementApiUpdatedEventData
    >;
  model ApiManagementApiUpdatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ApiUpdated",
      ApiManagementApiUpdatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIDeleted event.")
  model ApiManagementApiDeletedEventData {
    ...BaseEventData;
  }

  model ApiManagementApiDeletedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ApiDeleted",
      ApiManagementApiDeletedEventData
    >;
  model ApiManagementApiDeletedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ApiDeleted",
      ApiManagementApiDeletedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseCreated event.")
  model ApiManagementApiReleaseCreatedEventData {
    ...BaseEventData;
  }

  model ApiManagementApiReleaseCreatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ApiReleaseCreated",
      ApiManagementApiReleaseCreatedEventData
    >;
  model ApiManagementApiReleaseCreatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ApiReleaseCreated",
      ApiManagementApiReleaseCreatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseUpdated event.")
  model ApiManagementApiReleaseUpdatedEventData {
    ...BaseEventData;
  }

  model ApiManagementApiReleaseUpdatedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ApiReleaseUpdated",
      ApiManagementApiReleaseUpdatedEventData
    >;
  model ApiManagementApiReleaseUpdatedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ApiReleaseUpdated",
      ApiManagementApiReleaseUpdatedEventData
    >;

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseDeleted event.")
  model ApiManagementApiReleaseDeletedEventData {
    ...BaseEventData;
  }

  model ApiManagementApiReleaseDeletedEvent
    is EventGrid.TypedEventGridEvent<
      "Microsoft.ApiManagement.ApiReleaseDeleted",
      ApiManagementApiReleaseDeletedEventData
    >;
  model ApiManagementApiReleaseDeletedEventCloud
    is EventGrid.TypedCloudEvent<
      "Microsoft.ApiManagement.ApiReleaseDeleted",
      ApiManagementApiReleaseDeletedEventData
    >;

  alias BaseEventData = {
    @doc("The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/<ResourceType>/<ResourceName>`")
    resourceUri?: string;
  };
}
