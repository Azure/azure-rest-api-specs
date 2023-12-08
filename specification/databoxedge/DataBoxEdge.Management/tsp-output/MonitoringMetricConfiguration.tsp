import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeRole.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
@doc("The metric setting details for the role")
@parentResource(DataBoxEdgeRole)
@singleton("default")
model MonitoringMetricConfiguration
  is ProxyResource<MonitoringMetricConfigurationProperties> {
  @key("default")
  @segment("monitoringConfig")
  name: string;
}

@armResourceOperations
interface MonitoringMetricConfigurations {
  @doc("Gets a  metric configuration of a role.")
  get is ArmResourceRead<MonitoringMetricConfiguration>;
  @doc("Creates a new metric configuration or updates an existing one for a role.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MonitoringMetricConfiguration>;
  @doc("deletes a new metric configuration for a role.")
  delete is ArmResourceDeleteAsync<MonitoringMetricConfiguration>;
  @doc("Lists metric configurations in a role.")
  listByDataBoxEdgeRole is ArmResourceListByParent<MonitoringMetricConfiguration>;
}
