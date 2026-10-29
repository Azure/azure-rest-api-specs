import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared-models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * A network interface in a resource group.
 */
@featureFile(Features.virtualNetwork)
model NetworkInterface is ResourceInstance<NetworkInterfacePropertiesFormat> {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  name: string;

  /**
   * The extended location of the network interface.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}
