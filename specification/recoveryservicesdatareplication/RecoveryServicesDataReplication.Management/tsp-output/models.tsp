import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataReplication;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Gets or sets the provisioning state of the Dra.
 */
enum ProvisioningState {
  Canceled,
  Creating,
  Deleting,
  Deleted,
  Failed,
  Succeeded,
  Updating,
}

/**
 * Gets or sets the fabric health.
 */
enum HealthStatus {
  Normal,
  Warning,
  Critical,
}

/**
 * Gets or sets the protection state.
 */
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

/**
 * Gets or sets the test failover state.
 */
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

/**
 * Gets or sets the resynchronization state.
 */
enum ResynchronizationState {
  None,
  ResynchronizationInitiated,
  ResynchronizationCompleted,
  ResynchronizationFailed,
}

/**
 * Gets or sets the recovery point type.
 */
enum RecoveryPointType {
  ApplicationConsistent,
  CrashConsistent,
}

/**
 * Gets or sets the type of vault.
 */
enum ReplicationVaultType {
  DisasterRecovery,
  Migrate,
}

/**
 * Gets or sets the workflow state.
 */
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

/**
 * Gets or sets the object type.
 */
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

/**
 * Gets or sets the task state.
 */
enum TaskState {
  Pending,
  Started,
  Succeeded,
  Failed,
  Cancelled,
  Skipped,
}

/**
 * Gets or sets the selection type of the NIC.
 */
enum VMNicSelection {
  NotSelected,
  SelectedByUser,
  SelectedByDefault,
  SelectedByUserOverride,
}

/**
 * Gets or sets the location of the protected item.
 */
enum ProtectedItemActiveLocation {
  Primary,
  Recovery,
}

/**
 * Gets or sets the resync state.
 */
enum VMwareToAzureMigrateResyncState {
  None,
  PreparedForResynchronization,
  StartedResynchronization,
}

/**
 * Dra model properties.
 */
model DraModelProperties {
  /**
   * Gets or sets the Dra correlation Id.
   */
  @visibility("read")
  correlationId?: string;

  /**
   * Gets or sets the machine Id where Dra is running.
   */
  @minLength(1)
  machineId: string;

  /**
   * Gets or sets the machine name where Dra is running.
   */
  @minLength(1)
  machineName: string;

  /**
   * Identity model.
   */
  authenticationIdentity: IdentityModel;

  /**
   * Identity model.
   */
  resourceAccessIdentity: IdentityModel;

  /**
   * Gets or sets a value indicating whether Dra is responsive.
   */
  @visibility("read")
  isResponsive?: boolean;

  /**
   * Gets or sets the time when last heartbeat was sent by the Dra.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * Gets or sets the Dra version.
   */
  @visibility("read")
  versionNumber?: string;

  /**
   * Gets or sets the provisioning state of the Dra.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the list of health errors.
   */
  @visibility("read")
  healthErrors?: HealthErrorModel[];

  /**
   * Dra model custom properties.
   */
  customProperties: DraModelCustomProperties;
}

/**
 * Identity model.
 */
model IdentityModel {
  /**
   * Gets or sets the tenant Id of the SPN with which Dra communicates to service.
   */
  @minLength(1)
  tenantId: string;

  /**
   * Gets or sets the client/application Id of the SPN with which Dra communicates to
   * service.
   */
  @minLength(1)
  applicationId: string;

  /**
   * Gets or sets the object Id of the SPN with which Dra communicates to service.
   */
  @minLength(1)
  objectId: string;

  /**
   * Gets or sets the audience of the SPN with which Dra communicates to service.
   */
  @minLength(1)
  audience: string;

  /**
   * Gets or sets the authority of the SPN with which Dra communicates to service.
   */
  @minLength(1)
  aadAuthority: string;
}

/**
 * Health error model.
 */
model HealthErrorModel {
  /**
   * Gets or sets the type of affected resource type.
   */
  affectedResourceType?: string;

  /**
   * Gets or sets the list of affected resource correlation Ids. This can be used to
   * uniquely identify the count of items affected by a specific category and severity
   * as well as count of item affected by an specific issue.
   */
  affectedResourceCorrelationIds?: string[];

  /**
   * Gets or sets a list of child health errors associated with this error.
   */
  childErrors?: InnerHealthErrorModel[];

  /**
   * Gets or sets the error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Gets or sets the health category.
   */
  @visibility("read")
  healthCategory?: string;

  /**
   * Gets or sets the error category.
   */
  @visibility("read")
  category?: string;

  /**
   * Gets or sets the error severity.
   */
  @visibility("read")
  severity?: string;

  /**
   * Gets or sets the error source.
   */
  @visibility("read")
  source?: string;

  /**
   * Gets or sets the error creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets a value indicating whether the error is customer resolvable.
   */
  @visibility("read")
  isCustomerResolvable?: boolean;

  /**
   * Gets or sets the error summary.
   */
  @visibility("read")
  summary?: string;

  /**
   * Gets or sets the error message.
   */
  @visibility("read")
  message?: string;

  /**
   * Gets or sets possible causes of the error.
   */
  @visibility("read")
  causes?: string;

  /**
   * Gets or sets recommended action to resolve the error.
   */
  @visibility("read")
  recommendation?: string;
}

/**
 * Inner health error model.
 */
model InnerHealthErrorModel {
  /**
   * Gets or sets the error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Gets or sets the health category.
   */
  @visibility("read")
  healthCategory?: string;

  /**
   * Gets or sets the error category.
   */
  @visibility("read")
  category?: string;

  /**
   * Gets or sets the error severity.
   */
  @visibility("read")
  severity?: string;

  /**
   * Gets or sets the error source.
   */
  @visibility("read")
  source?: string;

  /**
   * Gets or sets the error creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets a value indicating whether the error is customer resolvable.
   */
  @visibility("read")
  isCustomerResolvable?: boolean;

  /**
   * Gets or sets the error summary.
   */
  @visibility("read")
  summary?: string;

  /**
   * Gets or sets the error message.
   */
  @visibility("read")
  message?: string;

  /**
   * Gets or sets possible causes of the error.
   */
  @visibility("read")
  causes?: string;

  /**
   * Gets or sets recommended action to resolve the error.
   */
  @visibility("read")
  recommendation?: string;
}

/**
 * Dra model custom properties.
 */
@discriminator("instanceType")
model DraModelCustomProperties {}

model DraModelSystemData extends SystemDataModel {}

/**
 * System data required to be defined for Azure resources.
 */
