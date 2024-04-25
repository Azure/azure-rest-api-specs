import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/PacketCoreControlPlaneVersionModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Packet core control plane version resource.")
@resource("packetCoreControlPlaneVersions")
@subscriptionResource
model PacketCoreControlPlaneVersion
  is ProxyResource<PacketCoreControlPlaneVersionPropertiesFormat> {
  @doc("The name of the packet core control plane version.")
  @pattern(".*")
  @path
  @key("versionName")
  @segment("packetCoreControlPlaneVersions")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PacketCoreControlPlaneVersions {
  @doc("Gets information about the specified packet core control plane version.")
  getBySubscription is ArmResourceRead<PacketCoreControlPlaneVersion>;

  @doc("Lists all supported packet core control planes versions.")
  listBySubscription is ArmListBySubscription<PacketCoreControlPlaneVersion>;
}

@armResourceOperations
interface PacketCoreControlPlaneVersionsTenantResource {
  @doc("Gets information about the specified packet core control plane version.")
  get is ArmResourceRead<
    PacketCoreControlPlaneVersion,
    BaseParameters = ApiVersionParameter
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "TypeSpec generated an Operation ID called PacketCoreControlPlaneVersionsTenantResource_ListBySubscription. Changed it to PacketCoreControlPlaneVersionsTenantResource_ListByTenant because this operation is for the tenant level only."
  @doc("Lists all supported packet core control planes versions.")
  @operationId("PacketCoreControlPlaneVersionsTenantResource_ListByTenant")
  listByTenant is ArmResourceListByParent<
    PacketCoreControlPlaneVersion,
    BaseParameters = ApiVersionParameter
  >;
}
