import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientName(Microsoft.ServiceFabric,
  "ServiceFabricManagementClient",
  "javascript,python"
);
@@clientName(Azure.ResourceManager.CommonTypes.ProxyResource,
  "ArmProxyResource",
  "python,java,javascript,csharp"
);

// Rename the custom ProxyResource to avoid collision with
// Azure.ResourceManager.CommonTypes.ProxyResource which confuses the C# generator
@@clientName(Microsoft.ServiceFabric.ProxyResource,
  "ServiceFabricProxyResource",
  "csharp"
);

@@clientName(Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "ManagedIdentity",
  "java"
);

@@clientName(Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType,
  "ManagedIdentityType",
  "java"
);

// C# renames to preserve backward compatibility with autorest-generated SDK
// NOTE: Resource classes for custom @customAzureResource ProxyResource models are
// generated as empty stubs. We use CodeGenSuppress + custom code on the SDK side
// to provide full implementations.
@@clientName(Microsoft.ServiceFabric.Cluster, "ServiceFabricCluster", "csharp");
@@clientName(Microsoft.ServiceFabric.ApplicationResource, "ServiceFabricApplication", "csharp");
@@clientName(Microsoft.ServiceFabric.ApplicationTypeResource, "ServiceFabricApplicationType", "csharp");
@@clientName(Microsoft.ServiceFabric.ApplicationTypeVersionResource, "ServiceFabricApplicationTypeVersion", "csharp");
@@clientName(Microsoft.ServiceFabric.ServiceResource, "ServiceFabricService", "csharp");
// @@clientName(Microsoft.ServiceFabric.VMSizeResource, "ServiceFabricVmSizeResource", "csharp");

// Mark ClusterVersions list operations as pageable (old API had Pageable<ClusterCodeVersionsResult>)
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Mark as pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Microsoft.ServiceFabric.ClusterVersionsOperationGroup.list, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Mark as pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Microsoft.ServiceFabric.ClusterVersionsOperationGroup.listByEnvironment, "csharp");

// Model type renames
@@clientName(Microsoft.ServiceFabric.AzureActiveDirectory, "ClusterAadSetting", "csharp");
@@clientName(Microsoft.ServiceFabric.CertificateDescription, "ClusterCertificateDescription", "csharp");
@@clientName(Microsoft.ServiceFabric.ClientCertificateCommonName, "ClusterClientCertificateCommonName", "csharp");
@@clientName(Microsoft.ServiceFabric.ClientCertificateThumbprint, "ClusterClientCertificateThumbprint", "csharp");
@@clientName(Microsoft.ServiceFabric.EndpointRangeDescription, "ClusterEndpointRangeDescription", "csharp");
@@clientName(Microsoft.ServiceFabric.NodeTypeDescription, "ClusterNodeTypeDescription", "csharp");
@@clientName(Microsoft.ServiceFabric.Notification, "ClusterNotification", "csharp");
@@clientName(Microsoft.ServiceFabric.NotificationTarget, "ClusterNotificationTarget", "csharp");
@@clientName(Microsoft.ServiceFabric.ServerCertificateCommonName, "ClusterServerCertificateCommonName", "csharp");
@@clientName(Microsoft.ServiceFabric.ServerCertificateCommonNames, "ClusterServerCertificateCommonNames", "csharp");

// Enum/union type renames
@@clientName(Microsoft.ServiceFabric.AddOnFeatures, "ClusterAddOnFeature", "csharp");
@@clientName(Microsoft.ServiceFabric.DurabilityLevel, "ClusterDurabilityLevel", "csharp");
@@clientName(Microsoft.ServiceFabric.MoveCost, "ApplicationMoveCost", "csharp");
@@clientName(Microsoft.ServiceFabric.NotificationCategory, "ClusterNotificationCategory", "csharp");
@@clientName(Microsoft.ServiceFabric.NotificationChannel, "ClusterNotificationChannel", "csharp");
@@clientName(Microsoft.ServiceFabric.NotificationLevel, "ClusterNotificationLevel", "csharp");
@@clientName(Microsoft.ServiceFabric.ReliabilityLevel, "ClusterReliabilityLevel", "csharp");
@@clientName(Microsoft.ServiceFabric.RollingUpgradeMode, "ApplicationRollingUpgradeMode", "csharp");
@@clientName(Microsoft.ServiceFabric.ServiceKind, "ApplicationServiceKind", "csharp");
@@clientName(Microsoft.ServiceFabric.StoreName, "ClusterCertificateStoreName", "csharp");
@@clientName(Microsoft.ServiceFabric.UpgradeMode, "ClusterUpgradeMode", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterState, "ServiceFabricClusterState", "csharp");
@@clientName(Microsoft.ServiceFabric.ProvisioningState, "ServiceFabricProvisioningState", "csharp");
@@clientName(Microsoft.ServiceFabric.PartitionScheme, "ApplicationPartitionScheme", "csharp");

// Access modifiers - types that were public in old API but generated as internal
@@access(Microsoft.ServiceFabric.AzureActiveDirectory, Access.public, "csharp");
@@access(Microsoft.ServiceFabric.ClusterVersionDetails, Access.public, "csharp");
@@access(Microsoft.ServiceFabric.DiagnosticsStorageAccountConfig, Access.public, "csharp");
@@access(Microsoft.ServiceFabric.ClusterState, Access.public, "csharp");
@@access(Microsoft.ServiceFabric.ProvisioningState, Access.public, "csharp");