model SystemDataModel {
  /**
   * Gets or sets identity that created the resource.
   */
  createdBy?: string;

  /**
   * Gets or sets the type of identity that created the resource: user, application,
   * managedIdentity.
   */
  createdByType?: string;

  /**
   * Gets or sets the timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Gets or sets the identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * Gets or sets the type of identity that last modified the resource: user, application,
   * managedIdentity.
   */
  lastModifiedByType?: string;

  /**
   * Gets or sets the timestamp of resource last modification (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * Email configuration model properties.
 */
model EmailConfigurationModelProperties {
  /**
   * Gets or sets a value indicating whether to send email to subscription administrator.
   */
  sendToOwners: boolean;

  /**
   * Gets or sets the custom email address for sending emails.
   */
  customEmailAddresses?: string[];

  /**
   * Gets or sets the locale for the email notification.
   */
  locale?: string;
}

model EmailConfigurationModelSystemData extends SystemDataModel {}

/**
 * Event model properties.
 */
model EventModelProperties {
  /**
   * Gets or sets the resource type.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * Gets or sets the resource name.
   */
  @visibility("read")
  resourceName?: string;

  /**
   * Gets or sets the event type.
   */
  @visibility("read")
  eventType?: string;

  /**
   * Gets or sets the event name.
   */
  @visibility("read")
  eventName?: string;

  /**
   * Gets or sets the time at which the event occurred at source.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeOfOccurrence?: utcDateTime;

  /**
   * Gets or sets the event severity.
   */
  @visibility("read")
  severity?: string;

  /**
   * Gets or sets the event description.
   */
  @visibility("read")
  description?: string;

  /**
   * Gets or sets the event correlation Id.
   */
  @visibility("read")
  correlationId?: string;

  /**
   * Gets or sets the errors associated with this event.
   */
  @visibility("read")
  healthErrors?: HealthErrorModel[];

  /**
   * Event model custom properties.
   */
  customProperties: EventModelCustomProperties;
}

/**
 * Event model custom properties.
 */
@discriminator("instanceType")
model EventModelCustomProperties {}

model EventModelSystemData extends SystemDataModel {}

/**
 * Fabric model properties.
 */
model FabricModelProperties {
  /**
   * Gets or sets the provisioning state of the fabric.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the service endpoint.
   */
  @visibility("read")
  serviceEndpoint?: string;

  /**
   * Gets or sets the service resource Id.
   */
  @visibility("read")
  serviceResourceId?: string;

  /**
   * Gets or sets the fabric health.
   */
  @visibility("read")
  health?: HealthStatus;

  /**
   * Gets or sets the list of health errors.
   */
  @visibility("read")
  healthErrors?: HealthErrorModel[];

  /**
   * Fabric model custom properties.
   */
  customProperties: FabricModelCustomProperties;
}

/**
 * Fabric model custom properties.
 */
@discriminator("instanceType")
model FabricModelCustomProperties {}

model FabricModelSystemData extends SystemDataModel {}

/**
 * Fabric model for update.
 */
model FabricModelUpdate {
  /**
   * Gets or sets the resource tags.
   */
  tags?: Record<string>;

  /**
   * Fabric model properties.
   */
  properties?: FabricModelProperties;

  /**
   * Gets or sets the Id of the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Gets or sets the name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Gets or sets the type of the resource.
   */
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: FabricModelUpdateSystemData;
}

model FabricModelUpdateSystemData extends SystemDataModel {}

/**
 * Policy model properties.
 */
model PolicyModelProperties {
  /**
   * Gets or sets the provisioning state of the policy.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Policy model custom properties.
   */
  customProperties: PolicyModelCustomProperties;
}

/**
 * Policy model custom properties.
 */
@discriminator("instanceType")
model PolicyModelCustomProperties {}

model PolicyModelSystemData extends SystemDataModel {}

/**
 * Protected item model properties.
 */
model ProtectedItemModelProperties {
  /**
   * Gets or sets the policy name.
   */
  @minLength(1)
  policyName: string;

  /**
   * Gets or sets the replication extension name.
   */
  @minLength(1)
  replicationExtensionName: string;

  /**
   * Gets or sets the protected item correlation Id.
   */
  @visibility("read")
  correlationId?: string;

  /**
   * Gets or sets the provisioning state of the Dra.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the protection state.
   */
  @visibility("read")
  protectionState?: ProtectionState;

  /**
   * Gets or sets the protection state description.
   */
  @visibility("read")
  protectionStateDescription?: string;

  /**
   * Gets or sets the test failover state.
   */
  @visibility("read")
  testFailoverState?: TestFailoverState;

  /**
   * Gets or sets the Test failover state description.
   */
  @visibility("read")
  testFailoverStateDescription?: string;

  /**
   * Gets or sets the resynchronization state.
   */
  @visibility("read")
  resynchronizationState?: ResynchronizationState;

  /**
   * Gets or sets the fabric object Id.
   */
  @visibility("read")
  fabricObjectId?: string;

  /**
   * Gets or sets the fabric object name.
   */
  @visibility("read")
  fabricObjectName?: string;

  /**
   * Gets or sets the source fabric provider Id.
   */
  @visibility("read")
  sourceFabricProviderId?: string;

  /**
   * Gets or sets the target fabric provider Id.
   */
  @visibility("read")
  targetFabricProviderId?: string;

  /**
   * Gets or sets the fabric Id.
   */
  @visibility("read")
  fabricId?: string;

  /**
   * Gets or sets the target fabric Id.
   */
  @visibility("read")
  targetFabricId?: string;

  /**
   * Gets or sets the DRA Id.
   */
  @visibility("read")
  draId?: string;

  /**
   * Gets or sets the target DRA Id.
   */
  @visibility("read")
  targetDraId?: string;

  /**
   * Gets or sets a value indicating whether resynchronization is required or not.
   */
  @visibility("read")
  resyncRequired?: boolean;

  /**
   * Gets or sets the Last successful planned failover time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulPlannedFailoverTime?: utcDateTime;

  /**
   * Gets or sets the Last successful unplanned failover time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulUnplannedFailoverTime?: utcDateTime;

  /**
   * Gets or sets the Last successful test failover time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulTestFailoverTime?: utcDateTime;

  /**
   * Protected item job properties.
   */
  @visibility("read")
  currentJob?: ProtectedItemJobProperties;

  /**
   * Gets or sets the allowed scenarios on the protected item.
   */
  @visibility("read")
  allowedJobs?: string[];

  /**
   * Protected item job properties.
   */
  @visibility("read")
  lastFailedEnableProtectionJob?: ProtectedItemJobProperties;

  /**
   * Protected item job properties.
   */
  @visibility("read")
  lastFailedPlannedFailoverJob?: ProtectedItemJobProperties;

  /**
   * Protected item job properties.
   */
  @visibility("read")
  lastTestFailoverJob?: ProtectedItemJobProperties;

  /**
   * Gets or sets protected item replication health.
   */
  @visibility("read")
  replicationHealth?: HealthStatus;

  /**
   * Gets or sets the list of health errors.
   */
  @visibility("read")
  healthErrors?: HealthErrorModel[];

  /**
   * Protected item model custom properties.
   */
  customProperties: ProtectedItemModelCustomProperties;
}

/**
 * Protected item job properties.
 */
model ProtectedItemJobProperties {
  /**
   * Gets or sets protection scenario name.
   */
  @visibility("read")
  scenarioName?: string;

  /**
   * Gets or sets workflow Id.
   */
  @visibility("read")
  id?: string;

  /**
   * Gets or sets workflow name.
   */
  @visibility("read")
  name?: string;

  /**
   * Gets or sets the workflow friendly display name.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Gets or sets workflow state.
   */
  @visibility("read")
  state?: string;

  /**
   * Gets or sets start time of the workflow.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets end time of the workflow.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

/**
 * Protected item model custom properties.
 */
@discriminator("instanceType")
model ProtectedItemModelCustomProperties {}

model ProtectedItemModelSystemData extends SystemDataModel {}

/**
 * Planned failover model.
 */
model PlannedFailoverModel {
  /**
   * Planned failover model properties.
   */
  properties: PlannedFailoverModelProperties;
}

/**
 * Planned failover model properties.
 */
model PlannedFailoverModelProperties {
  /**
   * Planned failover model custom properties.
   */
  customProperties: PlannedFailoverModelCustomProperties;
}

/**
 * Planned failover model custom properties.
 */
@discriminator("instanceType")
model PlannedFailoverModelCustomProperties {}

/**
 * Recovery point model properties.
 */
model RecoveryPointModelProperties {
  /**
   * Gets or sets the recovery point time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime: utcDateTime;

  /**
   * Gets or sets the recovery point type.
   */
  recoveryPointType: RecoveryPointType;

  /**
   * Recovery point model custom properties.
   */
  customProperties: RecoveryPointModelCustomProperties;
}

/**
 * Recovery point model custom properties.
 */
@discriminator("instanceType")
model RecoveryPointModelCustomProperties {}

model RecoveryPointModelSystemData extends SystemDataModel {}

/**
 * Replication extension model properties.
 */
model ReplicationExtensionModelProperties {
  /**
   * Gets or sets the provisioning state of the replication extension.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Replication extension model custom properties.
   */
  customProperties: ReplicationExtensionModelCustomProperties;
}

/**
 * Replication extension model custom properties.
 */
@discriminator("instanceType")
model ReplicationExtensionModelCustomProperties {}

model ReplicationExtensionModelSystemData extends SystemDataModel {}

/**
 * Check name availability model.
 */
model CheckNameAvailabilityModel {
  /**
   * Gets or sets the resource name.
   */
  name?: string;

  /**
   * Gets or sets the resource type.
   */
  type?: string;
}

/**
 * Check name availability response model.
 */
model CheckNameAvailabilityResponseModel {
  /**
   * Gets or sets a value indicating whether resource name is available or not.
   */
  nameAvailable?: boolean;

  /**
   * Gets or sets the reason for resource name unavailability.
   */
  reason?: string;

  /**
   * Gets or sets the message for resource name unavailability.
   */
  message?: string;
}

/**
 * Deployment preflight model.
 */
model DeploymentPreflightModel {
  /**
   * Gets or sets the list of resources.
   */
  resources?: DeploymentPreflightResource[];
}

/**
 * Deployment preflight resource.
 */
model DeploymentPreflightResource {
  /**
   * Gets or sets the resource name.
   */
  name?: string;

  /**
   * Gets or sets the resource type.
   */
  type?: string;

  /**
   * Gets or sets the location of the resource.
   */
  @visibility("read", "create")
  location?: string;

  /**
   * Gets or sets the Api version.
   */
  apiVersion?: string;
}

/**
 * Vault properties.
 */
model VaultModelProperties {
  /**
   * Gets or sets the provisioning state of the vault.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the service resource Id.
   */
  @visibility("read")
  serviceResourceId?: string;

  /**
   * Gets or sets the type of vault.
   */
  vaultType?: ReplicationVaultType;
}

model VaultModelSystemData extends SystemDataModel {}

/**
 * Vault model for update.
 */
model VaultModelUpdate {
  /**
   * Gets or sets the resource tags.
   */
  tags?: Record<string>;

  /**
   * Vault properties.
   */
  properties?: VaultModelProperties;

  /**
   * Gets or sets the Id of the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Gets or sets the name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Gets or sets the type of the resource.
   */
  @visibility("read")
  type?: string;

  @visibility("read")
  systemData?: VaultModelUpdateSystemData;
}

model VaultModelUpdateSystemData extends SystemDataModel {}

/**
 * Workflow model properties.
 */
model WorkflowModelProperties {
  /**
   * Gets or sets the friendly display name.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Gets or sets the workflow state.
   */
  @visibility("read")
  state?: WorkflowState;

  /**
   * Gets or sets the start time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets the end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets or sets the affected object Id.
   */
  @visibility("read")
  objectId?: string;

  /**
   * Gets or sets the affected object name.
   */
  @visibility("read")
  objectName?: string;

  /**
   * Gets or sets the affected object internal Id.
   */
  @visibility("read")
  objectInternalId?: string;

  /**
   * Gets or sets the affected object internal name.
   */
  @visibility("read")
  objectInternalName?: string;

  /**
   * Gets or sets the object type.
   */
  @visibility("read")
  objectType?: WorkflowObjectType;

  /**
   * Gets or sets the replication provider.
   */
  @visibility("read")
  replicationProviderId?: string;

  /**
   * Gets or sets the source fabric provider.
   */
  @visibility("read")
  sourceFabricProviderId?: string;

  /**
   * Gets or sets the target fabric provider.
   */
  @visibility("read")
  targetFabricProviderId?: string;

  /**
   * Gets or sets the list of allowed actions on the workflow.
   */
  @visibility("read")
  allowedActions?: string[];

  /**
   * Gets or sets the workflow activity id.
   */
  @visibility("read")
  activityId?: string;

  /**
   * Gets or sets the list of tasks.
   */
  @visibility("read")
  tasks?: TaskModel[];

  /**
   * Gets or sets the list of errors.
   */
  @visibility("read")
  errors?: ErrorModel[];

  /**
   * Workflow model custom properties.
   */
  customProperties: WorkflowModelCustomProperties;
}

/**
 * Task model.
 */
model TaskModel {
  /**
   * Gets or sets the task name.
   */
  @visibility("read")
  taskName?: string;

  /**
   * Gets or sets the task state.
   */
  @visibility("read")
  state?: TaskState;

  /**
   * Gets or sets the start time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets the end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Task model custom properties.
   */
  customProperties?: TaskModelCustomProperties;

  /**
   * Gets or sets the list of children workflow models.
   */
  childrenWorkflows?: WorkflowModel[];
}

/**
 * Task model custom properties.
 */
model TaskModelCustomProperties {
  /**
   * Gets or sets the instance type.
   */
  @minLength(1)
  instanceType: string;
}

/**
 * Error model.
 */
model ErrorModel {
  /**
   * Gets or sets the error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Gets or sets the error type.
   */
  @visibility("read")
  type?: string;

  /**
   * Gets or sets the error severity.
   */
  @visibility("read")
  severity?: string;

  /**
   * Gets or sets the creation time of error.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the error message.
   */
  @visibility("read")
  message?: string;

  /**
   * Gets or sets the possible causes of error.
   */
  @visibility("read")
  causes?: string;

  /**
   * Gets or sets the recommended action to resolve error.
   */
  @visibility("read")
  recommendation?: string;
}

/**
 * Workflow model custom properties.
 */
@discriminator("instanceType")
model WorkflowModelCustomProperties {
  /**
   * Gets or sets any custom properties of the affected object.
   */
  @visibility("read")
  affectedObjectDetails?: Record<string>;
}

model WorkflowModelSystemData extends SystemDataModel {}

/**
 * AzStackHCI cluster properties.
 */
model AzStackHCIClusterProperties {
  /**
   * Gets or sets the AzStackHCICluster FQDN name.
   */
  @minLength(1)
  clusterName: string;

  /**
   * Gets or sets the AzStackHCICluster resource name.
   */
  @minLength(1)
  resourceName: string;

  /**
   * Gets or sets the Storage account name.
   */
  @minLength(1)
  storageAccountName: string;

  /**
   * Gets or sets the list of AzStackHCICluster Storage Container.
   */
  storageContainers: StorageContainerProperties[];
}

/**
 * Storage container properties.
 */
model StorageContainerProperties {
  /**
   * Gets or sets the Name.
   */
  @minLength(1)
  name: string;

  /**
   * Gets or sets the ClusterSharedVolumePath.
   */
  @minLength(1)
  clusterSharedVolumePath: string;
}

/**
 * AzStackHCI fabric model custom properties.
 */
model AzStackHCIFabricModelCustomProperties
  extends FabricModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the AzStackHCI site.
   */
  @minLength(1)
  azStackHciSiteId: string;

  /**
   * Gets or sets the Appliance name.
   */
  @visibility("read")
  applianceName?: string[];

  /**
   * AzStackHCI cluster properties.
   */
  cluster: AzStackHCIClusterProperties;

  /**
   * Gets or sets the fabric resource Id.
   */
  @visibility("read")
  fabricResourceId?: string;

  /**
   * Gets or sets the fabric container Id.
   */
  @visibility("read")
  fabricContainerId?: string;

  /**
   * Gets or sets the Migration solution ARM Id.
   */
  @minLength(1)
  migrationSolutionId: string;

  /**
   * Gets or sets the migration hub Uri.
   */
  @visibility("read")
  migrationHubUri?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "AzStackHCI";
}

/**
 * Failover properties of the protected item.
 */
model FailoverProtectedItemProperties {
  /**
   * Gets or sets the protected item name.
   */
  @visibility("read")
  protectedItemName?: string;

  /**
   * Gets or sets the VM name.
   */
  @visibility("read")
  vmName?: string;

  /**
   * Gets or sets the test VM name.
   */
  @visibility("read")
  testVmName?: string;

  /**
   * Gets or sets the recovery point Id.
   */
  @visibility("read")
  recoveryPointId?: string;

  /**
   * Gets or sets the recovery point time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;

  /**
   * Gets or sets the network name.
   */
  @visibility("read")
  networkName?: string;

  /**
   * Gets or sets the network subnet.
   */
  @visibility("read")
  subnet?: string;
}

/**
 * Failover workflow model custom properties.
 */
model FailoverWorkflowModelCustomProperties
  extends WorkflowModelCustomProperties {
  /**
   * Gets or sets the failed over protected item details.
   */
  @visibility("read")
  protectedItemDetails?: FailoverProtectedItemProperties[];

  /**
   * Gets or sets the instance type.
   */
  instanceType: "FailoverWorkflowDetails";
}

/**
 * HyperV migrate fabric model custom properties.
 */
model HyperVMigrateFabricModelCustomProperties
  extends FabricModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the HyperV site.
   */
  @minLength(1)
  hyperVSiteId: string;

  /**
   * Gets or sets the fabric resource Id.
   */
  @visibility("read")
  fabricResourceId?: string;

  /**
   * Gets or sets the fabric container Id.
   */
  @visibility("read")
  fabricContainerId?: string;

  /**
   * Gets or sets the migration solution ARM Id.
   */
  @minLength(1)
  migrationSolutionId: string;

  /**
   * Gets or sets the migration hub Uri.
   */
  @visibility("read")
  migrationHubUri?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVMigrate";
}

