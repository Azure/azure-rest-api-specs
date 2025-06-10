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

/**
 * Specifies the authentication type.
 */
union AuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ACS: "ACS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AAD: "AAD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AccessControlService: "AccessControlService",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureActiveDirectory: "AzureActiveDirectory",
}

/**
 * Subresource type for vault AzureBackup, AzureBackup_secondary or AzureSiteRecovery
 */
union VaultSubResourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBackup: "AzureBackup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBackup_secondary: "AzureBackup_secondary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSiteRecovery: "AzureSiteRecovery",
}

/**
 * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.
 */
union ResourceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
}

/**
 * Status of the vault upgrade operation.
 */
union VaultUpgradeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Upgraded: "Upgraded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * The way the vault upgrade was triggered.
 */
union TriggerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserTriggered: "UserTriggered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ForcedUpgrade: "ForcedUpgrade",
}

/**
 * Gets or sets provisioning state of the private endpoint connection.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
}

/**
 * Gets or sets the status.
 */
union PrivateEndpointConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * Private endpoint state for backup.
 */
union VaultPrivateEndpointState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * Enabling/Disabling the Double Encryption state
 */
union InfrastructureEncryptionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The State of the Resource after the move operation
 */
union ResourceMoveState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrepareFailed: "PrepareFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CommitFailed: "CommitFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrepareTimedout: "PrepareTimedout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CommitTimedout: "CommitTimedout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MoveSucceeded: "MoveSucceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failure: "Failure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CriticalFailure: "CriticalFailure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PartialSuccess: "PartialSuccess",
}

/**
 * Backup storage version
 */
union BackupStorageVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  V2: "V2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unassigned: "Unassigned",
}

/**
 * property to enable or disable resource provider inbound network traffic from public clients
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AlertsState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union CrossSubscriptionRestoreState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PermanentlyDisabled: "PermanentlyDisabled",
}

/**
 * The storage redundancy setting of a vault
 */
union StandardTierStorageRedundancy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocallyRedundant: "LocallyRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeoRedundant: "GeoRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ZoneRedundant: "ZoneRedundant",
}

/**
 * Flag to show if Cross Region Restore is enabled on the Vault or not
 */
union CrossRegionRestore {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ImmutabilityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unlocked: "Unlocked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Locked: "Locked",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SoftDeleteState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlwaysON: "AlwaysON",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union EnhancedSecurityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlwaysON: "AlwaysON",
}

/**
 * MUA Settings of vault
 */
union MultiUserAuthorization {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Identity type that should be used for an operation.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
}

/**
 * Secure Score of Recovery Services Vault
 */
union SecureScoreLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Minimum: "Minimum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Adequate: "Adequate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Maximum: "Maximum",
}

/**
 * Security levels of Recovery Services Vault for business continuity and disaster recovery
 */
union BCDRSecurityLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Poor: "Poor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Fair: "Fair",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Good: "Good",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Excellent: "Excellent",
}

/**
 * Name of SKU is RS0 (Recovery Services 0th version) and the tier is standard tier. They do not have affect on backend storage redundancy or any other vault settings. To manage storage redundancy, use the backupstorageconfig
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RS0: "RS0",
}

/**
 * Unit of the usage.
 */
union UsagesUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Bytes: "Bytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Seconds: "Seconds",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Percent: "Percent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CountPerSecond: "CountPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BytesPerSecond: "BytesPerSecond",
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
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource Id represents the complete path to the resource.
   */
  @visibility(Lifecycle.Read)
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
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authType: string;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @items
  value?: ReplicationUsage[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
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
 * Class which represent the stamps associated with the vault.
 */
model PrivateLinkResources is Azure.Core.Page<PrivateLinkResource>;

/**
 * Properties of the private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResourceProperties {
  /**
   * e.g. f9ad6492-33d4-4690-9999-6bfd52a0d081 (Backup) or f9ad6492-33d4-4690-9999-6bfd52a0d082 (SiteRecovery)
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * [backup-ecs1, backup-prot1, backup-prot1b, backup-prot1c, backup-id1]
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  details?: Error[];

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nameAvailable?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reason?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message?: string;
}

/**
 * Input to get capabilities information for Microsoft.RecoveryServices
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  dnsZones?: DNSZone[];
}

/**
 * DNSZone information
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  dnsZones?: DNSZoneResponse[];
}

/**
 * DNSZone information for Microsoft.RecoveryServices
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DNSZoneResponse extends DNSZone {
  /**
   * The private link resource Private link DNS zone names.
   */
  requiredZoneNames?: string[];
}

