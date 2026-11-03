import "@typespec/rest";
import "./helpers.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

scalar CrossClusterNetworkingProfileId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/fleets/crossClusterNetworkingProfile",
    }
  ]>;

@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
@doc("The network profile data for a Fleet Member resource.")
model NetworkProfileProperties {
  @doc("The type of cross-cluster networking.")
  @visibility(Lifecycle.Read)
  networkType?: NetworkType;

  @doc("The Cilium cluster properties.")
  @visibility(Lifecycle.Read)
  ciliumProperties?: CiliumProperties;

  @doc("The AppNet cluster properties.")
  @visibility(Lifecycle.Read)
  appNetProperties?: AppNetProperties;

  @doc("The status of the mesh member.")
  @visibility(Lifecycle.Read)
  status: MeshMemberStatus;

  @doc("Resource id of the cross-cluster networking profile associated with this fleet member.")
  @visibility(Lifecycle.Read)
  crossClusterNetworkingProfileResourceId: CrossClusterNetworkingProfileId;
}

@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
@doc("The Cilium specific properties of the member cluster.")
model CiliumProperties {
  @doc("Cilium requires each cluster to be assigned a unique numeric cluster id from 1 - 255. The id is managed by Fleet and cannot be set by the user.")
  @visibility(Lifecycle.Read)
  id: int32;

  @doc("Cilium requires each cluster to be assigned a unique human-readable name. The name is managed by Fleet, based on the Fleet Member name, and cannot be set by the user.")
  @visibility(Lifecycle.Read)
  name: string;
}
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
@doc("The AppNet specific properties of the member cluster.")
model AppNetProperties {
  @doc("AppNet requires each cluster to be assigned a unique numeric cluster id. The id is managed by Fleet and cannot be set by the user.")
  @visibility(Lifecycle.Read)
  id?: int32;

  @doc("AppNet requires each cluster to be assigned a unique human-readable name. The name is managed by Fleet, based on the Fleet Member name, and cannot be set by the user.")
  @visibility(Lifecycle.Read)
  name?: string;
}


@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
@doc("Mesh member state.")
union MeshMemberState {
  string,

  @doc("The member is connecting to the mesh.")
  Connecting: "Connecting",

  @doc("The member is connected to the mesh.")
  Connected: "Connected",

  @doc("The member is disconnecting from the mesh.")
  Disconnecting: "Disconnecting",

  @doc("The member failed to connect due to an error.")
  Failed: "Failed",
}

@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
@added(Versions.v2026_06_02_preview)
@doc("Status of the mesh member.")
model MeshMemberStatus {
  @doc("The mesh member state.")
  @visibility(Lifecycle.Read)
  state: MeshMemberState;

  @doc("When the status was last updated.")
  @visibility(Lifecycle.Read)
  lastUpdatedAt?: utcDateTime;

  @doc("The last operation ID that affected the mesh properties of the fleet member.")
  @visibility(Lifecycle.Read)
  lastOperationId?: string;

  @doc("The error affecting this member.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}
