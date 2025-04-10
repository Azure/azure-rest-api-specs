import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Eureka server resource
 */
@singleton("default")
@parentResource(ServiceResource)
model EurekaServerResource
  is Azure.ResourceManager.ProxyResource<EurekaServerProperties> {
  ...ResourceNameParameter<
    Resource = EurekaServerResource,
    KeyName = "eurekaServer",
    SegmentName = "eurekaServers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface EurekaServerResources {
  /**
   * Get the eureka server settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EurekaServers_Get")
  get is ArmResourceRead<EurekaServerResource>;

  /**
   * Update the eureka server settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EurekaServers_UpdatePut")
  updatePut is ArmResourceCreateOrReplaceAsync<EurekaServerResource>;

  /**
   * Update the eureka server settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("EurekaServers_UpdatePatch")
  updatePatch is ArmCustomPatchAsync<
    EurekaServerResource,
    PatchModel = EurekaServerResource,
    Response = ArmResponse<EurekaServerResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: EurekaServerResource;
    })
  >;

  /**
   * List the eureka server settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EurekaServers_List")
  list is ArmResourceListByParent<
    EurekaServerResource,
    Response = ArmResponse<EurekaServerResourceCollection>
  >;
}

@@doc(EurekaServerResource.name, "");
@@doc(EurekaServerResource.properties,
  "Properties of the eureka server resource"
);
@@doc(EurekaServerResources.updatePut::parameters.resource,
  "Parameters for the update operation"
);
@@doc(EurekaServerResources.updatePatch::parameters.properties,
  "Parameters for the update operation"
);
