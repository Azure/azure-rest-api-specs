import "@typespec/rest";
import "./helpers.tsp";

namespace Microsoft.ContainerService;

@doc("The Mesh Member data for a Fleet Member resource.")
model MeshMember {
  @doc("The Id of the Mesh Member.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  meshMemberId: MeshMemberId;

  @doc("The Cilium cluster properties.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  ciliumProperties: CiliumProperties;

  @doc("Mutable properties of the mesh member.")
  mutableProperties?: MeshMemberUpdate;

  @doc("Resource id of the cluster mesh profile associated with this mesh member.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterMeshProfileResourceId?: string;
}

scalar FleetResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/fleets",
    }
  ]>;

@doc("The ID of the Mesh Member.")
model MeshMemberId {
  @doc("The ARM ID of the fleet resource that the member is part of.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  fleetResourceId: FleetResourceId;

  @doc("The name of the member cluster. Unique within a fleet. Mus tbe the same as the name of the Fleet Member Azure resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  fleetMemberName: string;
}

@doc("The Cilium specific properties of the member cluster.")
model CiliumProperties {
  @doc("The Cilium clusterId")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  id: int32;

  @doc("The Cilium cluster name")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@doc("Properties of the clustermesh-apiserver.")
model ClusterMeshApiServer {
  @doc("IP address, e.g. 172.18.255.201")
  ip: string;

  @doc("DNS address, e.g. cluster1.mesh.cilium.io")
  domain: string;

  @doc("Port, e.g. 2379")
  port: int32;
}

@doc("Mesh network properties for the cluster.")
model MeshNetwork {
  @doc("Pod CIDRs.")
  podCidrs: string[];

  @doc("Service CIDRs.")
  serviceCidrs: string[];

  @doc("Node CIDRs.")
  nodeCidrs: string[];
}

@doc("Mesh member state.")
union MeshMemberState {
  string,

  @doc("Unknown state.")
  Unknown: "Unknown",

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

@doc("Status of the mesh member.")
model MeshMemberStatus {
  @doc("The mesh member state.")
  meshMemberState: MeshMemberState;

  @doc("When the status was last updated.")
  lastUpdatedAt?: utcDateTime;

  @doc("The error(s) reported by the cluster mesh agent.")
  clusterMeshError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("An update to the mesh member properties.")
model MeshMemberUpdate {
  @doc("Properties of the clustermesh-apiserver.")
  clusterMeshApiServer?: ClusterMeshApiServer;

  @doc("Network properties for the cluster.")
  meshNetwork?: MeshNetwork;

  @doc("The mesh member status.")
  meshMemberStatus?: MeshMemberStatus;
}
