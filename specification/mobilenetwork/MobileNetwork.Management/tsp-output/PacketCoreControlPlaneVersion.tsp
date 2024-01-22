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
/**
 * Packet core control plane version resource.
 */
@tenantResource
model PacketCoreControlPlaneVersion
  is ProxyResource<PacketCoreControlPlaneVersionPropertiesFormat> {
  /**
   * The name of the packet core control plane version.
   */
  @path
  @key("versionName")
  @segment("packetCoreControlPlaneVersions")
  name: string;
}

@armResourceOperations
interface PacketCoreControlPlaneVersions {
  /**
   * Gets information about the specified packet core control plane version.
   */
  get is ArmResourceRead<PacketCoreControlPlaneVersion>;

  /**
   * Lists all supported packet core control planes versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PacketCoreControlPlaneVersions_List")
  list is ArmResourceListByParent<PacketCoreControlPlaneVersion>;
}
