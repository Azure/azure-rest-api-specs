import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataShare;

/**
 * Identity Type
 */
union Type {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
}

/**
 * Provisioning state of the Account
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * The type of identity that last modified the resource.
 */
union LastModifiedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * Operation state of the long running operation.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TransientFailure: "TransientFailure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * The status of the invitation.
 */
union InvitationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Withdrawn: "Withdrawn",
}

/**
 * Kind of data set.
 */
union DataSetKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Blob: "Blob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Container: "Container",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BlobFolder: "BlobFolder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2FileSystem: "AdlsGen2FileSystem",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2Folder: "AdlsGen2Folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2File: "AdlsGen2File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen1Folder: "AdlsGen1Folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen1File: "AdlsGen1File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  KustoCluster: "KustoCluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  KustoDatabase: "KustoDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SqlDBTable: "SqlDBTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SqlDWTable: "SqlDWTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SynapseWorkspaceSqlPoolTable: "SynapseWorkspaceSqlPoolTable",
}

/**
 * Kind of data set mapping.
 */
union DataSetMappingKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Blob: "Blob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Container: "Container",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BlobFolder: "BlobFolder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2FileSystem: "AdlsGen2FileSystem",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2Folder: "AdlsGen2Folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2File: "AdlsGen2File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  KustoCluster: "KustoCluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  KustoDatabase: "KustoDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SqlDBTable: "SqlDBTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SqlDWTable: "SqlDWTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SynapseWorkspaceSqlPoolTable: "SynapseWorkspaceSqlPoolTable",
}

/**
 * Registration status
 */
union RegistrationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ActivationPending: "ActivationPending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Activated: "Activated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ActivationAttemptsExhausted: "ActivationAttemptsExhausted",
}

/**
 * Synchronization mode
 */
union SynchronizationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Incremental: "Incremental",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FullSync: "FullSync",
}

/**
 * Type of data set
 */
union DataSetType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Blob: "Blob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Container: "Container",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BlobFolder: "BlobFolder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2FileSystem: "AdlsGen2FileSystem",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2Folder: "AdlsGen2Folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen2File: "AdlsGen2File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen1Folder: "AdlsGen1Folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdlsGen1File: "AdlsGen1File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  KustoCluster: "KustoCluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  KustoDatabase: "KustoDatabase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SqlDBTable: "SqlDBTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SqlDWTable: "SqlDWTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SynapseWorkspaceSqlPoolTable: "SynapseWorkspaceSqlPoolTable",
}

/**
 * Gets the status of share subscription
 */
union ShareSubscriptionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Revoked: "Revoked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceDeleted: "SourceDeleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Revoking: "Revoking",
}

/**
 * Share kind.
 */
union ShareKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CopyBased: "CopyBased",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InPlace: "InPlace",
}

/**
 * Kind of synchronization setting on share.
 */
union SourceShareSynchronizationSettingKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ScheduleBased: "ScheduleBased",
}

/**
 * Kind of synchronization setting.
 */
union SynchronizationSettingKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ScheduleBased: "ScheduleBased",
}

/**
 * Kind of synchronization on trigger.
 */
union TriggerKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ScheduleBased: "ScheduleBased",
}

/**
 * Gets the status of the data set mapping.
 */
union DataSetMappingStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ok: "Ok",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Broken: "Broken",
}

/**
 * Type of output file
 */
union OutputType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Csv: "Csv",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Parquet: "Parquet",
}

/**
 * Recurrence Interval
 */
union RecurrenceInterval {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hour: "Hour",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Day: "Day",
}

/**
 * Gets the trigger state
 */
union TriggerStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceSynchronizationSettingDeleted: "SourceSynchronizationSettingDeleted",
}

/**
 * List response for get Accounts.
 */
model AccountList is Azure.Core.Page<Account>;

/**
 * Identity of resource
 */
model Identity {
  /**
   * service principal Id
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Tenant Id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Identity Type
   */
  type?: Type;
}

