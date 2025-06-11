// cspell:ignore naar kubefleet NoSchedule
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;

@doc("A fleet managed namespace.")
@resource("managedNamespaces")
@added(Versions.v2025_03_02_naar)
@parentResource(Fleet)
model FleetManagedNamespace
  is TrackedResource<FleetManagedNamespaceProperties> {
  @doc("The name of the fleet managed namespace resource.")
  @key("fleetManagedNamespaceName")
  @segment("fleetManagedNamespaces")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @path
  @visibility("create", "read")
  name: string;

  ...EntityTagProperty;

  /* The ARM tags of the fleet managed namespace resource.*/
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

@doc("Action if Kubernetes managed namespace with the same name already exists.")
union AdoptionPolicy {
  @doc("If k8s managed namespace already exists, do not take over the existing managed namespace to be managed by ARM.")
  Never: "Never",

  @doc("If there is an identical managed namespace, take over the existing managed namespace to be managed by ARM.")
  IfIdentical: "IfIdentical",

  @doc("Always take over the existing managed namespace to be managed by ARM, even if it is not identical.")
  Always: "Always",

  string,
}

@doc("Delete options of a managed namespace.")
union DeletePolicy {
  @doc("Delete ARM resource but keep k8s managed namespace.")
  Keep: "Keep",

  @doc("Delete both ARM resource and k8s managed namespace.")
  Delete: "Delete",

  string,
}

@doc("The provisioning state of the fleet managed namespace resource")
union FleetManagedNamespaceProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The provisioning state of a fleet managed namespace being created.")
  Creating: "Creating",

  @doc("The provisioning state of a fleet managed namespace being updated.")
  Updating: "Updating",

  @doc("The provisioning state of a fleet managed namespace being deleted.")
  Deleting: "Deleting",
}

@doc("The resource quota for a managed namespace.")
model ResourceQuota {
  @doc("The CPU request for the managed namespace.")
  cpuRequest?: string;

  @doc("The CPU limit for the managed namespace.")
  cpuLimit?: string;

  @doc("The memory request for the managed namespace.")
  memoryRequest?: string;

  @doc("The memory limit for the managed namespace.")
  memoryLimit?: string;
}

@doc("The network policy for a managed namespace.")
model NetworkPolicy {
  @doc("The ingress policy for the managed namespace.")
  ingress?: PolicyRule;

  @doc("The egress policy for the managed namespace.")
  egress?: PolicyRule;
}

@doc("The ingress policy options for a managed namespace.")
union IngressPolicy {
  @doc("Allow all ingress traffic to the managed namespace.")
  AllowAll: "AllowAll",

  @doc("Deny all ingress traffic to the managed namespace.")
  DenyAll: "DenyAll",

  string,
}

@doc("The egress policy options for a managed namespace.")
union EgressPolicy {
  @doc("Allow all egress traffic from the managed namespace.")
  AllowAll: "AllowAll",

  @doc("Deny all egress traffic from the managed namespace")
  DenyAll: "DenyAll",

  string,
}

@doc("The possible values representing different network policy rules.")
union PolicyRule {
  @doc("Allow all network traffic.")
  AllowAll: "AllowAll",

  @doc("Deny all network traffic.")
  DenyAll: "DenyAll",

  @doc("Allow traffic within the same namespace.")
  AllowSameNamespace: "AllowSameNamespace",

  string,
}

@added(Versions.v2025_03_02_naar)
@doc("The orchestrator profile to manage the lifecycle of the namespace.")
model OrchestratorProfile {
  @doc("The type of the policy to be used.")
  type: OrchestratorProfileType;

  @doc("The policy configuration for the type of the orchestrator.")
  policy: OrchestratorPolicy;
}

@added(Versions.v2025_03_02_naar)
@doc("The type of the namespace orchestrator.")
union OrchestratorProfileType {
  @doc("Using a fleet hub and kubefleet ClusterResourcePlacement.")
  Hub: "Hub",

  string,
}

@added(Versions.v2025_03_02_naar)
@doc("The available orchestrator type.")
union OrchestratorPolicy {
  @doc("The Hub Orchestrator.")
  hubPolicy: HubPolicy,
}

@added(Versions.v2025_03_02_naar)
@doc("HubPolicy uses a fleet hub and CRP to propagate the namespace.")
model HubPolicy {
  @doc("The default ClusterResourcePlacement (CRP) policy configuration.")
  defaultClusterResourcePlacement: ClusterResourcePlacement;
}

@added(Versions.v2025_03_02_naar)
@doc("The desired state of ClusterResourcePlacement")
model ClusterResourcePlacement {
  @doc("Policy defines how to select member clusters to place the selected resources. If unspecified, all the joined member clusters are selected.")
  policy?: ClusterResourcePlacementPolicy;
}

