import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AzureLargeInstance.tsp";
import "./AzureLargeStorageInstance.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@Azure.ResourceManager.armCommonTypesVersion("v5")
@armProviderNamespace
@service({
  title: "Azure Large Instance",
})
@doc("The AzureLargeInstance Management client")
@versioned(Versions)
namespace Microsoft.AzureLargeInstance;

@doc("Azure Large Instance api versions.")
enum Versions {
  @doc("Azure Large Instance api version 2023-07-20-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_07_20_preview: "2023-07-20-preview",

  @doc("Azure Large Instance api version 2024-04-10.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_04_10: "2024-04-10",

  @doc("Azure Large Instance api version 2024-08-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_08_01_preview: "2024-08-01-preview",
}
