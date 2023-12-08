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
@doc("Represents a configuration.")
@parentResource(CosmosDBForPostgreSqlCluster)
model CosmosDBForPostgreSqlCoordinatorConfiguration
  is ProxyResource<ServerConfigurationProperties> {
  @doc("The name of the cluster configuration.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @path
  @key("configurationName")
  @segment("coordinatorConfigurations")
  name: string;
}

@armResourceOperations
interface CosmosDBForPostgreSqlCoordinatorConfigurations {
  @doc("Gets information of a configuration for coordinator.")
  getCoordinator is ArmResourceRead<CosmosDBForPostgreSqlCoordinatorConfiguration>;
  @doc("Updates configuration of coordinator in a cluster")
  updateOnCoordinator is ArmResourceCreateOrUpdateAsync<CosmosDBForPostgreSqlCoordinatorConfiguration>;
}
