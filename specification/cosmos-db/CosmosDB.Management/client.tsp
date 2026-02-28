import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DocumentDB;

@@clientName(ErrorResponse, "CosmosDBErrorResult", "csharp,java,javascript,go");
@@clientName(ErrorResponse, "CosmosDBErrorResult", "csharp,java");
@@clientName(Microsoft.DocumentDB,
  "CosmosDBManagementClient",
  "java,javascript"
);

@@clientName(CassandraClusterPublicStatus.eTag, "etag", "java");
@@clientName(ComponentsM9L909SchemasCassandraclusterpublicstatusPropertiesDatacentersItemsPropertiesNodesItems.hostID,
  "hostId",
  "java"
);
@@clientName(MongoUserDefinitionResource.userName, "username", "java");
@@clientName(MongoVCoreSourceSinkDetails.hostName, "hostname", "java");
@@clientName(CosmosMongoVCoreDataTransferDataSourceSink.hostName,
  "hostname",
  "java"
);
@@clientName(Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties,
  "ManagedServiceIdentityUserAssignedIdentities",
  "java"
);

@@usage(DatabaseAccountGetResults,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);
@@usage(DatabaseAccountGetProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

@@clientName(ARMProxyResource, "ArmProxyResource", "java");
@@clientName(ARMResourceProperties, "ArmResourceProperties", "java");
@@clientName(GraphAPIComputeRegionalServiceResource,
  "GraphApiComputeRegionalServiceResource",
  "java"
);
@@clientName(GraphAPIComputeServiceResourceProperties,
  "GraphApiComputeServiceResourceProperties",
  "java"
);
@@clientName(GraphAPIComputeServiceResource,
  "GraphApiComputeServiceResource",
  "java"
);
@@clientName(GraphAPIComputeServiceResourceCreateUpdateProperties,
  "GraphApiComputeServiceResourceCreateUpdateParameters",
  "java"
);
@@clientName(DataTransferServiceResourceCreateUpdateProperties,
  "DataTransferServiceResourceCreateUpdateParameters",
  "java"
);
@@clientName(MaterializedViewsBuilderServiceResourceCreateUpdateProperties,
  "MaterializedViewsBuilderServiceResourceCreateUpdateParameters",
  "java"
);
@@clientName(SqlDedicatedGatewayServiceResourceCreateUpdateProperties,
  "SqlDedicatedGatewayServiceResourceCreateUpdateParameters",
  "java"
);

@@clientName(ClusterResources.invokeCommandAsync,
  "invokeCommandAsyncResource",
  "java"
);
@@clientName(ClusterResources.getCommandAsync,
  "getCommandAsyncResource",
  "java"
);

@@clientName(ServerVersion.Three2, "THREE_TWO", "java");
@@clientName(ServerVersion.Three6, "THREE_SIX", "java");
@@clientName(ServerVersion.Four0, "FOUR_ZERO", "java");
@@clientName(ServerVersion.Four2, "FOUR_TWO", "java");
@@clientName(ServerVersion.Five0, "FIVE_ZERO", "java");
@@clientName(ServerVersion.Six0, "SIX_ZERO", "java");
@@clientName(ServerVersion.Seven0, "SEVEN_ZERO", "java");

@@clientName(FleetspacePropertiesThroughputPoolConfigurationServiceTier,
  "FleetspacePropertiesServiceTier",
  "java"
);

/**
 *  The subscription resource ID for an access rule.
 */
model AccessRulePropertiesSubscriptionsItem {
  /** The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000') */
  id?: Azure.Core.armResourceIdentifier;
}
@@alternateType(Azure.ResourceManager.CommonTypes.AccessRuleProperties.subscriptions,
  global.AccessRulePropertiesSubscriptionsItem[],
  "go"
);
