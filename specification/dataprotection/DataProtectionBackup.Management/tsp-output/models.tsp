import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataProtection;

interface Operations extends Azure.ResourceManager.Operations {}

enum AlertsState {
  Enabled,
  Disabled,
}

/**
 * Provisioning state of the BackupVault resource
 */
enum ProvisioningState {
  Failed,
  Provisioning,
  Succeeded,
  Unknown,
  Updating,
}

/**
 * Resource move state for backup vault
 */
enum ResourceMoveState {
  Unknown,
  InProgress,
  PrepareFailed,
  CommitFailed,
  Failed,
  PrepareTimedout,
  CommitTimedout,
  CriticalFailure,
  PartialSuccess,
  MoveSucceeded,
}

/**
 * State of soft delete
 */
enum SoftDeleteState {
  /**
   * Soft Delete is turned off for the BackupVault
   */
  Off,

  /**
   * Soft Delete is enabled for the BackupVault but can be turned off
   */
  On,

  /**
   * Soft Delete is permanently enabled for the BackupVault and the setting cannot be changed
   */
  AlwaysOn,
}

/**
 * Immutability state
 */
enum ImmutabilityState {
  Disabled,
  Unlocked,
  Locked,
}

/**
 * Gets or sets the type of the datastore.
 */
enum StorageSettingStoreTypes {
  ArchiveStore,
  OperationalStore,
  VaultStore,
}

/**
 * Gets or sets the type.
 */
enum StorageSettingTypes {
  GeoRedundant,
  LocallyRedundant,
  ZoneRedundant,
}

/**
 * CrossSubscriptionRestore state
 */
enum CrossSubscriptionRestoreState {
  Disabled,
  PermanentlyDisabled,
  Enabled,
}

/**
 * CrossRegionRestore state
 */
enum CrossRegionRestoreState {
  Disabled,
  Enabled,
}

/**
 * Secure Score of Backup Vault
 */
enum SecureScoreLevel {
  None,
  Minimum,
  Adequate,
  Maximum,
  NotSupported,
}

/**
 * Type of the specific object - used for deserializing
 */
enum ResourcePropertiesObjectType {
  DefaultResourceProperties,
}

/**
 * type of datastore; Operational/Vault/Archive
 */
enum DataStoreTypes {
  OperationalStore,
  VaultStore,
  ArchiveStore,
}

/**
 * Specifies the protection status of the resource
 */
enum Status {
  ConfiguringProtection,
  ConfiguringProtectionFailed,
  ProtectionConfigured,
  ProtectionStopped,
  SoftDeleted,
  SoftDeleting,
}

/**
 * Specifies the current protection state of the resource
 */
enum CurrentProtectionState {
  Invalid,
  NotProtected,
  ConfiguringProtection,
  ProtectionConfigured,
  BackupSchedulesSuspended,
  RetentionSchedulesSuspended,
  ProtectionStopped,
  ProtectionError,
  ConfiguringProtectionFailed,
  SoftDeleting,
  SoftDeleted,
  UpdatingProtection,
}

/**
 * Specifies the type of validation. In case of DeepValidation, all validations from /validateForBackup API will run again.
 */
enum ValidationType {
  ShallowValidation,
  DeepValidation,
}

/**
 * Recovery Option
 */
enum RecoveryOption {
  FailIfExists,
}

/**
 * Gets or sets the type of the source data store.
 */
enum SourceDataStoreType {
  ArchiveStore,
  SnapshotStore,
  OperationalStore,
  VaultStore,
}

/**
 * Priority to be used for rehydration. Values High or Standard
 */
enum RehydrationPriority {
  Invalid,
  High,
  Standard,
}

/**
 * Field indicating sync type e.g. to sync only in case of failure or in all cases
 */
enum SyncType {
  Default,
  ForceResync,
}

/**
 * Gets or sets the type of the source data store.
 */
enum RestoreSourceDataStoreType {
  OperationalStore,
  VaultStore,
  ArchiveStore,
}

enum RehydrationStatus {
  CREATE_IN_PROGRESS,
  COMPLETED,
  DELETE_IN_PROGRESS,
  DELETED,
  FAILED,
}

/**
 * Specifies recovery point completeness. Partial (i.e., only some of the intended items were backed up), or Completed (i.e., ALL intended items were backed up).
 */
enum RecoveryPointCompletionState {
  Completed,
  Partial,
}

/**
 * backup support feature type.
 */
enum FeatureType {
  Invalid,
  DataSourceType,
}

/**
 * feature support status
 */
enum FeatureSupportStatus {
  Invalid,
  NotSupported,
  AlphaPreview,
  PrivatePreview,
  PublicPreview,
  GenerallyAvailable,
}

/**
 * Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored.
 */
enum PersistentVolumeRestoreMode {
  RestoreWithVolumeData,
  RestoreWithoutVolumeData,
}

/**
 * Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore.
 */
enum ExistingResourcePolicy {
  Skip,
  Patch,
}

/**
 * Denotes the target location where the data will be restored,
 * string value for the enum {Microsoft.Internal.AzureBackup.DataProtection.Common.Interface.RestoreTargetLocationType}
 */
enum RestoreTargetLocationType {
  Invalid,
  AzureBlobs,
  AzureFiles,
}

enum AbsoluteMarker {
  AllBackup,
  FirstOfDay,
  FirstOfMonth,
  FirstOfWeek,
  FirstOfYear,
}

enum DayOfWeek {
  Friday,
  Monday,
  Saturday,
  Sunday,
  Thursday,
  Tuesday,
  Wednesday,
}

enum Month {
  April,
  August,
  December,
  February,
  January,
  July,
  June,
  March,
  May,
  November,
  October,
  September,
}

enum WeekNumber {
  First,
  Fourth,
  Last,
  Second,
  Third,
}

/**
 * Gets or sets the type of secret store
 */
enum SecretStoreType {
  Invalid,
  AzureKeyVault,
}

/**
 * Backup Vault
 */
model BackupVault {
  /**
   * Monitoring Settings
   */
  monitoringSettings?: MonitoringSettings;

  /**
   * Provisioning state of the BackupVault resource
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource move state for backup vault
   */
  @visibility("read")
  resourceMoveState?: ResourceMoveState;

  /**
   * Resource move details for backup vault
   */
  @visibility("read")
  resourceMoveDetails?: ResourceMoveDetails;

  /**
   * Security Settings
   */
  securitySettings?: SecuritySettings;

  /**
   * Storage Settings
   */
  storageSettings: StorageSetting[];

  /**
   * Is vault protected by resource guard
   */
  @visibility("read")
  isVaultProtectedByResourceGuard?: boolean;

  /**
   * Feature Settings
   */
  featureSettings?: FeatureSettings;

  /**
   * Secure Score of Backup Vault
   */
  @visibility("read")
  secureScore?: SecureScoreLevel;

  /**
   * List of replicated regions for Backup Vault
   */
  replicatedRegions?: string[];
}

