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

@renamedFrom(Versions.v2026_10_01_preview, "HorizonDbClusters")
@armResourceOperations
interface Clusters {
  @doc("Gets information about a HorizonDB cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Creates a new HorizonDB cluster or updates an existing cluster.")
  @removed(Versions.v2026_10_01_preview)
  @renamedFrom(Versions.v2026_10_01_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateLegacy is ArmResourceCreateOrReplaceAsync<Cluster>;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The AutoRest emitter infers final-state-via from polling metadata. Marking this standard ARM PUT as an LRO without polling decorators emits x-ms-long-running-operation while intentionally omitting x-ms-long-running-operation-options."
  @added(Versions.v2026_10_01_preview)
  @doc("Creates a new HorizonDB cluster or replaces an existing cluster. PointInTimeRestore creates the new Cluster resource and hydrates its service-owned database storage from an available source backup. It does not clone source pools, Pool-scoped endpoints, firewall rules, parameter-group associations, or other child resources. The new Cluster receives its service-generated Cluster-scoped Endpoint named cluster. For restore, postgreSqlVersion must be omitted because the service obtains it from backup metadata; all other new-cluster configuration comes from the request or service defaults. Same-location restore requires and honors pointInTimeUtc and allows creationSourceClusterLocation to be omitted. Cross-location restore requires creationSourceClusterLocation to identify the source cluster's Azure location and requires pointInTimeUtc, but ignores the supplied timestamp and restores the latest available backup. Cross-location responses omit pointInTimeUtc.")
  @sharedRoute
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  @autoRoute
  @armResourceCreateOrUpdate(Cluster)
  @put
  createOrReplace is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<Cluster>,
    Cluster,
    ClusterReplaceAcceptedResponse | ClusterCreateAcceptedResponse,
    ErrorResponse
  >;

  @removed(Versions.v2026_10_01_preview)
  @renamedFrom(Versions.v2026_10_01_preview, "update")
  @sharedRoute
  @doc("Updates an existing HorizonDB cluster (e.g., tags, virtual cores, replica count).")
  updateLegacy is ArmCustomPatchAsync<Cluster, ClusterForPatchUpdate>;

  @added(Versions.v2026_10_01_preview)
  @sharedRoute
  @doc("Updates an existing HorizonDB cluster.")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterForPatchUpdate,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    ClusterUpdateAcceptedHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Deletes a HorizonDB cluster.")
  @removed(Versions.v2026_10_01_preview)
  @renamedFrom(Versions.v2026_10_01_preview, "delete")
  @sharedRoute
  deleteLegacy is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @added(Versions.v2026_10_01_preview)
  @doc("Deletes a HorizonDB cluster, its Cluster-scoped Endpoint, and all remaining child resources. For an accepted deletion, the long-running operation remains nonterminal until physical deletion completes and point GET returns 404 Not Found.")
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

  @added(Versions.v2026_10_01_preview)
  @doc("Triggers failover within the cluster's designated read-write pool. HorizonDB selects the replacement node using the same eligibility and node-selection rules as automatic failover. The request fails with 409 Conflict when the designated pool is not eligible for failover or another conflicting operation is in progress.")
  @action("failover")
  failover is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01_preview)
  @doc("Starts a stopped HorizonDB cluster.")
  start is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01_preview)
  @doc("Stops a running HorizonDB cluster.")
  stop is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01_preview)
  @doc("Restarts a HorizonDB cluster.")
  restart is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;
}

@renamedFrom(Versions.v2026_10_01_preview, "HorizonDbPools")
@armResourceOperations
interface Pools {
  @doc("Gets information about a HorizonDB pool.")
  get is ArmResourceRead<Pool>;

