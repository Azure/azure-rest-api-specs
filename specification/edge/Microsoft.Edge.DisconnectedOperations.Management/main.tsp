import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./disconnectedOperations.tsp";
import "./images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@armProviderNamespace
@service(#{ title: "disconnected operations service" })
@versioned(Versions)
@doc("Disconnected operations service API.")
@armCommonTypesVersion(CommonTypes.Versions.v6)
namespace Microsoft.Edge;

@doc("The available API versions.")
enum Versions {
  @doc("Version 2024-12-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_12_01: "2024-12-01-preview",
}
