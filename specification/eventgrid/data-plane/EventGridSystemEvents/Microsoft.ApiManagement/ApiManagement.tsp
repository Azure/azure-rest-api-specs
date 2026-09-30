import "./ApiManagementExample.tsp";
using TypeSpec.Versioning;

/** Describes the schema of the Azure API Management events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserCreated event. */
@example(MicrosoftApiManagementUserCreatedExample)
model ApiManagementUserCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserUpdated event. */
@example(MicrosoftApiManagementUserUpdatedExample)
model ApiManagementUserUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserDeleted event. */
@example(MicrosoftApiManagementUserDeletedExample)
model ApiManagementUserDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionCreated event. */
@example(MicrosoftApiManagementSubscriptionCreatedExample)
model ApiManagementSubscriptionCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionUpdated event. */
@example(MicrosoftApiManagementSubscriptionUpdatedExample)
model ApiManagementSubscriptionUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionDeleted event. */
@example(MicrosoftApiManagementSubscriptionDeletedExample)
model ApiManagementSubscriptionDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductCreated event. */
@example(MicrosoftApiManagementProductCreatedExample)
model ApiManagementProductCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductUpdated event. */
@example(MicrosoftApiManagementProductUpdatedExample)
model ApiManagementProductUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductDeleted event. */
@example(MicrosoftApiManagementProductDeletedExample)
model ApiManagementProductDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APICreated event. */
@example(MicrosoftApiManagementAPICreatedExample)
model ApiManagementApiCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIUpdated event. */
@example(MicrosoftApiManagementAPIUpdatedExample)
model ApiManagementApiUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIDeleted event. */
@example(MicrosoftApiManagementAPIDeletedExample)
model ApiManagementApiDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseCreated event. */
@example(MicrosoftApiManagementAPIReleaseCreatedExample)
model ApiManagementApiReleaseCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseUpdated event. */
@example(MicrosoftApiManagementAPIReleaseUpdatedExample)
model ApiManagementApiReleaseUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseDeleted event. */
@example(MicrosoftApiManagementAPIReleaseDeletedExample)
model ApiManagementApiReleaseDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCreated event. */
@example(MicrosoftApiManagementGatewayCreatedExample)
model ApiManagementGatewayCreatedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayUpdated event. */
@example(MicrosoftApiManagementGatewayUpdatedExample)
model ApiManagementGatewayUpdatedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayDeleted event. */
@example(MicrosoftApiManagementGatewayDeletedExample)
model ApiManagementGatewayDeletedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationCreated event. */
@example(MicrosoftApiManagementGatewayHostnameConfigurationCreatedExample)
model ApiManagementGatewayHostnameConfigurationCreatedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationUpdated event. */
@example(MicrosoftApiManagementGatewayHostnameConfigurationUpdatedExample)
model ApiManagementGatewayHostnameConfigurationUpdatedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationDeleted event. */
@example(MicrosoftApiManagementGatewayHostnameConfigurationDeletedExample)
model ApiManagementGatewayHostnameConfigurationDeletedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityCreated event. */
@example(MicrosoftApiManagementGatewayCertificateAuthorityCreatedExample)
model ApiManagementGatewayCertificateAuthorityCreatedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityUpdated event. */
@example(MicrosoftApiManagementGatewayCertificateAuthorityUpdatedExample)
model ApiManagementGatewayCertificateAuthorityUpdatedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityDeleted event. */
@example(MicrosoftApiManagementGatewayCertificateAuthorityDeletedExample)
model ApiManagementGatewayCertificateAuthorityDeletedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayAPIAdded event. */
@example(MicrosoftApiManagementGatewayAPIAddedExample)
model ApiManagementGatewayApiAddedEventData {
  ...ApiGatewayApiBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayAPIRemoved event. */
@example(MicrosoftApiManagementGatewayAPIRemovedExample)
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
  rules: Record<Record<unknown>>;
}

/** Information related to a gateway token that has expired for a self-hosted gateway deployment. */
model ApiManagementExpiredGatewayTokenProperties {
  /** Timestamp when the gateway token has expired. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  expiredAtUtc: utcDateTime;
}

/** Information related to a gateway token that is near expiry for a self-hosted gateway deployment. */
model ApiManagementNearExpiryGatewayTokenProperties {
  /** Timestamp when the gateway token will expire. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
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
