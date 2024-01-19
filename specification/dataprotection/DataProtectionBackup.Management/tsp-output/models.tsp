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

@doc("Provisioning state of the BackupVault resource")
enum ProvisioningState {
  Failed,
  Provisioning,
  Succeeded,
  Unknown,
  Updating,
}

@doc("Resource move state for backup vault")
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

@doc("State of soft delete")
enum SoftDeleteState {
  @doc("Soft Delete is turned off for the BackupVault") Off,
  @doc("Soft Delete is enabled for the BackupVault but can be turned off") On,
  @doc("Soft Delete is permanently enabled for the BackupVault and the setting cannot be changed")
  AlwaysOn,
}

@doc("Immutability state")
enum ImmutabilityState {
  Disabled,
  Unlocked,
  Locked,
}

@doc("Gets or sets the type of the datastore.")
enum StorageSettingStoreTypes {
  ArchiveStore,
  OperationalStore,
  VaultStore,
}

@doc("Gets or sets the type.")
enum StorageSettingTypes {
  GeoRedundant,
  LocallyRedundant,
  ZoneRedundant,
}

@doc("CrossSubscriptionRestore state")
enum CrossSubscriptionRestoreState {
  Disabled,
  PermanentlyDisabled,
  Enabled,
}

@doc("CrossRegionRestore state")
enum CrossRegionRestoreState {
  Disabled,
  Enabled,
}

@doc("Secure Score of Backup Vault")
enum SecureScoreLevel {
  None,
  Minimum,
  Adequate,
  Maximum,
  NotSupported,
}

@doc("Type of the specific object - used for deserializing")
enum ResourcePropertiesObjectType {
  DefaultResourceProperties,
}

@doc("type of datastore; Operational/Vault/Archive")
enum DataStoreTypes {
  OperationalStore,
  VaultStore,
  ArchiveStore,
}

@doc("Specifies the protection status of the resource")
enum Status {
  ConfiguringProtection,
  ConfiguringProtectionFailed,
  ProtectionConfigured,
  ProtectionStopped,
  SoftDeleted,
  SoftDeleting,
}

@doc("Specifies the current protection state of the resource")
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

@doc("Specifies the type of validation. In case of DeepValidation, all validations from /validateForBackup API will run again.")
enum ValidationType {
  ShallowValidation,
  DeepValidation,
}

@doc("Recovery Option")
enum RecoveryOption {
  FailIfExists,
}

@doc("Gets or sets the type of the source data store.")
enum SourceDataStoreType {
  ArchiveStore,
  SnapshotStore,
  OperationalStore,
  VaultStore,
}

@doc("Priority to be used for rehydration. Values High or Standard")
enum RehydrationPriority {
  Invalid,
  High,
  Standard,
}

@doc("Field indicating sync type e.g. to sync only in case of failure or in all cases")
enum SyncType {
  Default,
  ForceResync,
}

@doc("Gets or sets the type of the source data store.")
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

@doc("Specifies recovery point completeness. Partial (i.e., only some of the intended items were backed up), or Completed (i.e., ALL intended items were backed up).")
enum RecoveryPointCompletionState {
  Completed,
  Partial,
}

@doc("backup support feature type.")
enum FeatureType {
  Invalid,
  DataSourceType,
}

@doc("feature support status")
enum FeatureSupportStatus {
  Invalid,
  NotSupported,
  AlphaPreview,
  PrivatePreview,
  PublicPreview,
  GenerallyAvailable,
}

@doc("Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored.")
enum PersistentVolumeRestoreMode {
  RestoreWithVolumeData,
  RestoreWithoutVolumeData,
}

@doc("Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore.")
enum ExistingResourcePolicy {
  Skip,
  Patch,
}

@doc("""
Denotes the target location where the data will be restored,
string value for the enum {Microsoft.Internal.AzureBackup.DataProtection.Common.Interface.RestoreTargetLocationType}
""")
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

@doc("Gets or sets the type of secret store")
enum SecretStoreType {
  Invalid,
  AzureKeyVault,
}

@doc("Backup Vault")
model BackupVault {
  @doc("Monitoring Settings")
  monitoringSettings?: MonitoringSettings;

  @doc("Provisioning state of the BackupVault resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource move state for backup vault")
  @visibility("read")
  resourceMoveState?: ResourceMoveState;

  @doc("Resource move details for backup vault")
  @visibility("read")
  resourceMoveDetails?: ResourceMoveDetails;

  @doc("Security Settings")
  securitySettings?: SecuritySettings;

  @doc("Storage Settings")
  storageSettings: StorageSetting[];

  @doc("Is vault protected by resource guard")
  @visibility("read")
  isVaultProtectedByResourceGuard?: boolean;

  @doc("Feature Settings")
  featureSettings?: FeatureSettings;

  @doc("Secure Score of Backup Vault")
  @visibility("read")
  secureScore?: SecureScoreLevel;

  @doc("List of replicated regions for Backup Vault")
  replicatedRegions?: string[];
}

@doc("Monitoring Settings")
model MonitoringSettings {
  @doc("Settings for Azure Monitor based alerts")
  azureMonitorAlertSettings?: AzureMonitorAlertSettings;
}

@doc("Settings for Azure Monitor based alerts")
model AzureMonitorAlertSettings {
  alertsForAllJobFailures?: AlertsState;
}

@doc("ResourceMoveDetails will be returned in response to GetResource call from ARM")
model ResourceMoveDetails {
  @doc("CorrelationId of latest ResourceMove operation attempted")
  operationId?: string;

  @doc("Start time in UTC of latest ResourceMove operation attempted. ISO 8601 format.")
  startTimeUtc?: string;

  @doc("Completion time in UTC of latest ResourceMove operation attempted. ISO 8601 format.")
  completionTimeUtc?: string;

  @doc("ARM resource path of source resource")
  sourceResourcePath?: string;

  @doc("ARM resource path of target resource used in latest ResourceMove operation")
  targetResourcePath?: string;
}

@doc("Class containing security settings of vault")
model SecuritySettings {
  @doc("Soft delete related settings")
  softDeleteSettings?: SoftDeleteSettings;

  @doc("Immutability Settings at vault level")
  immutabilitySettings?: ImmutabilitySettings;
}

@doc("Soft delete related settings")
model SoftDeleteSettings {
  @doc("State of soft delete")
  state?: SoftDeleteState;

  @doc("Soft delete retention duration")
  retentionDurationInDays?: float32;
}

