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
