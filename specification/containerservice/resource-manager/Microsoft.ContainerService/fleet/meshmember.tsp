import "@typespec/rest";
import "./helpers.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

@added(Versions.v2025_08_02_clustermesh)
@doc("The Mesh Member data for a Fleet Member resource.")
model MeshProperties {
  @doc("The Cilium cluster properties.")
  @visibility(Lifecycle.Read)
  ciliumProperties: CiliumProperties;

  @doc("The status of the mesh member.")
  @visibility(Lifecycle.Read)
  status: MeshMemberStatus;

  @doc("Resource id of the cluster mesh profile associated with this mesh member.")
  @visibility(Lifecycle.Read)
  clusterMeshProfileResourceId: string;
}


@added(Versions.v2025_08_02_clustermesh)
@doc("The Cilium specific properties of the member cluster.")
model CiliumProperties {
  @doc("The Cilium clusterId")
  @visibility(Lifecycle.Read)
  id: int32;

  @doc("The Cilium cluster name")
  @visibility(Lifecycle.Read)
  name: string;
}


@added(Versions.v2025_08_02_clustermesh)
@doc("Mesh member state.")
union MeshMemberState {
  string,

  @doc("The member is not connected to the mesh.")
  NotConnected: "NotConnected",

  @doc("The member is connecting to the mesh.")
  Connecting: "Connecting",

  @doc("The member is connected to the mesh.")
  Connected: "Connected",

  @doc("The member is disconnecting from the mesh.")
  Disconnecting: "Disconnecting",

  @doc("The member failed to connect due to an error.")
  Failed: "Failed",
}


@added(Versions.v2025_08_02_clustermesh)
@doc("Status of the mesh member.")
model MeshMemberStatus {
  @doc("The mesh member state.")
  state: MeshMemberState;

  @doc("When the status was last updated.")
  lastUpdatedAt?: utcDateTime;

  @doc("The error(s) reported by the cluster mesh agent.")
  clusterMeshError?: Azure.ResourceManager.Foundations.ErrorDetail;
}