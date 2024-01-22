import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Extension.tsp";
import "./FarmBeatsExtension.tsp";
import "./FarmBeats.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * APIs documentation for Azure AgFoodPlatform Resource Provider Service.
 */
@armProviderNamespace
@service({
  title: "Azure AgFoodPlatform RP Service",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.AgFoodPlatform;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-09-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_09_01_preview: "2021-09-01-preview",
}
