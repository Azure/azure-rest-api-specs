import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientName(Microsoft.ServiceFabric,
  "ServiceFabricManagementClient",
  "javascript"
);
