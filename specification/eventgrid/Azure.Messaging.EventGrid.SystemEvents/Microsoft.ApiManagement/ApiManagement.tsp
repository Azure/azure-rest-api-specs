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

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.CircuitBreaker.Opened event. */
model ApiManagementCircuitBreakerOpenedEventData {
  /** Name of the backend for which the circuit has opened. */
  backendName: string;

  /** Information related to the circuit breaker configured on the backend. */
  circuitBreaker: ApiManagementCircuitBreakerProperties;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.CircuitBreaker.Closed event. */
model ApiManagementCircuitBreakerClosedEventData {
  /** Name of the backend for which the circuit has closed. */
  backendName: string;

  /** Information related to the circuit breaker configured on the backend. */
  circuitBreaker: ApiManagementCircuitBreakerProperties;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayTokenNearExpiry event. */
model ApiManagementGatewayTokenNearExpiryEventData {
  /** Information related to a given self-hosted gateway deployment. */
  gatewayInfo: ApiManagementGatewayProperties;

  /** Information related to a an expired gateway token for a self-hosted gateway deployment. */
  tokenInfo: ApiManagementNearExpiryGatewayTokenProperties;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayTokenExpired event. */
model ApiManagementGatewayTokenExpiredEventData {
  /** Information related to a given self-hosted gateway deployment. */
  gatewayInfo: ApiManagementGatewayProperties;

  /** Information related to a an expired gateway token for a self-hosted gateway deployment. */
  tokenInfo: ApiManagementExpiredGatewayTokenProperties;
}

/** Information related to the circuit breaker configured on the backend. */
model ApiManagementCircuitBreakerProperties {
  /** Overview of all configured rules and respective details. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Type is Object in swagger, we cannot define full schema given customer owns the rule names"
  rules: Record<{}>;
}

/** Information related to a gateway token that has expired for a self-hosted gateway deployment. */
model ApiManagementExpiredGatewayTokenProperties {
  /** Timestamp when the gateway token has expired. */
  expiredAtUtc: utcDateTime;
}

/** Information related to a gateway token that is near expiry for a self-hosted gateway deployment. */
model ApiManagementNearExpiryGatewayTokenProperties {
  /** Timestamp when the gateway token will expire. */
  expiredAtUtc: utcDateTime;
}

/** Information related to a given self-hosted gateway deployment. */
model ApiManagementGatewayProperties {
  /** Id of Gateway that is used to deploy the gateway to get the configuration for. This is the ARM resource ID referenced in the Azure API Management instance. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateway/<GatewayName>` */
  gatewayId: string;

  /** Unique instance ID of the deployed gateway */
  instanceId: string;
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
