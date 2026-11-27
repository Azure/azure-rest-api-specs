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

@doc("Tunnel type for EdgeConnector connectivity.")
@added(Versions.v2026_07_15_preview)
union TunnelType {
  string,

  @doc("Customer-managed connectivity — the RP does not orchestrate the tunnel.")
  direct: "direct",
}

@doc("Connectivity state of the EdgeConnector.")
@added(Versions.v2026_07_15_preview)
union ConnectivityState {
  string,

  @doc("Connected and ready to receive requests.")
  Connected: "Connected",

  @doc("Not connected.")
  Disconnected: "Disconnected",

  @doc("Connection pending.")
  Pending: "Pending",
}

@doc("Connectivity configuration for the EdgeConnector.")
@added(Versions.v2026_07_15_preview)
model ConnectivityConfig {
  @doc("How connectivity is established. Starting value: direct.")
  tunnelType: TunnelType;

  @doc("ARM resource ID of the Custom Location where the RP projects CRDs.")
  customLocationId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;
}

@doc("Connectivity configuration for PATCH.")
@added(Versions.v2026_07_15_preview)
model PatchConnectivityConfig {
  @doc("How connectivity is established.")
  tunnelType?: TunnelType;

  @doc("ARM resource ID of the Custom Location where the RP projects CRDs.")
  customLocationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;
}

@doc("EdgeConnector patchable properties.")
@added(Versions.v2026_01_15_preview)
model EdgeConnectorPatchableProperties {
  @doc("How the EdgeConnector establishes connectivity to on-prem infrastructure.")
  @removed(Versions.v2026_07_15_preview)
  connectivityModel?: ConnectivityModel;

  @doc("Software version of the control plane.")
  @removed(Versions.v2026_07_15_preview)
  version?: string;

  @doc("Connectivity configuration.")
  @added(Versions.v2026_07_15_preview)
  connectivity?: PatchConnectivityConfig;

  @doc("Free-text description. Max 1024 characters.")
  @added(Versions.v2026_07_15_preview)
  @maxLength(1024)
  description?: string;
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
  @removed(Versions.v2026_07_15_preview)
  @visibility(Lifecycle.Read)
  managedFabricIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/fabrics";
    }
  ]>[];

  @doc("Whether the target destination is connected and ready to receive requests.")
  @added(Versions.v2026_07_15_preview)
  @visibility(Lifecycle.Read)
  connectivityState?: ConnectivityState;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
