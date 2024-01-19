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
@doc("The metric setting details for the role")
@singleton("default")
@parentResource(Role)
model MonitoringMetricConfiguration
  is ProxyResource<MonitoringMetricConfigurationProperties> {
  @key("monitoringConfig")
  @segment("monitoringConfig")
  name: string;
}

@armResourceOperations
interface MonitoringMetricConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a  metric configuration of a role.")
  @operationId("MonitoringConfig_Get")
  get is ArmResourceRead<MonitoringMetricConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new metric configuration or updates an existing one for a role.")
  @operationId("MonitoringConfig_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MonitoringMetricConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("deletes a new metric configuration for a role.")
  @operationId("MonitoringConfig_Delete")
  delete is ArmResourceDeleteAsync<MonitoringMetricConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists metric configurations in a role.")
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
