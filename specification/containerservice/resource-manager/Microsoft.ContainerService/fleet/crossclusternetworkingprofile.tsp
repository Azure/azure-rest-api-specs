import "@azure-tools/typespec-azure-core";
import "./selector.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

@doc("A cross-cluster networking profile stores the general information about the mesh.")
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
@resource("crossClusterNetworkingProfile")
@parentResource(Fleet)
model CrossClusterNetworkingProfile
  is Azure.ResourceManager.ProxyResource<CrossClusterNetworkingProfileProperties> {
  @doc("The name of the CrossClusterNetworkingProfile resource.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @path
  @segment("crossClusterNetworkingProfile")
  @key("crossClusterNetworkingProfileName")
  @visibility(Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("A cross-cluster networking profile stores the general information about the mesh.")
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
model CrossClusterNetworkingProfileProperties {
  @doc("The provisioning state of the cross-cluster networking profile.")
  @visibility(Lifecycle.Read)
  provisioningState?: CrossClusterNetworkingProfileProvisioningState;

  @doc("The type of cross-cluster networking.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkType?: NetworkType;

  @doc("""
    Select the members of the mesh.
      * Only key/value pairs with the `=` operator are accepted in the label selector.
      * If empty or not specified, no Fleet members will be selected to join the mesh.
    """)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  memberSelector?: MemberSelector;

  @doc("The cross-cluster networking profile status.")
  @visibility(Lifecycle.Read)
  status?: CrossClusterNetworkingProfileStatus;
}
@doc("The type of cross-cluster networking.")
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
union NetworkType {
  string,

  @doc("Cilium cluster mesh networking.")
  Cilium: "Cilium",

  @doc("AppNet networking.")
  AppNet: "AppNet",
}


@doc("The provisioning state of the cross-cluster networking profile resource.")
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
union CrossClusterNetworkingProfileProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Cross-cluster networking profile mesh state.")
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
union CrossClusterNetworkingProfileState {
  string,

  @doc("The cross-cluster network is not connected.")
  NotConnected: "NotConnected",

  @doc("The cross-cluster network is applying.")
  Applying: "Applying",

  @doc("The cross-cluster network is connected.")
  Connected: "Connected",

  @doc("The cross-cluster network is degraded.")
  Degraded: "Degraded",

  @doc("The cross-cluster network failed to connect.")
  Failed: "Failed",
}

@doc("Status of the cross cluster networking profile.")
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
model CrossClusterNetworkingProfileStatus {
  @doc("The state of the cross-cluster networking profile.")
  @visibility(Lifecycle.Read)
  state: CrossClusterNetworkingProfileState;

  @visibility(Lifecycle.Read)
  @doc("The last applied MemberSelector for the cross-cluster networking profile.")
  lastAppliedMemberSelector?: MemberSelector;

  @visibility(Lifecycle.Read)
  @doc("The last operation ID for the cross-cluster networking profile.")
  lastOperationId?: string;

  @visibility(Lifecycle.Read)
  @doc("The last operation error of the cross-cluster networking profile.")
  lastOperationError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
@armResourceOperations
interface CrossClusterNetworkingProfiles {
  get is ArmResourceRead<CrossClusterNetworkingProfile>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    CrossClusterNetworkingProfile,
    Azure.ResourceManager.Foundations.BaseParameters<CrossClusterNetworkingProfile> &
      IfMatchParameters<CrossClusterNetworkingProfile> &
      IfNoneMatchParameters<CrossClusterNetworkingProfile>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    CrossClusterNetworkingProfile,
    Azure.ResourceManager.Foundations.BaseParameters<CrossClusterNetworkingProfile> &
      IfMatchParameters<CrossClusterNetworkingProfile>
  >;

  listByFleet is ArmResourceListByParent<CrossClusterNetworkingProfile>;

  @doc("Applies the cross-cluster networking profile to selected fleet members.")
  apply is Azure.ResourceManager.ArmResourceActionAsync<
    CrossClusterNetworkingProfile,
    void,
    CrossClusterNetworkingProfile,
    BaseParameters<CrossClusterNetworkingProfile> & IfMatchParameters<CrossClusterNetworkingProfile>
  >;
}
