import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Connectivity model for EdgeConnector.")
@added(Versions.v2026_01_15_preview)
union ConnectivityModel {
  string,

  @doc("No connectivity.")
  none: "none",

  @doc("Direct IP reachability.")
  direct: "direct",

  @doc("Arc Proxy tunnel.")
  arcProxy: "arcProxy",

  @doc("ExpressRoute private peering.")
  expressRoute: "expressRoute",
}

@doc("EdgeConnector patchable properties.")
@added(Versions.v2026_01_15_preview)
model EdgeConnectorPatchableProperties {
  @doc("How the EdgeConnector establishes connectivity to on-prem infrastructure.")
  connectivityModel?: ConnectivityModel;

  @doc("Software version of the control plane.")
  version?: string;
}

@doc("EdgeConnector patch body.")
@added(Versions.v2026_01_15_preview)
model EdgeConnectorPatch {
  ...TagsUpdate;

  @doc("Resource properties.")
  properties?: EdgeConnectorPatchableProperties;
}

@doc("EdgeConnectorProperties defines the resource properties.")
@added(Versions.v2026_01_15_preview)
model EdgeConnectorProperties {
  ...EdgeConnectorPatchableProperties;

  @doc("ARM resource IDs of Fabric resources managed by this EdgeConnector.")
  @visibility(Lifecycle.Read)
  managedFabricIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/fabrics";
    }
  ]>[];

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
