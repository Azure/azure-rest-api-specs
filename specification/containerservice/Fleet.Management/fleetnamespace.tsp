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
  ingress?: IngressPolicy;

  @doc("The egress policy for the managed namespace.")
  egress?: EgressPolicy;
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

@doc("The profile of the fleet managed namespace.")
@added(Versions.v2025_03_02_naar)
model FleetManagedNamespaceProfile {
  @doc("Action if Kubernetes managed namespace with the same name already exists.")
  adoptionPolicy?: AdoptionPolicy;

  @doc("Delete options of a fleet managed namespace.")
  deletePolicy?: DeletePolicy;

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
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: FleetManagedNamespaceProvisioningState;

  @visibility("read")
  @doc("The profile of the fleet managed namespace.")
  fleetManagedNamespaceProfile?: FleetManagedNamespaceProfile;

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
