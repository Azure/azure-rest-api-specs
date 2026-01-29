import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.KeyVault;

/**
 * Resource information with extended details.
 */
model ManagedHsm is Azure.ResourceManager.ProxyResource<ManagedHsmProperties> {
  ...ResourceNameParameter<
    Resource = ManagedHsm,
    KeyName = "name",
    SegmentName = "managedHSMs",
    NamePattern = ""
  >;

  /**
   * SKU details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ManagedHsmSku;

  /**
   * Managed service identity
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: CommonTypes.ManagedServiceIdentity;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: azureLocation;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface ManagedHsms {
  /**
   * Gets the specified managed HSM Pool.
   */
  get is ArmResourceRead<
    ManagedHsm,
    Response = ArmResponse<ManagedHsm> | ArmNoContentResponse,
    Error = ManagedHsmError
  >;

  /**
   * Create or update a managed HSM Pool in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedHsm,
    Response = ArmResourceUpdatedResponse<ManagedHsm> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedHsm> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: ManagedHsm;
    }),
    Error = ManagedHsmError
  >;

  /**
   * Update a managed HSM Pool in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ManagedHsm,
    PatchModel = ManagedHsm,
    Response = ArmResponse<ManagedHsm> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedHsm> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: ManagedHsm;
    }),
    Error = ManagedHsmError
  >;

  /**
   * Deletes the specified managed HSM Pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedHsm,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ManagedHsmError
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
    },
    Error = ManagedHsmError
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
    },
    Error = ManagedHsmError
  >;

  /**
   * Gets the private link resources supported for the managed hsm pool.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("privateLinkResources")
  listByMHSMResource is ArmResourceActionSync<
    ManagedHsm,
    void,
    ArmResponse<MhsmPrivateLinkResourceListResult>,
    Error = CloudError
  >;

  /**
   * The List operation gets information about the regions associated with the managed HSM Pool.
   */
  @get
  @action("regions")
  @list
  listByResource is ArmResourceActionSync<
    ManagedHsm,
    void,
    ArmResponse<MhsmRegionsListResult>,
    Error = ManagedHsmError
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
