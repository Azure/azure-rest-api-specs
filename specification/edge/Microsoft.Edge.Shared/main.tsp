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
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_02_01_preview: "2024-02-01-preview",

  /**
   * The 2025-03-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_03_01_preview: "2025-03-01-preview",

  /**
   * The 2025-06-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_06_01: "2025-06-01",
}

/**
 * The ProvisioningState
 */
union ProvisioningState {
  string,
  ResourceProvisioningState,
}
