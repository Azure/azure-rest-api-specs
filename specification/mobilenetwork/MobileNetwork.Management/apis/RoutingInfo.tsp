import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/RoutingInfoModels.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Routing information")
@resource("routingInfo")
@singleton("default")
@parentResource(PacketCoreControlPlane)
model RoutingInfoModel is ProxyResource<RoutingInfoPropertiesFormat> {
  @doc("The name of the routing info.")
  @path
  @key("routingInfo")
  @segment("routingInfo")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface RoutingInfoModels {
  @doc("Get the routing information for the packet core.")
  get is ArmResourceRead<RoutingInfoModel>;

  @doc("List all of the routing information for the packet core.")
  listByPacketCoreControlPlane is ArmResourceListByParent<RoutingInfoModel>;
}
