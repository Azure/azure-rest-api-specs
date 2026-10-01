import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Properties of the PrivateEndpointConnection.
 */
@parentResource(EHNamespace)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is an existing envelope property from the original OpenAPI specification and cannot be changed without breaking compatibility."
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a description for the specified Private Endpoint Connection name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "OpenAPI decorator is required to preserve the original API behavior defined in the OpenAPI specification."
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  get is ArmResourceRead<PrivateEndpointConnection, Error = ErrorResponse>;

  /**
   * Creates or updates PrivateEndpointConnections of service namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The response body is required to match the original OpenAPI specification behavior."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "OpenAPI decorator is required to preserve the original API behavior defined in the OpenAPI specification."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing PUT operation response codes match the original OpenAPI specification. Changing would be a breaking change for existing clients."
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing long-running operation does not use the standard location header pattern as defined in the original OpenAPI specification."
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639408.aspx")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Response =
      | ArmResourceUpdatedResponse<PrivateEndpointConnection>
      | ArmResourceCreatedSyncResponse<PrivateEndpointConnection>
      | (AcceptedResponse & {
          @bodyRoot
          _: PrivateEndpointConnection;
        }),
    Error = ErrorResponse
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing long-running operation does not use the standard location header pattern as defined in the original OpenAPI specification."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing DELETE operation response codes match the original OpenAPI specification. Changing would be a breaking change for existing clients."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "OpenAPI decorator is required to preserve the original API behavior defined in the OpenAPI specification."
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639389.aspx")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Gets the available PrivateEndpointConnections within a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "OpenAPI decorator is required to preserve the original API behavior defined in the OpenAPI specification."
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639412.aspx")
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Error = ErrorResponse
  >;
}

@@doc(PrivateEndpointConnection.name, "The PrivateEndpointConnection name");
@@doc(
  PrivateEndpointConnection.properties,
  "Properties of the PrivateEndpointConnection."
);
@@doc(
  PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to update Status of PrivateEndPoint Connection to namespace resource."
);
