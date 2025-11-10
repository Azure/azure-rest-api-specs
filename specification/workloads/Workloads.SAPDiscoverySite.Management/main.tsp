import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./SAPDiscoverySite.tsp";
import "./SAPInstance.tsp";
import "./ServerInstance.tsp";
import "./back-compatible.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * SAP Migration client provides access to various operations for SAP Migration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Swagger is common for all RTs and is created as a separate file having it's own folder."
@armProviderNamespace
@service(#{ title: "Workloads Client" })
@versioned(Versions)
namespace Microsoft.Workloads;

/**
 * The available API versions.
 */
@doc("The Microsoft.Workloads/SAPDiscoverySites resource versions.")
enum Versions {
  /**
   * The 2023-10-01-preview API version.
   */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2023_10_01_preview: "2023-10-01-preview",

  /**
   * The 2024-06-01-preview API version.
   */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}
