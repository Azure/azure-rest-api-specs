import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
/**
 * DigitalTwinsInstance endpoint resource.
 */
@parentResource(DigitalTwinsDescription)
model DigitalTwinsEndpointResource
  is Azure.ResourceManager.ProxyResource<
    DigitalTwinsEndpointResourceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = DigitalTwinsEndpointResource,
    KeyName = "endpointName",
    SegmentName = "endpoints",
    NamePattern = "^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface DigitalTwinsEndpointResources {
  /**
   * Get DigitalTwinsInstances Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DigitalTwinsEndpoint_Get")
  get is ArmResourceRead<DigitalTwinsEndpointResource>;

  /**
   * Create or update DigitalTwinsInstance endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DigitalTwinsEndpoint_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DigitalTwinsEndpointResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a DigitalTwinsInstance endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("DigitalTwinsEndpoint_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DigitalTwinsEndpointResource,
    Response = ArmResponse<DigitalTwinsEndpointResource> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: DigitalTwinsEndpointResource;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Get DigitalTwinsInstance Endpoints.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DigitalTwinsEndpoint_List")
  list is ArmResourceListByParent<DigitalTwinsEndpointResource>;
}

@@maxLength(DigitalTwinsEndpointResource.name, 49);
@@minLength(DigitalTwinsEndpointResource.name, 2);
@@doc(DigitalTwinsEndpointResource.name, "Name of Endpoint Resource.");
@@doc(DigitalTwinsEndpointResource.properties,
  "DigitalTwinsInstance endpoint resource properties."
);
@@doc(DigitalTwinsEndpointResources.createOrUpdate::parameters.resource,
  "The DigitalTwinsInstance endpoint metadata and security metadata."
);
