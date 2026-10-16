import "@typespec/openapi";
import "@typespec/rest";
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

@doc("A fully qualified ARM resource ID referencing an azure service connection controller.")
scalar AzureServiceConnectionControllerId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/azureServiceConnectionControllers",
    }
  ]>;

@doc("The allowed Private IP allocation methods")
union IPAllocationMethod {
  @doc("Static Private IP address allocation")
  Static: "Static",

  string,
}

@doc("The provisioning state of the Probing Gateway resource.")
union ProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,

  @doc("The resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource is being updated.")
  Updating: "Updating",

  string,
}

@doc("Class representing the Probing Gateway IP configuration properties.")
model ProbingGatewayIpConfiguration {
  @doc("The private IP V4 address of the Probing Gateway.")
  privateIpV4Address?: ipV4Address;

  @doc("Private IP Allocation Method")
  privateIpAllocationMethod?: IPAllocationMethod = IPAllocationMethod.Static;
}

@doc("Class representing the Probing Gateway properties.")
model ProbingGatewayProperties {
  @doc("The reference to the subnet where the Probing Gateway is deployed.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: SubnetId;

  @doc("The IP configuration parameters for the Probing Gateway.")
  @identifiers(#[])
  ipConfigurations?: ProbingGatewayIpConfiguration[];

  @visibility(Lifecycle.Read)
  @doc("The ID of the Azure Service Connection Controller created and managed by this Probing Gateway. Customers cannot directly create or delete the controller; its lifecycle follows this gateway.")
  azureServiceConnectionControllerId?: AzureServiceConnectionControllerId;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
