import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./EpicVirtualInstance.tsp";
import "./WssServerInstance.tsp";
import "./DatabaseServerInstance.tsp";
import "./HyperspaceWebServerInstance.tsp";
import "./PresentationServerInstance.tsp";
import "./SharedServerInstance.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Epic client provides access to various epic operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Swagger is common for all RTs and is created as a separate file having it's own folder."
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
   * The 2024-04-01-preview API version.
   */
  v2024_04_01_preview: "2024-04-01-preview",
}
