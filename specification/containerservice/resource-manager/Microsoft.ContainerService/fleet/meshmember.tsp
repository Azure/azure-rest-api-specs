import "@typespec/rest";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;

@doc("The Mesh Member data for a Fleet Member resource.")
@resource("meshmembers")
@parentResource(FleetMember)
model MeshMember is ProxyResource<MeshMemberProperties> {
  @doc("The name of the Mesh member resource.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  @key("meshMemberName")
  @path
  @segment("members")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

// ???
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
  state: MeshMemberState;

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
  network?: MeshNetwork;

  @doc("The mesh member status.")
  status?: MeshMemberStatus;
}

@doc("The Mesh Member properties for a Fleet Member resource.")
model MeshMemberProperties {
  @doc("The Id of the Mesh Member.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  meshMemberId: MeshMemberId;

  @doc("The Cilium cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  ciliumProperties: CiliumProperties;

  @doc("Mutable properties of the mesh member.")
  mutableProperties?: MeshMemberUpdate;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: MeshMemberProvisioningState;

  @doc("Resource id of the cluster mesh profile associated with this mesh member.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterMeshProfileResourceId?: string;
}

@lroStatus
@doc("The provisioning state of the last accepted operation.")
union MeshMemberProvisioningState {
  string,
  ResourceProvisioningState,
}
