import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/Probe.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@armResourceOperations(#{ omitTags: true })
interface Probes {
  /**
   * Gets load balancer probe.
   */
  @tag("LoadBalancers")
  get is ArmResourceRead<Probe, Error = CloudError>;

  /**
   * Gets all the load balancer probes.
   */
  @tag("LoadBalancers")
  list is ArmResourceListByParent<
    Probe,
    Response = LoadBalancerProbeListResult,
    Error = CloudError
  >;
}

@@doc(Probe.name, "The name of the probe.");
@@doc(Probe.properties, "Properties of load balancer probe.");
