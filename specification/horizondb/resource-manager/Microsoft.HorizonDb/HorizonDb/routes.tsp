import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

alias PrivateEndpointOperations = Azure.ResourceManager.PrivateEndpoints<PrivateEndpointConnection>;

@doc("Long-running operation headers returned when a HorizonDB cluster update is accepted.")
model ClusterUpdateAcceptedHeaders is ArmLroLocationHeader<
  Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
  Cluster,
  string
> {
  @added(Versions.v2026_10_01)
  @doc("A link to the status monitor for the cluster update operation.")
  @Azure.Core.pollingLocation(
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>
  )
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;
}

@added(Versions.v2026_10_01)
@doc("Long-running operation headers returned when an asynchronous HorizonDB cluster create or replacement is accepted.")
model ClusterCreateOrReplaceLroHeaders {
  @doc("A link to the status monitor for the cluster create or replacement operation.")
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;

  ...Azure.Core.Foundations.RetryAfterHeader;
}

@added(Versions.v2026_10_01)
@doc("The response returned when an asynchronous HorizonDB cluster replacement is accepted.")
model ClusterReplaceAcceptedResponse {
  ...OkResponse;
  ...ClusterCreateOrReplaceLroHeaders;

  @doc("The HorizonDB cluster with a non-terminal provisioning state.")
  @bodyRoot
  body: Cluster;
}

