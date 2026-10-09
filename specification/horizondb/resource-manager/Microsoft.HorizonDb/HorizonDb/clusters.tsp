import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("A lowercase enforced name as a HorizonDB cluster name.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar ClusterName extends string;

@doc("The managed identity types supported by a HorizonDB cluster.")
union HorizonDbClusterIdentityType {
  string,

  @doc("No managed identity is assigned. Setting type to None clears all managed identity assignments.")
  None: "None",

  @doc("User-assigned managed identities are assigned.")
  UserAssigned: "UserAssigned",
}

@doc("The user-assigned managed identities assigned to a HorizonDB cluster. Omitting the entire top-level identity property from PUT or PATCH preserves all current assignments. When userAssignedIdentities is supplied, PUT replaces the complete set and PATCH merges the supplied entries with the existing set; a null PATCH entry removes that individual identity. Setting type to None clears all assignments. Removing an identity referenced by a change data capture identity assignment is rejected until the referencing assignment is deleted.")
model HorizonDbClusterManagedServiceIdentity {
  @doc("The managed identity type assigned to the cluster. Setting this property to None clears all managed identity assignments.")
  type: HorizonDbClusterIdentityType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The standard Azure Resource Manager identity envelope represents user-assigned identities as a resource-ID-keyed dictionary."
  @doc("The user-assigned managed identities associated with the cluster. When supplied on PUT, this dictionary replaces the complete set of assignments. When supplied on PATCH, entries are merged with the existing set and a null value removes the corresponding identity. Each dictionary key must be the full Azure resource ID of a Microsoft.ManagedIdentity/userAssignedIdentities resource. Non-null request values can be empty objects; response values contain the service-populated clientId and principalId. Assigning an identity does not grant it access to destination resources; required role assignments must be configured separately.")
  userAssignedIdentities?: Record<
    | Azure.ResourceManager.CommonTypes.UserAssignedIdentity
    | null>;
}

@doc("The user-assigned managed identity envelope for a HorizonDB cluster.")
model HorizonDbClusterManagedServiceIdentityProperty {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The standard managed identity envelope also permits system-assigned identity values, which HorizonDB clusters do not support."
  @doc("The managed service identities assigned to this resource. Omitting the entire identity property from PUT or PATCH preserves all current assignments. When provided, PUT replaces the user-assigned identity set and PATCH merges it; null PATCH dictionary entries remove individual identities. Setting type to None clears all assignments.")
  identity?: HorizonDbClusterManagedServiceIdentity;
}

@doc("Represents the HorizonDB cluster.")
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  @doc("The name of the HorizonDB cluster.")
  @key("clusterName")
  @path
  @segment("clusters")
  name: ClusterName;

  ...HorizonDbClusterManagedServiceIdentityProperty;
}