@added(Versions.v2025_03_02_naar)
@doc("ClusterResourcePlacementPolicy contains the rules to select target member clusters to place the selected resources. Only clusters that are both joined and satisfying the rules will be selected. You can only specify at most one of the two fields: ClusterNames and Affinity.")
model ClusterResourcePlacementPolicy {
  @doc("Type of placement.")
  placementType?: PlacementType;

  @doc("ClusterNames contains a list of names of MemberCluster to place the selected resources. Only valid if the placement type is PickFixed.")
  clusterNames?: string[];

  @doc("Affinity contains cluster affinity scheduling rules. Defines which member clusters to place the selected resources. Only valid if the placement type is PickAll.") // don't forget to update this when we add PickN.
  affinity?: ClusterResourcePlacementAffinity;

  @doc("If specified, the ClusterResourcePlacement's Tolerations. Tolerations cannot be updated or deleted.")
  @OpenAPI.extension("x-ms-identifiers", [])
  tolerations?: CrpToleration[];
}

@added(Versions.v2025_03_02_naar)
@doc("PlacementType identifies the type of placement.")
union PlacementType {
  @doc("PickAll selects all clusters that match the specified requirements.")
  PickAll: "PickAll",

  @doc("PickFixed selects a fixed set of clusters")
  PickFixed: "PickFixed",

  string,
}

@added(Versions.v2025_03_02_naar)
@doc("ClusterResourcePlacementAffinity is a group of cluster affinity scheduling rules.")
model ClusterResourcePlacementAffinity {
  @doc("ClusterAffinity contains cluster affinity scheduling rules for the selected resources.")
  clusterAffinity?: ClusterResourcePlacementClusterAffinity;
}

@added(Versions.v2025_03_02_naar)
@doc("ClusterAffinity contains cluster affinity scheduling rules for the selected resources.")
model ClusterResourcePlacementClusterAffinity {
  @doc("If any affinity requirements specified by this field are not met at scheduling time, the resource will not be scheduled onto the cluster.")
  requiredDuringSchedulingIgnoredDuringExecution?: CrpClusterSelector;
}
@added(Versions.v2025_03_02_naar)
@doc("CrpClusterSelector allows specifying cluster selector terms.")
model CrpClusterSelector {
  @doc("ClusterSelectorTerms is a list of cluster selector terms. The terms are `ORed`.")
  @OpenAPI.extension("x-ms-identifiers", [])
  clusterSelectorTerms: CrpClusterSelectorTerm[];
}

@added(Versions.v2025_03_02_naar)
@doc("CrpClusterSelectorTerm allows specifying what clusters in the fleet are in scope. If you specify both label and property selectors in the same term, the results are AND'd.")
model CrpClusterSelectorTerm {
  @doc("LabelSelector is a label query over all the joined member clusters. Clusters matching the query are selected.")
  labelSelector?: MetaV1ClusterLabelSelector;

  @doc("PropertySelector is a property query over all joined member clusters. Clusters matching the query are selected.")
  propertySelector?: CrpClusterPropertySelector;
}

@added(Versions.v2025_03_02_naar)
@doc("A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.")
model MetaV1ClusterLabelSelector {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("matchLabels is a map of {key,value} pairs.")
  matchLabels?: Record<string>;

  @doc("matchExpressions is a list of label selector requirements. The requirements are ANDed.")
  @OpenAPI.extension("x-ms-identifiers", [])
  matchExpressions?: MetaV1LabelSelectorRequirement[];
}

@added(Versions.v2025_03_02_naar)
@doc("A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.")
model MetaV1LabelSelectorRequirement {
  @doc("key is the label key that the selector applies to.")
  key: string;

  @doc("operator represents a key's relationship to a set of values.")
  operator: MetaV1LabelSelectorOperator;

  @doc("values is an array of string values to be compared using the operator.")
  values?: string[];
}

@added(Versions.v2025_03_02_naar)
@doc("A label selector operator is the set of operators that can be used in a selector requirement.")
union MetaV1LabelSelectorOperator {
  @doc("In validates whether the key is in the list of values.")
  In: "In",

  @doc("NotIn validates whether the key is not in the list of values.")
  NotIn: "NotIn",

  @doc("Exists validates the existence of the key.")
  Exists: "Exists",

  @doc("DoesNotExists validates the absence of the key.")
  DoesNotExist: "DoesNotExist",

  string,
}

@added(Versions.v2025_03_02_naar)
@doc("PropertySelector helps user specify property requirements when picking clusters for resource placement.")
model CrpClusterPropertySelector {
  @doc("MatchExpressions is an array of CRPPropertySelectorRequirements. The requirements are AND'd.")
  @OpenAPI.extension("x-ms-identifiers", [])
  matchExpressions: CrpClusterPropertySelectorRequirement[];
}

