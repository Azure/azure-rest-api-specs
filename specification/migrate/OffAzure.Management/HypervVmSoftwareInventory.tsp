import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HypervMachine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * HyperV VM software inventory REST resource.
 */
@parentResource(HypervMachine)
model HypervVmSoftwareInventory
  is Azure.ResourceManager.ProxyResource<MachineSoftwareInventoryProperties> {
  ...ResourceNameParameter<
    Resource = HypervVmSoftwareInventory,
    KeyName = "default",
    SegmentName = "softwareInventories",
    NamePattern = "",
    Type = Default
  >;
}

@armResourceOperations(#{ omitTags: true })
interface HypervVmSoftwareInventories {
  /**
   * Method to get a machines software inventory like applications and roles.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("HypervSoftwareInventoriesController")
  @operationId("HypervSoftwareInventoriesController_GetMachineSoftwareInventory")
  getMachineSoftwareInventory is ArmResourceRead<HypervVmSoftwareInventory>;

  /**
   * List HypervVmSoftwareInventory resources by HypervMachine
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("HypervSoftwareInventoriesController")
  @operationId("HypervSoftwareInventoriesController_ListByHypervMachine")
  listByHypervMachine is ArmResourceListByParent<HypervVmSoftwareInventory>;
}

@@doc(HypervVmSoftwareInventory.name, "Default value.");
@@doc(HypervVmSoftwareInventory.properties,
  "The resource-specific properties for this resource."
);
