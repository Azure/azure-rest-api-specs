import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Probe.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

@featureFile(Features.loadBalancer)
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