/**
 * Account property bag.
 */
model AccountProperties {
  /**
   * Time at which the account was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Provisioning state of the Account
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Email of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userName?: string;
}

/**
 * Base data transfer object implementation for default resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultDto extends ProxyDto {
  /**
   * Location of the azure resource.
   */
  location?: string;

  /**
   * Tags on the azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Base data transfer object implementation for proxy resources.
 */
model ProxyDto {
  /**
   * The resource id of the azure resource
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the azure resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * System Data of the Azure resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Type of the azure resource
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * List response for get InvitationList
 */
model ConsumerInvitationList is Azure.Core.Page<ConsumerInvitation>;

/**
 * Properties of consumer invitation
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ConsumerInvitationProperties {
  /**
   * Number of data sets in a share
   */
  @visibility(Lifecycle.Read)
  dataSetCount?: int32;

  /**
   * Description shared when the invitation was created
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The expiration date for the share subscription created by accepting the invitation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Unique id of the invitation.
   */
  invitationId: string;

  /**
   * The status of the invitation.
   */
  @visibility(Lifecycle.Read)
  invitationStatus?: InvitationStatus;

  /**
   * invitation location
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Email of the provider who created the resource
   */
  @visibility(Lifecycle.Read)
  providerEmail?: string;

  /**
   * Name of the provider who created the resource
   */
  @visibility(Lifecycle.Read)
  providerName?: string;

  /**
   * Tenant name of the provider who created the resource
   */
  @visibility(Lifecycle.Read)
  providerTenantName?: string;

  /**
   * The time the recipient responded to the invitation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  respondedAt?: utcDateTime;

  /**
   * Gets the time at which the invitation was sent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sentAt?: utcDateTime;

  /**
   * Gets the source share Name.
   */
  @visibility(Lifecycle.Read)
  shareName?: string;

  /**
   * Terms of use shared when the invitation was created
   */
  @visibility(Lifecycle.Read)
  termsOfUse?: string;

  /**
   * Email of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userName?: string;
}

/**
 * List response for get DataSets
 */
model DataSetList is Azure.Core.Page<DataSet>;

/**
 * List response for get DataSetMappings
 */
model DataSetMappingList is Azure.Core.Page<DataSetMapping>;

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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activationExpirationDate?: utcDateTime;

  /**
   * The email to register
   */
  @visibility(Lifecycle.Read)
  email?: string;

  /**
   * Registration status
   */
  @visibility(Lifecycle.Read)
  registrationStatus?: RegistrationStatus;

  /**
   * The tenant to register
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * Invitation property bag.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model InvitationProperties {
  /**
   * The expiration date for the invitation and share subscription.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * unique invitation id
   */
  @visibility(Lifecycle.Read)
  invitationId?: string;

  /**
   * The status of the invitation.
   */
  @visibility(Lifecycle.Read)
  invitationStatus?: InvitationStatus;

  /**
   * The time the recipient responded to the invitation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  respondedAt?: utcDateTime;

  /**
   * Gets the time at which the invitation was sent.
   */
  @visibility(Lifecycle.Read)
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
   * Must be specified along TargetActiveDirectoryId. This enables sending
   * invitations to specific users or applications in an AD tenant.
   */
  targetObjectId?: string;

  /**
   * Email of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userName?: string;
}

/**
 * List response for get InvitationList
 */
model InvitationList is Azure.Core.Page<Invitation>;

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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  dataSetId?: string;

  /**
   * Type of the data set
   */
  @visibility(Lifecycle.Read)
  dataSetType?: DataSetType;

  /**
   * Duration of data set level copy
   */
  @visibility(Lifecycle.Read)
  durationMs?: int32;

  /**
   * End time of data set level copy
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The number of files read from the source data set
   */
  @visibility(Lifecycle.Read)
  filesRead?: int64;

  /**
   * The number of files written into the sink data set
   */
  @visibility(Lifecycle.Read)
  filesWritten?: int64;

  /**
   * Error message if any
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Name of the data set
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The number of files copied into the sink data set
   */
  @visibility(Lifecycle.Read)
  rowsCopied?: int64;

  /**
   * The number of rows read from the source data set.
   */
  @visibility(Lifecycle.Read)
  rowsRead?: int64;

  /**
   * The size of the data read from the source data set in bytes
   */
  @visibility(Lifecycle.Read)
  sizeRead?: int64;

  /**
   * The size of the data written into the sink data set in bytes
   */
  @visibility(Lifecycle.Read)
  sizeWritten?: int64;

  /**
   * Start time of data set level copy
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Raw Status
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The vCore units consumed for the data set synchronization
   */
  @visibility(Lifecycle.Read)
  vCore?: int64;
}

/**
 * List response for get ShareSynchronization.
 */
model ShareSynchronizationList is Azure.Core.Page<ShareSynchronization>;

/**
 * Provider share subscription properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ProviderShareSubscriptionProperties {
  /**
   * Email of the consumer who created the share subscription
   */
  @visibility(Lifecycle.Read)
  consumerEmail?: string;

  /**
   * Name of the consumer who created the share subscription
   */
  @visibility(Lifecycle.Read)
  consumerName?: string;

  /**
   * Tenant name of the consumer who created the share subscription
   */
  @visibility(Lifecycle.Read)
  consumerTenantName?: string;

  /**
   * created at
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  providerEmail?: string;

  /**
   * Name of the provider who created the share
   */
  @visibility(Lifecycle.Read)
  providerName?: string;

  /**
   * Shared at
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sharedAt?: utcDateTime;

  /**
   * share Subscription Object Id
   */
  @visibility(Lifecycle.Read)
  shareSubscriptionObjectId?: string;

  /**
   * Gets the status of share subscription
   */
  @visibility(Lifecycle.Read)
  shareSubscriptionStatus?: ShareSubscriptionStatus;
}

