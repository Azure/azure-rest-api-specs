import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./reviews.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Microsoft Marketplace Rating And Reviews API")
@armProviderNamespace("Microsoft.Marketplace")
@service(#{ title: "Microsoft Marketplace Rating And Reviews API" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.Marketplace;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-01-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_01_01_preview: "2023-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
