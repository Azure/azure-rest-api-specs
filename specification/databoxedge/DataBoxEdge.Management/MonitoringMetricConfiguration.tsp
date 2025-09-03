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
@parentResource(Role)
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
  @action("monitoringConfig/default")
  get is MonitoringMetricConfigurationsNonListOps.Read<
    MonitoringMetricConfiguration,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates a new metric configuration or updates an existing one for a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("MonitoringConfig_CreateOrUpdate")
  @action("monitoringConfig/default")
  createOrUpdate is MonitoringMetricConfigurationsNonListOps.CreateOrUpdateAsync<
    MonitoringMetricConfiguration,
    Response = ArmResourceUpdatedResponse<MonitoringMetricConfiguration> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = MonitoringMetricConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader,
    OverrideErrorType = CloudError
  >;

  /**
   * deletes a new metric configuration for a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("MonitoringConfig_Delete")
  @action("monitoringConfig/default")
  delete is MonitoringMetricConfigurationsNonListOps.DeleteWithoutOkAsync<
    MonitoringMetricConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Lists metric configurations in a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MonitoringConfig_List")
  list is MonitoringMetricConfigurationsListOps.List<
    MonitoringMetricConfiguration,
    Response = ArmResponse<MonitoringMetricConfigurationList>,
    OverrideErrorType = CloudError
  >;
}

@armResourceOperations
interface MonitoringMetricConfigurationsListOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the device.
         */
        @path
        @segment("dataBoxEdgeDevices")
        deviceName: string,

        /**
         * The name of the role.
         */
        @path
        @segment("roles")
        roleName: string,
      },
      {
        /**
         * The name of the monitoring config.
         */
        @path
        @segment("monitoringConfig")
        monitoringConfig: string,
      }
    > {}

@armResourceOperations
interface MonitoringMetricConfigurationsNonListOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the device.
         */
        @path
        @segment("dataBoxEdgeDevices")
        deviceName: string,

        /**
         * The name of the role.
         */
        @path
        @segment("roles")
        roleName: string,
      },
      {}
    > {}

@@doc(MonitoringMetricConfiguration.name, "");
@@doc(MonitoringMetricConfiguration.properties,
  "The metric setting properties."
);
@@doc(MonitoringMetricConfigurations.createOrUpdate::parameters.resource,
  "The metric configuration."
);
