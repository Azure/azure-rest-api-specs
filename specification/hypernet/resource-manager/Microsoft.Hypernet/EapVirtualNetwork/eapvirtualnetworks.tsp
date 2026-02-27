import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Hypernet;

@doc("EAP Hypernet Virtual Network resource for managing eap virtual network infrastructure with subscription onboarding and IP reservation capabilities.")
model EapVirtualNetwork is ProxyResource<EapVirtualNetworkProperties> {
  @key("eapVirtualNetworkName")
  @segment("eapVirtualNetworks")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @minLength(3)
  @maxLength(24)
  @doc("The name of the EAP Virtual Network")
  name: string;
}

@doc("Properties of EAP Hypernet Virtual Network including subscription management, network configuration, and subnet definitions.")
model EapVirtualNetworkProperties {
  @doc("Microsoft Entra tenant ID associated with the subscription.")
  subscriptionTenantId: string;

  @doc("Comma-separated list of distribution lists for notifications and communications.")
  distributionList: string;

  @doc("Comma-separated list of security groups with access permissions.")
  securityGroups: string;

  @doc("Backend environment type for the virtual network deployment (Autopilot or Pilotfish).")
  backendEnvironment: BackendEnvironment;

  @doc("Name of the virtual network to be created or managed.")
  virtualNetworkName: string;

  @doc("Business category classification for the virtual network deployment. If the business category is shared, use 'EapNetworkProvision'. Otherwise, use the business category specific to your service or organization.")
  businessCategory: string;

  @doc("Comma-separated list of Manatree owners responsible for network management.")
  manatreeOwners: string;

  @doc("Azure region where the virtual network will be deployed (e.g., westus, eastus).")
  region: string;

  @doc("List of subnet configurations within the virtual network, including IP reservations.")
  @identifiers(#["name"])
  virtualNetworkSubnets: VirtualNetworkSubnet[];

  @doc("Comma-separated list of owner aliases responsible for the virtual network.")
  ownerAliasList?: string;

  @doc("Comma-separated list of tags applied to the subscription for categorization and billing.")
  subscriptionTags?: string;

  @doc("Flag indicating whether test cluster applications are allowed in this virtual network.")
  allowTestClusterApplications?: boolean;

  @doc("Comma-separated list of tags to be applied to the virtual network for organization and billing.")
  tags?: string;

  @visibility(Lifecycle.Read)
  @doc("Provisioning status of the resource.")
  provisioningState?: ProvisioningState;
}

@doc("Available backend environment types for EAP Hypernet Virtual Network deployment.")
union BackendEnvironment {
  string,

  @doc("Autopilot backend environment for standard deployments.")
  Autopilot: "Autopilot",

  @doc("Pilotfish backend environment for specialized deployments.")
  Pilotfish: "Pilotfish",
}

@doc("Configuration for a subnet within the virtual network, including IP allocation and reservation settings.")
model VirtualNetworkSubnet {
  @doc("Name of the subnet within the virtual network.")
  name: string;

  @doc("Type of IP addressing scheme for the subnet (IPv4, IPv6, or regional reuse).")
  ipType: IpType;

  @doc("Flag indicating whether to use bring-your-own IP addresses for this subnet.")
  isBringYourOwnIp?: boolean;

  @doc("List of IP reservation configurations for this subnet, including size and justification.")
  @identifiers(#[])
  ips: IpReservation[];
}

@doc("Available IP addressing types for subnet configuration.")
union IpType {
  string,

  @doc("Unique IPv4 address allocation for exclusive use.")
  UniqueIPv4: "UniqueIPv4",

  @doc("IPv4 address allocation that allows regional reuse for optimization.")
  IPv4RegionalReuse: "IPv4RegionalReuse",

  @doc("IPv6 address allocation for next-generation networking.")
  IPv6: "IPv6",
}

@doc("Configuration for IP address reservation within a subnet, supporting both subnet size and prefix-based allocation.")
model IpReservation {
  @doc("Size of the subnet in terms of the number of available IP addresses (CIDR notation).")
  subnetSize?: int32;

  @doc("IP prefix for bring-your-own IP address configurations when using custom IP ranges.")
  prefix?: string;

  @doc("Tags associated with the IP reservation for categorization and tracking.")
  tags?: string;

  @doc("Business justification or reason for the IP address reservation request.")
  justification?: string;
}

@doc("Current state of the EAP Hypernet Virtual Network resource provisioning process.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The virtual network resource is currently being provisioned.")
  Provisioning: "Provisioning",

  @doc("The virtual network resource is being updated with new configuration.")
  Updating: "Updating",

  @doc("The virtual network creation request has been accepted and queued for processing.")
  Accepted: "Accepted",

  string,
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@doc("Operations for managing EAP Hypernet Virtual Network resources including CRUD operations and listing capabilities.")
@armResourceOperations
interface EapVirtualNetworks {
  @doc("Get details of an EAP Hypernet Virtual Network resource.")
  get is ArmResourceRead<EapVirtualNetwork>;

  @doc("Create or update an EAP Hypernet Virtual Network with subscription onboarding and network deployment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EapVirtualNetwork>;

  @doc("List all EAP Hypernet Virtual Networks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<EapVirtualNetwork>;
}
