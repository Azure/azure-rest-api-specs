import "./Network/main.tsp";
import "./Vmss/main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Azure.Core;
using Microsoft.Network;
using Microsoft.Compute;
@client({
  name: "CombineClient",
  service: [Microsoft.Network, Microsoft.Compute],
})
@useDependency(
  Microsoft.Network.Versions.v2025_05_01,
  Microsoft.Compute.Versions.v2018_10_01
)
namespace CombineClient;

@@clientName(CombineClient, "NetworkManagementClient", "javascript");
@@clientName(Microsoft.Network.ErrorResponse,
  "NetworkWatcherErrorResponse",
  "java"
);
@@clientName(Microsoft.Network.Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties,
  "UserAssignedIdentity",
  "java"
);

// Fix IP -> Ip naming for Java backward compatibility (Swagger -> TypeSpec migration)
@@clientName(Microsoft.Network.PublicIPAddress, "PublicIpAddress", "java");
@@clientName(Microsoft.Network.FrontendIPConfiguration,
  "FrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfiguration,
  "NetworkInterfaceIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.IPVersion, "IpVersion", "java");
@@clientName(Microsoft.Network.IPAllocationMethod,
  "IpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressSku,
  "PublicIpAddressSku",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressSkuName,
  "PublicIpAddressSkuName",
  "java"
);
