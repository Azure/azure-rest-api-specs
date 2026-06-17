import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Devices;
using Azure.ResourceManager;
using Azure.Core;
using Http;

@@clientName(Microsoft.Devices, "IotHubClient", "javascript,java,python");
@@clientName(IotHubDescriptions.getEndpointHealth,
  "listEndpointHealth",
  "javascript"
);
@@clientName(IotHubDescriptions.getQuotaMetrics,
  "listQuotaMetrics",
  "javascript"
);
@@clientName(IotHubDescriptions.getValidSkus, "listValidSkus", "javascript");

@@clientName(Microsoft.Devices.IotHubProperties.hostName, "hostname", "java");
@@clientName(Microsoft.Devices.NetworkRuleIPAction,
  "NetworkRuleIpAction",
  "java"
);
@@clientName(Microsoft.Devices.IotHubProperties.disableModuleSAS,
  "disableModuleSas",
  "java"
);
@@clientName(Microsoft.Devices.IotHubProperties.disableDeviceSAS,
  "disableDeviceSas",
  "java"
);

// Keep legacy Go struct field names with "Iso8601" casing.
@@clientName(StorageEndpointProperties.sasTtlAsIso8601,
  "SasTTLAsIso8601",
  "go"
);
@@clientName(FeedbackProperties.lockDurationAsIso8601,
  "LockDurationAsIso8601",
  "go"
);
@@clientName(FeedbackProperties.ttlAsIso8601, "TTLAsIso8601", "go");
@@clientName(CloudToDeviceProperties.defaultTtlAsIso8601,
  "DefaultTTLAsIso8601",
  "go"
);
@@clientName(MessagingEndpointProperties.lockDurationAsIso8601,
  "LockDurationAsIso8601",
  "go"
);
@@clientName(MessagingEndpointProperties.ttlAsIso8601, "TTLAsIso8601", "go");