/**
 * Monitoring Settings
 */
model MonitoringSettings {
  /**
   * Settings for Azure Monitor based alerts
   */
  azureMonitorAlertSettings?: AzureMonitorAlertSettings;
}

/**
 * Settings for Azure Monitor based alerts
 */
model AzureMonitorAlertSettings {
  alertsForAllJobFailures?: AlertsState;
}

/**
 * ResourceMoveDetails will be returned in response to GetResource call from ARM
 */
model ResourceMoveDetails {
  /**
   * CorrelationId of latest ResourceMove operation attempted
   */
  operationId?: string;

  /**
   * Start time in UTC of latest ResourceMove operation attempted. ISO 8601 format.
   */
  startTimeUtc?: string;

  /**
   * Completion time in UTC of latest ResourceMove operation attempted. ISO 8601 format.
   */
  completionTimeUtc?: string;

  /**
   * ARM resource path of source resource
   */
  sourceResourcePath?: string;

  /**
   * ARM resource path of target resource used in latest ResourceMove operation
   */
  targetResourcePath?: string;
}

/**
 * Class containing security settings of vault
 */
model SecuritySettings {
  /**
   * Soft delete related settings
   */
  softDeleteSettings?: SoftDeleteSettings;

  /**
   * Immutability Settings at vault level
   */
  immutabilitySettings?: ImmutabilitySettings;
}

/**
 * Soft delete related settings
 */
model SoftDeleteSettings {
  /**
   * State of soft delete
   */
  state?: SoftDeleteState;

  /**
   * Soft delete retention duration
   */
  retentionDurationInDays?: float64;
}

/**
 * Immutability Settings at vault level
 */
model ImmutabilitySettings {
  /**
   * Immutability state
   */
  state?: ImmutabilityState;
}

/**
 * Storage setting
 */
model StorageSetting {
  /**
   * Gets or sets the type of the datastore.
   */
  datastoreType?: StorageSettingStoreTypes;

  /**
   * Gets or sets the type.
   */
  type?: StorageSettingTypes;
}

/**
 * Class containing feature settings of vault
 */
model FeatureSettings {
  /**
   * CrossSubscriptionRestore Settings
   */
  crossSubscriptionRestoreSettings?: CrossSubscriptionRestoreSettings;

  crossRegionRestoreSettings?: CrossRegionRestoreSettings;
}

/**
 * CrossSubscriptionRestore Settings
 */
model CrossSubscriptionRestoreSettings {
  /**
   * CrossSubscriptionRestore state
   */
  state?: CrossSubscriptionRestoreState;
}

model CrossRegionRestoreSettings {
  /**
   * CrossRegionRestore state
   */
  state?: CrossRegionRestoreState;
}

model DppTrackedResource extends DppBaseTrackedResource {
  /**
   * Input Managed Identity Details
   */
  identity?: DppIdentityDetails;
}

/**
 * Identity details
 */