  @added(Versions.v2026_10_01_preview)
  @doc("Creates a new HorizonDB pool or replaces an existing pool, including its node allocation, compute model, high-availability configuration, or associated parameter group. nodeCount and highAvailability.mode are required and have no service defaults. nodeCount must be 1 through 16. Disabled is valid only when nodeCount is 1. AnyZone and ZoneRedundant are valid only when nodeCount is 2 through 16. AnyZone permits same-zone or cross-zone placement, while ZoneRedundant requires nodes to be allocated across availability zones. Node allocation and high-availability reconfiguration are atomic: if all requested nodes or the required zonal topology cannot be provisioned, the long-running operation fails and the previous resource state is preserved. A pool name must differ from its parent cluster name because the Cluster-scoped ReadWrite Endpoint is named after the Cluster and the Pool-scoped ReadOnly Endpoint is named after the Pool; the service rejects a request whose names would collide. Creating a pool also creates exactly one service-managed Pool-scoped ReadOnly Endpoint representing that Pool and its network boundary. The Endpoint's associatedResourceId identifies the Pool, and the Endpoint cannot outlive or be deleted independently from it. When the first pool is created, the service automatically designates it to host the cluster's read-write node when an eligible node is available. A Cluster must contain at least one Pool before a private endpoint connection can be created or approved. This API version supports at most one pool per cluster; an attempt to create another pool is rejected with 409 Conflict. parameterGroup, parameterGroupResourceId, and applyMethod are required. When creating a new pool in this API version, parameterGroupResourceId must identify the corresponding default parameter group; a customer-created parameter group is rejected. When replacing an existing pool, the request can switch its association in either direction between the corresponding default parameter group and a customer-created parameter group. applyMethod controls when dynamic parameter changes become effective. Static parameter changes always require a customer-initiated Restart; Stop followed by Start and scheduled maintenance do not apply pending changes. Subtype-specific compute constraints are validated before the resource is changed.")
  @sharedRoute
  @autoRoute
  @armResourceCreateOrUpdate(Pool)
  @put
  createOrReplace is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<Pool>,
    Pool,
    HorizonDbResourceUpdatedLroResponse<Pool> | PoolCreateAcceptedResponse,
    ErrorResponse
  >;

