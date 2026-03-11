import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Cache, "RedisEnterpriseManagementClient", "javascript");
@@clientName(Microsoft.Cache, "RedisEnterpriseManagementClient", "python");

@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python"
);
