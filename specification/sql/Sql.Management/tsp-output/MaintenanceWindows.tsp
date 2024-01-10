import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("Maintenance windows.")
@singleton("current")
@parentResource(Database)
model MaintenanceWindows is ProxyResource<MaintenanceWindowsProperties> {
  @key("maintenanceWindow")
  @segment("maintenanceWindows")
  name: string;
}

@armResourceOperations
@projectedName("client", "MaintenanceWindows")
interface MaintenanceWindowsOperationGroup {
  @doc("Gets maintenance windows settings for a database.")
  get is ArmResourceRead<
    MaintenanceWindows,
    {
      ...BaseParameters<MaintenanceWindows>;

      @doc("Maintenance window name.")
      @query("maintenanceWindowName")
      maintenanceWindowName: string;
    }
  >;

  @doc("Sets maintenance windows settings for a database.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MaintenanceWindows,
    {
      ...BaseParameters<MaintenanceWindows>;

      @doc("Maintenance window name.")
      @query("maintenanceWindowName")
      maintenanceWindowName: string;
    }
  >;
}
