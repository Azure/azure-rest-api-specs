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

@doc("Identity Type")
enum ServiceIdentityType {
  SystemAssigned,
}

@doc("Provisioning state of the Account")
enum ProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Moving,
  Failed,
}

@doc("The type of identity that last modified the resource.")
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("Operation state of the long running operation.")
enum Status {
  Accepted,
  InProgress,
  TransientFailure,
  Succeeded,
  Failed,
  Canceled,
}

@doc("The status of the invitation.")
enum InvitationStatus {
  Pending,
  Accepted,
  Rejected,
  Withdrawn,
}

@doc("Kind of data set.")
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

@doc("Kind of data set mapping.")
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

@doc("Registration status")
enum RegistrationStatus {
  ActivationPending,
  Activated,
  ActivationAttemptsExhausted,
}

@doc("Synchronization mode")
enum SynchronizationMode {
  Incremental,
  FullSync,
}

@doc("Type of data set")
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

@doc("Gets the status of share subscription")
enum ShareSubscriptionStatus {
  Active,
  Revoked,
  SourceDeleted,
  Revoking,
}

@doc("Share kind.")
enum ShareKind {
  CopyBased,
  InPlace,
}

@doc("Kind of synchronization setting on share.")
enum SourceShareSynchronizationSettingKind {
  ScheduleBased,
}

@doc("Kind of synchronization setting.")
enum SynchronizationSettingKind {
  ScheduleBased,
}

@doc("Kind of synchronization on trigger.")
enum TriggerKind {
  ScheduleBased,
}

@doc("Gets the status of the data set mapping.")
enum DataSetMappingStatus {
  Ok,
  Broken,
}

@doc("Type of output file")
enum OutputType {
  Csv,
  Parquet,
}

@doc("Recurrence Interval")
enum RecurrenceInterval {
  Hour,
  Day,
}

@doc("Gets the trigger state")
enum TriggerStatus {
  Active,
  Inactive,
  SourceSynchronizationSettingDeleted,
}

@doc("Identity of resource")
model Identity {
  @doc("service principal Id")
  @visibility("read")
  principalId?: string;

  @doc("Tenant Id")
  @visibility("read")
  tenantId?: string;

  @doc("Identity Type")
  type?: ServiceIdentityType;
}

@doc("Account property bag.")
model AccountProperties {
  @doc("Time at which the account was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Provisioning state of the Account")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Email of the user who created the resource")
  @visibility("read")
  userEmail?: string;

  @doc("Name of the user who created the resource")
  @visibility("read")
  userName?: string;
}

@doc("Base data transfer object implementation for default resources.")
model DefaultDto extends ProxyDto {
  @doc("Location of the azure resource.")
  location?: string;

  @doc("Tags on the azure resource.")
  tags?: Record<string>;
}

@doc("Base data transfer object implementation for proxy resources.")
model ProxyDto {
  @doc("The resource id of the azure resource")
  @visibility("read")
  id?: string;

  @doc("Name of the azure resource")
  @visibility("read")
  name?: string;

  @doc("System Data of the Azure resource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Type of the azure resource")
  @visibility("read")
  type?: string;
}

@doc("The data share error model.")
@error
model DataShareError {
  @doc("The data share error body")
  error: DataShareErrorInfo;
}

@doc("The data share error body model.")
model DataShareErrorInfo {
  @doc("Code of the error")
  code: string;

  @doc("Nested details of the error model")
  details?: DataShareErrorInfo[];

  @doc("Message of the error")
  message: string;

  @doc("Target of the error")
  target?: string;
}

@doc("Response for long running operation")
model OperationResponse {
  @doc("start time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The error property when status is failed.")
  error?: DataShareErrorInfo;

  @doc("start time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Operation state of the long running operation.")
  status: Status;
}

@doc("Update parameters for accounts")
model AccountUpdateParameters {
  @doc("Tags on the azure resource.")
  tags?: Record<string>;
}