/**
 * The response model for a list of Vaults.
 */
model VaultList is Azure.Core.Page<Vault>;

/**
 * Identity for the resource.
 */
model IdentityData {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.
   */
  type: ResourceIdentityType;

  /**
   * The list of user-assigned identities associated with the resource. The user-assigned identity dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentity>;
}

/**
 * A resource identity that is managed by the user of the service.
 */
model UserIdentity {
  /**
   * The principal ID of the user-assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of the user-assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Properties of the vault.
 */
model VaultProperties {
  /**
   * Provisioning State.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Details for upgrading vault.
   */
  upgradeDetails?: UpgradeDetails;

  /**
   * List of private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionVaultProperties[];

  /**
   * Private endpoint state for backup.
   */
  @visibility(Lifecycle.Read)
  privateEndpointStateForBackup?: VaultPrivateEndpointState;

  /**
   * Private endpoint state for site recovery.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  moveState?: ResourceMoveState;

  /**
   * Backup storage version
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  secureScore?: SecureScoreLevel;

  /**
   * Security levels of Recovery Services Vault for business continuity and disaster recovery
   */
  @visibility(Lifecycle.Read)
  bcdrSecurityLevel?: BCDRSecurityLevel;

  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];
}

/**
 * Details for upgrading vault.
 */
model UpgradeDetails {
  /**
   * ID of the vault upgrade operation.
   */
  @visibility(Lifecycle.Read)
  operationId?: string;

  /**
   * UTC time at which the upgrade operation has started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * UTC time at which the upgrade operation status was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimeUtc?: utcDateTime;

  /**
   * UTC time at which the upgrade operation has ended.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Status of the vault upgrade operation.
   */
  @visibility(Lifecycle.Read)
  status?: VaultUpgradeState;

  /**
   * Message to the user containing information about the upgrade operation.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The way the vault upgrade was triggered.
   */
  @visibility(Lifecycle.Read)
  triggerType?: TriggerType;

  /**
   * Resource ID of the upgraded vault.
   */
  @visibility(Lifecycle.Read)
  upgradedResourceId?: string;

  /**
   * Resource ID of the vault before the upgrade.
   */
  @visibility(Lifecycle.Read)
  previousResourceId?: string;
}

/**
 * Information to be stored in Vault properties as an element of privateEndpointConnections List.
 */
model PrivateEndpointConnectionVaultProperties {
  /**
   * Format of id subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.[Service]/{resource}/{resourceName}/privateEndpointConnections/{connectionName}.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Private Endpoint Connection Response Properties.
   */
  @visibility(Lifecycle.Read)
  properties?: PrivateEndpointConnection;

  /**
   * The name of the private Endpoint Connection
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type, which will be of the format, Microsoft.RecoveryServices/vaults/privateEndpointConnections
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the private Endpoint connection
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * Private Endpoint Connection Response Properties.
 */
model PrivateEndpointConnection {
  /**
   * Gets or sets provisioning state of the private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The Private Endpoint network resource that is linked to the Private Endpoint connection.
   */
  @visibility(Lifecycle.Read)
  privateEndpoint?: PrivateEndpoint;

  /**
   * Gets or sets private link service connection state.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Gets or sets private link service connection state.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Gets or sets the status.
   */
  @visibility(Lifecycle.Read)
  status?: PrivateEndpointConnectionStatus;

  /**
   * Gets or sets description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Gets or sets actions required.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  operationId?: string;

  /**
   * Start Time of the Resource Move Operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * End Time of the Resource Move Operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completionTimeUtc?: utcDateTime;

  /**
   * Source Resource of the Resource Move Operation
   */
  @visibility(Lifecycle.Read)
  sourceResourceId?: string;

  /**
   * Target Resource of the Resource Move Operation
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alertsForAllJobFailures?: AlertsState;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alertsForAllReplicationIssues?: AlertsState;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alertsForAllFailoverIssues?: AlertsState;
}

/**
 * Settings for classic alerts
 */
model ClassicAlertSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alertsForCriticalOperations?: AlertsState;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  emailNotificationsForSiteRecovery?: AlertsState;
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  crossSubscriptionRestoreState?: CrossSubscriptionRestoreState;
}

/**
 * The redundancy Settings of a Vault
 */
model VaultPropertiesRedundancySettings {
  /**
   * The storage redundancy setting of a vault
   */
  standardTierStorageRedundancy?: StandardTierStorageRedundancy;

  /**
   * Flag to show if Cross Region Restore is enabled on the Vault or not
   */
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
  @visibility(Lifecycle.Read)
  multiUserAuthorization?: MultiUserAuthorization;

  /**
   * Source scan configuration of vault
   */
  sourceScanConfiguration?: SourceScanConfiguration;
}

/**
 * Immutability Settings of vault
 */
model ImmutabilitySettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  state?: ImmutabilityState;
}

/**
 * Soft delete Settings of vault
 */
model SoftDeleteSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  softDeleteState?: SoftDeleteState;

  /**
   * Soft delete retention period in days
   */
  softDeleteRetentionPeriodInDays?: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enhancedSecurityState?: EnhancedSecurityState;
}

