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
 * Maintenance windows.
 */
@singleton("current")
@parentResource(SqlPool)
model MaintenanceWindows
  is Azure.ResourceManager.ProxyResource<MaintenanceWindowsProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceWindows,
    KeyName = "maintenancewindow",
    SegmentName = "maintenancewindows",
    NamePattern = ""
  >;
}

alias MaintenanceWindowsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolParentParameters,
  {
    /** The maintenance window name (always current). */
    @segment("maintenancewindows")
    @key
    @path
    maintenanceWindow: "current";
  }
>;

@armResourceOperations
interface SqlPoolMaintenanceWindows {
  /**
   * Get a SQL pool's Maintenance Windows.
   */
  get is MaintenanceWindowsOps.Read<
    MaintenanceWindows,
    Parameters = {
      /**
       * Maintenance window name.
       */
      @query("maintenanceWindowName")
      maintenanceWindowName: string;
    }
  >;

  /**
   * Creates or updates a Sql pool's maintenance windows settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The published 200 response has no body."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is MaintenanceWindowsOps.CreateOrUpdateSync<
    MaintenanceWindows,
    Parameters = {
      /**
       * Maintenance window name.
       */
      @query("maintenanceWindowName")
      maintenanceWindowName: string;
    },
    Response = OkResponse
  >;
}

@@doc(MaintenanceWindows.name, "");
@@doc(MaintenanceWindows.properties, "Resource properties.");
@@doc(
  SqlPoolMaintenanceWindows.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating Maintenance Windows settings"
);
