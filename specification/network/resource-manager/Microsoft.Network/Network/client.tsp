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
@@clientName(Microsoft.Network.PublicIPAddressPropertiesFormat,
  "PublicIpAddressPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.FrontendIPConfiguration,
  "FrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.FrontendIPConfigurationPropertiesFormat,
  "FrontendIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfiguration,
  "NetworkInterfaceIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurationPropertiesFormat,
  "NetworkInterfaceIpConfigurationPropertiesFormat",
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
@@clientName(Microsoft.Network.PublicIPAddressSkuTier,
  "PublicIpAddressSkuTier",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressDnsSettings,
  "PublicIpAddressDnsSettings",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressMigrationPhase,
  "PublicIpAddressMigrationPhase",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixSku, "PublicIpPrefixSku", "java");
@@clientName(Microsoft.Network.PublicIPPrefixSkuName,
  "PublicIpPrefixSkuName",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixSkuTier,
  "PublicIpPrefixSkuTier",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixPropertiesFormat,
  "PublicIpPrefixPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayIPConfiguration,
  "ApplicationGatewayIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayIPConfigurationPropertiesFormat,
  "ApplicationGatewayIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayFrontendIPConfiguration,
  "ApplicationGatewayFrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat,
  "ApplicationGatewayFrontendIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.AzureFirewallIPConfiguration,
  "AzureFirewallIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat,
  "AzureFirewallIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.AzureFirewallIPGroups,
  "AzureFirewallIpGroups",
  "java"
);
@@clientName(Microsoft.Network.AzureFirewallPublicIPAddress,
  "AzureFirewallPublicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.BastionHostIPConfiguration,
  "BastionHostIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.BastionHostIPConfigurationPropertiesFormat,
  "BastionHostIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.HubIPAddresses, "HubIpAddresses", "java");
@@clientName(Microsoft.Network.HubIPConfigurationPropertiesFormat,
  "HubIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.HubPublicIPAddresses,
  "HubPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.Network.IPAddressAvailabilityResult,
  "IpAddressAvailabilityResult",
  "java"
);
@@clientName(Microsoft.Network.IPConfiguration, "IpConfiguration", "java");
@@clientName(Microsoft.Network.IPConfigurationPropertiesFormat,
  "IpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.IPConfigurationBgpPeeringAddress,
  "IpConfigurationBgpPeeringAddress",
  "java"
);
@@clientName(Microsoft.Network.IPConfigurationProfile,
  "IpConfigurationProfile",
  "java"
);
@@clientName(Microsoft.Network.IPConfigurationProfilePropertiesFormat,
  "IpConfigurationProfilePropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.IPPrefixesList, "IpPrefixesList", "java");
@@clientName(Microsoft.Network.IPRule, "IpRule", "java");
@@clientName(Microsoft.Network.IPTraffic, "IpTraffic", "java");
@@clientName(Microsoft.Network.LoadBalancerVipSwapRequestFrontendIPConfiguration,
  "LoadBalancerVipSwapRequestFrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties,
  "LoadBalancerVipSwapRequestFrontendIpConfigurationProperties",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties,
  "NetworkInterfaceIpConfigurationPrivateLinkConnectionProperties",
  "java"
);
@@clientName(Microsoft.Network.PrivateEndpointIPConfiguration,
  "PrivateEndpointIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.PrivateEndpointIPConfigurationProperties,
  "PrivateEndpointIpConfigurationProperties",
  "java"
);
@@clientName(Microsoft.Network.PrivateEndpointIPVersionType,
  "PrivateEndpointIpVersionType",
  "java"
);
@@clientName(Microsoft.Network.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(Microsoft.Network.VerificationIPFlowParameters,
  "VerificationIpFlowParameters",
  "java"
);
@@clientName(Microsoft.Network.VerificationIPFlowResult,
  "VerificationIpFlowResult",
  "java"
);
@@clientName(Microsoft.Network.VirtualApplianceIPConfiguration,
  "VirtualApplianceIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.VirtualApplianceIPConfigurationProperties,
  "VirtualApplianceIpConfigurationProperties",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayIPConfiguration,
  "VirtualNetworkGatewayIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat,
  "VirtualNetworkGatewayIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.VpnClientIPsecParameters,
  "VpnClientIpsecParameters",
  "java"
);
