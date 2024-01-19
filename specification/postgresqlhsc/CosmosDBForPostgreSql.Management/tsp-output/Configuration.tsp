import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
@doc("Represents configuration details for coordinator and node.")
@parentResource(Cluster)
model Configuration is ProxyResource<ConfigurationProperties> {
  @doc("The name of the cluster configuration.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;
}

@armResourceOperations
interface Configurations {
  @doc("Gets information of a configuration for coordinator and nodes.")
  get is ArmResourceRead<Configuration>;

  @doc("List all the configurations of a cluster.")
  listByCluster is ArmResourceListByParent<Configuration>;
}
