import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ConfigurationValidationResults.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Workloads client provides access to various workload operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Swagger is common for all RTs and is created as a separate file having it's own folder."
@armProviderNamespace
@service({
  title: "Workloads Client",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Workloads;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-10-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_10_01_preview: "2024-10-01-preview",
}
