import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;
/**
 * The configurations regarding multiple standard load balancers. If not supplied, single load balancer mode will be used. Multiple standard load balancers mode will be used if at lease one configuration is supplied. There has to be a configuration named `kubernetes`. The name field will be the name of the corresponding public load balancer. There will be an internal load balancer created if needed, and the name will be `<name>-internal`. The internal lb shares the same configurations as the external one. The internal lbs are not needed to be included in LoadBalancer list.
 */
@parentResource(ManagedCluster)
@added(Versions.v2025_10_02_preview)
model LoadBalancer
  is Azure.ResourceManager.ProxyResource<LoadBalancerProperties> {
  ...ResourceNameParameter<
    Resource = LoadBalancer,
    KeyName = "loadBalancerName",
    SegmentName = "loadBalancers",
    NamePattern = "^[a-z][a-z0-9]{0,11}$"
  >;
}

@armResourceOperations
@added(Versions.v2025_10_02_preview)
interface LoadBalancers {
  /**
   * Gets the specified load balancer.
   */
  get is ArmResourceRead<LoadBalancer>;

  /**
   * Creates or updates a load balancer in the specified managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<LoadBalancer>;

  /**
   * Deletes a load balancer in the specified managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    LoadBalancer,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of load balancers in the specified managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<LoadBalancer>;
}

@@maxLength(LoadBalancer.name, 12);
@@minLength(LoadBalancer.name, 1);
@@doc(LoadBalancer.name, "The name of the load balancer.");
@@doc(LoadBalancer.properties, "The properties of the load balancer.");
@@doc(LoadBalancers.createOrUpdate::parameters.resource,
  "The load balancer to create or update."
);
