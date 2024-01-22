import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CustomRollout.tsp";
import "./DefaultRollout.tsp";
import "./NotificationRegistration.tsp";
import "./ProviderRegistration.tsp";
import "./ResourceTypeRegistration.tsp";
import "./SkuResource.tsp";
import "./SkuResource.tsp";
import "./SkuResource.tsp";
import "./SkuResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Microsoft ProviderHub
 */
@armProviderNamespace
@service({
  title: "ProviderHub",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.ProviderHub;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2020-11-20 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_11_20: "2020-11-20",
}
