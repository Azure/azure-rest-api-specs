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
@doc("Represents a server in a cluster.")
@parentResource(Cluster)
model ClusterServer is ProxyResource<ClusterServerProperties> {
  @doc("The name of the server.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @path
  @key("serverName")
  @segment("servers")
  name: string;
}

@armResourceOperations
interface ClusterServers {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about a server in cluster.")
  @operationId("Servers_Get")
  get is ArmResourceRead<ClusterServer>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists servers of a cluster.")
  @operationId("Servers_ListByCluster")
  listByCluster is ArmResourceListByParent<ClusterServer>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_ListByServer")
  @doc("List all the configurations of a server in cluster.")
  // FIXME: Configurations_ListByServer could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforPostgreSQL/serverGroupsv2/{clusterName}/servers/{serverName}/configurations")
  @get
  listByServer is Azure.Core.Foundations.Operation<
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
