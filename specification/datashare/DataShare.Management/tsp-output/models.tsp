import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataShare;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Identity Type
 */
enum ServiceIdentityType {
  SystemAssigned,
}

/**
 * Provisioning state of the Account
 */
enum ProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Moving,
  Failed,
}

/**
 * The type of identity that last modified the resource.
 */
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * Operation state of the long running operation.
 */
enum Status {
  Accepted,
  InProgress,
  TransientFailure,
  Succeeded,
  Failed,
  Canceled,
}

/**
 * The status of the invitation.
 */
enum InvitationStatus {
  Pending,
  Accepted,
  Rejected,
  Withdrawn,
}

/**
 * Kind of data set.
 */
enum DataSetKind {
  Blob,
  Container,
  BlobFolder,
  AdlsGen2FileSystem,
  AdlsGen2Folder,
  AdlsGen2File,
  AdlsGen1Folder,
  AdlsGen1File,
  KustoCluster,
  KustoDatabase,
  KustoTable,
  SqlDBTable,
  SqlDWTable,
  SynapseWorkspaceSqlPoolTable,
}

/**
 * Kind of data set mapping.
 */
enum DataSetMappingKind {
  Blob,
  Container,
  BlobFolder,
  AdlsGen2FileSystem,
  AdlsGen2Folder,
  AdlsGen2File,
  KustoCluster,
  KustoDatabase,
  KustoTable,
  SqlDBTable,
  SqlDWTable,
  SynapseWorkspaceSqlPoolTable,
}

/**
 * Registration status
 */
enum RegistrationStatus {
  ActivationPending,
  Activated,
  ActivationAttemptsExhausted,
}

/**
 * Synchronization mode
 */
enum SynchronizationMode {
  Incremental,
  FullSync,
}

/**
 * Type of data set
 */
enum DataSetType {
  Blob,
  Container,
  BlobFolder,
  AdlsGen2FileSystem,
  AdlsGen2Folder,
  AdlsGen2File,
  AdlsGen1Folder,
  AdlsGen1File,
  KustoCluster,
  KustoDatabase,
  KustoTable,
  SqlDBTable,
  SqlDWTable,
  SynapseWorkspaceSqlPoolTable,
}

/**
 * Gets the status of share subscription
 */
enum ShareSubscriptionStatus {
  Active,
  Revoked,
  SourceDeleted,
  Revoking,
}

/**
 * Share kind.
 */
enum ShareKind {
  CopyBased,
  InPlace,
}

/**
 * Kind of synchronization setting on share.
 */
enum SourceShareSynchronizationSettingKind {
  ScheduleBased,
}

/**
 * Kind of synchronization setting.
 */
enum SynchronizationSettingKind {
  ScheduleBased,
}

/**
 * Kind of synchronization on trigger.
 */
enum TriggerKind {
  ScheduleBased,
}

/**
 * Gets the status of the data set mapping.
 */
enum DataSetMappingStatus {
  Ok,
  Broken,
}

/**
 * Type of output file
 */
enum OutputType {
  Csv,
  Parquet,
}

/**
 * Recurrence Interval
 */
enum RecurrenceInterval {
  Hour,
  Day,
}

/**
 * Gets the trigger state
 */
enum TriggerStatus {
  Active,
  Inactive,
  SourceSynchronizationSettingDeleted,
}

/**
 * Identity of resource
 */
model Identity {
  /**
   * service principal Id
   */
  @visibility("read")
  principalId?: string;

  /**
   * Tenant Id
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Identity Type
   */
  type?: ServiceIdentityType;
}

/**
 * Account property bag.
 */
model AccountProperties {
  /**
   * Time at which the account was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Provisioning state of the Account
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Email of the user who created the resource
   */
  @visibility("read")
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility("read")
  userName?: string;
}

/**
 * Base data transfer object implementation for default resources.
 */
model DefaultDto extends ProxyDto {
  /**
   * Location of the azure resource.
   */
  location?: string;

  /**
   * Tags on the azure resource.
   */
  tags?: Record<string>;
}

/**
 * Base data transfer object implementation for proxy resources.
 */
model ProxyDto {
  /**
   * The resource id of the azure resource
   */
  @visibility("read")
  id?: string;

  /**
   * Name of the azure resource
   */
  @visibility("read")
  name?: string;

  /**
   * System Data of the Azure resource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * Type of the azure resource
   */
  @visibility("read")
  type?: string;
}

/**
 * The data share error model.
 */
@error
model DataShareError {
  /**
   * The data share error body
   */
  error: DataShareErrorInfo;
}

/**
 * The data share error body model.
 */
