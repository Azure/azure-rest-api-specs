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
 * Maintenance windows.
 */
@singleton("current")
@parentResource(Database)
model MaintenanceWindows
  is Azure.ResourceManager.ProxyResource<MaintenanceWindowsProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceWindows,
    KeyName = "maintenanceWindow",
    SegmentName = "maintenanceWindows",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MaintenanceWindowsOperationGroup {
  /**
   * Gets maintenance windows settings for a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceWindows_Get")
  get is ArmResourceRead<
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
   * Sets maintenance windows settings for a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("MaintenanceWindows_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
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
@@doc(MaintenanceWindowsOperationGroup.createOrUpdate::parameters.resource, "");
