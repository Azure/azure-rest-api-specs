import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RedisEnterprise;
@doc("Describes the RedisEnterprise cluster")
model RedisEnterpriseCluster is TrackedResource<ClusterProperties> {
  @doc("The name of the RedisEnterprise cluster.")
  @path
  @key("clusterName")
  @segment("redisEnterprise")
  name: string;

  @doc("The Availability Zones where this cluster will be deployed.")
  zones?: string[];

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface RedisEnterpriseClusters {
  @doc("Gets information about a RedisEnterprise cluster")
  get is ArmResourceRead<RedisEnterpriseCluster>;
  @doc("Creates or updates an existing (overwrite/recreate, with potential downtime) cache cluster")
  create is ArmResourceCreateOrUpdateAsync<RedisEnterpriseCluster>;
  @doc("Updates an existing RedisEnterprise cluster")
  update is ArmResourcePatchAsync<RedisEnterpriseCluster, ClusterProperties>;
  @doc("Deletes a RedisEnterprise cache cluster.")
  delete is ArmResourceDeleteAsync<RedisEnterpriseCluster>;
  @doc("Lists all RedisEnterprise clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<RedisEnterpriseCluster>;
  @doc("Gets all RedisEnterprise clusters in the specified subscription.")
  list is ArmListBySubscription<RedisEnterpriseCluster>;
  @doc("Gets the private link resources that need to be created for a RedisEnterprise cluster.")
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
