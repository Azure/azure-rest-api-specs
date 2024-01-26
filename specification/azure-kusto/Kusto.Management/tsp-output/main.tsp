import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Cluster.tsp";
import "./ClusterPrincipalAssignment.tsp";
import "./Database.tsp";
import "./AttachedDatabaseConfiguration.tsp";
import "./ManagedPrivateEndpoint.tsp";
import "./DatabasePrincipalAssignment.tsp";
import "./Script.tsp";
import "./SandboxCustomImage.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";
import "./DataConnection.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Azure Kusto management API provides a RESTful set of web services that interact with Azure Kusto services to manage your clusters and databases. The API enables you to create, update, and delete clusters and databases.
 */
@armProviderNamespace
@service({
  title: "KustoManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.Kusto;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-08-15 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_08_15: "2023-08-15",
}
