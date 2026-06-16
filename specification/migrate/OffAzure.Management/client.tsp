import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.OffAzure;

// Mitigate Java breaking changes: model renames (case changes from Swagger → TypeSpec)
@@clientName(FCIInstanceState, "FciInstanceState", "java");
@@clientName(FileMetaData, "FileMetadata", "java");
@@clientName(MicrosoftAzureFDSWebRoleHealthErrorDetailsSource,
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
