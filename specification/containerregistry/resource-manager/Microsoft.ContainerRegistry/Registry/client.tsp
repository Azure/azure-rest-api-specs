import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryManagementClient",
  "javascript"
);
