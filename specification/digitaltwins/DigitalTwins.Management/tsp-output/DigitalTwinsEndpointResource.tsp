import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
/**
 * DigitalTwinsInstance endpoint resource.
 */
@parentResource(DigitalTwinsDescription)
model DigitalTwinsEndpointResource
  is ProxyResource<DigitalTwinsEndpointResourceProperties> {
  /**
   * Name of Endpoint Resource.
   */
  @maxLength(49)
  @minLength(2)
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  @path
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
interface DigitalTwinsEndpointResources {
  /**
   * Get DigitalTwinsInstances Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwinsEndpoint_Get")
  get is ArmResourceRead<DigitalTwinsEndpointResource>;

  /**
   * Create or update DigitalTwinsInstance endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwinsEndpoint_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DigitalTwinsEndpointResource>;

  /**
   * Delete a DigitalTwinsInstance endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwinsEndpoint_Delete")
  delete is ArmResourceDeleteAsync<DigitalTwinsEndpointResource>;

  /**
   * Get DigitalTwinsInstance Endpoints.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwinsEndpoint_List")
  list is ArmResourceListByParent<DigitalTwinsEndpointResource>;
}

@@projectedName(DigitalTwinsEndpointResources.createOrUpdate::parameters.resource,
  "json",
  "endpointDescription"
);
@@extension(DigitalTwinsEndpointResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "endpointDescription"
);
@@doc(DigitalTwinsEndpointResources.createOrUpdate::parameters.resource,
  "The DigitalTwinsInstance endpoint metadata and security metadata."
);
