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

namespace Microsoft.OffAzure;
/**
 * An software inventory resource belonging to a server resource.
 */
@parentResource(Server)
model ServerSoftwareInventory
  is Azure.ResourceManager.ProxyResource<MachineSoftwareInventoryProperties> {
  ...ResourceNameParameter<
    Resource = ServerSoftwareInventory,
    KeyName = "default",
    SegmentName = "softwareInventories",
    NamePattern = "",
    Type = Default
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ServerSoftwareInventories {
  /**
   * Method to get a machines software inventory like applications and roles.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ServerSoftwareInventoriesController")
  @operationId("ServerSoftwareInventoriesController_GetMachineSoftwareInventory")
  getMachineSoftwareInventory is ArmResourceRead<ServerSoftwareInventory>;

  /**
   * List ServerSoftwareInventory resources by Server
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ServerSoftwareInventoriesController")
  @operationId("ServerSoftwareInventoriesController_ListByServer")
  listByServer is ArmResourceListByParent<ServerSoftwareInventory>;
}

@@doc(ServerSoftwareInventory.name, "Default value.");
@@doc(ServerSoftwareInventory.properties,
  "The resource-specific properties for this resource."
);
