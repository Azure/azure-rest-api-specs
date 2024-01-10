import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DBforPostgreSQL;
@doc("Represents a configuration.")
@parentResource(Cluster)
model ServerConfiguration is ProxyResource<ServerConfigurationProperties> {
  @doc("The name of the cluster configuration.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @key("configurationName")
  @segment("coordinatorConfigurations")
  name: string;
}

@armResourceOperations
@projectedName("client", "Configurations")
interface ServerConfigurations_Configurations {
  @doc("Gets information of a configuration for coordinator.")
  getCoordinator is ArmResourceRead<ServerConfiguration>;

  @doc("Updates configuration of coordinator in a cluster")
  updateOnCoordinator is ArmResourceCreateOrUpdateAsync<ServerConfiguration>;
}
