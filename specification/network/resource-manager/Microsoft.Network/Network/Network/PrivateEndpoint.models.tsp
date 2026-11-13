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
 * Private endpoint resource.
 */
@featureFile(Features.virtualNetwork)
model PrivateEndpoint is ResourceInstance<PrivateEndpointProperties> {
  @visibility(Lifecycle.Read)
  @path
  @key("privateEndpointName")
  @segment("privateEndpoints")
  name: string;

  /**
   * The extended location of the load balancer.
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

@@doc(PrivateEndpoint.name, "The name of the private endpoint.");
@@doc(PrivateEndpoint.properties, "Properties of the private endpoint.");
