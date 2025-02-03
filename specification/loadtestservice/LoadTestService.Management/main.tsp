import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "LoadTest Client",
})
@doc("LoadTest client provides access to LoadTest Resource and it's status operations.")
@versioned(APIVersions)
namespace Microsoft.LoadTestService;

@doc("The Loadtest service resource manager version.")
enum APIVersions {
  @doc("The 2022-12-01 version of the Azure Load Testing Resource manager API.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2022_12_01: "2022-12-01",

  @doc("The 2023-12-01-preview version of the Azure Load Testing Resource manager API.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_12_01_preview: "2023-12-01-preview",

  @doc("The 2024-12-01-preview version of the Azure Load Testing Resource manager API.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_01_preview: "2024-12-01-preview",
}
