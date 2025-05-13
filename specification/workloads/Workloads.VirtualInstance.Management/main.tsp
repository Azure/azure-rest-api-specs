import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./VirtualInstance.tsp";
import "./WorkloadComponent.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Workloads client provides access to various workload operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
@armProviderNamespace
@service(#{ title: "Workloads Client" })
@versioned(Versions)
namespace Microsoft.Workloads;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-12-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_01_preview: "2024-12-01-preview",

  /**
   * The 2025-06-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_06_01_preview: "2025-06-01-preview",
}
