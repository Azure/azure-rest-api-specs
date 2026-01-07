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
   * The 2024-10-01-preview API version.
   */
  v2024_10_01_preview: "2024-10-01-preview",

  /**
   * The 2024-11-01-preview API version.
   */
  v2024_11_01_preview: "2024-11-01-preview",
}

@added(Versions.v2024_11_01_preview)
interface Operations extends Azure.ResourceManager.Operations {}
