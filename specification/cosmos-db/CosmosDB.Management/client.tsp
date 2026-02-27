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
  "GraphApiComputeServiceResourceCreateUpdateProperties",
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
