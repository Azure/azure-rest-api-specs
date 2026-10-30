import "./common.tsp";
import "./FabricDelegation.tsp";

using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.ManagedNetworkFabric;

@doc("Provider-side allocation of one concrete Vrf under a Fabric delegation authorization.")
@added(Versions.v2026_07_15_preview)
model VrfDelegationProperties {
  @doc("Same-Fabric FabricDelegation ARM resource ID. Required and immutable after creation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricDelegationResourceId: armResourceIdentifier;

  @doc("CSP authorization limits for this Vrf. Required, immutable, and capped by the Fabric delegation defaults.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  limits: RoutingDomainGrantLimits;

  @doc("Optional normalized private-prefix guardrail for managed segments in this Vrf.")
  addressPrefixes?: string[];

  @doc("Provider-neutral egress authorization label. Required when NAT or public IP allowance is enabled.")
  egressNetwork?: string;

  @doc("Enabled publishes the Vrf grant; Disabled blocks new use and starts fail-closed withdrawal.")
  administrativeState: AdministrativeState;

  @doc("Service-populated ARM provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("VrfDelegation patchable properties.")
@added(Versions.v2026_07_15_preview)
model VrfDelegationPatchableProperties {
  @doc("Optional normalized private-prefix guardrail for managed segments in this Vrf.")
  addressPrefixes?: string[];

  @doc("Provider-neutral egress authorization label.")
  egressNetwork?: string;

  @doc("Enabled publishes the Vrf grant; Disabled blocks new use and starts fail-closed withdrawal.")
  administrativeState?: AdministrativeState;
}

@doc("The VrfDelegation patch resource definition.")
@added(Versions.v2026_07_15_preview)
model VrfDelegationPatch {
  ...TagsUpdate;

  @doc("VrfDelegation patchable properties.")
  properties?: VrfDelegationPatchableProperties;
}
