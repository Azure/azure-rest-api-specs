import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../../../../k8s.io/api/core/v1/types.tsp";
import "../../../../k8s.io/apimachinery/apis/meta/v1/types.tsp";

using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Core.V1;
using Meta.V1;
using Azure.ResourceManager;

namespace Placement.V1;

@doc("The rollout strategy configuration.")
model RolloutStrategy {
  @madeOptional(Microsoft.ContainerService.Versions.v2026_04_02_preview)
  @doc("The type of rollout strategy. Default is RollingUpdate.")
  type?: RolloutStrategyType;
}

@doc("The possible rollout strategy types.")
union RolloutStrategyType {
  @doc("Use rolling update strategy for rollout.")
  RollingUpdate: "RollingUpdate",

  @doc("Use external rollout strategy managed outside of Fleet.")
  External: "External",

  string,
}

@added(Microsoft.ContainerService.Versions.v2026_04_02_preview)
@doc("UpdateRunStrategySpec defines a reusable strategy that specifies the stages and the sequence in which the selected cluster resources will be updated on the member clusters.")
model UpdateRunStrategySpec {
  @doc("Stages specifies the configuration for each update stage. Maximum of 31 stages allowed.")
  @maxItems(31)
  stages?: StageConfig[];
}

@added(Microsoft.ContainerService.Versions.v2026_04_02_preview)
@doc("StageConfig describes a single update stage. The clusters in each stage are updated sequentially. The update stops if any of the updates fail.")
model StageConfig {
  @doc("The name of the stage. This MUST be unique within the same UpdateRunStrategySpec.")
  @maxLength(63)
  @pattern("^[a-z0-9]+$")
  name: string;

  @doc("LabelSelector is a label query over all the joined member clusters. Clusters matching the query are selected for this stage. There cannot be overlapping clusters between stages when the update run is created. If the label selector is empty, the stage includes all the selected clusters. If the label selector is nil, the stage does not include any selected clusters.")
  labelSelector?: LabelSelector;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark this property with @secret if the contents should be kept private."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME:  If this is a real secret, mark with @secret"
  @OpenAPI.extension("x-ms-secret", false)
  @doc("The label key used to sort the selected clusters. The clusters within the stage are updated sequentially following the rule below: 1) Ascending order based on the value of the label key, interpreted as integers if present. 2) Ascending order based on the name of the cluster if the label key is absent or the label value is the same.")
  sortingLabelKey?: string;

  @doc("MaxConcurrency specifies the maximum number of clusters that can be updated concurrently within this stage. Value can be an absolute number (ex: 5) or a percentage of the total clusters in the stage (ex: 50%). Fractional results are rounded down. A minimum of 1 update is enforced. If not specified, all clusters in the stage are updated sequentially (effectively maxConcurrency = 1). Integer values must be at least 1. Percentage values must match pattern ^(100|[1-9][0-9]?)%$. Defaults to 1.")
  maxConcurrency?: string;

  @doc("The collection of tasks that each stage needs to complete successfully before moving to the next stage. Each task is executed in parallel and there cannot be more than one task of the same type. Maximum 2 tasks allowed.")
  @maxItems(2)
  @identifiers(#[])
  afterStageTasks?: StageTask[];

  @doc("The collection of tasks that needs to be completed successfully by each stage before starting the stage. Each task is executed in parallel and there cannot be more than one task of the same type. Maximum 1 task allowed.")
  @maxItems(1)
  @identifiers(#[])
  beforeStageTasks?: StageTask[];
}

@added(Microsoft.ContainerService.Versions.v2026_04_02_preview)
@doc("StageTask is the pre or post stage task that needs to be completed before starting or moving to the next stage.")
model StageTask {
  @doc("The type of the before or after stage task.")
  type: StageTaskType;

  @doc("The time to wait after all the clusters in the current stage complete the update before moving to the next stage. Format is duration string (e.g., '30s', '5m', '2h'). Pattern must match: ^0|([0-9]+(\\.[0-9]+)?(s|m|h))+$. Only valid when type is TimedWait. Required for TimedWait, not allowed for Approval.")
  @pattern("^0|([0-9]+(\\.[0-9]+)?(s|m|h))+$")
  waitTime?: string;
}

@added(Microsoft.ContainerService.Versions.v2026_04_02_preview)
@doc("StageTaskType identifies a specific type of the AfterStageTask or BeforeStageTask.")
union StageTaskType {
  @doc("TimedWait indicates the stage task is a timed wait.")
  TimedWait: "TimedWait",

  @doc("Approval indicates the stage task is an approval.")
  Approval: "Approval",

  string,
}

@doc("ClusterResourcePlacementSpec defines the desired state of ClusterResourcePlacement.")
model ClusterResourcePlacementSpec {
  @doc("Policy defines how to select member clusters to place the selected resources. If unspecified, all the joined member clusters are selected.")
  policy?: PlacementPolicy;

  @added(Microsoft.ContainerService.Versions.v2026_04_02_preview)
  @doc("The rollout strategy configuration for the cluster resource placement. This field is added in version 2026-04-02-preview.")
  rolloutStrategy?: RolloutStrategy;
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
  @madeOptional(Microsoft.ContainerService.Versions.v2026_04_02_preview)
  @doc("ClusterSelectorTerms is a list of cluster selector terms. The terms are `ORed`.")
  @identifiers(#[])
  clusterSelectorTerms?: ClusterSelectorTerm[];
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
