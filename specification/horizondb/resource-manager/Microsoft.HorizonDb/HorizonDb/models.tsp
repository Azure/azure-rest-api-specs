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

@doc("A HorizonDB cluster name used before enforcing lowercase names.")
@pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
@minLength(1)
@maxLength(63)
scalar LegacyClusterName extends string;

@doc("A lowercase enforced name as a HorizonDB cluster name.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar ClusterName extends string;

@doc("A HorizonDB pool name used before allowing one-character names.")
@pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
@minLength(1)
@maxLength(63)
scalar LegacyPoolName extends string;

@doc("A lowercase enforced name as a HorizonDB pool name.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar PoolName extends string;

@added(Versions.v2026_10_01)
@doc("A customer-chosen DNS base name for a HorizonDB endpoint. The service validates that the name is globally available across HorizonDB endpoint DNS names.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar EndpointBaseName extends string;

@added(Versions.v2026_10_01)
@doc("A customer-selected lowercase DNS segment used as a HorizonDB endpoint alias.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar EndpointAlias extends string;

@added(Versions.v2026_10_01)
@doc("A user-supplied description with a maximum length of 1024 characters.")
@maxLength(1024)
scalar WritableDescription extends string;

@added(Versions.v2026_10_01)
@doc("An IPv4 address in dotted-decimal notation.")
@pattern("^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])[.]){3}(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$")
scalar DottedDecimalIpv4Address extends string;

@added(Versions.v2026_10_01)
@doc("A provisioned HorizonDB pool compute capacity in vCores, from 1 through 192.")
@minValue(1)
@maxValue(192)
scalar ProvisionedPoolVCores extends int32;

@added(Versions.v2026_10_01)
@doc("A serverless HorizonDB pool compute capacity in vCores, from 0.5 through 192.")
@minValue(0.5)
@maxValue(192)
scalar ServerlessPoolVCores extends float32;

@added(Versions.v2026_10_01)
@doc("A HorizonDB pool node count, from 0 through 16.")
@minValue(0)
@maxValue(16)
scalar PoolNodeCount extends int32;

@renamedFrom(Versions.v2026_10_01, "HorizonDbCluster")
@doc("Represents the HorizonDB cluster.")
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  @doc("The name of the HorizonDB cluster.")
  @key("clusterName")
  @path
  @segment("clusters")
  @typeChangedFrom(Versions.v2026_10_01, LegacyClusterName)
  name: ClusterName;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPool")
@doc("Represents the HorizonDB pool.")
@parentResource(Cluster)
model Pool is Azure.ResourceManager.ProxyResource<PoolProperties> {
  @doc("The name of the HorizonDB pool.")
  @key("poolName")
  @path
  @segment("pools")
  @typeChangedFrom(Versions.v2026_10_01, LegacyPoolName)
  name: PoolName;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags are valid in v2026-01-20-preview and removed in v2026-10-01"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> is acceptable for tags in this version"
  @removed(Versions.v2026_10_01)
  @doc("Resource tags.")
  tags?: Record<string>;
}

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

@added(Versions.v2026_10_01)
@doc("Represents a service-generated, service-managed HorizonDB endpoint. The Cluster-scoped Endpoint is created and deleted with its parent Cluster. A Pool-scoped Endpoint is created and deleted with the Pool identified by associatedResourceId. Endpoints cannot be created or deleted independently from their lifecycle owner.")
@parentResource(Cluster)
model Endpoint is Azure.ResourceManager.ProxyResource<EndpointProperties> {
  @doc("The service-generated name of the HorizonDB endpoint. The Cluster-scoped Endpoint is named cluster. Pool-scoped Endpoint names use the form pool-NN, where NN is a two-digit sequence number.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("endpointName")
  @path
  @segment("endpoints")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("Represents stable writer and reader DNS aliases for a HorizonDB replication topology. For regional resilience, customers should deploy the VirtualEndpoint in an Azure region that has a paired region and that is different from every Cluster region in the referenced replication set. This is a recommendation only: the service does not validate or enforce it, and any otherwise supported location remains accepted. Separating the VirtualEndpoint control-plane resource from all replication-set Cluster regions can help it survive a regional outage affecting the root Cluster and remain available for promote or switchover recovery workflows, but does not guarantee availability.")
model VirtualEndpoint
  is Azure.ResourceManager.TrackedResource<VirtualEndpointProperties> {
  @doc("The globally unique DNS base name of the virtual endpoint. The writer FQDN is <name>.writer.horizondb.azure.com and the reader FQDN is <name>.reader.horizondb.azure.com.")
  @key("virtualEndpointName")
  @path
  @segment("virtualEndpoints")
  name: EndpointBaseName;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "The resource has the fixed literal name passwordMethod, which is more restrictive than a pattern."
@added(Versions.v2026_10_01)
@doc("The service-created PostgreSQL username-and-password authentication method for a HorizonDB cluster. This resource configures the authentication mechanism, including its enabled state and administrator login credentials; it is not a password-only resource.")
@parentResource(Cluster)
model PasswordAuthentication
  is Azure.ResourceManager.ProxyResource<PasswordAuthenticationProperties> {
  @doc("The fixed name of the PostgreSQL username-and-password authentication method.")
  @key("authenticationName")
  @path
  @segment("authentications")
  name: "passwordMethod";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "The resource has the fixed literal name microsoftEntra, which is more restrictive than a pattern."
@added(Versions.v2026_10_01)
@doc("The service-created Microsoft Entra authentication method for a HorizonDB cluster.")
@parentResource(Cluster)
model MicrosoftEntraAuthentication
  is Azure.ResourceManager.ProxyResource<MicrosoftEntraAuthenticationProperties> {
  @doc("The fixed name of the Microsoft Entra authentication method.")
  @key("authenticationName")
  @path
  @segment("authentications")
  name: "microsoftEntra";
}

@added(Versions.v2026_10_01)
@doc("A service-created authentication configuration returned by the authentications collection. The resource name is passwordMethod or microsoftEntra.")
model Authentication {
  @doc("The Azure resource ID of the service-created authentication configuration.")
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("The fixed name of the service-created authentication configuration.")
  @visibility(Lifecycle.Read)
  name: AuthenticationName;

  @doc("The Azure resource type.")
  @visibility(Lifecycle.Read)
  type: "Microsoft.HorizonDb/clusters/authentications";

  @doc("The authentication configuration properties.")
  @visibility(Lifecycle.Read)
  properties: AuthenticationProperties;
}

@added(Versions.v2026_10_01)
@doc("The name of a service-created authentication configuration.")
union AuthenticationName {
  string,

  @doc("PostgreSQL username-and-password authentication.")
  PasswordMethod: "passwordMethod",

  @doc("Microsoft Entra authentication.")
  MicrosoftEntra: "microsoftEntra",
}

@added(Versions.v2026_10_01)
@doc("Common read-only properties of a service-created authentication configuration.")
model AuthenticationProperties {
  @doc("The state of the authentication configuration.")
  @visibility(Lifecycle.Read)
  state: AuthenticationState;

  @doc("The provisioning state of the authentication configuration.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Represents a maintenance event for a HorizonDB pool.")
@parentResource(Pool)
model MaintenanceEvent
  is Azure.ResourceManager.ProxyResource<MaintenanceEventProperties> {
  @doc("The identifier of the maintenance event.")
  @pattern("^[A-Z0-9]{4}-[A-Z0-9]{3}$")
  @minLength(8)
  @maxLength(8)
  @key("maintenanceEventId")
  @path
  @segment("maintenanceEvents")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("Represents an available backup for a HorizonDB cluster.")
@parentResource(Cluster)
model Backup is Azure.ResourceManager.ProxyResource<BackupResourceProperties> {
  @doc("The name of the HorizonDB backup.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,62}$")
  @minLength(1)
  @maxLength(63)
  @key("backupName")
  @path
  @segment("backups")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("Represents a PostgreSQL role that is a member of the azure_pg_admin role and is mapped to a Microsoft Entra principal.")
@parentResource(Cluster)
model MicrosoftEntraAdministrator
  is Azure.ResourceManager.ProxyResource<MicrosoftEntraAdministratorProperties> {
  @doc("The Microsoft Entra object identifier of the principal mapped to the PostgreSQL role, represented as an RFC 4122 GUID.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  @key("objectId")
  @path
  @segment("microsoftEntraAdministrators")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("Represents a system-managed AI model for a HorizonDB cluster. System AI models are supported only on provisioned clusters.")
@parentResource(Cluster)
model SystemAiModel
  is Azure.ResourceManager.ProxyResource<SystemAiModelProperties> {
  ...ResourceNameParameter<
    Resource = SystemAiModel,
    KeyName = "objectId",
    SegmentName = "systemAiModels",
    NamePattern = ""
  >;
}

@removed(Versions.v2026_10_01)
@renamedFrom(Versions.v2026_10_01, "HorizonDbFirewallRule")
@doc("Represents the HorizonDB firewall rule.")
@parentResource(Pool)
model LegacyHorizonDbFirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties> {
  @doc("The name of the HorizonDB firewall rule.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(128)
  @key("firewallRuleName")
  @path
  @segment("firewallRules")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("Represents a customer-managed firewall rule for a HorizonDB endpoint.")
@parentResource(Endpoint)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties> {
  @doc("The name of the HorizonDB endpoint firewall rule.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(128)
  @key("firewallRuleName")
  @path
  @segment("firewallRules")
  name: string;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPrivateLinkResource")
@doc("Represents the HorizonDB private link resource.")
@parentResource(Cluster)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @pattern("^.*$")
  @minLength(1)
  @maxLength(128)
  @key("groupName")
  @path
  @segment("privateLinkResources")
  name: string;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbParameterGroup")
@doc("Represents the HorizonDB parameter group.")
model ParameterGroup
  is Azure.ResourceManager.TrackedResource<ParameterGroupProperties> {
  @doc("The name of the HorizonDB parameter group.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("parameterGroupName")
  @path
  @segment("parameterGroups")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("Represents an Entra ID administrator configured on a HorizonDB cluster.")
@parentResource(Cluster)
model HorizonDbAdministrator
  is Azure.ResourceManager.ProxyResource<HorizonDbAdministratorProperties> {
  @doc("The Entra ID object identifier of the principal (an RFC 4122 GUID).")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  @key("objectId")
  @path
  @segment("administrators")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("Properties of the service-created PostgreSQL username-and-password authentication method. The control plane stores no administrator identity; PostgreSQL is the source of truth for the sole member of the service-owned administrator role.")
model PasswordAuthenticationProperties {
  @doc("The state of PostgreSQL username-and-password authentication.")
  @visibility(Lifecycle.Read)
  state: AuthenticationState;

  @doc("The provisioning state of the PostgreSQL username-and-password authentication method.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties of the service-created Microsoft Entra authentication method.")
model MicrosoftEntraAuthenticationProperties {
  @doc("The state of Microsoft Entra authentication.")
  @visibility(Lifecycle.Read)
  state: AuthenticationState;

  @doc("The provisioning state of the Microsoft Entra authentication method.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties for updating PostgreSQL username-and-password authentication. Omitted properties preserve their current values. State-only requests enable or disable the authentication mechanism. Credentials are secrets and are never returned or stored by the control plane. Login-only, password-only, and combined credential updates require this authentication method to already be Enabled unless the request also sets state to Enabled.")
model PasswordAuthenticationPropertiesForPatchUpdate {
  @doc("The target password-authentication state. Enabled or Disabled can be supplied without credentials to toggle the feature. Disabled cannot be combined with administratorLogin or administratorLoginPassword. Disabling password authentication does not remove or modify existing database users or roles.")
  @visibility(Lifecycle.Update)
  state?: AuthenticationState;

  @doc("The PostgreSQL administrator role name. A login-only update requires password authentication to already be Enabled unless state is set to Enabled in this request, and requires exactly one member in the AzureSU-owned special group. The current name is an idempotent no-op; a different name renames the current member only when that target role does not already exist. When supplied together with administratorLoginPassword, this value can create the administrator if the special group has no member, reset the matching member's password, or rename a differently named member and reset its password.")
  @secret
  @minLength(1)
  @maxLength(63)
  @visibility(Lifecycle.Update)
  administratorLogin?: string;

  @doc("The PostgreSQL administrator password. A password-only update requires password authentication to already be Enabled unless state is set to Enabled in this request, and requires exactly one member in the AzureSU-owned special group. When supplied together with administratorLogin, it can create the administrator if the special group has no member, reset the matching member's password, or rename a differently named member and reset its password.")
  @secret
  @minLength(8)
  @maxLength(128)
  @visibility(Lifecycle.Update)
  administratorLoginPassword?: string;
}

@added(Versions.v2026_10_01)
@doc("Properties for updating Microsoft Entra authentication. State Enabled enables the feature and State Disabled disables it. Disabling Microsoft Entra authentication does not remove or modify database roles or users previously created through the MicrosoftEntraAdministrators control-plane API or directly through pgaadauth extension functions.")
model MicrosoftEntraAuthenticationPropertiesForPatchUpdate {
  @doc("The target Microsoft Entra authentication state. Omission preserves the current state.")
  @visibility(Lifecycle.Update)
  state?: AuthenticationState;
}

@added(Versions.v2026_10_01)
@doc("A sparse update request for PostgreSQL username-and-password authentication.")
model PasswordAuthenticationForPatchUpdate {
  @doc("The PostgreSQL username-and-password authentication properties to update.")
  properties?: PasswordAuthenticationPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("A sparse update request for Microsoft Entra authentication.")
model MicrosoftEntraAuthenticationForPatchUpdate {
  @doc("The Microsoft Entra authentication properties to update.")
  properties?: MicrosoftEntraAuthenticationPropertiesForPatchUpdate;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbClusterProperties")
@doc("Properties of a HorizonDB cluster.")
model ClusterProperties {
  @removed(Versions.v2026_10_01)
  @doc("The administrator login name.")
  @minLength(1)
  @maxLength(63)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  administratorLogin: string;

  @removed(Versions.v2026_10_01)
  @doc("The administrator login password.")
  @secret
  @minLength(8)
  @maxLength(128)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  administratorLoginPassword?: string;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "version")
  @doc("The version of PostgreSQL used by the HorizonDB cluster.")
  legacyPgVersion?: string;

  @added(Versions.v2026_10_01)
  @doc("The PostgreSQL major version used by the HorizonDB cluster. API version 2026-10-01 accepts only 17. This property is required on every PUT and is immutable after creation. On replacement, resubmitting the existing value is accepted and changing it is rejected. For point-in-time restore, PostgreSQL version is the only new-cluster property inherited from the source backup metadata, and the value in the request must match that version. All other new-cluster configuration comes from the request or service defaults. Future API versions may add supported values without changing this property type.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  postgreSqlVersion: PostgreSqlVersion;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "createMode")
  @doc("The mode to create a new HorizonDB cluster.")
  legacyCreateMode?: CreateModeCluster;

  @added(Versions.v2026_10_01)
  @doc("The mode used to create the cluster. When this property is omitted while creating a new cluster, the service records Create. PointInTimeRestore creates a new cluster from an available backup; pointInTimeUtc and creationSourceClusterResourceId are then required, postgreSqlVersion must match the source backup's major version, and the target cluster location must match the source cluster location until cross-region point-in-time restore is supported. Set it to AsyncReplica only when creating an asynchronous replica; creationSourceClusterResourceId is then required, pointInTimeUtc must be absent, and the source can be in the same Azure region or a different Azure region. This property is immutable and is returned as creation provenance. On replacement, omission preserves the recorded value, resubmitting the same value is accepted, and changing it is rejected.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  creationMode?: ClusterCreateMode;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "pointInTimeUTC")
  @doc("Restore point creation time specifying the time to restore from.")
  legacyPointInTime?: utcDateTime;

  @added(Versions.v2026_10_01)
  @doc("The requested point in time, in UTC, to restore from. This property is required when creationMode is PointInTimeRestore and must be absent when creationMode is Create, AsyncReplica, or omitted. The service honors this value for same-region restore. Until cross-region point-in-time restore is supported, the target cluster location must match the source cluster location; a cross-region request is rejected synchronously with 400 CrossRegionPointInTimeRestoreNotSupported and does not create or modify a resource. This property can only be specified during resource creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  pointInTimeUtc?: utcDateTime;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "sourceClusterResourceId")
  @doc("The source cluster resource ID for restore or node creation.")
  legacySourceClusterResourceId?: armResourceIdentifier;

  @added(Versions.v2026_10_01)
  @doc("The Azure resource ID of the source HorizonDB cluster supplied when this cluster was created by point-in-time restore or as an asynchronous replica. This property is required when creationMode is PointInTimeRestore or AsyncReplica and must be absent when creationMode is Create or omitted. AsyncReplica allows the source to be in the same Azure region as the new cluster or in a different Azure region. Until cross-region point-in-time restore is supported, PointInTimeRestore requires the target and source clusters to be in the same Azure region. A source cluster does not need to have a pool to be restored, provided an available backup exists. This immutable creation-provenance value does not change when topology operations change the cluster's current immediate source; use replication.sourceClusterResourceId for the current topology. It can only be specified during resource creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  creationSourceClusterResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters";
    }
  ]>;

  @added(Versions.v2026_10_01)
  @doc("The replication-set metadata for this cluster. This property is present on every cluster that belongs to a replication set, including the current root cluster and replicas created with creationMode AsyncReplica.")
  @visibility(Lifecycle.Read)
  replication?: ClusterReplicationProperties;

  @removed(Versions.v2026_10_01)
  @doc("The pool name for restore or node operations.")
  poolName?: string;

  @removed(Versions.v2026_10_01)
  @doc("Number of replicas.")
  @minValue(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  replicaCount?: int32;

  @removed(Versions.v2026_10_01)
  @doc("Number of vCores.")
  @minValue(1)
  @maxValue(96)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  vCores?: int32;

  @removed(Versions.v2026_10_01)
  @doc("The processor type for the HorizonDB cluster.")
  processorType?: string;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "network")
  @doc("The network related info.")
  legacyNetwork?: Network;

  @added(Versions.v2026_10_01)
  @doc("The network configuration for the cluster. When this object is omitted, the service defaults it to publicAccess Disabled.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  network?: Network = #{ publicAccess: "Disabled" };

  @added(Versions.v2026_10_01)
  @doc("The backup configuration for the cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  backup?: BackupProperties;

  @added(Versions.v2026_10_01)
  @doc("The deletion configuration and current deletion-blocking status for the cluster. When this object is omitted while creating a new cluster, the service records policy Immediate. When it is omitted from a replacement PUT, the existing policy is preserved.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  deletion?: ClusterDeletionProperties;

  @typeChangedFrom(Versions.v2026_10_01, State)
  @madeRequired(Versions.v2026_10_01)
  @doc("Current state of the cluster.")
  @visibility(Lifecycle.Read)
  state: ClusterState;

  @removed(Versions.v2026_10_01)
  @doc("The fully qualified domain name of the cluster.")
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  @removed(Versions.v2026_10_01)
  @doc("The fully qualified domain name used for readonly endpoint for the cluster.")
  @visibility(Lifecycle.Read)
  readonlyEndpoint?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "API version 2026-10-01 guarantees provisioningState in every Cluster response; the 2026-01-20-preview projection remains optional."
  @madeRequired(Versions.v2026_10_01)
  @doc("The provisioning state of the cluster.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @added(Versions.v2026_10_01)
  @doc("The current designated read-write pool and read-write status for the cluster.")
  @visibility(Lifecycle.Read)
  readWritePool: ReadWritePoolProperties;

  @removed(Versions.v2026_10_01)
  @doc("Defines how replicas are placed across availability zones.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  zonePlacementPolicy?: ZonePlacementEnforcement;

  @removed(Versions.v2026_10_01)
  @doc("Defines connection to a parameter group.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  parameterGroup?: HorizonDbClusterParameterGroupConnectionProperties;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Authentication configuration for the HorizonDB cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  authConfig?: HorizonDbClusterAuthConfig;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("The compute model for the cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeModel?: HorizonDbComputeModel;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Mirroring configuration for the HorizonDB cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  mirroring?: HorizonDbClusterMirroring;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("Mirroring configuration for a HorizonDB cluster.")
model HorizonDbClusterMirroring {
  @doc("The names of the databases to mirror.")
  databaseNames?: string[];

  @doc("The resource ID of the user-assigned managed identity used for mirroring.")
  userAssignedIdentityId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("Authentication configuration for a HorizonDB cluster.")
model HorizonDbClusterAuthConfig {
  @doc("Indicates whether Microsoft Entra ID authentication is enabled or disabled.")
  entraIdAuth?: AuthenticationState;

  @doc("The Microsoft Entra tenant ID.")
  tenantId?: string;

  @doc("Indicates whether password authentication is enabled or disabled.")
  passwordAuth?: AuthenticationState;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("The compute model for a HorizonDB cluster.")
model HorizonDbComputeModel {
  @doc("The compute model type. Supported values: 'Provisioned', 'Serverless'.")
  type?: HorizonDbComputeModelType;

  @doc("The fixed vCore count for Provisioned compute.")
  vCores?: int32;

  @doc("The minimum vCores for Serverless compute. Defines the lower autoscaling bound.")
  minvCores?: float64;

  @doc("The maximum vCores for Serverless compute. Defines the upper autoscaling bound.")
  maxvCores?: float64;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("The compute model type.")
union HorizonDbComputeModelType {
  string,

  @doc("Provisioned compute.")
  Provisioned: "Provisioned",

  @doc("Serverless compute.")
  Serverless: "Serverless",
}

@added(Versions.v2026_10_01)
@doc("The current automatic and requested failover eligibility for a cluster.")
model FailoverProperties {
  @doc("The current readiness state for both automatic failover and a caller-requested failover operation.")
  @visibility(Lifecycle.Read)
  state: FailoverState;

  @doc("The reason failover is not ready. This property is present only when state is NotReady and absent when state is Ready. Valid reasons are that no read-write pool is designated, the designated read-write pool has fewer than two nodes, the designated read-write pool is stopped or shut down, or its read-only nodes are not functional.")
  @visibility(Lifecycle.Read)
  unavailableReason?: string;
}

@added(Versions.v2026_10_01)
@doc("The current zone redundancy status for the read-write node.")
model ReadWritePoolZoneRedundancyProperties {
  @doc("The current zone-redundancy readiness state for the read-write node. The state is NotReady when no read-write pool is designated.")
  @visibility(Lifecycle.Read)
  state: ZoneRedundancyState;

  @doc("The reason zone redundancy is not ready. This property is present only when state is NotReady and absent when state is Ready. Valid reasons are that no read-write pool is designated, the designated read-write pool has fewer than two nodes, all nodes in the designated read-write pool are deployed in a single availability zone, or the region does not support availability zones.")
  @visibility(Lifecycle.Read)
  unavailableReason?: string;
}

@added(Versions.v2026_10_01)
@doc("The current designated read-write pool and read-write status for a HorizonDB cluster. When a pool is created while the cluster currently has no pools, the service automatically designates the new pool as the read-write pool. This behavior also applies after all pools that existed earlier in the cluster's lifetime have been deleted.")
model ReadWritePoolProperties {
  @doc("The Azure resource ID of the pool designated to host the cluster's read-write node. The pool is a child resource of this cluster. When a pool is created while the cluster currently has no pools, the service automatically sets this property to the new pool's resource ID, including when all pools that existed earlier in the cluster's lifetime were deleted. This property is absent when no pool is designated, such as after clearReadWritePool succeeds.")
  @visibility(Lifecycle.Read)
  designatedPoolResourceId?: PoolResourceId;

  @added(Versions.v2026_10_01)
  @doc("The current failover status for the read-write node. This object is always returned on reads. When failover is not ready, state is NotReady and unavailableReason explains why.")
  @visibility(Lifecycle.Read)
  failover: FailoverProperties;

  @added(Versions.v2026_10_01)
  @doc("The current zone redundancy status for the read-write node. This object is always returned on reads. When zone redundancy is not ready, state is NotReady and unavailableReason explains why.")
  @visibility(Lifecycle.Read)
  zoneRedundancy: ReadWritePoolZoneRedundancyProperties;
}

@added(Versions.v2026_10_01)
@doc("An Azure resource ID that identifies a HorizonDB cluster.")
scalar HorizonDbClusterResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters",
    }
  ]>;

@added(Versions.v2026_10_01)
@doc("An Azure resource ID that identifies a HorizonDB endpoint.")
scalar EndpointResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/endpoints",
    }
  ]>;

@added(Versions.v2026_10_01)
@doc("The depth of a HorizonDB cluster in its current asynchronous replication topology. Level 0 is the current root cluster, level 1 is a direct replica of the current root that can be used as the source for one additional replica level, and level 2 is a terminal second-level replica that cannot be used as the source of another asynchronous replica.")
@minValue(0)
@maxValue(2)
scalar ClusterReplicaLevel extends int32;

@added(Versions.v2026_10_01)
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

@added(Versions.v2026_10_01)
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

@added(Versions.v2026_10_01)
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

@added(Versions.v2026_10_01)
@doc("The role of a HorizonDB cluster in a virtual endpoint reference.")
union VirtualEndpointReferenceRole {
  string,

  @doc("The virtual endpoint writer target belongs to this cluster.")
  Writer: "Writer",

  @doc("The virtual endpoint reader target belongs to this cluster.")
  Reader: "Reader",
}

@added(Versions.v2026_10_01)
@doc("A role played by a HorizonDB cluster in a replication set.")
union ClusterReplicationRole {
  string,

  /** The cluster sends replicated data to one or more target clusters. */
  Source: "Source",

  /** The cluster receives replicated data from a source cluster. */
  Target: "Target",
}

@added(Versions.v2026_10_01)
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

@added(Versions.v2026_10_01)
@doc("The readiness state for automatic and caller-requested failover.")
union FailoverState {
  string,

  @doc("Failover is ready.")
  Ready: "Ready",

  @doc("Failover is not ready. Inspect unavailableReason for details.")
  NotReady: "NotReady",
}

@added(Versions.v2026_10_01)
@doc("The readiness state for zone redundancy of the read-write node.")
union ZoneRedundancyState {
  string,

  @doc("Zone redundancy is ready.")
  Ready: "Ready",

  @doc("Zone redundancy is not ready. Inspect unavailableReason for details.")
  NotReady: "NotReady",
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbClusterPropertiesForPatchUpdate")
@doc("Properties of a HorizonDB cluster for update operations.")
model ClusterPropertiesForPatchUpdate {
  @removed(Versions.v2026_10_01)
  @secret
  @minLength(8)
  @maxLength(128)
  @doc("The administrator login password.")
  @visibility(Lifecycle.Update)
  administratorLoginPassword?: string;

  @added(Versions.v2026_10_01)
  @doc("The network configuration to update for the cluster.")
  @visibility(Lifecycle.Update)
  network?: NetworkForPatchUpdate;

  @removed(Versions.v2026_10_01)
  @doc("Number of vCores.")
  @minValue(1)
  @maxValue(96)
  @visibility(Lifecycle.Update)
  vCores?: int32;

  @removed(Versions.v2026_10_01)
  @doc("Defines connection to a parameter group.")
  parameterGroup?: HorizonDbClusterParameterGroupConnectionProperties;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Authentication configuration for the HorizonDB cluster.")
  @visibility(Lifecycle.Update)
  authConfig?: HorizonDbClusterAuthConfig;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("The compute model for the cluster.")
  @visibility(Lifecycle.Update)
  computeModel?: HorizonDbComputeModel;

  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  @doc("Mirroring configuration for the HorizonDB cluster.")
  @visibility(Lifecycle.Update)
  mirroring?: HorizonDbClusterMirroring;

  @added(Versions.v2026_10_01)
  @doc("The backup configuration for the cluster.")
  @visibility(Lifecycle.Update)
  backup?: BackupPropertiesForPatchUpdate;

  @added(Versions.v2026_10_01)
  @doc("The deletion configuration to update for the cluster.")
  @visibility(Lifecycle.Update)
  deletion?: ClusterDeletionPropertiesForPatchUpdate;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbClusterForPatchUpdate")
@doc("HorizonDB cluster for update operations.")
model ClusterForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  @doc("The properties that can be updated for a HorizonDB cluster.")
  properties?: ClusterPropertiesForPatchUpdate;
}

@@added(Cluster.identity, Versions.v2026_05_01_preview);
@@added(ClusterForPatchUpdate.identity, Versions.v2026_05_01_preview);

@added(Versions.v2026_10_01)
@doc("The scheduled maintenance configuration for a HorizonDB pool.")
@discriminator("maintenanceManagementType")
model ScheduledMaintenanceProperties {
  @doc("Specifies whether scheduled maintenance is managed by the system or by the user.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  maintenanceManagementType: ScheduledMaintenanceManagementType;
}

@added(Versions.v2026_10_01)
@doc("The system-managed scheduled maintenance configuration for a HorizonDB pool. User-managed schedule properties must be absent.")
model SystemScheduledMaintenanceProperties
  extends ScheduledMaintenanceProperties {
  @added(Versions.v2026_10_01)
  @doc("Specifies that scheduled maintenance is managed by the system.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  maintenanceManagementType: "System";
}

@added(Versions.v2026_10_01)
@doc("The user-managed weekly scheduled maintenance configuration for a HorizonDB pool.")
model UserScheduledMaintenanceProperties
  extends ScheduledMaintenanceProperties {
  @added(Versions.v2026_10_01)
  @doc("Specifies that scheduled maintenance is managed by the user.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  maintenanceManagementType: "User";

  @added(Versions.v2026_10_01)
  @doc("The day of the week on which user-managed maintenance starts.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  dayOfWeek: ScheduledMaintenanceDayOfWeek;

  @added(Versions.v2026_10_01)
  @minValue(0)
  @maxValue(23)
  @doc("The hour, in UTC, at which user-managed maintenance starts. Valid values range from 0 through 23.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  startHourUtc: int32;

  @added(Versions.v2026_10_01)
  @minValue(0)
  @maxValue(59)
  @doc("The minute, in UTC, at which user-managed maintenance starts. Valid values range from 0 through 59.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  startMinuteUtc: int32;
}

@added(Versions.v2026_10_01)
@doc("The deletion configuration and current deletion-blocking status for a HorizonDB cluster.")
model ClusterDeletionProperties {
  @doc("Determines when the cluster is permanently deleted. When this property is omitted while creating a new cluster, the service records Immediate. When it is omitted from a replacement PUT, the existing policy is preserved. With RetainUntilNoBackupsRemain, a delete request removes all pools, stops creation of automatic backups, transitions the cluster to DeletionBlockedByBackups, and returns 409 Conflict while automatic or user-created backups remain. In that state, reads remain available, but mutating operations other than deletion of user-created backups and another cluster delete request are rejected. Once no backups remain, retrying the cluster delete request starts physical deletion. The policy can be changed from Immediate to RetainUntilNoBackupsRemain, but cannot be changed back to Immediate. Resubmitting the current value succeeds as an idempotent no-op.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  policy?: ClusterDeletionPolicy;

  @doc("The date and time, in UTC, when the cluster becomes eligible for physical deletion based on its remaining automatic backups. This property is present only when state is DeletionBlockedByBackups, blockingReason is AutomaticBackups, and a real eligibility time can be calculated. It is absent while user-created backups block deletion.")
  @visibility(Lifecycle.Read)
  deletionEligibleAtUtc?: utcDateTime;

  @doc("The current reason that physical deletion is blocked. This property is present only when state is DeletionBlockedByBackups.")
  @visibility(Lifecycle.Read)
  blockingReason?: ClusterDeletionBlockingReason;
}

@added(Versions.v2026_10_01)
@doc("The deletion configuration for updating a HorizonDB cluster.")
model ClusterDeletionPropertiesForPatchUpdate {
  @doc("Determines when the cluster is permanently deleted. With RetainUntilNoBackupsRemain, a delete request removes all pools, stops creation of automatic backups, and retains the cluster in DeletionBlockedByBackups until all backups are removed or expire. The policy can be changed from Immediate to RetainUntilNoBackupsRemain, but cannot be changed back to Immediate. Resubmitting the current value succeeds as an idempotent no-op.")
  @visibility(Lifecycle.Update)
  policy?: ClusterDeletionPolicy;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPoolProperties")
@doc("Properties of a HorizonDB pool.")
model PoolProperties {
  @removed(Versions.v2026_10_01)
  @doc("The location of the HorizonDB pool.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: azureLocation;

  @typeChangedFrom(Versions.v2026_10_01, State)
  @doc("Current state of the pool.")
  @visibility(Lifecycle.Read)
  state?: PoolState;

  @removed(Versions.v2026_10_01)
  @doc("Number of replicas in the pool.")
  @visibility(Lifecycle.Read)
  replicaCount?: int32;

  @removed(Versions.v2026_10_01)
  @doc("The version of the HorizonDB pool.")
  @visibility(Lifecycle.Read)
  version?: string;

  @removed(Versions.v2026_10_01)
  @doc("The create mode for the pool.")
  @visibility(Lifecycle.Read)
  createMode?: CreateModePool;

  @added(Versions.v2026_10_01)
  @doc("The compute model for the HorizonDB pool.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeModel?: PoolComputeModel;

  @added(Versions.v2026_10_01)
  @doc("The desired number of nodes to allocate and assign to the pool. Allowed values are 0 through 16. A value of 0 keeps the pool resource and its name, compute configuration, maintenance configuration, and parameter-group association, but allocates no nodes; it does not delete the pool. If this pool is currently the parent cluster's designated read-write pool, a PUT or PATCH request that would leave the effective desiredNodeCount at 0 is rejected. Clear the designation through clearReadWritePool before scaling this pool to zero. On rejection, the pool and designation remain unchanged.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  desiredNodeCount?: PoolNodeCount;

  @added(Versions.v2026_10_01)
  @doc("The number of nodes currently allocated and assigned to the pool, regardless of their operational state or the operational state of the pool.")
  @visibility(Lifecycle.Read)
  allocatedNodeCount: PoolNodeCount;

  @added(Versions.v2026_10_01)
  @doc("The required default or custom parameter group associated with the pool.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  parameterGroup: PoolParameterGroupReference;

  @added(Versions.v2026_10_01)
  @doc("The scheduled maintenance configuration for the pool. When maintenanceManagementType is User, dayOfWeek, startHourUtc, and startMinuteUtc are required. Those schedule properties must be absent when maintenanceManagementType is System.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  scheduledMaintenance?: ScheduledMaintenanceProperties;

  @doc("The provisioning state of the pool.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPoolPropertiesForPatchUpdate")
@doc("Properties of a HorizonDB pool for update operations.")
model PoolPropertiesForPatchUpdate {
  @added(Versions.v2026_10_01)
  @doc("The compute model properties to update. Omitted properties preserve their current values. To change the compute model type between Provisioned and Serverless, supply the complete target compute model, including type, computeProcessor, computeGeneration, and all properties required by the target type.")
  @visibility(Lifecycle.Update)
  computeModel?: PoolComputeModelForPatchUpdate;

  @added(Versions.v2026_10_01)
  @doc("The desired number of nodes to allocate and assign to the pool. Allowed values are 0 through 16. A value of 0 keeps the pool resource and its configuration but allocates no nodes; it does not delete the pool. Omission preserves the current target. If this pool is currently the parent cluster's designated read-write pool, the PATCH request is rejected when the resulting effective desiredNodeCount would be 0. Clear the designation through clearReadWritePool first. On rejection, the pool and designation remain unchanged.")
  @visibility(Lifecycle.Update)
  desiredNodeCount?: PoolNodeCount;

  @added(Versions.v2026_10_01)
  @doc("The default or custom parameter group to associate with the pool. Omission preserves the current association.")
  @visibility(Lifecycle.Update)
  parameterGroup?: PoolParameterGroupReferenceForPatchUpdate;

  @added(Versions.v2026_10_01)
  @doc("The scheduled maintenance configuration to update for the pool. When supplied, the complete System or User configuration is required. Omission preserves the current configuration.")
  @visibility(Lifecycle.Update)
  scheduledMaintenance?: ScheduledMaintenanceProperties;
}

@added(Versions.v2026_10_01)
@doc("A reference to the default or custom parameter group associated with a HorizonDB pool.")
model PoolParameterGroupReference {
  @added(Versions.v2026_10_01)
  @doc("The Azure resource ID of the default or custom parameter group.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  parameterGroupResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/parameterGroups";
    },
    {
      type: "Microsoft.HorizonDb/locations/parameterGroups";
    }
  ]>;

  @added(Versions.v2026_10_01)
  @doc("Determines when dynamic parameter changes from the associated parameter group become effective. Static parameter changes always require a pool restart, regardless of this value.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  applyMethod: ParameterApplyMethod;

  @added(Versions.v2026_10_01)
  @doc("The synchronization status between the pool and its parameter group.")
  @visibility(Lifecycle.Read)
  syncStatus?: ParameterGroupSyncStatus;
}

@added(Versions.v2026_10_01)
@doc("A parameter group reference for updating a HorizonDB pool.")
model PoolParameterGroupReferenceForPatchUpdate {
  @added(Versions.v2026_10_01)
  @doc("The Azure resource ID of the default or custom parameter group to associate with the pool.")
  @visibility(Lifecycle.Update)
  parameterGroupResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/parameterGroups";
    },
    {
      type: "Microsoft.HorizonDb/locations/parameterGroups";
    }
  ]>;

  @added(Versions.v2026_10_01)
  @doc("Determines when dynamic parameter changes from the associated parameter group become effective. Static parameter changes always require a pool restart, regardless of this value.")
  @visibility(Lifecycle.Update)
  applyMethod: ParameterApplyMethod;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbPoolForPatchUpdate")
@doc("HorizonDB pool for update operations.")
model PoolForPatchUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> is acceptable for tags in this version"
  @removed(Versions.v2026_10_01)
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The properties that can be updated for a HorizonDB pool.")
  properties?: PoolPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("Parameters for designating a pool to host the cluster's read-write node.")
model DesignateReadWritePoolRequest {
  @doc("The Azure resource ID of the existing pool to designate as the read-write pool. The pool must be a child resource of the cluster on which this action is invoked. A resource ID for a pool in another cluster is rejected.")
  poolResourceId: PoolResourceId;

  @doc("Indicates whether the operation can succeed when the named target pool has no active or running compute, leaving the cluster without an active or running read-write node. The default is false.")
  allowNoActiveReadWriteNode?: boolean = false;
}

@added(Versions.v2026_10_01)
@doc("The compute model for a HorizonDB pool.")
@discriminator("type")
model PoolComputeModel {
  @doc("The type of compute model.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  type: PoolComputeModelType;

  @doc("The processor type for the compute model.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeProcessor?: ComputeProcessorType;

  @doc("The compute generation for the compute model.")
  @minValue(1)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  computeGeneration?: int32;
}

@added(Versions.v2026_10_01)
@doc("A provisioned compute model for a HorizonDB pool.")
model ProvisionedHorizonDbPoolComputeModel extends PoolComputeModel {
  @doc("The type of compute model.")
  type: "Provisioned";

  @doc("The number of provisioned vCores. Allowed values are 1 through 192.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  vCores: ProvisionedPoolVCores;
}

@added(Versions.v2026_10_01)
@doc("A serverless compute model for a HorizonDB pool. minVCores must be less than or equal to maxVCores.")
model ServerlessHorizonDbPoolComputeModel extends PoolComputeModel {
  @doc("The type of compute model.")
  type: "Serverless";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "minVCores preserves the existing vCores contract term in the serverless compute model."
  @doc("The minimum number of vCores. Allowed values are 0.5 through 192. The service validates that this value is less than or equal to maxVCores.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  minVCores: ServerlessPoolVCores;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxVCores preserves the existing vCores contract term in the serverless compute model."
  @doc("The maximum number of vCores. Allowed values are 0.5 through 192. The service validates that this value is greater than or equal to minVCores.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  maxVCores: ServerlessPoolVCores;
}

@added(Versions.v2026_10_01)
@doc("The compute model properties of a HorizonDB pool that can be updated. The object is recursively mergeable: omitted properties preserve their current values. Properties that do not apply to the current or target compute model type are rejected. When type changes, the request must include the complete target compute model. For an effective Serverless model, the merged minVCores value must be less than or equal to the merged maxVCores value; invalid requests are rejected without changing the resource.")
model PoolComputeModelForPatchUpdate {
  @doc("The compute model type. Omit this property to retain the current type. Resubmitting the current type succeeds as an idempotent no-op. To change the type, supply all common properties and all properties required by the target type.")
  @visibility(Lifecycle.Update)
  type?: PoolComputeModelType;

  @doc("The processor type for the compute model. Omission preserves the current processor type.")
  @visibility(Lifecycle.Update)
  computeProcessor?: ComputeProcessorType;

  @doc("The compute generation for the compute model. Omission preserves the current compute generation.")
  @minValue(1)
  @visibility(Lifecycle.Update)
  computeGeneration?: int32;

  @doc("The number of provisioned vCores. Allowed values are 1 through 192. This property applies only to a Provisioned compute model. Omission preserves the current value.")
  @visibility(Lifecycle.Update)
  vCores?: ProvisionedPoolVCores;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "minVCores preserves the existing vCores contract term in the serverless compute model."
  @doc("The minimum number of vCores. Allowed values are 0.5 through 192. This property applies only to a Serverless compute model. Omission preserves the current value. The service validates that the effective value after merging is less than or equal to the effective maxVCores.")
  @visibility(Lifecycle.Update)
  minVCores?: ServerlessPoolVCores;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxVCores preserves the existing vCores contract term in the serverless compute model."
  @doc("The maximum number of vCores. Allowed values are 0.5 through 192. This property applies only to a Serverless compute model. Omission preserves the current value. The service validates that the effective value after merging is greater than or equal to the effective minVCores.")
  @visibility(Lifecycle.Update)
  maxVCores?: ServerlessPoolVCores;
}

@doc("Network properties.")
model Network {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicNetworkAccess is a configuration flag, not sensitive data"
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "publicNetworkAccess")
  @doc("The flag indicating whether public ip is requested.")
  @visibility(Lifecycle.Read)
  legacyPublicNetworkAccess?: PublicNetworkAccessState;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicAccess is a configuration flag, not sensitive data"
  @added(Versions.v2026_10_01)
  @doc("Specifies whether public access is enabled for the cluster. The service defaults to Disabled when this property is omitted.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  publicAccess?: PublicNetworkAccessState = PublicNetworkAccessState.Disabled;
}

@added(Versions.v2026_10_01)
@doc("Network properties for updating a HorizonDB cluster.")
model NetworkForPatchUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicAccess is a configuration flag, not sensitive data"
  @doc("Specifies whether public access is enabled for the cluster. Omission preserves the current value.")
  @visibility(Lifecycle.Update)
  publicAccess?: PublicNetworkAccessState;
}

@added(Versions.v2026_10_01)
@doc("Backup configuration properties for a HorizonDB cluster.")
model BackupProperties {
  @doc("The geo-redundancy state.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  geoRedundancy: GeoRedundancyState;

  @doc("The number of days that automatic backups are retained. The service defaults to 7 days when this property is omitted.")
  @minValue(1)
  @maxValue(35)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  retentionDays?: int32 = 7;

  @added(Versions.v2026_10_01)
  @doc("The earliest point in time, in UTC, to which the cluster can currently be restored.")
  @visibility(Lifecycle.Read)
  earliestRestorePointUtc?: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("Backup configuration properties for updating a HorizonDB cluster.")
model BackupPropertiesForPatchUpdate {
  @doc("The number of days that automatic backups are retained.")
  @minValue(1)
  @maxValue(35)
  @visibility(Lifecycle.Update)
  retentionDays?: int32;
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Endpoint is a service-managed resource with no asynchronous PUT or PATCH operation whose status would require provisioningState."
@added(Versions.v2026_10_01)
@doc("Properties of a service-generated HorizonDB endpoint.")
model EndpointProperties {
  @doc("The scope of the endpoint. Cluster-scoped Endpoint roles are derived from replication topology. Pool-scoped Endpoints have the ReadOnly role.")
  @visibility(Lifecycle.Read)
  scope: EndpointScope;

  @doc("The Azure resource ID of the Endpoint's lifecycle owner. For Cluster scope, this identifies the parent Cluster with which the Endpoint is created and deleted. For Pool scope, this identifies the Pool with which the Endpoint and its FirewallRule children are created and deleted; the Pool must be a child of the Endpoint's parent Cluster.")
  @visibility(Lifecycle.Read)
  associatedResourceId: EndpointAssociatedResourceId;

  @doc("The service-generated fully qualified domain name of the endpoint. A Cluster-scoped Endpoint uses <cluster>.<clusterid>.<region>.horizondb.azure.com. A Pool-scoped Endpoint uses <poolid>.<cluster>.<clusterid>.<region>.horizondb.azure.com.")
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName: string;

  @doc("The routing role of the endpoint. The Cluster-scoped Endpoint is ReadWrite only for the current level-0 root, top-most upstream Cluster. A Cluster-scoped Endpoint is ReadOnly for every asynchronous replica Cluster whose replication.roles contains Target, including intermediate Source and Target replicas and terminal Target replicas. Pool-scoped Endpoints are also ReadOnly and route only to allocated nodes in the associated Pool that are not currently playing the read-write role. A Pool-scoped ReadOnly Endpoint has no routing destination unless at least one such node exists, including when the Pool is Stopped or Shutdown, has zero allocated nodes, or has only one allocated node and that node is playing the read-write role.")
  @visibility(Lifecycle.Read)
  role: EndpointRole;

  @doc("The customer-selected DNS aliases for the endpoint. An empty list means that the endpoint has no aliased CNAME. Only one alias is currently supported.")
  @maxItems(1)
  @visibility(Lifecycle.Update, Lifecycle.Read)
  aliases: EndpointAlias[];

  @doc("The fully qualified domain names formed from aliases by appending the .horizondb.azure.com suffix. The list is empty when aliases is empty.")
  @visibility(Lifecycle.Read)
  aliasFullyQualifiedDomainNames: string[];
}

@added(Versions.v2026_10_01)
@doc("Properties of a HorizonDB virtual endpoint.")
model VirtualEndpointProperties {
  @doc("The Azure resource ID of the endpoint that receives writer traffic. The target must be the Cluster-scoped ReadWrite Endpoint of the current level-0 root cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  writerEndpointResourceId: EndpointResourceId;

  @doc("The Azure resource ID of the Cluster-scoped Endpoint that receives reader traffic. The target must be the Endpoint named cluster in the writer Cluster or one of its direct level-1 replica Clusters; indirect descendants are not valid targets. The target role is topology-derived: the writer Cluster's Endpoint is ReadWrite when that Cluster is the current root, while a direct replica Cluster's Endpoint is ReadOnly because its replication.roles contains Target.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  readerEndpointResourceId: EndpointResourceId;

  @doc("The stable writer fully qualified domain name, in the format <virtual-endpoint-name>.writer.horizondb.azure.com.")
  @visibility(Lifecycle.Read)
  writerFullyQualifiedDomainName: string;

  @doc("The stable reader fully qualified domain name, in the format <virtual-endpoint-name>.reader.horizondb.azure.com.")
  @visibility(Lifecycle.Read)
  readerFullyQualifiedDomainName: string;

  @doc("The provisioning state of the virtual endpoint resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties of a service-generated HorizonDB endpoint for an update operation.")
model EndpointPropertiesForPatchUpdate {
  @doc("The replacement DNS alias list. An empty list removes the aliased CNAME. Only one alias is currently supported.")
  @maxItems(1)
  @visibility(Lifecycle.Update)
  aliases: EndpointAlias[];
}

@added(Versions.v2026_10_01)
@doc("A service-generated HorizonDB endpoint update request.")
model EndpointForPatchUpdate {
  @doc("The endpoint properties to update.")
  properties: EndpointPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("Properties of a HorizonDB virtual endpoint for an update operation. Omitted properties preserve their current values.")
model VirtualEndpointPropertiesForPatchUpdate {
  @doc("The Cluster-scoped Endpoint target to apply for writer traffic. The target must be the Endpoint named cluster in the current level-0 root Cluster.")
  @visibility(Lifecycle.Update)
  writerEndpointResourceId?: EndpointResourceId;

  @doc("The Cluster-scoped Endpoint target to apply for reader traffic. The target must be the Endpoint named cluster in the writer Cluster or one of its direct level-1 replica Clusters; indirect descendants are not valid targets.")
  @visibility(Lifecycle.Update)
  readerEndpointResourceId?: EndpointResourceId;
}

@added(Versions.v2026_10_01)
@doc("A HorizonDB virtual endpoint update request.")
model VirtualEndpointForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The properties to update. Omission preserves the current writer and reader targets.")
  properties?: VirtualEndpointPropertiesForPatchUpdate;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Maintenance events are read-only resources that do not have a provisioning lifecycle."
@added(Versions.v2026_10_01)
@doc("Properties of a maintenance event resource.")
model MaintenanceEventProperties {
  @doc("A service-generated identifier for this maintenance event, assigned by the platform. The format is not contractual, and clients should not attempt to parse or construct this value.")
  @visibility(Lifecycle.Read)
  maintenanceEventId?: string;

  @doc("The maintenance type.")
  @visibility(Lifecycle.Read)
  maintenanceType: MaintenanceType;

  @doc("The human-readable description of the maintenance event.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("The customer-facing status of the maintenance event.")
  @visibility(Lifecycle.Read)
  status: MaintenanceEventStatus;

  @doc("The scheduled start time of the maintenance event in UTC.")
  @visibility(Lifecycle.Read)
  startTimeUtc: utcDateTime;

  @doc("The scheduled end time of the maintenance event in UTC.")
  @visibility(Lifecycle.Read)
  endTimeUtc: utcDateTime;

  @doc("The estimated downtime as an ISO 8601 duration string, for example, 'PT60S' for 60 seconds.")
  @visibility(Lifecycle.Read)
  estimatedDowntime?: string;

  @doc("Indicates whether the customer can reschedule this maintenance event.")
  @visibility(Lifecycle.Read)
  deferrable: boolean;

  @doc("The latest date and time to which this maintenance event can be postponed, in UTC. This property is present only when deferrable is true.")
  @visibility(Lifecycle.Read)
  deferralDeadlineUtc?: utcDateTime;

  @doc("The scheduled start time before the most recent reschedule, in UTC. This property is absent if the event has never been rescheduled.")
  @visibility(Lifecycle.Read)
  rescheduledFromUtc?: utcDateTime;

  @doc("The time when this maintenance event record was last updated, in UTC.")
  @visibility(Lifecycle.Read)
  lastUpdatedTimeUtc?: utcDateTime;

  @doc("The initially scheduled start time before any reschedule, in UTC. This value equals startTimeUtc when the event has never been rescheduled.")
  @visibility(Lifecycle.Read)
  originalStartTimeUtc: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("Parameters for rescheduling a maintenance event.")
model MaintenanceEventRescheduleRequest {
  @doc("The new start time in RFC 3339 format.")
  postponeToDateTimeUtc: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("The response from a maintenance event reschedule or apply-now action.")
model MaintenanceEventActionResponse {
  @doc("The maintenance event identifier.")
  maintenanceEventId?: string;

  @doc("The full Azure resource ID of the HorizonDB pool.")
  poolResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/pools";
    }
  ]>;

  @doc("The status of the maintenance event.")
  status?: MaintenanceEventStatus;

  @doc("The planned start time of the maintenance event in UTC.")
  plannedStartTimeUtc?: utcDateTime;

  @doc("The planned end time of the maintenance event in UTC.")
  plannedEndTimeUtc?: utcDateTime;

  @doc("Indicates whether the maintenance event was requested to be applied immediately. The value is true for apply-now and false for reschedule.")
  appliedNow?: boolean;

  @doc("The time when this maintenance event record was last updated, in UTC.")
  lastUpdatedTimeUtc?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Backups are immutable point-in-time records and do not have a resource provisioning state."
@added(Versions.v2026_10_01)
@doc("Properties of an available HorizonDB backup.")
model BackupResourceProperties {
  @doc("The date and time when the backup was taken, in UTC.")
  @visibility(Lifecycle.Read)
  takenAtUtc: utcDateTime;

  @doc("The PostgreSQL version of the backed-up cluster.")
  @visibility(Lifecycle.Read)
  postgreSqlVersion: PostgreSqlVersion;

  @doc("The type of the backup.")
  @visibility(Lifecycle.Read)
  backupType: BackupType;

  @doc("The date and time when an automatic backup expires, in UTC. This property is absent for user-created backups, which remain available until explicitly deleted.")
  @visibility(Lifecycle.Read)
  expiredAtUtc?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "System AI models are system-managed resources whose established response contract reports lifecycle through status rather than provisioningState."
@added(Versions.v2026_10_01)
@doc("Properties of a system-managed AI model. All properties are generated by the service and are read-only.")
model SystemAiModelProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "The nested id is an established service-internal model identifier distinct from the top-level Azure resource ID."
  @doc("The service-internal identifier of the system AI model. This is an opaque identifier, and clients should not parse or construct it.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The model name assigned by the service.")
  @visibility(Lifecycle.Read)
  modelName?: string;

  @doc("The alias assigned to the system AI model by the service.")
  @visibility(Lifecycle.Read)
  `alias`?: string;

  @doc("The version assigned to the system AI model by the service.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("The deployment name of the system AI model.")
  @visibility(Lifecycle.Read)
  deploymentName?: string;

  @doc("The format of the system AI model.")
  @visibility(Lifecycle.Read)
  format?: string;

  @doc("The date and time when the system AI model was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAtUtc?: utcDateTime;

  @doc("The lifecycle status of the system AI model.")
  @visibility(Lifecycle.Read)
  status?: SystemAiModelStatus;
}

@removed(Versions.v2026_10_01)
@doc("HorizonDB replica for update operations.")
model HorizonDbReplicaForPatchUpdate {
  @doc("Properties of a HorizonDB replica for update operations.")
  properties?: HorizonDbReplicaPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("The scope of a HorizonDB endpoint.")
union EndpointScope {
  string,

  /** The Endpoint is associated with its parent Cluster. Its role is derived from replication topology. */
  Cluster: "Cluster",

  /** The Endpoint is associated with a Pool under its parent Cluster and has the ReadOnly role. */
  Pool: "Pool",
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbFirewallRuleProperties")
@doc("Properties of a HorizonDB firewall rule.")
model FirewallRuleProperties {
  @removed(Versions.v2026_10_01)
  @doc("The start IP address of the firewall rule (IPv4).")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @renamedFrom(Versions.v2026_10_01, "startIpAddress")
  legacyStartIpAddress: string;

  @added(Versions.v2026_10_01)
  @doc("The start IPv4 address of the firewall rule in dotted-decimal notation.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  startIpAddress: DottedDecimalIpv4Address;

  @removed(Versions.v2026_10_01)
  @doc("The end IP address of the firewall rule (IPv4).")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @renamedFrom(Versions.v2026_10_01, "endIpAddress")
  legacyEndIpAddress: string;

  @added(Versions.v2026_10_01)
  @doc("The end IPv4 address of the firewall rule in dotted-decimal notation. This address must be numerically greater than or equal to startIpAddress.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  endIpAddress: DottedDecimalIpv4Address;

  @removed(Versions.v2026_10_01)
  @doc("The description of the HorizonDB firewall rule.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @renamedFrom(Versions.v2026_10_01, "description")
  legacyDescription?: string;

  @added(Versions.v2026_10_01)
  @doc("The description of the HorizonDB firewall rule. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: WritableDescription;

  @doc("The provisioning state of the firewall rule.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("Properties of a HorizonDB administrator.")
model HorizonDbAdministratorProperties {
  @doc("The display name or UPN of the Entra ID principal. For users, typically the User Principal Name (e.g., admin@contoso.com). For groups, the group display name. For service principals, the application display name.")
  @maxLength(256)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalName: string;

  @doc("The type of the Entra ID principal.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalType: PrincipalTypes;

  @doc("The Entra ID object identifier of the principal (an RFC 4122 GUID). On PUT requests, this value comes from the URI path parameter.")
  @visibility(Lifecycle.Read)
  objectId?: string;

  @doc("The Entra ID tenant identifier (an RFC 4122 GUID). If omitted, defaults to the tenant of the subscription.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tenantId?: string;

  @doc("The provisioning state of the administrator.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties of a HorizonDB endpoint firewall rule for update operations. Omitted properties preserve their current values. The service validates the effective IP range after merging the supplied values with the existing rule.")
model FirewallRulePropertiesForPatchUpdate {
  @doc("The start IPv4 address to apply in dotted-decimal notation. The resulting effective start address must be numerically less than or equal to the effective end address.")
  @visibility(Lifecycle.Update)
  startIpAddress?: DottedDecimalIpv4Address;

  @doc("The end IPv4 address to apply in dotted-decimal notation. The resulting effective end address must be numerically greater than or equal to the effective start address.")
  @visibility(Lifecycle.Update)
  endIpAddress?: DottedDecimalIpv4Address;

  @doc("The description to apply to the HorizonDB firewall rule. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Update)
  description?: WritableDescription;
}

@added(Versions.v2026_10_01)
@doc("A HorizonDB endpoint firewall rule update request.")
model FirewallRuleForPatchUpdate {
  @doc("The properties to update. Omission preserves all current firewall rule properties.")
  properties?: FirewallRulePropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("Properties of a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
model MicrosoftEntraAdministratorProperties {
  @doc("The display name or user principal name of the Microsoft Entra principal mapped to the PostgreSQL role. For users, this is typically the user principal name, such as admin@contoso.com. For groups, this is the group display name. For service principals, this is the application display name.")
  @maxLength(256)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalName: string;

  @doc("The type of Microsoft Entra principal mapped to the PostgreSQL role.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalType: PrincipalTypes;

  @doc("The Microsoft Entra object identifier of the principal mapped to the PostgreSQL role, represented as an RFC 4122 GUID. On PUT requests, this value comes from the URI path parameter.")
  @visibility(Lifecycle.Read)
  objectId?: string;

  @doc("The identifier of the Microsoft Entra tenant containing the mapped principal, represented as an RFC 4122 GUID. If omitted, this value defaults to the tenant of the subscription.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tenantId?: string;

  @doc("The provisioning state of the PostgreSQL role and Microsoft Entra principal mapping.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("The properties for adding a HorizonDB administrator.")
model HorizonDbAdministratorPropertiesForAdd {
  @doc("The display name or UPN of the Entra ID principal. For users, typically the User Principal Name (e.g., admin@contoso.com). For groups, the group display name. For service principals, the application display name.")
  @maxLength(256)
  principalName: string;

  @doc("The type of the Entra ID principal.")
  principalType: PrincipalTypes;

  @doc("The Entra ID tenant identifier (an RFC 4122 GUID). If omitted, defaults to the tenant of the subscription.")
  tenantId?: string;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("The request body for adding a HorizonDB administrator.")
model HorizonDbAdministratorAdd {
  @doc("The properties for adding a HorizonDB administrator.")
  properties: HorizonDbAdministratorPropertiesForAdd;
}

@added(Versions.v2026_10_01)
@doc("Properties for creating or updating a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
model MicrosoftEntraAdministratorPropertiesForAdd {
  @doc("The display name or user principal name of the Microsoft Entra principal to map to the PostgreSQL role. For users, this is typically the user principal name, such as admin@contoso.com. For groups, this is the group display name. For service principals, this is the application display name.")
  @maxLength(256)
  principalName: string;

  @doc("The type of Microsoft Entra principal to map to the PostgreSQL role.")
  principalType: PrincipalTypes;

  @doc("The identifier of the Microsoft Entra tenant containing the principal to map, represented as an RFC 4122 GUID. If omitted, this value defaults to the tenant of the subscription.")
  tenantId?: string;
}

@added(Versions.v2026_10_01)
@doc("The request body for creating or updating a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
model MicrosoftEntraAdministratorAdd {
  @doc("The PostgreSQL role and Microsoft Entra principal mapping properties.")
  properties: MicrosoftEntraAdministratorPropertiesForAdd;
}

@added(Versions.v2026_05_01_preview)
@doc("The type of Microsoft Entra principal mapped to a PostgreSQL role.")
union PrincipalTypes {
  string,

  @doc("An unknown or unrecognized type. This value is for internal use and is not accepted in requests.")
  Unknown: "Unknown",

  @doc("A Microsoft Entra ID user account.")
  User: "User",

  @doc("A Microsoft Entra ID security group. All members of the group inherit administrator privileges.")
  Group: "Group",

  @doc("A Microsoft Entra ID application or service principal used for automated workloads.")
  ServicePrincipal: "ServicePrincipal",
}

@doc("The mode to create a new HorizonDB cluster.")
union CreateModeCluster {
  string,

  /** Create a new cluster */
  Create: "Create",

  /** Update an existing cluster */
  @removed(Versions.v2026_10_01)
  Update: "Update",

  /** Create cluster from point-in-time restore */
  PointInTimeRestore: "PointInTimeRestore",
}

@added(Versions.v2026_10_01)
@doc("Controls how a HorizonDB cluster PUT request is processed.")
union ClusterCreateMode {
  string,

  /** Process the request as a normal cluster creation. */
  Create: "Create",

  /** Create the cluster from a point-in-time restore. */
  PointInTimeRestore: "PointInTimeRestore",

  /** Create the cluster as an asynchronous replica and add it to the source cluster's existing replication set. */
  @added(Versions.v2026_10_01)
  AsyncReplica: "AsyncReplica",
}

@doc("The mode to create a new HorizonDB cluster.")
union CreateModePool {
  string,

  /** Create a new pool */
  Create: "Create",

  /** Update an existing pool */
  Update: "Update",
}

@renamedFrom(Versions.v2026_10_01, "ZonePlacementPolicy")
@doc("The zone placement enforcement option.")
union ZonePlacementEnforcement {
  string,

  /** Enforce zonal redundancy */
  Strict: "Strict",

  /** Best-effort placement (default) */
  BestEffort: "BestEffort",
}

@removed(Versions.v2026_10_01)
@doc("Current states.")
union State {
  string,

  @doc("Is ready and operational")
  Ready: "Ready",

  @doc("Is being dropped/deleted")
  Dropping: "Dropping",

  @doc("Is disabled")
  Disabled: "Disabled",

  @doc("Is starting up")
  Starting: "Starting",

  @doc("Is stopping")
  Stopping: "Stopping",

  @doc("Is stopped")
  Stopped: "Stopped",

  @doc("Is being updated")
  Updating: "Updating",

  @doc("Is healthy")
  Healthy: "Healthy",

  @added(Versions.v2026_05_01_preview)
  @doc("Is succeeded")
  Succeeded: "Succeeded",

  @added(Versions.v2026_05_01_preview)
  @doc("Is upgrading")
  Upgrading: "Upgrading",
}

@added(Versions.v2026_05_01_preview)
@doc("Indicates if authentication state is enabled or not.")
union AuthenticationState {
  string,

  @doc("Is enabled")
  Enabled: "Enabled",

  @doc("Is disabled")
  Disabled: "Disabled",
}

@added(Versions.v2026_10_01)
@doc("A PostgreSQL major version supported by HorizonDB. API version 2026-10-01 accepts only 17. Future API versions may add named values, and clients must tolerate unknown values returned by the service.")
union PostgreSqlVersion {
  string,

  /** PostgreSQL major version 17. */
  V17: "17",
}

@added(Versions.v2026_10_01)
@doc("Current state of a HorizonDB cluster.")
union ClusterState {
  string,

  /** Is ready and operational */
  Ready: "Ready",

  /** Is provisioning */
  Provisioning: "Provisioning",

  /** Is being deleted */
  Deleting: "Deleting",

  /** A delete request removed all pools and stopped new automatic backups, but physical deletion is blocked until all remaining backups are removed or expire */
  DeletionBlockedByBackups: "DeletionBlockedByBackups",

  /** Is inaccessible */
  Inaccessible: "Inaccessible",

  /** Is being updated */
  Updating: "Updating",
}

@added(Versions.v2026_10_01)
@doc("Determines when a HorizonDB cluster is permanently deleted after a delete request.")
union ClusterDeletionPolicy {
  string,

  /** Permanently deletes the cluster as soon as the delete request is processed */
  Immediate: "Immediate",

  /** Removes all pools, stops new automatic backups, and retains the cluster until all remaining backups are removed or expire */
  RetainUntilNoBackupsRemain: "RetainUntilNoBackupsRemain",
}

@added(Versions.v2026_10_01)
@doc("The reason that physical deletion of a HorizonDB cluster is blocked.")
union ClusterDeletionBlockingReason {
  string,

  /** Physical deletion is blocked until all remaining automatic backups expire. */
  AutomaticBackups: "AutomaticBackups",

  /** Physical deletion is blocked until all user-created backups are deleted. */
  UserCreatedBackups: "UserCreatedBackups",
}

@added(Versions.v2026_10_01)
@doc("Current state of a HorizonDB pool.")
union PoolState {
  string,

  /** Is ready and operational */
  Ready: "Ready",

  /** Is provisioning */
  Provisioning: "Provisioning",

  /** Is being deleted */
  Deleting: "Deleting",

  /** Is inaccessible */
  Inaccessible: "Inaccessible",

  /** Is being updated */
  Updating: "Updating",

  /** Is starting up */
  Starting: "Starting",

  /** Is stopping */
  Stopping: "Stopping",

  /** Is stopped */
  Stopped: "Stopped",

  /** Is restarting */
  Restarting: "Restarting",

  /** Is shutting down */
  ShuttingDown: "ShuttingDown",

  /** Is shut down */
  Shutdown: "Shutdown",
}

@doc("Indicates if public network access is enabled or not.")
union PublicNetworkAccessState {
  string,

  @doc("Public network access is enabled")
  Enabled: "Enabled",

  @doc("Public network access is disabled")
  Disabled: "Disabled",
}

@added(Versions.v2026_10_01)
@doc("Indicates the geo-redundancy state.")
union GeoRedundancyState {
  string,

  @doc("Geo-redundancy is enabled")
  Enabled: "Enabled",

  @doc("Geo-redundancy is disabled")
  Disabled: "Disabled",
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

@added(Versions.v2026_10_01)
@doc("Role of the endpoint.")
union EndpointRole {
  string,

  /** The Endpoint accepts read-only traffic. This applies to Pool-scoped Endpoints and to Cluster-scoped Endpoints for asynchronous replica Clusters whose replication.roles contains Target, including intermediate and terminal replicas. */
  ReadOnly: "ReadOnly",

  /** The Cluster-scoped Endpoint accepts read and write traffic. This applies only to the current level-0 root, top-most upstream Cluster. */
  ReadWrite: "ReadWrite",
}

@added(Versions.v2026_10_01)
@doc("Specifies who manages scheduled maintenance for a HorizonDB pool.")
union ScheduledMaintenanceManagementType {
  string,

  /** Scheduled maintenance is managed by the system. */
  System: "System",

  /** Scheduled maintenance is managed by the user. */
  User: "User",
}

@added(Versions.v2026_10_01)
@doc("The day of the week for user-managed scheduled maintenance.")
union ScheduledMaintenanceDayOfWeek {
  string,

  /** Sunday. */
  Sunday: "Sunday",

  /** Monday. */
  Monday: "Monday",

  /** Tuesday. */
  Tuesday: "Tuesday",

  /** Wednesday. */
  Wednesday: "Wednesday",

  /** Thursday. */
  Thursday: "Thursday",

  /** Friday. */
  Friday: "Friday",

  /** Saturday. */
  Saturday: "Saturday",
}

@added(Versions.v2026_10_01)
@doc("The status of a maintenance event.")
union MaintenanceEventStatus {
  string,

  /** The maintenance event is scheduled and has not yet started. */
  Planned: "Planned",

  /** The maintenance event is currently in progress. */
  InProgress: "InProgress",

  /** The maintenance event completed successfully. */
  Complete: "Complete",

  /** The customer rescheduled the maintenance event. */
  Rescheduled: "Rescheduled",

  /** The maintenance event was canceled, failed, or timed out. */
  Canceled: "Canceled",
}

@added(Versions.v2026_10_01)
@doc("The type of a maintenance event.")
union MaintenanceType {
  string,

  /** A planned maintenance event. */
  PlannedMaintenance: "PlannedMaintenance",
}

@added(Versions.v2026_10_01)
@doc("A filter for maintenance event status.")
union MaintenanceEventStatusFilter {
  string,

  /** Return events that have a scheduled or in-progress status. */
  Upcoming: "Upcoming",

  /** Return events that have a completed status. */
  Past: "Past",
}

@added(Versions.v2026_10_01)
@doc("The type of a HorizonDB backup. New values may be added over time.")
union BackupType {
  string,

  /** A backup created automatically by the HorizonDB service. */
  System: "System",

  /** A backup created at a customer's request. */
  User: "User",
}

@added(Versions.v2026_10_01)
@doc("The lifecycle status of a system-managed AI model.")
union SystemAiModelStatus {
  string,

  /** The system AI model is being provisioned. */
  Provisioning: "Provisioning",

  /** The system AI model is ready for use. */
  Ready: "Ready",

  /** The system AI model is being deleted. */
  Deleting: "Deleting",

  /** The lifecycle status of the system AI model is unknown. */
  Unknown: "Unknown",
}

@added(Versions.v2026_10_01)
@doc("The compute processor type.")
union ComputeProcessorType {
  string,

  /** Intel processor */
  Intel: "Intel",

  /** AMD processor */
  AMD: "AMD",
}

@added(Versions.v2026_10_01)
@doc("The compute model type.")
union PoolComputeModelType {
  string,

  /** Provisioned compute model */
  Provisioned: "Provisioned",

  /** Serverless compute model */
  Serverless: "Serverless",
}

@doc("The provisioning state.")
@lroStatus
union ProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,

  /** The HorizonDB resource operation is actively running. */
  InProgress: "InProgress",

  /** The HorizonDB resource is still provisioning. */
  Provisioning: "Provisioning",
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbParameterGroupProperties")
@doc("Properties of a HorizonDB parameter group.")
model ParameterGroupProperties {
  @doc("Parameters in the parameter group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @typeChangedFrom(Versions.v2026_10_01, LegacyParameterProperties[])
  parameters?: ParameterProperties[];

  @removed(Versions.v2026_10_01)
  @doc("Description of the parameter group.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @renamedFrom(Versions.v2026_10_01, "description")
  legacyDescription?: string;

  @added(Versions.v2026_10_01)
  @doc("Description of the parameter group. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: WritableDescription;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "pgVersion")
  @doc("PostgreSQL version for the parameter group.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  legacyPgVersion?: int32;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "version")
  @doc("Current version of the parameter group.")
  @visibility(Lifecycle.Read)
  currentVersion?: int32;

  @added(Versions.v2026_10_01)
  @doc("The PostgreSQL major version for the parameter group. This property is required during creation and is immutable thereafter. The service selects the unique location-scoped default parameter group for this version in the resource location. The DefaultParameterGroups APIs return at most one default parameter group for each PostgreSQL version in a location, so this selection is unambiguous.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  postgreSqlVersion: PostgreSqlVersion;

  @removed(Versions.v2026_10_01)
  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  applyImmediately?: boolean;

  @added(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "applyImmediately")
  @doc("Determines when dynamic parameter changes become effective. Static parameter changes always require a restart of each connected pool, regardless of this value.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  applyMethod?: ParameterApplyMethod;

  @doc("The provisioning state of the parameter group.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@removed(Versions.v2026_10_01)
@renamedFrom(Versions.v2026_10_01, "ParameterProperties")
@doc("Properties of a HorizonDB parameters.")
model LegacyParameterProperties {
  @doc("The name of the parameter.")
  name?: string;

  @visibility(Lifecycle.Read)
  @doc("The description of the parameter.")
  description?: string;

  @doc("The value of the configuration.")
  value?: string;

  @visibility(Lifecycle.Read)
  @doc("The data type of the parameter.")
  dataType?: string;

  @visibility(Lifecycle.Read)
  @doc("The allowed values for the parameter.")
  allowedValues?: string;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter can be changed dynamically.")
  isDynamic?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter is a read-only parameter.")
  isReadOnly?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Link to parameter documentation.")
  documentationLink?: url;

  @visibility(Lifecycle.Read)
  @doc("The unit of measurement for the parameter.")
  unit?: string;
}

@added(Versions.v2026_10_01)
@doc("Properties of a HorizonDB parameter.")
model ParameterProperties {
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @doc("The name of the parameter.")
  name?: string;

  @visibility(Lifecycle.Read)
  @doc("The description of the parameter.")
  description?: string;

  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @doc("The value of the configuration.")
  value?: string;

  @visibility(Lifecycle.Read)
  @doc("The data type of the parameter.")
  dataType?: string;

  @visibility(Lifecycle.Read)
  @doc("The allowed values for the parameter.")
  allowedValues?: string;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter can be changed dynamically.")
  isDynamic?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter is a read-only parameter.")
  isReadOnly?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Link to parameter documentation.")
  documentationLink?: url;

  @visibility(Lifecycle.Read)
  @doc("The unit of measurement for the parameter.")
  unit?: string;
}

@renamedFrom(
  Versions.v2026_10_01,
  "HorizonDbParameterGroupPropertiesForPatchUpdate"
)
@doc("Properties of a HorizonDB parameter group for update operations.")
model ParameterGroupPropertiesForPatchUpdate {
  @doc("Parameters in the parameter group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Update)
  @typeChangedFrom(Versions.v2026_10_01, LegacyParameterProperties[])
  parameters?: ParameterProperties[];

  @removed(Versions.v2026_10_01)
  @doc("Description of the parameter group.")
  @visibility(Lifecycle.Update)
  @renamedFrom(Versions.v2026_10_01, "description")
  legacyDescription?: string;

  @added(Versions.v2026_10_01)
  @doc("Description of the parameter group. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Update)
  description?: WritableDescription;

  @removed(Versions.v2026_10_01)
  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Update)
  applyImmediately?: boolean;

  @added(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "applyImmediately")
  @doc("Determines when dynamic parameter changes in this request become effective. This property is required when parameters is supplied and optional otherwise. Static parameter changes always require a restart of each connected pool, regardless of this value.")
  @visibility(Lifecycle.Update)
  applyMethod?: ParameterApplyMethod;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbParameterGroupForPatchUpdate")
@doc("HorizonDB parameter group for update operations.")
model ParameterGroupForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The properties that can be updated for a HorizonDB parameter group.")
  properties?: ParameterGroupPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("The Azure resource ID of a HorizonDB pool.")
scalar PoolResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/pools",
    }
  ]>;

@added(Versions.v2026_10_01)
@doc("The Azure resource ID of the HorizonDB cluster or pool associated with an endpoint.")
scalar EndpointAssociatedResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters",
    },
    {
      type: "Microsoft.HorizonDb/clusters/pools",
    }
  ]>;

@renamedFrom(
  Versions.v2026_10_01,
  "HorizonDbParameterGroupConnectionProperties"
)
@doc("Connection information for HorizonDB parameter group.")
model ParameterGroupConnectionProperties {
  @removed(Versions.v2026_10_01)
  @doc("The name of the connected resource.")
  @visibility(Lifecycle.Read)
  name?: string;

  @removed(Versions.v2026_10_01)
  @doc("The resource ID of the connected resource.")
  @visibility(Lifecycle.Read)
  id?: armResourceIdentifier;

  @removed(Versions.v2026_10_01)
  @doc("The type of the resource.")
  @visibility(Lifecycle.Read)
  type?: string;

  @added(Versions.v2026_10_01)
  @doc("The Azure resource ID of the connected HorizonDB pool.")
  @visibility(Lifecycle.Read)
  poolResourceId: PoolResourceId;
}

@added(Versions.v2026_10_01)
@doc("A default parameter group available in a specific region. For each PostgreSQL version, the DefaultParameterGroups APIs return at most one default parameter group in a location.")
model DefaultParameterGroup {
  @doc("The unique name of the default parameter group.")
  name: string;

  @doc("Parameters in the default parameter group.")
  @identifiers(#["name"])
  parameters: ParameterProperties[];

  @doc("Description of the default parameter group.")
  description?: string;

  @doc("PostgreSQL version for which this default parameter group is valid.")
  postgreSqlVersion: PostgreSqlVersion;
}

@doc("Connection information for HorizonDB parameter group.")
model HorizonDbClusterParameterGroupConnectionProperties {
  @doc("The resource ID of the connected parameter group.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  id?: armResourceIdentifier;

  @doc("Indication of if parameter group is applied on HorizonDB resource.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Versions.v2026_10_01, string)
  syncStatus?: ParameterGroupSyncStatus;

  @removed(Versions.v2026_10_01)
  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  applyImmediately?: boolean;
}

@added(Versions.v2026_10_01)
@doc("Controls when dynamic parameter changes become effective. Static parameter changes always become effective only after a pool restart, whether initiated by the customer or performed during scheduled maintenance.")
union ParameterApplyMethod {
  string,

  /** Apply dynamic parameter changes immediately. Static parameter changes remain pending until the pool restarts. */
  Immediate: "Immediate",

  /** Apply dynamic and static parameter changes when the pool next restarts, whether initiated by the customer or performed during scheduled maintenance. */
  PendingReboot: "PendingReboot",
}

@added(Versions.v2026_10_01)
@doc("Indicates synchronization status between a HorizonDB resource and its parameter group.")
union ParameterGroupSyncStatus {
  string,

  /** Parameter updates are currently being applied. */
  Applying: "Applying",

  /** Parameter values are synchronized and up to date. */
  InSync: "InSync",

  /** Applying parameter updates failed. */
  FailedToApply: "FailedToApply",

  /** Parameter updates are pending and require a reboot to take effect. */
  PendingReboot: "PendingReboot",
}
