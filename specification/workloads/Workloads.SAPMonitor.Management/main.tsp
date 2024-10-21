import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Monitor.tsp";
import "./ProviderInstance.tsp";
import "./SapLandscapeMonitor.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * The workload SAP monitor Client.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Swagger is common for all RTs and is created as a separate file having it's own folder."
@armProviderNamespace
@service({
  title: "Workloads Client test",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
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
  v2023_12_01_preview: "2023-12-01-preview",
}
