import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Maintenance;
@doc("Maintenance configuration record type")
@subscriptionResource
model MaintenanceConfiguration
  is TrackedResource<MaintenanceConfigurationProperties> {
  @doc("Maintenance Configuration Name")
  @key("resourceName")
  @segment("publicMaintenanceConfigurations")
  name: string;
}

@armResourceOperations
@projectedName("client", "PublicMaintenanceConfigurations")
interface MaintenanceConfigurations_PublicMaintenanceConfigurations {
  @doc("Get Public Maintenance Configuration record")
  get is ArmResourceRead<MaintenanceConfiguration>;

  @doc("Get Public Maintenance Configuration records")
  list is ArmResourceListByParent<MaintenanceConfiguration>;
}
