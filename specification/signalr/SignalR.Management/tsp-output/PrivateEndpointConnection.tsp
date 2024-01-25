import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * A private endpoint connection to an azure resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SignalRResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  PrivateEndpointConnectionProperties
)
model PrivateEndpointConnection extends ProxyResourceBase {
  /**
   * The name of the private endpoint connection
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;

  /**
   * Private endpoint connection properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointConnectionProperties;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get the specified private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRPrivateEndpointConnections_Get")
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the state of specified private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRPrivateEndpointConnections_Update")
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  /**
   * Delete the specified private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRPrivateEndpointConnections_Delete")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  /**
   * List private endpoint connections
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRPrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.update::parameters.resource,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.update::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The resource of private endpoint and its properties"
);
