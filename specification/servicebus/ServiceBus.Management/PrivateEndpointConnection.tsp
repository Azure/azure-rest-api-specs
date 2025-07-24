import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Properties of the PrivateEndpointConnection.
 */
@parentResource(SBNamespace)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a description for the specified Private Endpoint Connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Creates or updates PrivateEndpointConnections of service namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639408.aspx")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection> | ArmResourceCreatedSyncResponse<PrivateEndpointConnection> | (AcceptedResponse & {
      @bodyRoot
      _: PrivateEndpointConnection;
    })
  >;

  /**
   * Deletes an existing Private Endpoint Connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639389.aspx")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the available PrivateEndpointConnections within a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639412.aspx")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.name, "The PrivateEndpointConnection name");
@@doc(PrivateEndpointConnection.properties,
  "Properties of the PrivateEndpointConnection."
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to update Status of PrivateEndPoint Connection to namespace resource."
);