/**
 * List response for get ShareSubscription.
 */
model ProviderShareSubscriptionList
  is Azure.Core.Page<ProviderShareSubscription>;

/**
 * Share property bag.
 */
model ShareProperties {
  /**
   * Time at which the share was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Share description.
   */
  description?: string;

  /**
   * Gets or sets the provisioning state
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userName?: string;
}

/**
 * List response for get Shares.
 */
model ShareList is Azure.Core.Page<Share>;

/**
 * A ShareSubscriptionSynchronization data transfer object.
 */
model ShareSubscriptionSynchronization {
  /**
   * Synchronization duration
   */
  @visibility(Lifecycle.Read)
  durationMs?: int32;

  /**
   * End time of synchronization
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * message of Synchronization
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * start time of synchronization
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Raw Status
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Synchronization id
   */
  synchronizationId: string;

  /**
   * Synchronization Mode
   */
  @visibility(Lifecycle.Read)
  synchronizationMode?: SynchronizationMode;
}

/**
 * A consumer side list of source dataSets
 */
model ConsumerSourceDataSetList is Azure.Core.Page<ConsumerSourceDataSet>;

/**
 * A consumer side dataSet data transfer object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ConsumerSourceDataSet extends ProxyDto {
  /**
   * source dataSet properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ConsumerSourceDataSetProperties;
}

/**
 * Properties of consumer source dataSet
 */
model ConsumerSourceDataSetProperties {
  /**
   * DataSet Id
   */
  @visibility(Lifecycle.Read)
  dataSetId?: string;

  /**
   * Location of the data set.
   */
  @visibility(Lifecycle.Read)
  dataSetLocation?: string;

  /**
   * DataSet name
   */
  @visibility(Lifecycle.Read)
  dataSetName?: string;

  /**
   * DataSet path
   */
  @visibility(Lifecycle.Read)
  dataSetPath?: string;

  /**
   * Type of data set
   */
  @visibility(Lifecycle.Read)
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
model SourceShareSynchronizationSetting {
  /**
   * Kind of synchronization setting on share.
   */
  kind: SourceShareSynchronizationSettingKind;
}

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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  providerEmail?: string;

  /**
   * Name of the provider who created the resource
   */
  @visibility(Lifecycle.Read)
  providerName?: string;

  /**
   * Tenant name of the provider who created the resource
   */
  @visibility(Lifecycle.Read)
  providerTenantName?: string;

  /**
   * Provisioning state of the share subscription
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Description of share
   */
  @visibility(Lifecycle.Read)
  shareDescription?: string;

  /**
   * Kind of share
   */
  @visibility(Lifecycle.Read)
  shareKind?: ShareKind;

  /**
   * Name of the share
   */
  @visibility(Lifecycle.Read)
  shareName?: string;

  /**
   * Gets the current status of share subscription.
   */
  @visibility(Lifecycle.Read)
  shareSubscriptionStatus?: ShareSubscriptionStatus;

  /**
   * Terms of a share
   */
  @visibility(Lifecycle.Read)
  shareTerms?: string;

  /**
   * Source share location.
   */
  sourceShareLocation: string;

  /**
   * Email of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userEmail?: string;

  /**
   * Name of the user who created the resource
   */
  @visibility(Lifecycle.Read)
  userName?: string;
}

/**
 * List response for get ShareSubscription.
 */
model ShareSubscriptionList is Azure.Core.Page<ShareSubscription>;

/**
 * List response for get Synchronization settings
 */
model SynchronizationSettingList is Azure.Core.Page<SynchronizationSetting>;

/**
 * List response for get triggers
 */
model TriggerList is Azure.Core.Page<Trigger>;

/**
 * An ADLS Gen 1 file data set.
 */
model AdlsGen1FileDataSet extends DataSet {
  /**
   * ADLS Gen 1 file data set properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * The file system name.
   */
  fileSystem: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Prefix for blob folder
   */
  prefix: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetId?: string;

  /**
   * Resource id of the kusto cluster.
   */
  kustoClusterResourceId: string;

  /**
   * Location of the kusto cluster.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Provisioning state of the kusto cluster data set.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A Kusto cluster data set mapping
 */
model KustoClusterDataSetMapping extends DataSetMapping {
  /**
   * Kusto cluster data set mapping properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Resource id of the sink kusto cluster.
   */
  kustoClusterResourceId: string;

  /**
   * Location of the sink kusto cluster.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A kusto database data set.
 */
model KustoDatabaseDataSet extends DataSet {
  /**
   * Kusto database data set properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetId?: string;

  /**
   * Resource id of the kusto database.
   */
  kustoDatabaseResourceId: string;

  /**
   * Location of the kusto cluster.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Provisioning state of the kusto database data set.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A Kusto database data set mapping
 */
model KustoDatabaseDataSetMapping extends DataSetMapping {
  /**
   * Kusto database data set mapping properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Resource id of the sink kusto cluster.
   */
  kustoClusterResourceId: string;

  /**
   * Location of the sink kusto cluster.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Gets or sets the provisioning state
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  userName?: string;
}

/**
 * A type of trigger based on schedule
 */
model ScheduledTrigger extends Trigger {
  /**
   * Properties of scheduled synchronization
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Gets the provisioning state
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  triggerStatus?: TriggerStatus;

  /**
   * Name of the user who created the trigger.
   */
  @visibility(Lifecycle.Read)
  userName?: string;
}

/**
 * A SQL DB table data set.
 */
model SqlDBTableDataSet extends DataSet {
  /**
   * SQL DB table data set properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * DataWarehouse name of the source data set
   */
  dataWarehouseName: string;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  dataSetMappingStatus?: DataSetMappingStatus;

  /**
   * Provisioning state of the data set mapping.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Resource id of the Synapse Workspace SQL Pool Table
   */
  synapseWorkspaceSqlPoolTableResourceId: string;
}
