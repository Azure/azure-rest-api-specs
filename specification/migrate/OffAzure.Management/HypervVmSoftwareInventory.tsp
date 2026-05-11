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

alias HypervVmSoftwareInventoryLegacyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Site name. */
    @path
    @segment("hypervSites")
    @key
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    siteName: string;

    /** Machine name. */
    @path
    @segment("machines")
    @key
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    machineName: string;
  },
  {
    /** Default value. */
    @path
    @segment("softwareinventories")
    @key
    default: Default;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface HypervVmSoftwareInventories {
  /**
   * Method to get a machines software inventory like applications and roles.
   */
  @tag("HypervSoftwareInventoriesController")
  getMachineSoftwareInventory is ArmResourceRead<HypervVmSoftwareInventory>;

  /**
   * List HypervVmSoftwareInventory resources by HypervMachine
   */
  @tag("HypervSoftwareInventoriesController")
  listByHypervMachine is HypervVmSoftwareInventoryLegacyOps.List<HypervVmSoftwareInventory>;
}

@@doc(HypervVmSoftwareInventory.name, "Default value.");
@@doc(HypervVmSoftwareInventory.properties,
  "The resource-specific properties for this resource."
);
