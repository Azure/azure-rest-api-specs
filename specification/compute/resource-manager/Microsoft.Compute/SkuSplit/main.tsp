import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./SkuMixPlacementBase.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * The Compute SkuSplit Resource Provider Client
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Already exist outside this subservice"
@armProviderNamespace
@service(#{ title: "ComputeSkuSplitResourceProviderClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.Compute;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-04-01-preview API version.
   */
  v2026_04_01_preview: "2026-04-01-preview",
}
