import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ClusterMigrationAgent.tsp";

using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * Service Fabric migration management client. Provides the cluster migration agent resource used to move a
 * classic Service Fabric cluster to a Service Fabric managed cluster.
 */
@armProviderNamespace
@service(#{ title: "ServiceFabricMigrationManagementClient" })
@versioned(Versions)
namespace Microsoft.ServiceFabric;

/**
 * The available API versions.
 */
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_06_01_preview: "2026-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
