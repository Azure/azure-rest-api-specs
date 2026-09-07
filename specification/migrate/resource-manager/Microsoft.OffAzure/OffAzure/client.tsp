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
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id, armResourceIdentifier, "csharp");
@@alternateType(BaseResource.id, armResourceIdentifier, "csharp");

// Resolve C# analyzer model suffix rules.
@@clientName(
  DependencyMapServiceMapextensionsClientGroupMembersRequest,
  "MigrationDiscoveryDependencyMapServiceMapextensionsClientGroupMembersRequestContent",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsExportDependenciesRequest,
  "MigrationDiscoveryDependencyMapServiceMapextensionsExportDependenciesRequestContent",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsScopeMapRequest,
  "MigrationDiscoveryDependencyMapServiceMapextensionsScopeMapRequestContent",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsServerGroupMembersRequest,
  "MigrationDiscoveryDependencyMapServiceMapextensionsServerGroupMembersRequestContent",
  "csharp"
);
@@clientName(
  DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest,
  "MigrationDiscoveryDependencyMapServiceMapextensionsSingleMachineDetailedMapRequestContent",
  "csharp"
);
@@clientName(ErrorSummaryRequest, "MigrationDiscoveryErrorSummaryRequestContent", "csharp");
@@clientName(
  ExportMachineErrorsRequest,
  "MigrationDiscoveryExportMachineErrorsRequestContent",
  "csharp"
);
@@clientName(ExportMachinesRequest, "MigrationDiscoveryExportMachinesRequestContent", "csharp");
@@clientName(ExportSqlServersRequest, "MigrationDiscoveryExportSqlServersRequestContent", "csharp");
@@clientName(ExportWebAppsRequest, "MigrationDiscoveryExportWebAppsRequestContent", "csharp");
@@clientName(FileMetaData, "FileMetadata", "csharp");
@@clientName(MachineMetadataCollection, "MigrationDiscoveryMachineMetadataList", "csharp");
@@clientName(SasUriResponse, "MigrationDiscoverySasUriResult", "csharp");
@@clientName(ServerSiteUsageResponse, "MigrationDiscoveryServerSiteUsageResult", "csharp");
@@clientName(SiteHealthSummaryCollection, "MigrationDiscoverySiteHealthSummaryList", "csharp");
@@clientName(WebAppPropertiesCollection, "MigrationDiscoveryWebAppPropertiesList", "csharp");
