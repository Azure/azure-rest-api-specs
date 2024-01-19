import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maintenance;
@doc("Maintenance configuration record type")
@subscriptionResource
model MaintenanceConfiguration
  is TrackedResource<MaintenanceConfigurationProperties> {
  @doc("Maintenance Configuration Name")
  @path
  @key("resourceName")
  @segment("publicMaintenanceConfigurations")
  name: string;
}

@armResourceOperations
interface MaintenanceConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get Public Maintenance Configuration record")
  @operationId("PublicMaintenanceConfigurations_Get")
  get is ArmResourceRead<MaintenanceConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get Public Maintenance Configuration records")
  @operationId("PublicMaintenanceConfigurations_List")
  list is ArmResourceListByParent<MaintenanceConfiguration>;
}
