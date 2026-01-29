import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./disconnectedOperations.tsp";
import "./images.tsp";
import "./artifacts.tsp";
import "./hardwareSettings.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@armProviderNamespace
@service(#{ title: "disconnected operations service" })
@versioned(Microsoft.Edge.Versions)
@doc("Disconnected operations service API.")
@armCommonTypesVersion(CommonTypes.Versions.v6)
namespace Microsoft.Edge;

@doc("The available API versions.")
enum Versions {
  @doc("Version 2025-06-01-preview")
  v2025_06_01: "2025-06-01-preview",

  @doc("Version 2026-03-01")
  v2026_03_01: "2026-03-01",
}
