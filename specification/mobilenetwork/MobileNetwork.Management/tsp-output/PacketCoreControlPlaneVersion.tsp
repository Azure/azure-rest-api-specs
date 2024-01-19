import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
@doc("Packet core control plane version resource.")
@tenantResource
model PacketCoreControlPlaneVersion
  is ProxyResource<PacketCoreControlPlaneVersionPropertiesFormat> {
  @doc("The name of the packet core control plane version.")
  @path
  @key("versionName")
  @segment("packetCoreControlPlaneVersions")
  name: string;
}

@armResourceOperations
interface PacketCoreControlPlaneVersions {
  @doc("Gets information about the specified packet core control plane version.")
  get is ArmResourceRead<PacketCoreControlPlaneVersion>;

  @doc("Lists all supported packet core control planes versions.")
  list is ArmResourceListByParent<PacketCoreControlPlaneVersion>;
}