@added(Versions.v2025_03_02_naar)
@doc("PropertySelectorRequirement is a specific property requirement when picking clusters for resource placement.")
model CrpClusterPropertySelectorRequirement {
  @doc("Name is the name of the property.")
  name: string;

  @doc("Operator specifies the relationship between a cluster's observed value of the specified property and the values given in the requirement.")
  operator: CrpPropertySelectorOperator;

  @doc("Values are a list of values of the specified property which Fleet will compare against the observed values of individual member clusters in accordance with the given operator.")
  values: string[];
}

@added(Versions.v2025_03_02_naar)
@doc("The possible operator values, which describe the relationship between a cluster’s observed value of the given property and the list of values in the matcher.")
union CrpPropertySelectorOperator {
  @doc("Gt (Greater than): a cluster’s observed value of the given property must be greater than the value in the matcher before it can be picked for resource placement.")
  Gt: "Gt",

  @doc("Ge (Greater than or equal to): a cluster’s observed value of the given property must be greater than or equal to the value in the matcher before it can be picked for resource placement.")
  Ge: "Ge",

  @doc("Eq (Equal to): a cluster’s observed value of the given property must be equal to the value in the matcher before it can be picked for resource placement.")
  Eq: "Eq",

  @doc("Ne (Not equal to): a cluster’s observed value of the given property must be not equal to the value in the matcher before it can be picked for resource placement.")
  Ne: "Ne",

  @doc("Lt (Less than): a cluster’s observed value of the given property must be less than the value in the matcher before it can be picked for resource placement.")
  Lt: "Lt",

  @doc("Le (Less than or equal to): a cluster’s observed value of the given property must be less than or equal to the value in the matcher before it can be picked for resource placement.")
  Le: "Le",

  string,
}

@added(Versions.v2025_03_02_naar)
@doc("Toleration allows ClusterResourcePlacement to tolerate any taint that matches <key,value,effect> using the matching operator <operator>")
model CrpToleration {
  @doc("Key is the taint key that the toleration applies to.")
  key?: string;

  @doc("Operator represents a key's relationship to the value. Default is Equal.")
  operator?: CoreV1TolerationOperator;

  @doc("Value is the taint value the toleration matches to.")
  value?: string;

  @doc("Effect indicates the taint effect to match. Empty means match all taint effects.")
  effect?: CoreV1TaintEffect;
}

@doc("The available operator for the Toleration section.")
union CoreV1TolerationOperator {
  @doc("Operator that checks for existence.")
  Exists: "Exists",

  @doc("Operator that checks for equality.")
  Equal: "Equal",

  string,
}

@doc("The available taint effect for the Toleration section")
union CoreV1TaintEffect {
  @doc("The NoSchedule taint effect.")
  NoSchedule: "NoSchedule",

  string,
}

@added(Versions.v2025_03_02_naar)
@doc("Status information for the fleet managed namespace.")
model FleetManagedNamespaceStatus {
  @visibility("read")
  @doc("The last operation ID for the fleet managed namespace")
  lastOperationId?: string;

  @visibility("read")
  @doc("The last operation error of the fleet managed namespace")
  lastOperationError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("A fleet managed namespace.")
@added(Versions.v2025_03_02_naar)
model FleetManagedNamespaceProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The labels for the fleet managed namespace.")
  labels?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The annotations for the fleet managed namespace.")
  annotations?: Record<string>;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: FleetManagedNamespaceProvisioningState;

  @doc("The default resource quota for the fleet managed namespace.")
  defaultResourceQuota?: ResourceQuota;

  @doc("The default network policy for the fleet managed namespace.")
  defaultNetworkPolicy?: NetworkPolicy;

  @doc("Action if Kubernetes managed namespace with the same name already exists.")
  adoptionPolicy?: AdoptionPolicy;

  @doc("Delete options of a fleet managed namespace.")
  deletePolicy?: DeletePolicy;

  @doc("The profile of the orchestrator to create the namespace.")
  orchestratorProfile: OrchestratorProfile;

  @visibility("read")
  @doc("Status information of the last operation for fleet managed namespace.")
  status?: FleetManagedNamespaceStatus;
}

@added(Versions.v2025_03_02_naar)
@armResourceOperations
interface FleetManagedNamespaces {
  get is ArmResourceRead<FleetManagedNamespace>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetManagedNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<FleetManagedNamespace> &
      IfMatchParameters<FleetManagedNamespace> &
      IfNoneMatchParameters<FleetManagedNamespace>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    FleetManagedNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<FleetManagedNamespace> &
      IfMatchParameters<FleetManagedNamespace>
  >;

  listByFleet is ArmResourceListByParent<FleetManagedNamespace>;
}
