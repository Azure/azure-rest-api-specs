import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Provisioning state of resource")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource Provisioning is initialized")
  Initialized: "Initialized",

  @doc("Resource Provisioning is in progress")
  Inprogress: "InProgress",

  @doc("Resource Provisioning is deleting")
  Deleting: "Deleting",

  string,
}
