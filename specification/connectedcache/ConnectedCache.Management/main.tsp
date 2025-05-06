import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./enterpriseCustomerspreviewResource.tsp";
import "./cacheNodespreviewResource.tsp";
import "./ispCustomers.tsp";
import "./ispCacheNodes.tsp";
import "./enterpriseMccCustomers.tsp";
import "./enterpriseMccCacheNodes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service(#{ title: "ConnectedCache" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("Microsoft Connected Cache Rest Api version 2023-05-01-preview")
namespace Microsoft.ConnectedCache;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Microsoft Connected Cache Rest Api version 2023-05-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_05_01_preview: "2023-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Microsoft Connected Cache Rest Api version 2024-11-30-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_11_30_preview: "2024-11-30-preview",
}
