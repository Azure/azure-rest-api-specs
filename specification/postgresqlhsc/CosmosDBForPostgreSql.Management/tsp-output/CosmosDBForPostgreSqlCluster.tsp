import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CosmosDBForPostgreSql;
@doc("Represents a cluster.")
model CosmosDBForPostgreSqlCluster is TrackedResource<ClusterProperties> {
  @doc("The name of the cluster.")
  @maxLength(40)
  @minLength(3)
  @pattern("^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$")
  @path
  @key("clusterName")
  @segment("serverGroupsv2")
  name: string;
}

@armResourceOperations
interface CosmosDBForPostgreSqlClusters {
  @doc("Gets information about a cluster such as compute and storage configuration and cluster lifecycle metadata such as cluster creation date and time.")
  get is ArmResourceRead<CosmosDBForPostgreSqlCluster>;
  @doc("Creates a new cluster with servers.")
  create is ArmResourceCreateOrUpdateAsync<CosmosDBForPostgreSqlCluster>;
  @doc("Updates an existing cluster. The request body can contain one or several properties from the cluster definition.")
  update is ArmResourcePatchAsync<
    CosmosDBForPostgreSqlCluster,
    ClusterProperties
  >;
  @doc("Deletes a cluster together with servers in it.")
  delete is ArmResourceDeleteAsync<CosmosDBForPostgreSqlCluster>;
  @doc("Lists all clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<CosmosDBForPostgreSqlCluster>;
  @doc("Lists all clusters in a subscription.")
  list is ArmListBySubscription<CosmosDBForPostgreSqlCluster>;
  @doc("Restarts all nodes in the cluster.")
  restart is ArmResourceActionNoResponseContentAsync<
    CosmosDBForPostgreSqlCluster,
    {}
  >;
  @doc("Starts stopped compute on all cluster nodes.")
  start is ArmResourceActionAsync<CosmosDBForPostgreSqlCluster, {}, {}>;
  @doc("Stops compute on all cluster nodes.")
  stop is ArmResourceActionAsync<CosmosDBForPostgreSqlCluster, {}, {}>;
  @doc("Promotes read replica cluster to an independent read-write cluster.")
  promoteReadReplica is ArmResourceActionNoResponseContentAsync<
    CosmosDBForPostgreSqlCluster,
    {}
  >;
}
