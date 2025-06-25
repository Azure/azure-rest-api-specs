import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("Provisioning state of the resource")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource is getting provisioned.")
  Provisioning: "Provisioning",

  @doc("Resource is Updating.")
  Updating: "Updating",

  @doc("Resource is Deleting.")
  Deleting: "Deleting",

  @doc("Resource has been Accepted.")
  Accepted: "Accepted",
}

@doc("Provisioning resource details for Internal Metadata")
model ProvisionResource {
  @doc("The name of the resource")
  name: string;

  @doc("Type of the resource")
  type: string;

  @doc("Resource ID of the resource")
  resourceId: string;
}

@doc("UMI resource details for AppLink Member Internal Metadata")
model UnderlayMetadata {
  @doc("The name of the underlay resource")
  name: string;

  @doc("The tenant ID of the underlay resource")
  tenantId: string;

  @doc("Location of the underlay resource")
  location: string;

  @doc("The subscription ID of the resource provisioning")
  resourceProvisionSubId: string;

  @doc("The resource group of the resource provisioning")
  resourceProvisionRg: string;

  @doc("Ingress gateway IP address for the underlay")
  ingressGatewayIp: string;

  @doc("Underlay address")
  meshManagerAddress: string;
}
