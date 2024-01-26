import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.RecoveryServices;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Specifies the authentication type.
 */
enum AuthType {
  Invalid,
  ACS,
  AAD,
  AccessControlService,
  AzureActiveDirectory,
}

/**
 * Subresource type for vault AzureBackup, AzureBackup_secondary or AzureSiteRecovery
 */
enum VaultSubResourceType {
  AzureBackup,
  AzureBackup_secondary,
  AzureSiteRecovery,
}

/**
 * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.
 */
enum ResourceIdentityType {
  SystemAssigned,
  None,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * Status of the vault upgrade operation.
 */
enum VaultUpgradeState {
  Unknown,
  InProgress,
  Upgraded,
  Failed,
}

/**
 * The way the vault upgrade was triggered.
 */
enum TriggerType {
  UserTriggered,
  ForcedUpgrade,
}

/**
 * Gets or sets provisioning state of the private endpoint connection.
 */
enum ProvisioningState {
  Succeeded,
  Deleting,
  Failed,
  Pending,
}

/**
 * Gets or sets the status.
 */
enum PrivateEndpointConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Private endpoint state for backup.
 */
enum VaultPrivateEndpointState {
  None,
  Enabled,
}

/**
 * Enabling/Disabling the Double Encryption state
 */
enum InfrastructureEncryptionState {
  Enabled,
  Disabled,
}

/**
 * The State of the Resource after the move operation
 */
enum ResourceMoveState {
  Unknown,
  InProgress,
  PrepareFailed,
  CommitFailed,
  PrepareTimedout,
  CommitTimedout,
  MoveSucceeded,
  Failure,
  CriticalFailure,
  PartialSuccess,
}

/**
 * Backup storage version
 */
enum BackupStorageVersion {
  V1,
  V2,
  Unassigned,
}

/**
 * property to enable or disable resource provider inbound network traffic from public clients
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

enum AlertsState {
  Enabled,
  Disabled,
}

enum CrossSubscriptionRestoreState {
  Enabled,
  Disabled,
  PermanentlyDisabled,
}

/**
 * The storage redundancy setting of a vault
 */
enum StandardTierStorageRedundancy {
  LocallyRedundant,
  GeoRedundant,
  ZoneRedundant,
}

/**
 * Flag to show if Cross Region Restore is enabled on the Vault or not
 */
enum CrossRegionRestore {
  Enabled,
  Disabled,
}

enum ImmutabilityState {
  Disabled,
  Unlocked,
  Locked,
}

enum SoftDeleteState {
  Invalid,
  Enabled,
  Disabled,
  AlwaysON,
}

/**
 * MUA Settings of vault
 */
enum MultiUserAuthorization {
  Invalid,
  Enabled,
  Disabled,
}

/**
 * Secure Score of Recovery Services Vault
 */
enum SecureScoreLevel {
  None,
  Minimum,
  Adequate,
  Maximum,
}

/**
 * Name of SKU is RS0 (Recovery Services 0th version) and the tier is standard tier. They do not have affect on backend storage redundancy or any other vault settings. To manage storage redundancy, use the backupstorageconfig
 */
enum SkuName {
  Standard,
  RS0,
}

/**
 * Unit of the usage.
 */
enum UsagesUnit {
  Count,
  Bytes,
  Seconds,
  Percent,
  CountPerSecond,
  BytesPerSecond,
}

/**
 * Details of the certificate to be uploaded to the vault.
 */
model CertificateRequest {
  /**
   * Raw certificate data.
   */
  properties?: RawCertificateData;
}

/**
 * Raw certificate data.
 */
model RawCertificateData {
  /**
   * Specifies the authentication type.
   */
  authType?: AuthType;

  /**
   * The base64 encoded certificate raw data string
   */
  certificate?: bytes;
}

/**
 * Certificate corresponding to a vault that can be used by clients to register themselves with the vault.
 */
model VaultCertificateResponse {
  /**
   * Resource name associated with the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...
   */
  @visibility("read")
  type?: string;

  /**
   * Resource Id represents the complete path to the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Certificate details representing the Vault credentials.
   */
  properties?: ResourceCertificateDetails;
}

/**
 * Certificate details representing the Vault credentials.
 */
@discriminator("authType")
model ResourceCertificateDetails {
  /**
   * The base64 encoded certificate raw data string.
   */
  certificate?: bytes;

  /**
   * Certificate friendly name.
   */
  friendlyName?: string;

  /**
   * Certificate issuer.
   */
  issuer?: string;

  /**
   * Resource ID of the vault.
   */
  resourceId?: int64;

  /**
   * Certificate Subject Name.
   */
  subject?: string;

  /**
   * Certificate thumbprint.
   */
  thumbprint?: string;

  /**
   * Certificate Validity start Date time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validFrom?: utcDateTime;

  /**
   * Certificate Validity End Date time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validTo?: utcDateTime;
}

/**
 * Replication usages for vault.
 */
@pagedResult
model ReplicationUsageList {
  /**
   * The list of replication usages for the given vault.
   */
  @items
  value?: ReplicationUsage[];
}

/**
 * Replication usages of a vault.
 */
model ReplicationUsage {
  /**
   * Summary of the replication monitoring data for this vault.
   */
  monitoringSummary?: MonitoringSummary;

  /**
   * Summary of the replication jobs data for this vault.
   */
  jobsSummary?: JobsSummary;

  /**
   * Number of replication protected items for this vault.
   */
  protectedItemCount?: int32;

  /**
   * Number of replication recovery plans for this vault.
   */
  recoveryPlanCount?: int32;

  /**
   * Number of servers registered to this vault.
   */
  registeredServersCount?: int32;

  /**
   * The authentication type of recovery service providers in the vault.
   */
  recoveryServicesProviderAuthType?: int32;
}

/**
 * Summary of the replication monitoring data for this vault.
 */
model MonitoringSummary {
  /**
   * Count of unhealthy VMs.
   */
  unHealthyVmCount?: int32;

  /**
   * Count of unhealthy replication providers.
   */
  unHealthyProviderCount?: int32;

  /**
   * Count of all critical warnings.
   */
  eventsCount?: int32;

  /**
   * Count of all deprecated recovery service providers.
   */
  deprecatedProviderCount?: int32;

  /**
   * Count of all the supported recovery service providers.
   */
  supportedProviderCount?: int32;

  /**
   * Count of all the unsupported recovery service providers.
   */
  unsupportedProviderCount?: int32;
}

/**
 * Summary of the replication job data for this vault.
 */
model JobsSummary {
  /**
   * Count of failed jobs.
   */
  failedJobs?: int32;

  /**
   * Count of suspended jobs.
   */
  suspendedJobs?: int32;

  /**
   * Count of in-progress jobs.
   */
  inProgressJobs?: int32;
}

/**
 * Properties of the private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * e.g. f9ad6492-33d4-4690-9999-6bfd52a0d081 (Backup) or f9ad6492-33d4-4690-9999-6bfd52a0d082 (SiteRecovery)
   */
  @visibility("read")
  groupId?: string;

  /**
   * [backup-ecs1, backup-prot1, backup-prot1b, backup-prot1c, backup-id1]
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  @visibility("read")
  requiredZoneNames?: string[];
}

/**
 * An error response from Azure Backup.
 */
@error
model CloudError {
  /**
   * The resource management error response.
   */
  error?: Error;
}

/**
 * The resource management error response.
 */
model Error {
  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];

  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: Error[];

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;
}

/**
 * Resource Name availability input parameters - Resource type and resource name
 */
model CheckNameAvailabilityParameters {
  /**
   * Describes the Resource type: Microsoft.RecoveryServices/Vaults
   */
  type?: string;

  /**
   * Resource name for which availability needs to be checked
   */
  name?: string;
}

/**
 * Response for check name availability API. Resource provider will set availability as true | false.
 */
model CheckNameAvailabilityResult {
  nameAvailable?: boolean;
  reason?: string;
  message?: string;
}

/**
 * Input to get capabilities information for Microsoft.RecoveryServices
 */
model ResourceCapabilities extends ResourceCapabilitiesBase {
  /**
   * Capabilities information
   */
  properties?: CapabilitiesProperties;
}

/**
 * Capabilities information
 */
model CapabilitiesProperties {
  dnsZones?: DNSZone[];
}

/**
 * DNSZone information
 */
model DNSZone {
  /**
   * Subresource type for vault AzureBackup, AzureBackup_secondary or AzureSiteRecovery
   */
  subResource?: VaultSubResourceType;
}

/**
 * Base class for request and response capabilities information for Microsoft.RecoveryServices
 */
model ResourceCapabilitiesBase {
  /**
   * Describes the Resource type: Microsoft.RecoveryServices/Vaults
   */
  type: string;
}

/**
 * Capabilities response for Microsoft.RecoveryServices
 */
model CapabilitiesResponse extends ResourceCapabilitiesBase {
  /**
   * Capabilities properties in response
   */
  properties?: CapabilitiesResponseProperties;
}

/**
 * Capabilities properties in response
 */
model CapabilitiesResponseProperties {
  dnsZones?: DNSZoneResponse[];
}

/**
 * DNSZone information for Microsoft.RecoveryServices
 */
model DNSZoneResponse extends DNSZone {
  /**
   * The private link resource Private link DNS zone names.
   */
  requiredZoneNames?: string[];
}

/**
 * Identity for the resource.
 */
model IdentityData {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.
   */
  type: ResourceIdentityType;

  /**
   * The list of user-assigned identities associated with the resource. The user-assigned identity dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: Record<UserIdentity>;
}

/**
 * A resource identity that is managed by the user of the service.
 */
model UserIdentity {
  /**
   * The principal ID of the user-assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client ID of the user-assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Properties of the vault.
 */
model VaultProperties {
  /**
   * Provisioning State.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Details for upgrading vault.
   */
  upgradeDetails?: UpgradeDetails;

  /**
   * List of private endpoint connection.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionVaultProperties[];

  /**
   * Private endpoint state for backup.
   */
  @visibility("read")
  privateEndpointStateForBackup?: VaultPrivateEndpointState;

  /**
   * Private endpoint state for site recovery.
   */
  @visibility("read")
  privateEndpointStateForSiteRecovery?: VaultPrivateEndpointState;

  /**
   * Customer Managed Key details of the resource.
   */
  encryption?: VaultPropertiesEncryption;

  /**
   * The details of the latest move operation performed on the Azure Resource
   */
  moveDetails?: VaultPropertiesMoveDetails;

  /**
   * The State of the Resource after the move operation
   */
  @visibility("read")
  moveState?: ResourceMoveState;

  /**
   * Backup storage version
   */
  @visibility("read")
  backupStorageVersion?: BackupStorageVersion;

  /**
   * property to enable or disable resource provider inbound network traffic from public clients
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Monitoring Settings of the vault
   */
  monitoringSettings?: MonitoringSettings;

  /**
   * Restore Settings of the vault
   */
  restoreSettings?: RestoreSettings;

  /**
   * The redundancy Settings of a Vault
   */
  redundancySettings?: VaultPropertiesRedundancySettings;

  /**
   * Security Settings of the vault
   */
  securitySettings?: SecuritySettings;

  /**
   * Secure Score of Recovery Services Vault
   */
  @visibility("read")
  secureScore?: SecureScoreLevel;
}

/**
 * Details for upgrading vault.
 */
model UpgradeDetails {
  /**
   * ID of the vault upgrade operation.
   */
  @visibility("read")
  operationId?: string;

  /**
   * UTC time at which the upgrade operation has started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * UTC time at which the upgrade operation status was last updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimeUtc?: utcDateTime;

  /**
   * UTC time at which the upgrade operation has ended.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Status of the vault upgrade operation.
   */
  @visibility("read")
  status?: VaultUpgradeState;

  /**
   * Message to the user containing information about the upgrade operation.
   */
  @visibility("read")
  message?: string;

  /**
   * The way the vault upgrade was triggered.
   */
  @visibility("read")
  triggerType?: TriggerType;

  /**
   * Resource ID of the upgraded vault.
   */
  @visibility("read")
  upgradedResourceId?: string;

  /**
   * Resource ID of the vault before the upgrade.
   */
  @visibility("read")
  previousResourceId?: string;
}

/**
 * Information to be stored in Vault properties as an element of privateEndpointConnections List.
 */
model PrivateEndpointConnectionVaultProperties {
  /**
   * Format of id subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.[Service]/{resource}/{resourceName}/privateEndpointConnections/{connectionName}.
   */
  @visibility("read")
  id?: string;

  /**
   * Private Endpoint Connection Response Properties.
   */
  @visibility("read")
  properties?: PrivateEndpointConnection;

  /**
   * The name of the private Endpoint Connection
   */
  @visibility("read")
  name?: string;

  /**
   * The type, which will be of the format, Microsoft.RecoveryServices/vaults/privateEndpointConnections
   */
  @visibility("read")
  type?: string;

  /**
   * The location of the private Endpoint connection
   */
  @visibility("read")
  location?: string;
}

/**
 * Private Endpoint Connection Response Properties.
 */
model PrivateEndpointConnection {
  /**
   * Gets or sets provisioning state of the private endpoint connection.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The Private Endpoint network resource that is linked to the Private Endpoint connection.
   */
  @visibility("read")
  privateEndpoint?: PrivateEndpoint;

  /**
   * Gets or sets private link service connection state.
   */
  @visibility("read")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * Group Ids for the Private Endpoint
   */
  groupIds?: VaultSubResourceType[];
}

/**
 * The Private Endpoint network resource that is linked to the Private Endpoint connection.
 */
model PrivateEndpoint {
  /**
   * Gets or sets id.
   */
  @visibility("read")
  id?: string;
}

/**
 * Gets or sets private link service connection state.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Gets or sets the status.
   */
  @visibility("read")
  status?: PrivateEndpointConnectionStatus;

  /**
   * Gets or sets description.
   */
  @visibility("read")
  description?: string;

  /**
   * Gets or sets actions required.
   */
  @visibility("read")
  actionsRequired?: string;
}

/**
 * Customer Managed Key details of the resource.
 */
model VaultPropertiesEncryption {
  /**
   * The properties of the Key Vault which hosts CMK
   */
  keyVaultProperties?: CmkKeyVaultProperties;

  /**
   * The details of the identity used for CMK
   */
  kekIdentity?: CmkKekIdentity;

  /**
   * Enabling/Disabling the Double Encryption state
   */
  infrastructureEncryption?: InfrastructureEncryptionState;
}

/**
 * The properties of the Key Vault which hosts CMK
 */
model CmkKeyVaultProperties {
  /**
   * The key uri of the Customer Managed Key
   */
  keyUri?: string;
}

/**
 * The details of the identity used for CMK
 */
model CmkKekIdentity {
  /**
   * Indicate that system assigned identity should be used. Mutually exclusive with 'userAssignedIdentity' field
   */
  useSystemAssignedIdentity?: boolean;

  /**
   * The user assigned identity to be used to grant permissions in case the type of identity used is UserAssigned
   */
  userAssignedIdentity?: string;
}

/**
 * The details of the latest move operation performed on the Azure Resource
 */
model VaultPropertiesMoveDetails {
  /**
   * OperationId of the Resource Move Operation
   */
  @visibility("read")
  operationId?: string;

  /**
   * Start Time of the Resource Move Operation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * End Time of the Resource Move Operation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completionTimeUtc?: utcDateTime;

  /**
   * Source Resource of the Resource Move Operation
   */
  @visibility("read")
  sourceResourceId?: string;

  /**
   * Target Resource of the Resource Move Operation
   */
  @visibility("read")
  targetResourceId?: string;
}

/**
 * Monitoring Settings of the vault
 */
model MonitoringSettings {
  /**
   * Settings for Azure Monitor based alerts
   */
  azureMonitorAlertSettings?: AzureMonitorAlertSettings;

  /**
   * Settings for classic alerts
   */
  classicAlertSettings?: ClassicAlertSettings;
}

/**
 * Settings for Azure Monitor based alerts
 */
model AzureMonitorAlertSettings {
  alertsForAllJobFailures?: AlertsState;
}

/**
 * Settings for classic alerts
 */
model ClassicAlertSettings {
  alertsForCriticalOperations?: AlertsState;
}

/**
 * Restore Settings  of the vault
 */
model RestoreSettings {
  /**
   * Settings for CrossSubscriptionRestore
   */
  crossSubscriptionRestoreSettings?: CrossSubscriptionRestoreSettings;
}

/**
 * Settings for Cross Subscription Restore Settings
 */
model CrossSubscriptionRestoreSettings {
  crossSubscriptionRestoreState?: CrossSubscriptionRestoreState;
}

/**
 * The redundancy Settings of a Vault
 */
model VaultPropertiesRedundancySettings {
  /**
   * The storage redundancy setting of a vault
   */
  @visibility("read")
  standardTierStorageRedundancy?: StandardTierStorageRedundancy;

  /**
   * Flag to show if Cross Region Restore is enabled on the Vault or not
   */
  @visibility("read")
  crossRegionRestore?: CrossRegionRestore;
}

/**
 * Security Settings of the vault
 */
model SecuritySettings {
  /**
   * Immutability Settings of a vault
   */
  immutabilitySettings?: ImmutabilitySettings;

  /**
   * Soft delete Settings of a vault
   */
  softDeleteSettings?: SoftDeleteSettings;

  /**
   * MUA Settings of a vault
   */
  @visibility("read")
  multiUserAuthorization?: MultiUserAuthorization;
}

/**
 * Immutability Settings of vault
 */
model ImmutabilitySettings {
  state?: ImmutabilityState;
}

/**
 * Soft delete Settings of vault
 */
model SoftDeleteSettings {
  softDeleteState?: SoftDeleteState;

  /**
   * Soft delete retention period in days
   */
  softDeleteRetentionPeriodInDays?: int32;
}

/**
 * Identifies the unique system identifier for each Azure resource.
 */
model Sku {
  /**
   * Name of SKU is RS0 (Recovery Services 0th version) and the tier is standard tier. They do not have affect on backend storage redundancy or any other vault settings. To manage storage redundancy, use the backupstorageconfig
   */
  name: SkuName;

  /**
   * The Sku tier.
   */
  tier?: string;

  /**
   * The sku family
   */
  family?: string;

  /**
   * The sku size
   */
  size?: string;

  /**
   * The sku capacity
   */
  capacity?: string;
}

/**
 * ARM Resource.
 */
model Resource {
  /**
   * Resource Id represents the complete path to the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name associated with the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...
   */
  @visibility("read")
  type?: string;

  /**
   * Optional ETag.
   */
  etag?: string;
}

/**
 * Available operation details.
 */
model ClientDiscoveryValueForSingleApi {
  /**
   * Name of the Operation.
   */
  name?: string;

  /**
   * Contains the localized display information for this particular operation
   */
  display?: ClientDiscoveryDisplay;

  /**
   * The intended executor of the operation;governs the display of the operation in the RBAC UX and the audit logs UX
   */
  origin?: string;

  /**
   * ShoeBox properties for the given operation.
   */
  properties?: ClientDiscoveryForProperties;
}

/**
 * Localized display information of an operation.
 */
model ClientDiscoveryDisplay {
  /**
   * Name of the provider for display purposes
   */
  provider?: string;

  /**
   * ResourceType for which this Operation can be performed.
   */
  resource?: string;

  /**
   * Operations Name itself.
   */
  operation?: string;

  /**
   * Description of the operation having details of what operation is about.
   */
  description?: string;
}

/**
 * Class to represent shoebox properties in json client discovery.
 */
model ClientDiscoveryForProperties {
  /**
   * Operation properties.
   */
  serviceSpecification?: ClientDiscoveryForServiceSpecification;
}

/**
 * Class to represent shoebox service specification in json client discovery.
 */
model ClientDiscoveryForServiceSpecification {
  /**
   * List of log specifications of this operation.
   */
  logSpecifications?: ClientDiscoveryForLogSpecification[];
}

/**
 * Class to represent shoebox log specification in json client discovery.
 */
model ClientDiscoveryForLogSpecification {
  /**
   * Name of the log.
   */
  name?: string;

  /**
   * Localized display name
   */
  displayName?: string;

  /**
   * Blobs created in customer storage account per hour
   */
  blobDuration?: string;
}

/**
 * Patch Resource information, as returned by the resource provider.
 */
model PatchVault extends PatchTrackedResource {
  /**
   * Properties of the vault.
   */
  properties?: VaultProperties;

  /**
   * Identifies the unique system identifier for each Azure resource.
   */
  sku?: Sku;

  /**
   * Identity for the resource.
   */
  identity?: IdentityData;
}

/**
 * Tracked resource with location.
 */
model PatchTrackedResource extends Resource {
  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Vault extended information.
 */
model VaultExtendedInfoProperties {
  /**
   * Integrity key.
   */
  integrityKey?: string;

  /**
   * Encryption key.
   */
  encryptionKey?: string;

  /**
   * Encryption key thumbprint.
   */
  encryptionKeyThumbprint?: string;

  /**
   * Algorithm for Vault ExtendedInfo
   */
  algorithm?: string;
}

/**
 * Usage for vault.
 */
@pagedResult
model VaultUsageList {
  /**
   * The list of usages for the given vault.
   */
  @items
  value?: VaultUsage[];
}

/**
 * Usages of a vault.
 */
model VaultUsage {
  /**
   * Unit of the usage.
   */
  unit?: UsagesUnit;

  /**
   * Quota period of usage.
   */
  quotaPeriod?: string;

  /**
   * Next reset time of usage.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  /**
   * Current value of usage.
   */
  currentValue?: int64;

  /**
   * Limit of usage.
   */
  limit?: int64;

  /**
   * Name of usage.
   */
  name?: NameInfo;
}

/**
 * The name of usage.
 */
model NameInfo {
  /**
   * Value of usage.
   */
  value?: string;

  /**
   * Localized value of usage.
   */
  localizedValue?: string;
}

/**
 * Certificate details representing the Vault credentials for AAD.
 */
model ResourceCertificateAndAadDetails extends ResourceCertificateDetails {
  /**
   * AAD tenant authority.
   */
  aadAuthority: string;

  /**
   * AAD tenant Id.
   */
  aadTenantId: string;

  /**
   * AAD service principal clientId.
   */
  servicePrincipalClientId: string;

  /**
   * AAD service principal ObjectId.
   */
  servicePrincipalObjectId: string;

  /**
   * Azure Management Endpoint Audience.
   */
  azureManagementEndpointAudience: string;

  /**
   * Service Resource Id.
   */
  serviceResourceId?: string;

  /**
   * AAD audience for the resource
   */
  aadAudience?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  authType: "AzureActiveDirectory";
}

/**
 * Certificate details representing the Vault credentials for ACS.
 */
model ResourceCertificateAndAcsDetails extends ResourceCertificateDetails {
  /**
   * ACS namespace name - tenant for our service.
   */
  globalAcsNamespace: string;

  /**
   * Acs mgmt host name to connect to.
   */
  globalAcsHostName: string;

  /**
   * Global ACS namespace RP realm.
   */
  globalAcsRPRealm: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  authType: "AccessControlService";
}

/**
 * Operation Resource
 */
model OperationResource {
  /**
   * End time of the operation
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Required if status == failed or status == canceled. This is the OData v4 error format, used by the RPC and will go into the v2.2 Azure REST API guidelines.
   */
  error?: Error;

  /**
   * It should match what is used to GET the operation result
   */
  id?: string;

  /**
   * It must match the last segment of the "id" field, and will typically be a GUID / system generated value
   */
  name?: string;

  /**
   * The status of the operation. (InProgress/Success/Failed/Cancelled)
   */
  status?: string;

  /**
   * Start time of the operation
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}
