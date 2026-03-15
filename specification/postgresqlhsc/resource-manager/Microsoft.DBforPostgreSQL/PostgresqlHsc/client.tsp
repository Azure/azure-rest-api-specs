import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforPostgreSQL;

@@clientName(ClusterProperties.pointInTimeUTC, "PointInTimeUtc", "java");

@@alternateType(NameAvailabilityRequest.type,
  "Microsoft.DBforPostgreSQL/serverGroupsv2",
  "java"
);

// rename-mapping: model renames
@@clientName(CheckNameAvailabilityResourceType, "CosmosDBForPostgreSqlNameAvailabilityResourceType", "csharp");
@@clientName(CheckNameAvailabilityResourceType.MICROSOFT_DB_FOR_POSTGRESQL_SERVER_GROUPSV2, "ServerGroupsV2", "csharp");
@@clientName(NameAvailability, "CosmosDBForPostgreSqlClusterNameAvailabilityResult", "csharp");
@@clientName(NameAvailability.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(NameAvailabilityRequest, "CosmosDBForPostgreSqlClusterNameAvailabilityContent", "csharp");

// rename-mapping: property renames (Cluster)
@@clientName(ClusterProperties.enableShardsOnCoordinator, "IsShardsOnCoordinatorEnabled", "csharp");
@@clientName(ClusterProperties.enableHa, "IsHAEnabled", "csharp");
@@clientName(ClusterProperties.coordinatorEnablePublicIpAccess, "IsCoordinatorPublicIPAccessEnabled", "csharp");
@@clientName(ClusterProperties.nodeEnablePublicIpAccess, "IsNodePublicIPAccessEnabled", "csharp");

// rename-mapping: property renames (ClusterForUpdate)
@@clientName(ClusterPropertiesForUpdate.enableShardsOnCoordinator, "IsShardsOnCoordinatorEnabled", "csharp");
@@clientName(ClusterPropertiesForUpdate.enableHa, "IsHAEnabled", "csharp");
@@clientName(ClusterPropertiesForUpdate.coordinatorEnablePublicIpAccess, "IsCoordinatorPublicIPAccessEnabled", "csharp");
@@clientName(ClusterPropertiesForUpdate.nodeEnablePublicIpAccess, "IsNodePublicIPAccessEnabled", "csharp");

// rename-mapping: property renames (ClusterServer / ServerProperties)
@@clientName(ServerProperties.enableHa, "IsHAEnabled", "csharp");
@@clientName(ServerProperties.enablePublicIpAccess, "IsPublicIPAccessEnabled", "csharp");

// rename-mapping: property renames (Configuration / ServerConfiguration)
@@clientName(ConfigurationProperties.requiresRestart, "IsRestartRequired", "csharp");
@@clientName(ServerConfigurationProperties.requiresRestart, "IsRestartRequired", "csharp");

// rename-mapping: type changes
@@alternateType(FirewallRuleProperties.startIpAddress, Azure.Core.ipV4Address, "csharp");
@@alternateType(FirewallRuleProperties.endIpAddress, Azure.Core.ipV4Address, "csharp");
@@alternateType(NameAvailability.type, Azure.Core.armResourceType, "csharp");

// format-by-name-rules
@@alternateType(ClusterProperties.sourceResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ClusterProperties.sourceLocation, Azure.Core.azureLocation, "csharp");
@@alternateType(DataEncryption.primaryKeyUri, url, "csharp");

// prepend-rp-prefix
@@clientName(Cluster, "CosmosDBForPostgreSqlCluster", "csharp");
@@clientName(ClusterServer, "CosmosDBForPostgreSqlClusterServer", "csharp");
@@clientName(Configuration, "CosmosDBForPostgreSqlConfiguration", "csharp");
@@clientName(ConfigurationDataType, "CosmosDBForPostgreSqlConfigurationDataType", "csharp");
@@clientName(FirewallRule, "CosmosDBForPostgreSqlFirewallRule", "csharp");
@@clientName(MaintenanceWindow, "CosmosDBForPostgreSqlMaintenanceWindow", "csharp");
@@clientName(Role, "CosmosDBForPostgreSqlRole", "csharp");
@@clientName(ServerRole, "CosmosDBForPostgreSqlServerRole", "csharp");
@@clientName(ServerRoleGroupConfiguration, "CosmosDBForPostgreSqlServerRoleGroupConfiguration", "csharp");
@@clientName(SimplePrivateEndpointConnection, "CosmosDBForPostgreSqlSimplePrivateEndpointConnection", "csharp");
@@clientName(ServerConfiguration, "CosmosDBForPostgreSqlServerConfiguration", "csharp");
@@clientName(ServerNameItem, "CosmosDBForPostgreSqlServerNameItem", "csharp");
@@clientName(ProvisioningState, "CosmosDBForPostgreSqlProvisioningState", "csharp");
@@clientName(ClusterConfigurationListResult, "CosmosDBForPostgreSqlClusterConfigurationListResult", "csharp");

// override-operation-name
@@clientName(ClustersOperationGroup.checkNameAvailability, "CheckCosmosDBForPostgreSqlClusterNameAvailability", "csharp");
