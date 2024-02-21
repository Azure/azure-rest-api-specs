import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

/**
 * The ProvisioningState
 */
enum ProvisioningState {
  ...ResourceProvisioningState,
}
