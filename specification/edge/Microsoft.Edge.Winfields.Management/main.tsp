import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./winfields.tsp";
import "./images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@armProviderNamespace
@service(#{ title: "winfields service" })
@versioned(Versions)
@doc("Arc-A winfields Service API.")
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.Edge;

@doc("The available API versions.")
enum Versions {
  @doc("Version 2024-11-01-preview")
  v2024_02_01: "2024-11-01-preview",
}
