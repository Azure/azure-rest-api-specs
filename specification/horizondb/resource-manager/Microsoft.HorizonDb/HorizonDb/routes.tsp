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

alias HorizonDbPrivateEndpointOperations = Azure.ResourceManager.PrivateEndpoints<PrivateEndpointConnection>;

@renamedFrom(Versions.v2026_09_01, "HorizonDbClusters")
@armResourceOperations
interface Clusters {
  @doc("Gets information about a HorizonDB cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Creates a new HorizonDB cluster or updates an existing cluster.")
  @removed(Versions.v2026_09_01)
  @renamedFrom(Versions.v2026_09_01, "createOrUpdate")
  @sharedRoute
  createOrUpdateLegacy is ArmResourceCreateOrReplaceAsync<Cluster>;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The AutoRest emitter infers final-state-via from polling metadata. Marking this standard ARM PUT as an LRO without polling decorators emits x-ms-long-running-operation while intentionally omitting x-ms-long-running-operation-options."
  @added(Versions.v2026_09_01)
  @doc("Creates a new HorizonDB cluster or replaces an existing cluster. PointInTimeRestore creates the new Cluster resource and hydrates its service-owned database storage from an available source backup. It does not clone source pools, Pool-scoped endpoints, firewall rules, parameter-group associations, or other child resources. The new Cluster receives its service-generated Cluster-scoped Endpoint named cluster. PostgreSQL version is inherited from backup metadata; all other new-cluster configuration comes from the request or service defaults. Until cross-region point-in-time restore is supported, the target cluster location must match the source cluster location; a cross-region request is rejected synchronously with 400 CrossRegionPointInTimeRestoreNotSupported and does not create or modify a resource.")
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

  @removed(Versions.v2026_09_01)
  @renamedFrom(Versions.v2026_09_01, "update")
  @sharedRoute
  @doc("Updates an existing HorizonDB cluster (e.g., tags, virtual cores, replica count).")
  updateLegacy is ArmCustomPatchAsync<Cluster, ClusterForPatchUpdate>;

  @added(Versions.v2026_09_01)
  @sharedRoute
  @doc("Updates an existing HorizonDB cluster.")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterForPatchUpdate,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    ClusterUpdateAcceptedHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Deletes a HorizonDB cluster.")
  @removed(Versions.v2026_09_01)
  @renamedFrom(Versions.v2026_09_01, "delete")
  @sharedRoute
  deleteLegacy is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @added(Versions.v2026_09_01)
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

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_09_01)
  @doc("Starts a stopped HorizonDB cluster.")
  start is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_09_01)
  @doc("Stops a running HorizonDB cluster.")
  stop is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_09_01)
  @doc("Restarts a HorizonDB cluster.")
  restart is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2026_09_01)
  @doc("Triggers a failover operation for the HorizonDB cluster. The service selects the new read-write node using the same mechanics as automatic failover.")
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

@armResourceOperations
interface HorizonDbPools {
  @doc("Gets information about a HorizonDB pool.")
  get is ArmResourceRead<HorizonDbPool>;

  @doc("Lists all HorizonDB pools in a cluster.")
  list is ArmResourceListByParent<HorizonDbPool>;
}

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

@removed(Versions.v2026_09_01)
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

@added(Versions.v2026_09_01)
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

@armResourceOperations
interface HorizonDbPrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is HorizonDbPrivateEndpointOperations.Read<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Lists private endpoint connections in a HorizonDB cluster.")
  list is HorizonDbPrivateEndpointOperations.ListByParent<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Updates a private endpoint connection.")
  @removed(Versions.v2026_05_01_preview)
  update is HorizonDbPrivateEndpointOperations.CustomPatchAsync<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Approves or rejects a private endpoint connection.")
  @added(Versions.v2026_05_01_preview)
  updateStatus is HorizonDbPrivateEndpointOperations.CreateOrReplaceSync<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Deletes a private endpoint connection.")
  delete is HorizonDbPrivateEndpointOperations.DeleteAsync<
    Cluster,
    PrivateEndpointConnectionResource,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}

@armResourceOperations
interface HorizonDbPrivateLinkResources {
  @doc("Gets a private link resource.")
  get is ArmResourceRead<HorizonDbPrivateLinkResource>;

  @doc("Lists private link resources in a HorizonDB cluster.")
  list is ArmResourceListByParent<HorizonDbPrivateLinkResource>;
}

@armResourceOperations
interface HorizonDbParameterGroups {
  @doc("Gets information about a HorizonDB parameter group.")
  get is ArmResourceRead<HorizonDbParameterGroup>;

  @doc("Creates a new HorizonDB parameter group or updates an existing parameter group.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbParameterGroup>;

  @doc("Updates an existing HorizonDB parameter group.")
  update is ArmCustomPatchAsync<
    HorizonDbParameterGroup,
    HorizonDbParameterGroupForPatchUpdate
  >;

  @doc("Deletes a HorizonDB parameter group.")
  delete is ArmResourceDeleteWithoutOkAsync<
    HorizonDbParameterGroup,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB parameter groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<HorizonDbParameterGroup>;

  @doc("Lists all HorizonDB parameter groups in a subscription.")
  listBySubscription is ArmListBySubscription<HorizonDbParameterGroup>;

  @doc("Gets all connections to a parameter group.")
  @get
  @list
  @action("connections")
  listConnections is ArmResourceActionSync<
    HorizonDbParameterGroup,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListResult<HorizonDbParameterGroupConnectionProperties>>
  >;

  @doc("Lists parameter groups filtered by version number.")
  @get
  @list
  @action("versions")
  listVersions is ArmResourceActionSync<
    HorizonDbParameterGroup,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListResult<HorizonDbParameterGroup>>,
    Parameters = {
      @doc("The version number to filter by.")
      @query
      version?: int32;
    }
  >;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_09_01)
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

@added(Versions.v2026_09_01)
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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Authentication method instances are service-created with the cluster; customers update an existing instance through PATCH and cannot create additional instances."
@added(Versions.v2026_09_01)
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
@added(Versions.v2026_09_01)
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

@added(Versions.v2026_09_01)
@doc("Backup operations for HorizonDB clusters.")
@armResourceOperations
interface Backups {
  @doc("Gets an available backup for a HorizonDB cluster. Expired automatic backups are not available through this operation.")
  get is ArmResourceRead<Backup>;

  @doc("Lists the backups available for a HorizonDB cluster. Expired automatic backups are omitted.")
  list is ArmResourceListByParent<Backup>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This is a custom non-resource subscription-level discovery operation with an explicit route and parameters."
@added(Versions.v2026_09_01)
@route("/subscriptions/{subscriptionId}/providers/Microsoft.HorizonDb/locations/{location}/capabilities")
interface Capabilities {
  @doc("Lists HorizonDB capabilities available to a subscription in a specific region.")
  @get
  @list
  list(
    ...ApiVersionParameter,

    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string,

    @doc("The Azure region for which to list HorizonDB capabilities.")
    @path
    location: Azure.Core.azureLocation,
  ): ArmResponse<Azure.ResourceManager.ResourceListResult<LocationCapability>>;
}
