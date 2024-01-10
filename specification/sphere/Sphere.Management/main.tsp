import "./common.tsp";
import "./catalog.tsp";
import "./image.tsp";
import "./deviceGroup.tsp";
import "./certificate.tsp";
import "./deployment.tsp";
import "./device.tsp";
import "./deviceGroup.tsp";
import "./product.tsp";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "AzureSphereProviderClient",
})
@doc("Azure Sphere resource management API.")
@versioned(Microsoft.AzureSphere.Versions)
namespace Microsoft.AzureSphere;

@doc("Azure Sphere API versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Public preview API version.")
  v2022_09_01: "2022-09-01-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Initial GA API version.")
  v2024_04_01: "2024-04-01",
}