// C# migration customizations for Azure.ResourceManager.IotHub backward compatibility.
@@clientName(CertificateDescription, "IotHubCertificateDescription", "csharp");
@@clientName(CertificateProperties, "IotHubCertificateProperties", "csharp");
@@clientName(CertificateProperties.expiry, "ExpireOn", "csharp");
@@clientName(CertificateProperties.created, "CreatedOn", "csharp");
@@clientName(CertificateProperties.updated, "UpdatedOn", "csharp");
@@clientName(CertificateProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(CertificatePropertiesWithNonce,
  "IotHubCertificatePropertiesWithNonce",
  "csharp"
);
@@clientName(CertificatePropertiesWithNonce.expiry, "ExpireOn", "csharp");
@@clientName(CertificatePropertiesWithNonce.created, "CreatedOn", "csharp");
@@clientName(CertificatePropertiesWithNonce.updated, "UpdatedOn", "csharp");
@@clientName(CertificatePropertiesWithNonce.thumbprint,
  "ThumbprintString",
  "csharp"
);
@@clientName(CertificateWithNonceDescription,
  "IotHubCertificateWithNonceDescription",
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(CertificateWithNonceDescription,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
@@clientName(CertificateVerificationDescription,
  "IotHubCertificateVerificationContent",
  "csharp"
);
@@clientName(RootCertificateProperties,
  "IotHubRootCertificateProperties",
  "csharp"
);
@@clientName(PublicNetworkAccess, "IotHubPublicNetworkAccess", "csharp");
@@clientName(AuthenticationType, "IotHubAuthenticationType", "csharp");
@@clientName(PrivateLinkServiceConnectionStatus,
  "IotHubPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(IpFilterRule, "IotHubIPFilterRule", "csharp");
@@clientName(IpFilterRule.ipMask, "IPMask", "csharp");
@@clientName(IpFilterActionType, "IotHubIPFilterActionType", "csharp");
@@clientName(NetworkRuleSetProperties,
  "IotHubNetworkRuleSetProperties",
  "csharp"
);
@@clientName(NetworkRuleSetProperties.ipRules, "IPRules", "csharp");
@@clientName(DefaultAction, "IotHubNetworkRuleSetDefaultAction", "csharp");
@@clientName(NetworkRuleSetIpRule, "IotHubNetworkRuleSetIPRule", "csharp");
@@clientName(NetworkRuleSetIpRule.ipMask, "IPMask", "csharp");
@@clientName(NetworkRuleIPAction, "IotHubNetworkRuleIPAction", "csharp");
@@clientName(EventHubProperties,
  "EventHubCompatibleEndpointProperties",
  "csharp"
);
@@clientName(EventHubProperties.path, "EventHubCompatibleName", "csharp");
@@clientName(RoutingProperties, "IotHubRoutingProperties", "csharp");
@@clientName(RoutingSource, "IotHubRoutingSource", "csharp");
@@clientName(RoutingStorageContainerPropertiesEncoding.JSON, "Json", "csharp");
@@clientName(RouteProperties, "RoutingRuleProperties", "csharp");
@@clientName(FallbackRouteProperties,
  "IotHubFallbackRouteProperties",
  "csharp"
);
@@clientName(EnrichmentProperties, "IotHubEnrichmentProperties", "csharp");
@@clientName(StorageEndpointProperties,
  "IotHubStorageEndpointProperties",
  "csharp"
);
@@clientName(DeviceRegistry, "IotHubDeviceRegistry", "csharp");
@@clientName(EncryptionPropertiesDescription,
  "IotHubEncryptionProperties",
  "csharp"
);
@@clientName(KeyVaultKeyProperties, "IotHubKeyVaultKeyProperties", "csharp");
@@clientName(Capabilities, "IotHubCapability", "csharp");
@@clientName(IpVersion, "IotHubIPVersion", "csharp");
@@clientName(IpVersion.ipv4, "IPv4", "csharp");
@@clientName(IpVersion.ipv6, "IPv6", "csharp");
@@clientName(IpVersion.ipv4ipv6, "IPv4IPv6", "csharp");
@@clientName(IotHubSku.GEN2, "Gen2", "csharp");
@@clientName(AccessRights, "IotHubSharedAccessRight", "csharp");
@@clientName(FeedbackProperties,
  "CloudToDeviceFeedbackQueueProperties",
  "csharp"
);
@@clientName(RegistryStatistics, "IotHubRegistryStatistics", "csharp");
@@clientName(EndpointHealthData, "IotHubEndpointHealthInfo", "csharp");
@@clientName(EndpointHealthStatus, "IotHubEndpointHealthStatus", "csharp");
@@clientName(JobResponse, "IotHubJobInfo", "csharp");
@@clientName(JobResponse.startTimeUtc, "StartOn", "csharp");
@@clientName(JobResponse.endTimeUtc, "EndOn", "csharp");
@@clientName(JobResponse.type, "JobType", "csharp");
@@clientName(JobResponseListResult, "IotHubJobInfoListResult", "csharp");
@@clientName(JobType, "IotHubJobType", "csharp");
@@clientName(JobStatus, "IotHubJobStatus", "csharp");
@@clientName(OperationInputs, "IotHubNameAvailabilityContent", "csharp");
@@clientName(IotHubNameAvailabilityInfo,
  "IotHubNameAvailabilityResponse",
  "csharp"
);
@@clientName(IotHubNameAvailabilityInfo.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(IotHubNameUnavailabilityReason,
  "IotHubNameUnavailableReason",
  "csharp"
);
@@clientName(UserSubscriptionQuota, "IotHubUserSubscriptionQuota", "csharp");
@@clientName(UserSubscriptionQuota.id, "IotHubTypeId", "csharp");
@@clientName(UserSubscriptionQuota.type, "UserSubscriptionQuotaType", "csharp");
@@clientName(Name, "IotHubTypeName", "csharp");
@@clientName(TestAllRoutesInput, "IotHubTestAllRoutesContent", "csharp");
@@clientName(TestAllRoutesResult, "IotHubTestAllRoutesResult", "csharp");
@@clientName(TestRouteInput, "IotHubTestRouteContent", "csharp");
@@clientName(TestRouteResult, "IotHubTestRouteResult", "csharp");
@@clientName(TestRouteResultDetails, "IotHubTestRouteResultDetails", "csharp");
@@visibility(TestRouteResultDetails.compilationErrors, Lifecycle.Read);
@@clientName(MatchedRoute, "IotHubMatchedRoute", "csharp");
@@clientName(ExportDevicesRequest, "ExportDevicesContent", "csharp");
@@clientName(ImportDevicesRequest, "IotHubImportDevicesContent", "csharp");
@@clientName(FailoverInput, "IotHubFailoverContent", "csharp");
@@clientName(EventHubConsumerGroupBodyDescription,
  "EventHubConsumerGroupInfoCreateOrUpdateContent",
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EventHubConsumerGroupBodyDescription.properties,
  "csharp"
);
@@clientName(EventHubConsumerGroupName.name, "Name", "csharp");
@@clientName(IotHubProperties.disableDeviceSAS, "DisableDeviceSas", "csharp");
@@clientName(IotHubProperties.disableModuleSAS, "DisableModuleSas", "csharp");
@@clientName(IotHubProperties.allowedFqdnList, "AllowedFqdns", "csharp");
@@clientName(IotHubProperties.ipFilterRules, "IPFilterRules", "csharp");
@@clientName(IotHubProperties.ipVersion, "IPVersion", "csharp");
@@clientName(RootCertificateProperties.enableRootCertificateV2,
  "IsRootCertificateV2Enabled",
  "csharp"
);
@@clientName(RootCertificateProperties.lastUpdatedTimeUtc,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(Microsoft.Devices.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(GroupIdInformationProperties.requiredZoneNames,
  "RequiredDnsZoneNames",
  "csharp"
);
@@clientName(RoutingEventHubProperties.endpointUri, "Endpoint", "csharp");
@@clientName(RoutingServiceBusQueueEndpointProperties.endpointUri,
  "Endpoint",
  "csharp"
);
@@clientName(RoutingServiceBusTopicEndpointProperties.endpointUri,
  "Endpoint",
  "csharp"
);
@@clientName(RoutingStorageContainerProperties.endpointUri,
  "Endpoint",
  "csharp"
);
@@alternateType(ManagedIdentity.userAssignedIdentity,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Devices.PrivateEndpoint.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(Microsoft.Devices.PrivateEndpointConnection,
  "IotHubPrivateEndpointConnection",
  "csharp"
);
@@clientName(Microsoft.Devices.PrivateEndpointConnectionProperties,
  "IotHubPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(GroupIdInformation,
  "IotHubPrivateEndpointGroupInformation",
  "csharp"
);
@@clientName(GroupIdInformationProperties,
  "IotHubPrivateEndpointGroupInformationProperties",
  "csharp"
);
@@clientName(IotHubDescriptions.manualFailover,
  "ManualFailoverIotHub",
  "csharp"
);
@@clientName(IotHubResourceOperationGroup.checkNameAvailability,
  "CheckIotHubNameAvailability",
  "csharp"
);
@@clientName(ResourceProviderCommonOperationGroup.getSubscriptionQuota,
  "GetIotHubUserSubscriptionQuota",
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(ResourceProviderCommonOperationGroup.getSubscriptionQuota,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(CertificateDescriptions.listByIotHub,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(GroupIdInformations.list,
  "csharp"
);
@@clientName(PrivateEndpointConnections.list,
  "GetIotHubPrivateEndpointConnections",
  "csharp"
);
@@clientName(TestResultStatus, "IotHubTestResultStatus", "csharp");
@@clientLocation(IotHubDescriptions.manualFailover, "IotHubResource", "csharp");

/**
 * override for IotHubDescriptions.manualFailover
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceManualFailover(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  iotHubName: string,
  ...Azure.ResourceManager.ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  @body body: Microsoft.Devices.FailoverInput,
): (ArmCombinedLroHeaders &
  Azure.Core.Foundations.RetryAfterHeader) | Microsoft.Devices.ErrorDetails | Azure.ResourceManager.ArmResponse<void>;

@@override(IotHubDescriptions.manualFailover, replaceManualFailover);
@@clientName(replaceManualFailover::parameters.body,
  "failoverInput",
  "go,javascript"
);

/**
 * override for IotHubDescriptions.testAllRoutes
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceTestAllRoutes(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  iotHubName: string,
  ...Azure.ResourceManager.ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  @body body: Microsoft.Devices.TestAllRoutesInput,
): Azure.ResourceManager.ArmResponse<Microsoft.Devices.TestAllRoutesResult> | Microsoft.Devices.ErrorDetails;

@@override(IotHubDescriptions.testAllRoutes, replaceTestAllRoutes);
@@clientName(replaceTestAllRoutes::parameters.body, "input", "go,javascript");

/**
 * override for IotHubDescriptions.testRoute
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceTestRoute(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  iotHubName: string,
  ...Azure.ResourceManager.ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  @body body: Microsoft.Devices.TestRouteInput,
): Azure.ResourceManager.ArmResponse<Microsoft.Devices.TestRouteResult> | Microsoft.Devices.ErrorDetails;

@@override(IotHubDescriptions.testRoute, replaceTestRoute);
@@clientName(replaceTestRoute::parameters.body, "input", "go,javascript");

@@clientLocation(
  GroupIdInformations.get,
  "PrivateLinkResourcesOperations",
  "javascript"
);
@@clientLocation(
  GroupIdInformations.list,
  "PrivateLinkResourcesOperations",
  "javascript"
);
