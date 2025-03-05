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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
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
  v2024_12_01_preview: "2024-12-01-preview",
}
