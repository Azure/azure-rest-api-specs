import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Virtual Network Tap resource.
 */
@featureFile(Features.networkGateway)
model VirtualNetworkTap is ResourceInstance<VirtualNetworkTapPropertiesFormat> {
  @visibility(Lifecycle.Read)
  @path
  @key("tapName")
  @segment("virtualNetworkTaps")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(VirtualNetworkTap.name, "The name of virtual network tap.");
@@doc(VirtualNetworkTap.properties, "Virtual Network Tap Properties.");
