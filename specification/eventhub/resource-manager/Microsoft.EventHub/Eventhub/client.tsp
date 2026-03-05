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

// C# SDK rename mappings
@@clientName(SchemaType, "EventHubsSchemaType", "csharp");
@@clientName(SchemaCompatibility, "EventHubsSchemaCompatibility", "csharp");
@@clientName(ClusterProperties.createdAt, "CreatedOn", "csharp");
@@alternateType(ClusterProperties.createdAt, utcDateTime, "csharp");
@@clientName(ClusterProperties.updatedAt, "UpdatedOn", "csharp");
@@alternateType(ClusterProperties.updatedAt, utcDateTime, "csharp");
@@clientName(EHNamespace, "EventHubsNamespace", "csharp");
@@alternateType(EHNamespaceProperties.clusterArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(DefaultAction, "EventHubsNetworkRuleSetDefaultAction", "csharp");
@@clientName(PublicNetworkAccessFlag,
  "EventHubsPublicNetworkAccessFlag",
  "csharp"
);
@@clientName(NWRuleSetIpRules, "EventHubsNetworkRuleSetIPRules", "csharp");
@@clientName(NetworkRuleIPAction, "EventHubsNetworkRuleIPAction", "csharp");
@@clientName(NWRuleSetVirtualNetworkRules,
  "EventHubsNetworkRuleSetVirtualNetworkRules",
  "csharp"
);
@@clientName(EndPointProvisioningState,
  "EventHubsPrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(ConnectionState,
  "EventHubsPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(PrivateLinkConnectionStatus,
  "EventHubsPrivateLinkConnectionStatus",
  "csharp"
);
@@clientName(PrivateLinkResource, "EventHubsPrivateLinkResourceData", "csharp");
@@clientName(ProvisioningState, "EventHubsClusterProvisioningState", "csharp");
@@clientName(CleanupPolicyRetentionDescription.Compact, "Compaction", "csharp");
@@alternateType(NetworkSecurityPerimeterConfigurationProperties.sourceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ApplicationGroupPolicy,
  "EventHubsApplicationGroupPolicy",
  "csharp"
);
// @@clientName(ApplicationGroupListResult,
//   "EventHubsApplicationGroupListResult",
//   "csharp"
// );
@@clientName(RegenerateAccessKeyParameters,
  "EventHubsRegenerateAccessKeyContent",
  "csharp"
);
@@clientName(KeyType, "EventHubsAccessKeyType", "csharp");
@@clientName(ArmDisasterRecovery, "EventHubsDisasterRecovery", "csharp");
@@clientName(ProvisioningStateDR,
  "EventHubsDisasterRecoveryProvisioningState",
  "csharp"
);
@@clientName(RoleDisasterRecovery, "EventHubsDisasterRecoveryRole", "csharp");
@@clientName(Eventhub, "EventHub", "csharp");
@@clientName(Destination, "EventHubDestination", "csharp");
@@alternateType(DestinationProperties.storageAccountResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(EntityStatus, "EventHubEntityStatus", "csharp");
@@clientName(CheckNameAvailabilityParameter,
  "EventHubsNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult,
  "EventHubsNameAvailabilityResult",
  "csharp"
);
@@clientName(UnavailableReason, "EventHubsNameUnavailableReason", "csharp");
@@clientName(FailOver, "EventHubsNamespaceFailOver", "csharp");
@@clientName(GeoDataReplicationProperties,
  "NamespaceGeoDataReplicationProperties",
  "csharp"
);
@@clientName(GeoDRRoleType, "EventHubsNamespaceGeoDRRoleType", "csharp");
@@alternateType(NamespaceReplicaLocation.clusterArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(Mode, "EventHubsConfidentialComputeMode", "csharp");
@@clientName(TimestampType, "EventHubsTimestampType", "csharp");
@@clientName(NamespaceReplicaLocation,
  "EventHubsNamespaceReplicaLocation",
  "csharp"
);
