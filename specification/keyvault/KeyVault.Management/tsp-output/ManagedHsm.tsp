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
  get (
    ...ResourceInstanceParameters<ManagedHsm>
  ): ArmNoContentResponse<"Request successful. Resource does not exist."> //204 response
  | ArmResponse<ManagedHsm>
  | ErrorResponse;//is ArmResourceRead<ManagedHsm>;

  /**
   * Create or update a managed HSM Pool in the specified subscription.
   */
  @autoRoute
  @doc("Create or update a managed HSM Pool in the specified subscription.")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @armResourceCreateOrUpdate(ManagedHsm)
  @put
  createOrUpdate (
    ...ResourceInstanceParameters<ManagedHsm,BaseParameters<ManagedHsm>>,
    @doc("Resource create parameters.")
    @body
    resource: ManagedHsm
  ): ArmResponse<ManagedHsm>
  | ArmAcceptedResponse  //202 response
  | ErrorResponse;

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
  @segment("managedHSMs")
  listByResourceGroup (
    ...ResourceParentParameters<ManagedHsm, BaseParameters<ManagedHsm>>,
      /**
       * Maximum number of results to return.
       */    
    @query("$top")
    $top?: int32;
  ): TResourceListResult<ManagedHsm>
  | ErrorResponse;

  /**
   * The List operation gets information about the managed HSM Pools associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedHsms_ListBySubscription")
  @segment("managedHSMs")
  listBySubscription (
    ...ResourceParentParameters<ManagedHsm, SubscriptionBaseParameters>;
      /**
       * Maximum number of results to return.
       */    
    @query("$top")
    $top?: int32;
  ): TResourceListResult<ManagedHsm>
  | ErrorResponse;

}

@armResourceOperations
interface MHSMPrivateLinkResources {
    /**
   * Gets the private link resources supported for the managed hsm pool.
   */
  // FIXME: MHSMPrivateLinkResources_ListByMHSMResource could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MHSMPrivateLinkResources_ListByMHSMResource")
  @segment("privateLinkResources")
  @get
  listByMHSMResource(
    ...ResourceInstanceParameters<ManagedHsm,BaseParameters<ManagedHsm>> 
  ) : ArmResponse<MhsmPrivateLinkResourceListResult> | ErrorResponse;
}

@armResourceOperations
interface MHSMListRegions {
    /**
   * The List operation gets information about the regions associated with the managed HSM Pool.
   */
  // FIXME: MHSMRegions_ListByResource could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MHSMRegions_ListByResource")
  @segment("regions")
  @get
  listByResource(
    ...ResourceInstanceParameters<ManagedHsm,BaseParameters<ManagedHsm>>
  ) : ArmResponse<MhsmRegionsListResult> | ErrorResponse;
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
