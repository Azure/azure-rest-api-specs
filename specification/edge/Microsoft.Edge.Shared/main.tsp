import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
namespace Microsoft.Edge;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-02-01-preview API version.
   */
  v2024_02_01_preview: "2024-02-01-preview",
}

/**
 * The ProvisioningState
 */
union ProvisioningState {
  string,
  ResourceProvisioningState,
}
