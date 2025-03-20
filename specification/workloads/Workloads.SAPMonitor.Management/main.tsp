import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Monitor.tsp";
import "./ProviderInstance.tsp";
import "./SapLandscapeMonitor.tsp";
import "./Alert.tsp";
import "./AlertTemplate.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * The workload SAP monitor Client.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Swagger is common for all RTs and is created as a separate file having it's own folder."
@armProviderNamespace
@service(#{ title: "Workloads Client" })
@versioned(Versions)
namespace Microsoft.Workloads;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-12-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_12_01_preview: "2023-12-01-preview",

  /**
   * The 2024-02-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_02_01_preview: "2024-02-01-preview",
}
