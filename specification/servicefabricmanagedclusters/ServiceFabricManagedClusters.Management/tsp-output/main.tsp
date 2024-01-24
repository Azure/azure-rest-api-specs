import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ApplicationTypeResource.tsp";
import "./ApplicationTypeVersionResource.tsp";
import "./ApplicationResource.tsp";
import "./ServiceResource.tsp";
import "./ManagedCluster.tsp";
import "./NodeType.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Service Fabric Managed Clusters Management Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "ServiceFabricManagedClustersManagementClient",
})
@versioned(Versions)
namespace Microsoft.ServiceFabric;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-03-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_03_01_preview: "2023-03-01-preview",
}
