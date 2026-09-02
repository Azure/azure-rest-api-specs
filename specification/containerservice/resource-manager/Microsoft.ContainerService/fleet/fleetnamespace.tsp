import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./helpers.tsp";
import "./kubefleet/apis/placement/v1/types.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Placement.V1;

namespace Microsoft.ContainerService;

@doc("A fleet managed namespace.")
@resource("managedNamespaces")
@added(Versions.v2025_08_01_preview)
@parentResource(Fleet)
model FleetManagedNamespace
  is TrackedResource<FleetManagedNamespaceProperties> {
  @doc("The name of the fleet managed namespace resource.")
  @key("managedNamespaceName")
  @segment("managedNamespaces")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @path
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("The properties of a fleet managed namespace.")
@added(Versions.v2025_08_01_preview)
model FleetManagedNamespaceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: FleetManagedNamespaceProvisioningState;

  @doc("The namespace properties for the fleet managed namespace.")
  managedNamespaceProperties?: ManagedNamespaceProperties;

  @doc("Action if the managed namespace with the same name already exists. Default is Never.")
  adoptionPolicy: AdoptionPolicy;

  @doc("Delete options of a fleet managed namespace. Default is Keep.")
  deletePolicy: DeletePolicy;

  @doc("The profile of the propagation to create the namespace.")
  propagationPolicy?: PropagationPolicy;

  @visibility(Lifecycle.Read)
  @doc("Status information of the last operation for fleet managed namespace.")
  status?: FleetManagedNamespaceStatus;

  @visibility(Lifecycle.Read)
  @doc("The Azure Portal FQDN of the Fleet hub.")
  portalFqdn?: string;
}

@added(Versions.v2025_08_01_preview)
@doc("Status information for the fleet managed namespace.")
model FleetManagedNamespaceStatus {
  @visibility(Lifecycle.Read)
  @doc("The last operation ID for the fleet managed namespace")
  lastOperationId?: string;

  @visibility(Lifecycle.Read)
  @doc("The last operation error of the fleet managed namespace")
  lastOperationError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("The namespace properties for the fleet managed namespace.")
@added(Versions.v2025_08_01_preview)
model ManagedNamespaceProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The labels for the fleet managed namespace.")
  labels?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The annotations for the fleet managed namespace.")
  annotations?: Record<string>;

  @doc("The default resource quota for the fleet managed namespace.")
  defaultResourceQuota?: ResourceQuota;

  @doc("The default network policy for the fleet managed namespace.")
  defaultNetworkPolicy?: NetworkPolicy;
}

@doc("The resource quota for the managed namespace.")
@added(Versions.v2025_08_01_preview)
model ResourceQuota {
  @doc("The CPU request for the managed namespace. See more at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu")
  cpuRequest?: string;

  @doc("The CPU limit for the managed namespace. See more at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu")
  cpuLimit?: string;

  @doc("The memory request for the managed namespace. See more at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory")
  memoryRequest?: string;

  @doc("The memory limit for the managed namespace. See more at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory")
  memoryLimit?: string;
}

@doc("The network policy for the managed namespace.")
@added(Versions.v2025_08_01_preview)
model NetworkPolicy {
  @doc("The ingress policy for the managed namespace.")
  ingress?: PolicyRule;

  @doc("The egress policy for the managed namespace.")
  egress?: PolicyRule;
}

@doc("The possible values representing different network policy rules.")
@added(Versions.v2025_08_01_preview)
union PolicyRule {
  @doc("Allow all network traffic.")
  AllowAll: "AllowAll",

  @doc("Deny all network traffic.")
  DenyAll: "DenyAll",

  @doc("Allow traffic within the same namespace.")
  AllowSameNamespace: "AllowSameNamespace",

  string,
}

@doc("Action if the Namespace with the same name already exists.")
@added(Versions.v2025_08_01_preview)
union AdoptionPolicy {
  @doc("If the Namespace already exists, do not take over the existing Namespace to be managed by ARM.")
  Never: "Never",

  @doc("If there is an identical Namespace, take over the existing Namespace to be managed by ARM.")
  IfIdentical: "IfIdentical",

  @doc("Always take over the existing Namespace to be managed by ARM, even if it is not identical.")
  Always: "Always",

  string,
}

@doc("Delete options for the ARM managed namespace.")
@added(Versions.v2025_08_01_preview)
union DeletePolicy {
  @doc("Delete the ARM resource but keep the Namespace.")
  Keep: "Keep",

  @doc("Delete both ARM resource and Namespace.")
  Delete: "Delete",

  string,
}

@added(Versions.v2025_08_01_preview)
@doc("The propagation to be used for provisioning the namespace among the fleet.")
model PropagationPolicy {
  @doc("The type of the policy to be used. Default is Placement.")
  type: PropagationType;

  @doc("The profile to be used for propagation via placement.")
  placementProfile?: PlacementProfile;
}

@added(Versions.v2025_08_01_preview)
@doc("How the namespace will be provisioned among the fleet members.")
union PropagationType {
  @doc("Using ClusterResourcePlacement.")
  Placement: "Placement",

  string,
}

@added(Versions.v2025_08_01_preview)
@doc("The configuration profile for default ClusterResourcePlacement for placement.")
model PlacementProfile {
  @doc("The default ClusterResourcePlacement policy configuration.")
  defaultClusterResourcePlacement?: ClusterResourcePlacementSpec;
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

@added(Versions.v2025_08_01_preview)
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

  update is ArmCustomPatchAsync<
    FleetManagedNamespace,
    FleetManagedNamespacePatch,
    Azure.ResourceManager.Foundations.BaseParameters<FleetManagedNamespace> &
      IfMatchParameters<FleetManagedNamespace>
  >;
}

@added(Versions.v2025_08_01_preview)
@doc("The properties of a fleet managed namespace that can be patched.")
model FleetManagedNamespacePatch {
  /* The ARM tags of the fleet managed namespace resource.*/
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
