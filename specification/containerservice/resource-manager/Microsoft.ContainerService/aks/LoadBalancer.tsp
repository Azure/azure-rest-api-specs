import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// LoadBalancer resource and operations
// =============================================================================

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

@@maxLength(LoadBalancer.name, 12);
@@minLength(LoadBalancer.name, 1);
@@doc(LoadBalancer.name, "The name of the load balancer.");
@@doc(LoadBalancer.properties, "The properties of the load balancer.");
@@doc(LoadBalancers.createOrUpdate::parameters.resource,
  "The load balancer to create or update."
);

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

// =============================================================================
// LoadBalancer models
// =============================================================================

/**
 * operator represents a key's relationship to a set of values. Valid operators are In and NotIn
 */
@added(Versions.v2025_10_02_preview)
union Operator {
  string,

  /**
   * The value of the key should be in the given list.
   */
  In: "In",

  /**
   * The value of the key should not be in the given list.
   */
  NotIn: "NotIn",

  /**
   * The value of the key should exist.
   */
  Exists: "Exists",

  /**
   * The value of the key should not exist.
   */
  DoesNotExist: "DoesNotExist",
}

/** Properties for a load balancer resource. */
@added(Versions.v2025_10_02_preview)
model LoadBalancerProperties {
  /**
   * Required field. A string value that must specify the ID of an existing agent pool. All nodes in the given pool will always be added to this load balancer. This agent pool must have at least one node and minCount>=1 for autoscaling operations. An agent pool can only be the primary pool for a single load balancer.
   */
  primaryAgentPoolName: string;

  /**
   * Whether to automatically place services on the load balancer. If not supplied, the default value is true. If set to false manually, both of the external and the internal load balancer will not be selected for services unless they explicitly target it.
   */
  allowServicePlacement?: boolean;

  /**
   * Only services that must match this selector can be placed on this load balancer.
   */
  serviceLabelSelector?: LabelSelector;

  /**
   * Services created in namespaces that match the selector can be placed on this load balancer.
   */
  serviceNamespaceSelector?: LabelSelector;

  /**
   * Nodes that match this selector will be possible members of this load balancer.
   */
  nodeSelector?: LabelSelector;

  /**
   * The current provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.
 */
@added(Versions.v2025_10_02_preview)
model LabelSelector {
  /**
   * matchLabels is an array of {key=value} pairs. A single {key=value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is `key`, the operator is `In`, and the values array contains only `value`. The requirements are ANDed.
   */
  matchLabels?: string[];

  /**
   * matchExpressions is a list of label selector requirements. The requirements are ANDed.
   */
  @identifiers(#[])
  matchExpressions?: LabelSelectorRequirement[];
}

/**
 * A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.
 */
@added(Versions.v2025_10_02_preview)
model LabelSelectorRequirement {
  /**
   * key is the label key that the selector applies to.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;

  /**
   * operator represents a key's relationship to a set of values. Valid operators are In and NotIn
   */
  operator?: Operator;

  /**
   * values is an array of string values, the values array must be non-empty.
   */
  values?: string[];
}

/**
 * The names of the load balancers to rebalance. If set to empty, all load balancers will be rebalanced.
 */
@added(Versions.v2025_10_02_preview)
model RebalanceLoadBalancersRequestBody {
  /**
   * The load balancer names list.
   */
  loadBalancerNames?: string[];
}
