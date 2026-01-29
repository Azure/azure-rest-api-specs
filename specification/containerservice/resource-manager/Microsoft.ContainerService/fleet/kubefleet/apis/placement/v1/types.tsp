import "@azure-tools/typespec-azure-resource-manager";
import "../../../../k8s.io/api/core/v1/types.tsp";
import "../../../../k8s.io/apimachinery/apis/meta/v1/types.tsp";

using TypeSpec.Versioning;
using Core.V1;
using Meta.V1;
using Azure.ResourceManager;

namespace Placement.V1;

@doc("ClusterResourcePlacementSpec defines the desired state of ClusterResourcePlacement.")
model ClusterResourcePlacementSpec {
  @doc("Policy defines how to select member clusters to place the selected resources. If unspecified, all the joined member clusters are selected.")
  policy?: PlacementPolicy;
}

@doc("PlacementPolicy contains the rules to select target member clusters to place the selected resources. Note that only clusters that are both joined and satisfying the rules will be selected. You can only specify at most one of the two fields: ClusterNames and Affinity. If none is specified, all the joined clusters are selected.")
model PlacementPolicy {
  @doc("Type of placement. Can be \"PickAll\", \"PickN\" or \"PickFixed\". Default is PickAll.")
  placementType?: PlacementType;

  @doc("ClusterNames contains a list of names of MemberCluster to place the selected resources. Only valid if the placement type is \"PickFixed\"")
  clusterNames?: string[];

  @doc("Affinity contains cluster affinity scheduling rules. Defines which member clusters to place the selected resources. Only valid if the placement type is \"PickAll\" or \"PickN\".")
  affinity?: Affinity;

  @doc("If specified, the ClusterResourcePlacement's Tolerations. Tolerations cannot be updated or deleted. This field is beta-level and is for the taints and tolerations feature.")
  @identifiers(#[])
  tolerations?: Toleration[];
}

@doc("PlacementType identifies the type of placement.")
union PlacementType {
  @doc("PickAll picks all clusters that satisfy the rules.")
  PickAll: "PickAll",

  @doc("PickFixed picks a fixed set of clusters.")
  PickFixed: "PickFixed",

  string,
}

@doc("Affinity is a group of cluster affinity scheduling rules. More to be added.")
model Affinity {
  @doc("ClusterAffinity contains cluster affinity scheduling rules for the selected resources.")
  clusterAffinity?: ClusterAffinity;
}

@doc("ClusterAffinity contains cluster affinity scheduling rules for the selected resources.")
model ClusterAffinity {
  @doc("If the affinity requirements specified by this field are not met at scheduling time, the resource will not be scheduled onto the cluster. If the affinity requirements specified by this field cease to be met at some point after the placement (e.g. due to an update), the system may or may not try to eventually remove the resource from the cluster.")
  requiredDuringSchedulingIgnoredDuringExecution?: ClusterSelector;
}

@doc("ClusterSelector")
model ClusterSelector {
  @doc("ClusterSelectorTerms is a list of cluster selector terms. The terms are `ORed`.")
  @identifiers(#[])
  clusterSelectorTerms: ClusterSelectorTerm[];
}

@doc("ClusterSelectorTerm")
model ClusterSelectorTerm {
  @doc("LabelSelector is a label query over all the joined member clusters. Clusters matching the query are selected. If you specify both label and property selectors in the same term, the results are AND'd.")
  labelSelector?: LabelSelector;

  @doc("PropertySelector is a property query over all joined member clusters. Clusters matching the query are selected. If you specify both label and property selectors in the same term, the results are AND'd. At this moment, PropertySelector can only be used with `RequiredDuringSchedulingIgnoredDuringExecution` affinity terms. This field is beta-level; it is for the property-based scheduling feature and is only functional when a property provider is enabled in the deployment.")
  propertySelector?: PropertySelector;
}

@doc("PropertySelector helps user specify property requirements when picking clusters for resource placement.")
model PropertySelector {
  @doc("MatchExpressions is an array of PropertySelectorRequirements. The requirements are AND'd.")
  matchExpressions: PropertySelectorRequirement[];
}

@doc("PropertySelectorRequirement is a specific property requirement when picking clusters for resource placement.")
model PropertySelectorRequirement {
  @doc("Name is the name of the property; it should be a Kubernetes label name.")
  name: string;

  @doc("Operator specifies the relationship between a cluster's observed value of the specified property and the values given in the requirement.")
  operator: PropertySelectorOperator;

  @doc("Values are a list of values of the specified property which Fleet will compare against the observed values of individual member clusters in accordance with the given operator. At this moment, each value should be a Kubernetes quantity. For more information, see https://pkg.go.dev/k8s.io/apimachinery/pkg/api/resource#Quantity. If the operator is Gt (greater than), Ge (greater than or equal to), Lt (less than), or `Le` (less than or equal to), Eq (equal to), or Ne (ne), exactly one value must be specified in the list.")
  values: string[];
}

@doc("PropertySelectorOperator is the operator that can be used with PropertySelectorRequirements.")
union PropertySelectorOperator {
  @doc("Gt dictates Fleet to select cluster if its observed value of a given property is greater than the value specified in the requirement.")
  Gt: "Gt",

  @doc("Ge dictates Fleet to select cluster if its observed value of a given property is greater than or equal to the value specified in the requirement.")
  Ge: "Ge",

  @doc("Eq dictates Fleet to select cluster if its observed value of a given property is equal to the values specified in the requirement.")
  Eq: "Eq",

  @doc("Ne dictates Fleet to select cluster if its observed value of a given property is not equal to the values specified in the requirement.")
  Ne: "Ne",

  @doc("Lt dictates Fleet to select cluster if its observed value of a given property is less than the value specified in the requirement.")
  Lt: "Lt",

  @doc("Le dictates Fleet to select cluster if its observed value of a given property is less than or equal to the value specified in the requirement.")
  Le: "Le",

  string,
}

@doc("Toleration allows ClusterResourcePlacement to tolerate any taint that matches the triple <key,value,effect> using the matching operator <operator>.")
model Toleration {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "This key is not sensitive; it's a taint key identifier in Kubernetes tolerations."
  @doc("Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.")
  key?: string;

  @doc("Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a ClusterResourcePlacement can tolerate all taints of a particular category.")
  operator?: TolerationOperator;

  @doc("Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.")
  value?: string;

  @doc("Effect indicates the taint effect to match. Empty means match all taint effects. When specified, only allowed value is NoSchedule.")
  effect?: TaintEffect;
}