@added(Versions.v2026_10_01)
@doc("The response returned when asynchronous HorizonDB cluster creation is accepted.")
model ClusterCreateAcceptedResponse {
  ...CreatedResponse;
  ...ClusterCreateOrReplaceLroHeaders;

  @doc("The HorizonDB cluster with a non-terminal provisioning state.")
  @bodyRoot
  body: Cluster;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbClusters")
@armResourceOperations
interface Clusters {
  @doc("Gets information about a HorizonDB cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Creates a new HorizonDB cluster or updates an existing cluster.")
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "createOrUpdate")
  @sharedRoute
  createOrUpdateLegacy is ArmResourceCreateOrReplaceAsync<Cluster>;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The AutoRest emitter infers final-state-via from polling metadata. Marking this standard ARM PUT as an LRO without polling decorators emits x-ms-long-running-operation while intentionally omitting x-ms-long-running-operation-options."
  @added(Versions.v2026_10_01)
  @doc("Creates a new HorizonDB cluster or replaces an existing cluster. PointInTimeRestore creates the new Cluster resource and hydrates its service-owned database storage from an available source backup. It does not clone source pools, Pool-scoped endpoints, firewall rules, parameter-group associations, or other child resources. The new Cluster receives its service-generated Cluster-scoped Endpoint named cluster. The Endpoint role is ReadWrite for a new level-0 root Cluster and ReadOnly when creationMode is AsyncReplica because the new Cluster's replication.roles contains Target. PostgreSQL version is inherited from backup metadata; all other new-cluster configuration comes from the request or service defaults. Until cross-region point-in-time restore is supported, the target cluster location must match the source cluster location; a cross-region request is rejected synchronously with 400 CrossRegionPointInTimeRestoreNotSupported and does not create or modify a resource.")
  @sharedRoute
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  @autoRoute
  @armResourceCreateOrUpdate(Cluster)
  @put
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<Cluster>,
    Cluster,
    ClusterReplaceAcceptedResponse | ClusterCreateAcceptedResponse,
    ErrorResponse
  >;

  @doc("Updates an existing HorizonDB cluster.")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterForPatchUpdate,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    ClusterUpdateAcceptedHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Deletes a HorizonDB cluster.")
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "delete")
  @sharedRoute
  deleteLegacy is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @added(Versions.v2026_10_01)
  @doc("Deletes a HorizonDB cluster, its Cluster-scoped Endpoint, and all remaining child resources. The service first rejects the request with 409 ClusterReferencedByVirtualEndpoint, without making destructive changes, when any virtual endpoint writer or reader target belongs to the cluster. Use virtualEndpointReferences to discover blocking references and retarget or delete them before retrying. When deletion.policy is RetainUntilNoBackupsRemain and backups remain, the service removes all pools together with their Pool-scoped Endpoints and FirewallRules, stops creation of automatic backups, transitions the cluster to DeletionBlockedByBackups, and returns 409 Conflict without starting a long-running operation. The Cluster-scoped Endpoint remains tied to the Cluster lifecycle while deletion is blocked. While blocked, reads remain available, but the service rejects mutating operations other than deletion of user-created backups and another cluster delete request. Retry cluster deletion after all backups are removed or expire. For an accepted deletion, the long-running operation remains nonterminal until physical deletion completes and point GET returns 404 Not Found.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  @doc("Lists all HorizonDB clusters in a subscription.")
  listBySubscription is ArmListBySubscription<Cluster>;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Starts a stopped HorizonDB cluster.")
  start is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Stops a running HorizonDB cluster.")
  stop is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Restarts a HorizonDB cluster.")
  restart is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_10_01)
  @doc("Lists the direct asynchronous replicas of this cluster. Each item identifies a cluster that has the Target role and uses this cluster as its immediate source, and reports the state of that replication link. Descendant replicas whose immediate source is another replica are not returned.")
  @get
  @list
  @action("replicas")
  listReplicas is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListCustomResult<ClusterReplicaLink>>
  >;

  @added(Versions.v2026_10_01)
  @doc("Lists virtual endpoints whose writer or reader endpoint target belongs to this cluster. Each item identifies the virtual endpoint and the Writer or Reader role through which it references the cluster. Callers can use this operation to discover dependencies that block cluster deletion or replication topology changes.")
  @get
  @list
  @action("virtualEndpointReferences")
  listVirtualEndpointReferences is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListCustomResult<ClusterVirtualEndpointReference>>
  >;

  @added(Versions.v2026_10_01)
  @doc("Promotes this replica cluster by detaching it and all of its descendant replicas from the current replication set, creating an isolated replication set rooted at this cluster while preserving its descendant relationships. The operation is valid only when the cluster has the Target role. Current root clusters, clusters outside a replication set, and clusters in an incompatible operational or replication state are rejected. The service also rejects promotion with 409 ClusterReferencedByVirtualEndpoint when the topology change would invalidate a virtual endpoint reader relationship; callers must retarget or delete the virtual endpoint first.")
  @action("promote")
  promote is ArmResourceActionAsyncBase<
    Cluster,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  @added(Versions.v2026_10_01)
  @doc("Switches this replica cluster with its immediate source while preserving the replication set and descendant relationships. The operation is valid only when the cluster has the Target role. Before starting, a virtual endpoint must exist whose writer targets the Cluster-scoped Endpoint named cluster in the immediate source Cluster and whose reader targets the Cluster-scoped Endpoint named cluster in this direct replica; otherwise the service rejects the request with 409 VirtualEndpointSwitchoverPreconditionFailed. On success, the service atomically swaps the replication topology, changes the invoked replica's Cluster-scoped Endpoint role to ReadWrite, changes the former source's Cluster-scoped Endpoint role to ReadOnly, and swaps the virtual endpoint writer and reader resource IDs and DNS CNAME destinations. The virtual endpoint resource ID and stable writer and reader FQDNs do not change. If the topology, role, or endpoint retarget cannot commit, the service rolls back all changes and reports a failed operation.")
  @action("switchover")
  switchover is ArmResourceActionAsyncBase<
    Cluster,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  @added(Versions.v2026_10_01)
  @doc("Designates an existing pool to host the cluster's read-write node. This POST action can be authorized separately from general cluster write permissions. The pool resource ID must identify a child resource of this cluster; a pool in another cluster is rejected. On success, the service sets readWritePool.designatedPoolResourceId to the requested resource ID. Endpoint scopes, roles, FQDNs, aliases, and firewall rules do not change during designation.")
  @action("designateReadWritePool")
  designateReadWritePool is ArmResourceActionAsyncBase<
    Cluster,
    DesignateReadWritePoolRequest,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  @added(Versions.v2026_10_01)
  @doc("Clears the cluster's read-write pool designation so that no pool hosts the cluster's read-write node. This POST action can be authorized separately from general cluster write permissions. On success, the service removes readWritePool.designatedPoolResourceId. Endpoint scopes, roles, FQDNs, aliases, and firewall rules do not change; the Cluster-scoped ReadWrite Endpoint remains discoverable but has no routing destination.")
  @action("clearReadWritePool")
  clearReadWritePool is ArmResourceActionAsyncBase<
    Cluster,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  @added(Versions.v2026_10_01)
  @doc("Triggers a failover operation for the HorizonDB cluster. Before invoking this action, callers should inspect the always-present properties.readWritePool.failover.state value returned by cluster reads; Ready represents eligibility for automatic and caller-requested failover, while NotReady means unavailableReason explains why failover cannot currently run. The service selects the new read-write node using the same mechanics as automatic failover.")
  @action("failover")
  failover is ArmResourceActionAsyncBase<
    Cluster,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Cluster>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;
}

