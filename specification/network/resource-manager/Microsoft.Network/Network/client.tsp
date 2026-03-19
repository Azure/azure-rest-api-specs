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

// Java naming mitigations
@@clientName(Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayHttpListenerPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(Microsoft.Network.BastionActiveSession.userName,
  "username",
  "java"
);
@@clientName(Microsoft.Network.AzureReachabilityReportLatencyInfo.timeStamp,
  "timestamp",
  "java"
);
@@clientName(Microsoft.Network.QosIpRange.startIP, "startIp", "java");
@@clientName(Microsoft.Network.QosIpRange.endIP, "endIp", "java");
@@clientName(Microsoft.Network.ErrorResponse, "NetworkErrorResponse", "java");
@@clientName(Microsoft.Network.Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties,
  "ManagedServiceIdentityUserAssignedIdentities",
  "java"
);

// IP → Ip naming mitigations for backward compatibility with hand-written wrapper code
@@clientName(Microsoft.Network.PublicIPAddress, "PublicIpAddress", "java");
@@clientName(Microsoft.Network.PublicIPPrefix, "PublicIpPrefix", "java");
@@clientName(Microsoft.Network.FrontendIPConfiguration,
  "FrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.IPConfiguration, "IpConfiguration", "java");
@@clientName(Microsoft.Network.IPConfigurationProfile,
  "IpConfigurationProfile",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfiguration,
  "NetworkInterfaceIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.IPAddressAvailabilityResult,
  "IpAddressAvailabilityResult",
  "java"
);
@@clientName(Microsoft.Network.VerificationIPFlowResult,
  "VerificationIpFlowResult",
  "java"
);
@@clientName(Microsoft.Network.VerificationIPFlowParameters,
  "VerificationIpFlowParameters",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayIPConfiguration,
  "VirtualNetworkGatewayIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayIPConfiguration,
  "ApplicationGatewayIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayFrontendIPConfiguration,
  "ApplicationGatewayFrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.IPAllocationMethod,
  "IpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.IPVersion, "IpVersion", "java");
@@clientName(Microsoft.Network.PublicIPAddressSku,
  "PublicIpAddressSku",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressSkuName,
  "PublicIpAddressSkuName",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixSku, "PublicIpPrefixSku", "java");
