import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./routes.tsp";
import "./client.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

/**
 * Azure Resource Provider API for managing HorizonDB clusters, pools, replicas, and firewall rules
 */
@armProviderNamespace
@service(#{ title: "Microsoft HorizonDB Management API" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.HorizonDb;

@doc("The available API versions.")
enum Versions {
  @doc("The 2026-01-20-preview API version.")
  v2026_01_20_preview: "2026-01-20-preview",

  @doc("The 2026-05-01-preview API version.")
  @previewVersion
  v2026_05_01_preview: "2026-05-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