@added(Versions.v2026_10_01)
@doc("Long-running operation headers returned when asynchronous HorizonDB pool creation is accepted.")
model PoolCreateLroHeaders {
  @doc("A link to the status monitor for the pool creation operation.")
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;

  ...Azure.Core.Foundations.RetryAfterHeader;
}

@added(Versions.v2026_10_01)
@doc("The response returned when asynchronous HorizonDB pool creation is accepted.")
model PoolCreateAcceptedResponse {
  ...CreatedResponse;
  ...PoolCreateLroHeaders;

  @doc("The HorizonDB pool with a non-terminal provisioning state.")
  @bodyRoot
  body: Pool;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPools")
@armResourceOperations
interface Pools {
  @doc("Gets information about a HorizonDB pool.")
  get is ArmResourceRead<Pool>;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The AutoRest emitter infers final-state-via from polling metadata. Marking this standard ARM PUT as an LRO without polling decorators emits x-ms-long-running-operation while intentionally omitting x-ms-long-running-operation-options."
  @added(Versions.v2026_10_01)
  @doc("Creates a new HorizonDB pool or updates an existing pool, including its desired node allocation, compute model, or associated parameter group. A pool name can be the same as its parent cluster name. Creating a pool also creates exactly one service-managed Pool-scoped ReadOnly Endpoint representing that Pool and its network boundary. The Endpoint's associatedResourceId identifies the Pool, and the Endpoint cannot outlive or be deleted independently from it. When a pool is created while its parent cluster currently has no pools, the service automatically designates the new pool as the cluster's read-write pool and selects an eligible read-write node when one is available. This behavior applies whether the cluster has never had a pool or previously had pools that were all deleted, and supports end-to-end declarative deployment without a separate designation request. The resulting designation is reported by the parent cluster's readWritePool.designatedPoolResourceId. This API version supports at most one pool per cluster; an attempt to create another pool is rejected with 409 Conflict. Every pool must be associated with a parameter group, so parameterGroup, parameterGroupResourceId, and applyMethod are required. applyMethod controls when dynamic parameter changes become effective; static parameter changes always require a customer-triggered restart or a restart during scheduled maintenance. For a Serverless compute model, the service validates that minVCores is less than or equal to maxVCores. The request is rejected if it would leave the pool with an effective desiredNodeCount of 0 while that pool is currently the parent cluster's designated read-write pool. Clear the designation through clearReadWritePool first. On rejection, the pool and designation remain unchanged.")
  @sharedRoute
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  @autoRoute
  @armResourceCreateOrUpdate(Pool)
  @put
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<Pool>,
    Pool,
    ArmResourceUpdatedResponse<Pool> | PoolCreateAcceptedResponse,
    ErrorResponse
  >;

  @added(Versions.v2026_10_01)
  @doc("Updates an existing HorizonDB pool, including its desired node allocation, selected compute model properties, the compute model type, or its associated parameter group. When parameterGroup is supplied, both parameterGroupResourceId and applyMethod are required. applyMethod controls when dynamic parameter changes become effective; static parameter changes always require a customer-triggered restart or a restart during scheduled maintenance. For an effective Serverless compute model, the service validates that the recursively merged minVCores value is less than or equal to the recursively merged maxVCores value. The request is rejected if it would leave the pool with an effective desiredNodeCount of 0 while that pool is currently the parent cluster's designated read-write pool. Clear the designation through clearReadWritePool first. On rejection, the pool and designation remain unchanged.")
  update is ArmCustomPatchAsync<Pool, PoolForPatchUpdate>;

  @added(Versions.v2026_10_01)
  @doc("Deletes a HorizonDB pool together with the Pool-scoped Endpoint whose associatedResourceId identifies that Pool and all FirewallRule children of that Endpoint. The Endpoint cannot outlive or be deleted independently from its Pool. Deletion fails with a conflict while the pool is designated as the cluster's read-write pool. Transfer or clear the designation before deleting the pool.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Pool,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB pools in a cluster.")
  list is ArmResourceListByParent<Pool>;

  @added(Versions.v2026_10_01)
  @doc("Starts a stopped or shut down HorizonDB pool. Power operations are supported only at pool scope in this API version; there is no cluster-level start action. When the pool transitions from Stopped or Shutdown to Ready, completion applies pending dynamic and static parameter changes. When the pool is already Ready, the operation succeeds as a true idempotent no-op and leaves pending parameter changes pending. The operation is allowed when allocatedNodeCount is 0. After the Pool is running, its Pool-scoped ReadOnly Endpoint routes only when at least one allocated node is not currently playing the read-write role. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
  @action("start")
  start is ArmResourceActionAsyncBase<
    Pool,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Pool>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;

  @added(Versions.v2026_10_01)
  @doc("Stops a running HorizonDB pool without deallocating compute. Power operations are supported only at pool scope in this API version; there is no cluster-level stop action. The operation succeeds as an idempotent no-op when the pool is already Stopped. It is allowed when allocatedNodeCount is 0. The Pool-scoped ReadOnly Endpoint remains discoverable but has no routing destination while the Pool is Stopped. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
  @action("stop")
  stop is ArmResourceActionAsyncBase<
    Pool,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Pool>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;

  @added(Versions.v2026_10_01)
  @doc("Shuts down a running or stopped HorizonDB pool and deallocates compute. Power operations are supported only at pool scope in this API version; there is no cluster-level shutdown action. The operation succeeds as an idempotent no-op when the pool is already Shutdown. It is allowed when allocatedNodeCount is 0. The Pool-scoped ReadOnly Endpoint remains discoverable but has no routing destination while the Pool is Shutdown. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
  @action("shutdown")
  shutdown is ArmResourceActionAsyncBase<
    Pool,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Pool>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;

  @added(Versions.v2026_10_01)
  @doc("Restarts the PostgreSQL container on all allocated nodes in a ready HorizonDB pool and applies pending dynamic and static parameter changes. Power operations are supported only at pool scope in this API version; there is no cluster-level restart action. When allocatedNodeCount is 0, the operation succeeds without restarting any nodes, pending changes are considered applied, parameterGroup.syncStatus becomes InSync, and the resulting configuration applies to nodes allocated later. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
  @action("restart")
  restart is ArmResourceActionAsyncBase<
    Pool,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader &
          ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ArmResponse<Pool>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;
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

@added(Versions.v2026_10_01)
@armResourceOperations
interface Endpoints {
  @doc("Gets information about a service-generated HorizonDB Cluster- or Pool-scoped Endpoint.")
  get is ArmResourceRead<Endpoint>;

  @doc("Lists the service-generated Endpoints in a cluster. The collection contains the Cluster-scoped Endpoint named cluster and one Pool-scoped Endpoint for each pool.")
  list is ArmResourceListByParent<Endpoint>;

  @doc("Replaces the DNS alias list of a service-generated HorizonDB endpoint. An empty list removes the endpoint's aliased CNAME. Only one alias is currently supported.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Endpoint, PatchModel = EndpointForPatchUpdate>;
}

@added(Versions.v2026_10_01)
@doc("Operations for stable writer and reader DNS aliases associated with HorizonDB replication topologies.")
@armResourceOperations
interface VirtualEndpoints {
  @doc("Gets information about a HorizonDB virtual endpoint.")
  get is ArmResourceRead<VirtualEndpoint>;

  @doc("Creates or replaces a HorizonDB virtual endpoint. The resource name must be globally available as a HorizonDB endpoint DNS base name. The writer target must be the Cluster-scoped Endpoint named cluster in the current root Cluster. The reader target must be the Cluster-scoped Endpoint named cluster in that Cluster or one of its direct level-1 replica Clusters; indirect descendants are rejected. For regional resilience, customers should deploy the VirtualEndpoint in an Azure region that has a paired region and that is different from every Cluster region in the referenced replication set. This recommendation is not validated or enforced; any otherwise supported location remains accepted. This placement can help the VirtualEndpoint remain available for promote or switchover recovery workflows during a regional outage affecting the root Cluster, but does not guarantee availability.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualEndpoint>;

  @doc("Updates the writer or reader target of a HorizonDB virtual endpoint. Omitted properties preserve their current values, and the complete effective target pair must satisfy the root-cluster and direct-replica constraints.")
  update is ArmCustomPatchAsync<VirtualEndpoint, VirtualEndpointForPatchUpdate>;

  @doc("Deletes a HorizonDB virtual endpoint. This removes its strong references to the target clusters but does not delete or modify the target endpoints or clusters.")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualEndpoint>;

  @doc("Lists all HorizonDB virtual endpoints in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualEndpoint>;

  @doc("Lists all HorizonDB virtual endpoints in a subscription.")
  listBySubscription is ArmListBySubscription<VirtualEndpoint>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Authentication method instances are service-created with the cluster; customers update an existing instance through PATCH and cannot create additional instances."
@added(Versions.v2026_10_01)
@doc("Operations for the service-created PostgreSQL username-and-password authentication method of a HorizonDB cluster.")
@armResourceOperations
interface PasswordAuthentications {
  @doc("Gets the service-created PostgreSQL username-and-password authentication method.")
  get is ArmResourceRead<PasswordAuthentication>;

  @doc("Updates the service-created PostgreSQL username-and-password authentication method. The request is sparse and omitted properties preserve their current values. A state-only request enables or disables the authentication mechanism; disabling cannot include credentials and does not remove or modify existing database users or roles. Login-only, password-only, and combined credential updates require this method to already be Enabled unless this request also sets state to Enabled. PostgreSQL is the sole source of truth; the control plane stores no administrator identity or credentials. The service bootstraps an AzureSU-owned special group, only AzureSU can grant or revoke its membership, and at most one user role can be a member. Login-only or password-only updates require exactly one current member. A combined administratorLogin and administratorLoginPassword request creates and adds a new user when no member exists, resets the password when the member name matches, or renames the member and resets its password when names differ. A requested name that already exists outside the special group is rejected to prevent privilege elevation. Both authentication methods may be Disabled.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PasswordAuthentication,
    PatchModel = PasswordAuthenticationForPatchUpdate
  >;

  @doc("Lists the two service-created authentication configurations for the cluster: passwordMethod and microsoftEntra.")
  list is ArmResourceListByParent<
    PasswordAuthentication,
    Response = ArmResponse<Azure.ResourceManager.ResourceListCustomResult<Authentication>>
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Authentication method instances are service-created with the cluster; customers update an existing instance through PATCH and cannot create additional instances."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-list-operation" "The shared authentications collection list operation is defined by PasswordAuthentications.list and returns both constrained resource instances."
@added(Versions.v2026_10_01)
@doc("Operations for the service-created Microsoft Entra authentication method of a HorizonDB cluster.")
@armResourceOperations
interface MicrosoftEntraAuthentications {
  @doc("Gets the service-created Microsoft Entra authentication method.")
  get is ArmResourceRead<MicrosoftEntraAuthentication>;

  @doc("Updates the service-created Microsoft Entra authentication method. State Enabled enables the feature and State Disabled disables it; no additional properties are required. Disabling the feature does not remove or modify database roles or users previously created through the MicrosoftEntraAdministrators control-plane API or directly through pgaadauth extension functions. The method may be Disabled even when password authentication is also Disabled.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    MicrosoftEntraAuthentication,
    PatchModel = MicrosoftEntraAuthenticationForPatchUpdate
  >;
}

@added(Versions.v2026_10_01)
@doc("Operations for PostgreSQL roles that are members of azure_pg_admin and mapped to Microsoft Entra principals.")
@armResourceOperations
interface MicrosoftEntraAdministrators {
  @doc("Gets information about a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
  get is ArmResourceRead<MicrosoftEntraAdministrator>;

  @doc("Creates or updates a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    MicrosoftEntraAdministrator,
    Request = MicrosoftEntraAdministratorAdd
  >;

  @doc("Deletes a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
  delete is ArmResourceDeleteWithoutOkAsync<
    MicrosoftEntraAdministrator,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists the PostgreSQL roles in a cluster that are members of azure_pg_admin and mapped to Microsoft Entra principals.")
  list is ArmResourceListByParent<MicrosoftEntraAdministrator>;
}

@added(Versions.v2026_10_01)
@doc("Maintenance event operations for HorizonDB pools.")
@armResourceOperations
interface MaintenanceEvents {
  @doc("Gets information about a maintenance event for a HorizonDB pool.")
  get is ArmResourceRead<MaintenanceEvent>;

  @doc("Lists maintenance events for a HorizonDB pool.")
  list is ArmResourceListByParent<
    MaintenanceEvent,
    Parameters = {
      @doc("Filters maintenance events by status.")
      @query("maintenanceStatus")
      maintenanceStatus?: MaintenanceEventStatusFilter;
    }
  >;

  @doc("Reschedules a maintenance event to a new date and time.")
  reschedule is ArmResourceActionAsyncBase<
    MaintenanceEvent,
    MaintenanceEventRescheduleRequest,
    | ArmResponse<MaintenanceEventActionResponse>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MaintenanceEventActionResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MaintenanceEvent>
  >;

  @doc("Applies the maintenance event immediately.")
  applyNow is ArmResourceActionAsyncBase<
    MaintenanceEvent,
    void,
    | ArmResponse<MaintenanceEventActionResponse>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MaintenanceEventActionResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MaintenanceEvent>
  >;
}

@added(Versions.v2026_10_01)
@doc("Backup operations for HorizonDB clusters.")
@armResourceOperations
interface Backups {
  @doc("Gets an available backup for a HorizonDB cluster. Expired automatic backups are not available through this operation; user-created backups remain available until explicitly deleted.")
  get is ArmResourceRead<Backup>;

  @doc("Creates a user backup with the name specified in the request path. Backup properties are service-generated and cannot be supplied by the caller.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    Backup,
    void,
    OptionalRequestBody = true
  >;

  @doc("Deletes a user-created backup. The request fails with 409 Conflict when the specified backup is an automatic backup. Automatic backups cannot be deleted explicitly and are removed only when they reach their expiry date.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Backup,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists the backups available for a HorizonDB cluster. Expired automatic backups are omitted; user-created backups remain available until explicitly deleted.")
  list is ArmResourceListByParent<Backup>;
}

@added(Versions.v2026_10_01)
@doc("System-managed AI model operations for provisioned HorizonDB clusters.")
@armResourceOperations
interface SystemAiModels {
  @doc("Gets a system-managed AI model for a provisioned HorizonDB cluster.")
  get is ArmResourceRead<SystemAiModel>;

  @doc("Lists the system-managed AI models for a provisioned HorizonDB cluster.")
  list is ArmResourceListByParent<SystemAiModel>;
}

@removed(Versions.v2026_10_01)
@armResourceOperations
interface HorizonDbFirewallRules {
  @doc("Gets information about a HorizonDB firewall rule.")
  get is ArmResourceRead<LegacyHorizonDbFirewallRule>;

  @doc("Lists all HorizonDB firewall rules in a pool.")
  list is ArmResourceListByParent<LegacyHorizonDbFirewallRule>;

  @doc("Creates a new HorizonDB firewall rule or updates an existing rule.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LegacyHorizonDbFirewallRule>;

  @doc("Deletes a HorizonDB firewall rule.")
  delete is ArmResourceDeleteWithoutOkAsync<
    LegacyHorizonDbFirewallRule,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}

@added(Versions.v2026_10_01)
@armResourceOperations
interface FirewallRules {
  @doc("Gets information about a HorizonDB endpoint firewall rule.")
  get is ArmResourceRead<FirewallRule>;

  @doc("Lists all HorizonDB firewall rules in an endpoint.")
  list is ArmResourceListByParent<FirewallRule>;

  @doc("Creates or replaces a HorizonDB endpoint firewall rule.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FirewallRule>;

  @doc("Updates selected properties of a HorizonDB endpoint firewall rule. Omitted properties preserve their current values.")
  update is ArmCustomPatchSync<FirewallRule, FirewallRuleForPatchUpdate>;

  @doc("Deletes a HorizonDB endpoint firewall rule.")
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPrivateEndpointConnections")
@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is PrivateEndpointOperations.Read<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Lists private endpoint connections in a HorizonDB cluster.")
  list is PrivateEndpointOperations.ListByParent<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Updates a private endpoint connection.")
  @removed(Versions.v2026_05_01_preview)
  @renamedFrom(Versions.v2026_05_01_preview, "update")
  @sharedRoute
  updateLegacy is PrivateEndpointOperations.CustomPatchAsync<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @added(Versions.v2026_10_01)
  @sharedRoute
  update is PrivateEndpointOperations.CustomPatchAsync<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Approves or rejects a private endpoint connection.")
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  updateStatus is PrivateEndpointOperations.CreateOrReplaceSync<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Deletes a private endpoint connection.")
  delete is PrivateEndpointOperations.DeleteAsync<
    Cluster,
    PrivateEndpointConnectionResource,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPrivateLinkResources")
@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets a private link resource.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Lists private link resources in a HorizonDB cluster.")
  list is ArmResourceListByParent<PrivateLinkResource>;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbParameterGroups")
@armResourceOperations
interface ParameterGroups {
  @doc("Gets information about a HorizonDB parameter group.")
  get is ArmResourceRead<ParameterGroup>;

  @doc("Creates a new HorizonDB parameter group or updates an existing parameter group.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ParameterGroup>;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "update")
  @sharedRoute
  @doc("Updates an existing HorizonDB parameter group. A request-wide applyMethod is required and controls when dynamic parameter changes become effective on connected pools. Static parameter changes always require a customer-triggered restart or a restart during scheduled maintenance. The operation fails with a conflict while a previous update to this parameter group is still being applied to connected pools.")
  updateV1 is ArmCustomPatchAsync<ParameterGroup, ParameterGroupForPatchUpdate>;

  @added(Versions.v2026_10_01)
  @sharedRoute
  @doc("Updates an existing HorizonDB parameter group. When parameters is supplied, applyMethod is required and controls when dynamic parameter changes become effective on connected pools. Tags-only and description-only updates do not require applyMethod. Static parameter changes always require a customer-triggered restart or a restart during scheduled maintenance. The operation fails with a conflict while a previous update to this parameter group is still being applied to connected pools.")
  update is ArmCustomPatchAsync<ParameterGroup, ParameterGroupForPatchUpdate>;

  @doc("Deletes a HorizonDB parameter group. Deletion fails with a conflict when the parameter group is associated with one or more pools.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ParameterGroup,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB parameter groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ParameterGroup>;

  @doc("Lists all HorizonDB parameter groups in a subscription.")
  listBySubscription is ArmListBySubscription<ParameterGroup>;

  @doc("Gets all connections to a parameter group.")
  @get
  @list
  @action("connections")
  listConnections is ArmResourceActionSync<
    ParameterGroup,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListResult<ParameterGroupConnectionProperties>>
  >;

  @removed(Versions.v2026_10_01)
  @doc("Lists parameter groups filtered by version number.")
  @get
  @list
  @action("versions")
  listVersions is ArmResourceActionSync<
    ParameterGroup,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListResult<ParameterGroup>>,
    Parameters = {
      @doc("The version number to filter by.")
      @query
      version?: int32;
    }
  >;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@armResourceOperations
interface HorizonDbAdministrators {
  @doc("Gets information about a HorizonDB administrator.")
  get is ArmResourceRead<HorizonDbAdministrator>;

  @doc("Creates a new HorizonDB administrator or updates an existing administrator.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    HorizonDbAdministrator,
    Request = HorizonDbAdministratorAdd
  >;

  @doc("Deletes a HorizonDB administrator.")
  delete is ArmResourceDeleteWithoutOkAsync<
    HorizonDbAdministrator,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB administrators in a cluster.")
  list is ArmResourceListByParent<HorizonDbAdministrator>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom non-resource subscription-level operation with explicit route and parameters."
@added(Versions.v2026_10_01)
@route("/subscriptions/{subscriptionId}/providers/Microsoft.HorizonDb/locations/{location}/parameterGroups")
interface DefaultParameterGroups {
  @doc("Lists default parameter groups available for a subscription in a specific region. The response contains at most one default parameter group for each PostgreSQL version.")
  @get
  @list
  listDefaultParameterGroupsBySubscriptionAndRegion(
    ...ApiVersionParameter,

    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string,

    @doc("The Azure region for which to list default parameter groups.")
    @path
    location: Azure.Core.azureLocation,
  ): ArmResponse<Azure.ResourceManager.ResourceListResult<DefaultParameterGroup>>;

  @doc("Gets a default parameter group available for a subscription in a specific region. Each PostgreSQL version has at most one default parameter group in a location.")
  @route("/{name}")
  @get
  getDefaultParameterGroup(
    ...ApiVersionParameter,

    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string,

    @doc("The Azure region containing the default parameter group.")
    @path
    location: Azure.Core.azureLocation,

    @doc("The name of the default parameter group.")
    @path
    name: string,
  ): ArmResponse<DefaultParameterGroup>;
}
