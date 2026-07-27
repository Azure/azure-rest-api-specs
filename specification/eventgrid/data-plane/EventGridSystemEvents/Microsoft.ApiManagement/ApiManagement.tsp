import "./ApiManagementExample.tsp";
using TypeSpec.Versioning;

/** Describes the schema of the Azure API Management events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserCreated event. */
@example(MicrosoftApiManagementUserCreatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementUserCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserUpdated event. */
@example(MicrosoftApiManagementUserUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementUserUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserDeleted event. */
@example(MicrosoftApiManagementUserDeletedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementUserDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionCreated event. */
@example(MicrosoftApiManagementSubscriptionCreatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementSubscriptionCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionUpdated event. */
@example(MicrosoftApiManagementSubscriptionUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementSubscriptionUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionDeleted event. */
@example(MicrosoftApiManagementSubscriptionDeletedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementSubscriptionDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductCreated event. */
@example(MicrosoftApiManagementProductCreatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementProductCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductUpdated event. */
@example(MicrosoftApiManagementProductUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementProductUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductDeleted event. */
@example(MicrosoftApiManagementProductDeletedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementProductDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APICreated event. */
@example(MicrosoftApiManagementAPICreatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementApiCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIUpdated event. */
@example(MicrosoftApiManagementAPIUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementApiUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIDeleted event. */
@example(MicrosoftApiManagementAPIDeletedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementApiDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseCreated event. */
@example(MicrosoftApiManagementAPIReleaseCreatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementApiReleaseCreatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseUpdated event. */
@example(MicrosoftApiManagementAPIReleaseUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementApiReleaseUpdatedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseDeleted event. */
@example(MicrosoftApiManagementAPIReleaseDeletedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementApiReleaseDeletedEventData {
  ...ApiManagementBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCreated event. */
@example(MicrosoftApiManagementGatewayCreatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayCreatedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayUpdated event. */
@example(MicrosoftApiManagementGatewayUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayUpdatedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayDeleted event. */
@example(MicrosoftApiManagementGatewayDeletedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayDeletedEventData {
  ...ApiGatewayBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationCreated event. */
@example(MicrosoftApiManagementGatewayHostnameConfigurationCreatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayHostnameConfigurationCreatedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationUpdated event. */
@example(MicrosoftApiManagementGatewayHostnameConfigurationUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayHostnameConfigurationUpdatedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationDeleted event. */
@example(MicrosoftApiManagementGatewayHostnameConfigurationDeletedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayHostnameConfigurationDeletedEventData {
  ...ApiGatewayHostnameBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityCreated event. */
@example(MicrosoftApiManagementGatewayCertificateAuthorityCreatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayCertificateAuthorityCreatedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityUpdated event. */
@example(MicrosoftApiManagementGatewayCertificateAuthorityUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayCertificateAuthorityUpdatedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityDeleted event. */
@example(MicrosoftApiManagementGatewayCertificateAuthorityDeletedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayCertificateAuthorityDeletedEventData {
  ...ApiGatewayCertificateBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayAPIAdded event. */
@example(MicrosoftApiManagementGatewayAPIAddedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayApiAddedEventData {
  ...ApiGatewayApiBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayAPIRemoved event. */
@example(MicrosoftApiManagementGatewayAPIRemovedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayApiRemovedEventData {
  ...ApiGatewayApiBase;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.CircuitBreaker.Opened event. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementCircuitBreakerOpenedEventData {
  /** Name of the backend for which the circuit has opened. */
  backendName: string;

  /** Information related to the circuit breaker configured on the backend. */
  circuitBreaker: ApiManagementCircuitBreakerProperties;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.CircuitBreaker.Closed event. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementCircuitBreakerClosedEventData {
  /** Name of the backend for which the circuit has closed. */
  backendName: string;

  /** Information related to the circuit breaker configured on the backend. */
  circuitBreaker: ApiManagementCircuitBreakerProperties;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayTokenNearExpiry event. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayTokenNearExpiryEventData {
  /** Information related to a given self-hosted gateway deployment. */
  gatewayInfo: ApiManagementGatewayProperties;

  /** Information related to a an expired gateway token for a self-hosted gateway deployment. */
  tokenInfo: ApiManagementNearExpiryGatewayTokenProperties;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayTokenExpired event. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementGatewayTokenExpiredEventData {
  /** Information related to a given self-hosted gateway deployment. */
  gatewayInfo: ApiManagementGatewayProperties;

  /** Information related to a an expired gateway token for a self-hosted gateway deployment. */
  tokenInfo: ApiManagementExpiredGatewayTokenProperties;
}

/** Information related to the circuit breaker configured on the backend. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiManagementCircuitBreakerProperties {
  /** Overview of all configured rules and respective details. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Type is Object in swagger, we cannot define full schema given customer owns the rule names"
  rules: Record<Record<unknown>>;
}

/** Information related to a gateway token that has expired for a self-hosted gateway deployment. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
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
