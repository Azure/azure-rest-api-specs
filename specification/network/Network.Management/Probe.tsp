import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LoadBalancer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * A load balancer probe.
 */
@parentResource(LoadBalancer)
model Probe is Azure.ResourceManager.ProxyResource<ProbePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = Probe,
    KeyName = "probeName",
    SegmentName = "probes",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface Probes {
  /**
   * Gets load balancer probe.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerProbes_Get")
  get is ArmResourceRead<Probe, Error = CloudError>;

  /**
   * Gets all the load balancer probes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerProbes_List")
  list is ArmResourceListByParent<
    Probe,
    Response = LoadBalancerProbeListResult,
    Error = CloudError
  >;
}

@@doc(Probe.name, "The name of the probe.");
@@doc(Probe.properties, "Properties of load balancer probe.");
