import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Maintenance window options.")
@singleton("current")
@parentResource(Database)
model MaintenanceWindowOptions
  is ProxyResource<MaintenanceWindowOptionsProperties> {
  @key("current")
  @segment("maintenanceWindowOptions")
  name: string;
}

@armResourceOperations
interface MaintenanceWindowOptions {
  @doc("Gets a list of available maintenance windows.")
  get is ArmResourceRead<
    MaintenanceWindowOptions,
    {
      ...BaseParameters<MaintenanceWindowOptions>;

      @doc("Maintenance window options name.")
      @query("maintenanceWindowOptionsName")
      maintenanceWindowOptionsName: string;
    }
  >;
}
