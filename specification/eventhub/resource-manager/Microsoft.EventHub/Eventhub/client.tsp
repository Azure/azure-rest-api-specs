import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventHub;

@@clientName(Microsoft.EventHub,
  "EventHubManagementClient",
  "python,javascript"
);

// Fix TLS version naming changes for Go SDK backward compatibility
@@clientName(TlsVersion.`1.0`, "One0", "go");
@@clientName(TlsVersion.`1.1`, "One1", "go");
@@clientName(TlsVersion.`1.2`, "One2", "go");
@@clientName(TlsVersion.`1.3`, "One3", "go");

// Fix field naming changes for Go SDK backward compatibility
@@clientName(RetentionDescription.minCompactionLagTimeInMinutes,
  "MinCompactionLagInMins",
  "go"
);

@@clientName(SchemaType, "EventHubsSchemaType", "csharp");
@@clientName(SchemaCompatibility, "EventHubsSchemaCompatibility", "csharp");
@@clientName(EHNamespace, "EventHubsNamespace", "csharp");
@@clientName(DefaultAction, "EventHubsNetworkRuleSetDefaultAction", "csharp");
@@clientName(PublicNetworkAccessFlag, "EventHubsPublicNetworkAccessFlag", "csharp");
@@clientName(NWRuleSetIpRules, "EventHubsNetworkRuleSetIPRules", "csharp");
@@clientName(NetworkRuleIPAction, "EventHubsNetworkRuleIPAction", "csharp");
@@clientName(NWRuleSetVirtualNetworkRules, "EventHubsNetworkRuleSetVirtualNetworkRules", "csharp");
@@clientName(EndPointProvisioningState, "EventHubsPrivateEndpointConnectionProvisioningState", "csharp");
@@clientName(ConnectionState, "EventHubsPrivateLinkServiceConnectionState", "csharp");
@@clientName(PrivateLinkConnectionStatus, "EventHubsPrivateLinkConnectionStatus", "csharp");
@@clientName(PrivateLinkResource, "EventHubsPrivateLinkResourceData", "csharp");
@@clientName(ProvisioningState, "EventHubsClusterProvisioningState", "csharp");
@@clientName(CleanupPolicyRetentionDescription.Compact, "Compaction", "csharp");
@@clientName(ApplicationGroupPolicy, "EventHubsApplicationGroupPolicy", "csharp");
@@clientName(RegenerateAccessKeyParameters, "EventHubsRegenerateAccessKeyContent", "csharp");
@@clientName(KeyType, "EventHubsAccessKeyType", "csharp");
@@clientName(ArmDisasterRecovery, "EventHubsDisasterRecovery", "csharp");
@@clientName(ProvisioningStateDR, "EventHubsDisasterRecoveryProvisioningState", "csharp");
@@clientName(RoleDisasterRecovery, "EventHubsDisasterRecoveryRole", "csharp");
@@clientName(Eventhub, "EventHub", "csharp");
@@clientName(Destination, "EventHubDestination", "csharp");
@@clientName(EntityStatus, "EventHubEntityStatus", "csharp");
@@clientName(CheckNameAvailabilityParameter, "EventHubsNameAvailabilityContent", "csharp");
@@clientName(CheckNameAvailabilityResult, "EventHubsNameAvailabilityResult", "csharp");
@@clientName(UnavailableReason, "EventHubsNameUnavailableReason", "csharp");
@@clientName(FailOver, "EventHubsNamespaceFailOver", "csharp");
@@clientName(GeoDataReplicationProperties, "NamespaceGeoDataReplicationProperties", "csharp");
@@clientName(GeoDRRoleType, "EventHubsNamespaceGeoDRRoleType", "csharp");
@@clientName(Mode, "EventHubsConfidentialComputeMode", "csharp");
@@clientName(TimestampType, "EventHubsTimestampType", "csharp");
@@clientName(NamespaceReplicaLocation, "EventHubsNamespaceReplicaLocation", "csharp");
@@clientName(ClusterSku, "EventHubsClusterSku", "csharp");
@@clientName(ClusterSkuName, "EventHubsClusterSkuName", "csharp");
@@clientName(NetworkRuleSet, "EventHubsNetworkRuleSet", "csharp");
@@clientName(Encryption, "EventHubsEncryption", "csharp");
@@clientName(KeyVaultProperties, "EventHubsKeyVaultProperties", "csharp");
@@clientName(CaptureIdentity, "EventHubsCaptureIdentity", "csharp");
@@clientName(CaptureIdentityType, "EventHubsCaptureIdentityType", "csharp");
@@clientName(ThrottlingPolicy, "EventHubsThrottlingPolicy", "csharp");
@@clientName(ApplicationGroup, "EventHubsApplicationGroup", "csharp");
@@clientName(AuthorizationRule, "EventHubsAuthorizationRule", "csharp");
@@clientName(AccessKeys, "EventHubsAccessKeys", "csharp");
@@clientName(AccessRights, "EventHubsAccessRight", "csharp");
@@clientName(ConsumerGroup, "EventHubsConsumerGroup", "csharp");
@@clientName(SchemaGroup, "EventHubsSchemaGroup", "csharp");
@@clientName(TlsVersion, "EventHubsTlsVersion", "csharp");
@@clientName(PublicNetworkAccess, "EventHubsPublicNetworkAccess", "csharp");
@@clientName(ProvisioningIssueProperties, "EventHubsProvisioningIssueProperties", "csharp");
@@clientName(ProvisioningIssue, "EventHubsProvisioningIssue", "csharp");
@@clientName(MetricId, "EventHubsMetricId", "csharp");
@@clientName(NetworkSecurityPerimeter, "EventHubsNetworkSecurityPerimeter", "csharp");
@@clientName(NetworkSecurityPerimeterConfiguration, "EventHubsNetworkSecurityPerimeterConfiguration", "csharp");
@@clientName(NetworkSecurityPerimeterConfigurationPropertiesProfile, "EventHubsNetworkSecurityPerimeterConfigurationPropertiesProfile", "csharp");
@@clientName(NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation, "EventHubsNetworkSecurityPerimeterConfigurationPropertiesResourceAssociation", "csharp");
@@clientName(NetworkSecurityPerimeterConfigurationProvisioningState, "EventHubsNetworkSecurityPerimeterConfigurationProvisioningState", "csharp");
@@clientName(NspAccessRule, "EventHubsNspAccessRule", "csharp");
@@clientName(NspAccessRuleDirection, "EventHubsNspAccessRuleDirection", "csharp");
@@clientName(NspAccessRuleProperties, "EventHubsNspAccessRuleProperties", "csharp");
@@clientName(ResourceAssociationAccessMode, "EventHubsResourceAssociationAccessMode", "csharp");

@@clientLocation(AuthorizationRules.getAuthorizationRule, "Namespaces", "!csharp");