// Property renames on ClusterProperties (and ClusterPropertiesUpdateParameters)
@@clientName(Microsoft.ServiceFabric.ClusterProperties.eventStoreServiceEnabled,
  "IsEventStoreServiceEnabled", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterProperties.infrastructureServiceManager,
  "IsInfrastructureServiceManagerEnabled", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterProperties.waveUpgradePaused,
  "IsWaveUpgradePaused", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterProperties.upgradePauseStartTimestampUtc,
  "UpgradePauseStartOn", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterProperties.upgradePauseEndTimestampUtc,
  "UpgradePauseEndOn", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterProperties.sfZonalUpgradeMode,
  "ServiceFabricZonalUpgradeMode", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterProperties.clusterEndpoint,
  "ClusterEndpoint", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterProperties.managementEndpoint,
  "ManagementEndpoint", "csharp");

// Same renames on ClusterPropertiesUpdateParameters
@@clientName(Microsoft.ServiceFabric.ClusterPropertiesUpdateParameters.eventStoreServiceEnabled,
  "IsEventStoreServiceEnabled", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterPropertiesUpdateParameters.infrastructureServiceManager,
  "IsInfrastructureServiceManagerEnabled", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterPropertiesUpdateParameters.waveUpgradePaused,
  "IsWaveUpgradePaused", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterPropertiesUpdateParameters.upgradePauseStartTimestampUtc,
  "UpgradePauseStartOn", "csharp");
@@clientName(Microsoft.ServiceFabric.ClusterPropertiesUpdateParameters.upgradePauseEndTimestampUtc,
  "UpgradePauseEndOn", "csharp");

// Property renames on NodeTypeDescription
@@clientName(Microsoft.ServiceFabric.NodeTypeDescription.multipleAvailabilityZones,
  "IsMultipleAvailabilityZonesSupported", "csharp");

// Property renames on ClusterVersionDetails
@@clientName(Microsoft.ServiceFabric.ClusterVersionDetails.supportExpiryUtc,
  "SupportExpireOn", "csharp");

// Type overrides for URI properties
@@alternateType(Microsoft.ServiceFabric.ClusterProperties.clusterEndpoint, url, "csharp");
@@alternateType(Microsoft.ServiceFabric.ClusterProperties.managementEndpoint, url, "csharp");
@@alternateType(Microsoft.ServiceFabric.DiagnosticsStorageAccountConfig.blobEndpoint, url, "csharp");
@@alternateType(Microsoft.ServiceFabric.DiagnosticsStorageAccountConfig.queueEndpoint, url, "csharp");
@@alternateType(Microsoft.ServiceFabric.DiagnosticsStorageAccountConfig.tableEndpoint, url, "csharp");

// Type overrides for Guid properties (old API used System.Guid)
@@alternateType(Microsoft.ServiceFabric.AzureActiveDirectory.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(Microsoft.ServiceFabric.ApplicationUserAssignedIdentity.principalId, Azure.Core.uuid, "csharp");

// Type override for DateTimeOffset property (old API used System.DateTimeOffset?)
@@alternateType(Microsoft.ServiceFabric.ClusterVersionDetails.supportExpiryUtc, utcDateTime, "csharp");

// Type overrides for BinaryData properties (old API used System.BinaryData for thumbprints)
@@alternateType(Microsoft.ServiceFabric.CertificateDescription.thumbprint, bytes, "csharp");
@@alternateType(Microsoft.ServiceFabric.ClientCertificateCommonName.certificateIssuerThumbprint, bytes, "csharp");
@@alternateType(Microsoft.ServiceFabric.ClientCertificateThumbprint.certificateThumbprint, bytes, "csharp");
@@alternateType(Microsoft.ServiceFabric.ServerCertificateCommonName.certificateIssuerThumbprint, bytes, "csharp");

// Type overrides for TimeSpan properties (old API used System.TimeSpan)
@@alternateType(Microsoft.ServiceFabric.ClusterUpgradePolicy.upgradeReplicaSetCheckTimeout, duration, "csharp");
@@alternateType(Microsoft.ServiceFabric.ApplicationUpgradePolicy.upgradeReplicaSetCheckTimeout, duration, "csharp");

// NOTE: @@hierarchyBuilding causes cascading base type changes on all Data classes
// in the namespace. Skipping for now - ClusterCodeVersionsResult base type change
// accepted as known breaking change.

// Base type overrides: old SDK had these as TrackedResourceData.
// Spec has them as ProxyResource (location is optional), but the GA SDK ships with
// TrackedResourceData, so we use hierarchyBuilding to restore that for C#.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change base to TrackedResource for backward compatibility with GA SDK"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.ServiceFabric.ApplicationResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change base to TrackedResource for backward compatibility with GA SDK"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.ServiceFabric.ApplicationTypeResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change base to TrackedResource for backward compatibility with GA SDK"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.ServiceFabric.ApplicationTypeVersionResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change base to TrackedResource for backward compatibility with GA SDK"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.ServiceFabric.ServiceResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);


