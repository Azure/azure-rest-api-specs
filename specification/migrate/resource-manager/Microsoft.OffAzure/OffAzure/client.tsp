import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.OffAzure;

// Mitigate Java breaking changes: model renames (case changes from Swagger → TypeSpec)
@@clientName(FCIInstanceState, "FciInstanceState", "java");
@@clientName(FileMetaData, "FileMetadata", "java");
@@clientName(
  MicrosoftAzureFDSWebRoleHealthErrorDetailsSource,
  "MicrosoftAzureFdsWebRoleHealthErrorDetailsSource",
  "java"
);
@@clientName(SQLDiscoveryScopeStatus, "SqlDiscoveryScopeStatus", "java");
@@clientName(SQLInventoryImportBody, "SqlInventoryImportBody", "java");

// Mitigate Java breaking changes: property rename hostName → hostname
@@clientName(SqlDatabaseReplicaInfo.hostName, "hostname", "java");
@@clientName(SqlServerProperties.hostName, "hostname", "java");
@@clientName(SqlServerV2UpdateProperties.hostName, "hostname", "java");
@@clientName(WebAppExtendedMachineProperties.hostName, "hostname", "java");
@@clientName(FrontEndBinding.hostName, "hostname", "java");
@@clientName(VmwareMachineProperties.hostName, "hostname", "java");

// Mitigate Java breaking changes: resource name parameter hostName → hostname
@@clientName(HypervHost.name, "hostname", "java");
@@clientName(VmwareHost.name, "hostname", "java");

// Mitigate Java breaking changes: property rename dnsHostName → dnsHostname
@@clientName(SqlServerApplication.dnsHostName, "dnsHostname", "java");

// Resolve C# generated API name collisions.
@@clientName(BaseResource, "MigrationDiscoveryJobBaseInfo", "csharp");
@@clientName(Default, "SoftwareInventoryName", "csharp");
@@clientName(
  WebAppSites.listByWebAppSite,
  "ListWebApplicationsByWebAppSite",
  "csharp"
);
@@clientName(
  WebAppSites.webServersControllerListByWebAppSite,
  "ListWebServersByWebAppSite",
  "csharp"
);

// Match current Azure.ResourceManager C# resource data base types.
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BaseResource.id, armResourceIdentifier, "csharp");
@@alternateType(
  Azure.ResourceManager.EntityTagProperty.eTag,
  Azure.Core.eTag,
  "csharp"
);

