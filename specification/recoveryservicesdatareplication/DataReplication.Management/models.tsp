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
 * Gets or sets the provisioning state of the email configuration.
 */
union ProvisioningState {
  string,

  /**
   * Resource creation has been canceled
   */
  Canceled: "Canceled",

  /**
   * Resource is being created.
   */
  Creating: "Creating",

  /**
   * Resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * Resource has been deleted.
   */
  Deleted: "Deleted",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation/update succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Resource is being updated.
   */
  Updating: "Updating",
}

/**
 * Gets or sets the fabric health.
 */
union HealthStatus {
  string,

  /**
   * Healthy Status.
   */
  Normal: "Normal",

  /**
   * Warning Status.
   */
  Warning: "Warning",

  /**
   * Critical Status.
   */
  Critical: "Critical",
}

/**
 * Gets or sets the job state.
 */
union JobState {
  string,

  /**
   * Job has not been started.
   */
  Pending: "Pending",

  /**
   * Job is in progress.
   */
  Started: "Started",

  /**
   * Job cancellation is in progress.
   */
  Cancelling: "Cancelling",

  /**
   * Job has completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * Job failed.
   */
  Failed: "Failed",

  /**
   * Job has been cancelled.
   */
  Cancelled: "Cancelled",

  /**
   * Job has completed with information.
   */
  CompletedWithInformation: "CompletedWithInformation",

  /**
   * Job has completed with warnings.
   */
  CompletedWithWarnings: "CompletedWithWarnings",

  /**
   * Job has completed with errors.
   */
  CompletedWithErrors: "CompletedWithErrors",
}

/**
 * Gets or sets the object type.
 */
union JobObjectType {
  string,

  /**
   * AVS disk pool.
   */
  AvsDiskPool: "AvsDiskPool",

  /**
   * Fabric agent level workflow.
   */
  FabricAgent: "FabricAgent",

  /**
   * Fabric level job.
   */
  Fabric: "Fabric",

  /**
   * Policy level job.
   */
  Policy: "Policy",

  /**
   * Protected item level job.
   */
  ProtectedItem: "ProtectedItem",

  /**
   * Recovery plan level job.
   */
  RecoveryPlan: "RecoveryPlan",

  /**
   * Replication extension level job.
   */
  ReplicationExtension: "ReplicationExtension",

  /**
   * Vault level job.
   */
  Vault: "Vault",
}

/**
 * Gets or sets the task state.
 */
union TaskState {
  string,

  /**
   * Task has not been started.
   */
  Pending: "Pending",

  /**
   * Task is in progress.
   */
  Started: "Started",

  /**
   * Task has completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * Task failed.
   */
  Failed: "Failed",

  /**
   * Task has been cancelled.
   */
  Cancelled: "Cancelled",

  /**
   * Task has been skipped.
   */
  Skipped: "Skipped",
}

/**
 * Gets or sets the status.
 */
union PrivateEndpointConnectionStatus {
  string,

  /**
   * Approved Status.
   */
  Approved: "Approved",

  /**
   * Disconnected Status.
   */
  Disconnected: "Disconnected",

  /**
   * Pending Status.
   */
  Pending: "Pending",

  /**
   * Rejected Status.
   */
  Rejected: "Rejected",
}

/**
 * Gets or sets the protection state.
 */
union ProtectionState {
  string,

  /**
   * Begin marker for unprotected states.
   */
  UnprotectedStatesBegin: "UnprotectedStatesBegin",

  /**
   * Enable protection is in progress.
   */
  EnablingProtection: "EnablingProtection",

  /**
   * Enable protection failed.
   */
  EnablingFailed: "EnablingFailed",

  /**
   * Disabling protection is in progress.
   */
  DisablingProtection: "DisablingProtection",

  /**
   * Disabling protection succeeded. This is a transient state before the protected item is deleted.
   */
  MarkedForDeletion: "MarkedForDeletion",

  /**
   * Disable protection failed.
   */
  DisablingFailed: "DisablingFailed",

  /**
   * End marker for unprotected states.
   */
  UnprotectedStatesEnd: "UnprotectedStatesEnd",

  /**
   * Begin marker for initial replication states.
   */
  InitialReplicationStatesBegin: "InitialReplicationStatesBegin",

  /**
   * Initial replication is in progress.
   */
  InitialReplicationInProgress: "InitialReplicationInProgress",

  /**
   * Initial replication has completed on the primary side.
   */
  InitialReplicationCompletedOnPrimary: "InitialReplicationCompletedOnPrimary",

  /**
   * Initial replication has completed on the recovery side.
   */
  InitialReplicationCompletedOnRecovery: "InitialReplicationCompletedOnRecovery",

  /**
   * Initial replication failed and would need to be started again.
   */
  InitialReplicationFailed: "InitialReplicationFailed",

  /**
   * End marker for initial replication states.
   */
  InitialReplicationStatesEnd: "InitialReplicationStatesEnd",

  /**
   * Begin marker for protected steady-state states.
   */
  ProtectedStatesBegin: "ProtectedStatesBegin",

  /**
   *  Protected item is protected and replication is on-going. Any issues with replication will be surfaced separately via the health property and will not affect the state.
   */
  Protected: "Protected",

  /**
   * End marker for protected steady-state states.
   */
  ProtectedStatesEnd: "ProtectedStatesEnd",

  /**
   * Begin marker for planned failover transition states.
   */
  PlannedFailoverTransitionStatesBegin: "PlannedFailoverTransitionStatesBegin",

  /**
   * Planned failover has been initiated.
   */
  PlannedFailoverInitiated: "PlannedFailoverInitiated",

  /**
   * Planned failover preparing protected entities is in progress.
   */
  PlannedFailoverCompleting: "PlannedFailoverCompleting",

  /**
   * Planned failover has been completed successfully.
   */
  PlannedFailoverCompleted: "PlannedFailoverCompleted",

  /**
   * Planned failover initiation failed.
   */
  PlannedFailoverFailed: "PlannedFailoverFailed",

  /**
   * Planned failover preparing protected entities failed.
   */
  PlannedFailoverCompletionFailed: "PlannedFailoverCompletionFailed",

  /**
   * End marker for planned failover transition states.
   */
  PlannedFailoverTransitionStatesEnd: "PlannedFailoverTransitionStatesEnd",

  /**
   * Begin marker for unplanned failover transition states.
   */
  UnplannedFailoverTransitionStatesBegin: "UnplannedFailoverTransitionStatesBegin",

  /**
   *  Unplanned failover has been initiated.
   */
  UnplannedFailoverInitiated: "UnplannedFailoverInitiated",

  /**
   * Unplanned failover preparing protected entities is in progress.
   */
  UnplannedFailoverCompleting: "UnplannedFailoverCompleting",

  /**
   * Unplanned failover preparing protected entities is in progress.
   */
  UnplannedFailoverCompleted: "UnplannedFailoverCompleted",

  /**
   * Unplanned failover initiation failed.
   */
  UnplannedFailoverFailed: "UnplannedFailoverFailed",

  /**
   * Unplanned failover preparing protected entities failed.
   */
  UnplannedFailoverCompletionFailed: "UnplannedFailoverCompletionFailed",

  /**
   * End marker for unplanned failover transition states.
   */
  UnplannedFailoverTransitionStatesEnd: "UnplannedFailoverTransitionStatesEnd",

  /**
   * Begin marker for commit failover states.
   */
  CommitFailoverStatesBegin: "CommitFailoverStatesBegin",

  /**
   * Commit failover is in progress on the primary side.
   */
  CommitFailoverInProgressOnPrimary: "CommitFailoverInProgressOnPrimary",

  /**
   * Commit failover is in progress on the recovery side.
   */
  CommitFailoverInProgressOnRecovery: "CommitFailoverInProgressOnRecovery",

  /**
   * Commit failover has been completed successfully.
   */
  CommitFailoverCompleted: "CommitFailoverCompleted",

  /**
   * Commit failover failed on the primary side.
   */
  CommitFailoverFailedOnPrimary: "CommitFailoverFailedOnPrimary",

  /**
   * Commit failover failed on the recovery side.
   */
  CommitFailoverFailedOnRecovery: "CommitFailoverFailedOnRecovery",

