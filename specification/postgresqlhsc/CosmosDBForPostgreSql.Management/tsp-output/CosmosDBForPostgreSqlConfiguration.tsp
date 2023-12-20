import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./CosmosDBForPostgreSqlCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CosmosDBForPostgreSql;
@doc("Represents configuration details for coordinator and node.")
@parentResource(CosmosDBForPostgreSqlCluster)
model CosmosDBForPostgreSqlConfiguration
  is ProxyResource<ConfigurationProperties> {
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
interface CosmosDBForPostgreSqlConfigurations {
  @doc("Gets information of a configuration for coordinator and nodes.")
  get is ArmResourceRead<CosmosDBForPostgreSqlConfiguration>;
  @doc("List all the configurations of a cluster.")
  listByCluster is ArmResourceListByParent<CosmosDBForPostgreSqlConfiguration>;
}