model DataShareErrorInfo {
  /**
   * Code of the error
   */
  code: string;

  /**
   * Nested details of the error model
   */
  details?: DataShareErrorInfo[];

  /**
   * Message of the error
   */
  message: string;

  /**
   * Target of the error
   */
  target?: string;
}

/**
 * Response for long running operation
 */
model OperationResponse {
  /**
   * start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The error property when status is failed.
   */
  error?: DataShareErrorInfo;

  /**
   * start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Operation state of the long running operation.
   */
  status: Status;
}

/**
 * Update parameters for accounts
 */
model AccountUpdateParameters {
  /**
   * Tags on the azure resource.
   */
  tags?: Record<string>;
}

/**
 * Properties of consumer invitation
 */
model ConsumerInvitationProperties {
  /**
   * Number of data sets in a share
   */
  @visibility("read")
  dataSetCount?: int32;

  /**
   * Description shared when the invitation was created
   */
  @visibility("read")
  description?: string;

  /**
   * The expiration date for the share subscription created by accepting the invitation.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Unique id of the invitation.
   */
  invitationId: string;

  /**
   * The status of the invitation.
   */
  @visibility("read")
  invitationStatus?: InvitationStatus;

  /**
   * invitation location
   */
  @visibility("read")
  location?: string;

  /**
   * Email of the provider who created the resource
   */
  @visibility("read")
  providerEmail?: string;

  /**
   * Name of the provider who created the resource
   */
  @visibility("read")
  providerName?: string;

  /**
   * Tenant name of the provider who created the resource
   */
  @visibility("read")
  providerTenantName?: string;

  /**
   * The time the recipient responded to the invitation.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  respondedAt?: utcDateTime;

  /**
   * Gets the time at which the invitation was sent.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sentAt?: utcDateTime;

  /**
   * Gets the source share Name.
   */
  @visibility("read")
  shareName?: string;

  /**
   * Terms of use shared when the invitation was created
   */
  @visibility("read")
  termsOfUse?: string;

  /**
   * Email of the user who created the resource
   */
  @visibility("read")
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility("read")
  userName?: string;
}

/**
 * Dto for tenant domain registration
 */