/**
 * HyperVToAzStack disk input.
 */
model HyperVToAzStackHCIDiskInput {
  /**
   * Gets or sets the disk Id.
   */
  @minLength(1)
  diskId: string;

  /**
   * Gets or sets the target storage account ARM Id.
   */
  storageContainerId?: string;

  /**
   * Gets or sets a value indicating whether dynamic sizing is enabled on the virtual hard
   * disk.
   */
  isDynamic?: boolean;

  /**
   * Gets or sets the disk size in GB.
   */
  diskSizeGB: int64;

  /**
   * Gets or sets the type of the virtual hard disk, vhd or vhdx.
   */
  @minLength(1)
  diskFileFormat: string;

  /**
   * Gets or sets a value indicating whether disk is os disk.
   */
  isOsDisk: boolean;
}

/**
 * HyperV to  AzStackHCI event model custom properties. This class provides provider specific
 * details for events of type DataContract.HealthEvents.HealthEventType.ProtectedItemHealth and
 * DataContract.HealthEvents.HealthEventType.AgentHealth.
 */
model HyperVToAzStackHCIEventModelCustomProperties
  extends EventModelCustomProperties {
  /**
   * Gets or sets the friendly name of the source which has raised this health event.
   */
  @visibility("read")
  eventSourceFriendlyName?: string;

  /**
   * Gets or sets the protected item friendly name.
   */
  @visibility("read")
  protectedItemFriendlyName?: string;

  /**
   * Gets or sets the source appliance name.
   */
  @visibility("read")
  sourceApplianceName?: string;

  /**
   * Gets or sets the source target name.
   */
  @visibility("read")
  targetApplianceName?: string;

  /**
   * Gets or sets the server type.
   */
  @visibility("read")
  serverType?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";
}

