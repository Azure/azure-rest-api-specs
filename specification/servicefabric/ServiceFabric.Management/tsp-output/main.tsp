import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Cluster.tsp";
import "./ApplicationTypeResource.tsp";
import "./ApplicationTypeVersionResource.tsp";
import "./ApplicationResource.tsp";
import "./ServiceResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Service Fabric Management Client
 */
@armProviderNamespace
@service({
  title: "ServiceFabricManagementClient",
})
@versioned(Versions)
namespace Microsoft.ServiceFabric;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-06-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_06_01: "2021-06-01",
}