model DppIdentityDetails {
  /**
   * The object ID of the service principal object for the managed identity that is used to grant role-based access to an Azure resource.
   */
  @visibility("read")
  principalId?: string;

  /**
   * A Globally Unique Identifier (GUID) that represents the Azure AD tenant where the resource is now a member.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identityType which can be either SystemAssigned, UserAssigned, 'SystemAssigned,UserAssigned' or None
   */
  type?: string;

  /**
   * Gets or sets the user assigned identities.
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

model DppBaseTrackedResource {
  /**
   * Optional ETag.
   */
  eTag?: string;

  /**
   * Resource Id represents the complete path to the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource name associated with the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...
   */
  @visibility("read")
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
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
 * Patch Request content for Microsoft.DataProtection resources
 */
model PatchResourceRequestInput {
  /**
   * Input Managed Identity Details
   */
  identity?: DppIdentityDetails;

  /**
   * Resource properties.
   */
  properties?: PatchBackupVaultInput;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Backup Vault Contract for Patch Backup Vault API.
 */
model PatchBackupVaultInput {
  /**
   * Monitoring Settings
   */
  monitoringSettings?: MonitoringSettings;

  /**
   * Security Settings
   */
  securitySettings?: SecuritySettings;

  /**
   * Feature Settings
   */
  featureSettings?: FeatureSettings;
}

/**
 * CheckNameAvailability Request
 */
model CheckNameAvailabilityRequest {
  /**
   * Resource name for which availability needs to be checked
   */
  name?: string;

  /**
   * Describes the Resource type: Microsoft.DataProtection/BackupVaults
   */
  type?: string;
}

/**
 * CheckNameAvailability Result
 */
model CheckNameAvailabilityResult {
  /**
   * Gets or sets the message.
   */
  message?: string;

  /**
   * Gets or sets a value indicating whether [name available].
   */
  nameAvailable?: boolean;

  /**
   * Gets or sets the reason.
   */
  reason?: string;
}

/**
 * Base class for Backup Feature support
 */
@discriminator("objectType")
model FeatureValidationRequestBase {}

/**
 * Base class for Backup Feature support
 */
@discriminator("objectType")
model FeatureValidationResponseBase {}

/**
 * BackupPolicy base
 */
@discriminator("objectType")
model BaseBackupPolicy {
  /**
   * Type of datasource for the backup management
   */
  datasourceTypes: string[];
}

/**
 * Resource class
 */
model DppResource {
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
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Backup Instance
 */
model BackupInstance {
  /**
   * Gets or sets the Backup Instance friendly name.
   */
  friendlyName?: string;

  /**
   * Gets or sets the data source information.
   */
  dataSourceInfo: Datasource;

  /**
   * Gets or sets the data source set information.
   */
  dataSourceSetInfo?: DatasourceSet;

  /**
   * Gets or sets the policy information.
   */
  policyInfo: PolicyInfo;

  /**
   * Specifies the protection status of the resource
   */
  @visibility("read")
  protectionStatus?: ProtectionStatusDetails;

  /**
   * Specifies the current protection state of the resource
   */
  @visibility("read")
  currentProtectionState?: CurrentProtectionState;

  /**
   * Specifies the protection error of the resource
   */
  @visibility("read")
  protectionErrorDetails?: UserFacingError;

  /**
   * Specifies the provisioning state of the resource i.e. provisioning/updating/Succeeded/Failed
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Credentials to use to authenticate with data source provider.
   */
  datasourceAuthCredentials?: AuthCredentials;

  /**
   * Specifies the type of validation. In case of DeepValidation, all validations from /validateForBackup API will run again.
   */
  validationType?: ValidationType;

  /**
   * Contains information of the Identity Details for the BI.
   * If it is null, default will be considered as System Assigned.
   */
  identityDetails?: IdentityDetails;

  objectType: string;
}

/**
 * Datasource to be backed up
 */
model Datasource {
  /**
   * DatasourceType of the resource.
   */
  datasourceType?: string;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType?: string;

  /**
   * Full ARM ID of the resource. For azure resources, this is ARM ID. For non azure resources, this will be the ID created by backup service via Fabric/Vault.
   */
  resourceID: string;

  /**
   * Location of datasource.
   */
  resourceLocation?: string;

  /**
   * Unique identifier of the resource in the context of parent.
   */
  resourceName?: string;

  /**
   * Resource Type of Datasource.
   */
  resourceType?: string;

  /**
   * Uri of the resource.
   */
  resourceUri?: string;

  /**
   * Properties specific to data source
   */
  resourceProperties?: BaseResourceProperties;
}

/**
 * Properties which are specific to datasource/datasourceSets
 */
@discriminator("objectType")
model BaseResourceProperties {}

/**
 * DatasourceSet details of datasource to be backed up
 */
model DatasourceSet {
  /**
   * DatasourceType of the resource.
   */
  datasourceType?: string;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType?: string;

  /**
   * Full ARM ID of the resource. For azure resources, this is ARM ID. For non azure resources, this will be the ID created by backup service via Fabric/Vault.
   */
  resourceID: string;

  /**
   * Location of datasource.
   */
  resourceLocation?: string;

  /**
   * Unique identifier of the resource in the context of parent.
   */
  resourceName?: string;

  /**
   * Resource Type of Datasource.
   */
  resourceType?: string;

  /**
   * Uri of the resource.
   */
  resourceUri?: string;

  /**
   * Properties specific to data source set
   */
  resourceProperties?: BaseResourceProperties;
}

/**
 * Policy Info in backupInstance
 */
model PolicyInfo {
  policyId: string;

  @visibility("read")
  policyVersion?: string;

  /**
   * Policy parameters for the backup instance
   */
  policyParameters?: PolicyParameters;
}

/**
 * Parameters in Policy
 */
model PolicyParameters {
  /**
   * Gets or sets the DataStore Parameters
   */
  dataStoreParametersList?: DataStoreParameters[];

  /**
   * Gets or sets the Backup Data Source Parameters
   */
  backupDatasourceParametersList?: BackupDatasourceParameters[];
}

/**
 * Parameters for DataStore
 */
@discriminator("objectType")
model DataStoreParameters {
  /**
   * type of datastore; Operational/Vault/Archive
   */
  dataStoreType: DataStoreTypes;
}

/**
 * Parameters for Backup Datasource
 */
@discriminator("objectType")
model BackupDatasourceParameters {}

/**
 * Protection status details
 */
model ProtectionStatusDetails {
  /**
   * Specifies the protection status error of the resource
   */
  errorDetails?: UserFacingError;

  /**
   * Specifies the protection status of the resource
   */
  status?: Status;
}

/**
 * Error object used by layers that have access to localized content, and propagate that to user
 */
model UserFacingError {
  /**
   * Unique code for this error
   */
  code?: string;

  /**
   * Additional related Errors
   */
  details?: UserFacingError[];

  /**
   * Inner Error
   */
  innerError?: InnerError;

  /**
   * Whether the operation will be retryable or not
   */
  isRetryable?: boolean;

  /**
   * Whether the operation is due to a user error or service error
   */
  isUserError?: boolean;

  /**
   * Any key value pairs that can be injected inside error object
   */
  properties?: Record<string>;

  message?: string;

  /**
   * RecommendedAction � localized.
   */
  recommendedAction?: string[];

  /**
   * Target of the error.
   */
  target?: string;
}

/**
 * Inner Error
 */
model InnerError {
  /**
   * Any Key value pairs that can be provided to the client for additional  verbose information.
   */
  additionalInfo?: Record<string>;

  /**
   * Unique code for this error
   */
  code?: string;

  /**
   * Child Inner Error, to allow Nesting.
   */
  embeddedInnerError?: InnerError;
}

/**
 * Base class for different types of authentication credentials.
 */
@discriminator("objectType")
model AuthCredentials {}

model IdentityDetails {
  /**
   * Specifies if the BI is protected by System Identity.
   */
  useSystemAssignedIdentity?: boolean;

  /**
   * ARM URL for User Assigned Identity.
   */
  userAssignedIdentityArmUrl?: string;
}

model DppProxyResource {
  /**
   * Proxy Resource Id represents the complete path to the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Proxy Resource name associated with the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Proxy Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...
   */
  @visibility("read")
  type?: string;

  /**
   * Proxy Resource tags.
   */
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Trigger backup request
 */
model TriggerBackupRequest {
  /**
   * Name for the Rule of the Policy which needs to be applied for this backup
   */
  backupRuleOptions: AdHocBackupRuleOptions;
}

/**
 * Adhoc backup rules
 */
model AdHocBackupRuleOptions {
  ruleName: string;

  /**
   * Adhoc backup trigger option
   */
  triggerOption: AdhocBackupTriggerOption;
}

/**
 * Adhoc backup trigger option
 */
model AdhocBackupTriggerOption {
  retentionTagOverride?: string;
}

/**
 * Operation Job Extended Info
 */
model OperationJobExtendedInfo extends OperationExtendedInfo {
  /**
   * Name or Arm Id of the job created for this operation.
   */
  jobId?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationJobExtendedInfo";
}

/**
 * Operation Extended Info
 */
@discriminator("objectType")
model OperationExtendedInfo {}

/**
 * Validate for backup request
 */
model ValidateForBackupRequest {
  /**
   * Backup Instance
   */
  backupInstance: BackupInstance;
}

/**
 * Azure backup recoveryPoint
 */
@discriminator("objectType")
model AzureBackupRecoveryPoint {}

/**
 * Information about BI whose secondary RecoveryPoints are requested
 * Source region and
 * BI ARM path
 */
model FetchSecondaryRPsRequestParameters {
  /**
   * Source region in which BackupInstance is located
   */
  sourceRegion?: string;

  /**
   * ARM Path of BackupInstance
   */
  sourceBackupInstanceId?: string;
}

/**
 * Cross Region Restore Request Object
 */
model CrossRegionRestoreRequestObject {
  /**
   * Gets or sets the restore request object.
   */
  restoreRequestObject: AzureBackupRestoreRequest;

  /**
   * Cross region restore details.
   */
  crossRegionRestoreDetails: CrossRegionRestoreDetails;
}

/**
 * Azure backup restore request
 */
@discriminator("objectType")
model AzureBackupRestoreRequest {
  /**
   * Gets or sets the restore target information.
   */
  restoreTargetInfo: RestoreTargetInfoBase;

  /**
   * Gets or sets the type of the source data store.
   */
  sourceDataStoreType: SourceDataStoreType;

  /**
   * Fully qualified Azure Resource Manager ID of the datasource which is being recovered.
   */
  sourceResourceId?: string;

  /**
   * Contains information of the Identity Details for the BI.
   * If it is null, default will be considered as System Assigned.
   */
  identityDetails?: IdentityDetails;
}

/**
 * Base class common to RestoreTargetInfo and RestoreFilesTargetInfo
 */
@discriminator("objectType")
model RestoreTargetInfoBase {
  /**
   * Recovery Option
   */
  recoveryOption: RecoveryOption;

  /**
   * Target Restore region
   */
  restoreLocation?: string;
}

/**
 * Cross Region Restore details
 */
model CrossRegionRestoreDetails {
  sourceRegion: string;
  sourceBackupInstanceId: string;
}

/**
 * Cross Region Restore Request Object
 */
model ValidateCrossRegionRestoreRequestObject {
  /**
   * Gets or sets the restore request object.
   */
  restoreRequestObject: AzureBackupRestoreRequest;

  /**
   * Cross region restore details.
   */
  crossRegionRestoreDetails: CrossRegionRestoreDetails;
}

/**
 * Details of CRR Job to be fetched
 */
model CrossRegionRestoreJobRequest {
  sourceRegion: string;
  sourceBackupVaultId: string;
  jobId: string;
}

/**
 * AzureBackup Job Class
 */
model AzureBackupJob {
  /**
   * Job Activity Id
   */
  activityID: string;

  /**
   * Name of the Backup Instance
   */
  backupInstanceFriendlyName: string;

  /**
   * ARM ID of the Backup Instance
   */
  @visibility("read")
  backupInstanceId?: string;

  /**
   * ARM ID of the DataSource
   */
  dataSourceId: string;

  /**
   * Location of the DataSource
   */
  dataSourceLocation: string;

  /**
   * User Friendly Name of the DataSource
   */
  dataSourceName: string;

  /**
   * Data Source Set Name of the DataSource
   */
  dataSourceSetName?: string;

  /**
   * Type of DataSource
   */
  dataSourceType: string;

  /**
   * Total run time of the job. ISO 8601 format.
   */
  duration?: string;

  /**
   * EndTime of the job(in UTC)
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * A List, detailing the errors related to the job
   */
  @visibility("read")
  errorDetails?: UserFacingError[];

  /**
   * Extended Information about the job
   */
  @visibility("read")
  extendedInfo?: JobExtendedInfo;

  /**
   * Indicated that whether the job is adhoc(true) or scheduled(false)
   */
  isUserTriggered: boolean;

  /**
   * It indicates the type of Job i.e. Backup:full/log/diff ;Restore:ALR/OLR; Tiering:Backup/Archive ; Management:ConfigureProtection/UnConfigure
   */
  operation: string;

  /**
   * It indicates the type of Job i.e. Backup/Restore/Tiering/Management
   */
  operationCategory: string;

  /**
   * ARM ID of the policy
   */
  @visibility("read")
  policyId?: string;

  /**
   * Name of the policy
   */
  @visibility("read")
  policyName?: string;

  /**
   * Indicated whether progress is enabled for the job
   */
  progressEnabled: boolean;

  /**
   * Url which contains job's progress
   */
  @visibility("read")
  progressUrl?: string;

  /**
   * Priority to be used for rehydration
   */
  @visibility("read")
  rehydrationPriority?: string;

  /**
   * It indicates the sub type of operation i.e. in case of Restore it can be ALR/OLR
   */
  @visibility("read")
  restoreType?: string;

  /**
   * Resource Group Name of the Datasource
   */
  sourceResourceGroup: string;

  /**
   * SubscriptionId corresponding to the DataSource
   */
  sourceSubscriptionID: string;

  /**
   * StartTime of the job(in UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * Status of the job like InProgress/Success/Failed/Cancelled/SuccessWithWarning
   */
  status: string;

  /**
   * Subscription Id of the corresponding backup vault
   */
  subscriptionId: string;

  /**
   * List of supported actions
   */
  supportedActions: string[];

  /**
   * Name of the vault
   */
  vaultName: string;

  etag?: string;
  sourceDataStoreName?: string;
  destinationDataStoreName?: string;
}

/**
 * Extended Information about the job
 */
model JobExtendedInfo {
  /**
   * Job's Additional Details
   */
  additionalDetails?: Record<string>;

  /**
   * State of the Backup Instance
   */
  @visibility("read")
  backupInstanceState?: string;

  /**
   * Number of bytes transferred
   */
  @visibility("read")
  dataTransferredInBytes?: float64;

  /**
   * Destination where restore is done
   */
  @visibility("read")
  recoveryDestination?: string;

  /**
   * Details of the Source Recovery Point
   */
  @visibility("read")
  sourceRecoverPoint?: RestoreJobRecoveryPointDetails;

  /**
   * List of Sub Tasks of the job
   */
  @visibility("read")
  subTasks?: JobSubTask[];

  /**
   * Details of the Target Recovery Point
   */
  @visibility("read")
  targetRecoverPoint?: RestoreJobRecoveryPointDetails;

  /**
   * A List, detailing the warnings related to the job
   */
  @visibility("read")
  warningDetails?: UserFacingWarningDetail[];
}

model RestoreJobRecoveryPointDetails {
  recoveryPointID?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;
}

/**
 * Details of Job's Sub Task
 */
model JobSubTask {
  /**
   * Additional details of Sub Tasks
   */
  additionalDetails?: Record<string>;

  /**
   * Task Id of the Sub Task
   */
  taskId: int32;

  /**
   * Name of the Sub Task
   */
  taskName: string;

  /**
   * Progress of the Sub Task
   */
  @visibility("read")
  taskProgress?: string;

  /**
   * Status of the Sub Task
   */
  taskStatus: string;
}

/**
 * Warning object used by layers that have access to localized content, and propagate that to user
 */
model UserFacingWarningDetail {
  /**
   * Name of resource for which warning is raised.
   */
  resourceName?: string;

  /**
   * Error details for the warning.
   */
  warning: UserFacingError;
}

/**
 * Details of Backup Vault for which CRR Jobs are to be fetched
 */
model CrossRegionRestoreJobsRequest {
  sourceRegion: string;
  sourceBackupVaultId: string;
}

/**
 * Azure Backup Rehydrate Request
 */
model AzureBackupRehydrationRequest {
  /**
   * Id of the recovery point to be recovered
   */
  recoveryPointId: string;

  /**
   * Priority to be used for rehydration. Values High or Standard
   */
  rehydrationPriority?: RehydrationPriority;

  /**
   * Retention duration in ISO 8601 format i.e P10D .
   */
  rehydrationRetentionDuration: duration;
}

/**
 * Sync BackupInstance Request
 */
model SyncBackupInstanceRequest {
  /**
   * Field indicating sync type e.g. to sync only in case of failure or in all cases
   */
  syncType?: SyncType;
}

/**
 * Validate restore request object
 */
model ValidateRestoreRequestObject {
  /**
   * Gets or sets the restore request object.
   */
  restoreRequestObject: AzureBackupRestoreRequest;
}

/**
 * List Restore Ranges Request
 */
model AzureBackupFindRestorableTimeRangesRequest {
  /**
   * Gets or sets the type of the source data store.
   */
  sourceDataStoreType: RestoreSourceDataStoreType;

  /**
   * Start time for the List Restore Ranges request. ISO 8601 format.
   */
  startTime?: string;

  /**
   * End time for the List Restore Ranges request. ISO 8601 format.
   */
  endTime?: string;
}

/**
 * List Restore Ranges Response
 */
model AzureBackupFindRestorableTimeRangesResponseResource extends DppResource {
  /**
   * AzureBackupFindRestorableTimeRangesResponseResource properties
   */
  properties?: AzureBackupFindRestorableTimeRangesResponse;
}

/**
 * List Restore Ranges Response
 */
model AzureBackupFindRestorableTimeRangesResponse {
  /**
   * Returns the Restore Ranges available on the Backup Instance.
   */
  restorableTimeRanges?: RestorableTimeRange[];

  objectType?: string;
}

model RestorableTimeRange {
  /**
   * Start time for the available restore range
   */
  startTime: string;

  /**
   * End time for the available restore range
   */
  endTime: string;

  objectType?: string;
}

/**
 * Deleted Backup Instance
 */
model DeletedBackupInstance extends BackupInstance {
  /**
   * Deletion info of Backup Instance
   */
  @visibility("read")
  deletionInfo?: DeletionInfo;
}

/**
 * Deletion Info
 */
model DeletionInfo {
  /**
   * Specifies time of deletion
   */
  @visibility("read")
  deletionTime?: string;

  /**
   * Specifies billing end date
   */
  @visibility("read")
  billingEndDate?: string;

  /**
   * Specifies purge time
   */
  @visibility("read")
  scheduledPurgeTime?: string;

  /**
   * Delete activity ID for troubleshooting purpose
   */
  @visibility("read")
  deleteActivityID?: string;
}

/**
 * ListResource
 */
model DppResourceList {
  /**
   * The uri to fetch the next page of resources. Call ListNext() fetches next page of resources.
   */
  nextLink?: string;
}

model ResourceGuard {
  /**
   * Provisioning state of the BackupVault resource
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * This flag indicates whether auto approval is allowed or not.
   */
  @visibility("read")
  allowAutoApprovals?: boolean;

  /**
   * {readonly} List of operation details those are protected by the ResourceGuard resource
   */
  @visibility("read")
  resourceGuardOperations?: ResourceGuardOperation[];

  /**
   * List of critical operations which are not protected by this resourceGuard
   */
  vaultCriticalOperationExclusionList?: string[];

  /**
   * Description about the pre-req steps to perform all the critical operations.
   */
  @visibility("read")
  description?: string;
}

/**
 * This class contains all the details about a critical operation.
 */
model ResourceGuardOperation {
  /**
   * Name of the critical operation.
   */
  @visibility("read")
  vaultCriticalOperation?: string;

  /**
   * Type of resource request.
   */
  @visibility("read")
  requestResourceType?: string;
}

/**
 * Patch Request content for Microsoft.DataProtection Resource Guard resources
 */
model PatchResourceGuardInput {
  /**
   * Resource Guard tags.
   */
  tags?: Record<string>;
}

/**
 * Base for all lists of V2 resources.
 */
model DppBaseResourceList is Azure.Core.Page<ResourceGuardProtectedObjectData>;

/**
 * Base resource under Microsoft.DataProtection provider namespace
 */
model ResourceGuardProtectedObjectData extends ResourceData {}

model ResourceData {
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
}

/**
 * ResourceGuardProxyBase object, used in ResourceGuardProxyBaseResource
 */
model ResourceGuardProxyBase {
  resourceGuardResourceId?: string;
  resourceGuardOperationDetails?: ResourceGuardOperationDetail[];
  lastUpdatedTime?: string;
  description?: string;
}

/**
 * VaultCritical Operation protected by a resource guard
 */
model ResourceGuardOperationDetail {
  vaultCriticalOperation?: string;
  defaultResourceRequest?: string;
}

/**
 * Request body of unlock delete API.
 */
model UnlockDeleteRequest {
  resourceGuardOperationRequests?: string[];
  resourceToBeDeleted?: string;
}

/**
 * Response of Unlock Delete API.
 */
model UnlockDeleteResponse {
  /**
   * This is the time when unlock delete privileges will get expired.
   */
  unlockDeleteExpiryTime?: string;
}

/**
 * Delete option with duration
 */
model AbsoluteDeleteOption extends DeleteOption {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AbsoluteDeleteOption";
}

/**
 * Delete Option
 */
@discriminator("objectType")
model DeleteOption {
  /**
   * Duration of deletion after given timespan
   */
  duration: duration;
}

model RecoveryPointsFilters {
  restorePointDataStoreId?: string;
  isVisible?: boolean;
  startDate?: string;
  endDate?: string;
  extendedInfo?: boolean;
  restorePointState?: string;
}

/**
 * Adhoc backup tagging criteria
 */
model AdhocBasedTaggingCriteria {
  /**
   * Retention tag information
   */
  tagInfo?: RetentionTag;
}

/**
 * Retention tag
 */
model RetentionTag {
  /**
   * Retention Tag version.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Retention Tag version.
   */
  @visibility("read")
  id?: string;

  /**
   * Retention Tag Name to relate it to retention rule.
   */
  tagName: string;
}

/**
 * Adhoc trigger context
 */
model AdhocBasedTriggerContext extends TriggerContext {
  /**
   * Tagging Criteria containing retention tag for adhoc backup.
   */
  taggingCriteria: AdhocBasedTaggingCriteria;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AdhocBasedTriggerContext";
}

/**
 * Trigger context
 */
@discriminator("objectType")
model TriggerContext {}

/**
 * Azure backup discrete RecoveryPoint
 */
model AzureBackupDiscreteRecoveryPoint extends AzureBackupRecoveryPoint {
  friendlyName?: string;
  recoveryPointDataStoresDetails?: RecoveryPointDataStoreDetails[];

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime: utcDateTime;

  policyName?: string;
  policyVersion?: string;
  recoveryPointId?: string;
  recoveryPointType?: string;
  retentionTagName?: string;
  retentionTagVersion?: string;

  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Specifies recovery point completeness. Partial (i.e., only some of the intended items were backed up), or Completed (i.e., ALL intended items were backed up).
   */
  recoveryPointState?: RecoveryPointCompletionState;

  objectType: "AzureBackupDiscreteRecoveryPoint";
}

/**
 * RecoveryPoint datastore details
 */
model RecoveryPointDataStoreDetails {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  id?: string;
  metaData?: string;
  state?: string;
  type?: string;
  visible?: boolean;

  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rehydrationExpiryTime?: utcDateTime;

  @visibility("read")
  rehydrationStatus?: RehydrationStatus;
}

/**
 * List Restore Ranges Request
 */
model AzureBackupFindRestorableTimeRangesRequestResource
  extends DppWorkerRequest {
  /**
   * AzureBackupFindRestorableTimeRangesRequestResource content
   */
  content?: AzureBackupFindRestorableTimeRangesRequest;
}

model DppWorkerRequest {
  subscriptionId?: string;
  uri?: string;

  /**
   * Dictionary of <components·ikn5y4·schemas·dppworkerrequest·properties·headers·additionalproperties>
   */
  headers?: Record<string[]>;

  supportedGroupVersions?: string[];
  cultureInfo?: string;

  /**
   * Dictionary of <string>
   */
  parameters?: Record<string>;

  httpMethod?: string;
}

/**
 * Azure backup parameters
 */
model AzureBackupParams extends BackupParameters {
  /**
   * BackupType ; Full/Incremental etc
   */
  backupType: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AzureBackupParams";
}

/**
 * BackupParameters base
 */
@discriminator("objectType")
model BackupParameters {}

/**
 * Azure backup recoveryPoint based restore request
 */
@discriminator("objectType")
model AzureBackupRecoveryPointBasedRestoreRequest
  extends AzureBackupRestoreRequest {
  recoveryPointId: string;
}

/**
 * AzureBackup Restore with Rehydration Request
 */
model AzureBackupRestoreWithRehydrationRequest
  extends AzureBackupRecoveryPointBasedRestoreRequest {
  /**
   * Priority to be used for rehydration. Values High or Standard
   */
  rehydrationPriority: RehydrationPriority;

  /**
   * Retention duration in ISO 8601 format i.e P10D .
   */
  rehydrationRetentionDuration: duration;

  objectType: "AzureBackupRestoreWithRehydrationRequest";
}

/**
 * AzureBackup RecoveryPointTime Based Restore Request
 */
model AzureBackupRecoveryTimeBasedRestoreRequest
  extends AzureBackupRestoreRequest {
  /**
   * The recovery time in ISO 8601 format example - 2020-08-14T17:30:00.0000000Z.
   */
  recoveryPointTime: string;

  objectType: "AzureBackupRecoveryTimeBasedRestoreRequest";
}

/**
 * Azure backup rule
 */
model AzureBackupRule extends BasePolicyRule {
  /**
   * BackupParameters base
   */
  backupParameters?: BackupParameters;

  /**
   * DataStoreInfo base
   */
  dataStore: DataStoreInfoBase;

  /**
   * Trigger context
   */
  trigger: TriggerContext;

  objectType: "AzureBackupRule";
}

/**
 * DataStoreInfo base
 */
model DataStoreInfoBase {
  /**
   * type of datastore; Operational/Vault/Archive
   */
  dataStoreType: DataStoreTypes;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType: string;
}

/**
 * BasePolicy Rule
 */
@discriminator("objectType")
model BasePolicyRule {
  name: string;
}

/**
 * Parameters for Operational-Tier DataStore
 */
model AzureOperationalStoreParameters extends DataStoreParameters {
  /**
   * Gets or sets the Snapshot Resource Group Uri.
   */
  resourceGroupId?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AzureOperationalStoreParameters";
}

/**
 * Parameters for Kubernetes Cluster Backup Datasource
 */
model KubernetesClusterBackupDatasourceParameters
  extends BackupDatasourceParameters {
  /**
   * Gets or sets the volume snapshot property. This property if enabled will take volume snapshots during backup.
   */
  snapshotVolumes: boolean;

  /**
   * Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during backup.
   */
  includeClusterScopeResources: boolean;

  /**
   * Gets or sets the include namespaces property. This property sets the namespaces to be included during backup.
   */
  includedNamespaces?: string[];

  /**
   * Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during backup.
   */
  excludedNamespaces?: string[];

  /**
   * Gets or sets the include resource types property. This property sets the resource types to be included during backup.
   */
  includedResourceTypes?: string[];

  /**
   * Gets or sets the exclude resource types property. This property sets the resource types to be excluded during backup.
   */
  excludedResourceTypes?: string[];

  /**
   * Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during backup.
   */
  labelSelectors?: string[];

  /**
   * Gets or sets the backup hook references. This property sets the hook reference to be executed during backup.
   */
  backupHookReferences?: NamespacedNameResource[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesClusterBackupDatasourceParameters";
}

/**
 * Class to refer resources which contains namespace and name
 */
model NamespacedNameResource {
  /**
   * Name of the resource
   */
  name?: string;

  /**
   * Namespace in which the resource exists
   */
  `namespace`?: string;
}

/**
 * Parameters to be used during configuration of backup of blobs
 */
model BlobBackupDatasourceParameters extends BackupDatasourceParameters {
  /**
   * List of containers to be backed up during configuration of backup of blobs
   */
  containersList: string[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "BlobBackupDatasourceParameters";
}

/**
 * Azure retention rule
 */
model AzureRetentionRule extends BasePolicyRule {
  isDefault?: boolean;
  lifecycles: SourceLifeCycle[];
  objectType: "AzureRetentionRule";
}

/**
 * Source LifeCycle
 */
model SourceLifeCycle {
  /**
   * Delete Option
   */
  deleteAfter: DeleteOption;

  /**
   * DataStoreInfo base
   */
  sourceDataStore: DataStoreInfoBase;

  targetDataStoreCopySettings?: TargetCopySetting[];
}

/**
 * Target copy settings
 */
model TargetCopySetting {
  /**
   * It can be CustomCopyOption or ImmediateCopyOption.
   */
  copyAfter: CopyOption;

  /**
   * Info of target datastore
   */
  dataStore: DataStoreInfoBase;
}

/**
 * Options to copy
 */
@discriminator("objectType")
model CopyOption {}

/**
 * BackupCriteria base class
 */
@discriminator("objectType")
model BackupCriteria {}

/**
 * Rule based backup policy
 */
model BackupPolicy extends BaseBackupPolicy {
  /**
   * Policy rule dictionary that contains rules for each backuptype i.e Full/Incremental/Logs etc
   */
  policyRules: BasePolicyRule[];

  objectType: "BackupPolicy";
}

/**
 * Schedule for backup
 */
model BackupSchedule {
  /**
   * ISO 8601 repeating time interval format
   */
  repeatingTimeIntervals: string[];

  /**
   * Time zone for a schedule. Example: Pacific Standard Time
   */
  timeZone?: string;
}

/**
 * Localized display information of an operation.
 */
model ClientDiscoveryDisplay {
  /**
   * Description of the operation having details of what operation is about.
   */
  description?: string;

  /**
   * Operations Name itself.
   */
  operation?: string;

  /**
   * Name of the provider for display purposes
   */
  provider?: string;

  /**
   * ResourceType for which this Operation can be performed.
   */
  resource?: string;
}

/**
 * Class to represent shoebox log specification in json client discovery.
 */
model ClientDiscoveryForLogSpecification {
  /**
   * blob duration of shoebox log specification
   */
  blobDuration?: duration;

  /**
   * Localized display name
   */
  displayName?: string;

  /**
   * Name for shoebox log specification.
   */
  name?: string;
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
 * Operations List response which contains list of available APIs.
 */
model ClientDiscoveryResponse {
  /**
   * Link to the next chunk of Response.
   */
  nextLink?: string;

  /**
   * List of available operations.
   */
  value?: ClientDiscoveryValueForSingleApi[];
}

/**
 * Available operation details.
 */
model ClientDiscoveryValueForSingleApi {
  /**
   * Contains the localized display information for this particular operation
   */
  display?: ClientDiscoveryDisplay;

  /**
   * Name of the Operation.
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The intended executor of the operation;governs the display of the operation in the RBAC UX and the audit logs UX
   */
  origin?: string;

  /**
   * Properties for the given operation.
   */
  properties?: ClientDiscoveryForProperties;
}

/**
 * Copy on Expiry Option
 */
model CopyOnExpiryOption extends CopyOption {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "CopyOnExpiryOption";
}

/**
 * Duration based custom options to copy
 */
model CustomCopyOption extends CopyOption {
  /**
   * Data copied after given timespan
   */
  duration?: duration;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "CustomCopyOption";
}

/**
 * Day of the week
 */
model Day {
  /**
   * Date of the month
   */
  date?: int32;

  /**
   * Whether Date is last date of month
   */
  isLast?: boolean;
}

/**
 * Default source properties
 */
model DefaultResourceProperties extends BaseResourceProperties {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "DefaultResourceProperties";
}

model DppTrackedResourceList {
  /**
   * The uri to fetch the next page of resources. Call ListNext() fetches next page of resources.
   */
  nextLink?: string;
}

/**
 * The result for export jobs containing blob details.
 */
model ExportJobsResult {
  /**
   * URL of the blob into which the serialized string of list of jobs is exported.
   */
  @visibility("read")
  blobUrl?: string;

  /**
   * SAS key to access the blob.
   */
  @visibility("read")
  blobSasKey?: string;

  /**
   * URL of the blob into which the ExcelFile is uploaded.
   */
  @visibility("read")
  excelFileBlobUrl?: string;

  /**
   * SAS key to access the ExcelFile blob.
   */
  @visibility("read")
  excelFileBlobSasKey?: string;
}

/**
 * Base class for feature object
 */
model FeatureValidationRequest extends FeatureValidationRequestBase {
  /**
   * backup support feature type.
   */
  featureType?: FeatureType;

  /**
   * backup support feature name.
   */
  featureName?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "FeatureValidationRequest";
}

/**
 * Feature Validation Response
 */
model FeatureValidationResponse extends FeatureValidationResponseBase {
  /**
   * backup support feature type.
   */
  featureType?: FeatureType;

  /**
   * Response features
   */
  features?: SupportedFeature[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "FeatureValidationResponse";
}

/**
 * Elements class for feature request
 */
model SupportedFeature {
  /**
   * support feature type.
   */
  featureName?: string;

  /**
   * feature support status
   */
  supportStatus?: FeatureSupportStatus;

  /**
   * support feature type.
   */
  exposureControlledFeatures?: string[];
}

/**
 * Immediate copy Option
 */
model ImmediateCopyOption extends CopyOption {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "ImmediateCopyOption";
}

/**
 * Class to contain criteria for item level restore
 */
@discriminator("objectType")
model ItemLevelRestoreCriteria {}

/**
 * Restore target info for Item level restore operation
 */
model ItemLevelRestoreTargetInfo extends RestoreTargetInfoBase {
  /**
   * Restore Criteria
   */
  restoreCriteria: ItemLevelRestoreCriteria[];

  /**
   * Information of target DS
   */
  datasourceInfo: Datasource;

  /**
   * Information of target DS Set
   */
  datasourceSetInfo?: DatasourceSet;

  /**
   * Credentials to use to authenticate with data source provider.
   */
  datasourceAuthCredentials?: AuthCredentials;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType: "ItemLevelRestoreTargetInfo";
}

/**
 * Prefix criteria to be used to during restore
 */
model ItemPathBasedRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * The path of the item to be restored. It could be the full path of the item or the path relative to the backup item
   */
  itemPath: string;

  /**
   * Flag to specify if the path is relative to backup item or full path
   */
  isPathRelativeToBackupItem: boolean;

  /**
   * The list of prefix strings to be used as filter criteria during restore. These are relative to the item path specified.
   */
  subItemPathPrefix?: string[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "ItemPathBasedRestoreCriteria";
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
   * The full set of optional properties (e.g. inner errors / details) can be found in the "Error Response" section.
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
   * End time of the operation
   */
  properties?: OperationExtendedInfo;

  /**
   * Start time of the operation
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  status?: string;
}

/**
 * Item Level target info for restore operation
 */
model RangeBasedItemLevelRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * minimum value for range prefix match
   */
  minMatchingValue?: string;

  /**
   * maximum value for range prefix match
   */
  maxMatchingValue?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "RangeBasedItemLevelRestoreCriteria";
}

/**
 * Item Level kubernetes storage class target info for restore operation
 */
model KubernetesStorageClassRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * Selected storage class name
   */
  selectedStorageClassName?: string;

  /**
   * Provisioner of the storage class
   */
  provisioner?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesStorageClassRestoreCriteria";
}

/**
 * Item Level kubernetes persistent volume target info for restore operation
 */
model KubernetesPVRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * Selected persistent volume claim name
   */
  name?: string;

  /**
   * Selected storage class name for restore operation
   */
  storageClassName?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesPVRestoreCriteria";
}

/**
 * kubernetes Cluster Backup target info for restore operation
 */
model KubernetesClusterRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during restore.
   */
  includeClusterScopeResources: boolean;

  /**
   * Gets or sets the include namespaces property. This property sets the namespaces to be included during restore.
   */
  includedNamespaces?: string[];

  /**
   * Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during restore.
   */
  excludedNamespaces?: string[];

  /**
   * Gets or sets the include resource types property. This property sets the resource types to be included during restore.
   */
  includedResourceTypes?: string[];

  /**
   * Gets or sets the exclude resource types property. This property sets the resource types to be excluded during restore.
   */
  excludedResourceTypes?: string[];

  /**
   * Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during restore.
   */
  labelSelectors?: string[];

  /**
   * Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored.
   */
  persistentVolumeRestoreMode?: PersistentVolumeRestoreMode;

  /**
   * Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore.
   */
  conflictPolicy?: ExistingResourcePolicy;

  /**
   * Gets or sets the Namespace Mappings property. This property sets if namespace needs to be change during restore.
   */
  namespaceMappings?: Record<string>;

  /**
   * Gets or sets the restore hook references. This property sets the hook reference to be executed during restore.
   */
  restoreHookReferences?: NamespacedNameResource[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesClusterRestoreCriteria";
}

/**
 * kubernetes Cluster Backup target info for restore operation from vault
 */
model KubernetesClusterVaultTierRestoreCriteria
  extends ItemLevelRestoreCriteria {
  /**
   * Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during restore from vault.
   */
  includeClusterScopeResources: boolean;

  /**
   * Gets or sets the include namespaces property. This property sets the namespaces to be included during restore from vault.
   */
  includedNamespaces?: string[];

  /**
   * Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during restore from vault.
   */
  excludedNamespaces?: string[];

  /**
   * Gets or sets the include resource types property. This property sets the resource types to be included during restore from vault.
   */
  includedResourceTypes?: string[];

  /**
   * Gets or sets the exclude resource types property. This property sets the resource types to be excluded during restore from vault.
   */
  excludedResourceTypes?: string[];

  /**
   * Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during restore from vault.
   */
  labelSelectors?: string[];

  /**
   * Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored from vault.
   */
  persistentVolumeRestoreMode?: PersistentVolumeRestoreMode;

  /**
   * Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore from vault.
   */
  conflictPolicy?: ExistingResourcePolicy;

  /**
   * Gets or sets the Namespace Mappings property. This property sets if namespace needs to be change during restore from vault.
   */
  namespaceMappings?: Record<string>;

  /**
   * Gets or sets the restore hook references. This property sets the hook reference to be executed during restore from vault.
   */
  restoreHookReferences?: NamespacedNameResource[];

  /**
   * Gets or sets the staging RG Id for creating staging disks and snapshots during restore from vault.
   */
  stagingResourceGroupId?: ResourceIdentifier;

  /**
   * Gets or sets the staging Storage Account Id for creating backup extension object store data during restore from vault.
   */
  stagingStorageAccountId?: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesClusterVaultTierRestoreCriteria";
}

/**
 * Class encapsulating restore as files target parameters
 */
model RestoreFilesTargetInfo extends RestoreTargetInfoBase {
  /**
   * Destination of RestoreAsFiles operation, when destination is not a datasource
   */
  targetDetails: TargetDetails;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType: "RestoreFilesTargetInfo";
}

/**
 * Class encapsulating target details, used where the destination is not a datasource
 */
model TargetDetails {
  /**
   * Restore operation may create multiple files inside location pointed by Url
   * Below will be the common prefix for all of them
   */
  filePrefix: string;

  /**
   * Denotes the target location where the data will be restored,
   * string value for the enum {Microsoft.Internal.AzureBackup.DataProtection.Common.Interface.RestoreTargetLocationType}
   */
  restoreTargetLocationType: RestoreTargetLocationType;

  /**
   * Url denoting the restore destination. It can point to container / file share etc
   */
  url: string;

  /**
   * Full ARM Id denoting the restore destination. It is the ARM Id pointing to container / file share
   * This is optional if the target subscription can be identified with the URL field. If not
   * then this is needed if CrossSubscriptionRestore field of BackupVault is in any of the disabled states
   */
  targetResourceArmId?: string;
}

/**
 * Class encapsulating restore target parameters
 */
model RestoreTargetInfo extends RestoreTargetInfoBase {
  /**
   * Information of target DS
   */
  datasourceInfo: Datasource;

  /**
   * Information of target DS Set
   */
  datasourceSetInfo?: DatasourceSet;

  /**
   * Credentials to use to authenticate with data source provider.
   */
  datasourceAuthCredentials?: AuthCredentials;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType: "RestoreTargetInfo";
}

/**
 * Schedule based backup criteria
 */
model ScheduleBasedBackupCriteria extends BackupCriteria {
  /**
   * it contains absolute values like "AllBackup" / "FirstOfDay" / "FirstOfWeek" / "FirstOfMonth"
   * and should be part of AbsoluteMarker enum
   */
  absoluteCriteria?: AbsoluteMarker[];

  /**
   * This is day of the month from 1 to 28 other wise last of month
   */
  daysOfMonth?: Day[];

  /**
   * It should be Sunday/Monday/T..../Saturday
   */
  daysOfTheWeek?: DayOfWeek[];

  /**
   * It should be January/February/....../December
   */
  monthsOfYear?: Month[];

  /**
   * List of schedule times for backup
   */
  scheduleTimes?: utcDateTime[];

  /**
   * It should be First/Second/Third/Fourth/Last
   */
  weeksOfTheMonth?: WeekNumber[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "ScheduleBasedBackupCriteria";
}

/**
 * Schedule based trigger context
 */
model ScheduleBasedTriggerContext extends TriggerContext {
  /**
   * Schedule for this backup
   */
  schedule: BackupSchedule;

  /**
   * List of tags that can be applicable for given schedule.
   */
  taggingCriteria: TaggingCriteria[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "ScheduleBasedTriggerContext";
}

/**
 * Tagging criteria
 */
model TaggingCriteria {
  /**
   * Criteria which decides whether the tag can be applied to a triggered backup.
   */
  criteria?: BackupCriteria[];

  /**
   * Specifies if tag is default.
   */
  isDefault: boolean;

  /**
   * Retention Tag priority.
   */
  taggingPriority: int64;

  /**
   * Retention tag information
   */
  tagInfo: RetentionTag;
}

/**
 * Secret store based authentication credentials.
 */
model SecretStoreBasedAuthCredentials extends AuthCredentials {
  /**
   * Secret store resource
   */
  secretStoreResource?: SecretStoreResource;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "SecretStoreBasedAuthCredentials";
}

/**
 * Class representing a secret store resource.
 */
model SecretStoreResource {
  /**
   * Uri to get to the resource
   */
  uri?: string;

  /**
   * Gets or sets the type of secret store
   */
  secretStoreType: SecretStoreType;

  /**
   * Gets or sets value stored in secret store resource
   */
  value?: string;
}
