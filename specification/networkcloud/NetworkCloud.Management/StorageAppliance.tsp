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

  /**
   * Resource ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;
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
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    }
  >;

  /**
   * Update properties of the provided storage appliance, or update tags associated with the storage appliance Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    StorageAppliance,
    PatchModel = StorageAppliancePatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<StorageAppliance> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = StorageAppliance> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: StorageAppliance;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided storage appliance. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageAppliance,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of storage appliances in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    StorageAppliance,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<StorageApplianceList>
  >;

  /**
   * Get a list of storage appliances in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    StorageAppliance,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<StorageApplianceList>
  >;

  /**
   * Disable remote vendor management of the provided storage appliance.
   */
  disableRemoteVendorManagement is ArmResourceActionAsync<
    StorageAppliance,
    void,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Enable remote vendor management of the provided storage appliance.
   */
  enableRemoteVendorManagement is ArmResourceActionAsync<
    StorageAppliance,
    StorageApplianceEnableRemoteVendorManagementParameters,
    ArmResponse<OperationStatusResult>,
    OptionalRequestBody = true
  >;

  /**
   * Run one or more read-only commands on the provided storage appliance.
   */
  runReadCommands is ArmResourceActionAsync<
    StorageAppliance,
    StorageApplianceRunReadCommandsParameters,
    ArmResponse<OperationStatusResult>
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