/**
 * Source scan configuration of vault
 */
model SourceScanConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  state?: State;

  /**
   * Identity details to be used for an operation
   */
  sourceScanIdentity?: AssociatedIdentity;
}

/**
 * Identity details to be used for an operation
 */
model AssociatedIdentity {
  /**
   * Identity type that should be used for an operation.
   */
  operationIdentityType?: IdentityType;

  /**
   * User assigned identity to be used for an operation if operationIdentityType is UserAssigned.
   */
  userAssignedIdentity?: string;
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PatchTrackedResource extends Azure.ResourceManager.Foundations.Resource {
  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Optional ETag.
   */
  etag?: string;
}

/**
 * Vault extended information.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VaultExtendedInfo {
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  globalAcsRPRealm: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  authType: "AccessControlService";
}

model ClientDiscoveryResponse
  is Azure.Core.Page<ClientDiscoveryValueForSingleApi>;

@@doc(VaultPropertiesEncryption.infrastructureEncryption,
  "Enabling/Disabling the Double Encryption state"
);
@@doc(VaultPropertiesMoveDetails.operationId,
  "OperationId of the Resource Move Operation"
);
@@doc(VaultPropertiesMoveDetails.startTimeUtc,
  "Start Time of the Resource Move Operation"
);
@@doc(VaultPropertiesMoveDetails.completionTimeUtc,
  "End Time of the Resource Move Operation"
);
@@doc(VaultPropertiesMoveDetails.sourceResourceId,
  "Source Resource of the Resource Move Operation"
);
@@doc(VaultPropertiesMoveDetails.targetResourceId,
  "Target Resource of the Resource Move Operation"
);
@@doc(VaultPropertiesRedundancySettings.standardTierStorageRedundancy,
  "The storage redundancy setting of a vault"
);
@@doc(VaultPropertiesRedundancySettings.crossRegionRestore,
  "Flag to show if Cross Region Restore is enabled on the Vault or not"
);
