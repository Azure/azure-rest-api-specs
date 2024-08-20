import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure Stack HCI management service
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "HCI itself is a short form."
@armProviderNamespace
@service({
  title: "Microsoft.AzureStackHCI",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AzureStackHCI;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-02-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_01_preview: "2024-02-01-preview",

  /**
   * The 2024-05-01-preview API version for internal testing only.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_05_01_preview: "2024-05-01-preview",
}
