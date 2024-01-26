import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Role.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The metric setting details for the role
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(Role)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  MonitoringMetricConfigurationProperties
)
model MonitoringMetricConfiguration extends ProxyResourceBase {
  @key("monitoringConfig")
  @segment("monitoringConfig")
  @visibility("read")
  name: string;

  /**
   * The metric setting properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: MonitoringMetricConfigurationProperties;
}

@armResourceOperations
interface MonitoringMetricConfigurations {
  /**
   * Gets a  metric configuration of a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MonitoringConfig_Get")
  get is ArmResourceRead<MonitoringMetricConfiguration>;

  /**
   * Creates a new metric configuration or updates an existing one for a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MonitoringConfig_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MonitoringMetricConfiguration>;

  /**
   * deletes a new metric configuration for a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MonitoringConfig_Delete")
  delete is ArmResourceDeleteAsync<MonitoringMetricConfiguration>;

  /**
   * Lists metric configurations in a role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MonitoringConfig_List")
  list is ArmResourceListByParent<MonitoringMetricConfiguration>;
}

@@projectedName(MonitoringMetricConfigurations.createOrUpdate::parameters.resource,
  "json",
  "monitoringMetricConfiguration"
);
@@extension(MonitoringMetricConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "monitoringMetricConfiguration"
);
@@doc(MonitoringMetricConfigurations.createOrUpdate::parameters.resource,
  "The metric configuration."
);
