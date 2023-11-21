import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureSiteRecoveryManagementServiceAPI;

enum ProvisioningState {
  Canceled,
  Creating,
  Deleting,
  Deleted,
  Failed,
  Succeeded,
  Updating,
}

enum HealthStatus {
  Normal,
  Warning,
  Critical,
}

enum ProtectionState {
  UnprotectedStatesBegin,
  EnablingProtection,
  EnablingFailed,
  DisablingProtection,
  MarkedForDeletion,
  DisablingFailed,
  UnprotectedStatesEnd,
  InitialReplicationStatesBegin,
  InitialReplicationInProgress,
  InitialReplicationCompletedOnPrimary,
  InitialReplicationCompletedOnRecovery,
  InitialReplicationFailed,
  InitialReplicationStatesEnd,
  ProtectedStatesBegin,
  Protected,
  ProtectedStatesEnd,
  PlannedFailoverTransitionStatesBegin,
  PlannedFailoverInitiated,
  PlannedFailoverCompleting,
  PlannedFailoverCompleted,
  PlannedFailoverFailed,
  PlannedFailoverCompletionFailed,
  PlannedFailoverTransitionStatesEnd,
  UnplannedFailoverTransitionStatesBegin,
  UnplannedFailoverInitiated,
  UnplannedFailoverCompleting,
  UnplannedFailoverCompleted,
  UnplannedFailoverFailed,
  UnplannedFailoverCompletionFailed,
  UnplannedFailoverTransitionStatesEnd,
  CommitFailoverStatesBegin,
  CommitFailoverInProgressOnPrimary,
  CommitFailoverInProgressOnRecovery,
  CommitFailoverCompleted,
  CommitFailoverFailedOnPrimary,
  CommitFailoverFailedOnRecovery,
  CommitFailoverStatesEnd,
  CancelFailoverStatesBegin,
  CancelFailoverInProgressOnPrimary,
  CancelFailoverInProgressOnRecovery,
  CancelFailoverFailedOnPrimary,
  CancelFailoverFailedOnRecovery,
  CancelFailoverStatesEnd,
  ChangeRecoveryPointStatesBegin,
  ChangeRecoveryPointInitiated,
  ChangeRecoveryPointCompleted,
  ChangeRecoveryPointFailed,
  ChangeRecoveryPointStatesEnd,
  ReprotectStatesBegin,
  ReprotectInitiated,
  ReprotectFailed,
  ReprotectStatesEnd,
}

enum TestFailoverState {
  None,
  TestFailoverInitiated,
  TestFailoverCompleting,
  TestFailoverCompleted,
  TestFailoverFailed,
  TestFailoverCompletionFailed,
  TestFailoverCleanupInitiated,
  TestFailoverCleanupCompleting,
  MarkedForDeletion,
}

enum ResynchronizationState {
  None,
  ResynchronizationInitiated,
  ResynchronizationCompleted,
  ResynchronizationFailed,
}

