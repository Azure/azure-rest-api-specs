import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Azure.ResourceManager.RecoveryServices;

interface Operations extends Azure.ResourceManager.Operations {}

enum AuthType {
  Invalid,
  ACS,
  AAD,
  AccessControlService,
  AzureActiveDirectory,
}

enum VaultSubResourceType {
  AzureBackup,
  AzureBackup_secondary,
  AzureSiteRecovery,
}

enum ResourceIdentityType {
  SystemAssigned,
  None,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

enum VaultUpgradeState {
  Unknown,
  InProgress,
  Upgraded,
  Failed,
}

enum TriggerType {
  UserTriggered,
  ForcedUpgrade,
}

enum ProvisioningState {
  Succeeded,
  Deleting,
  Failed,
  Pending,
}

enum PrivateEndpointConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

enum VaultPrivateEndpointState {
  None,
  Enabled,
}

enum InfrastructureEncryptionState {
  Enabled,
  Disabled,
}

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

enum BackupStorageVersion {
  V1,
  V2,
  Unassigned,
}

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

enum StandardTierStorageRedundancy {
  LocallyRedundant,
  GeoRedundant,
  ZoneRedundant,
}

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

enum MultiUserAuthorization {
  Invalid,
  Enabled,
  Disabled,
}

enum SecureScoreLevel {
  None,
  Minimum,
  Adequate,
  Maximum,
}

enum SkuName {
  Standard,
  RS0,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum UsagesUnit {
  Count,
  Bytes,
  Seconds,
  Percent,
  CountPerSecond,
  BytesPerSecond,
}

@doc("Details of the certificate to be uploaded to the vault.")
model CertificateRequest {
  @doc("Raw certificate data.")
  properties?: RawCertificateData;
}

@doc("Raw certificate data.")
model RawCertificateData {
  @doc("Specifies the authentication type.")
  authType?: AuthType;

  @doc("The base64 encoded certificate raw data string")
  certificate?: bytes;
}

@doc("Certificate corresponding to a vault that can be used by clients to register themselves with the vault.")
model VaultCertificateResponse {
  @doc("Resource name associated with the resource.")
  @visibility("read")
  name?: string;

  @doc("Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...")
  @visibility("read")
  type?: string;

  @doc("Resource Id represents the complete path to the resource.")
  @visibility("read")
  id?: string;

  @doc("Certificate details representing the Vault credentials.")
  properties?: ResourceCertificateDetails;
}

@doc("Certificate details representing the Vault credentials.")
@discriminator("authType")
model ResourceCertificateDetails {
  @doc("The base64 encoded certificate raw data string.")
  certificate?: bytes;

  @doc("Certificate friendly name.")
  friendlyName?: string;

  @doc("Certificate issuer.")
  issuer?: string;

  @doc("Resource ID of the vault.")
  resourceId?: int32;

  @doc("Certificate Subject Name.")
  subject?: string;

  @doc("Certificate thumbprint.")
  thumbprint?: string;

  @doc("Certificate Validity start Date time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validFrom?: utcDateTime;

  @doc("Certificate Validity End Date time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validTo?: utcDateTime;
}

@doc("Replication usages for vault.")
@pagedResult
model ReplicationUsageList {
  @doc("The list of replication usages for the given vault.")
  @items
  value?: ReplicationUsage[];
}

@doc("Replication usages of a vault.")
model ReplicationUsage {
  @doc("Summary of the replication monitoring data for this vault.")
  monitoringSummary?: MonitoringSummary;

  @doc("Summary of the replication jobs data for this vault.")
  jobsSummary?: JobsSummary;

  @doc("Number of replication protected items for this vault.")
  protectedItemCount?: int32;

  @doc("Number of replication recovery plans for this vault.")
  recoveryPlanCount?: int32;

  @doc("Number of servers registered to this vault.")
  registeredServersCount?: int32;

  @doc("The authentication type of recovery service providers in the vault.")
  recoveryServicesProviderAuthType?: int32;
}

@doc("Summary of the replication monitoring data for this vault.")
model MonitoringSummary {
  @doc("Count of unhealthy VMs.")
  unHealthyVmCount?: int32;

  @doc("Count of unhealthy replication providers.")
  unHealthyProviderCount?: int32;

  @doc("Count of all critical warnings.")
  eventsCount?: int32;

  @doc("Count of all deprecated recovery service providers.")
  deprecatedProviderCount?: int32;

  @doc("Count of all the supported recovery service providers.")
  supportedProviderCount?: int32;

  @doc("Count of all the unsupported recovery service providers.")
  unsupportedProviderCount?: int32;
}

@doc("Summary of the replication job data for this vault.")
model JobsSummary {
  @doc("Count of failed jobs.")
  failedJobs?: int32;

  @doc("Count of suspended jobs.")
  suspendedJobs?: int32;

  @doc("Count of in-progress jobs.")
  inProgressJobs?: int32;
}

@doc("Properties of the private link resource.")
model PrivateLinkResourceProperties {
  @doc("e.g. f9ad6492-33d4-4690-9999-6bfd52a0d081 (Backup) or f9ad6492-33d4-4690-9999-6bfd52a0d082 (SiteRecovery)")
  @visibility("read")
  groupId?: string;

  @doc("[backup-ecs1, backup-prot1, backup-prot1b, backup-prot1c, backup-id1]")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  @visibility("read")
  requiredZoneNames?: string[];
}

@doc("An error response from Azure Backup.")
@error
model CloudError {
  @doc("The resource management error response.")
  error?: Error;
}

@doc("The resource management error response.")
model Error {
  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];

  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error details.")
  @visibility("read")
  details?: Error[];

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;
}

@doc("Resource Name availability input parameters - Resource type and resource name")
model CheckNameAvailabilityParameters {
  @doc("Describes the Resource type: Microsoft.RecoveryServices/Vaults")
  type?: string;

  @doc("Resource name for which availability needs to be checked")
  name?: string;
}

@doc("Response for check name availability API. Resource provider will set availability as true | false.")
model CheckNameAvailabilityResult {
  nameAvailable?: boolean;
  reason?: string;
  message?: string;
}

@doc("Input to get capabilities information for Microsoft.RecoveryServices")
model ResourceCapabilities {
  ...ResourceCapabilitiesBase;

  @doc("Capabilities information")
  properties?: CapabilitiesProperties;
}

@doc("Capabilities information")
model CapabilitiesProperties {
  dnsZones?: DNSZone[];
}

@doc("DNSZone information")
model DNSZone {
  @doc("Subresource type for vault AzureBackup, AzureBackup_secondary or AzureSiteRecovery")
  subResource?: VaultSubResourceType;
}

@doc("Base class for request and response capabilities information for Microsoft.RecoveryServices")
model ResourceCapabilitiesBase {
  @doc("Describes the Resource type: Microsoft.RecoveryServices/Vaults")
  type: string;
}

@doc("Capabilities response for Microsoft.RecoveryServices")
model CapabilitiesResponse {
  ...ResourceCapabilitiesBase;

  @doc("Capabilities properties in response")
  properties?: CapabilitiesResponseProperties;
}

@doc("Capabilities properties in response")
model CapabilitiesResponseProperties {
  dnsZones?: DNSZoneResponse[];
}

@doc("DNSZone information for Microsoft.RecoveryServices")
model DNSZoneResponse {
  ...DNSZone;

  @doc("The private link resource Private link DNS zone names.")
  requiredZoneNames?: string[];
}

@doc("Identity for the resource.")
model IdentityData {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.")
  type: ResourceIdentityType;

  @doc("The list of user-assigned identities associated with the resource. The user-assigned identity dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentities?: Record<UserIdentity>;
}

@doc("A resource identity that is managed by the user of the service.")
model UserIdentity {
  @doc("The principal ID of the user-assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the user-assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Properties of the vault.")
model VaultProperties {
  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: string;

  @doc("Details for upgrading vault.")
  upgradeDetails?: UpgradeDetails;

  @doc("List of private endpoint connection.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionVaultProperties[];

  @doc("Private endpoint state for backup.")
  @visibility("read")
  privateEndpointStateForBackup?: VaultPrivateEndpointState;

  @doc("Private endpoint state for site recovery.")
  @visibility("read")
  privateEndpointStateForSiteRecovery?: VaultPrivateEndpointState;

  @doc("Customer Managed Key details of the resource.")
  encryption?: VaultPropertiesEncryption;

  @doc("The details of the latest move operation performed on the Azure Resource")
  moveDetails?: VaultPropertiesMoveDetails;

  @doc("The State of the Resource after the move operation")
  @visibility("read")
  moveState?: ResourceMoveState;

  @doc("Backup storage version")
  @visibility("read")
  backupStorageVersion?: BackupStorageVersion;

  @doc("property to enable or disable resource provider inbound network traffic from public clients")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Monitoring Settings of the vault")
  monitoringSettings?: MonitoringSettings;

  @doc("Restore Settings of the vault")
  restoreSettings?: RestoreSettings;

  @doc("The redundancy Settings of a Vault")
  redundancySettings?: VaultPropertiesRedundancySettings;

  @doc("Security Settings of the vault")
  securitySettings?: SecuritySettings;

  @doc("Secure Score of Recovery Services Vault")
  @visibility("read")
  secureScore?: SecureScoreLevel;
}

@doc("Details for upgrading vault.")
model UpgradeDetails {
  @doc("ID of the vault upgrade operation.")
  @visibility("read")
  operationId?: string;

  @doc("UTC time at which the upgrade operation has started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  @doc("UTC time at which the upgrade operation status was last updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimeUtc?: utcDateTime;

  @doc("UTC time at which the upgrade operation has ended.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  @doc("Status of the vault upgrade operation.")
  @visibility("read")
  status?: VaultUpgradeState;

  @doc("Message to the user containing information about the upgrade operation.")
  @visibility("read")
  message?: string;

  @doc("The way the vault upgrade was triggered.")
  @visibility("read")
  triggerType?: TriggerType;

  @doc("Resource ID of the upgraded vault.")
  @visibility("read")
  upgradedResourceId?: string;

  @doc("Resource ID of the vault before the upgrade.")
  @visibility("read")
  previousResourceId?: string;
}

@doc("Information to be stored in Vault properties as an element of privateEndpointConnections List.")
model PrivateEndpointConnectionVaultProperties {
  @doc("Format of id subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.[Service]/{resource}/{resourceName}/privateEndpointConnections/{connectionName}.")
  @visibility("read")
  id?: string;

  @doc("Private Endpoint Connection Response Properties.")
  @visibility("read")
  properties?: PrivateEndpointConnection;

  @doc("The name of the private Endpoint Connection")
  @visibility("read")
  name?: string;

  @doc("The type, which will be of the format, Microsoft.RecoveryServices/vaults/privateEndpointConnections")
  @visibility("read")
  type?: string;

  @doc("The location of the private Endpoint connection")
  @visibility("read")
  location?: string;
}

@doc("Private Endpoint Connection Response Properties.")
model PrivateEndpointConnection {
  @doc("Gets or sets provisioning state of the private endpoint connection.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The Private Endpoint network resource that is linked to the Private Endpoint connection.")
  @visibility("read")
  privateEndpoint?: PrivateEndpoint;

  @doc("Gets or sets private link service connection state.")
  @visibility("read")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  @doc("Group Ids for the Private Endpoint")
  groupIds?: VaultSubResourceType[];
}

@doc("The Private Endpoint network resource that is linked to the Private Endpoint connection.")
model PrivateEndpoint {
  @doc("Gets or sets id.")
  @visibility("read")
  id?: string;
}

@doc("Gets or sets private link service connection state.")
model PrivateLinkServiceConnectionState {
  @doc("Gets or sets the status.")
  @visibility("read")
  status?: PrivateEndpointConnectionStatus;

  @doc("Gets or sets description.")
  @visibility("read")
  description?: string;

  @doc("Gets or sets actions required.")
  @visibility("read")
  actionsRequired?: string;
}

@doc("Customer Managed Key details of the resource.")
model VaultPropertiesEncryption {
  @doc("The properties of the Key Vault which hosts CMK")
  keyVaultProperties?: CmkKeyVaultProperties;

  @doc("The details of the identity used for CMK")
  kekIdentity?: CmkKekIdentity;

  @doc("Enabling/Disabling the Double Encryption state")
  infrastructureEncryption?: InfrastructureEncryptionState;
}

@doc("The properties of the Key Vault which hosts CMK")
model CmkKeyVaultProperties {
  @doc("The key uri of the Customer Managed Key")
  keyUri?: string;
}

@doc("The details of the identity used for CMK")
model CmkKekIdentity {
  @doc("Indicate that system assigned identity should be used. Mutually exclusive with 'userAssignedIdentity' field")
  useSystemAssignedIdentity?: boolean;

  @doc("The user assigned identity to be used to grant permissions in case the type of identity used is UserAssigned")
  userAssignedIdentity?: string;
}

@doc("The details of the latest move operation performed on the Azure Resource")
model VaultPropertiesMoveDetails {
  @doc("OperationId of the Resource Move Operation")
  @visibility("read")
  operationId?: string;

  @doc("Start Time of the Resource Move Operation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  @doc("End Time of the Resource Move Operation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completionTimeUtc?: utcDateTime;

  @doc("Source Resource of the Resource Move Operation")
  @visibility("read")
  sourceResourceId?: string;

  @doc("Target Resource of the Resource Move Operation")
  @visibility("read")
  targetResourceId?: string;
}

@doc("Monitoring Settings of the vault")
model MonitoringSettings {
  @doc("Settings for Azure Monitor based alerts")
  azureMonitorAlertSettings?: AzureMonitorAlertSettings;

  @doc("Settings for classic alerts")
  classicAlertSettings?: ClassicAlertSettings;
}

@doc("Settings for Azure Monitor based alerts")
model AzureMonitorAlertSettings {
  alertsForAllJobFailures?: AlertsState;
}

@doc("Settings for classic alerts")
model ClassicAlertSettings {
  alertsForCriticalOperations?: AlertsState;
}

@doc("Restore Settings  of the vault")
model RestoreSettings {
  @doc("Settings for CrossSubscriptionRestore")
  crossSubscriptionRestoreSettings?: CrossSubscriptionRestoreSettings;
}

@doc("Settings for Cross Subscription Restore Settings")
model CrossSubscriptionRestoreSettings {
  crossSubscriptionRestoreState?: CrossSubscriptionRestoreState;
}

@doc("The redundancy Settings of a Vault")
model VaultPropertiesRedundancySettings {
  @doc("The storage redundancy setting of a vault")
  @visibility("read")
  standardTierStorageRedundancy?: StandardTierStorageRedundancy;

  @doc("Flag to show if Cross Region Restore is enabled on the Vault or not")
  @visibility("read")
  crossRegionRestore?: CrossRegionRestore;
}

@doc("Security Settings of the vault")
model SecuritySettings {
  @doc("Immutability Settings of a vault")
  immutabilitySettings?: ImmutabilitySettings;

  @doc("Soft delete Settings of a vault")
  softDeleteSettings?: SoftDeleteSettings;

  @doc("MUA Settings of a vault")
  @visibility("read")
  multiUserAuthorization?: MultiUserAuthorization;
}

@doc("Immutability Settings of vault")
model ImmutabilitySettings {
  state?: ImmutabilityState;
}

@doc("Soft delete Settings of vault")
model SoftDeleteSettings {
  softDeleteState?: SoftDeleteState;

  @doc("Soft delete retention period in days")
  softDeleteRetentionPeriodInDays?: int32;
}

@doc("Identifies the unique system identifier for each Azure resource.")
model Sku {
  @doc("Name of SKU is RS0 (Recovery Services 0th version) and the tier is standard tier. They do not have affect on backend storage redundancy or any other vault settings. To manage storage redundancy, use the backupstorageconfig")
  name: SkuName;

  @doc("The Sku tier.")
  tier?: string;

  @doc("The sku family")
  family?: string;

  @doc("The sku size")
  size?: string;

  @doc("The sku capacity")
  capacity?: string;
}

@doc("Operations List response which contains list of available APIs.")
model ClientDiscoveryResponse
  is Azure.Core.Page<ClientDiscoveryValueForSingleApi>;

@doc("Available operation details.")
model ClientDiscoveryValueForSingleApi {
  @doc("Name of the Operation.")
  name?: string;

  @doc("Contains the localized display information for this particular operation")
  display?: ClientDiscoveryDisplay;

  @doc("The intended executor of the operation;governs the display of the operation in the RBAC UX and the audit logs UX")
  origin?: string;

  @doc("ShoeBox properties for the given operation.")
  properties?: ClientDiscoveryForProperties;
}

@doc("Localized display information of an operation.")
model ClientDiscoveryDisplay {
  @doc("Name of the provider for display purposes")
  provider?: string;

  @doc("ResourceType for which this Operation can be performed.")
  resource?: string;

  @doc("Operations Name itself.")
  operation?: string;

  @doc("Description of the operation having details of what operation is about.")
  description?: string;
}

@doc("Class to represent shoebox properties in json client discovery.")
model ClientDiscoveryForProperties {
  @doc("Operation properties.")
  serviceSpecification?: ClientDiscoveryForServiceSpecification;
}

@doc("Class to represent shoebox service specification in json client discovery.")
model ClientDiscoveryForServiceSpecification {
  @doc("List of log specifications of this operation.")
  logSpecifications?: ClientDiscoveryForLogSpecification[];
}

@doc("Class to represent shoebox log specification in json client discovery.")
model ClientDiscoveryForLogSpecification {
  @doc("Name of the log.")
  name?: string;

  @doc("Localized display name")
  displayName?: string;

  @doc("Blobs created in customer storage account per hour")
  blobDuration?: string;
}

@doc("Tracked resource with location.")
model PatchTrackedResource {
  ...Resource;

  @doc("Resource location.")
  location?: string;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Vault extended information.")
model VaultExtendedInfoProperties {
  @doc("Integrity key.")
  integrityKey?: string;

  @doc("Encryption key.")
  encryptionKey?: string;

  @doc("Encryption key thumbprint.")
  encryptionKeyThumbprint?: string;

  @doc("Algorithm for Vault ExtendedInfo")
  algorithm?: string;
}

@doc("Usage for vault.")
@pagedResult
model VaultUsageList {
  @doc("The list of usages for the given vault.")
  @items
  value?: VaultUsage[];
}

@doc("Usages of a vault.")
model VaultUsage {
  @doc("Unit of the usage.")
  unit?: UsagesUnit;

  @doc("Quota period of usage.")
  quotaPeriod?: string;

  @doc("Next reset time of usage.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  @doc("Current value of usage.")
  currentValue?: int32;

  @doc("Limit of usage.")
  limit?: int32;

  @doc("Name of usage.")
  name?: NameInfo;
}

@doc("The name of usage.")
model NameInfo {
  @doc("Value of usage.")
  value?: string;

  @doc("Localized value of usage.")
  localizedValue?: string;
}

@doc("Certificate details representing the Vault credentials for AAD.")
model ResourceCertificateAndAadDetails extends ResourceCertificateDetails {
  @doc("AAD tenant authority.")
  aadAuthority: string;

  @doc("AAD tenant Id.")
  aadTenantId: string;

  @doc("AAD service principal clientId.")
  servicePrincipalClientId: string;

  @doc("AAD service principal ObjectId.")
  servicePrincipalObjectId: string;

  @doc("Azure Management Endpoint Audience.")
  azureManagementEndpointAudience: string;

  @doc("Service Resource Id.")
  serviceResourceId?: string;

  @doc("AAD audience for the resource")
  aadAudience?: string;

  @doc("This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.")
  authType: "AzureActiveDirectory";
}

@doc("Certificate details representing the Vault credentials for ACS.")
model ResourceCertificateAndAcsDetails extends ResourceCertificateDetails {
  @doc("ACS namespace name - tenant for our service.")
  globalAcsNamespace: string;

  @doc("Acs mgmt host name to connect to.")
  globalAcsHostName: string;

  @doc("Global ACS namespace RP realm.")
  globalAcsRPRealm: string;

  @doc("This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.")
  authType: "AccessControlService";
}

@doc("Operation Resource")
model OperationResource {
  @doc("End time of the operation")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Required if status == failed or status == canceled. This is the OData v4 error format, used by the RPC and will go into the v2.2 Azure REST API guidelines.")
  error?: Error;

  @doc("It should match what is used to GET the operation result")
  id?: string;

  @doc("It must match the last segment of the \"id\" field, and will typically be a GUID / system generated value")
  name?: string;

  @doc("The status of the operation. (InProgress/Success/Failed/Cancelled)")
  status?: string;

  @doc("Start time of the operation")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}