@doc("Properties of a HorizonDB cluster.")
model ClusterProperties {
  @doc("The PostgreSQL major version used by the HorizonDB cluster. API version 2026-10-01-preview supports versions 17 and 18. For ordinary cluster creation, the version is supplied in the request and is immutable after creation. For point-in-time restore, the service obtains the version from the source backup metadata and the request must omit this property. This API version does not support in-place PostgreSQL major-version upgrades.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  postgreSqlVersion?: PostgreSqlVersion;

  @doc("The mode used to create the cluster. When this property is omitted while creating a new cluster, the service records Create. PointInTimeRestore creates a new cluster from an available backup; pointInTimeUtc and creationSourceClusterResourceId are then required, postgreSqlVersion must be omitted because it is obtained from the backup metadata, and creationSourceClusterLocation is required when the source and target cluster locations differ. This property is immutable and is returned as creation provenance. On replacement, omission preserves the recorded value, resubmitting the same value is accepted, and changing it is rejected.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  creationMode?: ClusterCreateMode;

  @doc("The requested point in time, in UTC. This property is required in every PointInTimeRestore request. For a same-location restore, the service restores the latest backup available at or before this value. For a cross-location restore, the service requires but ignores this value and restores the latest available backup; cross-location responses omit this property. This property must be absent for other creation modes or when creationMode is omitted and can only be specified during resource creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  pointInTimeUtc?: utcDateTime;

  @doc("The Azure resource ID of the source HorizonDB cluster used by the selected creation mode. This property is required for PointInTimeRestore and other source-based creation modes, and must be absent when creationMode is Create or omitted. A source cluster does not need to have a pool to be restored, provided an available backup exists. This immutable creation-provenance value does not change after creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  creationSourceClusterResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters";
    }
  ]>;

  @doc("The Azure location of the source HorizonDB cluster used for point-in-time restore. This property is optional when the source and target cluster locations are the same. It is required when the source cluster location differs from the target cluster location and must identify the source cluster's location. This property must be absent for creation modes other than PointInTimeRestore or when creationMode is omitted. This immutable creation-provenance value does not change after creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  creationSourceClusterLocation?: string;

  @doc("The network configuration for the cluster. When this object is omitted, the service defaults it to publicAccess Disabled.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  network?: Network = #{ publicAccess: "Disabled" };

  @doc("The backup configuration for the cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  backup?: BackupProperties;

  @doc("The data encryption configuration for the cluster. When omitted during initial cluster creation, the service uses SystemManaged encryption. When supplied during initial cluster creation, type is required. For PUT updates of an existing cluster, type may be omitted; if provided, it must match the existing encryption type. The encryption type is selected at cluster creation; switching between SystemManaged and AzureKeyVault after creation is not supported.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  dataEncryption?: HorizonDbClusterDataEncryption;

  @doc("Current state of the cluster.")
  @visibility(Lifecycle.Read)
  state: ClusterState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "API version 2026-10-01-preview guarantees provisioningState in every Cluster response; the 2026-01-20-preview projection remains optional."
  @doc("The provisioning state of the cluster.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @doc("The pool currently designated to host the cluster's read-write node.")
  @visibility(Lifecycle.Read)
  readWritePool: ReadWritePoolProperties;
}

@doc("The pool currently designated to host a HorizonDB cluster's read-write node. When a pool is created while the cluster currently has no pools, the service automatically designates the new pool as the read-write pool. This behavior also applies after all pools that existed earlier in the cluster's lifetime have been deleted.")
model ReadWritePoolProperties {
  @doc("The Azure resource ID of the pool designated to host the cluster's read-write node. The pool is a child resource of this cluster. When a pool is created while the cluster currently has no pools, the service automatically sets this property to the new pool's resource ID, including when all pools that existed earlier in the cluster's lifetime were deleted. This property is absent when no pool is designated, such as after clearReadWritePool succeeds.")
  @visibility(Lifecycle.Read)
  designatedPoolResourceId?: PoolResourceId;
}

@doc("Properties of a HorizonDB cluster for update operations.")
model ClusterPropertiesForPatchUpdate {
  @doc("The network configuration to update for the cluster.")
  @visibility(Lifecycle.Update)
  network?: NetworkForPatchUpdate;

  @doc("The backup configuration for the cluster.")
  @visibility(Lifecycle.Update)
  backup?: BackupPropertiesForPatchUpdate;

  @doc("The data encryption configuration to update for the cluster. Omitted properties preserve their current values. Updates can modify settings within the existing encryption type, but switching between SystemManaged and AzureKeyVault after cluster creation is not supported.")
  @visibility(Lifecycle.Update)
  dataEncryption?: HorizonDbClusterDataEncryptionForPatchUpdate;
}

@doc("HorizonDB cluster for update operations.")
model ClusterForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...HorizonDbClusterManagedServiceIdentityProperty;

  @doc("The properties that can be updated for a HorizonDB cluster.")
  properties?: ClusterPropertiesForPatchUpdate;
}

@doc("Network properties.")
model Network {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicAccess is a configuration flag, not sensitive data"
  @doc("Specifies whether public access is enabled for the cluster. The service defaults to Disabled when this property is omitted.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  publicAccess?: PublicNetworkAccessState = PublicNetworkAccessState.Disabled;
}

@doc("Network properties for updating a HorizonDB cluster.")
model NetworkForPatchUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicAccess is a configuration flag, not sensitive data"
  @doc("Specifies whether public access is enabled for the cluster. Omission preserves the current value.")
  @visibility(Lifecycle.Update)
  publicAccess?: PublicNetworkAccessState;
}

@doc("The type of data encryption used by a HorizonDB cluster. The type is selected at cluster creation; switching between SystemManaged and AzureKeyVault after creation is not supported.")
union HorizonDbClusterDataEncryptionType {
  string,

  @doc("Data encryption is managed by Azure using platform-managed keys.")
  SystemManaged: "SystemManaged",

  @doc("Data encryption uses customer-managed keys stored in Azure Key Vault.")
  AzureKeyVault: "AzureKeyVault",
}

@doc("The validation status of a customer-managed encryption key used by a HorizonDB cluster.")
union HorizonDbClusterEncryptionKeyStatus {
  string,

  @doc("The encryption key is valid and accessible to the configured user-assigned managed identity.")
  Valid: "Valid",

  @doc("The encryption key is invalid or inaccessible to the configured user-assigned managed identity.")
  Invalid: "Invalid",
}

@doc("A versionless HTTPS Azure Key Vault key URI. The URI must use a supported public or sovereign Azure Key Vault DNS suffix and the path /keys/{key-name}. Key version paths are not supported.")
@pattern("^https://[A-Za-z0-9-]+[.]vault([.]azure[.]net|[.]usgovcloudapi[.]net|[.]azure[.]cn)/keys/[A-Za-z0-9-]+/?$")
scalar VersionlessKeyVaultKeyUri extends url;

@doc("The Cluster-level data encryption configuration. The encryption type is selected at cluster creation; switching between SystemManaged and AzureKeyVault after creation is not supported. For AzureKeyVault encryption, primaryKeyUri and primaryUserAssignedIdentityId are required, and backup.geoRedundancy must be Disabled. Both primaryKeyUri and primaryUserAssignedIdentityId can be provided during initial cluster creation. For updates to an existing cluster through PUT or PATCH, only one of these properties can change per request, and that update must complete before submitting a separate update to change the other property. Customer-managed key identities must also be assigned to the Cluster through its top-level identity property. Only versionless Azure Key Vault key URIs are supported; key version paths are rejected. For SystemManaged encryption, key and identity properties must be omitted.")
model HorizonDbClusterDataEncryption {
  @doc("The type of data encryption used by the cluster. When the data encryption configuration is supplied during initial cluster creation, this property is required. For PUT updates of an existing cluster, this property may be omitted; if provided, it must match the existing encryption type. This value is selected at cluster creation and cannot later be changed from SystemManaged to AzureKeyVault or from AzureKeyVault to SystemManaged.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  type?: HorizonDbClusterDataEncryptionType;

  @doc("The versionless Azure Key Vault key URI used to encrypt the cluster's primary storage. Key version paths are not supported. During initial cluster creation, this property can be provided together with primaryUserAssignedIdentityId. For updates to an existing cluster through PUT or PATCH, this property and primaryUserAssignedIdentityId cannot both change in the same request; the first update must complete before submitting a separate update for the other property.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  primaryKeyUri?: VersionlessKeyVaultKeyUri;

  @doc("The Azure resource ID of the user-assigned managed identity used to access the primary encryption key. The identity must also be assigned to the Cluster through its top-level identity property. During initial cluster creation, this property can be provided together with primaryKeyUri. For updates to an existing cluster through PUT or PATCH, this property and primaryKeyUri cannot both change in the same request; the first update must complete before submitting a separate update for the other property.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  primaryUserAssignedIdentityId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  @doc("The validation status of the primary encryption key. This property is returned for AzureKeyVault encryption and is absent for SystemManaged encryption.")
  @visibility(Lifecycle.Read)
  primaryEncryptionKeyStatus?: HorizonDbClusterEncryptionKeyStatus;

  @doc("The current version of the primary encryption key used by the cluster. This property is returned for AzureKeyVault encryption and is absent for SystemManaged encryption.")
  @visibility(Lifecycle.Read)
  primaryEncryptionKeyCurrentVersion?: string;
}

@doc("Properties for sparsely updating Cluster-level data encryption. Omitted properties preserve their current values. Updates can modify settings within the existing encryption type, such as the primary Azure Key Vault key URI, but switching between SystemManaged and AzureKeyVault after cluster creation is not supported. AzureKeyVault encryption is not supported when backup.geoRedundancy is Enabled. An update can change only one of primaryKeyUri or primaryUserAssignedIdentityId; that update must complete before submitting a separate update to change the other property.")
model HorizonDbClusterDataEncryptionForPatchUpdate {
  @doc("The existing data encryption type used by the cluster. PATCH is a sparse update, so this property may be omitted. If provided, it must match the existing encryption type. This value cannot be changed from SystemManaged to AzureKeyVault or from AzureKeyVault to SystemManaged after cluster creation.")
  @visibility(Lifecycle.Update)
  type?: HorizonDbClusterDataEncryptionType;

  @doc("The versionless Azure Key Vault key URI used to encrypt the cluster's primary storage. Key version paths are not supported. This property and primaryUserAssignedIdentityId cannot both change in the same update; the first update must complete before submitting a separate update for the other property.")
  @visibility(Lifecycle.Update)
  primaryKeyUri?: VersionlessKeyVaultKeyUri;

  @doc("The Azure resource ID of the user-assigned managed identity used to access the primary encryption key. The identity must also be assigned to the Cluster through its top-level identity property. This property and primaryKeyUri cannot both change in the same update; the first update must complete before submitting a separate update for the other property.")
  @visibility(Lifecycle.Update)
  primaryUserAssignedIdentityId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("Backup configuration properties for a HorizonDB cluster.")
model BackupProperties {
  @doc("The geo-redundancy state. Geo-redundant backup is not supported when dataEncryption.type is AzureKeyVault.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  geoRedundancy: GeoRedundancyState;

  @doc("The number of days that automatic backups are retained. The service defaults to 7 days when this property is omitted.")
  @minValue(1)
  @maxValue(35)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  retentionDays?: int32 = 7;

  @doc("The earliest point in time, in UTC, to which the cluster can currently be restored.")
  @visibility(Lifecycle.Read)
  earliestRestorePointUtc?: utcDateTime;
}

@doc("Backup configuration properties for updating a HorizonDB cluster.")
model BackupPropertiesForPatchUpdate {
  @doc("The number of days that automatic backups are retained.")
  @minValue(1)
  @maxValue(35)
  @visibility(Lifecycle.Update)
  retentionDays?: int32;
}

@doc("Indicates the geo-redundancy state.")
union GeoRedundancyState {
  string,

  @doc("Geo-redundancy is enabled. This value is not supported when dataEncryption.type is AzureKeyVault.")
  Enabled: "Enabled",

  @doc("Geo-redundancy is disabled")
  Disabled: "Disabled",
}

@doc("The mode to create a new HorizonDB cluster.")
union CreateModeCluster {
  string,

  /** Create a new cluster */
  Create: "Create",

  /** Create cluster from point-in-time restore */
  PointInTimeRestore: "PointInTimeRestore",
}

@doc("Controls how a HorizonDB cluster PUT request is processed.")
union ClusterCreateMode {
  string,

  /** Process the request as a normal cluster creation. */
  Create: "Create",

  /** Create the cluster from a point-in-time restore. */
  PointInTimeRestore: "PointInTimeRestore",
}

@doc("Current state of a HorizonDB cluster.")
union ClusterState {
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
}

@doc("Long-running operation headers returned when a HorizonDB cluster update is accepted.")
model ClusterUpdateAcceptedHeaders is ArmLroLocationHeader<
  Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
  Cluster,
  string
> {
  @doc("A link to the status monitor for the cluster update operation.")
  @Azure.Core.pollingLocation(
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>
  )
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;
}

@doc("Long-running operation headers returned when an asynchronous HorizonDB cluster create or replacement is accepted.")
model ClusterCreateOrReplaceLroHeaders {
  @doc("A link to the status monitor for the cluster create or replacement operation.")
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;

  ...Azure.Core.Foundations.RetryAfterHeader;
}

@doc("The response returned when an asynchronous HorizonDB cluster replacement is accepted.")
model ClusterReplaceAcceptedResponse {
  ...OkResponse;
  ...ClusterCreateOrReplaceLroHeaders;

  @doc("The HorizonDB cluster with a non-terminal provisioning state.")
  @bodyRoot
  body: Cluster;
}

@doc("The response returned when asynchronous HorizonDB cluster creation is accepted.")
model ClusterCreateAcceptedResponse {
  ...CreatedResponse;
  ...ClusterCreateOrReplaceLroHeaders;

  @doc("The HorizonDB cluster with a non-terminal provisioning state.")
  @bodyRoot
  body: Cluster;
}

@doc("Indicates if public network access is enabled or not.")
union PublicNetworkAccessState {
  string,

  @doc("Public network access is enabled")
  Enabled: "Enabled",

  @doc("Public network access is disabled")
  Disabled: "Disabled",
}

@armResourceOperations
interface Clusters {
  @doc("Gets information about a HorizonDB cluster.")
  get is ArmResourceRead<Cluster>;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The AutoRest emitter infers final-state-via from polling metadata. Marking this standard ARM PUT as an LRO without polling decorators emits x-ms-long-running-operation while intentionally omitting x-ms-long-running-operation-options."
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

  @sharedRoute
  @doc("Updates an existing HorizonDB cluster.")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterForPatchUpdate,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    ClusterUpdateAcceptedHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

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

  @doc("Triggers failover within the cluster's designated read-write pool. HorizonDB selects the replacement node using the same eligibility and node-selection rules as automatic failover. The request fails with 409 Conflict when the designated pool is not eligible for failover or another conflicting operation is in progress.")
  @action("failover")
  failover is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<Cluster>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
