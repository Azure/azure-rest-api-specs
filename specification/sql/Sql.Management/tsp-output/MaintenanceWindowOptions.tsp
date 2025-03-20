import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Maintenance window options.
 */
@singleton("current")
@parentResource(Database)
model MaintenanceWindowOptions
  is ProxyResource<MaintenanceWindowOptionsProperties> {
  @key("maintenanceWindowOption")
  @segment("maintenanceWindowOptions")
  name: string;
}

@armResourceOperations
@projectedName("client", "MaintenanceWindowOptions")
interface MaintenanceWindowOptionsOperationGroup {
  /**
   * Gets a list of available maintenance windows.
   */
  get is ArmResourceRead<
    MaintenanceWindowOptions,
    {
      ...BaseParameters<MaintenanceWindowOptions>;

      /**
       * Maintenance window options name.
       */
      @query("maintenanceWindowOptionsName")
      maintenanceWindowOptionsName: string;
    }
  >;
}
