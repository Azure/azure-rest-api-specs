import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./operations.tsp";
import "./offer.tsp";
import "./publisher.tsp";

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
  @doc("Version 2024-10-01")
  v2024_10_01: "2024-10-01",

  @doc("Version 2025-10-01-preview")
  v2025_10_01_preview: "2025-10-01-preview",

  @doc("Version 2026-01-01-preview")
  v2026_01_01_preview: "2026-01-01-preview",
}
