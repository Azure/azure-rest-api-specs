import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Edge,
  "DisconnectedOperationsManagementClient",
  "javascript"
);
@@clientName(Microsoft.Edge, "DisconnectedOperationsMgmt", "python");
