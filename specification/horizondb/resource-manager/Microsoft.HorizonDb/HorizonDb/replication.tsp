import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@removed(Versions.v2026_10_01)
@doc("Represents the HorizonDB replica.")
@parentResource(Pool)
model HorizonDbReplica
  is Azure.ResourceManager.ProxyResource<HorizonDbReplicaProperties> {
  @doc("The name of the HorizonDB replica.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("replicaName")
  @path
  @segment("replicas")
  name: string;
}

@added(Versions.v2027_03_01_preview)
@doc("The depth of a HorizonDB cluster in its current asynchronous replication topology. Level 0 is the current root cluster, level 1 is a direct replica of the current root that can be used as the source for one additional replica level, and level 2 is a terminal second-level replica that cannot be used as the source of another asynchronous replica.")
@minValue(0)
@maxValue(2)
scalar ClusterReplicaLevel extends int32;

@added(Versions.v2027_03_01_preview)
@doc("The replication metadata for a HorizonDB cluster that participates in a replication set. Creating a cluster with creationMode AsyncReplica adds it to the replication set that already contains the referenced source cluster and any other members.")
model ClusterReplicationProperties {
  @doc("The roles this cluster currently plays in its replication set. Source means that the cluster sends replicated data to another cluster, and Target means that it receives replicated data from another cluster. Cascading replication supports at most two replica levels below the current root cluster. A direct replica of the current root has the Target role and can be used as the source for one additional replica level; when it has a child replica, it also has the Source role. A second-level replica is terminal, has the Target role, and cannot be used as the source of another asynchronous replica.")
  @visibility(Lifecycle.Read)
  roles: ClusterReplicationRole[];

  @doc("The depth of this cluster in the current replication topology. The current root cluster has level 0, a direct replica of the root has level 1, and a terminal second-level replica has level 2. This value changes when topology operations such as switchover change the cluster's position.")
  @visibility(Lifecycle.Read)
  replicaLevel: ClusterReplicaLevel;

  @doc("The Azure resource ID of this cluster's immediate source cluster. This property is present when roles contains Target, including intermediate replicas whose roles contain both Source and Target, and is absent for Source-only current root clusters.")
  @visibility(Lifecycle.Read)
  sourceClusterResourceId?: HorizonDbClusterResourceId;
}

@added(Versions.v2027_03_01_preview)
@doc("A projection of the current replication relationship from a HorizonDB cluster to one of its direct replica clusters. This model is not an ARM resource.")
model ClusterReplicaLink {
  @doc("The Azure resource ID of the direct replica cluster. The identified cluster has the Target role and uses the cluster on which the replicas operation was invoked as its immediate source.")
  @visibility(Lifecycle.Read)
  clusterResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters";
    }
  ]>;

  @doc("The current state of replication from the source cluster to this direct replica.")
  @visibility(Lifecycle.Read)
  replicationState: ClusterReplicationState;
}

@added(Versions.v2027_03_01_preview)
@doc("A projection of a virtual endpoint reference to a HorizonDB cluster. This model is not an ARM resource.")
model ClusterVirtualEndpointReference {
  @doc("The Azure resource ID of the virtual endpoint that references this cluster.")
  @visibility(Lifecycle.Read)
  virtualEndpointResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/virtualEndpoints";
    }
  ]>;

  @doc("The virtual endpoint alias whose target belongs to this cluster.")
  @visibility(Lifecycle.Read)
  role: VirtualEndpointReferenceRole;
}

@added(Versions.v2027_03_01_preview)
@doc("The role of a HorizonDB cluster in a virtual endpoint reference.")
union VirtualEndpointReferenceRole {
  string,

  @doc("The virtual endpoint writer target belongs to this cluster.")
  Writer: "Writer",

  @doc("The virtual endpoint reader target belongs to this cluster.")
  Reader: "Reader",
}

@added(Versions.v2027_03_01_preview)
@doc("A role played by a HorizonDB cluster in a replication set.")
union ClusterReplicationRole {
  string,

  /** The cluster sends replicated data to one or more target clusters. */
  Source: "Source",

  /** The cluster receives replicated data from a source cluster. */
  Target: "Target",
}

@added(Versions.v2027_03_01_preview)
@doc("The current state of replication between a source cluster and a direct replica cluster.")
union ClusterReplicationState {
  string,

  /** Replication is operating normally and the replica is receiving changes from its source. */
  Replicating: "Replicating",

  /** The replica is behind its source, but replication remains active. */
  Lagging: "Lagging",

  /** The replica is actively applying changes to reach the current state of its source. */
  CatchingUp: "CatchingUp",

  /** Replication has encountered an error and is not operating normally. */
  Error: "Error",
}

@removed(Versions.v2026_10_01)
@doc("Properties of a HorizonDB replica.")
model HorizonDbReplicaProperties {
  @doc("Role of the replica.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  role?: ReplicaRole;

  @doc("Current status of the replica.")
  @visibility(Lifecycle.Read)
  status?: State;

  @doc("The fully qualified domain name of the replica.")
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  @doc("The availability zone of the replica.")
  availabilityZone?: string;

  @doc("The provisioning state of the replica.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@removed(Versions.v2026_10_01)
@doc("Properties of a HorizonDB replica for update operations.")
model HorizonDbReplicaPropertiesForPatchUpdate {
  @visibility(Lifecycle.Update)
  @doc("Role of the replica.")
  role?: ReplicaRole;
}

@removed(Versions.v2026_10_01)
@doc("HorizonDB replica for update operations.")
model HorizonDbReplicaForPatchUpdate {
  @doc("Properties of a HorizonDB replica for update operations.")
  properties?: HorizonDbReplicaPropertiesForPatchUpdate;
}

@removed(Versions.v2026_10_01)
@doc("Role of the replica.")
union ReplicaRole {
  string,

  /** Read-only replica */
  Read: "Read",

  /** ReadWrite replica */
  ReadWrite: "ReadWrite",
}

@removed(Versions.v2026_10_01)
@armResourceOperations
interface HorizonDbReplicas {
  @doc("Gets information about a HorizonDB replica.")
  get is ArmResourceRead<HorizonDbReplica>;

  @doc("Lists all HorizonDB replicas in a pool.")
  list is ArmResourceListByParent<HorizonDbReplica>;

  @doc("Creates a new HorizonDB replica or updates an existing replica.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbReplica>;

  @doc("Updates an existing HorizonDB replica (e.g., role).")
  update is ArmCustomPatchAsync<
    HorizonDbReplica,
    HorizonDbReplicaForPatchUpdate
  >;

  @doc("Deletes a HorizonDB replica.")
  delete is ArmResourceDeleteWithoutOkAsync<
    HorizonDbReplica,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}
