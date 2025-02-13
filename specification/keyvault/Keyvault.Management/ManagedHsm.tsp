import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * Resource information with extended details.
 */
model ManagedHsm
  is Azure.ResourceManager.TrackedResource<ManagedHsmProperties> {
  ...ResourceNameParameter<
    Resource = ManagedHsm,
    KeyName = "name",
    SegmentName = "managedHSMs",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedHsm,
    Response = ArmResourceUpdatedResponse<ManagedHsm> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ManagedHsm;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a managed HSM Pool in the specified subscription.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<ManagedHsm, PatchModel = ManagedHsm>;

  /**
   * Deletes the specified managed HSM Pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedHsm,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * The List operation gets information about the managed HSM Pools associated with the subscription and within the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ManagedHsm,
    Parameters = {
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
  listBySubscription is ArmListBySubscription<
    ManagedHsm,
    Parameters = {
      /**
       * Maximum number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets the private link resources supported for the managed hsm pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("MHSMPrivateLinkResources_ListByMHSMResource")
  listByMHSMResource is ArmResourceActionSync<
    ManagedHsm,
    void,
    ArmResponse<MhsmPrivateLinkResourceListResult>
  >;

  /**
   * The List operation gets information about the regions associated with the managed HSM Pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("regions")
  @operationId("MHSMRegions_ListByResource")
  listByResource is ArmResourceActionSync<
    ManagedHsm,
    void,
    ArmResponse<MhsmRegionsListResult>
  >;
}

@@doc(ManagedHsm.name, "The name of the managed HSM Pool.");
@@doc(ManagedHsm.properties, "Properties of the managed HSM");
@@doc(ManagedHsms.createOrUpdate::parameters.resource,
  "Parameters to create or update the managed HSM Pool"
);
@@doc(ManagedHsms.update::parameters.properties,
  "Parameters to patch the managed HSM Pool"
);
