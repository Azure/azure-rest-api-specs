import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The metric setting details for the role
 */
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model MonitoringMetricConfiguration
  is Azure.ResourceManager.ProxyResource<
    MonitoringMetricConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = MonitoringMetricConfiguration,
    KeyName = "monitoringConfig",
    SegmentName = "monitoringConfig",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MonitoringMetricConfigurations {
  /**
   * Gets a  metric configuration of a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MonitoringConfig_Get")
  get is ArmResourceRead<MonitoringMetricConfiguration>;

  /**
   * Creates a new metric configuration or updates an existing one for a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("MonitoringConfig_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MonitoringMetricConfiguration,
    Response = ArmResourceUpdatedResponse<MonitoringMetricConfiguration> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = MonitoringMetricConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * deletes a new metric configuration for a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("MonitoringConfig_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    MonitoringMetricConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists metric configurations in a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MonitoringConfig_List")
  list is ArmResourceListByParent<
    MonitoringMetricConfiguration,
    Response = ArmResponse<MonitoringMetricConfigurationList>
  >;
}

@@doc(MonitoringMetricConfiguration.name, "");
@@doc(MonitoringMetricConfiguration.properties,
  "The metric setting properties."
);
@@doc(MonitoringMetricConfigurations.createOrUpdate::parameters.resource,
  "The metric configuration."
);
