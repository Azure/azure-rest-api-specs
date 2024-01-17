import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ElasticSan.tsp";
import "./VolumeGroup.tsp";
import "./Volume.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";
import "./Snapshot.tsp";
import "./routes.tsp";
import "./templates.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "ElasticSanManagement",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("Microsoft Elastic San Management API")
namespace Microsoft.ElasticSan;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-01-01 API version.")
  v2023_01_01: "2023-01-01",
}
