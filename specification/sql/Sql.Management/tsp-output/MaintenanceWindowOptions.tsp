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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("current")
@parentResource(Database)
@includeInapplicableMetadataInPayload(false)
model MaintenanceWindowOptions extends ProxyResource {
  @key("maintenanceWindowOption")
  @segment("maintenanceWindowOptions")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MaintenanceWindowOptionsProperties;
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
