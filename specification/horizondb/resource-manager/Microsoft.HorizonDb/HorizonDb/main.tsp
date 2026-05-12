import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./routes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/**
 * Azure Resource Provider API for managing HorizonDb clusters, pools, replicas, and firewall rules
 */
@armProviderNamespace
@service(#{ title: "Microsoft HorizonDb Management API" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.HorizonDb;

@doc("The available API versions.")
enum Versions {
  /**
   * The 2026-01-20-preview API version.
   */
  v2026_01_20_preview: "2026-01-20-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
