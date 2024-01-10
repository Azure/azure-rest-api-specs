import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.KeyVault;
@doc("Resource information with extended details.")
model ManagedHsm is TrackedResource<ManagedHsmProperties> {
  @doc("The name of the managed HSM Pool.")
  @key("name")
  @segment("managedHSMs")
  name: string;
}

@armResourceOperations
interface ManagedHsms {
  @doc("Gets the specified managed HSM Pool.")
  get is ArmResourceRead<ManagedHsm>;

  @doc("Create or update a managed HSM Pool in the specified subscription.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedHsm>;

  @doc("Update a managed HSM Pool in the specified subscription.")
  update is ArmCustomPatchAsync<ManagedHsm, ManagedHsm>;

  @doc("Deletes the specified managed HSM Pool.")
  delete is ArmResourceDeleteAsync<ManagedHsm>;

  @doc("The List operation gets information about the managed HSM Pools associated with the subscription and within the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    ManagedHsm,
    {
      ...BaseParameters<ManagedHsm>;

      @doc("Maximum number of results to return.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("The List operation gets information about the managed HSM Pools associated with the subscription.")
  listBySubscription is ArmListBySubscription<ManagedHsm>;
}

@armResourceOperations
@projectedName("client", "MHSMPrivateLinkResources")
interface ManagedHsms_MHSMPrivateLinkResources {
  @doc("Gets the private link resources supported for the managed hsm pool.")
  // FIXME: MHSMPrivateLinkResources_ListByMHSMResource could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/managedHSMs/{name}/privateLinkResources")
  @get
  ListByMHSMResource is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group that contains the managed HSM pool.")
      @path
      resourceGroupName: string;

      @doc("Name of the managed HSM Pool")
      @path
      name: string;
    },
    MhsmPrivateLinkResourceListResult
  >;
}

@armResourceOperations
@projectedName("client", "MHSMRegions")
interface ManagedHsms_MHSMRegions {
  @doc("The List operation gets information about the regions associated with the managed HSM Pool.")
  // FIXME: MHSMRegions_ListByResource could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/managedHSMs/{name}/regions")
  @get
  ListByResource is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group that contains the managed HSM pool.")
      @path
      resourceGroupName: string;

      @doc("Name of the managed HSM Pool")
      @path
      name: string;
    },
    MhsmRegionsListResult
  >;
}