  /**
   * End marker for commit failover states.
   */
  CommitFailoverStatesEnd: "CommitFailoverStatesEnd",

  /**
   * Begin marker for cancel failover states.
   */
  CancelFailoverStatesBegin: "CancelFailoverStatesBegin",

  /**
   * Cancel failover is in progress on the primary side.
   */
  CancelFailoverInProgressOnPrimary: "CancelFailoverInProgressOnPrimary",

  /**
   * Cancel failover is in progress on the recovery side.
   */
  CancelFailoverInProgressOnRecovery: "CancelFailoverInProgressOnRecovery",

  /**
   * Cancel failover failed on the primary side.
   */
  CancelFailoverFailedOnPrimary: "CancelFailoverFailedOnPrimary",

  /**
   * Cancel failover failed on the recovery side.
   */
  CancelFailoverFailedOnRecovery: "CancelFailoverFailedOnRecovery",

  /**
   * End marker for cancel failover states.
   */
  CancelFailoverStatesEnd: "CancelFailoverStatesEnd",

  /**
   *  Begin marker for change recovery point states.
   */
  ChangeRecoveryPointStatesBegin: "ChangeRecoveryPointStatesBegin",

  /**
   * Change recovery point has been initiated..
   */
  ChangeRecoveryPointInitiated: "ChangeRecoveryPointInitiated",

  /**
   * Change recovery point has been completed successfully.
   */
  ChangeRecoveryPointCompleted: "ChangeRecoveryPointCompleted",

  /**
   * Change recovery point has failed.
   */
  ChangeRecoveryPointFailed: "ChangeRecoveryPointFailed",

  /**
   * End marker for change recovery point states.
   */
  ChangeRecoveryPointStatesEnd: "ChangeRecoveryPointStatesEnd",

  /**
   * Begin marker for reprotect states.
   */
  ReprotectStatesBegin: "ReprotectStatesBegin",

  /**
   * Reprotect has been initiated.
   */
  ReprotectInitiated: "ReprotectInitiated",

  /**
   * Reprotect has failed.
   */
  ReprotectFailed: "ReprotectFailed",

  /**
   * End marker for reprotect states.
   */
  ReprotectStatesEnd: "ReprotectStatesEnd",
}

/**
 * Gets or sets the test failover state.
 */
union TestFailoverState {
  string,

  /**
   * Test failover is not active.
   */
  None: "None",

  /**
   * Test failover has been initiated.
   */
  TestFailoverInitiated: "TestFailoverInitiated",

  /**
   * Preparing test protected entities is in progress.
   */
  TestFailoverCompleting: "TestFailoverCompleting",

  /**
   * Test failover has been completed successfully.
   */
  TestFailoverCompleted: "TestFailoverCompleted",

  /**
   * Test failover initiation failed..
   */
  TestFailoverFailed: "TestFailoverFailed",

  /**
   *  Preparing test protected entities failed.
   */
  TestFailoverCompletionFailed: "TestFailoverCompletionFailed",

  /**
   * Test failover cleanup has been initiated.
   */
  TestFailoverCleanupInitiated: "TestFailoverCleanupInitiated",

  /**
   * Cleaning up test protected entities is in progress.
   */
  TestFailoverCleanupCompleting: "TestFailoverCleanupCompleting",

  /**
   *  Test failover cleanup has completed/failed. This is a transient state before the state is moved back to None.
   */
  MarkedForDeletion: "MarkedForDeletion",
}

/**
 * Gets or sets the resynchronization state.
 */
union ResynchronizationState {
  string,

  /**
   * Resynchronization is not active.
   */
  None: "None",

  /**
   * Resynchronization has been initiated.
   */
  ResynchronizationInitiated: "ResynchronizationInitiated",

  /**
   * Resynchronization has been completed successfully.
   */
  ResynchronizationCompleted: "ResynchronizationCompleted",

  /**
   * Resynchronization has failed and would need to be started again.
   */
  ResynchronizationFailed: "ResynchronizationFailed",
}

/**
 * Gets or sets the recovery point type.
 */
union RecoveryPointType {
  string,

  /**
   * Application consistent recovery point.
   */
  ApplicationConsistent: "ApplicationConsistent",

  /**
   * Crash consistent recovery point.
   */
  CrashConsistent: "CrashConsistent",
}

/**
 * Gets or sets the type of vault.
 */
union ReplicationVaultType {
  string,

  /**
   * Disaster recovery vault.
   */
  DisasterRecovery: "DisasterRecovery",

  /**
   * Migrate vault.
   */
  Migrate: "Migrate",
}

/**
 * Gets or sets the identityType which can be either SystemAssigned or None.
 */
union VaultIdentityType {
  string,

  /**
   * No identity.
   */
  None: "None",

  /**
   * System assigned identity.
   */
  SystemAssigned: "SystemAssigned",

  /**
   * User assigned identity.
   */
  UserAssigned: "UserAssigned",
}

/**
 * Gets or sets the selection type of the NIC.
 */
union VMNicSelection {
  string,

  /**
   * Not Selected.
   */
  NotSelected: "NotSelected",

  /**
   * Selected by user.
   */
  SelectedByUser: "SelectedByUser",

  /**
   * Default selection by ASR.
   */
  SelectedByDefault: "SelectedByDefault",

  /**
   * NIC configuration overridden by user. Differs from SelectedByUser in the sense that the legacy SelectedByUser is used both for explicit modification by user and implicit approval of user if the settings are used for TFO/FO. SelectedByUserOverride implies user overriding at least one of the configurations.
   */
  SelectedByUserOverride: "SelectedByUserOverride",
}

/**
 * Gets or sets the location of the protected item.
 */
union ProtectedItemActiveLocation {
  string,

  /**
   * Protected item is active on Primary.
   */
  Primary: "Primary",

  /**
   * Protected item is active on Recovery.
   */
  Recovery: "Recovery",
}

/**
 * Gets or sets the resync state.
 */
union VMwareToAzureMigrateResyncState {
  string,

  /**
   * None state.
   */
  None: "None",

  /**
   * Prepared for resynchronization state.
   */
  PreparedForResynchronization: "PreparedForResynchronization",

  /**
   * Started resynchronization state.
   */
  StartedResynchronization: "StartedResynchronization",
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

