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
@doc("Represents a server in a cluster.")
@parentResource(Cluster)
model ClusterServer is ProxyResource<ClusterServerProperties> {
  @doc("The name of the server.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @key("serverName")
  @segment("servers")
  name: string;
}

@armResourceOperations
@projectedName("client", "Servers")
interface ClusterServers_Servers {
  @doc("Gets information about a server in cluster.")
  get is ArmResourceRead<ClusterServer>;

  @doc("Lists servers of a cluster.")
  listByCluster is ArmResourceListByParent<ClusterServer>;
}

@armResourceOperations
@projectedName("client", "Configurations")
interface ClusterServers_Configurations {
  @doc("List all the configurations of a server in cluster.")
  // FIXME: Configurations_ListByServer could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforPostgreSQL/serverGroupsv2/{clusterName}/servers/{serverName}/configurations")
  @get
  ListByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @maxLength(40)
      @minLength(3)
      @pattern("^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$")
      @path
      clusterName: string;

      @doc("The name of the server.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      serverName: string;
    },
    ServerConfigurationListResult
  >;
}
