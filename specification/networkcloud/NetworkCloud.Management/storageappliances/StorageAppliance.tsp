import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./StorageAppliance_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the storage appliance.
 */
model StorageApplianceNameParameter
  is ResourceNameParameter<
    Resource = StorageAppliance,
    KeyName = "storageApplianceName",
    SegmentName = "storageAppliances",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * StorageAppliance represents on-premises Network Cloud storage appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model StorageAppliance
  is Azure.ResourceManager.TrackedResource<StorageApplianceProperties, false> {
  ...StorageApplianceNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface StorageAppliances {
  /**
   * Get properties of the provided storage appliance.
   */
  get is ArmResourceRead<StorageAppliance>;

  /**
   * Create a new storage appliance or update the properties of the existing one. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageAppliance,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = StorageAppliance>
  >;

  /**
   * Update properties of the provided storage appliance, or update tags associated with the storage appliance Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    StorageAppliance,
    PatchModel = StorageAppliancePatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = StorageAppliance> &
      ArmLroLocationHeader<FinalResult = StorageAppliance>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided storage appliance. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageAppliance,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of storage appliances in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    StorageAppliance,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<StorageApplianceList>
  >;

  /**
   * Get a list of storage appliances in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    StorageAppliance,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<StorageApplianceList>
  >;

  /**
   * Disable remote vendor management of the provided storage appliance.
   */
  disableRemoteVendorManagement is ActionAsync<
    StorageAppliance,
    void,
    OperationStatusResult
  >;

  /**
   * Enable remote vendor management of the provided storage appliance.
   */
  enableRemoteVendorManagement is ActionAsync<
    StorageAppliance,
    StorageApplianceEnableRemoteVendorManagementParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Run one or more read-only commands on the provided storage appliance.
   */
  runReadCommands is ActionAsync<
    StorageAppliance,
    StorageApplianceRunReadCommandsParameters,
    OperationStatusResult
  >;
}

@@doc(StorageAppliance.name, "The name of the storage appliance.");
@@doc(StorageAppliance.properties, "The list of the resource properties.");
@@doc(StorageAppliances.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(StorageAppliances.update::parameters.properties, "The request body.");
@@doc(StorageAppliances.enableRemoteVendorManagement::parameters.body,
  "The request body."
);
@@doc(StorageAppliances.runReadCommands::parameters.body, "The request body.");
