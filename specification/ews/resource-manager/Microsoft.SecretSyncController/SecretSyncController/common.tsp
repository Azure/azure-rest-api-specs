import "@azure-tools/typespec-azure-resource-manager";
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SecretSyncController")
namespace Microsoft.SecretSyncController;

@doc("Provisioning state of the resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,
}