enum RecoveryPointType {
  ApplicationConsistent,
  CrashConsistent,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum ReplicationVaultType {
  DisasterRecovery,
  Migrate,
}

enum WorkflowState {
  Pending,
  Started,
  Cancelling,
  Succeeded,
  Failed,
  Cancelled,
  CompletedWithInformation,
  CompletedWithWarnings,
  CompletedWithErrors,
}

enum WorkflowObjectType {
  AvsDiskPool,
  Dra,
  Fabric,
  Policy,
  ProtectedItem,
  RecoveryPlan,
  ReplicationExtension,
  Vault,
}

enum TaskState {
  Pending,
  Started,
  Succeeded,
  Failed,
  Cancelled,
  Skipped,
}

enum VMNicSelection {
  NotSelected,
  SelectedByUser,
  SelectedByDefault,
  SelectedByUserOverride,
}

enum ProtectedItemActiveLocation {
  Primary,
  Recovery,
}

enum VMwareToAzureMigrateResyncState {
  None,
  PreparedForResynchronization,
  StartedResynchronization,
}

@doc("Dra model.")
model DraModel {
  @doc("Dra model properties.")
  properties: DraModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: DraModelSystemData;
}

@doc("Dra model properties.")
model DraModelProperties {
  @doc("Gets or sets the Dra correlation Id.")
  @visibility("read")
  correlationId?: string;

  @doc("Gets or sets the machine Id where Dra is running.")
  machineId: string;

  @doc("Gets or sets the machine name where Dra is running.")
  machineName: string;

  @doc("Identity model.")
  authenticationIdentity: IdentityModel;

  @doc("Identity model.")
  resourceAccessIdentity: IdentityModel;

  @doc("Gets or sets a value indicating whether Dra is responsive.")
  @visibility("read")
  isResponsive?: boolean;

  @doc("Gets or sets the time when last heartbeat was sent by the Dra.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  @doc("Gets or sets the Dra version.")
  @visibility("read")
  versionNumber?: string;

  @doc("Gets or sets the provisioning state of the Dra.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Gets or sets the list of health errors.")
  @visibility("read")
  healthErrors?: HealthErrorModel[];

  @doc("Dra model custom properties.")
  customProperties: DraModelCustomProperties;
}

@doc("Identity model.")
model IdentityModel {
  @doc("Gets or sets the tenant Id of the SPN with which Dra communicates to service.")
  tenantId: string;

  @doc("""
Gets or sets the client/application Id of the SPN with which Dra communicates
to
service.
""")
  applicationId: string;

  @doc("Gets or sets the object Id of the SPN with which Dra communicates to service.")
  objectId: string;

  @doc("Gets or sets the audience of the SPN with which Dra communicates to service.")
  audience: string;

  @doc("Gets or sets the authority of the SPN with which Dra communicates to service.")
  aadAuthority: string;
}

@doc("Health error model.")
model HealthErrorModel {
  @doc("Gets or sets the type of affected resource type.")
  affectedResourceType?: string;

  @doc("""
Gets or sets the list of affected resource correlation Ids. This can be used
to
uniquely identify the count of items affected by a specific category and
severity
as well as count of item affected by an specific issue.
""")
  affectedResourceCorrelationIds?: string[];

  @doc("Gets or sets a list of child health errors associated with this error.")
  childErrors?: InnerHealthErrorModel[];

  @doc("Gets or sets the error code.")
  @visibility("read")
  code?: string;

  @doc("Gets or sets the health category.")
  @visibility("read")
  healthCategory?: string;

  @doc("Gets or sets the error category.")
  @visibility("read")
  category?: string;

  @doc("Gets or sets the error severity.")
  @visibility("read")
  severity?: string;

  @doc("Gets or sets the error source.")
  @visibility("read")
  source?: string;

  @doc("Gets or sets the error creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets a value indicating whether the error is customer resolvable.")
  @visibility("read")
  isCustomerResolvable?: boolean;

  @doc("Gets or sets the error summary.")
  @visibility("read")
  summary?: string;

  @doc("Gets or sets the error message.")
  @visibility("read")
  message?: string;

  @doc("Gets or sets possible causes of the error.")
  @visibility("read")
  causes?: string;

  @doc("Gets or sets recommended action to resolve the error.")
  @visibility("read")
  recommendation?: string;
}

@doc("Inner health error model.")
model InnerHealthErrorModel {
  @doc("Gets or sets the error code.")
  @visibility("read")
  code?: string;

  @doc("Gets or sets the health category.")
  @visibility("read")
  healthCategory?: string;

  @doc("Gets or sets the error category.")
  @visibility("read")
  category?: string;

  @doc("Gets or sets the error severity.")
  @visibility("read")
  severity?: string;

  @doc("Gets or sets the error source.")
  @visibility("read")
  source?: string;

  @doc("Gets or sets the error creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets a value indicating whether the error is customer resolvable.")
  @visibility("read")
  isCustomerResolvable?: boolean;

  @doc("Gets or sets the error summary.")
  @visibility("read")
  summary?: string;

  @doc("Gets or sets the error message.")
  @visibility("read")
  message?: string;

  @doc("Gets or sets possible causes of the error.")
  @visibility("read")
  causes?: string;

  @doc("Gets or sets recommended action to resolve the error.")
  @visibility("read")
  recommendation?: string;
}

@doc("Dra model custom properties.")
@discriminator("instanceType")
model DraModelCustomProperties {}

model DraModelSystemData {
  ...SystemDataModel;
}

@doc("System data required to be defined for Azure resources.")
model SystemDataModel {
  @doc("Gets or sets identity that created the resource.")
  createdBy?: string;

  @doc("""
Gets or sets the type of identity that created the resource: user,
application,
managedIdentity.
""")
  createdByType?: string;

  @doc("Gets or sets the timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Gets or sets the identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("""
Gets or sets the type of identity that last modified the resource: user,
application,
managedIdentity.
""")
  lastModifiedByType?: string;

  @doc("Gets or sets the timestamp of resource last modification (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("Dra model collection.")
model DraModelCollection is Azure.Core.Page<DraModel>;

@doc("Defines the operation status.")
model OperationStatus {
  @doc("Gets or sets the Id.")
  id?: string;

  @doc("Gets or sets the operation name.")
  name?: string;

  @doc("""
Gets or sets the status of the operation. ARM expects the terminal status to be
one of
Succeeded/ Failed/ Canceled. All other values imply that the operation
is still running.
""")
  status?: string;

  @doc("Gets or sets the start time.")
  startTime?: string;

  @doc("Gets or sets the end time.")
  endTime?: string;
}

@doc("Email configuration model.")
model EmailConfigurationModel {
  @doc("Email configuration model properties.")
  properties: EmailConfigurationModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: EmailConfigurationModelSystemData;
}

@doc("Email configuration model properties.")
model EmailConfigurationModelProperties {
  @doc("""
Gets or sets a value indicating whether to send email to subscription
administrator.
""")
  sendToOwners: boolean;

  @doc("Gets or sets the custom email address for sending emails.")
  customEmailAddresses?: string[];

  @doc("Gets or sets the locale for the email notification.")
  locale?: string;
}

model EmailConfigurationModelSystemData {
  ...SystemDataModel;
}

@doc("Email configuration model collection.")
model EmailConfigurationModelCollection
  is Azure.Core.Page<EmailConfigurationModel>;

@doc("Event model.")
model EventModel {
  @doc("Event model properties.")
  properties: EventModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: EventModelSystemData;
}

@doc("Event model properties.")
model EventModelProperties {
  @doc("Gets or sets the resource type.")
  @visibility("read")
  resourceType?: string;

  @doc("Gets or sets the resource name.")
  @visibility("read")
  resourceName?: string;

  @doc("Gets or sets the event type.")
  @visibility("read")
  eventType?: string;

  @doc("Gets or sets the event name.")
  @visibility("read")
  eventName?: string;

  @doc("Gets or sets the time at which the event occurred at source.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeOfOccurrence?: utcDateTime;

  @doc("Gets or sets the event severity.")
  @visibility("read")
  severity?: string;

  @doc("Gets or sets the event description.")
  @visibility("read")
  description?: string;

  @doc("Gets or sets the event correlation Id.")
  @visibility("read")
  correlationId?: string;

  @doc("Gets or sets the errors associated with this event.")
  @visibility("read")
  healthErrors?: HealthErrorModel[];

  @doc("Event model custom properties.")
  customProperties: EventModelCustomProperties;
}

@doc("Event model custom properties.")
@discriminator("instanceType")
model EventModelCustomProperties {}

model EventModelSystemData {
  ...SystemDataModel;
}

@doc("Event model collection.")
model EventModelCollection is Azure.Core.Page<EventModel>;

@doc("Fabric model.")
model FabricModel {
  @doc("Gets or sets the location of the fabric.")
  location: string;

  @doc("Gets or sets the resource tags.")
  tags?: Record<string>;

  @doc("Fabric model properties.")
  properties: FabricModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: FabricModelSystemData;
}

@doc("Fabric model properties.")
model FabricModelProperties {
  @doc("Gets or sets the provisioning state of the fabric.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Gets or sets the service endpoint.")
  @visibility("read")
  serviceEndpoint?: string;

  @doc("Gets or sets the service resource Id.")
  @visibility("read")
  serviceResourceId?: string;

  @doc("Gets or sets the fabric health.")
  @visibility("read")
  health?: HealthStatus;

  @doc("Gets or sets the list of health errors.")
  @visibility("read")
  healthErrors?: HealthErrorModel[];

  @doc("Fabric model custom properties.")
  customProperties: FabricModelCustomProperties;
}

@doc("Fabric model custom properties.")
@discriminator("instanceType")
model FabricModelCustomProperties {}

model FabricModelSystemData {
  ...SystemDataModel;
}

@doc("Fabric model for update.")
model FabricModelUpdate {
  @doc("Gets or sets the resource tags.")
  tags?: Record<string>;

  @doc("Fabric model properties.")
  properties?: FabricModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: FabricModelUpdateSystemData;
}

model FabricModelUpdateSystemData {
  ...SystemDataModel;
}

@doc("Fabric model collection.")
model FabricModelCollection is Azure.Core.Page<FabricModel>;

@doc("Policy model.")
model PolicyModel {
  @doc("Policy model properties.")
  properties: PolicyModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: PolicyModelSystemData;
}

@doc("Policy model properties.")
model PolicyModelProperties {
  @doc("Gets or sets the provisioning state of the policy.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Policy model custom properties.")
  customProperties: PolicyModelCustomProperties;
}

@doc("Policy model custom properties.")
@discriminator("instanceType")
model PolicyModelCustomProperties {}

model PolicyModelSystemData {
  ...SystemDataModel;
}

@doc("Policy model collection.")
model PolicyModelCollection is Azure.Core.Page<PolicyModel>;

@doc("Protected item model.")
model ProtectedItemModel {
  @doc("Protected item model properties.")
  properties: ProtectedItemModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: ProtectedItemModelSystemData;
}

@doc("Protected item model properties.")
model ProtectedItemModelProperties {
  @doc("Gets or sets the policy name.")
  policyName: string;

  @doc("Gets or sets the replication extension name.")
  replicationExtensionName: string;

  @doc("Gets or sets the protected item correlation Id.")
  @visibility("read")
  correlationId?: string;

  @doc("Gets or sets the provisioning state of the Dra.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Gets or sets the protection state.")
  @visibility("read")
  protectionState?: ProtectionState;

  @doc("Gets or sets the protection state description.")
  @visibility("read")
  protectionStateDescription?: string;

  @doc("Gets or sets the test failover state.")
  @visibility("read")
  testFailoverState?: TestFailoverState;

  @doc("Gets or sets the Test failover state description.")
  @visibility("read")
  testFailoverStateDescription?: string;

  @doc("Gets or sets the resynchronization state.")
  @visibility("read")
  resynchronizationState?: ResynchronizationState;

  @doc("Gets or sets the fabric object Id.")
  @visibility("read")
  fabricObjectId?: string;

  @doc("Gets or sets the fabric object name.")
  @visibility("read")
  fabricObjectName?: string;

  @doc("Gets or sets the source fabric provider Id.")
  @visibility("read")
  sourceFabricProviderId?: string;

  @doc("Gets or sets the target fabric provider Id.")
  @visibility("read")
  targetFabricProviderId?: string;

  @doc("Gets or sets the fabric Id.")
  @visibility("read")
  fabricId?: string;

  @doc("Gets or sets the target fabric Id.")
  @visibility("read")
  targetFabricId?: string;

  @doc("Gets or sets the DRA Id.")
  @visibility("read")
  draId?: string;

  @doc("Gets or sets the target DRA Id.")
  @visibility("read")
  targetDraId?: string;

  @doc("Gets or sets a value indicating whether resynchronization is required or not.")
  @visibility("read")
  resyncRequired?: boolean;

  @doc("Gets or sets the Last successful planned failover time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulPlannedFailoverTime?: utcDateTime;

  @doc("Gets or sets the Last successful unplanned failover time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulUnplannedFailoverTime?: utcDateTime;

  @doc("Gets or sets the Last successful test failover time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulTestFailoverTime?: utcDateTime;

  @visibility("read")
  currentJob?: ProtectedItemModelPropertiesCurrentJob;

  @doc("Gets or sets the allowed scenarios on the protected item.")
  @visibility("read")
  allowedJobs?: string[];

  @visibility("read")
  lastFailedEnableProtectionJob?: ProtectedItemModelPropertiesLastFailedEnableProtectionJob;

  @visibility("read")
  lastFailedPlannedFailoverJob?: ProtectedItemModelPropertiesLastFailedPlannedFailoverJob;

  @visibility("read")
  lastTestFailoverJob?: ProtectedItemModelPropertiesLastTestFailoverJob;

  @doc("Gets or sets protected item replication health.")
  @visibility("read")
  replicationHealth?: HealthStatus;

  @doc("Gets or sets the list of health errors.")
  @visibility("read")
  healthErrors?: HealthErrorModel[];

  @doc("Protected item model custom properties.")
  customProperties: ProtectedItemModelCustomProperties;
}

model ProtectedItemModelPropertiesCurrentJob {
  ...ProtectedItemJobProperties;
}

@doc("Protected item job properties.")
model ProtectedItemJobProperties {
  @doc("Gets or sets protection scenario name.")
  @visibility("read")
  scenarioName?: string;

  @doc("Gets or sets workflow Id.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets workflow name.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the workflow friendly display name.")
  @visibility("read")
  displayName?: string;

  @doc("Gets or sets workflow state.")
  @visibility("read")
  state?: string;

  @doc("Gets or sets start time of the workflow.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets or sets end time of the workflow.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

model ProtectedItemModelPropertiesLastFailedEnableProtectionJob {
  ...ProtectedItemJobProperties;
}

model ProtectedItemModelPropertiesLastFailedPlannedFailoverJob {
  ...ProtectedItemJobProperties;
}

model ProtectedItemModelPropertiesLastTestFailoverJob {
  ...ProtectedItemJobProperties;
}

@doc("Protected item model custom properties.")
@discriminator("instanceType")
model ProtectedItemModelCustomProperties {}

model ProtectedItemModelSystemData {
  ...SystemDataModel;
}

@doc("Protected item model collection.")
model ProtectedItemModelCollection is Azure.Core.Page<ProtectedItemModel>;

@doc("Planned failover model.")
model PlannedFailoverModel {
  @doc("Planned failover model properties.")
  properties: PlannedFailoverModelProperties;
}

@doc("Planned failover model properties.")
model PlannedFailoverModelProperties {
  @doc("Planned failover model custom properties.")
  customProperties: PlannedFailoverModelCustomProperties;
}

@doc("Planned failover model custom properties.")
@discriminator("instanceType")
model PlannedFailoverModelCustomProperties {}

@doc("Recovery point model.")
model RecoveryPointModel {
  @doc("Recovery point model properties.")
  properties: RecoveryPointModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: RecoveryPointModelSystemData;
}

@doc("Recovery point model properties.")
model RecoveryPointModelProperties {
  @doc("Gets or sets the recovery point time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime: utcDateTime;

  @doc("Gets or sets the recovery point type.")
  recoveryPointType: RecoveryPointType;

  @doc("Recovery point model custom properties.")
  customProperties: RecoveryPointModelCustomProperties;
}

@doc("Recovery point model custom properties.")
@discriminator("instanceType")
model RecoveryPointModelCustomProperties {}

model RecoveryPointModelSystemData {
  ...SystemDataModel;
}

@doc("Recovery point model collection.")
model RecoveryPointModelCollection is Azure.Core.Page<RecoveryPointModel>;

@doc("Replication extension model.")
model ReplicationExtensionModel {
  @doc("Replication extension model properties.")
  properties: ReplicationExtensionModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: ReplicationExtensionModelSystemData;
}

@doc("Replication extension model properties.")
model ReplicationExtensionModelProperties {
  @doc("Gets or sets the provisioning state of the replication extension.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Replication extension model custom properties.")
  customProperties: ReplicationExtensionModelCustomProperties;
}

@doc("Replication extension model custom properties.")
@discriminator("instanceType")
model ReplicationExtensionModelCustomProperties {}

model ReplicationExtensionModelSystemData {
  ...SystemDataModel;
}

@doc("Replication extension model collection.")
model ReplicationExtensionModelCollection
  is Azure.Core.Page<ReplicationExtensionModel>;

@doc("Check name availability model.")
model CheckNameAvailabilityModel {
  @doc("Gets or sets the resource name.")
  name?: string;

  @doc("Gets or sets the resource type.")
  type?: string;
}

@doc("Check name availability response model.")
model CheckNameAvailabilityResponseModel {
  @doc("Gets or sets a value indicating whether resource name is available or not.")
  nameAvailable?: boolean;

  @doc("Gets or sets the reason for resource name unavailability.")
  reason?: string;

  @doc("Gets or sets the message for resource name unavailability.")
  message?: string;
}

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}

@doc("Deployment preflight model.")
model DeploymentPreflightModel {
  @doc("Gets or sets the list of resources.")
  resources?: DeploymentPreflightResource[];
}

@doc("Deployment preflight resource.")
model DeploymentPreflightResource {
  @doc("Gets or sets the resource name.")
  name?: string;

  @doc("Gets or sets the resource type.")
  type?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Gets or sets the Api version.")
  apiVersion?: string;
}

@doc("Vault model.")
model VaultModel {
  @doc("Gets or sets the location of the vault.")
  location: string;

  @doc("Gets or sets the resource tags.")
  tags?: Record<string>;

  @doc("Vault properties.")
  properties?: VaultModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: VaultModelSystemData;
}

@doc("Vault properties.")
model VaultModelProperties {
  @doc("Gets or sets the provisioning state of the vault.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Gets or sets the service resource Id.")
  @visibility("read")
  serviceResourceId?: string;

  @doc("Gets or sets the type of vault.")
  vaultType?: ReplicationVaultType;
}

model VaultModelSystemData {
  ...SystemDataModel;
}

@doc("Vault model for update.")
model VaultModelUpdate {
  @doc("Gets or sets the resource tags.")
  tags?: Record<string>;

  @doc("Vault properties.")
  properties?: VaultModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: VaultModelUpdateSystemData;
}

model VaultModelUpdateSystemData {
  ...SystemDataModel;
}

@doc("Vault model collection.")
model VaultModelCollection is Azure.Core.Page<VaultModel>;

@doc("Workflow model.")
model WorkflowModel {
  @doc("Workflow model properties.")
  properties: WorkflowModelProperties;

  @doc("Gets or sets the Id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the type of the resource.")
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: WorkflowModelSystemData;
}

@doc("Workflow model properties.")
model WorkflowModelProperties {
  @doc("Gets or sets the friendly display name.")
  @visibility("read")
  displayName?: string;

  @doc("Gets or sets the workflow state.")
  @visibility("read")
  state?: WorkflowState;

  @doc("Gets or sets the start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets or sets the end time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets or sets the affected object Id.")
  @visibility("read")
  objectId?: string;

  @doc("Gets or sets the affected object name.")
  @visibility("read")
  objectName?: string;

  @doc("Gets or sets the affected object internal Id.")
  @visibility("read")
  objectInternalId?: string;

  @doc("Gets or sets the affected object internal name.")
  @visibility("read")
  objectInternalName?: string;

  @doc("Gets or sets the object type.")
  @visibility("read")
  objectType?: WorkflowObjectType;

  @doc("Gets or sets the replication provider.")
  @visibility("read")
  replicationProviderId?: string;

  @doc("Gets or sets the source fabric provider.")
  @visibility("read")
  sourceFabricProviderId?: string;

  @doc("Gets or sets the target fabric provider.")
  @visibility("read")
  targetFabricProviderId?: string;

  @doc("Gets or sets the list of allowed actions on the workflow.")
  @visibility("read")
  allowedActions?: string[];

  @doc("Gets or sets the workflow activity id.")
  @visibility("read")
  activityId?: string;

  @doc("Gets or sets the list of tasks.")
  @visibility("read")
  tasks?: TaskModel[];

  @doc("Gets or sets the list of errors.")
  @visibility("read")
  errors?: ErrorModel[];

  @doc("Workflow model custom properties.")
  customProperties: WorkflowModelCustomProperties;
}

@doc("Task model.")
model TaskModel {
  @doc("Gets or sets the task name.")
  @visibility("read")
  taskName?: string;

  @doc("Gets or sets the task state.")
  @visibility("read")
  state?: TaskState;

  @doc("Gets or sets the start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets or sets the end time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Task model custom properties.")
  customProperties?: TaskModelCustomProperties;

  @doc("Gets or sets the list of children workflow models.")
  childrenWorkflows?: WorkflowModel[];
}

@doc("Task model custom properties.")
model TaskModelCustomProperties {
  @doc("Gets or sets the instance type.")
  instanceType: string;
}

@doc("Error model.")
model ErrorModel {
  @doc("Gets or sets the error code.")
  @visibility("read")
  code?: string;

  @doc("Gets or sets the error type.")
  @visibility("read")
  type?: string;

  @doc("Gets or sets the error severity.")
  @visibility("read")
  severity?: string;

  @doc("Gets or sets the creation time of error.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the error message.")
  @visibility("read")
  message?: string;

  @doc("Gets or sets the possible causes of error.")
  @visibility("read")
  causes?: string;

  @doc("Gets or sets the recommended action to resolve error.")
  @visibility("read")
  recommendation?: string;
}

@doc("Workflow model custom properties.")
@discriminator("instanceType")
model WorkflowModelCustomProperties {
  @doc("Gets or sets any custom properties of the affected object.")
  @visibility("read")
  affectedObjectDetails?: Record<string>;
}

model WorkflowModelSystemData {
  ...SystemDataModel;
}

@doc("Workflow model collection.")
model WorkflowModelCollection is Azure.Core.Page<WorkflowModel>;

@doc("AzStackHCI cluster properties.")
model AzStackHCIClusterProperties {
  @doc("Gets or sets the AzStackHCICluster FQDN name.")
  clusterName: string;

  @doc("Gets or sets the AzStackHCICluster resource name.")
  resourceName: string;

  @doc("Gets or sets the Storage account name.")
  storageAccountName: string;

  @doc("Gets or sets the list of AzStackHCICluster Storage Container.")
  storageContainers: StorageContainerProperties[];
}

@doc("Storage container properties.")
model StorageContainerProperties {
  @doc("Gets or sets the Name.")
  name: string;

  @doc("Gets or sets the ClusterSharedVolumePath.")
  clusterSharedVolumePath: string;
}

@doc("AzStackHCI fabric model custom properties.")
model AzStackHCIFabricModelCustomProperties
  extends FabricModelCustomProperties {
  @doc("Gets or sets the ARM Id of the AzStackHCI site.")
  azStackHciSiteId: string;

  @doc("Gets or sets the Appliance name.")
  @visibility("read")
  applianceName?: string[];

  @doc("AzStackHCI cluster properties.")
  cluster: AzStackHCIClusterProperties;

  @doc("Gets or sets the fabric resource Id.")
  @visibility("read")
  fabricResourceId?: string;

  @doc("Gets or sets the fabric container Id.")
  @visibility("read")
  fabricContainerId?: string;

  @doc("Gets or sets the Migration solution ARM Id.")
  migrationSolutionId: string;

  @doc("Gets or sets the migration hub Uri.")
  @visibility("read")
  migrationHubUri?: string;

  @doc("Gets or sets the instance type.")
  instanceType: "AzStackHCI";
}

@doc("Failover properties of the protected item.")
model FailoverProtectedItemProperties {
  @doc("Gets or sets the protected item name.")
  @visibility("read")
  protectedItemName?: string;

  @doc("Gets or sets the VM name.")
  @visibility("read")
  vmName?: string;

  @doc("Gets or sets the test VM name.")
  @visibility("read")
  testVmName?: string;

  @doc("Gets or sets the recovery point Id.")
  @visibility("read")
  recoveryPointId?: string;

  @doc("Gets or sets the recovery point time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;

  @doc("Gets or sets the network name.")
  @visibility("read")
  networkName?: string;

  @doc("Gets or sets the network subnet.")
  @visibility("read")
  subnet?: string;
}

@doc("Failover workflow model custom properties.")
model FailoverWorkflowModelCustomProperties
  extends WorkflowModelCustomProperties {
  @doc("Gets or sets the failed over protected item details.")
  @visibility("read")
  protectedItemDetails?: FailoverProtectedItemProperties[];

  @doc("Gets or sets the instance type.")
  instanceType: "FailoverWorkflowDetails";
}

@doc("HyperV migrate fabric model custom properties.")
model HyperVMigrateFabricModelCustomProperties
  extends FabricModelCustomProperties {
  @doc("Gets or sets the ARM Id of the HyperV site.")
  hyperVSiteId: string;

  @doc("Gets or sets the fabric resource Id.")
  @visibility("read")
  fabricResourceId?: string;

  @doc("Gets or sets the fabric container Id.")
  @visibility("read")
  fabricContainerId?: string;

  @doc("Gets or sets the migration solution ARM Id.")
  migrationSolutionId: string;

  @doc("Gets or sets the migration hub Uri.")
  @visibility("read")
  migrationHubUri?: string;

  @doc("Gets or sets the instance type.")
  instanceType: "HyperVMigrate";
}

@doc("HyperVToAzStack disk input.")
model HyperVToAzStackHCIDiskInput {
  @doc("Gets or sets the disk Id.")
  diskId: string;

  @doc("Gets or sets the target storage account ARM Id.")
  storageContainerId?: string;

  @doc("""
Gets or sets a value indicating whether dynamic sizing is enabled on the
virtual hard
disk.
""")
  isDynamic?: boolean;

  @doc("Gets or sets the disk size in GB.")
  diskSizeGB: int32;

  @doc("Gets or sets the type of the virtual hard disk, vhd or vhdx.")
  diskFileFormat: string;

  @doc("Gets or sets a value indicating whether disk is os disk.")
  isOsDisk: boolean;
}

@doc("""
HyperV to  AzStackHCI event model custom properties. This class provides
provider specific
details for events of type
DataContract.HealthEvents.HealthEventType.ProtectedItemHealth
and
DataContract.HealthEvents.HealthEventType.AgentHealth.
""")
model HyperVToAzStackHCIEventModelCustomProperties
  extends EventModelCustomProperties {
  @doc("Gets or sets the friendly name of the source which has raised this health event.")
  @visibility("read")
  eventSourceFriendlyName?: string;

  @doc("Gets or sets the protected item friendly name.")
  @visibility("read")
  protectedItemFriendlyName?: string;

  @doc("Gets or sets the source appliance name.")
  @visibility("read")
  sourceApplianceName?: string;

  @doc("Gets or sets the source target name.")
  @visibility("read")
  targetApplianceName?: string;

  @doc("Gets or sets the server type.")
  @visibility("read")
  serverType?: string;

  @doc("Gets or sets the instance type.")
  instanceType: "HyperVToAzStackHCI";
}

@doc("HyperVToAzStackHCI NIC properties.")
model HyperVToAzStackHCINicInput {
  @doc("Gets or sets the NIC Id.")
  nicId: string;

  @doc("Gets or sets the network name.")
  @visibility("read")
  networkName?: string;

  @doc("Gets or sets the target network Id within AzStackHCI Cluster.")
  targetNetworkId: string;

  @doc("Gets or sets the target test network Id within AzStackHCI Cluster.")
  testNetworkId: string;

  @doc("Gets or sets the selection type of the NIC.")
  selectionTypeForFailover: VMNicSelection;
}

@doc("HyperV to AzStackHCI planned failover model custom properties.")
model HyperVToAzStackHCIPlannedFailoverModelCustomProperties
  extends PlannedFailoverModelCustomProperties {
  @doc("Gets or sets a value indicating whether VM needs to be shut down.")
  shutdownSourceVM: boolean;

  @doc("Gets or sets the instance type.")
  instanceType: "HyperVToAzStackHCI";
}

@doc("HyperV To AzStackHCI Policy model custom properties.")
model HyperVToAzStackHCIPolicyModelCustomProperties
  extends PolicyModelCustomProperties {
  @doc("""
Gets or sets the duration in minutes until which the recovery points need to
be
stored.
""")
  recoveryPointHistoryInMinutes: int32;

  @doc("Gets or sets the crash consistent snapshot frequency (in minutes).")
  crashConsistentFrequencyInMinutes: int32;

  @doc("Gets or sets the app consistent snapshot frequency (in minutes).")
  appConsistentFrequencyInMinutes: int32;

  @doc("Gets or sets the instance type.")
  instanceType: "HyperVToAzStackHCI";
}

@doc("HyperVToAzStackHCI protected disk properties.")
model HyperVToAzStackHCIProtectedDiskProperties {
  @doc("Gets or sets the ARM Id of the storage container.")
  @visibility("read")
  storageContainerId?: string;

  @doc("Gets or sets the local path of the storage container.")
  @visibility("read")
  storageContainerLocalPath?: string;

  @doc("Gets or sets the source disk Id.")
  @visibility("read")
  sourceDiskId?: string;

  @doc("Gets or sets the source disk Name.")
  @visibility("read")
  sourceDiskName?: string;

  @doc("Gets or sets the seed disk name.")
  @visibility("read")
  seedDiskName?: string;

  @doc("Gets or sets the test failover clone disk.")
  @visibility("read")
  testMigrateDiskName?: string;

  @doc("Gets or sets the failover clone disk.")
  @visibility("read")
  migrateDiskName?: string;

  @doc("Gets or sets a value indicating whether the disk is the OS disk.")
  @visibility("read")
  isOsDisk?: boolean;

  @doc("Gets or sets the disk capacity in bytes.")
  @visibility("read")
  capacityInBytes?: int32;

  @doc("""
Gets or sets a value indicating whether dynamic sizing is enabled on the
virtual hard
disk.
""")
  @visibility("read")
  isDynamic?: boolean;

  @doc("Gets or sets the disk type.")
  @visibility("read")
  diskType?: string;
}

@doc("HyperV to AzStackHCI Protected item model custom properties.")
model HyperVToAzStackHCIProtectedItemModelCustomProperties
  extends ProtectedItemModelCustomProperties {
  @doc("Gets or sets the location of the protected item.")
  @visibility("read")
  activeLocation?: ProtectedItemActiveLocation;

  @doc("Gets or sets the Target HCI Cluster ARM Id.")
  targetHciClusterId: string;

  @doc("Gets or sets the Target Arc Cluster Custom Location ARM Id.")
  targetArcClusterCustomLocationId: string;

  @doc("Gets or sets the Target AzStackHCI cluster name.")
  @visibility("read")
  targetAzStackHciClusterName?: string;

  @doc("Gets or sets the ARM Id of the discovered machine.")
  fabricDiscoveryMachineId: string;

  @doc("Gets or sets the list of disks to replicate.")
  disksToInclude: HyperVToAzStackHCIDiskInput[];

  @doc("Gets or sets the list of VM NIC to replicate.")
  nicsToInclude: HyperVToAzStackHCINicInput[];

  @doc("Gets or sets the source VM display name.")
  @visibility("read")
  sourceVmName?: string;

  @doc("Gets or sets the source VM CPU cores.")
  @visibility("read")
  sourceCpuCores?: int32;

  @doc("Gets or sets the source VM ram memory size in megabytes.")
  @visibility("read")
  sourceMemoryInMegaBytes?: float32;

  @doc("Gets or sets the target VM display name.")
  targetVmName?: string;

  @doc("Gets or sets the target resource group ARM Id.")
  targetResourceGroupId: string;

  @doc("Gets or sets the target storage container ARM Id.")
  storageContainerId: string;

  @doc("Gets or sets the hypervisor generation of the virtual machine.")
  hyperVGeneration: string;

  @doc("Gets or sets the target network Id within AzStackHCI Cluster.")
  targetNetworkId?: string;

  @doc("Gets or sets the target test network Id within AzStackHCI Cluster.")
  testNetworkId?: string;

  @doc("Gets or sets the target CPU cores.")
  targetCpuCores?: int32;

  @doc("Gets or sets a value indicating whether memory is dynamical.")
  isDynamicRam?: boolean;

  @doc("Protected item dynamic memory config.")
  dynamicMemoryConfig?: ProtectedItemDynamicMemoryConfig;

  @doc("Gets or sets the target memory in mega-bytes.")
  targetMemoryInMegaBytes?: int32;

  @doc("Gets or sets the Run As account Id.")
  runAsAccountId: string;

  @doc("Gets or sets the source DRA name.")
  sourceDraName: string;

  @doc("Gets or sets the target DRA name.")
  targetDraName: string;

  @doc("Gets or sets the source appliance name.")
  @visibility("read")
  sourceApplianceName?: string;

  @doc("Gets or sets the target appliance name.")
  @visibility("read")
  targetApplianceName?: string;

  @doc("Gets or sets the type of the OS.")
  @visibility("read")
  osType?: string;

  @doc("Gets or sets the name of the OS.")
  @visibility("read")
  osName?: string;

  @doc("Gets or sets the firmware type.")
  @visibility("read")
  firmwareType?: string;

  @doc("Gets or sets the target location.")
  @visibility("read")
  targetLocation?: string;

  @doc("Gets or sets the location of Azure Arc HCI custom location resource.")
  customLocationRegion: string;

  @doc("Gets or sets the recovery point Id to which the VM was failed over.")
  @visibility("read")
  failoverRecoveryPointId?: string;

  @doc("Gets or sets the last recovery point received time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  @doc("Gets or sets the last recovery point Id.")
  @visibility("read")
  lastRecoveryPointId?: string;

  @doc("""
Gets or sets the initial replication progress percentage. This is calculated
based on
total bytes processed for all disks in the source VM.
""")
  @visibility("read")
  initialReplicationProgressPercentage?: int32;

  @doc("""
Gets or sets the resync progress percentage. This is calculated based on total
bytes
processed for all disks in the source VM.
""")
  @visibility("read")
  resyncProgressPercentage?: int32;

  @doc("Gets or sets the list of protected disks.")
  @visibility("read")
  protectedDisks?: HyperVToAzStackHCIProtectedDiskProperties[];

  @doc("Gets or sets the VM NIC details.")
  @visibility("read")
  protectedNics?: HyperVToAzStackHCIProtectedNicProperties[];

  @doc("Gets or sets the BIOS Id of the target AzStackHCI VM.")
  @visibility("read")
  targetVmBiosId?: string;

  @doc("Gets or sets the latest timestamp that replication status is updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplicationUpdateTime?: utcDateTime;

  @doc("Gets or sets the instance type.")
  instanceType: "HyperVToAzStackHCI";
}

@doc("Protected item dynamic memory config.")
model ProtectedItemDynamicMemoryConfig {
  @doc("Gets or sets maximum memory in MB.")
  maximumMemoryInMegaBytes: int32;

  @doc("Gets or sets minimum memory in MB.")
  minimumMemoryInMegaBytes: int32;

  @doc("Gets or sets target memory buffer in %.")
  targetMemoryBufferPercentage: int32;
}

@doc("HyperVToAzStackHCI NIC properties.")
model HyperVToAzStackHCIProtectedNicProperties {
  @doc("Gets or sets the NIC Id.")
  @visibility("read")
  nicId?: string;

  @doc("Gets or sets the NIC mac address.")
  @visibility("read")
  macAddress?: string;

  @doc("Gets or sets the network name.")
  @visibility("read")
  networkName?: string;

  @doc("Gets or sets the target network Id within AzStackHCI Cluster.")
  @visibility("read")
  targetNetworkId?: string;

  @doc("Gets or sets the target test network Id within AzStackHCI Cluster.")
  @visibility("read")
  testNetworkId?: string;

  @doc("Gets or sets the selection type of the NIC.")
  @visibility("read")
  selectionTypeForFailover?: VMNicSelection;
}

@doc("HyperV to AzStackHCI recovery point model custom properties.")
model HyperVToAzStackHCIRecoveryPointModelCustomProperties
  extends RecoveryPointModelCustomProperties {
  @doc("Gets or sets the list of the disk Ids.")
  @visibility("read")
  diskIds?: string[];

  @doc("Gets or sets the instance type.")
  instanceType: "HyperVToAzStackHCI";
}

@doc("HyperV to AzStackHCI Replication extension model custom properties.")
model HyperVToAzStackHCIReplicationExtensionModelCustomProperties
  extends ReplicationExtensionModelCustomProperties {
  @doc("Gets or sets the ARM Id of the source HyperV fabric.")
  hyperVFabricArmId: string;

  @doc("Gets or sets the ARM Id of the HyperV site.")
  @visibility("read")
  hyperVSiteId?: string;

  @doc("Gets or sets the ARM Id of the target AzStackHCI fabric.")
  azStackHciFabricArmId: string;

  @doc("Gets or sets the ARM Id of the AzStackHCI site.")
  @visibility("read")
  azStackHciSiteId?: string;

  @doc("Gets or sets the storage account Id.")
  storageAccountId?: string;

  @doc("Gets or sets the Sas Secret of storage account.")
  storageAccountSasSecretName?: string;

  @doc("Gets or sets the Uri of ASR.")
  @visibility("read")
  asrServiceUri?: string;

  @doc("Gets or sets the Uri of Rcm.")
  @visibility("read")
  rcmServiceUri?: string;

  @doc("Gets or sets the Uri of Gateway.")
  @visibility("read")
  gatewayServiceUri?: string;

  @doc("Gets or sets the gateway service Id of source.")
  @visibility("read")
  sourceGatewayServiceId?: string;

  @doc("Gets or sets the gateway service Id of target.")
  @visibility("read")
  targetGatewayServiceId?: string;

  @doc("Gets or sets the source storage container name.")
  @visibility("read")
  sourceStorageContainerName?: string;

  @doc("Gets or sets the target storage container name.")
  @visibility("read")
  targetStorageContainerName?: string;

  @doc("Gets or sets the resource location.")
  @visibility("read")
  resourceLocation?: string;

  @doc("Gets or sets the subscription.")
  @visibility("read")
  subscriptionId?: string;

  @doc("Gets or sets the resource group.")
  @visibility("read")
  resourceGroup?: string;

  @doc("Gets or sets the instance type.")
  instanceType: "HyperVToAzStackHCI";
}

@doc("Operation model.")
model OperationModel {
  @doc("Gets or sets the name of the operation.")
  name?: string;

  @doc("""
Gets or sets a value indicating whether the action is specific to data plane
or
control plane.
""")
  isDataAction?: boolean;

  @doc("Gets or sets the executor of the operation.")
  origin?: string;

  @doc("Operation model properties.")
  display?: OperationModelProperties;
}

@doc("Operation model properties.")
model OperationModelProperties {
  @doc("Gets or sets the resource provider name.")
  provider?: string;

  @doc("Gets or sets resource name.")
  resource?: string;

  @doc("Gets or sets the operation.")
  operation?: string;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("Available operations of the service.")
model OperationModelCollection {
  @doc("Gets or sets the list of operations.")
  value?: OperationModel[];

  @doc("Gets or sets the value of next link.")
  nextLink?: string;
}

@doc("Test failover cleanup workflow model custom properties.")
model TestFailoverCleanupWorkflowModelCustomProperties
  extends WorkflowModelCustomProperties {
  @doc("Gets or sets the test failover cleanup comments.")
  @visibility("read")
  comments?: string;

  @doc("Gets or sets the instance type.")
  instanceType: "TestFailoverCleanupWorkflowDetails";
}

@doc("Test failover workflow model custom properties.")
model TestFailoverWorkflowModelCustomProperties
  extends WorkflowModelCustomProperties {
  @doc("Gets or sets the test VM details.")
  @visibility("read")
  protectedItemDetails?: FailoverProtectedItemProperties[];

  @doc("Gets or sets the instance type.")
  instanceType: "TestFailoverWorkflowDetails";
}

@doc("VMware DRA model custom properties.")
model VMwareDraModelCustomProperties extends DraModelCustomProperties {
  @doc("Gets or sets the BIOS Id of the DRA machine.")
  biosId: string;

  @doc("Identity model.")
  marsAuthenticationIdentity: IdentityModel;

  @doc("Gets or sets the instance type.")
  instanceType: "VMware";
}

@doc("VMware migrate fabric model custom properties.")
model VMwareMigrateFabricModelCustomProperties
  extends FabricModelCustomProperties {
  @doc("Gets or sets the ARM Id of the VMware site.")
  vmwareSiteId: string;

  @doc("Gets or sets the ARM Id of the migration solution.")
  migrationSolutionId: string;

  @doc("Gets or sets the instance type.")
  instanceType: "VMwareMigrate";
}

@doc("VMwareToAzStack disk input.")
model VMwareToAzStackHCIDiskInput {
  @doc("Gets or sets the disk Id.")
  diskId: string;

  @doc("Gets or sets the target storage account ARM Id.")
  storageContainerId?: string;

  @doc("""
Gets or sets a value indicating whether dynamic sizing is enabled on the
virtual hard
disk.
""")
  isDynamic?: boolean;

  @doc("Gets or sets the disk size in GB.")
  diskSizeGB: int32;

  @doc("Gets or sets the type of the virtual hard disk, vhd or vhdx.")
  diskFileFormat: string;

  @doc("Gets or sets a value indicating whether disk is os disk.")
  isOsDisk: boolean;
}

@doc("VMwareToAzStackHCI NIC properties.")
model VMwareToAzStackHCINicInput {
  @doc("Gets or sets the NIC Id.")
  nicId: string;

  @doc("Gets or sets the NIC label.")
  label: string;

  @doc("Gets or sets the network name.")
  @visibility("read")
  networkName?: string;

  @doc("Gets or sets the target network Id within AzStackHCI Cluster.")
  targetNetworkId: string;

  @doc("Gets or sets the target test network Id within AzStackHCI Cluster.")
  testNetworkId: string;

  @doc("Gets or sets the selection type of the NIC.")
  selectionTypeForFailover: VMNicSelection;
}

@doc("VMware to AzStackHCI planned failover model custom properties.")
model VMwareToAzStackHCIPlannedFailoverModelCustomProperties
  extends PlannedFailoverModelCustomProperties {
  @doc("Gets or sets a value indicating whether VM needs to be shut down.")
  shutdownSourceVM: boolean;

  @doc("Gets or sets the instance type.")
  instanceType: "VMwareToAzStackHCI";
}

@doc("VMware To AzStackHCI Policy model custom properties.")
model VMwareToAzStackHCIPolicyModelCustomProperties
  extends PolicyModelCustomProperties {
  @doc("""
Gets or sets the duration in minutes until which the recovery points need to
be
stored.
""")
  recoveryPointHistoryInMinutes: int32;

  @doc("Gets or sets the crash consistent snapshot frequency (in minutes).")
  crashConsistentFrequencyInMinutes: int32;

  @doc("Gets or sets the app consistent snapshot frequency (in minutes).")
  appConsistentFrequencyInMinutes: int32;

  @doc("Gets or sets the instance type.")
  instanceType: "VMwareToAzStackHCI";
}

@doc("VMwareToAzStackHCI protected disk properties.")
model VMwareToAzStackHCIProtectedDiskProperties {
  @doc("Gets or sets the ARM Id of the storage container.")
  @visibility("read")
  storageContainerId?: string;

  @doc("Gets or sets the local path of the storage container.")
  @visibility("read")
  storageContainerLocalPath?: string;

  @doc("Gets or sets the source disk Id.")
  @visibility("read")
  sourceDiskId?: string;

  @doc("Gets or sets the source disk Name.")
  @visibility("read")
  sourceDiskName?: string;

  @doc("Gets or sets the seed disk name.")
  @visibility("read")
  seedDiskName?: string;

  @doc("Gets or sets the test failover clone disk.")
  @visibility("read")
  testMigrateDiskName?: string;

  @doc("Gets or sets the failover clone disk.")
  @visibility("read")
  migrateDiskName?: string;

  @doc("Gets or sets a value indicating whether the disk is the OS disk.")
  @visibility("read")
  isOsDisk?: boolean;

  @doc("Gets or sets the disk capacity in bytes.")
  @visibility("read")
  capacityInBytes?: int32;

  @doc("""
Gets or sets a value indicating whether dynamic sizing is enabled on the
virtual hard
disk.
""")
  @visibility("read")
  isDynamic?: boolean;

  @doc("Gets or sets the disk type.")
  @visibility("read")
  diskType?: string;
}

@doc("VMware to AzStackHCI Protected item model custom properties.")
model VMwareToAzStackHCIProtectedItemModelCustomProperties
  extends ProtectedItemModelCustomProperties {
  @doc("Gets or sets the location of the protected item.")
  @visibility("read")
  activeLocation?: ProtectedItemActiveLocation;

  @doc("Gets or sets the Target HCI Cluster ARM Id.")
  targetHciClusterId: string;

  @doc("Gets or sets the Target Arc Cluster Custom Location ARM Id.")
  targetArcClusterCustomLocationId: string;

  @doc("Gets or sets the Target AzStackHCI cluster name.")
  @visibility("read")
  targetAzStackHciClusterName?: string;

  @doc("Gets or sets the target storage container ARM Id.")
  storageContainerId: string;

  @doc("Gets or sets the target resource group ARM Id.")
  targetResourceGroupId: string;

  @doc("Gets or sets the target location.")
  @visibility("read")
  targetLocation?: string;

  @doc("Gets or sets the location of Azure Arc HCI custom location resource.")
  customLocationRegion: string;

  @doc("Gets or sets the list of disks to replicate.")
  disksToInclude: VMwareToAzStackHCIDiskInput[];

  @doc("Gets or sets the list of VM NIC to replicate.")
  nicsToInclude: VMwareToAzStackHCINicInput[];

  @doc("Gets or sets the list of protected disks.")
  @visibility("read")
  protectedDisks?: VMwareToAzStackHCIProtectedDiskProperties[];

  @doc("Gets or sets the VM NIC details.")
  @visibility("read")
  protectedNics?: VMwareToAzStackHCIProtectedNicProperties[];

  @doc("Gets or sets the BIOS Id of the target AzStackHCI VM.")
  @visibility("read")
  targetVmBiosId?: string;

  @doc("Gets or sets the target VM display name.")
  targetVmName?: string;

  @doc("""
Gets or sets the hypervisor generation of the virtual machine possible values
are 1,2.
""")
  hyperVGeneration: string;

  @doc("Gets or sets the target network Id within AzStackHCI Cluster.")
  targetNetworkId?: string;

  @doc("Gets or sets the target test network Id within AzStackHCI Cluster.")
  testNetworkId?: string;

  @doc("Gets or sets the target CPU cores.")
  targetCpuCores?: int32;

  @doc("Gets or sets a value indicating whether memory is dynamical.")
  isDynamicRam?: boolean;

  @doc("Protected item dynamic memory config.")
  dynamicMemoryConfig?: ProtectedItemDynamicMemoryConfig;

  @doc("Gets or sets the target memory in mega-bytes.")
  targetMemoryInMegaBytes?: int32;

  @doc("Gets or sets the type of the OS.")
  @visibility("read")
  osType?: string;

  @doc("Gets or sets the name of the OS.")
  @visibility("read")
  osName?: string;

  @doc("Gets or sets the firmware type.")
  @visibility("read")
  firmwareType?: string;

  @doc("Gets or sets the ARM Id of the discovered machine.")
  fabricDiscoveryMachineId: string;

  @doc("Gets or sets the source VM display name.")
  @visibility("read")
  sourceVmName?: string;

  @doc("Gets or sets the source VM CPU cores.")
  @visibility("read")
  sourceCpuCores?: int32;

  @doc("Gets or sets the source VM ram memory size in megabytes.")
  @visibility("read")
  sourceMemoryInMegaBytes?: float32;

  @doc("Gets or sets the run as account Id.")
  runAsAccountId: string;

  @doc("Gets or sets the source DRA name.")
  sourceDraName: string;

  @doc("Gets or sets the target DRA name.")
  targetDraName: string;

  @doc("Gets or sets the source appliance name.")
  @visibility("read")
  sourceApplianceName?: string;

  @doc("Gets or sets the target appliance name.")
  @visibility("read")
  targetApplianceName?: string;

  @doc("Gets or sets the recovery point Id to which the VM was failed over.")
  @visibility("read")
  failoverRecoveryPointId?: string;

  @doc("Gets or sets the last recovery point received time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  @doc("Gets or sets the last recovery point Id.")
  @visibility("read")
  lastRecoveryPointId?: string;

  @doc("""
Gets or sets the initial replication progress percentage. This is calculated
based on
total bytes processed for all disks in the source VM.
""")
  @visibility("read")
  initialReplicationProgressPercentage?: int32;

  @doc("Gets or sets the migration progress percentage.")
  @visibility("read")
  migrationProgressPercentage?: int32;

  @doc("Gets or sets the resume progress percentage.")
  @visibility("read")
  resumeProgressPercentage?: int32;

  @doc("""
Gets or sets the resync progress percentage. This is calculated based on total
bytes
processed for all disks in the source VM.
""")
  @visibility("read")
  resyncProgressPercentage?: int32;

  @doc("Gets or sets the resync retry count.")
  @visibility("read")
  resyncRetryCount?: int32;

  @doc("Gets or sets a value indicating whether resync is required.")
  @visibility("read")
  resyncRequired?: boolean;

  @doc("Gets or sets the resync state.")
  @visibility("read")
  resyncState?: VMwareToAzureMigrateResyncState;

  @doc("Gets or sets a value indicating whether auto resync is to be done.")
  performAutoResync?: boolean;

  @doc("Gets or sets the resume retry count.")
  @visibility("read")
  resumeRetryCount?: int32;

  @doc("Gets or sets the latest timestamp that replication status is updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplicationUpdateTime?: utcDateTime;

  @doc("Gets or sets the instance type.")
  instanceType: "VMwareToAzStackHCI";
}

@doc("VMwareToAzStackHCI NIC properties.")
model VMwareToAzStackHCIProtectedNicProperties {
  @doc("Gets or sets the NIC Id.")
  @visibility("read")
  nicId?: string;

  @doc("Gets or sets the NIC mac address.")
  @visibility("read")
  macAddress?: string;

  @doc("Gets or sets the NIC label.")
  @visibility("read")
  label?: string;

  @doc("Gets or sets a value indicating whether this is the primary NIC.")
  isPrimaryNic?: boolean;

  @doc("Gets or sets the network name.")
  @visibility("read")
  networkName?: string;

  @doc("Gets or sets the target network Id within AzStackHCI Cluster.")
  @visibility("read")
  targetNetworkId?: string;

  @doc("Gets or sets the target test network Id within AzStackHCI Cluster.")
  @visibility("read")
  testNetworkId?: string;

  @doc("Gets or sets the selection type of the NIC.")
  @visibility("read")
  selectionTypeForFailover?: VMNicSelection;
}

@doc("VMware to AzStackHCI Replication extension model custom properties.")
model VMwareToAzStackHCIReplicationExtensionModelCustomProperties
  extends ReplicationExtensionModelCustomProperties {
  @doc("Gets or sets the ARM Id of the source VMware fabric.")
  vmwareFabricArmId: string;

  @doc("Gets or sets the ARM Id of the VMware site.")
  @visibility("read")
  vmwareSiteId?: string;

  @doc("Gets or sets the ARM Id of the target AzStackHCI fabric.")
  azStackHciFabricArmId: string;

  @doc("Gets or sets the ARM Id of the AzStackHCI site.")
  @visibility("read")
  azStackHciSiteId?: string;

  @doc("Gets or sets the storage account Id.")
  storageAccountId?: string;

  @doc("Gets or sets the Sas Secret of storage account.")
  storageAccountSasSecretName?: string;

  @doc("Gets or sets the Uri of ASR.")
  @visibility("read")
  asrServiceUri?: string;

  @doc("Gets or sets the Uri of Rcm.")
  @visibility("read")
  rcmServiceUri?: string;

  @doc("Gets or sets the Uri of Gateway.")
  @visibility("read")
  gatewayServiceUri?: string;

  @doc("Gets or sets the gateway service Id of source.")
  @visibility("read")
  sourceGatewayServiceId?: string;

  @doc("Gets or sets the gateway service Id of target.")
  @visibility("read")
  targetGatewayServiceId?: string;

  @doc("Gets or sets the source storage container name.")
  @visibility("read")
  sourceStorageContainerName?: string;

  @doc("Gets or sets the target storage container name.")
  @visibility("read")
  targetStorageContainerName?: string;

  @doc("Gets or sets the resource location.")
  @visibility("read")
  resourceLocation?: string;

  @doc("Gets or sets the subscription.")
  @visibility("read")
  subscriptionId?: string;

  @doc("Gets or sets the resource group.")
  @visibility("read")
  resourceGroup?: string;

  @doc("Gets or sets the instance type.")
  instanceType: "VMwareToAzStackHCI";
}
