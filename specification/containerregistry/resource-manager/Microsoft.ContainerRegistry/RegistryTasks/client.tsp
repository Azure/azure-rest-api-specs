import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Microsoft.ContainerRegistry;

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryTasksManagementClient",
  "javascript"
);