  /**
   * Gets or sets the provisioning state of the email configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Event model properties.
 */
model EventModelProperties {
  /**
   * Gets or sets the resource type.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * Gets or sets the resource name.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * Gets or sets the event type.
   */
  @visibility(Lifecycle.Read)
  eventType?: string;

  /**
   * Gets or sets the event name.
   */
  @visibility(Lifecycle.Read)
  eventName?: string;

  /**
   * Gets or sets the time at which the event occurred at source.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeOfOccurrence?: utcDateTime;

  /**
   * Gets or sets the event severity.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Gets or sets the event description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Gets or sets the event correlation Id.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * Gets or sets the errors associated with this event.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  healthErrors?: HealthErrorModel[];

  /**
   * Event model custom properties.
   */
  customProperties: EventModelCustomProperties;

  /**
   * Gets or sets the provisioning state of the event.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
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
   * Gets or sets the list of affected resource correlation Ids. This can be used to uniquely identify the count of items affected by a specific category and severity as well as count of item affected by an specific issue.
   */
  affectedResourceCorrelationIds?: string[];

  /**
   * Gets or sets a list of child health errors associated with this error.
   */
  @identifiers(#[])
  childErrors?: InnerHealthErrorModel[];

  /**
   * Gets or sets the error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets or sets the health category.
   */
  @visibility(Lifecycle.Read)
  healthCategory?: string;

  /**
   * Gets or sets the error category.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * Gets or sets the error severity.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Gets or sets the error source.
   */
  @visibility(Lifecycle.Read)
  source?: string;

  /**
   * Gets or sets the error creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets a value indicating whether the error is customer resolvable.
   */
  @visibility(Lifecycle.Read)
  isCustomerResolvable?: boolean;

  /**
   * Gets or sets the error summary.
   */
  @visibility(Lifecycle.Read)
  summary?: string;

  /**
   * Gets or sets the error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Gets or sets possible causes of the error.
   */
  @visibility(Lifecycle.Read)
  causes?: string;

  /**
   * Gets or sets recommended action to resolve the error.
   */
  @visibility(Lifecycle.Read)
  recommendation?: string;
}

/**
 * Inner health error model.
 */
model InnerHealthErrorModel {
  /**
   * Gets or sets the error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets or sets the health category.
   */
  @visibility(Lifecycle.Read)
  healthCategory?: string;

  /**
   * Gets or sets the error category.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * Gets or sets the error severity.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Gets or sets the error source.
   */
  @visibility(Lifecycle.Read)
  source?: string;

  /**
   * Gets or sets the error creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets a value indicating whether the error is customer resolvable.
   */
  @visibility(Lifecycle.Read)
  isCustomerResolvable?: boolean;

  /**
   * Gets or sets the error summary.
   */
  @visibility(Lifecycle.Read)
  summary?: string;

  /**
   * Gets or sets the error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Gets or sets possible causes of the error.
   */
  @visibility(Lifecycle.Read)
  causes?: string;

  /**
   * Gets or sets recommended action to resolve the error.
   */
  @visibility(Lifecycle.Read)
  recommendation?: string;
}

/**
 * Event model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@discriminator("instanceType")
model EventModelCustomProperties {}

/**
 * Fabric model properties.
 */
model FabricModelProperties {
  /**
   * Gets or sets the provisioning state of the fabric.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the service endpoint.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * Gets or sets the service resource Id.
   */
  @visibility(Lifecycle.Read)
  serviceResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the fabric health.
   */
  @visibility(Lifecycle.Read)
  health?: HealthStatus;

  /**
   * Gets or sets the list of health errors.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  healthErrors?: HealthErrorModel[];

  /**
   * Fabric model custom properties.
   */
  customProperties: FabricModelCustomProperties;
}

/**
 * Fabric model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@discriminator("instanceType")
model FabricModelCustomProperties {}

/**
 * Fabric model update.
 */
model FabricModelUpdate {
  /**
   * Gets or sets the resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;

  /**
   * Fabric model properties.
   */
  properties?: FabricModelProperties;

  /**
   * Gets or sets the Id of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets or sets the name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets the type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Fabric agent model properties.
 */
model FabricAgentModelProperties {
  /**
   * Gets or sets the fabric agent correlation Id.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * Gets or sets the machine Id where fabric agent is running.
   */
  @minLength(1)
  machineId: string;

  /**
   * Gets or sets the machine name where fabric agent is running.
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
   * Gets or sets a value indicating whether the fabric agent is responsive.
   */
  @visibility(Lifecycle.Read)
  isResponsive?: boolean;

  /**
   * Gets or sets the time when last heartbeat was sent by the fabric agent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartbeat?: utcDateTime;

  /**
   * Gets or sets the fabric agent version.
   */
  @visibility(Lifecycle.Read)
  versionNumber?: string;

  /**
   * Gets or sets the provisioning state of the fabric agent.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the list of health errors.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  healthErrors?: HealthErrorModel[];

  /**
   * Fabric agent model custom properties.
   */
  customProperties: FabricAgentModelCustomProperties;
}

/**
 * Identity model.
 */
model IdentityModel {
  /**
   * Gets or sets the tenant Id of the SPN with which fabric agent communicates to service.
   */
  @minLength(1)
  tenantId: string;

  /**
   * Gets or sets the client/application Id of the SPN with which fabric agent communicates to service.
   */
  @minLength(1)
  applicationId: string;

  /**
   * Gets or sets the object Id of the SPN with which fabric agent communicates to service.
   */
  @minLength(1)
  objectId: string;

  /**
   * Gets or sets the audience of the SPN with which fabric agent communicates to service.
   */
  @minLength(1)
  audience: string;

  /**
   * Gets or sets the authority of the SPN with which fabric agent communicates to service.
   */
  @minLength(1)
  aadAuthority: string;
}

/**
 * Fabric agent model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@discriminator("instanceType")
model FabricAgentModelCustomProperties {}

/**
 * Job model properties.
 */
model JobModelProperties {
  /**
   * Gets or sets the friendly display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets or sets the job state.
   */
  @visibility(Lifecycle.Read)
  state?: JobState;

  /**
   * Gets or sets the start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets the end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets or sets the affected object Id.
   */
  @visibility(Lifecycle.Read)
  objectId?: string;

  /**
   * Gets or sets the affected object name.
   */
  @visibility(Lifecycle.Read)
  objectName?: string;

  /**
   * Gets or sets the affected object internal Id.
   */
  @visibility(Lifecycle.Read)
  objectInternalId?: string;

  /**
   * Gets or sets the affected object internal name.
   */
  @visibility(Lifecycle.Read)
  objectInternalName?: string;

  /**
   * Gets or sets the object type.
   */
  @visibility(Lifecycle.Read)
  objectType?: JobObjectType;

  /**
   * Gets or sets the replication provider.
   */
  @visibility(Lifecycle.Read)
  replicationProviderId?: string;

  /**
   * Gets or sets the source fabric provider.
   */
  @visibility(Lifecycle.Read)
  sourceFabricProviderId?: string;

  /**
   * Gets or sets the target fabric provider.
   */
  @visibility(Lifecycle.Read)
  targetFabricProviderId?: string;

  /**
   * Gets or sets the list of allowed actions on the job.
   */
  @visibility(Lifecycle.Read)
  allowedActions?: string[];

  /**
   * Gets or sets the job activity id.
   */
  @visibility(Lifecycle.Read)
  activityId?: string;

  /**
   * Gets or sets the list of tasks.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  tasks?: TaskModel[];

  /**
   * Gets or sets the list of errors.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: ErrorModel[];

  /**
   * Job model custom properties.
   */
  customProperties: JobModelCustomProperties;

  /**
   * Gets or sets the provisioning state of the job.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Task model.
 */
model TaskModel {
  /**
   * Gets or sets the task name.
   */
  @visibility(Lifecycle.Read)
  taskName?: string;

  /**
   * Gets or sets the task state.
   */
  @visibility(Lifecycle.Read)
  state?: TaskState;

  /**
   * Gets or sets the start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets the end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Task model custom properties.
   */
  customProperties?: TaskModelCustomProperties;

  /**
   * Gets or sets the list of children job models.
   */
  @identifiers(#[])
  childrenJobs?: JobModel[];
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
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets or sets the error type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Gets or sets the error severity.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Gets or sets the creation time of error.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Gets or sets the possible causes of error.
   */
  @visibility(Lifecycle.Read)
  causes?: string;

  /**
   * Gets or sets the recommended action to resolve error.
   */
  @visibility(Lifecycle.Read)
  recommendation?: string;
}

/**
 * Job model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
@discriminator("instanceType")
model JobModelCustomProperties {
  /**
   * Gets or sets any custom properties of the affected object.
   */
  @visibility(Lifecycle.Read)
  affectedObjectDetails?: AffectedObjectDetails;
}

/**
 * Details of the affected object.
 */
model AffectedObjectDetails {
  /**
   * Description of the affected object details.
   */
  description?: string;

  /**
   * Type of the affected object details.
   */
  type?: "object";
}

/**
 * Policy model properties.
 */
model PolicyModelProperties {
  /**
   * Gets or sets the provisioning state of the policy.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Policy model custom properties.
   */
  customProperties: PolicyModelCustomProperties;
}

/**
 * Policy model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@discriminator("instanceType")
model PolicyModelCustomProperties {}

/**
 * Represents Private endpoint connection response properties.
 */
model PrivateEndpointConnectionResponseProperties {
  /**
   * Gets or sets provisioning state of the private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Represent private Endpoint network resource that is linked to the Private Endpoint connection.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Represents Private link service connection state.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/**
 * Represent private Endpoint network resource that is linked to the Private Endpoint connection.
 */
model PrivateEndpoint {
  /**
   * Gets or sets the id.
   */
  id?: string;
}

/**
 * Represents Private link service connection state.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Gets or sets the status.
   */
  status?: PrivateEndpointConnectionStatus;

  /**
   * Gets or sets description.
   */
  description?: string;

  /**
   * Gets or sets actions required.
   */
  actionsRequired?: string;
}

/**
 * Represents private endpoint connection proxy request.
 */
model PrivateEndpointConnectionProxyProperties {
  /**
   * Gets or sets the provisioning state of the private endpoint connection proxy.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Represent remote private endpoint information for the private endpoint connection proxy.
   */
  remotePrivateEndpoint?: RemotePrivateEndpoint;
}

/**
 * Represent remote private endpoint information for the private endpoint connection proxy.
 */
model RemotePrivateEndpoint {
  /**
   * Gets or sets private link service proxy id.
   */
  @minLength(1)
  id: string;

  /**
   * Gets or sets the list of Private Link Service Connections and gets populated for Auto approval flow.
   */
  @identifiers(#[])
  privateLinkServiceConnections?: PrivateLinkServiceConnection[];

  /**
   * Gets or sets the list of Manual Private Link Service Connections and gets populated for Manual approval flow.
   */
  @identifiers(#[])
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];

  /**
   * Gets or sets the list of private link service proxies.
   */
  @identifiers(#[])
  privateLinkServiceProxies?: PrivateLinkServiceProxy[];

  /**
   * Gets or sets the list of Connection Details. This is the connection details for private endpoint.
   */
  @identifiers(#[])
  connectionDetails?: ConnectionDetails[];
}

/**
 * Represents of an NRP private link service connection.
 */
model PrivateLinkServiceConnection {
  /**
   * Gets or sets private link service connection name.
   */
  name?: string;

  /**
   * Gets or sets group ids.
   */
  groupIds?: string[];

  /**
   * Gets or sets the request message for the private link service connection.
   */
  requestMessage?: string;
}

/**
 * Represents NRP private link service proxy.
 */
model PrivateLinkServiceProxy {
  /**
   * Gets or sets private link service proxy id.
   */
  id?: string;

  /**
   * Represents Private link service connection state.
   */
  remotePrivateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * Represent remote private endpoint connection.
   */
  remotePrivateEndpointConnection?: RemotePrivateEndpointConnection;

  /**
   * Gets or sets group connectivity information.
   */
  @identifiers(#[])
  groupConnectivityInformation?: GroupConnectivityInformation[];
}

/**
 * Represent remote private endpoint connection.
 */
model RemotePrivateEndpointConnection {
  /**
   * Gets or sets the remote private endpoint connection id.
   */
  id?: string;
}

/**
 * Represents of a connection's group information.
 */
model GroupConnectivityInformation {
  /**
   * Gets or sets group id.
   */
  groupId?: string;

  /**
   * Gets or sets member name.
   */
  memberName?: string;

  /**
   * Gets or sets customer visible FQDNs.
   */
  customerVisibleFqdns?: string[];

  /**
   * Gets or sets Internal Fqdn.
   */
  internalFqdn?: string;

  /**
   * Gets or sets the redirect map id.
   */
  redirectMapId?: string;

  /**
   * Gets or sets the private link service arm region.
   */
  privateLinkServiceArmRegion?: string;
}

/**
 * Private endpoint connection details at member level.
 */
model ConnectionDetails {
  /**
   * Gets or sets id.
   */
  id?: string;

  /**
   * Gets or sets private IP address.
   */
  privateIpAddress?: string;

  /**
   * Gets or sets link identifier.
   */
  linkIdentifier?: string;

  /**
   * Gets or sets group id.
   */
  groupId?: string;

  /**
   * Gets or sets member name.
   */
  memberName?: string;
}

/**
 * Represents private link resource properties.
 */
model PrivateLinkResourceProperties {
  /**
   * Gets or sets the group id.
   */
  groupId?: string;

  /**
   * Gets or sets the required member. This translates to how many Private IPs should be created for each privately linkable resource.
   */
  requiredMembers?: string[];

  /**
   * Gets or sets the private DNS zone names.
   */
  requiredZoneNames?: string[];

  /**
   * Gets or sets the provisioning state of the private link resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

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
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * Gets or sets the provisioning state of the fabric agent.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the protection state.
   */
  @visibility(Lifecycle.Read)
  protectionState?: ProtectionState;

  /**
   * Gets or sets the protection state description.
   */
  @visibility(Lifecycle.Read)
  protectionStateDescription?: string;

  /**
   * Gets or sets the test failover state.
   */
  @visibility(Lifecycle.Read)
  testFailoverState?: TestFailoverState;

  /**
   * Gets or sets the Test failover state description.
   */
  @visibility(Lifecycle.Read)
  testFailoverStateDescription?: string;

  /**
   * Gets or sets the resynchronization state.
   */
  @visibility(Lifecycle.Read)
  resynchronizationState?: ResynchronizationState;

  /**
   * Gets or sets the fabric object Id.
   */
  @visibility(Lifecycle.Read)
  fabricObjectId?: string;

  /**
   * Gets or sets the fabric object name.
   */
  @visibility(Lifecycle.Read)
  fabricObjectName?: string;

  /**
   * Gets or sets the source fabric provider Id.
   */
  @visibility(Lifecycle.Read)
  sourceFabricProviderId?: string;

  /**
   * Gets or sets the target fabric provider Id.
   */
  @visibility(Lifecycle.Read)
  targetFabricProviderId?: string;

  /**
   * Gets or sets the fabric Id.
   */
  @visibility(Lifecycle.Read)
  fabricId?: string;

  /**
   * Gets or sets the target fabric Id.
   */
  @visibility(Lifecycle.Read)
  targetFabricId?: string;

  /**
   * Gets or sets the fabric agent Id.
   */
  @visibility(Lifecycle.Read)
  fabricAgentId?: string;

  /**
   * Gets or sets the target fabric agent Id.
   */
  @visibility(Lifecycle.Read)
  targetFabricAgentId?: string;

  /**
   * Gets or sets a value indicating whether resynchronization is required or not.
   */
  @visibility(Lifecycle.Read)
  resyncRequired?: boolean;

  /**
   * Gets or sets the Last successful planned failover time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulPlannedFailoverTime?: utcDateTime;

  /**
   * Gets or sets the Last successful unplanned failover time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulUnplannedFailoverTime?: utcDateTime;

  /**
   * Gets or sets the Last successful test failover time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulTestFailoverTime?: utcDateTime;

  /**
   * Gets or sets the current scenario.
   */
  @visibility(Lifecycle.Read)
  currentJob?: ProtectedItemJobProperties;

  /**
   * Gets or sets the allowed scenarios on the protected item.
   */
  @visibility(Lifecycle.Read)
  allowedJobs?: string[];

  /**
   * Gets or sets the last failed enabled protection job.
   */
  @visibility(Lifecycle.Read)
  lastFailedEnableProtectionJob?: ProtectedItemJobProperties;

  /**
   * Gets or sets the last failed planned failover job.
   */
  @visibility(Lifecycle.Read)
  lastFailedPlannedFailoverJob?: ProtectedItemJobProperties;

  /**
   * Gets or sets the last test failover job.
   */
  @visibility(Lifecycle.Read)
  lastTestFailoverJob?: ProtectedItemJobProperties;

  /**
   * Gets or sets protected item replication health.
   */
  @visibility(Lifecycle.Read)
  replicationHealth?: HealthStatus;

  /**
   * Gets or sets the list of health errors.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
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
  @visibility(Lifecycle.Read)
  scenarioName?: string;

  /**
   * Gets or sets job Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets or sets job name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets the job friendly display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Gets or sets job state.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * Gets or sets start time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets end time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

/**
 * Protected item model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@discriminator("instanceType")
model ProtectedItemModelCustomProperties {}

/**
 * Protected item model update.
 */
model ProtectedItemModelUpdate {
  /**
   * Protected item model properties.
   */
  properties?: ProtectedItemModelPropertiesUpdate;

  /**
   * Gets or sets the Id of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets or sets the name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets the type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Protected item model properties update.
 */
model ProtectedItemModelPropertiesUpdate {
  /**
   * Protected item model custom properties update.
   */
  customProperties?: ProtectedItemModelCustomPropertiesUpdate;
}

/**
 * Protected item model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@discriminator("instanceType")
model ProtectedItemModelCustomPropertiesUpdate {}

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
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
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

  /**
   * Gets or sets the provisioning state of the recovery point item.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Recovery point model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@discriminator("instanceType")
model RecoveryPointModelCustomProperties {}

/**
 * Replication extension model properties.
 */
model ReplicationExtensionModelProperties {
  /**
   * Gets or sets the provisioning state of the replication extension.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Replication extension model custom properties.
   */
  customProperties: ReplicationExtensionModelCustomProperties;
}

/**
 * Replication extension model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@discriminator("instanceType")
model ReplicationExtensionModelCustomProperties {}

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
  @identifiers(#[])
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Gets or sets the Api version.
   */
  apiVersion?: string;

  /**
   * Gets or sets the properties of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  properties?: unknown;
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
   * Gets or sets the status of the operation. ARM expects the terminal status to be one of Succeeded/ Failed/ Canceled. All other values imply that the operation is still running.
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
 * Vault properties.
 */
model VaultModelProperties {
  /**
   * Gets or sets the provisioning state of the vault.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the service resource Id.
   */
  @visibility(Lifecycle.Read)
  serviceResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the type of vault.
   */
  vaultType?: ReplicationVaultType;
}

/**
 * Vault model.
 */
model VaultIdentityModel {
  /**
   * Gets or sets the identityType which can be either SystemAssigned or None.
   */
  type: VaultIdentityType;

  /**
   * Gets or sets the object ID of the service principal object for the managed identity that is used to grant role-based access to an Azure resource.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Gets or sets a Globally Unique Identifier (GUID) that represents the Azure AD tenant where the resource is now a member.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * Vault model update.
 */
model VaultModelUpdate {
  /**
   * Gets or sets the resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;

  /**
   * Vault properties.
   */
  properties?: VaultModelProperties;

  /**
   * Vault identity.
   */
  identity?: VaultIdentityModel;

  /**
   * Gets or sets the Id of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets or sets the name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets the type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * AzStackHCI cluster properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
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
  @identifiers(#[])
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzStackHCIFabricModelCustomProperties
  extends FabricModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the AzStackHCI site.
   */
  @minLength(1)
  azStackHciSiteId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the Appliance name.
   */
  @visibility(Lifecycle.Read)
  applianceName?: string[];

  /**
   * AzStackHCI cluster properties.
   */
  cluster: AzStackHCIClusterProperties;

  /**
   * Gets or sets the fabric resource Id.
   */
  @visibility(Lifecycle.Read)
  fabricResourceId?: string;

  /**
   * Gets or sets the fabric container Id.
   */
  @visibility(Lifecycle.Read)
  fabricContainerId?: string;

  /**
   * Gets or sets the Migration solution ARM Id.
   */
  @minLength(1)
  migrationSolutionId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the migration hub Uri.
   */
  @visibility(Lifecycle.Read)
  migrationHubUri?: url;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "AzStackHCI";
}

/**
 * Disk controller.
 */
model DiskControllerInputs {
  /**
   * Gets or sets the controller name (IDE,SCSI).
   */
  @minLength(1)
  controllerName: string;

  /**
   * Gets or sets the controller ID.
   */
  controllerId: int32;

  /**
   * Gets or sets the controller Location.
   */
  controllerLocation: int32;
}

/**
 * Failover job model custom properties.
 */
model FailoverJobModelCustomProperties extends JobModelCustomProperties {
  /**
   * Gets or sets the failed over protected item details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  protectedItemDetails?: FailoverProtectedItemProperties[];

  /**
   * Gets or sets the instance type.
   */
  instanceType: "FailoverJobDetails";
}

/**
 * Failover properties of the protected item.
 */
model FailoverProtectedItemProperties {
  /**
   * Gets or sets the protected item name.
   */
  @visibility(Lifecycle.Read)
  protectedItemName?: string;

  /**
   * Gets or sets the VM name.
   */
  @visibility(Lifecycle.Read)
  vmName?: string;

  /**
   * Gets or sets the test VM name.
   */
  @visibility(Lifecycle.Read)
  testVmName?: string;

  /**
   * Gets or sets the recovery point Id.
   */
  @visibility(Lifecycle.Read)
  recoveryPointId?: string;

  /**
   * Gets or sets the recovery point time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  recoveryPointTime?: utcDateTime;

  /**
   * Gets or sets the network name.
   */
  @visibility(Lifecycle.Read)
  networkName?: string;

  /**
   * Gets or sets the network subnet.
   */
  @visibility(Lifecycle.Read)
  subnet?: string;
}

/**
 * HyperV migrate fabric model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVMigrateFabricModelCustomProperties
  extends FabricModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the HyperV site.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @minLength(1)
  hyperVSiteId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the fabric resource Id.
   */
  @visibility(Lifecycle.Read)
  fabricResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the fabric container Id.
   */
  @visibility(Lifecycle.Read)
  fabricContainerId?: string;

  /**
   * Gets or sets the migration solution ARM Id.
   */
  @minLength(1)
  migrationSolutionId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the migration hub Uri.
   */
  @visibility(Lifecycle.Read)
  migrationHubUri?: url;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVMigrate";
}

/**
 * HyperVToAzStack disk input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIDiskInput {
  /**
   * Gets or sets the disk Id.
   */
  @minLength(1)
  diskId: string;

  /**
   * Gets or sets the target storage account ARM Id.
   */
  storageContainerId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets a value indicating whether dynamic sizing is enabled on the virtual hard disk.
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

  /**
   * Gets or sets a value of disk block size.
   */
  diskBlockSize?: int64;

  /**
   * Gets or sets a value of disk logical sector size.
   */
  diskLogicalSectorSize?: int64;

  /**
   * Gets or sets a value of disk physical sector size.
   */
  diskPhysicalSectorSize?: int64;

  /**
   * Gets or sets a value of disk identifier.
   */
  diskIdentifier?: string;

  /**
   * Disk controller.
   */
  diskController?: DiskControllerInputs;
}

/**
 * HyperV to  AzStackHCI event model custom properties. This class provides provider specific details for events of type DataContract.HealthEvents.HealthEventType.ProtectedItemHealth and DataContract.HealthEvents.HealthEventType.AgentHealth.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIEventModelCustomProperties
  extends EventModelCustomProperties {
  /**
   * Gets or sets the friendly name of the source which has raised this health event.
   */
  @visibility(Lifecycle.Read)
  eventSourceFriendlyName?: string;

  /**
   * Gets or sets the protected item friendly name.
   */
  @visibility(Lifecycle.Read)
  protectedItemFriendlyName?: string;

  /**
   * Gets or sets the source appliance name.
   */
  @visibility(Lifecycle.Read)
  sourceApplianceName?: string;

  /**
   * Gets or sets the source target name.
   */
  @visibility(Lifecycle.Read)
  targetApplianceName?: string;

  /**
   * Gets or sets the server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";
}

/**
 * HyperVToAzStackHCI NIC properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCINicInput {
  /**
   * Gets or sets the NIC Id.
   */
  @minLength(1)
  nicId: string;

  /**
   * Gets or sets the network name.
   */
  @visibility(Lifecycle.Read)
  networkName?: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  targetNetworkId?: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  testNetworkId?: string;

  /**
   * Gets or sets the selection type of the NIC.
   */
  selectionTypeForFailover: VMNicSelection;

  /**
   * Gets or sets a value indicating whether static ip migration is enabled.
   */
  isStaticIpMigrationEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether mac address migration is enabled.
   */
  isMacMigrationEnabled?: boolean;
}

/**
 * HyperV to AzStackHCI planned failover model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIPolicyModelCustomProperties
  extends PolicyModelCustomProperties {
  /**
   * Gets or sets the duration in minutes until which the recovery points need to be stored.
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIProtectedDiskProperties {
  /**
   * Gets or sets the ARM Id of the storage container.
   */
  @visibility(Lifecycle.Read)
  storageContainerId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the local path of the storage container.
   */
  @visibility(Lifecycle.Read)
  storageContainerLocalPath?: string;

  /**
   * Gets or sets the source disk Id.
   */
  @visibility(Lifecycle.Read)
  sourceDiskId?: string;

  /**
   * Gets or sets the source disk Name.
   */
  @visibility(Lifecycle.Read)
  sourceDiskName?: string;

  /**
   * Gets or sets the seed disk name.
   */
  @visibility(Lifecycle.Read)
  seedDiskName?: string;

  /**
   * Gets or sets the test failover clone disk.
   */
  @visibility(Lifecycle.Read)
  testMigrateDiskName?: string;

  /**
   * Gets or sets the failover clone disk.
   */
  @visibility(Lifecycle.Read)
  migrateDiskName?: string;

  /**
   * Gets or sets a value indicating whether the disk is the OS disk.
   */
  @visibility(Lifecycle.Read)
  isOsDisk?: boolean;

  /**
   * Gets or sets the disk capacity in bytes.
   */
  @visibility(Lifecycle.Read)
  capacityInBytes?: int64;

  /**
   * Gets or sets a value indicating whether dynamic sizing is enabled on the virtual hard disk.
   */
  @visibility(Lifecycle.Read)
  isDynamic?: boolean;

  /**
   * Gets or sets the disk type.
   */
  @visibility(Lifecycle.Read)
  diskType?: string;

  /**
   * Gets or sets a value of disk block size.
   */
  @visibility(Lifecycle.Read)
  diskBlockSize?: int64;

  /**
   * Gets or sets a value of disk logical sector size.
   */
  @visibility(Lifecycle.Read)
  diskLogicalSectorSize?: int64;

  /**
   * Gets or sets a value of disk physical sector size.
   */
  @visibility(Lifecycle.Read)
  diskPhysicalSectorSize?: int64;
}

/**
 * HyperV to AzStackHCI Protected item model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIProtectedItemModelCustomProperties
  extends ProtectedItemModelCustomProperties {
  /**
   * Gets or sets the location of the protected item.
   */
  @visibility(Lifecycle.Read)
  activeLocation?: ProtectedItemActiveLocation;

  /**
   * Gets or sets the Target HCI Cluster ARM Id.
   */
  @minLength(1)
  targetHciClusterId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the Target Arc Cluster Custom Location ARM Id.
   */
  @minLength(1)
  targetArcClusterCustomLocationId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the Target AzStackHCI cluster name.
   */
  @visibility(Lifecycle.Read)
  targetAzStackHciClusterName?: string;

  /**
   * Gets or sets the ARM Id of the discovered machine.
   */
  @minLength(1)
  fabricDiscoveryMachineId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the list of disks to replicate.
   */
  @identifiers(#[])
  disksToInclude: HyperVToAzStackHCIDiskInput[];

  /**
   * Gets or sets the list of VM NIC to replicate.
   */
  @identifiers(#[])
  nicsToInclude: HyperVToAzStackHCINicInput[];

  /**
   * Gets or sets the source VM display name.
   */
  @visibility(Lifecycle.Read)
  sourceVmName?: string;

  /**
   * Gets or sets the source VM CPU cores.
   */
  @visibility(Lifecycle.Read)
  sourceCpuCores?: int32;

  /**
   * Gets or sets the source VM ram memory size in megabytes.
   */
  @visibility(Lifecycle.Read)
  sourceMemoryInMegaBytes?: float64;

  /**
   * Gets or sets the target VM display name.
   */
  targetVmName?: string;

  /**
   * Gets or sets the target resource group ARM Id.
   */
  @minLength(1)
  targetResourceGroupId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the target storage container ARM Id.
   */
  @minLength(1)
  storageContainerId: Azure.Core.armResourceIdentifier;

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
   * Gets or sets the source fabric agent name.
   */
  @minLength(1)
  sourceFabricAgentName: string;

  /**
   * Gets or sets the target fabric agent name.
   */
  @minLength(1)
  targetFabricAgentName: string;

  /**
   * Gets or sets the source appliance name.
   */
  @visibility(Lifecycle.Read)
  sourceApplianceName?: string;

  /**
   * Gets or sets the target appliance name.
   */
  @visibility(Lifecycle.Read)
  targetApplianceName?: string;

  /**
   * Gets or sets the type of the OS.
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * Gets or sets the name of the OS.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * Gets or sets the firmware type.
   */
  @visibility(Lifecycle.Read)
  firmwareType?: string;

  /**
   * Gets or sets the target location.
   */
  @visibility(Lifecycle.Read)
  targetLocation?: string;

  /**
   * Gets or sets the location of Azure Arc HCI custom location resource.
   */
  @minLength(1)
  customLocationRegion: string;

  /**
   * Gets or sets the recovery point Id to which the VM was failed over.
   */
  @visibility(Lifecycle.Read)
  failoverRecoveryPointId?: string;

  /**
   * Gets or sets the last recovery point received time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  /**
   * Gets or sets the last recovery point Id.
   */
  @visibility(Lifecycle.Read)
  lastRecoveryPointId?: string;

  /**
   * Gets or sets the initial replication progress percentage. This is calculated based on total bytes processed for all disks in the source VM.
   */
  @visibility(Lifecycle.Read)
  initialReplicationProgressPercentage?: int32;

  /**
   * Gets or sets the resync progress percentage. This is calculated based on total bytes processed for all disks in the source VM.
   */
  @visibility(Lifecycle.Read)
  resyncProgressPercentage?: int32;

  /**
   * Gets or sets the list of protected disks.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  protectedDisks?: HyperVToAzStackHCIProtectedDiskProperties[];

  /**
   * Gets or sets the VM NIC details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  protectedNics?: HyperVToAzStackHCIProtectedNicProperties[];

  /**
   * Gets or sets the BIOS Id of the target AzStackHCI VM.
   */
  @visibility(Lifecycle.Read)
  targetVmBiosId?: string;

  /**
   * Gets or sets the latest timestamp that replication status is updated.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIProtectedNicProperties {
  /**
   * Gets or sets the NIC Id.
   */
  @visibility(Lifecycle.Read)
  nicId?: string;

  /**
   * Gets or sets the NIC mac address.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * Gets or sets the network name.
   */
  @visibility(Lifecycle.Read)
  networkName?: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  @visibility(Lifecycle.Read)
  targetNetworkId?: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  @visibility(Lifecycle.Read)
  testNetworkId?: string;

  /**
   * Gets or sets the selection type of the NIC.
   */
  @visibility(Lifecycle.Read)
  selectionTypeForFailover?: VMNicSelection;
}

/**
 * HyperV to AzStackHCI Protected item model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIProtectedItemModelCustomPropertiesUpdate
  extends ProtectedItemModelCustomPropertiesUpdate {
  /**
   * Gets or sets the list of VM NIC to replicate.
   */
  @identifiers(#[])
  nicsToInclude?: HyperVToAzStackHCINicInput[];

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
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";

  /**
   * Gets or sets the type of the OS.
   */
  osType?: string;
}

/**
 * HyperV to AzStackHCI recovery point model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIRecoveryPointModelCustomProperties
  extends RecoveryPointModelCustomProperties {
  /**
   * Gets or sets the list of the disk Ids.
   */
  @visibility(Lifecycle.Read)
  diskIds?: string[];

  /**
   * Gets or sets the instance type.
   */
  instanceType: "HyperVToAzStackHCI";
}

/**
 * HyperV to AzStackHCI Replication extension model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HyperVToAzStackHCIReplicationExtensionModelCustomProperties
  extends ReplicationExtensionModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the source HyperV fabric.
   */
  @minLength(1)
  hyperVFabricArmId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the ARM Id of the HyperV site.
   */
  @visibility(Lifecycle.Read)
  hyperVSiteId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the ARM Id of the target AzStackHCI fabric.
   */
  @minLength(1)
  azStackHciFabricArmId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the ARM Id of the AzStackHCI site.
   */
  @visibility(Lifecycle.Read)
  azStackHciSiteId?: Azure.Core.armResourceIdentifier;

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
  @visibility(Lifecycle.Read)
  asrServiceUri?: url;

  /**
   * Gets or sets the Uri of Rcm.
   */
  @visibility(Lifecycle.Read)
  rcmServiceUri?: url;

  /**
   * Gets or sets the Uri of Gateway.
   */
  @visibility(Lifecycle.Read)
  gatewayServiceUri?: url;

  /**
   * Gets or sets the gateway service Id of source.
   */
  @visibility(Lifecycle.Read)
  sourceGatewayServiceId?: string;

  /**
   * Gets or sets the gateway service Id of target.
   */
  @visibility(Lifecycle.Read)
  targetGatewayServiceId?: string;

  /**
   * Gets or sets the source storage container name.
   */
  @visibility(Lifecycle.Read)
  sourceStorageContainerName?: string;

  /**
   * Gets or sets the target storage container name.
   */
  @visibility(Lifecycle.Read)
  targetStorageContainerName?: string;

  /**
   * Gets or sets the resource location.
   */
  @visibility(Lifecycle.Read)
  resourceLocation?: string;

  /**
   * Gets or sets the subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Gets or sets the resource group.
   */
  @visibility(Lifecycle.Read)
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
   * Gets or sets a value indicating whether the action is specific to data plane or control plane.
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
  @identifiers(#[])
  value?: OperationModel[];

  /**
   * Gets or sets the value of next link.
   */
  nextLink?: string;
}

/**
 * System data required to be defined for Azure resources.
 */
model SystemDataModel {
  /**
   * Gets or sets identity that created the resource.
   */
  createdBy?: string;

  /**
   * Gets or sets the type of identity that created the resource: user, application,managedIdentity.
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
   * Gets or sets the type of identity that last modified the resource: user, application,managedIdentity.
   */
  lastModifiedByType?: string;

  /**
   * Gets or sets the timestamp of resource last modification (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * Test failover cleanup job model custom properties.
 */
model TestFailoverCleanupJobModelCustomProperties
  extends JobModelCustomProperties {
  /**
   * Gets or sets the test failover cleanup comments.
   */
  @visibility(Lifecycle.Read)
  comments?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "TestFailoverCleanupJobDetails";
}

/**
 * Test failover job model custom properties.
 */
model TestFailoverJobModelCustomProperties extends JobModelCustomProperties {
  /**
   * Gets or sets the test VM details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  protectedItemDetails?: FailoverProtectedItemProperties[];

  /**
   * Gets or sets the instance type.
   */
  instanceType: "TestFailoverJobDetails";
}

/**
 * VMware fabric agent model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareFabricAgentModelCustomProperties
  extends FabricAgentModelCustomProperties {
  /**
   * Gets or sets the BIOS Id of the fabric agent machine.
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareMigrateFabricModelCustomProperties
  extends FabricModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the VMware site.
   */
  @minLength(1)
  vmwareSiteId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the ARM Id of the migration solution.
   */
  @minLength(1)
  migrationSolutionId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareMigrate";
}

/**
 * VMwareToAzStack disk input.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIDiskInput {
  /**
   * Gets or sets the disk Id.
   */
  @minLength(1)
  diskId: string;

  /**
   * Gets or sets the target storage account ARM Id.
   */
  storageContainerId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets a value indicating whether dynamic sizing is enabled on the virtual hard disk.
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

  /**
   * Gets or sets a value of disk block size.
   */
  diskBlockSize?: int64;

  /**
   * Gets or sets a value of disk logical sector size.
   */
  diskLogicalSectorSize?: int64;

  /**
   * Gets or sets a value of disk physical sector size.
   */
  diskPhysicalSectorSize?: int64;

  /**
   * Gets or sets a value of disk identifier.
   */
  diskIdentifier?: string;

  /**
   * Disk controller.
   */
  diskController?: DiskControllerInputs;
}

/**
 * VMware to  AzStackHCI event model custom properties. This class provides provider specific details for events of type DataContract.HealthEvents.HealthEventType.ProtectedItemHealth and DataContract.HealthEvents.HealthEventType.AgentHealth.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIEventModelCustomProperties
  extends EventModelCustomProperties {
  /**
   * Gets or sets the friendly name of the source which has raised this health event.
   */
  @visibility(Lifecycle.Read)
  eventSourceFriendlyName?: string;

  /**
   * Gets or sets the protected item friendly name.
   */
  @visibility(Lifecycle.Read)
  protectedItemFriendlyName?: string;

  /**
   * Gets or sets the source appliance name.
   */
  @visibility(Lifecycle.Read)
  sourceApplianceName?: string;

  /**
   * Gets or sets the source target name.
   */
  @visibility(Lifecycle.Read)
  targetApplianceName?: string;

  /**
   * Gets or sets the server type.
   */
  @visibility(Lifecycle.Read)
  serverType?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareToAzStackHCI";
}

/**
 * VMwareToAzStackHCI NIC properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
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
  @visibility(Lifecycle.Read)
  networkName?: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  targetNetworkId?: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  testNetworkId?: string;

  /**
   * Gets or sets the selection type of the NIC.
   */
  selectionTypeForFailover: VMNicSelection;

  /**
   * Gets or sets a value indicating whether static ip migration is enabled.
   */
  isStaticIpMigrationEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether mac address migration is enabled.
   */
  isMacMigrationEnabled?: boolean;
}

/**
 * VMware to AzStackHCI planned failover model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIPolicyModelCustomProperties
  extends PolicyModelCustomProperties {
  /**
   * Gets or sets the duration in minutes until which the recovery points need to be stored.
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIProtectedDiskProperties {
  /**
   * Gets or sets the ARM Id of the storage container.
   */
  @visibility(Lifecycle.Read)
  storageContainerId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the local path of the storage container.
   */
  @visibility(Lifecycle.Read)
  storageContainerLocalPath?: string;

  /**
   * Gets or sets the source disk Id.
   */
  @visibility(Lifecycle.Read)
  sourceDiskId?: string;

  /**
   * Gets or sets the source disk Name.
   */
  @visibility(Lifecycle.Read)
  sourceDiskName?: string;

  /**
   * Gets or sets the seed disk name.
   */
  @visibility(Lifecycle.Read)
  seedDiskName?: string;

  /**
   * Gets or sets the test failover clone disk.
   */
  @visibility(Lifecycle.Read)
  testMigrateDiskName?: string;

  /**
   * Gets or sets the failover clone disk.
   */
  @visibility(Lifecycle.Read)
  migrateDiskName?: string;

  /**
   * Gets or sets a value indicating whether the disk is the OS disk.
   */
  @visibility(Lifecycle.Read)
  isOsDisk?: boolean;

  /**
   * Gets or sets the disk capacity in bytes.
   */
  @visibility(Lifecycle.Read)
  capacityInBytes?: int64;

  /**
   * Gets or sets a value indicating whether dynamic sizing is enabled on the virtual hard disk.
   */
  @visibility(Lifecycle.Read)
  isDynamic?: boolean;

  /**
   * Gets or sets the disk type.
   */
  @visibility(Lifecycle.Read)
  diskType?: string;

  /**
   * Gets or sets a value of disk block size.
   */
  @visibility(Lifecycle.Read)
  diskBlockSize?: int64;

  /**
   * Gets or sets a value of disk logical sector size.
   */
  @visibility(Lifecycle.Read)
  diskLogicalSectorSize?: int64;

  /**
   * Gets or sets a value of disk physical sector size.
   */
  @visibility(Lifecycle.Read)
  diskPhysicalSectorSize?: int64;
}

/**
 * VMware to AzStackHCI Protected item model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIProtectedItemModelCustomProperties
  extends ProtectedItemModelCustomProperties {
  /**
   * Gets or sets the location of the protected item.
   */
  @visibility(Lifecycle.Read)
  activeLocation?: ProtectedItemActiveLocation;

  /**
   * Gets or sets the Target HCI Cluster ARM Id.
   */
  @minLength(1)
  targetHciClusterId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the Target Arc Cluster Custom Location ARM Id.
   */
  @minLength(1)
  targetArcClusterCustomLocationId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the Target AzStackHCI cluster name.
   */
  @visibility(Lifecycle.Read)
  targetAzStackHciClusterName?: string;

  /**
   * Gets or sets the target storage container ARM Id.
   */
  @minLength(1)
  storageContainerId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the target resource group ARM Id.
   */
  @minLength(1)
  targetResourceGroupId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the target location.
   */
  @visibility(Lifecycle.Read)
  targetLocation?: string;

  /**
   * Gets or sets the location of Azure Arc HCI custom location resource.
   */
  @minLength(1)
  customLocationRegion: string;

  /**
   * Gets or sets the list of disks to replicate.
   */
  @identifiers(#[])
  disksToInclude: VMwareToAzStackHCIDiskInput[];

  /**
   * Gets or sets the list of VM NIC to replicate.
   */
  @identifiers(#[])
  nicsToInclude: VMwareToAzStackHCINicInput[];

  /**
   * Gets or sets the list of protected disks.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  protectedDisks?: VMwareToAzStackHCIProtectedDiskProperties[];

  /**
   * Gets or sets the VM NIC details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  protectedNics?: VMwareToAzStackHCIProtectedNicProperties[];

  /**
   * Gets or sets the BIOS Id of the target AzStackHCI VM.
   */
  @visibility(Lifecycle.Read)
  targetVmBiosId?: string;

  /**
   * Gets or sets the target VM display name.
   */
  targetVmName?: string;

  /**
   * Gets or sets the hypervisor generation of the virtual machine possible values are 1,2.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
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
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * Gets or sets the name of the OS.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * Gets or sets the firmware type.
   */
  @visibility(Lifecycle.Read)
  firmwareType?: string;

  /**
   * Gets or sets the ARM Id of the discovered machine.
   */
  @minLength(1)
  fabricDiscoveryMachineId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the source VM display name.
   */
  @visibility(Lifecycle.Read)
  sourceVmName?: string;

  /**
   * Gets or sets the source VM CPU cores.
   */
  @visibility(Lifecycle.Read)
  sourceCpuCores?: int32;

  /**
   * Gets or sets the source VM ram memory size in megabytes.
   */
  @visibility(Lifecycle.Read)
  sourceMemoryInMegaBytes?: float64;

  /**
   * Gets or sets the run as account Id.
   */
  @minLength(1)
  runAsAccountId: string;

  /**
   * Gets or sets the source fabric agent name.
   */
  @minLength(1)
  sourceFabricAgentName: string;

  /**
   * Gets or sets the target fabric agent name.
   */
  @minLength(1)
  targetFabricAgentName: string;

  /**
   * Gets or sets the source appliance name.
   */
  @visibility(Lifecycle.Read)
  sourceApplianceName?: string;

  /**
   * Gets or sets the target appliance name.
   */
  @visibility(Lifecycle.Read)
  targetApplianceName?: string;

  /**
   * Gets or sets the recovery point Id to which the VM was failed over.
   */
  @visibility(Lifecycle.Read)
  failoverRecoveryPointId?: string;

  /**
   * Gets or sets the last recovery point received time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecoveryPointReceived?: utcDateTime;

  /**
   * Gets or sets the last recovery point Id.
   */
  @visibility(Lifecycle.Read)
  lastRecoveryPointId?: string;

  /**
   * Gets or sets the initial replication progress percentage. This is calculated based on total bytes processed for all disks in the source VM.
   */
  @visibility(Lifecycle.Read)
  initialReplicationProgressPercentage?: int32;

  /**
   * Gets or sets the migration progress percentage.
   */
  @visibility(Lifecycle.Read)
  migrationProgressPercentage?: int32;

  /**
   * Gets or sets the resume progress percentage.
   */
  @visibility(Lifecycle.Read)
  resumeProgressPercentage?: int32;

  /**
   * Gets or sets the resync progress percentage. This is calculated based on total bytes processed for all disks in the source VM.
   */
  @visibility(Lifecycle.Read)
  resyncProgressPercentage?: int32;

  /**
   * Gets or sets the resync retry count.
   */
  @visibility(Lifecycle.Read)
  resyncRetryCount?: int64;

  /**
   * Gets or sets a value indicating whether resync is required.
   */
  @visibility(Lifecycle.Read)
  resyncRequired?: boolean;

  /**
   * Gets or sets the resync state.
   */
  @visibility(Lifecycle.Read)
  resyncState?: VMwareToAzureMigrateResyncState;

  /**
   * Gets or sets a value indicating whether auto resync is to be done.
   */
  performAutoResync?: boolean;

  /**
   * Gets or sets the resume retry count.
   */
  @visibility(Lifecycle.Read)
  resumeRetryCount?: int64;

  /**
   * Gets or sets the latest timestamp that replication status is updated.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIProtectedNicProperties {
  /**
   * Gets or sets the NIC Id.
   */
  @visibility(Lifecycle.Read)
  nicId?: string;

  /**
   * Gets or sets the NIC mac address.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * Gets or sets the NIC label.
   */
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * Gets or sets a value indicating whether this is the primary NIC.
   */
  isPrimaryNic?: boolean;

  /**
   * Gets or sets the network name.
   */
  @visibility(Lifecycle.Read)
  networkName?: string;

  /**
   * Gets or sets the target network Id within AzStackHCI Cluster.
   */
  @visibility(Lifecycle.Read)
  targetNetworkId?: string;

  /**
   * Gets or sets the target test network Id within AzStackHCI Cluster.
   */
  @visibility(Lifecycle.Read)
  testNetworkId?: string;

  /**
   * Gets or sets the selection type of the NIC.
   */
  @visibility(Lifecycle.Read)
  selectionTypeForFailover?: VMNicSelection;
}

/**
 * VMware to AzStackHCI Protected item model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIProtectedItemModelCustomPropertiesUpdate
  extends ProtectedItemModelCustomPropertiesUpdate {
  /**
   * Gets or sets the list of VM NIC to replicate.
   */
  @identifiers(#[])
  nicsToInclude?: VMwareToAzStackHCINicInput[];

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
   * Gets or sets the instance type.
   */
  instanceType: "VMwareToAzStackHCI";

  /**
   * Gets or sets the type of the OS.
   */
  osType?: string;
}

/**
 * VMware to AzStackHCI recovery point model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIRecoveryPointModelCustomProperties
  extends RecoveryPointModelCustomProperties {
  /**
   * Gets or sets the list of the disk Ids.
   */
  @visibility(Lifecycle.Read)
  diskIds?: string[];

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareToAzStackHCIRecoveryPointModelCustomProperties";
}

/**
 * VMware to AzStackHCI Replication extension model custom properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VMwareToAzStackHCIReplicationExtensionModelCustomProperties
  extends ReplicationExtensionModelCustomProperties {
  /**
   * Gets or sets the ARM Id of the source VMware fabric.
   */
  @minLength(1)
  vmwareFabricArmId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the ARM Id of the VMware site.
   */
  @visibility(Lifecycle.Read)
  vmwareSiteId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the ARM Id of the target AzStackHCI fabric.
   */
  @minLength(1)
  azStackHciFabricArmId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the ARM Id of the AzStackHCI site.
   */
  @visibility(Lifecycle.Read)
  azStackHciSiteId?: Azure.Core.armResourceIdentifier;

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
  @visibility(Lifecycle.Read)
  asrServiceUri?: url;

  /**
   * Gets or sets the Uri of Rcm.
   */
  @visibility(Lifecycle.Read)
  rcmServiceUri?: url;

  /**
   * Gets or sets the Uri of Gateway.
   */
  @visibility(Lifecycle.Read)
  gatewayServiceUri?: url;

  /**
   * Gets or sets the gateway service Id of source.
   */
  @visibility(Lifecycle.Read)
  sourceGatewayServiceId?: string;

  /**
   * Gets or sets the gateway service Id of target.
   */
  @visibility(Lifecycle.Read)
  targetGatewayServiceId?: string;

  /**
   * Gets or sets the source storage container name.
   */
  @visibility(Lifecycle.Read)
  sourceStorageContainerName?: string;

  /**
   * Gets or sets the target storage container name.
   */
  @visibility(Lifecycle.Read)
  targetStorageContainerName?: string;

  /**
   * Gets or sets the resource location.
   */
  @visibility(Lifecycle.Read)
  resourceLocation?: string;

  /**
   * Gets or sets the subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Gets or sets the resource group.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * Gets or sets the instance type.
   */
  instanceType: "VMwareToAzStackHCI";
}
