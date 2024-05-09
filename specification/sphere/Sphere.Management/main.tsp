import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./catalog.tsp";
import "./certificate.tsp";
import "./image.tsp";
import "./product.tsp";
import "./deviceGroup.tsp";
import "./deployment.tsp";
import "./device.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure Sphere resource management API.
 */
@armProviderNamespace
@service({
  title: "AzureSphereProviderClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.AzureSphere;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-04-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_04_01: "2024-04-01",
}
