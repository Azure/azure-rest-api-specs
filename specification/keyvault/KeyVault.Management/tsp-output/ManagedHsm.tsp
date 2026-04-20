import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * Resource information with extended details.
 */
model ManagedHsm is TrackedResource<ManagedHsmProperties> {
  /**
   * The name of the managed HSM Pool.
   */
  @path
  @key("name")
  @segment("managedHSMs")
  name: string;
}

@armResourceOperations
interface ManagedHsms {
  /**
   * Gets the specified managed HSM Pool.
   */
  get is ArmResourceRead<ManagedHsm>;

  /**
   * Create or update a managed HSM Pool in the specified subscription.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedHsm>;

  /**
   * Update a managed HSM Pool in the specified subscription.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<ManagedHsm, ManagedHsm>;

  /**
   * Deletes the specified managed HSM Pool.
   */
  delete is ArmResourceDeleteAsync<ManagedHsm>;

  /**
   * The List operation gets information about the managed HSM Pools associated with the subscription and within the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedHsms_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ManagedHsm,
    {
      ...BaseParameters<ManagedHsm>;

      /**
       * Maximum number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * The List operation gets information about the managed HSM Pools associated with the subscription.
   */
  listBySubscription is ArmListBySubscription<ManagedHsm>;

  /**
   * Gets the private link resources supported for the managed hsm pool.
   */
  // FIXME: MHSMPrivateLinkResources_ListByMHSMResource could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MHSMPrivateLinkResources_ListByMHSMResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/managedHSMs/{name}/privateLinkResources")
  @get
  listByMHSMResource is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group that contains the managed HSM pool.
       */
      @path
      resourceGroupName: string;

      /**
       * Name of the managed HSM Pool
       */
      @path
      name: string;
    },
    MhsmPrivateLinkResourceListResult
  >;

  /**
   * The List operation gets information about the regions associated with the managed HSM Pool.
   */
  // FIXME: MHSMRegions_ListByResource could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MHSMRegions_ListByResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/managedHSMs/{name}/regions")
  @get
  listByResource is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group that contains the managed HSM pool.
       */
      @path
      resourceGroupName: string;

      /**
       * Name of the managed HSM Pool
       */
      @path
      name: string;
    },
    MhsmRegionsListResult
  >;
}

@@projectedName(ManagedHsms.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedHsms.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedHsms.createOrUpdate::parameters.resource,
  "Parameters to create or update the managed HSM Pool"
);
@@projectedName(ManagedHsms.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ManagedHsms.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedHsms.update::parameters.properties,
  "Parameters to patch the managed HSM Pool"
);
