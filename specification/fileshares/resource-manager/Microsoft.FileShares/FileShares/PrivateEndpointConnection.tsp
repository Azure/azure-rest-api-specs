import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./fileshares.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager.Legacy;
using TypeSpec.Versioning;

namespace Microsoft.FileShares;

/**
 * The private endpoint connection resource.
 */
@parentResource(FileShare)
model PrivateEndpointConnection is PrivateEndpointConnectionResource;

alias PrivateEndpointOperations = Azure.ResourceManager.PrivateEndpoints<PrivateEndpointConnection>;

@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the file share.
   */
  get is PrivateEndpointOperations.Read<FileShare>;

  /**
   * Update the state of specified private endpoint connection associated with the file share.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("location")
  create is PrivateEndpointOperations.CreateOrUpdateAsync<
    FileShare,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes the specified private endpoint connection associated with the file share.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("location")
  delete is PrivateEndpointOperations.DeleteAsync<
    FileShare,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a PrivateEndpointConnection List.
   */
  @list
  listByFileShare is Azure.ResourceManager.Legacy.PrivateEndpoints.ListSinglePageByParent<
    FileShare,
    PrivateEndpointConnection
  >;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection properties."
);
