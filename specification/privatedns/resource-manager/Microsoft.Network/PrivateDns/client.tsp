import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Network, "PrivateDnsManagementClient", "javascript");
@@clientName(Microsoft.Network, "PrivateDnsManagementClient", "java");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.Network.PrivateZone,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "java"
);
