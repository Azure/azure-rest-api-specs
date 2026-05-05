import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryTasksManagementClient",
  "javascript"
);

@@clientName(Architecture.`386`, "ThreeHundredEightySix", "javascript");
@@clientName(Architecture.`386`, "X86_386", "java");

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryTasksMgmtClient",
  "python"
);
