import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Authorization lifecycle state served to tenant-local projections.")
@added(Versions.v2026_07_15_preview)
union AuthorizationState {
  string,

  @doc("Authorization is active.")
  Active: "Active",

  @doc("Authorization has been revoked.")
  Revoked: "Revoked",
}

@doc("Per-routing-domain authorization limits.")
@added(Versions.v2026_07_15_preview)
model RoutingDomainGrantLimits {
  @doc("Maximum managed segments authorized in this routing domain.")
  @minValue(0)
  vlanBudget: int32;

  @doc("Maximum concurrently bound PublicIPAddress resources.")
  @minValue(0)
  publicIpAllowance: int32;

  @doc("Whether this Vrf grant permits one managed NatGateway/default edge.")
  managedNatEnabled: BooleanEnumProperty;

  @doc("Maximum SNAT ports authorized for the one managed NatGateway. Must be zero when managedNatEnabled is False.")
  @minValue(0)
  maxSnatPorts: int32;
}

@doc("Per-routing-domain authorization limits for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchRoutingDomainGrantLimits {
  @doc("Maximum managed segments authorized in this routing domain.")
  @minValue(0)
  vlanBudget?: int32;

  @doc("Maximum concurrently bound PublicIPAddress resources.")
  @minValue(0)
  publicIpAllowance?: int32;

  @doc("Whether this Vrf grant permits one managed NatGateway/default edge.")
  managedNatEnabled?: BooleanEnumProperty;

  @doc("Maximum SNAT ports authorized for the one managed NatGateway. Must be zero when managedNatEnabled is False.")
  @minValue(0)
  maxSnatPorts?: int32;
}

@doc("Provider-side authorization that projects Fabric routing-domain policy into one customer resource group.")
@added(Versions.v2026_07_15_preview)
model FabricDelegationProperties {
  @doc("Customer subscription authorized to consume routing domains from this Fabric. Required and immutable after creation.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  customerSubscriptionId: string;

  @doc("Customer Entra tenant that owns customerSubscriptionId. Required and immutable after creation.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  customerTenantId: string;

  @doc("Exact customer resource group that receives the tenant-local authorization. Required and immutable after creation.")
  @minLength(1)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  customerResourceGroupName: string;

  @doc("Maximum active plus cleanup-pending routing domains under this authorization.")
  @minValue(0)
  routingDomainBudget: int32;

  @doc("CSP-owned limits snapshotted by future Vrf delegations created from this authorization.")
  defaultRoutingDomainLimits: RoutingDomainGrantLimits;

  @doc("Optional normalized private IPv4 prefixes that constrain customer-requested routing domains.")
  addressPrefixes?: string[];

  @doc("Provider-neutral egress labels a customer-created Vrf may select. Empty authorizes private-only routing domains.")
  allowedEgressNetworks: string[];

  @doc("Enabled publishes the grant; Disabled blocks new use and starts fail-closed revocation.")
  administrativeState: AdministrativeState;

  @doc("Service-populated ARM provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Authorization lifecycle state served to tenant-local projections.")
  @visibility(Lifecycle.Read)
  authorizationState?: AuthorizationState;

  @doc("Number of held routing-domain claims that are live and not cleanup-pending.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  activeRoutingDomains?: int32;

  @doc("Routing-domain budget still free for new use: budget minus active minus cleanup-pending.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  availableRoutingDomains?: int32;
}

@doc("FabricDelegation patchable properties.")
@added(Versions.v2026_07_15_preview)
model FabricDelegationPatchableProperties {
  @doc("Maximum active plus cleanup-pending routing domains under this authorization.")
  @minValue(0)
  routingDomainBudget?: int32;

  @doc("CSP-owned limits snapshotted by future Vrf delegations created from this authorization.")
  defaultRoutingDomainLimits?: PatchRoutingDomainGrantLimits;

  @doc("Optional normalized private IPv4 prefixes that constrain customer-requested routing domains.")
  addressPrefixes?: string[];

  @doc("Provider-neutral egress labels a customer-created Vrf may select.")
  allowedEgressNetworks?: string[];

  @doc("Enabled publishes the grant; Disabled blocks new use and starts fail-closed revocation.")
  administrativeState?: AdministrativeState;
}

@doc("The FabricDelegation patch resource definition.")
@added(Versions.v2026_07_15_preview)
model FabricDelegationPatch {
  ...TagsUpdate;

  @doc("FabricDelegation patchable properties.")
  properties?: FabricDelegationPatchableProperties;
}
