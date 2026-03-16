import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Storage Sync Service object.
 */
model StorageSyncService
  is Azure.ResourceManager.TrackedResource<StorageSyncServiceProperties> {
  ...ResourceNameParameter<
    Resource = StorageSyncService,
    KeyName = "storageSyncServiceName",
    SegmentName = "storageSyncServices",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface StorageSyncServices {
  /**
   * Get a given StorageSyncService.
   */
  get is ArmResourceRead<
    StorageSyncService,
    Response = ArmResponse<StorageSyncService> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;

  /**
   * Create a new StorageSyncService.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @Azure.Core.useFinalStateVia("location")
  create is Legacy.CreateOrReplaceAsync<
    StorageSyncService,
    StorageSyncServiceCreateParameters,
    Response = ArmResourceUpdatedResponse<StorageSyncService> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = StorageSyncService> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("Request id")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Patch a given StorageSyncService.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("location")
  update is Legacy.CustomPatchSync<
    StorageSyncService,
    PatchModel = StorageSyncServiceUpdateParameters,
    Response = (ArmResourceUpdatedResponse<StorageSyncService> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = StorageSyncService> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("Request id")
      requestId?: string;
    }),
    Error = StorageSyncError,
    OptionalRequestBody = true
  >;

  /**
   * Delete a given StorageSyncService.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("location")
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageSyncService,
    Response = (ArmDeletedResponse & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("Request id")
      requestId?: string;
    }) | ArmDeletedNoContentResponse,
    Error = StorageSyncError
  >;

  /**
   * Get a StorageSyncService list by Resource group name.
   */
  listByResourceGroup is ArmResourceListByParent<
    StorageSyncService,
    Response = ArmResponse<StorageSyncServiceArray> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;

  /**
   * Get a StorageSyncService list by subscription.
   */
  listBySubscription is ArmListBySubscription<
    StorageSyncService,
    Response = StorageSyncServiceArray & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;

  /**
   * Gets the private link resources that need to be created for a storage sync service.
   */
  #suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("privateLinkResources")
  listByStorageSyncService is ArmResourceActionSync<
    StorageSyncService,
    void,
    ArmResponse<Azure.ResourceManager.CommonTypes.PrivateLinkResourceListResultV5>,
    Error = StorageSyncError
  >;
}

@@doc(StorageSyncService.name, "Name of Storage Sync Service resource.");
@@doc(StorageSyncService.properties, "Storage Sync Service properties.");
@@doc(StorageSyncServices.create::parameters.resource,
  "Storage Sync Service resource name."
);
@@doc(StorageSyncServices.update::parameters.properties,
  "Storage Sync Service resource."
);