/**
 * HyperVToAzStackHCI NIC properties.
 */
model HyperVToAzStackHCINicInput {
  /**
   * Gets or sets the NIC Id.
   */
  @minLength(1)
  nicId: string;

  /**
   * Gets or sets the network name.
   */
  @visibility("read")
  networkName?: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  @minLength(1)
  targetNetworkId: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  @minLength(1)
  testNetworkId: string;

  /**
   * Gets or sets the selection type of the NIC.
   */
  selectionTypeForFailover: VMNicSelection;
}

/**
 * HyperV to AzStackHCI planned failover model custom properties.
 */
model HyperVToAzStackHCIPlannedFailoverModelCustomProperties
  extends PlannedFailoverModelCustomProperties {
  /**
   * Gets or sets a value indicating whether VM needs to be shut down.
   */
  shutdownSourceVM: boolean;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";
}

/**
 * HyperV To AzStackHCI Policy model custom properties.
 */
model HyperVToAzStackHCIPolicyModelCustomProperties
  extends PolicyModelCustomProperties {
  /**
   * Gets or sets the duration in minutes until which the recovery points need to be
   * stored.
   */
  recoveryPointHistoryInMinutes: int32;

  /**
   * Gets or sets the crash consistent snapshot frequency (in minutes).
   */
  crashConsistentFrequencyInMinutes: int32;

  /**
   * Gets or sets the app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes: int32;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";
}

/**
 * HyperVToAzStackHCI protected disk properties.
 */
model HyperVToAzStackHCIProtectedDiskProperties {
  /**
   * Gets or sets the ARM Id of the storage container.
   */
  @visibility("read")
  storageContainerId?: string;

  /**
   * Gets or sets the local path of the storage container.
   */
  @visibility("read")
  storageContainerLocalPath?: string;

  /**
   * Gets or sets the source disk Id.
   */
  @visibility("read")
  sourceDiskId?: string;

  /**
   * Gets or sets the source disk Name.
   */
  @visibility("read")
  sourceDiskName?: string;

  /**
   * Gets or sets the seed disk name.
   */
  @visibility("read")
  seedDiskName?: string;

  /**
   * Gets or sets the test failover clone disk.
   */
  @visibility("read")
  testMigrateDiskName?: string;

  /**
   * Gets or sets the failover clone disk.
   */
  @visibility("read")
  migrateDiskName?: string;

  /**
   * Gets or sets a value indicating whether the disk is the OS disk.
   */
  @visibility("read")
  isOsDisk?: boolean;

  /**
   * Gets or sets the disk capacity in bytes.
   */
  @visibility("read")
  capacityInBytes?: int64;

  /**
   * Gets or sets a value indicating whether dynamic sizing is enabled on the virtual hard
   * disk.
   */
  @visibility("read")
  isDynamic?: boolean;

  /**
   * Gets or sets the disk type.
   */
  @visibility("read")
  diskType?: string;
}

/**
 * HyperV to AzStackHCI Protected item model custom properties.
 */
model HyperVToAzStackHCIProtectedItemModelCustomProperties
  extends ProtectedItemModelCustomProperties {
  /**
   * Gets or sets the location of the protected item.
   */
  @visibility("read")
  activeLocation?: ProtectedItemActiveLocation;

  /**
   * Gets or sets the Target HCI Cluster ARM Id.
   */
  @minLength(1)
  targetHciClusterId: string;

  /**
   * Gets or sets the Target Arc Cluster Custom Location ARM Id.
   */
  @minLength(1)
  targetArcClusterCustomLocationId: string;

  /**
   * Gets or sets the Target AzStackHCI cluster name.
   */
  @visibility("read")
  targetAzStackHciClusterName?: string;

  /**
   * Gets or sets the ARM Id of the discovered machine.
   */
  @minLength(1)
  fabricDiscoveryMachineId: string;

  /**
   * Gets or sets the list of disks to replicate.
   */
  disksToInclude: HyperVToAzStackHCIDiskInput[];

  /**
   * Gets or sets the list of VM NIC to replicate.
   */
  nicsToInclude: HyperVToAzStackHCINicInput[];

  /**
   * Gets or sets the source VM display name.
   */
  @visibility("read")
  sourceVmName?: string;

  /**
   * Gets or sets the source VM CPU cores.
   */
  @visibility("read")
  sourceCpuCores?: int32;

  /**
   * Gets or sets the source VM ram memory size in megabytes.
   */
  @visibility("read")
  sourceMemoryInMegaBytes?: float64;

  /**
   * Gets or sets the target VM display name.
   */
  targetVmName?: string;

  /**
   * Gets or sets the target resource group ARM Id.
   */
  @minLength(1)
  targetResourceGroupId: string;

  /**
   * Gets or sets the target storage container ARM Id.
   */
  @minLength(1)
  storageContainerId: string;

  /**
   * Gets or sets the hypervisor generation of the virtual machine.
   */
  @minLength(1)
  hyperVGeneration: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  targetNetworkId?: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  testNetworkId?: string;

  /**
   * Gets or sets the target CPU cores.
   */
  targetCpuCores?: int32;

  /**
   * Gets or sets a value indicating whether memory is dynamical.
   */
  isDynamicRam?: boolean;

  /**
   * Protected item dynamic memory config.
   */
  dynamicMemoryConfig?: ProtectedItemDynamicMemoryConfig;

  /**
   * Gets or sets the target memory in mega-bytes.
   */
  targetMemoryInMegaBytes?: int32;

  /**
   * Gets or sets the Run As account Id.
   */
  @minLength(1)
  runAsAccountId: string;

  /**
   * Gets or sets the source DRA name.
   */
  @minLength(1)
  sourceDraName: string;

  /**
   * Gets or sets the target DRA name.
   */
  @minLength(1)
  targetDraName: string;

  /**
   * Gets or sets the source appliance name.
   */
  @visibility("read")
  sourceApplianceName?: string;

  /**
   * Gets or sets the target appliance name.
   */
  @visibility("read")
  targetApplianceName?: string;

  /**
   * Gets or sets the type of the OS.
   */
  @visibility("read")
  osType?: string;

  /**
   * Gets or sets the name of the OS.
   */
  @visibility("read")
  osName?: string;

  /**
   * Gets or sets the firmware type.
   */
  @visibility("read")
  firmwareType?: string;

  /**
   * Gets or sets the target location.
   */
  @visibility("read")
  targetLocation?: string;

  /**
   * Gets or sets the location of Azure Arc HCI custom location resource.
   */
  @minLength(1)
  customLocationRegion: string;

  /**
   * Gets or sets the recovery point Id to which the VM was failed over.
   */
  @visibility("read")
  failoverRecoveryPointId?: string;

  /**
   * Gets or sets the last recovery point received time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  /**
   * Gets or sets the last recovery point Id.
   */
  @visibility("read")
  lastRecoveryPointId?: string;

  /**
   * Gets or sets the initial replication progress percentage. This is calculated based on
   * total bytes processed for all disks in the source VM.
   */
  @visibility("read")
  initialReplicationProgressPercentage?: int32;

  /**
   * Gets or sets the resync progress percentage. This is calculated based on total bytes
   * processed for all disks in the source VM.
   */
  @visibility("read")
  resyncProgressPercentage?: int32;

  /**
   * Gets or sets the list of protected disks.
   */
  @visibility("read")
  protectedDisks?: HyperVToAzStackHCIProtectedDiskProperties[];

  /**
   * Gets or sets the VM NIC details.
   */
  @visibility("read")
  protectedNics?: HyperVToAzStackHCIProtectedNicProperties[];

  /**
   * Gets or sets the BIOS Id of the target AzStackHCI VM.
   */
  @visibility("read")
  targetVmBiosId?: string;

  /**
   * Gets or sets the latest timestamp that replication status is updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplicationUpdateTime?: utcDateTime;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";
}

/**
 * Protected item dynamic memory config.
 */
model ProtectedItemDynamicMemoryConfig {
  /**
   * Gets or sets maximum memory in MB.
   */
  maximumMemoryInMegaBytes: int64;

  /**
   * Gets or sets minimum memory in MB.
   */
  minimumMemoryInMegaBytes: int64;

  /**
   * Gets or sets target memory buffer in %.
   */
  targetMemoryBufferPercentage: int32;
}

/**
 * HyperVToAzStackHCI NIC properties.
 */
model HyperVToAzStackHCIProtectedNicProperties {
  /**
   * Gets or sets the NIC Id.
   */
  @visibility("read")
  nicId?: string;

  /**
   * Gets or sets the NIC mac address.
   */
  @visibility("read")
  macAddress?: string;

  /**
   * Gets or sets the network name.
   */
  @visibility("read")
  networkName?: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  @visibility("read")
  targetNetworkId?: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  @visibility("read")
  testNetworkId?: string;

  /**
   * Gets or sets the selection type of the NIC.
   */
  @visibility("read")
  selectionTypeForFailover?: VMNicSelection;
}

/**
 * HyperV to AzStackHCI recovery point model custom properties.
 */
model HyperVToAzStackHCIRecoveryPointModelCustomProperties
  extends RecoveryPointModelCustomProperties {
  /**
   * Gets or sets the list of the disk Ids.
   */
  @visibility("read")
  diskIds?: string[];

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";
}

/**
 * HyperV to AzStackHCI Replication extension model custom properties.
 */
model HyperVToAzStackHCIReplicationExtensionModelCustomProperties
  extends ReplicationExtensionModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the source HyperV fabric.
   */
  @minLength(1)
  hyperVFabricArmId: string;

  /**
   * Gets or sets the ARM Id of the HyperV site.
   */
  @visibility("read")
  hyperVSiteId?: string;

  /**
   * Gets or sets the ARM Id of the target AzStackHCI fabric.
   */
  @minLength(1)
  azStackHciFabricArmId: string;

  /**
   * Gets or sets the ARM Id of the AzStackHCI site.
   */
  @visibility("read")
  azStackHciSiteId?: string;

  /**
   * Gets or sets the storage account Id.
   */
  storageAccountId?: string;

  /**
   * Gets or sets the Sas Secret of storage account.
   */
  storageAccountSasSecretName?: string;

  /**
   * Gets or sets the Uri of ASR.
   */
  @visibility("read")
  asrServiceUri?: string;

  /**
   * Gets or sets the Uri of Rcm.
   */
  @visibility("read")
  rcmServiceUri?: string;

  /**
   * Gets or sets the Uri of Gateway.
   */
  @visibility("read")
  gatewayServiceUri?: string;

  /**
   * Gets or sets the gateway service Id of source.
   */
  @visibility("read")
  sourceGatewayServiceId?: string;

  /**
   * Gets or sets the gateway service Id of target.
   */
  @visibility("read")
  targetGatewayServiceId?: string;

  /**
   * Gets or sets the source storage container name.
   */
  @visibility("read")
  sourceStorageContainerName?: string;

  /**
   * Gets or sets the target storage container name.
   */
  @visibility("read")
  targetStorageContainerName?: string;

  /**
   * Gets or sets the resource location.
   */
  @visibility("read")
  resourceLocation?: string;

  /**
   * Gets or sets the subscription.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * Gets or sets the resource group.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";
}

/**
 * Operation model.
 */
model OperationModel {
  /**
   * Gets or sets the name of the operation.
   */
  name?: string;

  /**
   * Gets or sets a value indicating whether the action is specific to data plane or
   * control plane.
   */
  isDataAction?: boolean;

  /**
   * Gets or sets the executor of the operation.
   */
  origin?: string;

  /**
   * Operation model properties.
   */
  display?: OperationModelProperties;
}

/**
 * Operation model properties.
 */
model OperationModelProperties {
  /**
   * Gets or sets the resource provider name.
   */
  provider?: string;

  /**
   * Gets or sets resource name.
   */
  resource?: string;

  /**
   * Gets or sets the operation.
   */
  operation?: string;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * Available operations of the service.
 */
model OperationModelCollection {
  /**
   * Gets or sets the list of operations.
   */
  value?: OperationModel[];

  /**
   * Gets or sets the value of next link.
   */
  nextLink?: string;
}

/**
 * Defines the operation status.
 */
model OperationStatus {
  /**
   * Gets or sets the Id.
   */
  id?: string;

  /**
   * Gets or sets the operation name.
   */
  name?: string;

  /**
   * Gets or sets the status of the operation. ARM expects the terminal status to be one of
   * Succeeded/ Failed/ Canceled. All other values imply that the operation is still running.
   */
  status?: string;

  /**
   * Gets or sets the start time.
   */
  startTime?: string;

  /**
   * Gets or sets the end time.
   */
  endTime?: string;
}

/**
 * Test failover cleanup workflow model custom properties.
 */
model TestFailoverCleanupWorkflowModelCustomProperties
  extends WorkflowModelCustomProperties {
  /**
   * Gets or sets the test failover cleanup comments.
   */
  @visibility("read")
  comments?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "TestFailoverCleanupWorkflowDetails";
}

/**
 * Test failover workflow model custom properties.
 */
model TestFailoverWorkflowModelCustomProperties
  extends WorkflowModelCustomProperties {
  /**
   * Gets or sets the test VM details.
   */
  @visibility("read")
  protectedItemDetails?: FailoverProtectedItemProperties[];

  /**
   * Gets or sets the instance type.
   */
  instanceType: "TestFailoverWorkflowDetails";
}

/**
 * VMware DRA model custom properties.
 */
model VMwareDraModelCustomProperties extends DraModelCustomProperties {
  /**
   * Gets or sets the BIOS Id of the DRA machine.
   */
  @minLength(1)
  biosId: string;

  /**
   * Identity model.
   */
  marsAuthenticationIdentity: IdentityModel;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMware";
}

/**
 * VMware migrate fabric model custom properties.
 */
model VMwareMigrateFabricModelCustomProperties
  extends FabricModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the VMware site.
   */
  @minLength(1)
  vmwareSiteId: string;

  /**
   * Gets or sets the ARM Id of the migration solution.
   */
  @minLength(1)
  migrationSolutionId: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareMigrate";
}

/**
 * VMwareToAzStack disk input.
 */
model VMwareToAzStackHCIDiskInput {
  /**
   * Gets or sets the disk Id.
   */
  @minLength(1)
  diskId: string;

  /**
   * Gets or sets the target storage account ARM Id.
   */
  storageContainerId?: string;

  /**
   * Gets or sets a value indicating whether dynamic sizing is enabled on the virtual hard
   * disk.
   */
  isDynamic?: boolean;

  /**
   * Gets or sets the disk size in GB.
   */
  diskSizeGB: int64;

  /**
   * Gets or sets the type of the virtual hard disk, vhd or vhdx.
   */
  @minLength(1)
  diskFileFormat: string;

  /**
   * Gets or sets a value indicating whether disk is os disk.
   */
  isOsDisk: boolean;
}

/**
 * VMwareToAzStackHCI NIC properties.
 */
model VMwareToAzStackHCINicInput {
  /**
   * Gets or sets the NIC Id.
   */
  @minLength(1)
  nicId: string;

  /**
   * Gets or sets the NIC label.
   */
  @minLength(1)
  label: string;

  /**
   * Gets or sets the network name.
   */
  @visibility("read")
  networkName?: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  @minLength(1)
  targetNetworkId: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  @minLength(1)
  testNetworkId: string;

  /**
   * Gets or sets the selection type of the NIC.
   */
  selectionTypeForFailover: VMNicSelection;
}

/**
 * VMware to AzStackHCI planned failover model custom properties.
 */
model VMwareToAzStackHCIPlannedFailoverModelCustomProperties
  extends PlannedFailoverModelCustomProperties {
  /**
   * Gets or sets a value indicating whether VM needs to be shut down.
   */
  shutdownSourceVM: boolean;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareToAzStackHCI";
}

/**
 * VMware To AzStackHCI Policy model custom properties.
 */
model VMwareToAzStackHCIPolicyModelCustomProperties
  extends PolicyModelCustomProperties {
  /**
   * Gets or sets the duration in minutes until which the recovery points need to be
   * stored.
   */
  recoveryPointHistoryInMinutes: int32;

  /**
   * Gets or sets the crash consistent snapshot frequency (in minutes).
   */
  crashConsistentFrequencyInMinutes: int32;

  /**
   * Gets or sets the app consistent snapshot frequency (in minutes).
   */
  appConsistentFrequencyInMinutes: int32;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareToAzStackHCI";
}

/**
 * VMwareToAzStackHCI protected disk properties.
 */
model VMwareToAzStackHCIProtectedDiskProperties {
  /**
   * Gets or sets the ARM Id of the storage container.
   */
  @visibility("read")
  storageContainerId?: string;

  /**
   * Gets or sets the local path of the storage container.
   */
  @visibility("read")
  storageContainerLocalPath?: string;

  /**
   * Gets or sets the source disk Id.
   */
  @visibility("read")
  sourceDiskId?: string;

  /**
   * Gets or sets the source disk Name.
   */
  @visibility("read")
  sourceDiskName?: string;

  /**
   * Gets or sets the seed disk name.
   */
  @visibility("read")
  seedDiskName?: string;

  /**
   * Gets or sets the test failover clone disk.
   */
  @visibility("read")
  testMigrateDiskName?: string;

  /**
   * Gets or sets the failover clone disk.
   */
  @visibility("read")
  migrateDiskName?: string;

  /**
   * Gets or sets a value indicating whether the disk is the OS disk.
   */
  @visibility("read")
  isOsDisk?: boolean;

  /**
   * Gets or sets the disk capacity in bytes.
   */
  @visibility("read")
  capacityInBytes?: int64;

  /**
   * Gets or sets a value indicating whether dynamic sizing is enabled on the virtual hard
   * disk.
   */
  @visibility("read")
  isDynamic?: boolean;

  /**
   * Gets or sets the disk type.
   */
  @visibility("read")
  diskType?: string;
}

/**
 * VMware to AzStackHCI Protected item model custom properties.
 */
model VMwareToAzStackHCIProtectedItemModelCustomProperties
  extends ProtectedItemModelCustomProperties {
  /**
   * Gets or sets the location of the protected item.
   */
  @visibility("read")
  activeLocation?: ProtectedItemActiveLocation;

  /**
   * Gets or sets the Target HCI Cluster ARM Id.
   */
  @minLength(1)
  targetHciClusterId: string;

  /**
   * Gets or sets the Target Arc Cluster Custom Location ARM Id.
   */
  @minLength(1)
  targetArcClusterCustomLocationId: string;

  /**
   * Gets or sets the Target AzStackHCI cluster name.
   */
  @visibility("read")
  targetAzStackHciClusterName?: string;

  /**
   * Gets or sets the target storage container ARM Id.
   */
  @minLength(1)
  storageContainerId: string;

  /**
   * Gets or sets the target resource group ARM Id.
   */
  @minLength(1)
  targetResourceGroupId: string;

  /**
   * Gets or sets the target location.
   */
  @visibility("read")
  targetLocation?: string;

  /**
   * Gets or sets the location of Azure Arc HCI custom location resource.
   */
  @minLength(1)
  customLocationRegion: string;

  /**
   * Gets or sets the list of disks to replicate.
   */
  disksToInclude: VMwareToAzStackHCIDiskInput[];

  /**
   * Gets or sets the list of VM NIC to replicate.
   */
  nicsToInclude: VMwareToAzStackHCINicInput[];

  /**
   * Gets or sets the list of protected disks.
   */
  @visibility("read")
  protectedDisks?: VMwareToAzStackHCIProtectedDiskProperties[];

  /**
   * Gets or sets the VM NIC details.
   */
  @visibility("read")
  protectedNics?: VMwareToAzStackHCIProtectedNicProperties[];

  /**
   * Gets or sets the BIOS Id of the target AzStackHCI VM.
   */
  @visibility("read")
  targetVmBiosId?: string;

  /**
   * Gets or sets the target VM display name.
   */
  targetVmName?: string;

  /**
   * Gets or sets the hypervisor generation of the virtual machine possible values are 1,2.
   */
  @minLength(1)
  hyperVGeneration: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  targetNetworkId?: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  testNetworkId?: string;

  /**
   * Gets or sets the target CPU cores.
   */
  targetCpuCores?: int32;

  /**
   * Gets or sets a value indicating whether memory is dynamical.
   */
  isDynamicRam?: boolean;

  /**
   * Protected item dynamic memory config.
   */
  dynamicMemoryConfig?: ProtectedItemDynamicMemoryConfig;

  /**
   * Gets or sets the target memory in mega-bytes.
   */
  targetMemoryInMegaBytes?: int32;

  /**
   * Gets or sets the type of the OS.
   */
  @visibility("read")
  osType?: string;

  /**
   * Gets or sets the name of the OS.
   */
  @visibility("read")
  osName?: string;

  /**
   * Gets or sets the firmware type.
   */
  @visibility("read")
  firmwareType?: string;

  /**
   * Gets or sets the ARM Id of the discovered machine.
   */
  @minLength(1)
  fabricDiscoveryMachineId: string;

  /**
   * Gets or sets the source VM display name.
   */
  @visibility("read")
  sourceVmName?: string;

  /**
   * Gets or sets the source VM CPU cores.
   */
  @visibility("read")
  sourceCpuCores?: int32;

  /**
   * Gets or sets the source VM ram memory size in megabytes.
   */
  @visibility("read")
  sourceMemoryInMegaBytes?: float64;

  /**
   * Gets or sets the run as account Id.
   */
  @minLength(1)
  runAsAccountId: string;

  /**
   * Gets or sets the source DRA name.
   */
  @minLength(1)
  sourceDraName: string;

  /**
   * Gets or sets the target DRA name.
   */
  @minLength(1)
  targetDraName: string;

  /**
   * Gets or sets the source appliance name.
   */
  @visibility("read")
  sourceApplianceName?: string;

  /**
   * Gets or sets the target appliance name.
   */
  @visibility("read")
  targetApplianceName?: string;

  /**
   * Gets or sets the recovery point Id to which the VM was failed over.
   */
  @visibility("read")
  failoverRecoveryPointId?: string;

  /**
   * Gets or sets the last recovery point received time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  /**
   * Gets or sets the last recovery point Id.
   */
  @visibility("read")
  lastRecoveryPointId?: string;

  /**
   * Gets or sets the initial replication progress percentage. This is calculated based on
   * total bytes processed for all disks in the source VM.
   */
  @visibility("read")
  initialReplicationProgressPercentage?: int32;

  /**
   * Gets or sets the migration progress percentage.
   */
  @visibility("read")
  migrationProgressPercentage?: int32;

  /**
   * Gets or sets the resume progress percentage.
   */
  @visibility("read")
  resumeProgressPercentage?: int32;

  /**
   * Gets or sets the resync progress percentage. This is calculated based on total bytes
   * processed for all disks in the source VM.
   */
  @visibility("read")
  resyncProgressPercentage?: int32;

  /**
   * Gets or sets the resync retry count.
   */
  @visibility("read")
  resyncRetryCount?: int64;

  /**
   * Gets or sets a value indicating whether resync is required.
   */
  @visibility("read")
  resyncRequired?: boolean;

  /**
   * Gets or sets the resync state.
   */
  @visibility("read")
  resyncState?: VMwareToAzureMigrateResyncState;

  /**
   * Gets or sets a value indicating whether auto resync is to be done.
   */
  performAutoResync?: boolean;

  /**
   * Gets or sets the resume retry count.
   */
  @visibility("read")
  resumeRetryCount?: int64;

  /**
   * Gets or sets the latest timestamp that replication status is updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplicationUpdateTime?: utcDateTime;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareToAzStackHCI";
}

/**
 * VMwareToAzStackHCI NIC properties.
 */
model VMwareToAzStackHCIProtectedNicProperties {
  /**
   * Gets or sets the NIC Id.
   */
  @visibility("read")
  nicId?: string;

  /**
   * Gets or sets the NIC mac address.
   */
  @visibility("read")
  macAddress?: string;

  /**
   * Gets or sets the NIC label.
   */
  @visibility("read")
  label?: string;

  /**
   * Gets or sets a value indicating whether this is the primary NIC.
   */
  isPrimaryNic?: boolean;

  /**
   * Gets or sets the network name.
   */
  @visibility("read")
  networkName?: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  @visibility("read")
  targetNetworkId?: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  @visibility("read")
  testNetworkId?: string;

  /**
   * Gets or sets the selection type of the NIC.
   */
  @visibility("read")
  selectionTypeForFailover?: VMNicSelection;
}

/**
 * VMware to AzStackHCI Replication extension model custom properties.
 */
model VMwareToAzStackHCIReplicationExtensionModelCustomProperties
  extends ReplicationExtensionModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the source VMware fabric.
   */
  @minLength(1)
  vmwareFabricArmId: string;

  /**
   * Gets or sets the ARM Id of the VMware site.
   */
  @visibility("read")
  vmwareSiteId?: string;

  /**
   * Gets or sets the ARM Id of the target AzStackHCI fabric.
   */
  @minLength(1)
  azStackHciFabricArmId: string;

  /**
   * Gets or sets the ARM Id of the AzStackHCI site.
   */
  @visibility("read")
  azStackHciSiteId?: string;

  /**
   * Gets or sets the storage account Id.
   */
  storageAccountId?: string;

  /**
   * Gets or sets the Sas Secret of storage account.
   */
  storageAccountSasSecretName?: string;

  /**
   * Gets or sets the Uri of ASR.
   */
  @visibility("read")
  asrServiceUri?: string;

  /**
   * Gets or sets the Uri of Rcm.
   */
  @visibility("read")
  rcmServiceUri?: string;

  /**
   * Gets or sets the Uri of Gateway.
   */
  @visibility("read")
  gatewayServiceUri?: string;

  /**
   * Gets or sets the gateway service Id of source.
   */
  @visibility("read")
  sourceGatewayServiceId?: string;

  /**
   * Gets or sets the gateway service Id of target.
   */
  @visibility("read")
  targetGatewayServiceId?: string;

  /**
   * Gets or sets the source storage container name.
   */
  @visibility("read")
  sourceStorageContainerName?: string;

  /**
   * Gets or sets the target storage container name.
   */
  @visibility("read")
  targetStorageContainerName?: string;

  /**
   * Gets or sets the resource location.
   */
  @visibility("read")
  resourceLocation?: string;

  /**
   * Gets or sets the subscription.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * Gets or sets the resource group.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareToAzStackHCI";
}

/**
 * General DRA model custom properties.
 */
model GeneralDraModelCustomProperties extends DraModelCustomProperties {
  /**
   * Gets or sets the instance type.
   */
  instanceType: "DraModelCustomProperties";
}

/**
 * General fabric model custom properties.
 */
model GeneralFabricModelCustomProperties extends FabricModelCustomProperties {
  /**
   * Gets or sets the instance type.
   */
  instanceType: "FabricModelCustomProperties";
}

/**
 * General Policy model custom properties.
 */
model GeneralPolicyModelCustomProperties extends PolicyModelCustomProperties {
  /**
   * Gets or sets the instance type.
   */
  instanceType: "PolicyModelCustomProperties";
}

/**
 * General Protected item model custom properties.
 */
model GeneralProtectedItemModelCustomProperties
  extends ProtectedItemModelCustomProperties {
  /**
   * Gets or sets the instance type.
   */
  instanceType: "ProtectedItemModelCustomProperties";
}

/**
 * General planned failover model custom properties.
 */
model GeneralPlannedFailoverModelCustomProperties
  extends PlannedFailoverModelCustomProperties {
  /**
   * Gets or sets the instance type.
   */
  instanceType: "PlannedFailoverModelCustomProperties";
}

/**
 * General Replication extension model custom properties.
 */
model GeneralReplicationExtensionModelCustomProperties
  extends ReplicationExtensionModelCustomProperties {
  /**
   * Gets or sets the instance type.
   */
  instanceType: "ReplicationExtensionModelCustomProperties";
}
