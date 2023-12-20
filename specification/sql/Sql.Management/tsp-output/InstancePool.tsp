import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An Azure SQL instance pool.")
model InstancePool is TrackedResource<InstancePoolProperties> {
  @doc("The name of the instance pool to be retrieved.")
  @path
  @key("instancePoolName")
  @segment("instancePools")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface InstancePools {
  @doc("Gets an instance pool.")
  get is ArmResourceRead<InstancePool>;
  @doc("Creates or updates an instance pool.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InstancePool>;
  @doc("Updates an instance pool.")
  update is ArmTagsPatchAsync<InstancePool>;
  @doc("Deletes an instance pool")
  delete is ArmResourceDeleteAsync<InstancePool>;
  @doc("Gets a list of instance pools in the resource group")
  listByResourceGroup is ArmResourceListByParent<InstancePool>;
  @doc("Gets a list of all instance pools in the subscription.")
  list is ArmListBySubscription<InstancePool>;
  @doc("Gets all instance pool usage metrics")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/usages")
  @get
  ListByInstancePool is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the instance pool to be retrieved.")
      @path
      instancePoolName: string;

      @doc("Optional request parameter to include managed instance usages within the instance pool.")
      @query("expandChildren")
      expandChildren?: boolean;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    UsageListResult
  >;

  @doc("Gets a list of all managed instances in an instance pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/managedInstances")
  @get
  ListByInstancePool is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The instance pool name.")
      @path
      instancePoolName: string;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ManagedInstanceListResult
  >;
}
