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
 * Virtual Network resource.
 */
@featureFile(Features.virtualNetwork)
model VirtualNetwork is ResourceInstance<VirtualNetworkPropertiesFormat> {
  @visibility(Lifecycle.Read)
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  /**
   * The extended location of the virtual network.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(VirtualNetwork.name, "The name of the virtual network.");
@@doc(VirtualNetwork.properties, "Properties of the virtual network.");
