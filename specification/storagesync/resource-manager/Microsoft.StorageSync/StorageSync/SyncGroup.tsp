import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Sync Group object.
 */
@parentResource(StorageSyncService)
model SyncGroup is Azure.ResourceManager.ProxyResource<SyncGroupProperties> {
  ...ResourceNameParameter<
    Resource = SyncGroup,
    KeyName = "syncGroupName",
    SegmentName = "syncGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SyncGroups {
  /**
   * Get a given SyncGroup.
   */
  get is ArmResourceRead<
    SyncGroup,
    Response = SyncGroup & {
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
   * Create a new SyncGroup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  create is Legacy.CreateOrReplaceAsync<
    SyncGroup,
    SyncGroupCreateParameters,
    Response = ArmResourceUpdatedResponse<SyncGroup> & {
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
   * Delete a given SyncGroup.
   */
  delete is ArmResourceDeleteSync<
    SyncGroup,
    Response = (ArmDeletedResponse & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("Request id")
      requestId?: string;
    }) | NoContentResponse,
    Error = StorageSyncError
  >;

  /**
   * Get a SyncGroup List.
   */
  listByStorageSyncService is ArmResourceListByParent<
    SyncGroup,
    Response = ArmResponse<SyncGroupArray> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;
}

@@doc(SyncGroup.name, "Name of Sync Group resource.");
@@doc(SyncGroup.properties, "SyncGroup properties.");
@@doc(SyncGroups.create::parameters.resource, "Sync Group Body");
