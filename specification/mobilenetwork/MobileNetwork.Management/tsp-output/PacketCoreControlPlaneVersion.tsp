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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(
  PacketCoreControlPlaneVersionPropertiesFormat
)
@includeInapplicableMetadataInPayload(false)
model PacketCoreControlPlaneVersion extends ProxyResourceBase {
  /**
   * The name of the packet core control plane version.
   */
  @path
  @key("versionName")
  @segment("packetCoreControlPlaneVersions")
  name: string;

  /**
   * Packet core control plane version properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: PacketCoreControlPlaneVersionPropertiesFormat;
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
