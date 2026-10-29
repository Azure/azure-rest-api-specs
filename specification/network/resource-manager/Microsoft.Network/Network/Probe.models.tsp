import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./LoadBalancer.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * A load balancer probe.
 */
@featureFile(Features.loadBalancer)
@parentResource(LoadBalancer)
model Probe is SubResourceInstance<ProbePropertiesFormat> {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @path
  @key("probeName")
  @segment("probes")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}
