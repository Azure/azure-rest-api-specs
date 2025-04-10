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
 * Monitoring Setting resource
 */
@singleton("default")
@parentResource(ServiceResource)
model MonitoringSettingResource
  is Azure.ResourceManager.ProxyResource<MonitoringSettingProperties> {
  ...ResourceNameParameter<
    Resource = MonitoringSettingResource,
    KeyName = "monitoringSetting",
    SegmentName = "monitoringSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MonitoringSettingResources {
  /**
   * Get the Monitoring Setting and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MonitoringSettings_Get")
  get is ArmResourceRead<MonitoringSettingResource>;

  /**
   * Update the Monitoring Setting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("MonitoringSettings_UpdatePut")
  updatePut is ArmResourceCreateOrReplaceAsync<
    MonitoringSettingResource,
    Response = ArmResourceUpdatedResponse<MonitoringSettingResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: MonitoringSettingResource;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update the Monitoring Setting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("MonitoringSettings_UpdatePatch")
  updatePatch is ArmCustomPatchAsync<
    MonitoringSettingResource,
    PatchModel = MonitoringSettingResource,
    Response = ArmResponse<MonitoringSettingResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: MonitoringSettingResource;
    })
  >;
}

@@doc(MonitoringSettingResource.name, "");
@@doc(MonitoringSettingResource.properties,
  "Properties of the Monitoring Setting resource"
);
@@doc(MonitoringSettingResources.updatePut::parameters.resource,
  "Parameters for the update operation"
);
@@doc(MonitoringSettingResources.updatePatch::parameters.properties,
  "Parameters for the update operation"
);
