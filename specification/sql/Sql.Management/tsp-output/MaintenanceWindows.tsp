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
 * Maintenance windows.
 */
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
  /**
   * Gets maintenance windows settings for a database.
   */
  get is ArmResourceRead<
    MaintenanceWindows,
    {
      ...BaseParameters<MaintenanceWindows>;

      /**
       * Maintenance window name.
       */
      @query("maintenanceWindowName")
      maintenanceWindowName: string;
    }
  >;

  /**
   * Sets maintenance windows settings for a database.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MaintenanceWindows,
    {
      ...BaseParameters<MaintenanceWindows>;

      /**
       * Maintenance window name.
       */
      @query("maintenanceWindowName")
      maintenanceWindowName: string;
    }
  >;
}

@@projectedName(MaintenanceWindowsOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(MaintenanceWindowsOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(MaintenanceWindowsOperationGroup.createOrUpdate::parameters.resource, "");