@doc("Immutability Settings at vault level")
model ImmutabilitySettings {
  @doc("Immutability state")
  state?: ImmutabilityState;
}

@doc("Storage setting")
model StorageSetting {
  @doc("Gets or sets the type of the datastore.")
  datastoreType?: StorageSettingStoreTypes;

  @doc("Gets or sets the type.")
  type?: StorageSettingTypes;
}

@doc("Class containing feature settings of vault")
model FeatureSettings {
  @doc("CrossSubscriptionRestore Settings")
  crossSubscriptionRestoreSettings?: CrossSubscriptionRestoreSettings;

  crossRegionRestoreSettings?: CrossRegionRestoreSettings;
}

@doc("CrossSubscriptionRestore Settings")
model CrossSubscriptionRestoreSettings {
  @doc("CrossSubscriptionRestore state")
  state?: CrossSubscriptionRestoreState;
}

model CrossRegionRestoreSettings {
  @doc("CrossRegionRestore state")
  state?: CrossRegionRestoreState;
}

model DppTrackedResource extends DppBaseTrackedResource {
  @doc("Input Managed Identity Details")
  identity?: DppIdentityDetails;
}

@doc("Identity details")
model DppIdentityDetails {
  @doc("The object ID of the service principal object for the managed identity that is used to grant role-based access to an Azure resource.")
  @visibility("read")
  principalId?: string;

  @doc("A Globally Unique Identifier (GUID) that represents the Azure AD tenant where the resource is now a member.")
  @visibility("read")
  tenantId?: string;

  @doc("The identityType which can be either SystemAssigned, UserAssigned, 'SystemAssigned,UserAssigned' or None")
  type?: string;

  @doc("Gets or sets the user assigned identities.")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

model DppBaseTrackedResource {
  @doc("Optional ETag.")
  eTag?: string;

  @doc("Resource Id represents the complete path to the resource.")
  @visibility("read")
  id?: string;

  @doc("Resource location.")
  location?: string;

  @doc("Resource name associated with the resource.")
  @visibility("read")
  name?: string;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...")
  @visibility("read")
  type?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
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

@doc("Patch Request content for Microsoft.DataProtection resources")
model PatchResourceRequestInput {
  @doc("Input Managed Identity Details")
  identity?: DppIdentityDetails;

  @doc("Resource properties.")
  properties?: PatchBackupVaultInput;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Backup Vault Contract for Patch Backup Vault API.")
model PatchBackupVaultInput {
  @doc("Monitoring Settings")
  monitoringSettings?: MonitoringSettings;

  @doc("Security Settings")
  securitySettings?: SecuritySettings;

  @doc("Feature Settings")
  featureSettings?: FeatureSettings;
}

@doc("CheckNameAvailability Request")
model CheckNameAvailabilityRequest {
  @doc("Resource name for which availability needs to be checked")
  name?: string;

  @doc("Describes the Resource type: Microsoft.DataProtection/BackupVaults")
  type?: string;
}

@doc("CheckNameAvailability Result")
model CheckNameAvailabilityResult {
  @doc("Gets or sets the message.")
  message?: string;

  @doc("Gets or sets a value indicating whether [name available].")
  nameAvailable?: boolean;

  @doc("Gets or sets the reason.")
  reason?: string;
}

@doc("Base class for Backup Feature support")
@discriminator("objectType")
model FeatureValidationRequestBase {}

@doc("Base class for Backup Feature support")
@discriminator("objectType")
model FeatureValidationResponseBase {}

@doc("BackupPolicy base")
@discriminator("objectType")
model BaseBackupPolicy {
  @doc("Type of datasource for the backup management")
  datasourceTypes: string[];
}

@doc("Resource class")
model DppResource {
  @doc("Resource Id represents the complete path to the resource.")
  @visibility("read")
  id?: string;

  @doc("Resource name associated with the resource.")
  @visibility("read")
  name?: string;

  @doc("Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...")
  @visibility("read")
  type?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Backup Instance")
model BackupInstance {
  @doc("Gets or sets the Backup Instance friendly name.")
  friendlyName?: string;

  @doc("Gets or sets the data source information.")
  dataSourceInfo: Datasource;

  @doc("Gets or sets the data source set information.")
  dataSourceSetInfo?: DatasourceSet;

  @doc("Gets or sets the policy information.")
  policyInfo: PolicyInfo;

  @doc("Specifies the protection status of the resource")
  @visibility("read")
  protectionStatus?: ProtectionStatusDetails;

  @doc("Specifies the current protection state of the resource")
  @visibility("read")
  currentProtectionState?: CurrentProtectionState;

  @doc("Specifies the protection error of the resource")
  @visibility("read")
  protectionErrorDetails?: UserFacingError;

  @doc("Specifies the provisioning state of the resource i.e. provisioning/updating/Succeeded/Failed")
  @visibility("read")
  provisioningState?: string;

  @doc("Credentials to use to authenticate with data source provider.")
  datasourceAuthCredentials?: AuthCredentials;

  @doc("Specifies the type of validation. In case of DeepValidation, all validations from /validateForBackup API will run again.")
  validationType?: ValidationType;

  @doc("""
Contains information of the Identity Details for the BI.
If it is null, default will be considered as System Assigned.
""")
  identityDetails?: IdentityDetails;

  objectType: string;
}

@doc("Datasource to be backed up")
model Datasource {
  @doc("DatasourceType of the resource.")
  datasourceType?: string;

  @doc("Type of Datasource object, used to initialize the right inherited type")
  objectType?: string;

  @doc("Full ARM ID of the resource. For azure resources, this is ARM ID. For non azure resources, this will be the ID created by backup service via Fabric/Vault.")
  resourceID: string;

  @doc("Location of datasource.")
  resourceLocation?: string;

  @doc("Unique identifier of the resource in the context of parent.")
  resourceName?: string;

  @doc("Resource Type of Datasource.")
  resourceType?: string;

  @doc("Uri of the resource.")
  resourceUri?: string;

  @doc("Properties specific to data source")
  resourceProperties?: BaseResourceProperties;
}

@doc("Properties which are specific to datasource/datasourceSets")
@discriminator("objectType")
model BaseResourceProperties {}

@doc("DatasourceSet details of datasource to be backed up")
model DatasourceSet {
  @doc("DatasourceType of the resource.")
  datasourceType?: string;

  @doc("Type of Datasource object, used to initialize the right inherited type")
  objectType?: string;

  @doc("Full ARM ID of the resource. For azure resources, this is ARM ID. For non azure resources, this will be the ID created by backup service via Fabric/Vault.")
  resourceID: string;

  @doc("Location of datasource.")
  resourceLocation?: string;

  @doc("Unique identifier of the resource in the context of parent.")
  resourceName?: string;

  @doc("Resource Type of Datasource.")
  resourceType?: string;

  @doc("Uri of the resource.")
  resourceUri?: string;

  @doc("Properties specific to data source set")
  resourceProperties?: BaseResourceProperties;
}

@doc("Policy Info in backupInstance")
model PolicyInfo {
  policyId: string;

  @visibility("read")
  policyVersion?: string;

  @doc("Policy parameters for the backup instance")
  policyParameters?: PolicyParameters;
}

@doc("Parameters in Policy")
model PolicyParameters {
  @doc("Gets or sets the DataStore Parameters")
  dataStoreParametersList?: DataStoreParameters[];

  @doc("Gets or sets the Backup Data Source Parameters")
  backupDatasourceParametersList?: BackupDatasourceParameters[];
}

@doc("Parameters for DataStore")
@discriminator("objectType")
model DataStoreParameters {
  @doc("type of datastore; Operational/Vault/Archive")
  dataStoreType: DataStoreTypes;
}

@doc("Parameters for Backup Datasource")
@discriminator("objectType")
model BackupDatasourceParameters {}

@doc("Protection status details")
model ProtectionStatusDetails {
  @doc("Specifies the protection status error of the resource")
  errorDetails?: UserFacingError;

  @doc("Specifies the protection status of the resource")
  status?: Status;
}

@doc("Error object used by layers that have access to localized content, and propagate that to user")
model UserFacingError {
  @doc("Unique code for this error")
  code?: string;

  @doc("Additional related Errors")
  details?: UserFacingError[];

  @doc("Inner Error")
  innerError?: InnerError;

  @doc("Whether the operation will be retryable or not")
  isRetryable?: boolean;

  @doc("Whether the operation is due to a user error or service error")
  isUserError?: boolean;

  @doc("Any key value pairs that can be injected inside error object")
  properties?: Record<string>;

  message?: string;

  @doc("RecommendedAction � localized.")
  recommendedAction?: string[];

  @doc("Target of the error.")
  target?: string;
}

@doc("Inner Error")
model InnerError {
  @doc("Any Key value pairs that can be provided to the client for additional  verbose information.")
  additionalInfo?: Record<string>;

  @doc("Unique code for this error")
  code?: string;

  @doc("Child Inner Error, to allow Nesting.")
  embeddedInnerError?: InnerError;
}

@doc("Base class for different types of authentication credentials.")
@discriminator("objectType")
model AuthCredentials {}

model IdentityDetails {
  @doc("Specifies if the BI is protected by System Identity.")
  useSystemAssignedIdentity?: boolean;

  @doc("ARM URL for User Assigned Identity.")
  userAssignedIdentityArmUrl?: string;
}

model DppProxyResource {
  @doc("Proxy Resource Id represents the complete path to the resource.")
  @visibility("read")
  id?: string;

  @doc("Proxy Resource name associated with the resource.")
  @visibility("read")
  name?: string;

  @doc("Proxy Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...")
  @visibility("read")
  type?: string;

  @doc("Proxy Resource tags.")
  tags?: Record<string>;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Trigger backup request")
model TriggerBackupRequest {
  @doc("Name for the Rule of the Policy which needs to be applied for this backup")
  backupRuleOptions: AdHocBackupRuleOptions;
}

@doc("Adhoc backup rules")
model AdHocBackupRuleOptions {
  ruleName: string;

  @doc("Adhoc backup trigger option")
  triggerOption: AdhocBackupTriggerOption;
}

@doc("Adhoc backup trigger option")
model AdhocBackupTriggerOption {
  retentionTagOverride?: string;
}

@doc("Operation Job Extended Info")
model OperationJobExtendedInfo extends OperationExtendedInfo {
  @doc("Name or Arm Id of the job created for this operation.")
  jobId?: string;

  @doc("This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.")
  objectType: "OperationJobExtendedInfo";
}

@doc("Operation Extended Info")
@discriminator("objectType")
model OperationExtendedInfo {}

@doc("Validate for backup request")
model ValidateForBackupRequest {
  @doc("Backup Instance")
  backupInstance: BackupInstance;
}

@doc("Azure backup recoveryPoint")
@discriminator("objectType")
model AzureBackupRecoveryPoint {}

@doc("""
Information about BI whose secondary RecoveryPoints are requested
Source region and
BI ARM path
""")
model FetchSecondaryRPsRequestParameters {
  @doc("Source region in which BackupInstance is located")
  sourceRegion?: string;

  @doc("ARM Path of BackupInstance")
  sourceBackupInstanceId?: string;
}

@doc("Cross Region Restore Request Object")
model CrossRegionRestoreRequestObject {
  @doc("Gets or sets the restore request object.")
  restoreRequestObject: AzureBackupRestoreRequest;

  @doc("Cross region restore details.")
  crossRegionRestoreDetails: CrossRegionRestoreDetails;
}

@doc("Azure backup restore request")
@discriminator("objectType")
model AzureBackupRestoreRequest {
  @doc("Gets or sets the restore target information.")
  restoreTargetInfo: RestoreTargetInfoBase;

  @doc("Gets or sets the type of the source data store.")
  sourceDataStoreType: SourceDataStoreType;

  @doc("Fully qualified Azure Resource Manager ID of the datasource which is being recovered.")
  sourceResourceId?: string;

  @doc("""
Contains information of the Identity Details for the BI.
If it is null, default will be considered as System Assigned.
""")
  identityDetails?: IdentityDetails;
}

@doc("Base class common to RestoreTargetInfo and RestoreFilesTargetInfo")
@discriminator("objectType")
model RestoreTargetInfoBase {
  @doc("Recovery Option")
  recoveryOption: RecoveryOption;

  @doc("Target Restore region")
  restoreLocation?: string;
}

@doc("Cross Region Restore details")
model CrossRegionRestoreDetails {
  sourceRegion: string;
  sourceBackupInstanceId: string;
}

@doc("Cross Region Restore Request Object")
model ValidateCrossRegionRestoreRequestObject {
  @doc("Gets or sets the restore request object.")
  restoreRequestObject: AzureBackupRestoreRequest;

  @doc("Cross region restore details.")
  crossRegionRestoreDetails: CrossRegionRestoreDetails;
}

@doc("Details of CRR Job to be fetched")
model CrossRegionRestoreJobRequest {
  sourceRegion: string;
  sourceBackupVaultId: string;
  jobId: string;
}

@doc("AzureBackup Job Class")
model AzureBackupJob {
  @doc("Job Activity Id")
  activityID: string;

  @doc("Name of the Backup Instance")
  backupInstanceFriendlyName: string;

  @doc("ARM ID of the Backup Instance")
  @visibility("read")
  backupInstanceId?: string;

  @doc("ARM ID of the DataSource")
  dataSourceId: string;

  @doc("Location of the DataSource")
  dataSourceLocation: string;

  @doc("User Friendly Name of the DataSource")
  dataSourceName: string;

  @doc("Data Source Set Name of the DataSource")
  dataSourceSetName?: string;

  @doc("Type of DataSource")
  dataSourceType: string;

  @doc("Total run time of the job. ISO 8601 format.")
  duration?: string;

  @doc("EndTime of the job(in UTC)")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("A List, detailing the errors related to the job")
  @visibility("read")
  errorDetails?: UserFacingError[];

  @doc("Extended Information about the job")
  @visibility("read")
  extendedInfo?: JobExtendedInfo;

  @doc("Indicated that whether the job is adhoc(true) or scheduled(false)")
  isUserTriggered: boolean;

  @doc("It indicates the type of Job i.e. Backup:full/log/diff ;Restore:ALR/OLR; Tiering:Backup/Archive ; Management:ConfigureProtection/UnConfigure")
  operation: string;

  @doc("It indicates the type of Job i.e. Backup/Restore/Tiering/Management")
  operationCategory: string;

  @doc("ARM ID of the policy")
  @visibility("read")
  policyId?: string;

  @doc("Name of the policy")
  @visibility("read")
  policyName?: string;

  @doc("Indicated whether progress is enabled for the job")
  progressEnabled: boolean;

  @doc("Url which contains job's progress")
  @visibility("read")
  progressUrl?: string;

  @doc("Priority to be used for rehydration")
  @visibility("read")
  rehydrationPriority?: string;

  @doc("It indicates the sub type of operation i.e. in case of Restore it can be ALR/OLR")
  @visibility("read")
  restoreType?: string;

  @doc("Resource Group Name of the Datasource")
  sourceResourceGroup: string;

  @doc("SubscriptionId corresponding to the DataSource")
  sourceSubscriptionID: string;

  @doc("StartTime of the job(in UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  @doc("Status of the job like InProgress/Success/Failed/Cancelled/SuccessWithWarning")
  status: string;

  @doc("Subscription Id of the corresponding backup vault")
  subscriptionId: string;

  @doc("List of supported actions")
  supportedActions: string[];

  @doc("Name of the vault")
  vaultName: string;

  etag?: string;
  sourceDataStoreName?: string;
  destinationDataStoreName?: string;
}

@doc("Extended Information about the job")
model JobExtendedInfo {
  @doc("Job's Additional Details")
  additionalDetails?: Record<string>;

  @doc("State of the Backup Instance")
  @visibility("read")
  backupInstanceState?: string;

  @doc("Number of bytes transferred")
  @visibility("read")
  dataTransferredInBytes?: float32;

  @doc("Destination where restore is done")
  @visibility("read")
  recoveryDestination?: string;

  @doc("Details of the Source Recovery Point")
  @visibility("read")
  sourceRecoverPoint?: RestoreJobRecoveryPointDetails;

  @doc("List of Sub Tasks of the job")
  @visibility("read")
  subTasks?: JobSubTask[];

  @doc("Details of the Target Recovery Point")
  @visibility("read")
  targetRecoverPoint?: RestoreJobRecoveryPointDetails;

  @doc("A List, detailing the warnings related to the job")
  @visibility("read")
  warningDetails?: UserFacingWarningDetail[];
}

model RestoreJobRecoveryPointDetails {
  recoveryPointID?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;
}

@doc("Details of Job's Sub Task")
model JobSubTask {
  @doc("Additional details of Sub Tasks")
  additionalDetails?: Record<string>;

  @doc("Task Id of the Sub Task")
  taskId: int32;

  @doc("Name of the Sub Task")
  taskName: string;

  @doc("Progress of the Sub Task")
  @visibility("read")
  taskProgress?: string;

  @doc("Status of the Sub Task")
  taskStatus: string;
}

@doc("Warning object used by layers that have access to localized content, and propagate that to user")
model UserFacingWarningDetail {
  @doc("Name of resource for which warning is raised.")
  resourceName?: string;

  @doc("Error details for the warning.")
  warning: UserFacingError;
}

@doc("Details of Backup Vault for which CRR Jobs are to be fetched")
model CrossRegionRestoreJobsRequest {
  sourceRegion: string;
  sourceBackupVaultId: string;
}

@doc("Azure Backup Rehydrate Request")
model AzureBackupRehydrationRequest {
  @doc("Id of the recovery point to be recovered")
  recoveryPointId: string;

  @doc("Priority to be used for rehydration. Values High or Standard")
  rehydrationPriority?: RehydrationPriority;

  @doc("Retention duration in ISO 8601 format i.e P10D .")
  rehydrationRetentionDuration: duration;
}

@doc("Sync BackupInstance Request")
model SyncBackupInstanceRequest {
  @doc("Field indicating sync type e.g. to sync only in case of failure or in all cases")
  syncType?: SyncType;
}

@doc("Validate restore request object")
model ValidateRestoreRequestObject {
  @doc("Gets or sets the restore request object.")
  restoreRequestObject: AzureBackupRestoreRequest;
}

@doc("List Restore Ranges Request")
model AzureBackupFindRestorableTimeRangesRequest {
  @doc("Gets or sets the type of the source data store.")
  sourceDataStoreType: RestoreSourceDataStoreType;

  @doc("Start time for the List Restore Ranges request. ISO 8601 format.")
  startTime?: string;

  @doc("End time for the List Restore Ranges request. ISO 8601 format.")
  endTime?: string;
}

@doc("List Restore Ranges Response")
model AzureBackupFindRestorableTimeRangesResponseResource extends DppResource {
  @doc("AzureBackupFindRestorableTimeRangesResponseResource properties")
  properties?: AzureBackupFindRestorableTimeRangesResponse;
}

@doc("List Restore Ranges Response")
model AzureBackupFindRestorableTimeRangesResponse {
  @doc("Returns the Restore Ranges available on the Backup Instance.")
  restorableTimeRanges?: RestorableTimeRange[];

  objectType?: string;
}

model RestorableTimeRange {
  @doc("Start time for the available restore range")
  startTime: string;

  @doc("End time for the available restore range")
  endTime: string;

  objectType?: string;
}

@doc("Deleted Backup Instance")
model DeletedBackupInstance extends BackupInstance {
  @doc("Deletion info of Backup Instance")
  @visibility("read")
  deletionInfo?: DeletionInfo;
}

@doc("Deletion Info")
model DeletionInfo {
  @doc("Specifies time of deletion")
  @visibility("read")
  deletionTime?: string;

  @doc("Specifies billing end date")
  @visibility("read")
  billingEndDate?: string;

  @doc("Specifies purge time")
  @visibility("read")
  scheduledPurgeTime?: string;

  @doc("Delete activity ID for troubleshooting purpose")
  @visibility("read")
  deleteActivityID?: string;
}

@doc("ListResource")
model DppResourceList {
  @doc("The uri to fetch the next page of resources. Call ListNext() fetches next page of resources.")
  nextLink?: string;
}

model ResourceGuard {
  @doc("Provisioning state of the BackupVault resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("This flag indicates whether auto approval is allowed or not.")
  @visibility("read")
  allowAutoApprovals?: boolean;

  @doc("{readonly} List of operation details those are protected by the ResourceGuard resource")
  @visibility("read")
  resourceGuardOperations?: ResourceGuardOperation[];

  @doc("List of critical operations which are not protected by this resourceGuard")
  vaultCriticalOperationExclusionList?: string[];

  @doc("Description about the pre-req steps to perform all the critical operations.")
  @visibility("read")
  description?: string;
}

@doc("This class contains all the details about a critical operation.")
model ResourceGuardOperation {
  @doc("Name of the critical operation.")
  @visibility("read")
  vaultCriticalOperation?: string;

  @doc("Type of resource request.")
  @visibility("read")
  requestResourceType?: string;
}

@doc("Patch Request content for Microsoft.DataProtection Resource Guard resources")
model PatchResourceGuardInput {
  @doc("Resource Guard tags.")
  tags?: Record<string>;
}

@doc("Base for all lists of V2 resources.")
model DppBaseResourceList is Azure.Core.Page<ResourceGuardProtectedObjectData>;

@doc("Base resource under Microsoft.DataProtection provider namespace")
model ResourceGuardProtectedObjectData extends ResourceData {}

model ResourceData {
  @doc("Resource Id represents the complete path to the resource.")
  @visibility("read")
  id?: string;

  @doc("Resource name associated with the resource.")
  @visibility("read")
  name?: string;

  @doc("Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...")
  @visibility("read")
  type?: string;
}

@doc("ResourceGuardProxyBase object, used in ResourceGuardProxyBaseResource")
model ResourceGuardProxyBase {
  resourceGuardResourceId?: string;
  resourceGuardOperationDetails?: ResourceGuardOperationDetail[];
  lastUpdatedTime?: string;
  description?: string;
}

@doc("VaultCritical Operation protected by a resource guard")
model ResourceGuardOperationDetail {
  vaultCriticalOperation?: string;
  defaultResourceRequest?: string;
}

@doc("Request body of unlock delete API.")
model UnlockDeleteRequest {
  resourceGuardOperationRequests?: string[];
  resourceToBeDeleted?: string;
}

@doc("Response of Unlock Delete API.")
model UnlockDeleteResponse {
  @doc("This is the time when unlock delete privileges will get expired.")
  unlockDeleteExpiryTime?: string;
}

@doc("Delete option with duration")
model AbsoluteDeleteOption extends DeleteOption {
  @doc("Type of the specific object - used for deserializing")
  objectType: "AbsoluteDeleteOption";
}

@doc("Delete Option")
@discriminator("objectType")
model DeleteOption {
  @doc("Duration of deletion after given timespan")
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

@doc("Adhoc backup tagging criteria")
model AdhocBasedTaggingCriteria {
  @doc("Retention tag information")
  tagInfo?: RetentionTag;
}

@doc("Retention tag")
model RetentionTag {
  @doc("Retention Tag version.")
  @visibility("read")
  eTag?: string;

  @doc("Retention Tag version.")
  @visibility("read")
  id?: string;

  @doc("Retention Tag Name to relate it to retention rule.")
  tagName: string;
}

@doc("Adhoc trigger context")
model AdhocBasedTriggerContext extends TriggerContext {
  @doc("Tagging Criteria containing retention tag for adhoc backup.")
  taggingCriteria: AdhocBasedTaggingCriteria;

  @doc("Type of the specific object - used for deserializing")
  objectType: "AdhocBasedTriggerContext";
}

@doc("Trigger context")
@discriminator("objectType")
model TriggerContext {}

@doc("Azure backup discrete RecoveryPoint")
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

  @doc("Specifies recovery point completeness. Partial (i.e., only some of the intended items were backed up), or Completed (i.e., ALL intended items were backed up).")
  recoveryPointState?: RecoveryPointCompletionState;

  objectType: "AzureBackupDiscreteRecoveryPoint";
}

@doc("RecoveryPoint datastore details")
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

@doc("List Restore Ranges Request")
model AzureBackupFindRestorableTimeRangesRequestResource
  extends DppWorkerRequest {
  @doc("AzureBackupFindRestorableTimeRangesRequestResource content")
  content?: AzureBackupFindRestorableTimeRangesRequest;
}

model DppWorkerRequest {
  subscriptionId?: string;
  uri?: string;

  @doc("Dictionary of <components·ikn5y4·schemas·dppworkerrequest·properties·headers·additionalproperties>")
  headers?: Record<string[]>;

  supportedGroupVersions?: string[];
  cultureInfo?: string;

  @doc("Dictionary of <string>")
  parameters?: Record<string>;

  httpMethod?: string;
}

@doc("Azure backup parameters")
model AzureBackupParams extends BackupParameters {
  @doc("BackupType ; Full/Incremental etc")
  backupType: string;

  @doc("Type of the specific object - used for deserializing")
  objectType: "AzureBackupParams";
}

@doc("BackupParameters base")
@discriminator("objectType")
model BackupParameters {}

@doc("Azure backup recoveryPoint based restore request")
@discriminator("objectType")
model AzureBackupRecoveryPointBasedRestoreRequest
  extends AzureBackupRestoreRequest {
  recoveryPointId: string;
}

@doc("AzureBackup Restore with Rehydration Request")
model AzureBackupRestoreWithRehydrationRequest
  extends AzureBackupRecoveryPointBasedRestoreRequest {
  @doc("Priority to be used for rehydration. Values High or Standard")
  rehydrationPriority: RehydrationPriority;

  @doc("Retention duration in ISO 8601 format i.e P10D .")
  rehydrationRetentionDuration: duration;

  objectType: "AzureBackupRestoreWithRehydrationRequest";
}

@doc("AzureBackup RecoveryPointTime Based Restore Request")
model AzureBackupRecoveryTimeBasedRestoreRequest
  extends AzureBackupRestoreRequest {
  @doc("The recovery time in ISO 8601 format example - 2020-08-14T17:30:00.0000000Z.")
  recoveryPointTime: string;

  objectType: "AzureBackupRecoveryTimeBasedRestoreRequest";
}

@doc("Azure backup rule")
model AzureBackupRule extends BasePolicyRule {
  @doc("BackupParameters base")
  backupParameters?: BackupParameters;

  @doc("DataStoreInfo base")
  dataStore: DataStoreInfoBase;

  @doc("Trigger context")
  trigger: TriggerContext;

  objectType: "AzureBackupRule";
}

@doc("DataStoreInfo base")
model DataStoreInfoBase {
  @doc("type of datastore; Operational/Vault/Archive")
  dataStoreType: DataStoreTypes;

  @doc("Type of Datasource object, used to initialize the right inherited type")
  objectType: string;
}

@doc("BasePolicy Rule")
@discriminator("objectType")
model BasePolicyRule {
  name: string;
}

@doc("Parameters for Operational-Tier DataStore")
model AzureOperationalStoreParameters extends DataStoreParameters {
  @doc("Gets or sets the Snapshot Resource Group Uri.")
  resourceGroupId?: string;

  @doc("Type of the specific object - used for deserializing")
  objectType: "AzureOperationalStoreParameters";
}

@doc("Parameters for Kubernetes Cluster Backup Datasource")
model KubernetesClusterBackupDatasourceParameters
  extends BackupDatasourceParameters {
  @doc("Gets or sets the volume snapshot property. This property if enabled will take volume snapshots during backup.")
  snapshotVolumes: boolean;

  @doc("Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during backup.")
  includeClusterScopeResources: boolean;

  @doc("Gets or sets the include namespaces property. This property sets the namespaces to be included during backup.")
  includedNamespaces?: string[];

  @doc("Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during backup.")
  excludedNamespaces?: string[];

  @doc("Gets or sets the include resource types property. This property sets the resource types to be included during backup.")
  includedResourceTypes?: string[];

  @doc("Gets or sets the exclude resource types property. This property sets the resource types to be excluded during backup.")
  excludedResourceTypes?: string[];

  @doc("Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during backup.")
  labelSelectors?: string[];

  @doc("Gets or sets the backup hook references. This property sets the hook reference to be executed during backup.")
  backupHookReferences?: NamespacedNameResource[];

  @doc("Type of the specific object - used for deserializing")
  objectType: "KubernetesClusterBackupDatasourceParameters";
}

@doc("Class to refer resources which contains namespace and name")
model NamespacedNameResource {
  @doc("Name of the resource")
  name?: string;

  @doc("Namespace in which the resource exists")
  `namespace`?: string;
}

@doc("Parameters to be used during configuration of backup of blobs")
model BlobBackupDatasourceParameters extends BackupDatasourceParameters {
  @doc("List of containers to be backed up during configuration of backup of blobs")
  containersList: string[];

  @doc("Type of the specific object - used for deserializing")
  objectType: "BlobBackupDatasourceParameters";
}

@doc("Azure retention rule")
model AzureRetentionRule extends BasePolicyRule {
  isDefault?: boolean;
  lifecycles: SourceLifeCycle[];
  objectType: "AzureRetentionRule";
}

@doc("Source LifeCycle")
model SourceLifeCycle {
  @doc("Delete Option")
  deleteAfter: DeleteOption;

  @doc("DataStoreInfo base")
  sourceDataStore: DataStoreInfoBase;

  targetDataStoreCopySettings?: TargetCopySetting[];
}

@doc("Target copy settings")
model TargetCopySetting {
  @doc("It can be CustomCopyOption or ImmediateCopyOption.")
  copyAfter: CopyOption;

  @doc("Info of target datastore")
  dataStore: DataStoreInfoBase;
}

@doc("Options to copy")
@discriminator("objectType")
model CopyOption {}

@doc("BackupCriteria base class")
@discriminator("objectType")
model BackupCriteria {}

@doc("Rule based backup policy")
model BackupPolicy extends BaseBackupPolicy {
  @doc("Policy rule dictionary that contains rules for each backuptype i.e Full/Incremental/Logs etc")
  policyRules: BasePolicyRule[];

  objectType: "BackupPolicy";
}

@doc("Schedule for backup")
model BackupSchedule {
  @doc("ISO 8601 repeating time interval format")
  repeatingTimeIntervals: string[];

  @doc("Time zone for a schedule. Example: Pacific Standard Time")
  timeZone?: string;
}

@doc("Localized display information of an operation.")
model ClientDiscoveryDisplay {
  @doc("Description of the operation having details of what operation is about.")
  description?: string;

  @doc("Operations Name itself.")
  operation?: string;

  @doc("Name of the provider for display purposes")
  provider?: string;

  @doc("ResourceType for which this Operation can be performed.")
  resource?: string;
}

@doc("Class to represent shoebox log specification in json client discovery.")
model ClientDiscoveryForLogSpecification {
  @doc("blob duration of shoebox log specification")
  blobDuration?: duration;

  @doc("Localized display name")
  displayName?: string;

  @doc("Name for shoebox log specification.")
  name?: string;
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

@doc("Operations List response which contains list of available APIs.")
model ClientDiscoveryResponse {
  @doc("Link to the next chunk of Response.")
  nextLink?: string;

  @doc("List of available operations.")
  value?: ClientDiscoveryValueForSingleApi[];
}

@doc("Available operation details.")
model ClientDiscoveryValueForSingleApi {
  @doc("Contains the localized display information for this particular operation")
  display?: ClientDiscoveryDisplay;

  @doc("Name of the Operation.")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("The intended executor of the operation;governs the display of the operation in the RBAC UX and the audit logs UX")
  origin?: string;

  @doc("Properties for the given operation.")
  properties?: ClientDiscoveryForProperties;
}

@doc("Copy on Expiry Option")
model CopyOnExpiryOption extends CopyOption {
  @doc("Type of the specific object - used for deserializing")
  objectType: "CopyOnExpiryOption";
}

@doc("Duration based custom options to copy")
model CustomCopyOption extends CopyOption {
  @doc("Data copied after given timespan")
  duration?: duration;

  @doc("Type of the specific object - used for deserializing")
  objectType: "CustomCopyOption";
}

@doc("Day of the week")
model Day {
  @doc("Date of the month")
  date?: int32;

  @doc("Whether Date is last date of month")
  isLast?: boolean;
}

@doc("Default source properties")
model DefaultResourceProperties extends BaseResourceProperties {
  @doc("Type of the specific object - used for deserializing")
  objectType: "DefaultResourceProperties";
}

model DppTrackedResourceList {
  @doc("The uri to fetch the next page of resources. Call ListNext() fetches next page of resources.")
  nextLink?: string;
}

@doc("The result for export jobs containing blob details.")
model ExportJobsResult {
  @doc("URL of the blob into which the serialized string of list of jobs is exported.")
  @visibility("read")
  blobUrl?: string;

  @doc("SAS key to access the blob.")
  @visibility("read")
  blobSasKey?: string;

  @doc("URL of the blob into which the ExcelFile is uploaded.")
  @visibility("read")
  excelFileBlobUrl?: string;

  @doc("SAS key to access the ExcelFile blob.")
  @visibility("read")
  excelFileBlobSasKey?: string;
}

@doc("Base class for feature object")
model FeatureValidationRequest extends FeatureValidationRequestBase {
  @doc("backup support feature type.")
  featureType?: FeatureType;

  @doc("backup support feature name.")
  featureName?: string;

  @doc("Type of the specific object - used for deserializing")
  objectType: "FeatureValidationRequest";
}

@doc("Feature Validation Response")
model FeatureValidationResponse extends FeatureValidationResponseBase {
  @doc("backup support feature type.")
  featureType?: FeatureType;

  @doc("Response features")
  features?: SupportedFeature[];

  @doc("Type of the specific object - used for deserializing")
  objectType: "FeatureValidationResponse";
}

@doc("Elements class for feature request")
model SupportedFeature {
  @doc("support feature type.")
  featureName?: string;

  @doc("feature support status")
  supportStatus?: FeatureSupportStatus;

  @doc("support feature type.")
  exposureControlledFeatures?: string[];
}

@doc("Immediate copy Option")
model ImmediateCopyOption extends CopyOption {
  @doc("Type of the specific object - used for deserializing")
  objectType: "ImmediateCopyOption";
}

@doc("Class to contain criteria for item level restore")
@discriminator("objectType")
model ItemLevelRestoreCriteria {}

@doc("Restore target info for Item level restore operation")
model ItemLevelRestoreTargetInfo extends RestoreTargetInfoBase {
  @doc("Restore Criteria")
  restoreCriteria: ItemLevelRestoreCriteria[];

  @doc("Information of target DS")
  datasourceInfo: Datasource;

  @doc("Information of target DS Set")
  datasourceSetInfo?: DatasourceSet;

  @doc("Credentials to use to authenticate with data source provider.")
  datasourceAuthCredentials?: AuthCredentials;

  @doc("Type of Datasource object, used to initialize the right inherited type")
  objectType: "ItemLevelRestoreTargetInfo";
}

@doc("Prefix criteria to be used to during restore")
model ItemPathBasedRestoreCriteria extends ItemLevelRestoreCriteria {
  @doc("The path of the item to be restored. It could be the full path of the item or the path relative to the backup item")
  itemPath: string;

  @doc("Flag to specify if the path is relative to backup item or full path")
  isPathRelativeToBackupItem: boolean;

  @doc("The list of prefix strings to be used as filter criteria during restore. These are relative to the item path specified.")
  subItemPathPrefix?: string[];

  @doc("Type of the specific object - used for deserializing")
  objectType: "ItemPathBasedRestoreCriteria";
}

@doc("Operation Resource")
model OperationResource {
  @doc("End time of the operation")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("""
Required if status == failed or status == canceled. This is the OData v4 error format, used by the RPC and will go into the v2.2 Azure REST API guidelines.
The full set of optional properties (e.g. inner errors / details) can be found in the \"Error Response\" section.
""")
  error?: Error;

  @doc("It should match what is used to GET the operation result")
  id?: string;

  @doc("It must match the last segment of the \"id\" field, and will typically be a GUID / system generated value")
  name?: string;

  @doc("End time of the operation")
  properties?: OperationExtendedInfo;

  @doc("Start time of the operation")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  status?: string;
}

@doc("Item Level target info for restore operation")
model RangeBasedItemLevelRestoreCriteria extends ItemLevelRestoreCriteria {
  @doc("minimum value for range prefix match")
  minMatchingValue?: string;

  @doc("maximum value for range prefix match")
  maxMatchingValue?: string;

  @doc("Type of the specific object - used for deserializing")
  objectType: "RangeBasedItemLevelRestoreCriteria";
}

@doc("Item Level kubernetes storage class target info for restore operation")
model KubernetesStorageClassRestoreCriteria extends ItemLevelRestoreCriteria {
  @doc("Selected storage class name")
  selectedStorageClassName?: string;

  @doc("Provisioner of the storage class")
  provisioner?: string;

  @doc("Type of the specific object - used for deserializing")
  objectType: "KubernetesStorageClassRestoreCriteria";
}

@doc("Item Level kubernetes persistent volume target info for restore operation")
model KubernetesPVRestoreCriteria extends ItemLevelRestoreCriteria {
  @doc("Selected persistent volume claim name")
  name?: string;

  @doc("Selected storage class name for restore operation")
  storageClassName?: string;

  @doc("Type of the specific object - used for deserializing")
  objectType: "KubernetesPVRestoreCriteria";
}

@doc("kubernetes Cluster Backup target info for restore operation")
model KubernetesClusterRestoreCriteria extends ItemLevelRestoreCriteria {
  @doc("Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during restore.")
  includeClusterScopeResources: boolean;

  @doc("Gets or sets the include namespaces property. This property sets the namespaces to be included during restore.")
  includedNamespaces?: string[];

  @doc("Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during restore.")
  excludedNamespaces?: string[];

  @doc("Gets or sets the include resource types property. This property sets the resource types to be included during restore.")
  includedResourceTypes?: string[];

  @doc("Gets or sets the exclude resource types property. This property sets the resource types to be excluded during restore.")
  excludedResourceTypes?: string[];

  @doc("Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during restore.")
  labelSelectors?: string[];

  @doc("Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored.")
  persistentVolumeRestoreMode?: PersistentVolumeRestoreMode;

  @doc("Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore.")
  conflictPolicy?: ExistingResourcePolicy;

  @doc("Gets or sets the Namespace Mappings property. This property sets if namespace needs to be change during restore.")
  namespaceMappings?: Record<string>;

  @doc("Gets or sets the restore hook references. This property sets the hook reference to be executed during restore.")
  restoreHookReferences?: NamespacedNameResource[];

  @doc("Type of the specific object - used for deserializing")
  objectType: "KubernetesClusterRestoreCriteria";
}

@doc("kubernetes Cluster Backup target info for restore operation from vault")
model KubernetesClusterVaultTierRestoreCriteria
  extends ItemLevelRestoreCriteria {
  @doc("Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during restore from vault.")
  includeClusterScopeResources: boolean;

  @doc("Gets or sets the include namespaces property. This property sets the namespaces to be included during restore from vault.")
  includedNamespaces?: string[];

  @doc("Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during restore from vault.")
  excludedNamespaces?: string[];

  @doc("Gets or sets the include resource types property. This property sets the resource types to be included during restore from vault.")
  includedResourceTypes?: string[];

  @doc("Gets or sets the exclude resource types property. This property sets the resource types to be excluded during restore from vault.")
  excludedResourceTypes?: string[];

  @doc("Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during restore from vault.")
  labelSelectors?: string[];

  @doc("Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored from vault.")
  persistentVolumeRestoreMode?: PersistentVolumeRestoreMode;

  @doc("Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore from vault.")
  conflictPolicy?: ExistingResourcePolicy;

  @doc("Gets or sets the Namespace Mappings property. This property sets if namespace needs to be change during restore from vault.")
  namespaceMappings?: Record<string>;

  @doc("Gets or sets the restore hook references. This property sets the hook reference to be executed during restore from vault.")
  restoreHookReferences?: NamespacedNameResource[];

  @doc("Gets or sets the staging RG Id for creating staging disks and snapshots during restore from vault.")
  stagingResourceGroupId?: ResourceIdentifier;

  @doc("Gets or sets the staging Storage Account Id for creating backup extension object store data during restore from vault.")
  stagingStorageAccountId?: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("Type of the specific object - used for deserializing")
  objectType: "KubernetesClusterVaultTierRestoreCriteria";
}

@doc("Class encapsulating restore as files target parameters")
model RestoreFilesTargetInfo extends RestoreTargetInfoBase {
  @doc("Destination of RestoreAsFiles operation, when destination is not a datasource")
  targetDetails: TargetDetails;

  @doc("Type of Datasource object, used to initialize the right inherited type")
  objectType: "RestoreFilesTargetInfo";
}

@doc("Class encapsulating target details, used where the destination is not a datasource")
model TargetDetails {
  @doc("""
Restore operation may create multiple files inside location pointed by Url
Below will be the common prefix for all of them
""")
  filePrefix: string;

  @doc("""
Denotes the target location where the data will be restored,
string value for the enum {Microsoft.Internal.AzureBackup.DataProtection.Common.Interface.RestoreTargetLocationType}
""")
  restoreTargetLocationType: RestoreTargetLocationType;

  @doc("Url denoting the restore destination. It can point to container / file share etc")
  url: string;

  @doc("""
Full ARM Id denoting the restore destination. It is the ARM Id pointing to container / file share
This is optional if the target subscription can be identified with the URL field. If not
then this is needed if CrossSubscriptionRestore field of BackupVault is in any of the disabled states
""")
  targetResourceArmId?: string;
}

@doc("Class encapsulating restore target parameters")
model RestoreTargetInfo extends RestoreTargetInfoBase {
  @doc("Information of target DS")
  datasourceInfo: Datasource;

  @doc("Information of target DS Set")
  datasourceSetInfo?: DatasourceSet;

  @doc("Credentials to use to authenticate with data source provider.")
  datasourceAuthCredentials?: AuthCredentials;

  @doc("Type of Datasource object, used to initialize the right inherited type")
  objectType: "RestoreTargetInfo";
}

@doc("Schedule based backup criteria")
model ScheduleBasedBackupCriteria extends BackupCriteria {
  @doc("""
it contains absolute values like \"AllBackup\" / \"FirstOfDay\" / \"FirstOfWeek\" / \"FirstOfMonth\"
and should be part of AbsoluteMarker enum
""")
  absoluteCriteria?: AbsoluteMarker[];

  @doc("This is day of the month from 1 to 28 other wise last of month")
  daysOfMonth?: Day[];

  @doc("It should be Sunday/Monday/T..../Saturday")
  daysOfTheWeek?: DayOfWeek[];

  @doc("It should be January/February/....../December")
  monthsOfYear?: Month[];

  @doc("List of schedule times for backup")
  scheduleTimes?: utcDateTime[];

  @doc("It should be First/Second/Third/Fourth/Last")
  weeksOfTheMonth?: WeekNumber[];

  @doc("Type of the specific object - used for deserializing")
  objectType: "ScheduleBasedBackupCriteria";
}

@doc("Schedule based trigger context")
model ScheduleBasedTriggerContext extends TriggerContext {
  @doc("Schedule for this backup")
  schedule: BackupSchedule;

  @doc("List of tags that can be applicable for given schedule.")
  taggingCriteria: TaggingCriteria[];

  @doc("Type of the specific object - used for deserializing")
  objectType: "ScheduleBasedTriggerContext";
}

@doc("Tagging criteria")
model TaggingCriteria {
  @doc("Criteria which decides whether the tag can be applied to a triggered backup.")
  criteria?: BackupCriteria[];

  @doc("Specifies if tag is default.")
  isDefault: boolean;

  @doc("Retention Tag priority.")
  taggingPriority: int32;

  @doc("Retention tag information")
  tagInfo: RetentionTag;
}

@doc("Secret store based authentication credentials.")
model SecretStoreBasedAuthCredentials extends AuthCredentials {
  @doc("Secret store resource")
  secretStoreResource?: SecretStoreResource;

  @doc("Type of the specific object - used for deserializing")
  objectType: "SecretStoreBasedAuthCredentials";
}

@doc("Class representing a secret store resource.")
model SecretStoreResource {
  @doc("Uri to get to the resource")
  uri?: string;

  @doc("Gets or sets the type of secret store")
  secretStoreType: SecretStoreType;

  @doc("Gets or sets value stored in secret store resource")
  value?: string;
}
