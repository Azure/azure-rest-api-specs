import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.DBforMySQL;
/**
 * A server's Reader Endpoint.
 */
@parentResource(Server)
@added(Versions.v2025_12_01_preview)
model ReaderEndpoint
  is Azure.ResourceManager.ProxyResource<ReaderEndpointProperties> {
  ...ResourceNameParameter<
    Resource = ReaderEndpoint,
    KeyName = "readerEndpointName",
    SegmentName = "readerEndpoint",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*"
  >;
}

@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface ReaderEndpoints {
  /**
   * Get a server's Reader Endpoint
   */
  get is ArmResourceRead<ReaderEndpoint>;

  /**
   * Creates a server's Reader Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  updatePut is ArmResourceCreateOrReplaceAsync<
    ReaderEndpoint,
    Response = ArmResourceUpdatedResponse<ReaderEndpoint> | ArmResourceCreatedResponse<ReaderEndpoint> | ArmAcceptedLroResponse
  >;

  /**
   * Delete Reader Endpoint for a given server with specified reader endpoint name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ReaderEndpoint,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of server's Reader Endpoints.
   */
  list is ArmResourceListByParent<
    ReaderEndpoint,
    Response = ArmResponse<ReaderEndpointList>
  >;
}

@@doc(ReaderEndpoint.name, "The name of the Reader Endpoint.");
@@doc(ReaderEndpoint.properties, "Resource properties.");
@@doc(ReaderEndpoints.updatePut::parameters.resource,
  "The server's Reader Endpoint body to update."
);
