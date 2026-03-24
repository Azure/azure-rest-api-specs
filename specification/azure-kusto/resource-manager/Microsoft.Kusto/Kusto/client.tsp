import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Kusto, "KustoManagementClient", "javascript");
@@clientName(Microsoft.Kusto.ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties,
  "IdentityUserAssignedIdentities",
  "java"
);
@@clientName(Microsoft.Kusto.PublicIPType, "PublicIpType", "java");
@@clientName(Microsoft.Kusto.ClusterProperties.publicIPType,
  "publicIpType",
  "java"
);