@doc("Properties of consumer invitation")
model ConsumerInvitationProperties {
  @doc("Number of data sets in a share")
  @visibility("read")
  dataSetCount?: int32;

  @doc("Description shared when the invitation was created")
  @visibility("read")
  description?: string;

  @doc("The expiration date for the share subscription created by accepting the invitation.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Unique id of the invitation.")
  invitationId: string;

  @doc("The status of the invitation.")
  @visibility("read")
  invitationStatus?: InvitationStatus;

  @doc("invitation location")
  @visibility("read")
  location?: string;

  @doc("Email of the provider who created the resource")
  @visibility("read")
  providerEmail?: string;

  @doc("Name of the provider who created the resource")
  @visibility("read")
  providerName?: string;

  @doc("Tenant name of the provider who created the resource")
  @visibility("read")
  providerTenantName?: string;

  @doc("The time the recipient responded to the invitation.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  respondedAt?: utcDateTime;

  @doc("Gets the time at which the invitation was sent.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sentAt?: utcDateTime;

  @doc("Gets the source share Name.")
  @visibility("read")
  shareName?: string;

  @doc("Terms of use shared when the invitation was created")
  @visibility("read")
  termsOfUse?: string;

  @doc("Email of the user who created the resource")
  @visibility("read")
  userEmail?: string;

  @doc("Name of the user who created the resource")
  @visibility("read")
  userName?: string;
}

@doc("Dto for tenant domain registration")
model EmailRegistration {
  @doc("Activation code for the registration")
  activationCode?: string;

  @doc("Date of the activation expiration")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activationExpirationDate?: utcDateTime;

  @doc("The email to register")
  @visibility("read")
  email?: string;

  @doc("Registration status")
  @visibility("read")
  registrationStatus?: RegistrationStatus;

  @doc("The tenant to register")
  @visibility("read")
  tenantId?: string;
}

@doc("Invitation property bag.")
model InvitationProperties {
  @doc("The expiration date for the invitation and share subscription.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("unique invitation id")
  @visibility("read")
  invitationId?: string;

  @doc("The status of the invitation.")
  @visibility("read")
  invitationStatus?: InvitationStatus;

  @doc("The time the recipient responded to the invitation.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  respondedAt?: utcDateTime;

  @doc("Gets the time at which the invitation was sent.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sentAt?: utcDateTime;

  @doc("The target Azure AD Id. Can't be combined with email.")
  targetActiveDirectoryId?: string;

  @doc("The email the invitation is directed to.")
  targetEmail?: string;

  @doc("""
The target user or application Id that invitation is being sent to.
Must be specified along TargetActiveDirectoryId. This enables sending
invitations to specific users or applications in an AD tenant.
""")
  targetObjectId?: string;

  @doc("Email of the user who created the resource")
  @visibility("read")
  userEmail?: string;

  @doc("Name of the user who created the resource")
  @visibility("read")
  userName?: string;
}

@doc("The response model for get operations")
model OperationModel {
  @doc("Properties on the operation")
  display?: OperationModelProperties;

  @doc("Operation name for display purposes")
  name?: string;

  @doc("origin of the operation")
  origin?: string;

  @doc("properties for the operation meta info")
  properties?: OperationMetaPropertyInfo;
}

@doc("Properties on operations")
model OperationModelProperties {
  @doc("Description of the operation for display purposes")
  description?: string;

  @doc("Name of the operation for display purposes")
  operation?: string;

  @doc("Name of the provider for display purposes")
  provider?: string;

  @doc("Name of the resource type for display purposes")
  resource?: string;
}

@doc("properties on meta info")
model OperationMetaPropertyInfo {
  @doc("meta service specification")
  serviceSpecification?: OperationMetaServiceSpecification;
}

@doc("The operation meta service specification")
model OperationMetaServiceSpecification {
  @doc("log specifications for the operation")
  logSpecifications?: OperationMetaLogSpecification[];

  @doc("metric specifications for the operation")
  metricSpecifications?: OperationMetaMetricSpecification[];
}

@doc("log specifications for operation api")
model OperationMetaLogSpecification {
  @doc("blob duration of the log")
  blobDuration?: string;

  @doc("localized name of the log category")
  displayName?: string;

  @doc("name of the log category")
  name?: string;
}

@doc("metric specifications for the operation")
model OperationMetaMetricSpecification {
  @doc("aggregation type of metric")
  aggregationType?: string;

  @doc("properties for dimension")
  dimensions?: DimensionProperties[];

  @doc("description of the metric")
  displayDescription?: string;

  @doc("localized name of the metric")
  displayName?: string;

  @doc("enable regional mdm account")
  enableRegionalMdmAccount?: string;

  @doc("fill gap with zero")
  fillGapWithZero?: boolean;

  @doc("internal metric name")
  internalMetricName?: string;

  @doc("name of the metric")
  name?: string;

  @doc("dimension name use to replace resource id if specified")
  resourceIdDimensionNameOverride?: string;

  @doc("supported aggregation types")
  supportedAggregationTypes?: string[];

  @doc("supported time grain types")
  supportedTimeGrainTypes?: string[];

  @doc("units for the metric")
  unit?: string;
}

@doc("properties for dimension")
model DimensionProperties {
  @doc("localized display name of the dimension to customer")
  displayName?: string;

  @doc("dimension name")
  name?: string;
}

@doc("A ShareSynchronization data transfer object.")
model ShareSynchronization {
  @doc("Email of the user who created the synchronization")
  consumerEmail?: string;

  @doc("Name of the user who created the synchronization")
  consumerName?: string;

  @doc("Tenant name of the consumer who created the synchronization")
  consumerTenantName?: string;

  @doc("synchronization duration")
  durationMs?: int32;

  @doc("End time of synchronization")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("message of synchronization")
  message?: string;

  @doc("start time of synchronization")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Raw Status")
  status?: string;

  @doc("Synchronization id")
  synchronizationId?: string;

  @doc("Synchronization mode")
  @visibility("read")
  synchronizationMode?: SynchronizationMode;
}

@doc("details of synchronization")
model SynchronizationDetailsList is Azure.Core.Page<SynchronizationDetails>;

@doc("Synchronization details at data set level")
model SynchronizationDetails {
  @doc("Id of data set")
  @visibility("read")
  dataSetId?: string;

  @doc("Type of the data set")
  @visibility("read")
  dataSetType?: DataSetType;

  @doc("Duration of data set level copy")
  @visibility("read")
  durationMs?: int32;

  @doc("End time of data set level copy")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The number of files read from the source data set")
  @visibility("read")
  filesRead?: int32;

  @doc("The number of files written into the sink data set")
  @visibility("read")
  filesWritten?: int32;

  @doc("Error message if any")
  @visibility("read")
  message?: string;

  @doc("Name of the data set")
  @visibility("read")
  name?: string;

  @doc("The number of files copied into the sink data set")
  @visibility("read")
  rowsCopied?: int32;

  @doc("The number of rows read from the source data set.")
  @visibility("read")
  rowsRead?: int32;

  @doc("The size of the data read from the source data set in bytes")
  @visibility("read")
  sizeRead?: int32;

  @doc("The size of the data written into the sink data set in bytes")
  @visibility("read")
  sizeWritten?: int32;

  @doc("Start time of data set level copy")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Raw Status")
  @visibility("read")
  status?: string;

  @doc("The vCore units consumed for the data set synchronization")
  @visibility("read")
  vCore?: int32;
}

@doc("List response for get ShareSynchronization.")
model ShareSynchronizationList is Azure.Core.Page<ShareSynchronization>;

@doc("Provider share subscription properties")
model ProviderShareSubscriptionProperties {
  @doc("Email of the consumer who created the share subscription")
  @visibility("read")
  consumerEmail?: string;

  @doc("Name of the consumer who created the share subscription")
  @visibility("read")
  consumerName?: string;

  @doc("Tenant name of the consumer who created the share subscription")
  @visibility("read")
  consumerTenantName?: string;

  @doc("created at")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Expiration date of the share subscription in UTC format")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Email of the provider who created the share")
  @visibility("read")
  providerEmail?: string;

  @doc("Name of the provider who created the share")
  @visibility("read")
  providerName?: string;

  @doc("Shared at")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sharedAt?: utcDateTime;

  @doc("share Subscription Object Id")
  @visibility("read")
  shareSubscriptionObjectId?: string;

  @doc("Gets the status of share subscription")
  @visibility("read")
  shareSubscriptionStatus?: ShareSubscriptionStatus;
}

@doc("Share property bag.")
model ShareProperties {
  @doc("Time at which the share was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Share description.")
  description?: string;

  @doc("Gets or sets the provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Share kind.")
  shareKind?: ShareKind;

  @doc("Share terms.")
  terms?: string;

  @doc("Email of the user who created the resource")
  @visibility("read")
  userEmail?: string;

  @doc("Name of the user who created the resource")
  @visibility("read")
  userName?: string;
}

@doc("A ShareSubscriptionSynchronization data transfer object.")
model ShareSubscriptionSynchronization {
  @doc("Synchronization duration")
  @visibility("read")
  durationMs?: int32;

  @doc("End time of synchronization")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("message of Synchronization")
  @visibility("read")
  message?: string;

  @doc("start time of synchronization")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Raw Status")
  @visibility("read")
  status?: string;

  @doc("Synchronization id")
  synchronizationId: string;

  @doc("Synchronization Mode")
  @visibility("read")
  synchronizationMode?: SynchronizationMode;
}

@doc("A consumer side list of source dataSets")
model ConsumerSourceDataSetList is Azure.Core.Page<ConsumerSourceDataSet>;

@doc("A consumer side dataSet data transfer object.")
model ConsumerSourceDataSet extends ProxyDto {
  @doc("source dataSet properties")
  properties?: ConsumerSourceDataSetProperties;
}

@doc("Properties of consumer source dataSet")
model ConsumerSourceDataSetProperties {
  @doc("DataSet Id")
  @visibility("read")
  dataSetId?: string;

  @doc("Location of the data set.")
  @visibility("read")
  dataSetLocation?: string;

  @doc("DataSet name")
  @visibility("read")
  dataSetName?: string;

  @doc("DataSet path")
  @visibility("read")
  dataSetPath?: string;

  @doc("Type of data set")
  @visibility("read")
  dataSetType?: DataSetType;
}

@doc("List response for get source share Synchronization settings")
model SourceShareSynchronizationSettingList
  is Azure.Core.Page<SourceShareSynchronizationSetting>;

@doc("A view of synchronization setting added by the provider")
@discriminator("kind")
model SourceShareSynchronizationSetting {}

@doc("A consumer side list of share subscription synchronizations")
model ShareSubscriptionSynchronizationList
  is Azure.Core.Page<ShareSubscriptionSynchronization>;

@doc("Payload for the synchronizing the data.")
model Synchronize {
  @doc("Mode of synchronization used in triggers and snapshot sync. Incremental by default")
  synchronizationMode?: SynchronizationMode;
}

@doc("Share subscription property bag.")
model ShareSubscriptionProperties {
  @doc("Time at which the share subscription was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The expiration date of the share subscription.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("The invitation id.")
  invitationId: string;

  @doc("Email of the provider who created the resource")
  @visibility("read")
  providerEmail?: string;

  @doc("Name of the provider who created the resource")
  @visibility("read")
  providerName?: string;

  @doc("Tenant name of the provider who created the resource")
  @visibility("read")
  providerTenantName?: string;

  @doc("Provisioning state of the share subscription")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Description of share")
  @visibility("read")
  shareDescription?: string;

  @doc("Kind of share")
  @visibility("read")
  shareKind?: ShareKind;

  @doc("Name of the share")
  @visibility("read")
  shareName?: string;

  @doc("Gets the current status of share subscription.")
  @visibility("read")
  shareSubscriptionStatus?: ShareSubscriptionStatus;

  @doc("Terms of a share")
  @visibility("read")
  shareTerms?: string;

  @doc("Source share location.")
  sourceShareLocation: string;

  @doc("Email of the user who created the resource")
  @visibility("read")
  userEmail?: string;

  @doc("Name of the user who created the resource")
  @visibility("read")
  userName?: string;
}

@doc("An ADLS Gen 1 file data set.")
model AdlsGen1FileDataSet extends DataSet {
  @doc("ADLS Gen 1 file data set properties.")
  properties: AdlsGen1FileProperties;

  @doc("Kind of data set.")
  kind: "AdlsGen1File";
}

@doc("Properties of the ADLS Gen1 file data set.")
model AdlsGen1FileProperties {
  @doc("The ADLS account name.")
  accountName: string;

  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("The file name in the ADLS account.")
  fileName: string;

  @doc("The folder path within the ADLS account.")
  folderPath: string;

  @doc("Resource group of ADLS account.")
  resourceGroup: string;

  @doc("Subscription id of ADLS account.")
  subscriptionId: string;
}

@doc("An ADLS Gen 1 folder data set.")
model AdlsGen1FolderDataSet extends DataSet {
  @doc("ADLS Gen 1 folder data set properties.")
  properties: AdlsGen1FolderProperties;

  @doc("Kind of data set.")
  kind: "AdlsGen1Folder";
}

@doc("Properties of the ADLS Gen1 folder data set.")
model AdlsGen1FolderProperties {
  @doc("The ADLS account name.")
  accountName: string;

  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("The folder path within the ADLS account.")
  folderPath: string;

  @doc("Resource group of ADLS account.")
  resourceGroup: string;

  @doc("Subscription id of ADLS account.")
  subscriptionId: string;
}

@doc("An ADLS Gen 2 file data set.")
model AdlsGen2FileDataSet extends DataSet {
  @doc("ADLS Gen 2 file data set properties.")
  properties: AdlsGen2FileProperties;

  @doc("Kind of data set.")
  kind: "AdlsGen2File";
}

@doc("Properties of the ADLS Gen2 file data set.")
model AdlsGen2FileProperties {
  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("File path within the file system.")
  filePath: string;

  @doc("File system to which the file belongs.")
  fileSystem: string;

  @doc("Resource group of storage account")
  resourceGroup: string;

  @doc("Storage account name of the source data set")
  storageAccountName: string;

  @doc("Subscription id of storage account")
  subscriptionId: string;
}

@doc("An ADLS Gen2 file data set mapping.")
model AdlsGen2FileDataSetMapping extends DataSetMapping {
  @doc("ADLS Gen2 file data set mapping properties.")
  properties: AdlsGen2FileDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "AdlsGen2File";
}

@doc("ADLS Gen 2 file data set mapping property bag.")
model AdlsGen2FileDataSetMappingProperties {
  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("File path within the file system.")
  filePath: string;

  @doc("File system to which the file belongs.")
  fileSystem: string;

  @doc("Type of output file")
  outputType?: OutputType;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource group of storage account.")
  resourceGroup: string;

  @doc("Storage account name of the source data set.")
  storageAccountName: string;

  @doc("Subscription id of storage account.")
  subscriptionId: string;
}

@doc("An ADLS Gen 2 file system data set.")
model AdlsGen2FileSystemDataSet extends DataSet {
  @doc("ADLS Gen 2 file system data set properties.")
  properties: AdlsGen2FileSystemProperties;

  @doc("Kind of data set.")
  kind: "AdlsGen2FileSystem";
}

@doc("Properties of the ADLS Gen2 file system data set.")
model AdlsGen2FileSystemProperties {
  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("The file system name.")
  fileSystem: string;

  @doc("Resource group of storage account")
  resourceGroup: string;

  @doc("Storage account name of the source data set")
  storageAccountName: string;

  @doc("Subscription id of storage account")
  subscriptionId: string;
}

@doc("An ADLS Gen2 file system data set mapping.")
model AdlsGen2FileSystemDataSetMapping extends DataSetMapping {
  @doc("ADLS Gen2 file system data set mapping properties.")
  properties: AdlsGen2FileSystemDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "AdlsGen2FileSystem";
}

@doc("ADLS Gen 2 file system data set mapping property bag.")
model AdlsGen2FileSystemDataSetMappingProperties {
  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("The file system name.")
  fileSystem: string;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource group of storage account.")
  resourceGroup: string;

  @doc("Storage account name of the source data set.")
  storageAccountName: string;

  @doc("Subscription id of storage account.")
  subscriptionId: string;
}

@doc("An ADLS Gen 2 folder data set.")
model AdlsGen2FolderDataSet extends DataSet {
  @doc("ADLS Gen 2 folder data set properties.")
  properties: AdlsGen2FolderProperties;

  @doc("Kind of data set.")
  kind: "AdlsGen2Folder";
}

@doc("Properties of the ADLS Gen2 folder data set.")
model AdlsGen2FolderProperties {
  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("File system to which the folder belongs.")
  fileSystem: string;

  @doc("Folder path within the file system.")
  folderPath: string;

  @doc("Resource group of storage account")
  resourceGroup: string;

  @doc("Storage account name of the source data set")
  storageAccountName: string;

  @doc("Subscription id of storage account")
  subscriptionId: string;
}

@doc("An ADLS Gen2 folder data set mapping.")
model AdlsGen2FolderDataSetMapping extends DataSetMapping {
  @doc("ADLS Gen2 folder data set mapping properties.")
  properties: AdlsGen2FolderDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "AdlsGen2Folder";
}

@doc("ADLS Gen 2 folder data set mapping property bag.")
model AdlsGen2FolderDataSetMappingProperties {
  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("File system to which the folder belongs.")
  fileSystem: string;

  @doc("Folder path within the file system.")
  folderPath: string;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource group of storage account.")
  resourceGroup: string;

  @doc("Storage account name of the source data set.")
  storageAccountName: string;

  @doc("Subscription id of storage account.")
  subscriptionId: string;
}

@doc("An Azure storage blob container data set.")
model BlobContainerDataSet extends DataSet {
  @doc("Blob container data set properties.")
  properties: BlobContainerProperties;

  @doc("Kind of data set.")
  kind: "Container";
}

@doc("Properties of the BLOB container data set.")
model BlobContainerProperties {
  @doc("BLOB Container name.")
  containerName: string;

  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("Resource group of storage account")
  resourceGroup: string;

  @doc("Storage account name of the source data set")
  storageAccountName: string;

  @doc("Subscription id of storage account")
  subscriptionId: string;
}

@doc("A Blob container data set mapping.")
model BlobContainerDataSetMapping extends DataSetMapping {
  @doc("Blob container data set mapping properties.")
  properties: BlobContainerMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "Container";
}

@doc("Azure storage Blob container data set mapping property bag.")
model BlobContainerMappingProperties {
  @doc("BLOB Container name.")
  containerName: string;

  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource group of storage account.")
  resourceGroup: string;

  @doc("Storage account name of the source data set.")
  storageAccountName: string;

  @doc("Subscription id of storage account.")
  subscriptionId: string;
}

@doc("An Azure storage blob data set.")
model BlobDataSet extends DataSet {
  @doc("Blob data set properties.")
  properties: BlobProperties;

  @doc("Kind of data set.")
  kind: "Blob";
}

@doc("Properties of the blob data set.")
model BlobProperties {
  @doc("Container that has the file path.")
  containerName: string;

  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("File path within the source data set")
  filePath: string;

  @doc("Resource group of storage account")
  resourceGroup: string;

  @doc("Storage account name of the source data set")
  storageAccountName: string;

  @doc("Subscription id of storage account")
  subscriptionId: string;
}

@doc("A Blob data set mapping.")
model BlobDataSetMapping extends DataSetMapping {
  @doc("Blob data set mapping properties.")
  properties: BlobMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "Blob";
}

@doc("Azure storage Blob data set mapping property bag.")
model BlobMappingProperties {
  @doc("Container that has the file path.")
  containerName: string;

  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("File path within the source data set")
  filePath: string;

  @doc("File output type")
  outputType?: OutputType;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource group of storage account.")
  resourceGroup: string;

  @doc("Storage account name of the source data set.")
  storageAccountName: string;

  @doc("Subscription id of storage account.")
  subscriptionId: string;
}

@doc("An Azure storage blob folder data set.")
model BlobFolderDataSet extends DataSet {
  @doc("Blob folder data set properties.")
  properties: BlobFolderProperties;

  @doc("Kind of data set.")
  kind: "BlobFolder";
}

@doc("Properties of the blob folder data set.")
model BlobFolderProperties {
  @doc("Container that has the file path.")
  containerName: string;

  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("Prefix for blob folder")
  prefix: string;

  @doc("Resource group of storage account")
  resourceGroup: string;

  @doc("Storage account name of the source data set")
  storageAccountName: string;

  @doc("Subscription id of storage account")
  subscriptionId: string;
}

@doc("A Blob folder data set mapping.")
model BlobFolderDataSetMapping extends DataSetMapping {
  @doc("Blob folder data set mapping properties.")
  properties: BlobFolderMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "BlobFolder";
}

@doc("Azure storage Blob folder data set mapping property bag.")
model BlobFolderMappingProperties {
  @doc("Container that has the file path.")
  containerName: string;

  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("Prefix for blob folder")
  prefix: string;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource group of storage account.")
  resourceGroup: string;

  @doc("Storage account name of the source data set.")
  storageAccountName: string;

  @doc("Subscription id of storage account.")
  subscriptionId: string;
}

@doc("A kusto cluster data set.")
model KustoClusterDataSet extends DataSet {
  @doc("Kusto cluster data set properties.")
  properties: KustoClusterDataSetProperties;

  @doc("Kind of data set.")
  kind: "KustoCluster";
}

@doc("Properties of the kusto cluster data set.")
model KustoClusterDataSetProperties {
  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("Resource id of the kusto cluster.")
  kustoClusterResourceId: string;

  @doc("Location of the kusto cluster.")
  @visibility("read")
  location?: string;

  @doc("Provisioning state of the kusto cluster data set.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Kusto cluster data set mapping")
model KustoClusterDataSetMapping extends DataSetMapping {
  @doc("Kusto cluster data set mapping properties.")
  properties: KustoClusterDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "KustoCluster";
}

@doc("Properties of the Kusto cluster data set mapping")
model KustoClusterDataSetMappingProperties {
  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("Resource id of the sink kusto cluster.")
  kustoClusterResourceId: string;

  @doc("Location of the sink kusto cluster.")
  @visibility("read")
  location?: string;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A kusto database data set.")
model KustoDatabaseDataSet extends DataSet {
  @doc("Kusto database data set properties.")
  properties: KustoDatabaseDataSetProperties;

  @doc("Kind of data set.")
  kind: "KustoDatabase";
}

@doc("Properties of the kusto database data set.")
model KustoDatabaseDataSetProperties {
  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("Resource id of the kusto database.")
  kustoDatabaseResourceId: string;

  @doc("Location of the kusto cluster.")
  @visibility("read")
  location?: string;

  @doc("Provisioning state of the kusto database data set.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Kusto database data set mapping")
model KustoDatabaseDataSetMapping extends DataSetMapping {
  @doc("Kusto database data set mapping properties.")
  properties: KustoDatabaseDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "KustoDatabase";
}

@doc("Properties of the Kusto database data set mapping")
model KustoDatabaseDataSetMappingProperties {
  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("Resource id of the sink kusto cluster.")
  kustoClusterResourceId: string;

  @doc("Location of the sink kusto cluster.")
  @visibility("read")
  location?: string;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A kusto table data set.")
model KustoTableDataSet extends DataSet {
  @doc("Kusto table data set properties.")
  properties: KustoTableDataSetProperties;

  @doc("Kind of data set.")
  kind: "KustoTable";
}

@doc("Properties of the kusto table data set.")
model KustoTableDataSetProperties {
  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("Resource id of the kusto database.")
  kustoDatabaseResourceId: string;

  @doc("Location of the kusto cluster.")
  @visibility("read")
  location?: string;

  @doc("Provisioning state of the kusto table data set.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Table level sharing properties for kusto database")
  tableLevelSharingProperties: TableLevelSharingProperties;
}

@doc("Table level sharing properties dto for kusto data set properties")
model TableLevelSharingProperties {
  @doc("External tables to be excluded in the data set")
  externalTablesToExclude?: string[];

  @doc("External tables to be included in the data set")
  externalTablesToInclude?: string[];

  @doc("Materialized views to be excluded in the data set")
  materializedViewsToExclude?: string[];

  @doc("Materialized views to be included in the data set")
  materializedViewsToInclude?: string[];

  @doc("Tables to be excluded in the data set")
  tablesToExclude?: string[];

  @doc("Tables to be included in the data set")
  tablesToInclude?: string[];
}

@doc("A Kusto database data set mapping")
model KustoTableDataSetMapping extends DataSetMapping {
  @doc("Kusto database data set mapping properties.")
  properties: KustoTableDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "KustoTable";
}

@doc("Properties of the Kusto database data set mapping")
model KustoTableDataSetMappingProperties {
  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("Resource id of the sink kusto cluster.")
  kustoClusterResourceId: string;

  @doc("Location of the sink kusto cluster.")
  @visibility("read")
  location?: string;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Scheduled source synchronization setting data transfer object.")
model ScheduledSourceShareSynchronizationSettingProperties {
  @doc("Recurrence Interval")
  recurrenceInterval?: RecurrenceInterval;

  @doc("Synchronization time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  synchronizationTime?: utcDateTime;
}

@doc("A type of synchronization setting based on schedule")
model ScheduledSourceSynchronizationSetting
  extends SourceShareSynchronizationSetting {
  @doc("Properties of scheduled synchronization")
  properties?: ScheduledSourceShareSynchronizationSettingProperties;

  @doc("Kind of synchronization setting on share.")
  kind: "ScheduleBased";
}

@doc("A type of synchronization setting based on schedule")
model ScheduledSynchronizationSetting extends SynchronizationSetting {
  @doc("Properties of scheduled synchronization")
  properties: ScheduledSynchronizationSettingProperties;

  @doc("Kind of synchronization setting.")
  kind: "ScheduleBased";
}

@doc("A Scheduled synchronization setting data transfer object.")
model ScheduledSynchronizationSettingProperties {
  @doc("Time at which the synchronization setting was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Gets or sets the provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Recurrence Interval")
  recurrenceInterval: RecurrenceInterval;

  @doc("Synchronization time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  synchronizationTime: utcDateTime;

  @doc("Name of the user who created the synchronization setting.")
  @visibility("read")
  userName?: string;
}

@doc("A type of trigger based on schedule")
model ScheduledTrigger extends Trigger {
  @doc("Properties of scheduled synchronization")
  properties: ScheduledTriggerProperties;

  @doc("Kind of synchronization on trigger.")
  kind: "ScheduleBased";
}

@doc("A Scheduled trigger data transfer object.")
model ScheduledTriggerProperties {
  @doc("Time at which the trigger was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Gets the provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Recurrence Interval")
  recurrenceInterval: RecurrenceInterval;

  @doc("Synchronization mode")
  synchronizationMode?: SynchronizationMode;

  @doc("Synchronization time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  synchronizationTime: utcDateTime;

  @doc("Gets the trigger state")
  @visibility("read")
  triggerStatus?: TriggerStatus;

  @doc("Name of the user who created the trigger.")
  @visibility("read")
  userName?: string;
}

@doc("A SQL DB table data set.")
model SqlDBTableDataSet extends DataSet {
  @doc("SQL DB table data set properties.")
  properties?: SqlDBTableProperties;

  @doc("Kind of data set.")
  kind: "SqlDBTable";
}

@doc("Properties of the SQL DB table data set.")
model SqlDBTableProperties {
  @doc("Database name of the source data set")
  databaseName: string;

  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("Schema of the table. Default value is dbo.")
  schemaName: string;

  @doc("Resource id of SQL server")
  sqlServerResourceId: string;

  @doc("SQL DB table name.")
  tableName: string;
}

@doc("A SQL DB Table data set mapping.")
model SqlDBTableDataSetMapping extends DataSetMapping {
  @doc("Sql DB data set mapping properties.")
  properties: SqlDBTableDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "SqlDBTable";
}

@doc("Properties of the SQL DB table data set mapping.")
model SqlDBTableDataSetMappingProperties {
  @doc("DatabaseName name of the sink data set")
  databaseName: string;

  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Schema of the table. Default value is dbo.")
  schemaName: string;

  @doc("Resource id of SQL server")
  sqlServerResourceId: string;

  @doc("SQL DB table name.")
  tableName: string;
}

@doc("A SQL DW table data set.")
model SqlDWTableDataSet extends DataSet {
  @doc("SQL DW table data set properties.")
  properties?: SqlDWTableProperties;

  @doc("Kind of data set.")
  kind: "SqlDWTable";
}

@doc("Properties of the SQL DW table data set.")
model SqlDWTableProperties {
  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("DataWarehouse name of the source data set")
  dataWarehouseName: string;

  @doc("Schema of the table. Default value is dbo.")
  schemaName: string;

  @doc("Resource id of SQL server")
  sqlServerResourceId: string;

  @doc("SQL DW table name.")
  tableName: string;
}

@doc("A SQL DW Table data set mapping.")
model SqlDWTableDataSetMapping extends DataSetMapping {
  @doc("Sql DW data set mapping properties.")
  properties: SqlDWTableDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "SqlDWTable";
}

@doc("Properties of the SQL DW table data set mapping.")
model SqlDWTableDataSetMappingProperties {
  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("DataWarehouse name of the source data set")
  dataWarehouseName: string;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Schema of the table. Default value is dbo.")
  schemaName: string;

  @doc("Resource id of SQL server")
  sqlServerResourceId: string;

  @doc("SQL DW table name.")
  tableName: string;
}

@doc("A Synapse Workspace Sql Pool Table data set.")
model SynapseWorkspaceSqlPoolTableDataSet extends DataSet {
  @doc("Synapse Workspace Sql Pool Table data set properties.")
  properties: SynapseWorkspaceSqlPoolTableDataSetProperties;

  @doc("Kind of data set.")
  kind: "SynapseWorkspaceSqlPoolTable";
}

@doc("Properties of the Synapse Workspace SQL Pool Table data set.")
model SynapseWorkspaceSqlPoolTableDataSetProperties {
  @doc("Unique id for identifying a data set resource")
  @visibility("read")
  dataSetId?: string;

  @doc("Resource id of the Synapse Workspace SQL Pool Table")
  synapseWorkspaceSqlPoolTableResourceId: string;
}

@doc("A Synapse Workspace Sql Pool Table data set mapping")
model SynapseWorkspaceSqlPoolTableDataSetMapping extends DataSetMapping {
  @doc("A Synapse Workspace Sql Pool Table data set mapping properties.")
  properties: SynapseWorkspaceSqlPoolTableDataSetMappingProperties;

  @doc("Kind of data set mapping.")
  kind: "SynapseWorkspaceSqlPoolTable";
}

@doc("Properties of the Synapse Workspace SQL Pool Table data set mapping")
model SynapseWorkspaceSqlPoolTableDataSetMappingProperties {
  @doc("The id of the source data set.")
  dataSetId: string;

  @doc("Gets the status of the data set mapping.")
  @visibility("read")
  dataSetMappingStatus?: DataSetMappingStatus;

  @doc("Provisioning state of the data set mapping.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource id of the Synapse Workspace SQL Pool Table")
  synapseWorkspaceSqlPoolTableResourceId: string;
}
