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
model Cluster is TrackedResource<ClusterProperties> {
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
interface Clusters {
  @doc("Gets information about a cluster such as compute and storage configuration and cluster lifecycle metadata such as cluster creation date and time.")
  get is ArmResourceRead<Cluster>;
  @doc("Creates a new cluster with servers.")
  create is ArmResourceCreateOrUpdateAsync<Cluster>;
  @doc("Updates an existing cluster. The request body can contain one or several properties from the cluster definition.")
  update is ArmResourcePatchAsync<Cluster, ClusterProperties>;
  @doc("Deletes a cluster together with servers in it.")
  delete is ArmResourceDeleteAsync<Cluster>;
  @doc("Lists all clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;
  @doc("Lists all clusters in a subscription.")
  list is ArmListBySubscription<Cluster>;
  @doc("Restarts all nodes in the cluster.")
  restart is ArmResourceActionNoResponseContentAsync<Cluster, void>;
  @doc("Starts stopped compute on all cluster nodes.")
  start is ArmResourceActionAsync<Cluster, void, void>;
  @doc("Stops compute on all cluster nodes.")
  stop is ArmResourceActionAsync<Cluster, void, void>;
  @doc("Promotes read replica cluster to an independent read-write cluster.")
  promoteReadReplica is ArmResourceActionNoResponseContentAsync<Cluster, void>;
}
