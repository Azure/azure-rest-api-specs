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

@doc("A fleet namespace.")
@resource("namespaces")
@added(Versions.v2025_03_01_naar)
@parentResource(Fleet)
model FleetNamespace is TrackedResource<FleetNamespaceProperties> {
  @doc("The name of the fleet namespace resource.")
  @key("fleetNamespaceName")
  @segment("fleetNamespaces")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @path
  @visibility("create", "read")
  name: string;

  ...EntityTagProperty;
}

@doc("Action if Kubernetes namespace with the same name already exists.")
union AdoptionPolicy {
  @doc("If k8s namespace already exists, do not take over the existing namespace to be managed by ARM.")
  Never: "Never",

  @doc("If there is an identical namespace, take over the existing namespace to be managed by ARM.")
  IfIdentical: "IfIdentical",

  @doc("Always take over the existing namespace to be managed by ARM, even if it is not identical.")
  Always: "Always",

  string,
}

@doc("Delete options of a namespace.")
union DeletePolicy {
  @doc("Delete ARM resource but keep k8s namespace.")
  Keep: "Keep",

  @doc("Delete both ARM resource and k8s namespace.")
  Delete: "Delete",

  string,
}

@doc("The provisioning state of the fleet namespace resource")
union FleetNamespaceProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The provisioning state of a fleet namespace being created.")
  Creating: "Creating",

  @doc("The provisioning state of a fleet namespace being updated.")
  Updating: "Updating",

  @doc("The provisioning state of a fleet namespace being deleted.")
  Deleting: "Deleting",
}

@doc("The resource quota for a namespace.")
model ResourceQuota {
  @doc("The CPU request for the namespace.")
  cpuRequest?: string;

  @doc("The CPU limit for the namespace.")
  cpuLimit?: string;

  @doc("The memory request for the namespace.")
  memoryRequest?: string;

  @doc("The memory limit for the namespace.")
  memoryLimit?: string;
}

@doc("The network policy for a namespace.")
model NetworkPolicy {
  @doc("The ingress policy for the namespace.")
  ingress?: IngressPolicy;

  @doc("The egress policy for the namespace.")
  egress?: EgressPolicy;
}

@doc("The ingress policy options for a namespace.")
union IngressPolicy {
  @doc("Allow all ingress traffic to the namespace.")
  AllowAll: "AllowAll",

  @doc("Deny all ingress traffic to the namespace.")
  DenyAll: "DenyAll",

  string,
}

@doc("The egress policy options for a namespace.")
union EgressPolicy {
  @doc("Allow all egress traffic from the namespace.")
  AllowAll: "AllowAll",

  @doc("Deny all egress traffic from the namespace")
  DenyAll: "DenyAll",

  string,
}

@doc("The profile of the fleet namespace.")
@added(Versions.v2025_03_01_naar)
model FleetNamespaceProfile {
  @doc("Action if Kubernetes namespace with the same name already exists.")
  adoptionPolicy?: AdoptionPolicy;

  @doc("Delete options of a fleet namespace.")
  deletePolicy?: DeletePolicy;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The labels for the fleet namespace.")
  labels?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The annotations for the fleet namespace.")
  annotations?: Record<string>;

  @doc("The default resource quota for the fleet namespace.")
  defaultResourceQuota?: ResourceQuota;

  @doc("The default network policy for the fleet namespace.")
  defaultNetworkPolicy?: NetworkPolicy;
}

@added(Versions.v2025_03_01_naar)
@doc("Status information for the fleet namespace.")
model FleetNamespaceStatus {
  @visibility("read")
  @doc("The last operation ID for the fleet namespace")
  lastOperationId?: string;

  @visibility("read")
  @doc("The last operation error of the fleet namespace")
  lastOperationError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("A fleet namespace.")
@added(Versions.v2025_03_01_naar)
model FleetNamespaceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: FleetNamespaceProvisioningState;

  @visibility("read")
  @doc("The profile of the fleet namespace.")
  fleetNamespaceProfile?: FleetNamespaceProfile;

  @visibility("read")
  @doc("Status information of the last operation for fleet namespace.")
  status?: FleetNamespaceStatus;
}

@added(Versions.v2025_03_01_naar)
@armResourceOperations
interface FleetNamespaces {
  get is ArmResourceRead<FleetNamespace>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<FleetNamespace> &
      IfMatchParameters<FleetNamespace> &
      IfNoneMatchParameters<FleetNamespace>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    FleetNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<FleetNamespace> &
      IfMatchParameters<FleetNamespace>
  >;

  listByFleet is ArmResourceListByParent<FleetNamespace>;
}
