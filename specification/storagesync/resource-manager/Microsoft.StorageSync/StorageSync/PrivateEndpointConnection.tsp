import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager.Legacy;

namespace Microsoft.StorageSync;
/**
 * The private endpoint connection resource.
 */
@parentResource(StorageSyncService)
model PrivateEndpointConnection is PrivateEndpointConnectionResource;

alias PrivateEndpointOperations = Azure.ResourceManager.PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the storage sync service.
   */
  get is PrivateEndpointOperations.Read<
    StorageSyncService,
    Error = StorageSyncError
  >;

  /**
   * Update the state of specified private endpoint connection associated with the storage sync service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("location")
  create is PrivateEndpointOperations.CreateOrUpdateAsync<
    StorageSyncService,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnection> &
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
   * Deletes the specified private endpoint connection associated with the storage sync service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("location")
  delete is PrivateEndpointOperations.DeleteAsync<
    StorageSyncService,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
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
   * Get a PrivateEndpointConnection List.
   */
  @list
  listByStorageSyncService is Azure.ResourceManager.Legacy.PrivateEndpoints.ListSinglePageByParent<
    StorageSyncService,
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionListResult> & {
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

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection properties."
);
