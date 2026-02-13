import "@azure-tools/typespec-azure-core";
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

@doc("A cluster mesh profile stores the general information about the mesh.")
@added(Versions.v2026_03_02_preview)
@resource("clusterMeshProfiles")
@parentResource(Fleet)
model ClusterMeshProfile
  is Azure.ResourceManager.ProxyResource<ClusterMeshProfileProperties> {
  @doc("The name of the ClusterMeshProfile resource.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @path
  @segment("clusterMeshProfiles")
  @key("clusterMeshProfileName")
  @visibility(Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("A cluster mesh profile stores the general information about the mesh.")
@added(Versions.v2026_03_02_preview)
model ClusterMeshProfileProperties {
  @doc("The provisioning state of the cluster mesh profile.")
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterMeshProfileProvisioningState;

  @doc("Kubernetes-style label selector for selecting Fleet members to join the mesh, e.g. `env=production`. If empty or not specified, no Fleet members will be selected to join the mesh.")
  @maxLength(512)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  memberLabelSelector?: string;

  @doc("The cluster mesh profile status.")
  @visibility(Lifecycle.Read)
  status?: ClusterMeshProfileStatus;
}

@doc("The provisioning state of the cluster mesh profile resource.")
@added(Versions.v2026_03_02_preview)
union ClusterMeshProfileProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Cluster mesh state.")
@added(Versions.v2026_03_02_preview)
union ClusterMeshState {
  string,

  @doc("The mesh is not connected.")
  NotConnected: "NotConnected",

  @doc("The mesh is connecting.")
  Connecting: "Connecting",

  @doc("The mesh is connected.")
  Connected: "Connected",

  @doc("The mesh failed to connect.")
  Failed: "Failed",
}

@doc("Status of the cluster mesh.")
@added(Versions.v2026_03_02_preview)
model ClusterMeshProfileStatus {
  @doc("The state of the cluster mesh.")
  @visibility(Lifecycle.Read)
  state: ClusterMeshState;

  @doc("The last applied Kubernetes-style label selector defining which Fleet members are in the mesh, e.g. `env=production`.")
  @maxLength(512)
  @visibility(Lifecycle.Read)
  lastAppliedMemberLabelSelector?: string;

  @visibility(Lifecycle.Read)
  @doc("The last operation ID for the cluster mesh profile.")
  lastOperationId?: string;

  @visibility(Lifecycle.Read)
  @doc("The last operation error of the cluster mesh profile.")
  lastOperationError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@added(Versions.v2026_03_02_preview)
@armResourceOperations
interface ClusterMeshProfiles {
  get is ArmResourceRead<ClusterMeshProfile>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ClusterMeshProfile,
    Azure.ResourceManager.Foundations.BaseParameters<ClusterMeshProfile> &
      IfMatchParameters<ClusterMeshProfile> &
      IfNoneMatchParameters<ClusterMeshProfile>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    ClusterMeshProfile,
    Azure.ResourceManager.Foundations.BaseParameters<ClusterMeshProfile> &
      IfMatchParameters<ClusterMeshProfile>
  >;

  listByFleet is ArmResourceListByParent<ClusterMeshProfile>;

  @doc("Applies the cluster mesh profile to selected fleet members.")
  apply is Azure.ResourceManager.ArmResourceActionAsync<
    ClusterMeshProfile,
    void,
    ClusterMeshProfile,
    BaseParameters<ClusterMeshProfile> & IfMatchParameters<ClusterMeshProfile>
  >;
}
