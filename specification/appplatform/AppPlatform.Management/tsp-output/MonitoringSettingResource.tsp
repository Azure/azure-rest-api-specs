import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Monitoring Setting resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(ServiceResource)
@Azure.ResourceManager.Private.armResourceInternal(MonitoringSettingProperties)
@includeInapplicableMetadataInPayload(false)
model MonitoringSettingResource extends ProxyResource {
  @key("monitoringSetting")
  @segment("monitoringSettings")
  name: string;

  /**
   * Properties of the Monitoring Setting resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: MonitoringSettingProperties;
}

@armResourceOperations
interface MonitoringSettingResources {
  /**
   * Get the Monitoring Setting and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MonitoringSettings_Get")
  get is ArmResourceRead<MonitoringSettingResource>;

  /**
   * Update the Monitoring Setting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MonitoringSettings_UpdatePut")
  updatePut is ArmResourceCreateOrReplaceAsync<MonitoringSettingResource>;

  /**
   * Update the Monitoring Setting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("MonitoringSettings_UpdatePatch")
  updatePatch is ArmCustomPatchAsync<
    MonitoringSettingResource,
    MonitoringSettingResource
  >;
}

@@projectedName(MonitoringSettingResources.updatePut::parameters.resource,
  "json",
  "monitoringSettingResource"
);
@@extension(MonitoringSettingResources.updatePut::parameters.resource,
  "x-ms-client-name",
  "monitoringSettingResource"
);
@@doc(MonitoringSettingResources.updatePut::parameters.resource,
  "Parameters for the update operation"
);
@@projectedName(MonitoringSettingResources.updatePatch::parameters.properties,
  "json",
  "monitoringSettingResource"
);
@@extension(MonitoringSettingResources.updatePatch::parameters.properties,
  "x-ms-client-name",
  "monitoringSettingResource"
);
@@doc(MonitoringSettingResources.updatePatch::parameters.properties,
  "Parameters for the update operation"
);
