import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./Site.tsp";
import "./SiteAwareResourceTypes.tsp";
import "./backward-compatibles.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@doc("Azure Edge Sites Resource Provider management API.")
@armProviderNamespace
@service(#{ title: "Edge Sites" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Edge;

@doc("Supported API Versions")
enum Versions {
  @doc("API Version - 2025-03-01-preview")
  v2025_03_01_preview: "2025-03-01-preview",
}
