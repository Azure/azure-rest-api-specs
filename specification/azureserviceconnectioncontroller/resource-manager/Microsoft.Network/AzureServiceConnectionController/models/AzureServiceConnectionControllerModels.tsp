import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Network;

@doc("A fully qualified ARM resource ID referencing a subnet.")
scalar SubnetId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets",
    }
  ]>;

@doc("The provisioning state of the Azure Service Connection Controller resource.")
union AzureServiceConnectionControllerProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,
  string,
}

@doc("A fully qualified ARM resource ID referencing a user-defined route.")
scalar UDR
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/routeTables/routes",
    }
  ]>;

@doc("The allowed Private IP allocation methods")
union IPAllocationMethod {
  @doc("Static Private IP address allocation")
  Static: "Static",

  string,
}

@doc("Class representing the IP configuration properties.")
model IpConfiguration {
  @doc("The IP V4 address.")
  privateIpV4Address?: ipV4Address;

  @doc("Private IP Allocation Method")
  ipAllocationMethod?: IPAllocationMethod;
}

@doc("Properties describing a provider connection for a Private Outbound resource.")
model ProviderConnectionProperties {
  @doc("The name of the provider connection.")
  name?: string;

  @doc("The resource ID of the virtual network associated with the provider connection.")
  subnetId?: SubnetId;

  @doc("The IP configuration parameters for the provider connection.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  ipConfiguration?: IpConfiguration;

  @doc("The resource ID of the source private endpoint associated with the provider connection.")
  @visibility(Lifecycle.Read)
  sourceResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;
}

@doc("Class representing the Azure Service Connection Controller properties.")
model AzureServiceConnectionControllerProperties {
  @doc("The reference to the subnet where the Azure Service Connection Controller is deployed.")
  subnetId?: SubnetId;

  @doc("The IP configuration parameters for the Azure Service Connection Controller.")
  @identifiers(#[])
  ipConfigurations?: IpConfiguration[];

  @doc("Properties of the related Azure components providing the underlying infrastructure.")
  @identifiers(#["name"])
  providerConnections?: ProviderConnectionProperties[];

  @visibility(Lifecycle.Read)
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureServiceConnectionControllerProvisioningState;

  @doc("The reference to the effective UDR (User Defined Route) applied to the Azure Service Connection Controller.")
  udr?: UDR;
}
