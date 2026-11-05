import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./operations.tsp";
import "./offer.tsp";
import "./publisher.tsp";
import "./client.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "EdgeMarketplaceClient" })
@versioned(Versions)
@doc("Edge marketplace extensions")
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.EdgeMarketplace;

@doc("The available API versions.")
enum Versions {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract."
  @doc("Version 2024-10-01")
  v2024_10_01: "2024-10-01",

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract."
  @doc("Version 2025-10-01-preview")
  v2025_10_01_preview: "2025-10-01-preview",
}
