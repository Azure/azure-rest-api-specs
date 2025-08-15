import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * StorageAppliance represents on-premises Network Cloud storage appliance.
 */
model StorageAppliance
  is Azure.ResourceManager.TrackedResource<StorageApplianceProperties, false> {
  ...ResourceNameParameter<
    Resource = StorageAppliance,
    KeyName = "storageApplianceName",
    SegmentName = "storageAppliances",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface StorageAppliances {
  /**
   * Get properties of the provided storage appliance.
   */
  get is ArmResourceRead<StorageAppliance>;

  /**
   * Create a new storage appliance or update the properties of the existing one.
   * All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageAppliance,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    }
  >;

  /**
   * Update properties of the provided storage appliance, or update tags associated with the storage appliance Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    StorageAppliance,
    PatchModel = StorageAppliancePatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResponse<StorageAppliance> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = StorageAppliance> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: StorageAppliance;

      /**
       * The URL to retrieve the status of the asynchronous operation.
       */
      @header("Location")
      location: string;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided storage appliance.
   * All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageAppliance,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of storage appliances in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    StorageAppliance,
    Response = ArmResponse<StorageApplianceList>
  >;

  /**
   * Get a list of storage appliances in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    StorageAppliance,
    Response = ArmResponse<StorageApplianceList>
  >;

  /**
   * Disable remote vendor management of the provided storage appliance.
   */
  disableRemoteVendorManagement is ArmResourceActionAsyncBase<
    StorageAppliance,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<StorageAppliance>
  >;

  /**
   * Enable remote vendor management of the provided storage appliance.
   */
  enableRemoteVendorManagement is ArmResourceActionAsyncBase<
    StorageAppliance,
    StorageApplianceEnableRemoteVendorManagementParameters,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<StorageAppliance>,
    OptionalRequestBody = true
  >;
}

@@doc(StorageAppliance.name, "The name of the storage appliance.");
@@encodedName(StorageAppliance.eTag, "application/json", "etag");
@@doc(StorageAppliance.properties, "The list of the resource properties.");
@@doc(StorageAppliances.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(StorageAppliances.update::parameters.properties, "The request body.");
@@doc(StorageAppliances.enableRemoteVendorManagement::parameters.body,
  "The request body."
);
