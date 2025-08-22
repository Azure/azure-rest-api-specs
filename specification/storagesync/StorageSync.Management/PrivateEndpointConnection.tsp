import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
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
  create is PrivateEndpointOperations.CreateOrUpdateAsync<
    StorageSyncService,
    Response = ArmResourceUpdatedResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnection> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("Request id")
      requestId?: string;
    }),
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = StorageSyncError
  >;

  /**
   * Deletes the specified private endpoint connection associated with the storage sync service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is PrivateEndpointOperations.DeleteAsync<
    StorageSyncService,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
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
  #suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
