import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforMySQL;
/**
 * Represents a maintenance.
 */
@parentResource(Server)
model Maintenance
  is Azure.ResourceManager.ProxyResource<MaintenanceProperties, false> {
  ...ResourceNameParameter<
    Resource = Maintenance,
    KeyName = "maintenanceName",
    SegmentName = "maintenances",
    NamePattern = "^[a-zA-Z0-9-_]*$"
  >;
}

@armResourceOperations
interface Maintenances {
  /**
   * Read maintenance.
   */
  read is ArmResourceRead<Maintenance>;

  /**
   * Update maintenances.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Maintenance,
    PatchModel = MaintenanceUpdate,
    OptionalRequestBody = true
  >;

  /**
   * List maintenances.
   */
  list is ArmResourceListByParent<
    Maintenance,
    Response = ArmResponse<MaintenanceListResult>
  >;
}

@@doc(Maintenance.name, "The name of the maintenance.");
@@doc(Maintenance.properties, "The properties of a maintenance");
@@doc(Maintenances.update::parameters.properties,
  "The required parameters for update maintenance on a server."
);
