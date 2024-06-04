/** Describes the schema of the Azure API Management events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;
/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserCreated event. */
model ApiManagementUserCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserUpdated event. */
model ApiManagementUserUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserDeleted event. */
model ApiManagementUserDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionCreated event. */
model ApiManagementSubscriptionCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionUpdated event. */
model ApiManagementSubscriptionUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionDeleted event. */
model ApiManagementSubscriptionDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductCreated event. */
model ApiManagementProductCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductUpdated event. */
model ApiManagementProductUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductDeleted event. */
model ApiManagementProductDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APICreated event. */
model ApiManagementApiCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIUpdated event. */
model ApiManagementApiUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIDeleted event. */
model ApiManagementApiDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseCreated event. */
model ApiManagementApiReleaseCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseUpdated event. */
model ApiManagementApiReleaseUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseDeleted event. */
model ApiManagementApiReleaseDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCreated event. */
model ApiManagementGatewayCreatedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayUpdated event. */
model ApiManagementGatewayUpdatedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayDeleted event. */
model ApiManagementGatewayDeletedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationCreated event. */
model ApiManagementGatewayHostnameConfigurationCreatedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationUpdated event. */
model ApiManagementGatewayHostnameConfigurationUpdatedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationDeleted event. */
model ApiManagementGatewayHostnameConfigurationDeletedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityCreated event. */
model ApiManagementGatewayCertificateAuthorityCreatedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityUpdated event. */
model ApiManagementGatewayCertificateAuthorityUpdatedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityDeleted event. */
model ApiManagementGatewayCertificateAuthorityDeletedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayAPIAdded event. */
model ApiManagementGatewayApiAddedEventData {
  ...ApiGatewayApiBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayAPIRemoved event. */
model ApiManagementGatewayApiRemovedEventData {
  ...ApiGatewayApiBase;
}

alias ApiManagementBase = {
  /** The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/<ResourceType>/<ResourceName>` */
  resourceUri?: string;
};

alias ApiGatewayBase = {
  /** The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateways/<ResourceName>` */
  resourceUri?: string;
};

alias ApiGatewayHostnameBase = {
  /** The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateways/<GatewayName>/hostnameConfigurations/<ResourceName>` */
  resourceUri?: string;
};

alias ApiGatewayCertificateBase = {
  /** The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateways/<GatewayName>/certificateAuthorities/<ResourceName>` */
  resourceUri?: string;
};

alias ApiGatewayApiBase = {
  /** The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateways/<GatewayName>/apis/<ResourceName>` */
  resourceUri?: string;
};
