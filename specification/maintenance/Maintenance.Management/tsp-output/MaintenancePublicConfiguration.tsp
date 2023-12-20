import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Maintenance;
@doc("Maintenance configuration record type")
@subscriptionResource
model MaintenancePublicConfiguration
  is TrackedResource<MaintenanceConfigurationProperties> {
  @doc("Maintenance Configuration Name")
  @path
  @key("resourceName")
  @segment("publicMaintenanceConfigurations")
  name: string;
}

@armResourceOperations
interface MaintenancePublicConfigurations {
  @doc("Get Public Maintenance Configuration record")
  get is ArmResourceRead<MaintenancePublicConfiguration>;
  @doc("Get Public Maintenance Configuration records")
  list is ArmResourceListByParent<MaintenancePublicConfiguration>;
}
