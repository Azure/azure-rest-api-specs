import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Maintenance window options.
 */
@singleton("current")
@parentResource(SqlPool)
model MaintenanceWindowOptions
  is Azure.ResourceManager.ProxyResource<MaintenanceWindowOptionsProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceWindowOptions,
    KeyName = "maintenanceWindowOption",
    SegmentName = "maintenanceWindowOptions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlPoolMaintenanceWindowOptions {
  /**
   * Get list of SQL pool's available maintenance windows.
   */
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
