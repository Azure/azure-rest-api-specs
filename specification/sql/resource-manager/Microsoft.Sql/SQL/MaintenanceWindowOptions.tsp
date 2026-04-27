import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Maintenance window options.
 */
@singleton("current")
@parentResource(Database)
model MaintenanceWindowOptions
  is Azure.ResourceManager.ProxyResource<MaintenanceWindowOptionsProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceWindowOptions,
    KeyName = "maintenanceWindowOption",
    SegmentName = "maintenanceWindowOptions",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface MaintenanceWindowOptionsOperationGroup {
  /**
   * Gets a list of available maintenance windows.
   */
  @tag("MaintenanceWindowOptions")
  get is ArmResourceRead<
    MaintenanceWindowOptions,
    Parameters = {
      /**
       * Maintenance window options name.
       */
      @query("maintenanceWindowOptionsName")
      maintenanceWindowOptionsName: string;
    }
  >;
}

@@doc(MaintenanceWindowOptions.name, "");
@@doc(MaintenanceWindowOptions.properties, "Resource properties.");
