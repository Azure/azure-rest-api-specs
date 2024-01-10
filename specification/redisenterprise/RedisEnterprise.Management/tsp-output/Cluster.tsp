import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Cache;
@doc("Describes the RedisEnterprise cluster")
model Cluster is TrackedResource<ClusterProperties> {
  @doc("The name of the RedisEnterprise cluster.")
  @key("clusterName")
  @segment("redisEnterprise")
  name: string;

  @doc("The Availability Zones where this cluster will be deployed.")
  zones?: string[];

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
@projectedName("client", "RedisEnterprise")
interface Clusters_RedisEnterprise {
  @doc("Gets information about a RedisEnterprise cluster")
  get is ArmResourceRead<Cluster>;

  @doc("Creates or updates an existing (overwrite/recreate, with potential downtime) cache cluster")
  create is ArmResourceCreateOrUpdateAsync<Cluster>;

  @doc("Updates an existing RedisEnterprise cluster")
  update is ArmCustomPatchAsync<Cluster, ClusterUpdate>;

  @doc("Deletes a RedisEnterprise cache cluster.")
  delete is ArmResourceDeleteAsync<Cluster>;

  @doc("Lists all RedisEnterprise clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  @doc("Gets all RedisEnterprise clusters in the specified subscription.")
  list is ArmListBySubscription<Cluster>;
}

@armResourceOperations
@projectedName("client", "PrivateLinkResources")
interface Clusters_PrivateLinkResources {
  @doc("Gets the private link resources that need to be created for a RedisEnterprise cluster.")
  // FIXME: PrivateLinkResources_ListByCluster could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/privateLinkResources")
  @get
  ListByCluster is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}
