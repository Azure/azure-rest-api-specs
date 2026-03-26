import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ContainerInstance,
  "ContainerInstanceManagementClient",
  "javascript,python"
);
@@clientName(Azure.ResourceManager.CommonTypes.Resource,
  "ArmResource",
  "python,javascript"
);