model EmailRegistration {
  /**
   * Activation code for the registration
   */
  activationCode?: string;

  /**
   * Date of the activation expiration
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activationExpirationDate?: utcDateTime;

  /**
   * The email to register
   */
  @visibility("read")
  email?: string;

  /**
   * Registration status
   */
  @visibility("read")
  registrationStatus?: RegistrationStatus;

  /**
   * The tenant to register
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * Invitation property bag.
 */
model InvitationProperties {
  /**
   * The expiration date for the invitation and share subscription.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * unique invitation id
   */
  @visibility("read")
  invitationId?: string;

  /**
   * The status of the invitation.
   */
  @visibility("read")
  invitationStatus?: InvitationStatus;

  /**
   * The time the recipient responded to the invitation.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  respondedAt?: utcDateTime;

  /**
   * Gets the time at which the invitation was sent.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sentAt?: utcDateTime;

  /**
   * The target Azure AD Id. Can't be combined with email.
   */
  targetActiveDirectoryId?: string;

  /**
   * The email the invitation is directed to.
   */
  targetEmail?: string;

  /**
* The target user or application Id that invitation is being sent to.
Must be specified along TargetActiveDirectoryId. This enables sending
invitations to specific users or applications in an AD tenant.
*/
  targetObjectId?: string;

  /**
   * Email of the user who created the resource
   */
  @visibility("read")
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility("read")
  userName?: string;
}

/**
 * The response model for get operations
 */
model OperationModel {
  /**
   * Properties on the operation
   */
  display?: OperationModelProperties;

  /**
   * Operation name for display purposes
   */
  name?: string;

  /**
   * origin of the operation
   */
  origin?: string;

  /**
   * properties for the operation meta info
   */
  properties?: OperationMetaPropertyInfo;
}

/**
 * Properties on operations
 */
model OperationModelProperties {
  /**
   * Description of the operation for display purposes
   */
  description?: string;

  /**
   * Name of the operation for display purposes
   */
  operation?: string;

  /**
   * Name of the provider for display purposes
   */
  provider?: string;

  /**
   * Name of the resource type for display purposes
   */
  resource?: string;
}

/**
 * properties on meta info
 */
model OperationMetaPropertyInfo {
  /**
   * meta service specification
   */
  serviceSpecification?: OperationMetaServiceSpecification;
}

/**
 * The operation meta service specification
 */
model OperationMetaServiceSpecification {
  /**
   * log specifications for the operation
   */
  logSpecifications?: OperationMetaLogSpecification[];

  /**
   * metric specifications for the operation
   */
  metricSpecifications?: OperationMetaMetricSpecification[];
}

/**
 * log specifications for operation api
 */
model OperationMetaLogSpecification {
  /**
   * blob duration of the log
   */
  blobDuration?: string;

  /**
   * localized name of the log category
   */
  displayName?: string;

  /**
   * name of the log category
   */
  name?: string;
}

/**
 * metric specifications for the operation
 */
model OperationMetaMetricSpecification {
  /**
   * aggregation type of metric
   */
  aggregationType?: string;

  /**
   * properties for dimension
   */
  dimensions?: DimensionProperties[];

  /**
   * description of the metric
   */
  displayDescription?: string;

  /**
   * localized name of the metric
   */
  displayName?: string;

  /**
   * enable regional mdm account
   */
  enableRegionalMdmAccount?: string;

  /**
   * fill gap with zero
   */
  fillGapWithZero?: boolean;

  /**
   * internal metric name
   */
  internalMetricName?: string;

  /**
   * name of the metric
   */
  name?: string;

  /**
   * dimension name use to replace resource id if specified
   */
  resourceIdDimensionNameOverride?: string;

  /**
   * supported aggregation types
   */
  supportedAggregationTypes?: string[];

  /**
   * supported time grain types
   */
  supportedTimeGrainTypes?: string[];

  /**
   * units for the metric
   */
  unit?: string;
}

/**
 * properties for dimension
 */
model DimensionProperties {
  /**
   * localized display name of the dimension to customer
   */
  displayName?: string;

  /**
   * dimension name
   */
  name?: string;
}

/**
 * A ShareSynchronization data transfer object.
 */
model ShareSynchronization {
  /**
   * Email of the user who created the synchronization
   */
  consumerEmail?: string;

  /**
   * Name of the user who created the synchronization
   */
  consumerName?: string;

  /**
   * Tenant name of the consumer who created the synchronization
   */
  consumerTenantName?: string;

  /**
   * synchronization duration
   */
  durationMs?: int32;

  /**
   * End time of synchronization
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * message of synchronization
   */
  message?: string;

  /**
   * start time of synchronization
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Raw Status
   */
  status?: string;

  /**
   * Synchronization id
   */
  synchronizationId?: string;

  /**
   * Synchronization mode
   */
  @visibility("read")
  synchronizationMode?: SynchronizationMode;
}

/**
 * details of synchronization
 */
model SynchronizationDetailsList is Azure.Core.Page<SynchronizationDetails>;

/**
 * Synchronization details at data set level
 */
model SynchronizationDetails {
  /**
   * Id of data set
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Type of the data set
   */
  @visibility("read")
  dataSetType?: DataSetType;

  /**
   * Duration of data set level copy
   */
  @visibility("read")
  durationMs?: int32;

  /**
   * End time of data set level copy
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The number of files read from the source data set
   */
  @visibility("read")
  filesRead?: int64;

  /**
   * The number of files written into the sink data set
   */
  @visibility("read")
  filesWritten?: int64;

  /**
   * Error message if any
   */
  @visibility("read")
  message?: string;

  /**
   * Name of the data set
   */
  @visibility("read")
  name?: string;

  /**
   * The number of files copied into the sink data set
   */
  @visibility("read")
  rowsCopied?: int64;

  /**
   * The number of rows read from the source data set.
   */
  @visibility("read")
  rowsRead?: int64;

  /**
   * The size of the data read from the source data set in bytes
   */
  @visibility("read")
  sizeRead?: int64;

  /**
   * The size of the data written into the sink data set in bytes
   */
  @visibility("read")
  sizeWritten?: int64;

  /**
   * Start time of data set level copy
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Raw Status
   */
  @visibility("read")
  status?: string;

  /**
   * The vCore units consumed for the data set synchronization
   */
  @visibility("read")
  vCore?: int64;
}

/**
 * List response for get ShareSynchronization.
 */
model ShareSynchronizationList is Azure.Core.Page<ShareSynchronization>;

/**
 * Provider share subscription properties
 */
model ProviderShareSubscriptionProperties {
  /**
   * Email of the consumer who created the share subscription
   */
  @visibility("read")
  consumerEmail?: string;

  /**
   * Name of the consumer who created the share subscription
   */
  @visibility("read")
  consumerName?: string;

  /**
   * Tenant name of the consumer who created the share subscription
   */
  @visibility("read")
  consumerTenantName?: string;

  /**
   * created at
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Expiration date of the share subscription in UTC format
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Email of the provider who created the share
   */
  @visibility("read")
  providerEmail?: string;

  /**
   * Name of the provider who created the share
   */
  @visibility("read")
  providerName?: string;

  /**
   * Shared at
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sharedAt?: utcDateTime;

  /**
   * share Subscription Object Id
   */
  @visibility("read")
  shareSubscriptionObjectId?: string;

  /**
   * Gets the status of share subscription
   */
  @visibility("read")
  shareSubscriptionStatus?: ShareSubscriptionStatus;
}

/**
 * Share property bag.
 */
model ShareProperties {
  /**
   * Time at which the share was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Share description.
   */
  description?: string;

  /**
   * Gets or sets the provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Share kind.
   */
  shareKind?: ShareKind;

  /**
   * Share terms.
   */
  terms?: string;

  /**
   * Email of the user who created the resource
   */
  @visibility("read")
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility("read")
  userName?: string;
}

/**
 * A ShareSubscriptionSynchronization data transfer object.
 */
model ShareSubscriptionSynchronization {
  /**
   * Synchronization duration
   */
  @visibility("read")
  durationMs?: int32;

  /**
   * End time of synchronization
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * message of Synchronization
   */
  @visibility("read")
  message?: string;

  /**
   * start time of synchronization
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Raw Status
   */
  @visibility("read")
  status?: string;

  /**
   * Synchronization id
   */
  synchronizationId: string;

  /**
   * Synchronization Mode
   */
  @visibility("read")
  synchronizationMode?: SynchronizationMode;
}

/**
 * A consumer side list of source dataSets
 */
model ConsumerSourceDataSetList is Azure.Core.Page<ConsumerSourceDataSet>;

/**
 * A consumer side dataSet data transfer object.
 */
model ConsumerSourceDataSet extends ProxyDto {
  /**
   * source dataSet properties
   */
  properties?: ConsumerSourceDataSetProperties;
}

/**
 * Properties of consumer source dataSet
 */
model ConsumerSourceDataSetProperties {
  /**
   * DataSet Id
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Location of the data set.
   */
  @visibility("read")
  dataSetLocation?: string;

  /**
   * DataSet name
   */
  @visibility("read")
  dataSetName?: string;

  /**
   * DataSet path
   */
  @visibility("read")
  dataSetPath?: string;

  /**
   * Type of data set
   */
  @visibility("read")
  dataSetType?: DataSetType;
}

/**
 * List response for get source share Synchronization settings
 */
model SourceShareSynchronizationSettingList
  is Azure.Core.Page<SourceShareSynchronizationSetting>;

/**
 * A view of synchronization setting added by the provider
 */
@discriminator("kind")
model SourceShareSynchronizationSetting {}

/**
 * A consumer side list of share subscription synchronizations
 */
model ShareSubscriptionSynchronizationList
  is Azure.Core.Page<ShareSubscriptionSynchronization>;

/**
 * Payload for the synchronizing the data.
 */
model Synchronize {
  /**
   * Mode of synchronization used in triggers and snapshot sync. Incremental by default
   */
  synchronizationMode?: SynchronizationMode;
}

/**
 * Share subscription property bag.
 */
model ShareSubscriptionProperties {
  /**
   * Time at which the share subscription was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The expiration date of the share subscription.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * The invitation id.
   */
  invitationId: string;

  /**
   * Email of the provider who created the resource
   */
  @visibility("read")
  providerEmail?: string;

  /**
   * Name of the provider who created the resource
   */
  @visibility("read")
  providerName?: string;

  /**
   * Tenant name of the provider who created the resource
   */
  @visibility("read")
  providerTenantName?: string;

  /**
   * Provisioning state of the share subscription
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Description of share
   */
  @visibility("read")
  shareDescription?: string;

  /**
   * Kind of share
   */
  @visibility("read")
  shareKind?: ShareKind;

  /**
   * Name of the share
   */
  @visibility("read")
  shareName?: string;

  /**
   * Gets the current status of share subscription.
   */
  @visibility("read")
  shareSubscriptionStatus?: ShareSubscriptionStatus;

  /**
   * Terms of a share
   */
  @visibility("read")
  shareTerms?: string;

  /**
   * Source share location.
   */
  sourceShareLocation: string;

  /**
   * Email of the user who created the resource
   */
  @visibility("read")
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility("read")
  userName?: string;
}

/**
 * An ADLS Gen 1 file data set.
 */
model AdlsGen1FileDataSet extends DataSet {
  /**
   * ADLS Gen 1 file data set properties.
   */
  properties: AdlsGen1FileProperties;

  /**
   * Kind of data set.
   */
  kind: "AdlsGen1File";
}

/**
 * Properties of the ADLS Gen1 file data set.
 */
model AdlsGen1FileProperties {
  /**
   * The ADLS account name.
   */
  accountName: string;

  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * The file name in the ADLS account.
   */
  fileName: string;

  /**
   * The folder path within the ADLS account.
   */
  folderPath: string;

  /**
   * Resource group of ADLS account.
   */
  resourceGroup: string;

  /**
   * Subscription id of ADLS account.
   */
  subscriptionId: string;
}

/**
 * An ADLS Gen 1 folder data set.
 */
model AdlsGen1FolderDataSet extends DataSet {
  /**
   * ADLS Gen 1 folder data set properties.
   */
  properties: AdlsGen1FolderProperties;

  /**
   * Kind of data set.
   */
  kind: "AdlsGen1Folder";
}

/**
 * Properties of the ADLS Gen1 folder data set.
 */
model AdlsGen1FolderProperties {
  /**
   * The ADLS account name.
   */
  accountName: string;

  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * The folder path within the ADLS account.
   */
  folderPath: string;

  /**
   * Resource group of ADLS account.
   */
  resourceGroup: string;

  /**
   * Subscription id of ADLS account.
   */
  subscriptionId: string;
}

/**
 * An ADLS Gen 2 file data set.
 */
model AdlsGen2FileDataSet extends DataSet {
  /**
   * ADLS Gen 2 file data set properties.
   */
  properties: AdlsGen2FileProperties;

  /**
   * Kind of data set.
   */
  kind: "AdlsGen2File";
}

/**
 * Properties of the ADLS Gen2 file data set.
 */
model AdlsGen2FileProperties {
  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * File path within the file system.
   */
  filePath: string;

  /**
   * File system to which the file belongs.
   */
  fileSystem: string;

  /**
   * Resource group of storage account
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account
   */
  subscriptionId: string;
}

/**
 * An ADLS Gen2 file data set mapping.
 */
model AdlsGen2FileDataSetMapping extends DataSetMapping {
  /**
   * ADLS Gen2 file data set mapping properties.
   */
  properties: AdlsGen2FileDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "AdlsGen2File";
}

/**
 * ADLS Gen 2 file data set mapping property bag.
 */
model AdlsGen2FileDataSetMappingProperties {
  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * File path within the file system.
   */
  filePath: string;

  /**
   * File system to which the file belongs.
   */
  fileSystem: string;

  /**
   * Type of output file
   */
  outputType?: OutputType;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource group of storage account.
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set.
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account.
   */
  subscriptionId: string;
}

/**
 * An ADLS Gen 2 file system data set.
 */
model AdlsGen2FileSystemDataSet extends DataSet {
  /**
   * ADLS Gen 2 file system data set properties.
   */
  properties: AdlsGen2FileSystemProperties;

  /**
   * Kind of data set.
   */
  kind: "AdlsGen2FileSystem";
}

/**
 * Properties of the ADLS Gen2 file system data set.
 */
model AdlsGen2FileSystemProperties {
  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * The file system name.
   */
  fileSystem: string;

  /**
   * Resource group of storage account
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account
   */
  subscriptionId: string;
}

/**
 * An ADLS Gen2 file system data set mapping.
 */
model AdlsGen2FileSystemDataSetMapping extends DataSetMapping {
  /**
   * ADLS Gen2 file system data set mapping properties.
   */
  properties: AdlsGen2FileSystemDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "AdlsGen2FileSystem";
}

/**
 * ADLS Gen 2 file system data set mapping property bag.
 */
model AdlsGen2FileSystemDataSetMappingProperties {
  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * The file system name.
   */
  fileSystem: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource group of storage account.
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set.
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account.
   */
  subscriptionId: string;
}

/**
 * An ADLS Gen 2 folder data set.
 */
model AdlsGen2FolderDataSet extends DataSet {
  /**
   * ADLS Gen 2 folder data set properties.
   */
  properties: AdlsGen2FolderProperties;

  /**
   * Kind of data set.
   */
  kind: "AdlsGen2Folder";
}

/**
 * Properties of the ADLS Gen2 folder data set.
 */
model AdlsGen2FolderProperties {
  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * File system to which the folder belongs.
   */
  fileSystem: string;

  /**
   * Folder path within the file system.
   */
  folderPath: string;

  /**
   * Resource group of storage account
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account
   */
  subscriptionId: string;
}

/**
 * An ADLS Gen2 folder data set mapping.
 */
model AdlsGen2FolderDataSetMapping extends DataSetMapping {
  /**
   * ADLS Gen2 folder data set mapping properties.
   */
  properties: AdlsGen2FolderDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "AdlsGen2Folder";
}

/**
 * ADLS Gen 2 folder data set mapping property bag.
 */
model AdlsGen2FolderDataSetMappingProperties {
  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * File system to which the folder belongs.
   */
  fileSystem: string;

  /**
   * Folder path within the file system.
   */
  folderPath: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource group of storage account.
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set.
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account.
   */
  subscriptionId: string;
}

/**
 * An Azure storage blob container data set.
 */
model BlobContainerDataSet extends DataSet {
  /**
   * Blob container data set properties.
   */
  properties: BlobContainerProperties;

  /**
   * Kind of data set.
   */
  kind: "Container";
}

/**
 * Properties of the BLOB container data set.
 */
model BlobContainerProperties {
  /**
   * BLOB Container name.
   */
  containerName: string;

  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Resource group of storage account
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account
   */
  subscriptionId: string;
}

/**
 * A Blob container data set mapping.
 */
model BlobContainerDataSetMapping extends DataSetMapping {
  /**
   * Blob container data set mapping properties.
   */
  properties: BlobContainerMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "Container";
}

/**
 * Azure storage Blob container data set mapping property bag.
 */
model BlobContainerMappingProperties {
  /**
   * BLOB Container name.
   */
  containerName: string;

  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource group of storage account.
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set.
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account.
   */
  subscriptionId: string;
}

/**
 * An Azure storage blob data set.
 */
model BlobDataSet extends DataSet {
  /**
   * Blob data set properties.
   */
  properties: BlobProperties;

  /**
   * Kind of data set.
   */
  kind: "Blob";
}

/**
 * Properties of the blob data set.
 */
model BlobProperties {
  /**
   * Container that has the file path.
   */
  containerName: string;

  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * File path within the source data set
   */
  filePath: string;

  /**
   * Resource group of storage account
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account
   */
  subscriptionId: string;
}

/**
 * A Blob data set mapping.
 */
model BlobDataSetMapping extends DataSetMapping {
  /**
   * Blob data set mapping properties.
   */
  properties: BlobMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "Blob";
}

/**
 * Azure storage Blob data set mapping property bag.
 */
model BlobMappingProperties {
  /**
   * Container that has the file path.
   */
  containerName: string;

  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * File path within the source data set
   */
  filePath: string;

  /**
   * File output type
   */
  outputType?: OutputType;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource group of storage account.
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set.
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account.
   */
  subscriptionId: string;
}

/**
 * An Azure storage blob folder data set.
 */
model BlobFolderDataSet extends DataSet {
  /**
   * Blob folder data set properties.
   */
  properties: BlobFolderProperties;

  /**
   * Kind of data set.
   */
  kind: "BlobFolder";
}

/**
 * Properties of the blob folder data set.
 */
model BlobFolderProperties {
  /**
   * Container that has the file path.
   */
  containerName: string;

  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Prefix for blob folder
   */
  prefix: string;

  /**
   * Resource group of storage account
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account
   */
  subscriptionId: string;
}

/**
 * A Blob folder data set mapping.
 */
model BlobFolderDataSetMapping extends DataSetMapping {
  /**
   * Blob folder data set mapping properties.
   */
  properties: BlobFolderMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "BlobFolder";
}

/**
 * Azure storage Blob folder data set mapping property bag.
 */
model BlobFolderMappingProperties {
  /**
   * Container that has the file path.
   */
  containerName: string;

  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Prefix for blob folder
   */
  prefix: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource group of storage account.
   */
  resourceGroup: string;

  /**
   * Storage account name of the source data set.
   */
  storageAccountName: string;

  /**
   * Subscription id of storage account.
   */
  subscriptionId: string;
}

/**
 * A kusto cluster data set.
 */
model KustoClusterDataSet extends DataSet {
  /**
   * Kusto cluster data set properties.
   */
  properties: KustoClusterDataSetProperties;

  /**
   * Kind of data set.
   */
  kind: "KustoCluster";
}

/**
 * Properties of the kusto cluster data set.
 */
model KustoClusterDataSetProperties {
  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Resource id of the kusto cluster.
   */
  kustoClusterResourceId: string;

  /**
   * Location of the kusto cluster.
   */
  @visibility("read")
  location?: string;

  /**
   * Provisioning state of the kusto cluster data set.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A Kusto cluster data set mapping
 */
model KustoClusterDataSetMapping extends DataSetMapping {
  /**
   * Kusto cluster data set mapping properties.
   */
  properties: KustoClusterDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "KustoCluster";
}

/**
 * Properties of the Kusto cluster data set mapping
 */
model KustoClusterDataSetMappingProperties {
  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Resource id of the sink kusto cluster.
   */
  kustoClusterResourceId: string;

  /**
   * Location of the sink kusto cluster.
   */
  @visibility("read")
  location?: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A kusto database data set.
 */
model KustoDatabaseDataSet extends DataSet {
  /**
   * Kusto database data set properties.
   */
  properties: KustoDatabaseDataSetProperties;

  /**
   * Kind of data set.
   */
  kind: "KustoDatabase";
}

/**
 * Properties of the kusto database data set.
 */
model KustoDatabaseDataSetProperties {
  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Resource id of the kusto database.
   */
  kustoDatabaseResourceId: string;

  /**
   * Location of the kusto cluster.
   */
  @visibility("read")
  location?: string;

  /**
   * Provisioning state of the kusto database data set.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A Kusto database data set mapping
 */
model KustoDatabaseDataSetMapping extends DataSetMapping {
  /**
   * Kusto database data set mapping properties.
   */
  properties: KustoDatabaseDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "KustoDatabase";
}

/**
 * Properties of the Kusto database data set mapping
 */
model KustoDatabaseDataSetMappingProperties {
  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Resource id of the sink kusto cluster.
   */
  kustoClusterResourceId: string;

  /**
   * Location of the sink kusto cluster.
   */
  @visibility("read")
  location?: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A kusto table data set.
 */
model KustoTableDataSet extends DataSet {
  /**
   * Kusto table data set properties.
   */
  properties: KustoTableDataSetProperties;

  /**
   * Kind of data set.
   */
  kind: "KustoTable";
}

/**
 * Properties of the kusto table data set.
 */
model KustoTableDataSetProperties {
  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Resource id of the kusto database.
   */
  kustoDatabaseResourceId: string;

  /**
   * Location of the kusto cluster.
   */
  @visibility("read")
  location?: string;

  /**
   * Provisioning state of the kusto table data set.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Table level sharing properties for kusto database
   */
  tableLevelSharingProperties: TableLevelSharingProperties;
}

/**
 * Table level sharing properties dto for kusto data set properties
 */
model TableLevelSharingProperties {
  /**
   * External tables to be excluded in the data set
   */
  externalTablesToExclude?: string[];

  /**
   * External tables to be included in the data set
   */
  externalTablesToInclude?: string[];

  /**
   * Materialized views to be excluded in the data set
   */
  materializedViewsToExclude?: string[];

  /**
   * Materialized views to be included in the data set
   */
  materializedViewsToInclude?: string[];

  /**
   * Tables to be excluded in the data set
   */
  tablesToExclude?: string[];

  /**
   * Tables to be included in the data set
   */
  tablesToInclude?: string[];
}

/**
 * A Kusto database data set mapping
 */
model KustoTableDataSetMapping extends DataSetMapping {
  /**
   * Kusto database data set mapping properties.
   */
  properties: KustoTableDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "KustoTable";
}

/**
 * Properties of the Kusto database data set mapping
 */
model KustoTableDataSetMappingProperties {
  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Resource id of the sink kusto cluster.
   */
  kustoClusterResourceId: string;

  /**
   * Location of the sink kusto cluster.
   */
  @visibility("read")
  location?: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A Scheduled source synchronization setting data transfer object.
 */
model ScheduledSourceShareSynchronizationSettingProperties {
  /**
   * Recurrence Interval
   */
  recurrenceInterval?: RecurrenceInterval;

  /**
   * Synchronization time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  synchronizationTime?: utcDateTime;
}

/**
 * A type of synchronization setting based on schedule
 */
model ScheduledSourceSynchronizationSetting
  extends SourceShareSynchronizationSetting {
  /**
   * Properties of scheduled synchronization
   */
  properties?: ScheduledSourceShareSynchronizationSettingProperties;

  /**
   * Kind of synchronization setting on share.
   */
  kind: "ScheduleBased";
}

/**
 * A type of synchronization setting based on schedule
 */
model ScheduledSynchronizationSetting extends SynchronizationSetting {
  /**
   * Properties of scheduled synchronization
   */
  properties: ScheduledSynchronizationSettingProperties;

  /**
   * Kind of synchronization setting.
   */
  kind: "ScheduleBased";
}

/**
 * A Scheduled synchronization setting data transfer object.
 */
model ScheduledSynchronizationSettingProperties {
  /**
   * Time at which the synchronization setting was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Gets or sets the provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Recurrence Interval
   */
  recurrenceInterval: RecurrenceInterval;

  /**
   * Synchronization time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  synchronizationTime: utcDateTime;

  /**
   * Name of the user who created the synchronization setting.
   */
  @visibility("read")
  userName?: string;
}

/**
 * A type of trigger based on schedule
 */
model ScheduledTrigger extends Trigger {
  /**
   * Properties of scheduled synchronization
   */
  properties: ScheduledTriggerProperties;

  /**
   * Kind of synchronization on trigger.
   */
  kind: "ScheduleBased";
}

/**
 * A Scheduled trigger data transfer object.
 */
model ScheduledTriggerProperties {
  /**
   * Time at which the trigger was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Gets the provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Recurrence Interval
   */
  recurrenceInterval: RecurrenceInterval;

  /**
   * Synchronization mode
   */
  synchronizationMode?: SynchronizationMode;

  /**
   * Synchronization time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  synchronizationTime: utcDateTime;

  /**
   * Gets the trigger state
   */
  @visibility("read")
  triggerStatus?: TriggerStatus;

  /**
   * Name of the user who created the trigger.
   */
  @visibility("read")
  userName?: string;
}

/**
 * A SQL DB table data set.
 */
model SqlDBTableDataSet extends DataSet {
  /**
   * SQL DB table data set properties.
   */
  properties?: SqlDBTableProperties;

  /**
   * Kind of data set.
   */
  kind: "SqlDBTable";
}

/**
 * Properties of the SQL DB table data set.
 */
model SqlDBTableProperties {
  /**
   * Database name of the source data set
   */
  databaseName: string;

  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Schema of the table. Default value is dbo.
   */
  schemaName: string;

  /**
   * Resource id of SQL server
   */
  sqlServerResourceId: string;

  /**
   * SQL DB table name.
   */
  tableName: string;
}

/**
 * A SQL DB Table data set mapping.
 */
model SqlDBTableDataSetMapping extends DataSetMapping {
  /**
   * Sql DB data set mapping properties.
   */
  properties: SqlDBTableDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "SqlDBTable";
}

/**
 * Properties of the SQL DB table data set mapping.
 */
model SqlDBTableDataSetMappingProperties {
  /**
   * DatabaseName name of the sink data set
   */
  databaseName: string;

  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Schema of the table. Default value is dbo.
   */
  schemaName: string;

  /**
   * Resource id of SQL server
   */
  sqlServerResourceId: string;

  /**
   * SQL DB table name.
   */
  tableName: string;
}

/**
 * A SQL DW table data set.
 */
model SqlDWTableDataSet extends DataSet {
  /**
   * SQL DW table data set properties.
   */
  properties?: SqlDWTableProperties;

  /**
   * Kind of data set.
   */
  kind: "SqlDWTable";
}

/**
 * Properties of the SQL DW table data set.
 */
model SqlDWTableProperties {
  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * DataWarehouse name of the source data set
   */
  dataWarehouseName: string;

  /**
   * Schema of the table. Default value is dbo.
   */
  schemaName: string;

  /**
   * Resource id of SQL server
   */
  sqlServerResourceId: string;

  /**
   * SQL DW table name.
   */
  tableName: string;
}

/**
 * A SQL DW Table data set mapping.
 */
model SqlDWTableDataSetMapping extends DataSetMapping {
  /**
   * Sql DW data set mapping properties.
   */
  properties: SqlDWTableDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "SqlDWTable";
}

/**
 * Properties of the SQL DW table data set mapping.
 */
model SqlDWTableDataSetMappingProperties {
  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * DataWarehouse name of the source data set
   */
  dataWarehouseName: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Schema of the table. Default value is dbo.
   */
  schemaName: string;

  /**
   * Resource id of SQL server
   */
  sqlServerResourceId: string;

  /**
   * SQL DW table name.
   */
  tableName: string;
}

/**
 * A Synapse Workspace Sql Pool Table data set.
 */
model SynapseWorkspaceSqlPoolTableDataSet extends DataSet {
  /**
   * Synapse Workspace Sql Pool Table data set properties.
   */
  properties: SynapseWorkspaceSqlPoolTableDataSetProperties;

  /**
   * Kind of data set.
   */
  kind: "SynapseWorkspaceSqlPoolTable";
}

/**
 * Properties of the Synapse Workspace SQL Pool Table data set.
 */
model SynapseWorkspaceSqlPoolTableDataSetProperties {
  /**
   * Unique id for identifying a data set resource
   */
  @visibility("read")
  dataSetId?: string;

  /**
   * Resource id of the Synapse Workspace SQL Pool Table
   */
  synapseWorkspaceSqlPoolTableResourceId: string;
}

/**
 * A Synapse Workspace Sql Pool Table data set mapping
 */
model SynapseWorkspaceSqlPoolTableDataSetMapping extends DataSetMapping {
  /**
   * A Synapse Workspace Sql Pool Table data set mapping properties.
   */
  properties: SynapseWorkspaceSqlPoolTableDataSetMappingProperties;

  /**
   * Kind of data set mapping.
   */
  kind: "SynapseWorkspaceSqlPoolTable";
}

/**
 * Properties of the Synapse Workspace SQL Pool Table data set mapping
 */
model SynapseWorkspaceSqlPoolTableDataSetMappingProperties {
  /**
   * The id of the source data set.
   */
  dataSetId: string;

  /**
   * Gets the status of the data set mapping.
   */
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource id of the Synapse Workspace SQL Pool Table
   */
  synapseWorkspaceSqlPoolTableResourceId: string;
}
