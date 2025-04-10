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
 * Config Server resource
 */
@singleton("default")
@parentResource(ServiceResource)
model ConfigServerResource
  is Azure.ResourceManager.ProxyResource<ConfigServerProperties> {
  ...ResourceNameParameter<
    Resource = ConfigServerResource,
    KeyName = "configServer",
    SegmentName = "configServers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ConfigServerResources {
  /**
   * Get the config server and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigServers_Get")
  get is ArmResourceRead<ConfigServerResource>;

  /**
   * Update the config server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("ConfigServers_UpdatePut")
  updatePut is ArmResourceCreateOrReplaceAsync<
    ConfigServerResource,
    Response = ArmResourceUpdatedResponse<ConfigServerResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ConfigServerResource;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update the config server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("ConfigServers_UpdatePatch")
  updatePatch is ArmCustomPatchAsync<
    ConfigServerResource,
    PatchModel = ConfigServerResource,
    Response = ArmResponse<ConfigServerResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ConfigServerResource;
    })
  >;

  /**
   * Disable the default Config Server, only available in Enterprise Plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigServers_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ConfigServerResource>;

  /**
   * Handles requests to list all config server resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigServers_List")
  list is ArmResourceListByParent<
    ConfigServerResource,
    Response = ArmResponse<ConfigServerResourceCollection>
  >;
}

@@doc(ConfigServerResource.name, "");
@@doc(ConfigServerResource.properties,
  "Properties of the Config Server resource"
);
@@doc(ConfigServerResources.updatePut::parameters.resource,
  "Parameters for the update operation"
);
@@doc(ConfigServerResources.updatePatch::parameters.properties,
  "Parameters for the update operation"
);
