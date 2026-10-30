import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./operations.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/** Estimates prices for proposed configurations using subscription-applicable prices. */
@service(#{ title: "Cost Management Price Estimation" })
@armProviderNamespace
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.CostManagement;

/** Versions of the price estimation contract. */
enum Versions {
  /** In-development contract for review; not a customer release. */
  @previewVersion
  v2026_10_01_preview: "2026-10-01-preview",
}

/** Standard metadata for the existing resource provider, not another estimation business API. */
interface Operations extends Azure.ResourceManager.Operations {}
