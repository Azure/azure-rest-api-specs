import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./upns.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Commerce OfferCatalog Resource Provider management API. */
@armProviderNamespace("Microsoft.Commerce")
@service(#{ title: "Microsoft Commerce Offer Catalog" })
@versioned(Microsoft.Commerce.Versions)
namespace Microsoft.Commerce;

/** The available API versions for the Offer Catalog service. */
enum Versions {
  /** The 2026-04-24-preview API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @previewVersion
  v2026_04_24_preview: "2026-04-24-preview",
}

/** The operations supported by the Microsoft.Commerce resource provider for the Offer Catalog service. */
interface Operations extends Azure.ResourceManager.Operations {}
