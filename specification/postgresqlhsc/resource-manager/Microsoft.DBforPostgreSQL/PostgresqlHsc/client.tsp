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
@@clientName(CheckNameAvailabilityResourceType.MICROSOFT_DB_FOR_POSTGRESQL_SERVER_GROUPSV2,
  "ServerGroupsV2",
  "csharp"
);
@@clientName(NameAvailability,
  "CosmosDBForPostgreSqlClusterNameAvailabilityResult",
  "csharp"
);
@@clientName(NameAvailability.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(NameAvailabilityRequest,
  "CosmosDBForPostgreSqlClusterNameAvailabilityContent",
  "csharp"
);

// rename-mapping: property renames (Cluster)
@@clientName(ClusterProperties.enableShardsOnCoordinator,
  "IsShardsOnCoordinatorEnabled",
  "csharp"
);
@@clientName(ClusterProperties.enableHa, "IsHAEnabled", "csharp");
@@clientName(ClusterProperties.coordinatorEnablePublicIpAccess,
  "IsCoordinatorPublicIPAccessEnabled",
  "csharp"
);
@@clientName(ClusterProperties.nodeEnablePublicIpAccess,
  "IsNodePublicIPAccessEnabled",
  "csharp"
);

// rename-mapping: property renames (ClusterForUpdate)
@@clientName(ClusterPropertiesForUpdate.enableShardsOnCoordinator,
  "IsShardsOnCoordinatorEnabled",
  "csharp"
);
@@clientName(ClusterPropertiesForUpdate.enableHa, "IsHAEnabled", "csharp");
@@clientName(ClusterPropertiesForUpdate.coordinatorEnablePublicIpAccess,
  "IsCoordinatorPublicIPAccessEnabled",
  "csharp"
);
@@clientName(ClusterPropertiesForUpdate.nodeEnablePublicIpAccess,
  "IsNodePublicIPAccessEnabled",
  "csharp"
);

// rename-mapping: property renames (ClusterServer / ServerProperties)
@@clientName(ServerProperties.enableHa, "IsHAEnabled", "csharp");
@@clientName(ServerProperties.enablePublicIpAccess,
  "IsPublicIPAccessEnabled",
  "csharp"
);

// rename-mapping: property renames (Configuration / ServerConfiguration)
@@clientName(ConfigurationProperties.requiresRestart,
  "IsRestartRequired",
  "csharp"
);
@@clientName(ServerConfigurationProperties.requiresRestart,
  "IsRestartRequired",
  "csharp"
);

// rename-mapping: type changes
@@alternateType(FirewallRuleProperties.startIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(FirewallRuleProperties.endIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(NameAvailability.type, Azure.Core.armResourceType, "csharp");

// Fix: property name "type" → "ResourceType" (matches baseline naming)
@@clientName(NameAvailabilityRequest.type, "ResourceType", "csharp");
@@clientName(NameAvailability.type, "ResourceType", "csharp");

// Fix: IP property name casing (autorest acronym-mapping treated "Ip" as "IP")
@@clientName(FirewallRuleProperties.startIpAddress, "StartIPAddress", "csharp");
@@clientName(FirewallRuleProperties.endIpAddress, "EndIPAddress", "csharp");

// Fix: PrivateEndpointConnectionData property rename (baseline name was ConnectionState)
// Note: PrivateEndpointConnection uses CommonTypes properties, SimplePrivateEndpointConnection uses local properties
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

// Fix: SimplePrivateEndpointConnection.PrivateEndpointId type (baseline had ResourceIdentifier)
@@alternateType(PrivateEndpointProperty.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Fix: rename listByServer → GetConfigurations (baseline operation name)
@@clientName(Configurations.listByServer, "GetConfigurations", "csharp");

// format-by-name-rules
@@alternateType(ClusterProperties.sourceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ClusterProperties.sourceLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(DataEncryption.primaryKeyUri, url, "csharp");

// prepend-rp-prefix
@@clientName(Cluster, "CosmosDBForPostgreSqlCluster", "csharp");
@@clientName(ClusterServer, "CosmosDBForPostgreSqlClusterServer", "csharp");
@@clientName(Configuration, "CosmosDBForPostgreSqlConfiguration", "csharp");
@@clientName(ConfigurationDataType,
  "CosmosDBForPostgreSqlConfigurationDataType",
  "csharp"
);
@@clientName(FirewallRule, "CosmosDBForPostgreSqlFirewallRule", "csharp");
@@clientName(MaintenanceWindow,
  "CosmosDBForPostgreSqlMaintenanceWindow",
  "csharp"
);
@@clientName(Role, "CosmosDBForPostgreSqlRole", "csharp");
@@clientName(ServerRole, "CosmosDBForPostgreSqlServerRole", "csharp");
@@clientName(ServerRoleGroupConfiguration,
  "CosmosDBForPostgreSqlServerRoleGroupConfiguration",
  "csharp"
);
@@clientName(SimplePrivateEndpointConnection,
  "CosmosDBForPostgreSqlSimplePrivateEndpointConnection",
  "csharp"
);
@@clientName(ServerConfiguration,
  "CosmosDBForPostgreSqlServerConfiguration",
  "csharp"
);
@@clientName(ServerNameItem, "CosmosDBForPostgreSqlServerNameItem", "csharp");
@@clientName(ProvisioningState,
  "CosmosDBForPostgreSqlProvisioningState",
  "csharp"
);
@@clientName(ClusterConfigurationListResult,
  "CosmosDBForPostgreSqlClusterConfigurationListResult",
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "CosmosDBForPostgreSqlPrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateLinkResource,
  "CosmosDBForPostgreSqlPrivateLinkResource",
  "csharp"
);

// override-operation-name
@@clientName(ClustersOperationGroup.checkNameAvailability,
  "CheckCosmosDBForPostgreSqlClusterNameAvailability",
  "csharp"
);

// AZC0030: forbidden suffix fix
@@clientName(PromoteRequest,
  "CosmosDBForPostgreSqlPromoteRequestContent",
  "csharp"
);

/**
 * Resource type used for name availability verification.
 */
union CheckNameAvailabilityResourceTypeReplacement {
  CheckNameAvailabilityResourceType,
  string,
}
@@alternateType(CheckNameAvailabilityResourceType,
  CheckNameAvailabilityResourceTypeReplacement,
  "csharp"
);
@@clientName(CheckNameAvailabilityResourceTypeReplacement,
  "CosmosDBForPostgreSqlNameAvailabilityResourceType",
  "csharp"
);

// Fix: undo @@clientLocation merging for C# so emitter generates separate resource classes
// back-compat.tsp moves node/coordinator ops into Configurations client (for Python/Java),
// but C# mgmt needs them in separate interfaces to produce distinct Resource classes.
@@clientLocation(NodeConfigurations.getNode, NodeConfigurations, "csharp");
@@clientLocation(NodeConfigurations.updateOnNode, NodeConfigurations, "csharp");
@@clientLocation(CoordinatorConfigurations.getCoordinator,
  CoordinatorConfigurations,
  "csharp"
);
@@clientLocation(CoordinatorConfigurations.updateOnCoordinator,
  CoordinatorConfigurations,
  "csharp"
);

// Rename interfaces to add RP prefix — resource/collection names are derived from these
@@clientName(NodeConfigurations,
  "CosmosDBForPostgreSqlNodeConfigurations",
  "csharp"
);
@@clientName(CoordinatorConfigurations,
  "CosmosDBForPostgreSqlCoordinatorConfigurations",
  "csharp"
);

// @@usage: restore public constructors and setters for response-only models
@@usage(ClusterServer, Usage.input | Usage.output, "csharp");
@@usage(Configuration, Usage.input | Usage.output, "csharp");
@@usage(PrivateLinkResource, Usage.input | Usage.output, "csharp");
@@usage(Role, Usage.input | Usage.output, "csharp");
@@usage(ServerRoleGroupConfiguration, Usage.input | Usage.output, "csharp");
@@usage(SimplePrivateEndpointConnection, Usage.input | Usage.output, "csharp");
@@usage(NameAvailabilityRequest, Usage.input | Usage.output, "csharp");
