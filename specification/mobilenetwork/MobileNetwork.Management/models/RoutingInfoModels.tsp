import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.MobileNetwork;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility. The resource RoutingInfo is for retrieving the information of the resources only."
@doc("Routing information properties")
model RoutingInfoPropertiesFormat {
  @doc("A list of IPv4 control plane access routes.")
  @identifiers(#[])
  controlPlaneAccessRoutes?: Ipv4Routes;

  @doc("A list of IPv4 user plane access routes.")
  @identifiers(#[])
  userPlaneAccessRoutes?: Ipv4Routes;

  @doc("A list of attached data networks and their IPv4 routes.")
  @identifiers(#[])
  userPlaneDataRoutes?: UserPlaneDataRoutes;
}

@doc("A list of IPv4 routes.")
@identifiers(#["destination"])
model Ipv4Routes is Array<Ipv4Route>;

@doc("An IPv4 route.")
model Ipv4Route {
  @doc("The destination IPv4 prefix.")
  destination?: Ipv4AddrMask;

  @doc("A list of next hops for the destination.")
  @identifiers(#["address"])
  nextHops?: Ipv4RouteNextHop[];
}

@doc("The next hop in an IPv4 route.")
model Ipv4RouteNextHop {
  @doc("The next hop address.")
  address?: Ipv4Addr;

  @doc("The priority of this next hop. Next hops with lower preference values are preferred.")
  priority?: int32;
}

@doc("A list of attached data networks and their IPv4 routes.")
@identifiers(#["/attachedDataNetwork/id"])
model UserPlaneDataRoutes is Array<UserPlaneDataRoutesItem>;

@doc("Attached data networks and their IPv4 routes.")
model UserPlaneDataRoutesItem {
  @doc("Reference to an attached data network resource.")
  attachedDataNetwork?: AttachedDataNetworkResourceId;

  @doc("A list of IPv4 routes.")
  @identifiers(#[])
  routes?: Ipv4Routes;
}