  @added(Versions.v2026_10_01_preview)
  @doc("Updates an existing HorizonDB pool, including its node allocation, selected compute model properties, compute model type, high-availability configuration, or associated parameter group. Omitted nodeCount and highAvailability.mode values preserve their existing values; the service recursively merges the PATCH before atomically validating the effective tuple. nodeCount, when supplied, must be 1 through 16. Disabled is valid only when the effective nodeCount is 1. AnyZone and ZoneRedundant are valid only when the effective nodeCount is 2 through 16. Therefore, crossing between those node-count ranges requires nodeCount and highAvailability.mode to be changed together. AnyZone permits same-zone or cross-zone placement. Changing from AnyZone to ZoneRedundant may allocate a replacement node in another availability zone and replace a read-only node, disconnecting connections to the replaced node. If all requested nodes or the required zonal topology cannot be provisioned, the long-running operation fails and the previous resource state is preserved. To deallocate runtime compute without changing the configured nodeCount, use the Pool stop action. When parameterGroup is supplied, both parameterGroupResourceId and applyMethod are required. The pool can switch its association in either direction between the corresponding default parameter group and a customer-created parameter group. applyMethod controls when dynamic parameter changes become effective. Static parameter changes always require a customer-initiated Restart; Stop followed by Start and scheduled maintenance do not apply pending changes. Subtype-specific compute constraints are validated against the recursively merged configuration.")
  update is ArmCustomPatchAsync<
    Pool,
    PoolForPatchUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Pool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_10_01_preview)
  @doc("Deletes a HorizonDB pool together with the Pool-scoped Endpoint whose associatedResourceId identifies that Pool and all FirewallRule children of that Endpoint. The Endpoint cannot outlive or be deleted independently from its Pool. When this is the Cluster's last surviving Pool, the service also disconnects every existing private endpoint connection associated with the Cluster by setting its privateLinkServiceConnectionState.status to Rejected and providing a description that the last Pool was deleted. The HorizonDB private endpoint connection resources remain available for inspection and cleanup, and customer-owned Microsoft.Network/privateEndpoints resources are not deleted. The delete long-running operation completes only after all required private endpoint disconnections have completed.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Pool,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB pools in a cluster.")
  list is ArmResourceListByParent<Pool>;

  @added(Versions.v2026_10_01_preview)
  @doc("Starts a stopped HorizonDB pool. Power operations are supported only at pool scope in this API version; there is no cluster-level start action. Start does not apply pending dynamic or static parameter changes; parameterGroup.syncStatus remains PendingReboot until a customer-initiated Restart. When the pool is already Ready, the operation succeeds as a true idempotent no-op and likewise leaves pending parameter changes pending. The operation is allowed when the pool has no allocated nodes. After the Pool is running, its Pool-scoped ReadOnly Endpoint routes only when at least one allocated node is not currently playing the read-write role. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
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

  @added(Versions.v2026_10_01_preview)
  @doc("Stops a running HorizonDB pool and deallocates compute. Power operations are supported only at pool scope in this API version; there is no cluster-level stop action. Stop does not apply pending dynamic or static parameter changes; parameterGroup.syncStatus remains PendingReboot. A subsequent Start also preserves those pending changes. The operation succeeds as an idempotent no-op when the pool is already Stopped. It is allowed when the pool has no allocated nodes. The Pool-scoped ReadOnly Endpoint remains discoverable but has no routing destination while the Pool is Stopped. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
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

  @added(Versions.v2026_10_01_preview)
  @doc("Restarts the PostgreSQL container on all allocated nodes in a ready HorizonDB pool and applies pending dynamic and static parameter changes. This customer-initiated Restart is the only operation that applies static parameter changes or dynamic parameter changes requested with PendingReboot; Stop followed by Start and scheduled maintenance do not apply them. Power operations are supported only at pool scope in this API version; there is no cluster-level restart action. When the pool has no allocated nodes, the operation succeeds without restarting any nodes, pending changes are considered applied, parameterGroup.syncStatus becomes InSync, and the resulting configuration applies to nodes allocated later. The request fails with 409 Conflict when another operation is in progress or the pool is in any other incompatible state.")
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

@removed(Versions.v2026_10_01_preview)
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

@removed(Versions.v2026_10_01_preview)
@armResourceOperations
interface HorizonDbFirewallRules {
  @doc("Gets information about a HorizonDB firewall rule.")
  @sharedRoute
  get is ArmResourceRead<LegacyHorizonDbFirewallRule>;

  @doc("Lists all HorizonDB firewall rules in a pool.")
  @sharedRoute
  list is ArmResourceListByParent<LegacyHorizonDbFirewallRule>;

  @doc("Creates a new HorizonDB firewall rule or updates an existing rule.")
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LegacyHorizonDbFirewallRule>;

  @doc("Deletes a HorizonDB firewall rule.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    LegacyHorizonDbFirewallRule,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}

@added(Versions.v2026_10_01_preview)
@armResourceOperations
interface FirewallRules {
  @doc("Gets information about a HorizonDB pool firewall rule.")
  @sharedRoute
  get is ArmResourceRead<FirewallRule>;

  @doc("Lists all HorizonDB firewall rules in a pool.")
  @sharedRoute
  list is ArmResourceListByParent<FirewallRule>;

  @doc("Creates or replaces a HorizonDB pool firewall rule.")
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    FirewallRule,
    LroHeaders = HorizonDbResourceLroHeaders<FirewallRule>,
    Response =
      | HorizonDbResourceUpdatedLroResponse<FirewallRule>
      | ArmResourceCreatedResponse<
          FirewallRule,
          HorizonDbResourceLroHeaders<FirewallRule>
        >
  >;

  @doc("Deletes a HorizonDB pool firewall rule.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}

@renamedFrom(
  Versions.v2026_10_01_preview,
  "HorizonDbPrivateEndpointConnections"
)
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

  @doc("Approves or rejects an existing private endpoint connection. Approval requires the parent Cluster to contain at least one Pool. An approval attempt when the Cluster has no Pools fails with 409 Conflict and the stable error code PrivateEndpointRequiresPool. Rejection remains allowed when the Cluster has no Pools so that existing connections can be cleaned up.")
  @added(Versions.v2026_10_01_preview)
  @sharedRoute
  approveOrReject is PrivateEndpointOperations.CreateOrReplaceAsync<
    Cluster,
    PrivateEndpointConnectionResource,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnectionResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Approves or rejects a private endpoint connection.")
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01_preview)
  @sharedRoute
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

@renamedFrom(Versions.v2026_10_01_preview, "HorizonDbPrivateLinkResources")
@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets a private link resource.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Lists private link resources in a HorizonDB cluster.")
  list is ArmResourceListByParent<PrivateLinkResource>;
}

@renamedFrom(Versions.v2026_10_01_preview, "HorizonDbParameterGroups")
@armResourceOperations
interface ParameterGroups {
  @doc("Gets information about a HorizonDB parameter group.")
  get is ArmResourceRead<ParameterGroup>;

  @doc("Creates a new HorizonDB parameter group or updates an existing parameter group.")
  @removed(Versions.v2026_10_01_preview)
  @renamedFrom(Versions.v2026_10_01_preview, "createOrUpdate")
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdateLegacy is ArmResourceCreateOrReplaceAsync<ParameterGroup>;

  @added(Versions.v2026_10_01_preview)
  @doc("Creates a new HorizonDB parameter group or replaces an existing parameter group.")
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ParameterGroup>;

  @removed(Versions.v2026_10_01_preview)
  @renamedFrom(Versions.v2026_10_01_preview, "update")
  @sharedRoute
  @doc("Updates an existing HorizonDB parameter group.")
  updateV1 is ArmCustomPatchAsync<ParameterGroup, ParameterGroupForPatchUpdate>;

  @added(Versions.v2026_10_01_preview)
  @sharedRoute
  @doc("Updates an existing HorizonDB parameter group. Each connected pool's applyMethod setting controls whether dynamic parameter changes become effective immediately or remain pending until a customer-initiated pool Restart. Static parameter changes always remain pending until a customer-initiated pool Restart. Stop followed by Start and scheduled maintenance do not apply pending changes. The operation fails with a conflict while a previous update to this parameter group is still being processed.")
  update is ArmCustomPatchAsync<ParameterGroup, ParameterGroupForPatchUpdate>;

  @removed(Versions.v2026_10_01_preview)
  @renamedFrom(Versions.v2026_10_01_preview, "delete")
  @sharedRoute
  @doc("Deletes a HorizonDB parameter group.")
  deleteV1 is ArmResourceDeleteWithoutOkAsync<
    ParameterGroup,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @added(Versions.v2026_10_01_preview)
  @sharedRoute
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
  @returnTypeChangedFrom(
    Versions.v2026_10_01_preview,

      | ArmResponse<Azure.ResourceManager.ResourceListResult<ParameterGroupConnectionProperties>>
      | ErrorResponse
  )
  listConnections is ArmResourceActionSync<
    ParameterGroup,
    void,
    ArmResponse<PagedParameterGroupConnectionProperties>
  >;

  @removed(Versions.v2026_10_01_preview)
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

@added(Versions.v2026_10_01_preview)
@armResourceOperations
interface DefaultParameterGroups {
  @doc("Lists default parameter groups available for a subscription in a specific region. The response contains at most one default parameter group for each PostgreSQL version.")
  listBySubscriptionAndRegion is ArmResourceListByParent<DefaultParameterGroup>;

  @doc("Gets a default parameter group available for a subscription in a specific region. Each PostgreSQL version has at most one default parameter group in a location.")
  get is ArmResourceRead<DefaultParameterGroup>;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01_preview)
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

@added(Versions.v2026_10_01_preview)
@doc("Operations for PostgreSQL roles that are members of azure_pg_admin and mapped to Microsoft Entra principals.")
@armResourceOperations
interface MicrosoftEntraAdministrators {
  @doc("Gets information about a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
  get is ArmResourceRead<MicrosoftEntraAdministrator>;

  @doc("Creates or replaces a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    MicrosoftEntraAdministrator,
    Request = MicrosoftEntraAdministratorAdd,
    LroHeaders = HorizonDbResourceLroHeaders<MicrosoftEntraAdministrator>,
    Response =
      | HorizonDbResourceUpdatedLroResponse<MicrosoftEntraAdministrator>
      | ArmResourceCreatedResponse<
          MicrosoftEntraAdministrator,
          HorizonDbResourceLroHeaders<MicrosoftEntraAdministrator>
        >
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

@added(Versions.v2026_10_01_preview)
@doc("Operations for the service-created authentication methods of a HorizonDB cluster.")
@armResourceOperations
interface Authentications {
  @doc("Lists the two service-created authentication configurations for the cluster: passwordMethod and microsoftEntra.")
  list is ArmResourceListByParent<Authentication>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
@added(Versions.v2026_10_01_preview)
@doc("Operations for the service-created PostgreSQL username-and-password authentication method of a HorizonDB cluster.")
@armResourceOperations
interface PasswordAuthentications {
  @doc("Gets the service-created PostgreSQL username-and-password authentication method.")
  @autoRoute
  @get
  get is ArmResourceRead<PasswordAuthentication>;

  @doc("Creates or replaces the service-created PostgreSQL username-and-password authentication method.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    PasswordAuthentication,
    LroHeaders = HorizonDbResourceLroHeaders<PasswordAuthentication>,
    Response =
      | HorizonDbResourceUpdatedLroResponse<PasswordAuthentication>
      | ArmResourceCreatedResponse<
          PasswordAuthentication,
          HorizonDbResourceLroHeaders<PasswordAuthentication>
        >
  >;

  @doc("Updates the service-created PostgreSQL username-and-password authentication method. The request is sparse and omitted properties preserve their current values. This API version supports enabling the method, disabling the method, and resetting its password. For a cluster that already has an administrator but currently has password authentication disabled, state Enabled and administratorLoginPassword can be supplied together to re-enable password authentication and reset the password. Disabling cannot include credentials and does not remove or modify existing database users or roles. Administrator rename is not supported in this API version.")
  @autoRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    PasswordAuthentication,
    PasswordAuthenticationForPatchUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = PasswordAuthentication> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Authentication method instances are service-created with the cluster; customers update an existing instance through PATCH and cannot create additional instances."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-list-operation" "The shared authentications collection list operation is defined by Authentications.list and returns both constrained resource instances."
@added(Versions.v2026_10_01_preview)
@doc("Operations for the service-created Microsoft Entra authentication method of a HorizonDB cluster.")
@armResourceOperations
interface MicrosoftEntraAuthentications {
  @doc("Gets the service-created Microsoft Entra authentication method.")
  @autoRoute
  @get
  @armResourceRead(Authentication)
  get is Azure.ResourceManager.Foundations.ArmReadOperation<
    ResourceInstanceParameters<MicrosoftEntraAuthentication>,
    ArmResponse<Authentication>,
    ErrorResponse
  >;

  @doc("Updates the service-created Microsoft Entra authentication method. State Enabled enables the feature and State Disabled disables it; no additional properties are required. Disabling the feature does not remove or modify database roles or users previously created through the MicrosoftEntraAdministrators control-plane API or directly through pgaadauth extension functions.")
  @autoRoute
  @armResourceUpdate(Authentication)
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is Azure.ResourceManager.Foundations.ArmUpdateOperation<
    ResourceInstanceParameters<MicrosoftEntraAuthentication>,
    MicrosoftEntraAuthenticationForPatchUpdate,
    Response =
      | ArmResponse<Authentication>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Authentication> &
          Azure.Core.Foundations.RetryAfterHeader>,
    ErrorResponse = ErrorResponse
  >;
}
