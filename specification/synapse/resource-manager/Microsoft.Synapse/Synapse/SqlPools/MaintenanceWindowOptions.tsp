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

namespace SqlPools;
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

alias MaintenanceWindowOptionsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolParentParameters,
  {
    /** The maintenance window options name (always current). */
    @segment("maintenanceWindowOptions")
    @key
    @path
    maintenanceWindowOption: "current";
  }
>;

@armResourceOperations
interface SqlPoolMaintenanceWindowOptions {
  /**
   * Get list of SQL pool's available maintenance windows.
   */
  get is MaintenanceWindowOptionsOps.Read<
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
