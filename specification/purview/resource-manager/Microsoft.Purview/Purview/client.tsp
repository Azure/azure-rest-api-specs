import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Purview, "PurviewManagementClient", "javascript,python");
@@clientName(Microsoft.Purview.AccountSkuName, "Name", "java");
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatus,
  "Status",
  "java"
);
@@clientName(Microsoft.Purview.ManagedIdentityType, "Type", "java");
