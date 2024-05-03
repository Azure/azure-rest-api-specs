import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/UesModels.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Basic UE Information.")
@resource("ues")
@parentResource(PacketCoreControlPlane)
model UeInfo is ProxyResource<UeInfoPropertiesFormat> {
  @doc("IMSI of a UE.")
  @pattern(".*")
  @path
  @key("ueId")
  @segment("ues")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Ues {
  @doc("List all UEs and their state in a packet core.")
  listByPacketCoreControlPlane is ArmResourceListByParent<UeInfo>;
}
