import "./k8s.io/api/core/v1/types.tsp";
import "./k8s.io/apimachinery/apis/meta/v1/types.tsp";

using TypeSpec.Versioning;
using K8s.Io.Api.Core.V1;
using K8s.ApiMachinery.Apis.Meta.V1;

namespace Microsoft.ContainerService;

@added(Versions.v2025_03_02_naar)
@doc("ClusterResourcePlacementSpec defines the desired state of ClusterResourcePlacement.")
model ClusterResourcePlacementSpec {
  @doc("PlacementPolicy defines how to select member clusters to place the selected resources. If unspecified, all the joined member clusters are selected.")
  policy?: PlacementPolicy;
}

@added(Versions.v2025_03_02_naar)
@doc("PlacementPolicy contains the rules to select target member clusters to place the selected resources. Only clusters that are both joined and satisfying the rules will be selected. You can only specify at most one of the two fields: ClusterNames and Affinity.")
model PlacementPolicy {
  @doc("Type of placement. Default is PickAll.")
  placementType?: PlacementType;

  @doc("ClusterNames contains a list of names of MemberCluster to place the selected resources. Only valid if the placement type is PickFixed.")
  clusterNames?: string[];

  @doc("Affinity contains cluster affinity scheduling rules. Defines which member clusters to place the selected resources. Only valid if the placement type is PickAll.") // don't forget to update this when we add PickN.
  affinity?: Affinity;

  @doc("If specified, the ClusterClusterResourcePlacement's Tolerations. Tolerations cannot be updated or deleted.")
  @OpenAPI.extension("x-ms-identifiers", [])
  tolerations?: Toleration[];
}

@added(Versions.v2025_03_02_naar)
@doc("PlacementType identifies the type of placement.")
union PlacementType {
  @doc("PickAll selects all clusters that match the specified requirements.")
  PickAllPlacementType: "PickAll",

  @doc("PickFixed selects a fixed set of clusters")
  PickFixedPlacementType: "PickFixed",

  string,
}

@added(Versions.v2025_03_02_naar)
@doc("Affinity is a group of cluster affinity scheduling rules.")
model Affinity {
  @doc("ClusterAffinity contains cluster affinity scheduling rules for the selected resources.")
  clusterAffinity?: ClusterAffinity;
}

@added(Versions.v2025_03_02_naar)
@doc("ClusterAffinity contains cluster affinity scheduling rules for the selected resources.")
model ClusterAffinity {
  @doc("If any affinity requirements specified by this field are not met at scheduling time, the resource will not be scheduled onto the cluster.")
  requiredDuringSchedulingIgnoredDuringExecution?: ClusterSelector;
}
@added(Versions.v2025_03_02_naar)
@doc("ClusterSelector allows specifying cluster selector terms.")
model ClusterSelector {
  @doc("ClusterSelectorTerms is a list of cluster selector terms. The terms are `ORed`.")
  @OpenAPI.extension("x-ms-identifiers", [])
  clusterSelectorTerms: ClusterSelectorTerm[];
}

@added(Versions.v2025_03_02_naar)
@doc("ClusterSelectorTerm allows specifying what clusters in the fleet are in scope. If you specify both label and property selectors in the same term, the results are AND'd.")
model ClusterSelectorTerm {
  @doc("LabelSelector is a label query over all the joined member clusters. Clusters matching the query are selected.")
  labelSelector?: LabelSelector;

  @doc("PropertySelector is a property query over all joined member clusters. Clusters matching the query are selected.")
  propertySelector?: PropertySelector;
}

@added(Versions.v2025_03_02_naar)
@doc("PropertySelector helps user specify property requirements when picking clusters for resource placement.")
model PropertySelector {
  @doc("MatchExpressions is an array of PropertySelectorRequirements. The requirements are AND'd.")
  @OpenAPI.extension("x-ms-identifiers", [])
  matchExpressions: PropertySelectorRequirement[];
}

@added(Versions.v2025_03_02_naar)
@doc("PropertySelectorRequirement is a specific property requirement when picking clusters for resource placement.")
model PropertySelectorRequirement {
  @doc("Name is the name of the property.")
  name: string;

  @doc("Operator specifies the relationship between a cluster's observed value of the specified property and the values given in the requirement.")
  operator: PropertySelectorOperator;

  @doc("Values are a list of values of the specified property which Fleet will compare against the observed values of individual member clusters in accordance with the given operator.")
  values: string[];
}

@added(Versions.v2025_03_02_naar)
@doc("The possible operator values, which describe the relationship between a cluster’s observed value of the given property and the list of values in the matcher.")
union PropertySelectorOperator {
  @doc("Gt (Greater than): a cluster’s observed value of the given property must be greater than the value in the matcher before it can be picked for resource placement.")
  PropertySelectorGreaterThan: "Gt",

  @doc("Ge (Greater than or equal to): a cluster’s observed value of the given property must be greater than or equal to the value in the matcher before it can be picked for resource placement.")
  PropertySelectorGreaterThanOrEqualTo: "Ge",

  @doc("Eq (Equal to): a cluster’s observed value of the given property must be equal to the value in the matcher before it can be picked for resource placement.")
  PropertySelectorEqualTo: "Eq",

  @doc("Ne (Not equal to): a cluster’s observed value of the given property must be not equal to the value in the matcher before it can be picked for resource placement.")
  PropertySelectorNotEqualTo: "Ne",

  @doc("Lt (Less than): a cluster’s observed value of the given property must be less than the value in the matcher before it can be picked for resource placement.")
  PropertySelectorLessThan: "Lt",

  @doc("Le (Less than or equal to): a cluster’s observed value of the given property must be less than or equal to the value in the matcher before it can be picked for resource placement.")
  PropertySelectorLessThanOrEqualTo: "Le",

  string,
}

@added(Versions.v2025_03_02_naar)
@doc("Toleration allows ClusterResourcePlacement to tolerate any taint that matches <key,value,effect> using the matching operator <operator>")
model Toleration {
  @doc("Key is the taint key that the toleration applies to.Empty means match all taint keys.If the key is empty, operator must be 'Exists'; this combination means to match all values and all keys.")
  key?: string;

  @doc("Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Default is Equal. Exists is equivalent to wildcard for value, so that a ClusterResourcePlacement can tolerate all taints of a particular category.")
  operator?: TolerationOperator;

  @doc("Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.")
  value?: string;

  @doc("Effect indicates the taint effect to match. Empty means match all taint effects. When specified, only allowed value is NoSchedule.")
  effect?: TaintEffect;
}