// Resolve C# management naming review findings.
// Resource wrapper, collection, and data names come from the detected ARM
// resource name, so override that name on each canonical Read operation.
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Use a C#-specific resource name for the MigrationDiscovery machine resource trio."
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Scope the resource name override to C#."
@@clientOption(
  MachineResources.get,
  "resource-name",
  "MigrationDiscoveryMachine",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Use a C#-specific resource name for the MigrationDiscovery server resource trio."
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Scope the resource name override to C#."
@@clientOption(
  Servers.getMachine,
  "resource-name",
  "MigrationDiscoveryServer",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Use a C#-specific resource name for the MigrationDiscovery vCenter resource trio."
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Scope the resource name override to C#."
@@clientOption(
  Vcenters.get,
  "resource-name",
  "MigrationDiscoveryVcenter",
  "csharp"
);
@@clientName(HypervRunAsAccountResource, "HypervRunAsAccount", "csharp");
@@clientName(VmwareRunAsAccountResource, "VmwareRunAsAccount", "csharp");
@@clientName(ServerSiteResource, "ServerSite", "csharp");
@@clientName(ArcScopePropertiesUpdate, "ArcScopePropertiesPatch", "csharp");
@@clientName(FCIInstanceState, "FciInstanceState", "csharp");
@@clientName(
  MicrosoftAzureFDSWebRoleHealthErrorDetailsSource,
  "MicrosoftAzureFdsWebRoleHealthErrorDetailsSource",
  "csharp"
);
@@clientName(SQLDiscoveryScopeStatus, "SqlDiscoveryScopeStatus", "csharp");
@@clientName(VMwareDatastoreType, "VmwareDatastoreType", "csharp");
@@clientName(
  DiscoveryScopes.SQLServerConnectionInfo,
  Azure.ClientGenerator.Core.exact("SqlServerConnectionInfo"),
  "csharp"
);
@@clientName(
  ExportMachineErrorsProperties.SQLServerConnectionInfo,
  Azure.ClientGenerator.Core.exact("SqlServerConnectionInfo"),
  "csharp"
);
@@clientName(
  HealthErrorDetailsDiscoveryScope.SQLServerConnectionInfo,
  Azure.ClientGenerator.Core.exact("SqlServerConnectionInfo"),
  "csharp"
);
@@clientName(
  SqlMetadataDiscoveryPipe.SSH,
  Azure.ClientGenerator.Core.exact("Ssh"),
  "csharp"
);
@@clientName(
  VMwareDatastoreType.NFS,
  Azure.ClientGenerator.Core.exact("Nfs"),
  "csharp"
);
@@clientName(
  VMwareDatastoreType.NFS41,
  Azure.ClientGenerator.Core.exact("Nfs41"),
  "csharp"
);
@@clientName(
  HypervMachineProperties.secureBootEnabled,
  "IsSecureBootEnabled",
  "csharp"
);
@@clientName(HypervMachineProperties.tpmEnabled, "IsTpmEnabled", "csharp");
@@clientName(HypervMachineProperties.ksdEnabled, "IsKsdEnabled", "csharp");
@@clientName(
  HypervMachineProperties.shieldingRequested,
  "IsShieldingRequested",
  "csharp"
);
@@clientName(
  HypervMachineProperties.dataProtectionRequested,
  "IsDataProtectionRequested",
  "csharp"
);
@@clientName(
  HypervMachineProperties.encryptStateAndVmMigrationTraffic,
  "IsEncryptStateAndVmMigrationTraffic",
  "csharp"
);
@@clientName(
  HypervMachineProperties.virtualizationBasedSecurityOptOut,
  "IsVirtualizationBasedSecurityOptOut",
  "csharp"
);
@@clientName(
  VmwareMachineProperties.hostInMaintenanceMode,
  "IsHostInMaintenanceMode",
  "csharp"
);
@@clientName(
  VmwareMachineProperties.changeTrackingSupported,
  "IsChangeTrackingSupported",
  "csharp"
);
@@clientName(
  VmwareMachineProperties.changeTrackingEnabled,
  "IsChangeTrackingEnabled",
  "csharp"
);
@@clientName(
  VmwareMachineProperties.secureBootEnabled,
  "IsSecureBootEnabled",
  "csharp"
);
@@clientName(ServerProperties.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(
  DeleteImportedMachinesJobProperties.deletionConfirmation,
  "IsDeletionConfirmation",
  "csharp"
);

// Resolve C# analyzer model suffix rules.
@@clientName(
  DependencyMapServiceMapextensionsDependencyMapRequestFilters,
  "MigrationDiscoveryDependencyMapServiceMapExtensionsDependencyMapRequestFilters",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsClientGroupMembersRequest,
  "MigrationDiscoveryDependencyMapServiceMapExtensionsClientGroupMembersContent",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsExportDependenciesRequest,
  "MigrationDiscoveryDependencyMapServiceMapExtensionsExportDependenciesContent",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsScopeMapRequest,
  "MigrationDiscoveryDependencyMapServiceMapExtensionsScopeMapContent",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsServerGroupMembersRequest,
  "MigrationDiscoveryDependencyMapServiceMapExtensionsServerGroupMembersContent",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest,
  "MigrationDiscoveryDependencyMapServiceMapExtensionsSingleMachineDetailedMapContent",
  "csharp"
);
@@clientName(
  ErrorSummaryRequest,
  "MigrationDiscoveryErrorSummaryRequestContent",
  "csharp"
);
@@clientName(
  ExportMachineErrorsRequest,
  "MigrationDiscoveryExportMachineErrorsRequestContent",
  "csharp"
);
@@clientName(
  ExportMachinesRequest,
  "MigrationDiscoveryExportMachinesRequestContent",
  "csharp"
);
@@clientName(
  ExportSqlServersRequest,
  "MigrationDiscoveryExportSqlServersRequestContent",
  "csharp"
);
@@clientName(
  ExportWebAppsRequest,
  "MigrationDiscoveryExportWebAppsRequestContent",
  "csharp"
);
@@clientName(FileMetaData, "FileMetadata", "csharp");
@@clientName(
  MachineMetadataCollection,
  "MigrationDiscoveryMachineMetadataList",
  "csharp"
);
@@clientName(ProxySiteRefreshBody, "ProxySiteRefreshContent", "csharp");
@@clientName(SasUriResponse, "MigrationDiscoverySasUriResult", "csharp");
@@clientName(
  ServerSiteUsageResponse,
  "MigrationDiscoveryServerSiteUsageResult",
  "csharp"
);
@@clientName(
  SiteHealthSummaryCollection,
  "MigrationDiscoverySiteHealthSummaryList",
  "csharp"
);
@@clientName(SQLInventoryImportBody, "SqlInventoryImportContent", "csharp");
@@clientName(SqlSiteRefreshBody, "SqlSiteRefreshContent", "csharp");
@@clientName(
  WebAppPropertiesCollection,
  "MigrationDiscoveryWebAppPropertiesList",
  "csharp"
);

// Resolve C# status member spelling without changing wire values.
@@clientName(
  ApplicationDiscoveryScopeStatus.DiscoveryPartiallySucceded,
  "DiscoveryPartiallySucceeded",
  "csharp"
);
@@clientName(
  ApplicationDiscoveryScopeStatus.DiscoverySucceededAtleastOnce,
  "DiscoverySucceededAtLeastOnce",
  "csharp"
);
@@clientName(
  DependencyMapDiscoveryScopeStatus.DiscoveryPartiallySucceded,
  "DiscoveryPartiallySucceeded",
  "csharp"
);
@@clientName(
  DependencyMapDiscoveryScopeStatus.DiscoverySucceededAtleastOnce,
  "DiscoverySucceededAtLeastOnce",
  "csharp"
);
@@clientName(
  DiscoveryScopeStatus.DiscoveryPartiallySucceded,
  "DiscoveryPartiallySucceeded",
  "csharp"
);
@@clientName(
  DiscoveryScopeStatus.DiscoverySucceededAtleastOnce,
  "DiscoverySucceededAtLeastOnce",
  "csharp"
);
@@clientName(
  ShallowDiscoveryStatus.DiscoveryPartiallySucceded,
  "DiscoveryPartiallySucceeded",
  "csharp"
);
@@clientName(
  ShallowDiscoveryStatus.DiscoverySucceededAtleastOnce,
  "DiscoverySucceededAtLeastOnce",
  "csharp"
);
@@clientName(
  SQLDiscoveryScopeStatus.DiscoveryPartiallySucceded,
  "DiscoveryPartiallySucceeded",
  "csharp"
);
@@clientName(
  SQLDiscoveryScopeStatus.DiscoverySucceededAtleastOnce,
  "DiscoverySucceededAtLeastOnce",
  "csharp"
);
@@clientName(
  StaticDiscoveryScopeStatus.DiscoveryPartiallySucceded,
  "DiscoveryPartiallySucceeded",
  "csharp"
);
@@clientName(
  StaticDiscoveryScopeStatus.DiscoverySucceededAtleastOnce,
  "DiscoverySucceededAtLeastOnce",
  "csharp"
);
