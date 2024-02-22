import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./offer.tsp";
import "./publisher.tsp";
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "EdgeMarketplaceClient",
})
@versioned(Versions)
@doc("Edge marketplace extensions")
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.EdgeMarketplace;

@doc("The available API versions.")
enum Versions {
  @doc("Version 2024-01-01")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_00_01: "2024-01-01",
}
