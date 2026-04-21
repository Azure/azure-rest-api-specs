import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MachineResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * An software inventory resource belonging to a machine resource.
 */
@parentResource(MachineResource)
model VmwareMachineSoftwareInventory
  is Azure.ResourceManager.ProxyResource<MachineSoftwareInventoryProperties> {
  ...ResourceNameParameter<
    Resource = VmwareMachineSoftwareInventory,
    KeyName = "default",
    SegmentName = "softwareInventories",
    NamePattern = "",
    Type = Default
  >;
}

@armResourceOperations(#{ omitTags: true })
interface VmwareMachineSoftwareInventories {
  /**
   * Method to get a machines software inventory like applications and roles.
   */
  @tag("VmwareSoftwareInventoriesController")
  getMachineSoftwareInventory is ArmResourceRead<VmwareMachineSoftwareInventory>;

  /**
   * List VmwareMachineSoftwareInventory resources by MachineResource
   */
  @tag("VmwareSoftwareInventoriesController")
  listByMachineResource is ArmResourceListByParent<VmwareMachineSoftwareInventory>;
}

@@doc(VmwareMachineSoftwareInventory.name, "Default value.");
@@doc(VmwareMachineSoftwareInventory.properties,
  "The resource-specific properties for this resource."
);
