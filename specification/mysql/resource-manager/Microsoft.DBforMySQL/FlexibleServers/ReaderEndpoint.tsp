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
    SegmentName = "readerEndpoints",
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
   * Creates or updates a server's Reader Endpoint.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ReaderEndpoint,
    Response = ArmResourceUpdatedResponse<ReaderEndpoint> | ArmResourceCreatedResponse<ReaderEndpoint>
  >;

  /**
   * Delete Reader Endpoint for a given server with specified reader endpoint name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ReaderEndpoint,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of server's Reader Endpoints.
   */
  list is ArmResourceListByParent<ReaderEndpoint>;
}

@@doc(ReaderEndpoint.name, "The name of the Reader Endpoint.");
@@doc(ReaderEndpoint.properties, "Resource properties.");
@@doc(ReaderEndpoints.createOrUpdate::parameters.resource,
  "The server's Reader Endpoint body to create or update."
);
