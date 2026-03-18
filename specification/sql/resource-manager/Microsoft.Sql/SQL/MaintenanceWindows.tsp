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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface MaintenanceWindowsOperationGroup {
  /**
   * Gets maintenance windows settings for a database.
   */
  @tag("MaintenanceWindows")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("MaintenanceWindows")
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
