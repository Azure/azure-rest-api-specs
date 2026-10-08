import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Compute;

// =====================================================================
// Recurring Bulk Actions (RBA) — exposed through the `scheduledActions` resource
// family, folded into the BulkActions project. API identifiers remain unchanged.
//
// NAMING NOTE: RBA collision-renames take the `ScheduledActions*` prefix to avoid
// colliding with BulkActions' bare shared types (e.g. `ProvisioningState`,
// `DeadlineType`, `ExecutionParameters`, `RetryPolicy`) that coexist in this shared
// `Microsoft.Compute` namespace. (These were named `RecurringScheduledActions*`
// through 2026-07-06-preview; renamed to `ScheduledActions*` in 2026-08-06-preview
// via `@renamedFrom`.)
// =====================================================================

// ------------------ Shared enums ------------------

@added(Versions.`2026-07-06-preview`)
@doc("The type of compute resource targeted by the recurring bulk action.")
union ResourceType {
  @doc("Azure virtual machines.")
  VirtualMachine: "VirtualMachine",

  @doc("Azure Virtual Machine Scale Sets.")
  VirtualMachineScaleSet: "VirtualMachineScaleSet",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The operation performed by the recurring bulk action.")
union ScheduledActionType {
  @doc("Starts the targeted resources.")
  Start: "Start",

  @doc("Deallocates the targeted resources.")
  Deallocate: "Deallocate",

  @doc("Hibernates the targeted resources.")
  Hibernate: "Hibernate",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("A day of the week on which the recurring bulk action can run.")
union WeekDay {
  @doc("The recurring bulk action can run on Monday.")
  Monday: "Monday",

  @doc("The recurring bulk action can run on Tuesday.")
  Tuesday: "Tuesday",

  @doc("The recurring bulk action can run on Wednesday.")
  Wednesday: "Wednesday",

  @doc("The recurring bulk action can run on Thursday.")
  Thursday: "Thursday",

  @doc("The recurring bulk action can run on Friday.")
  Friday: "Friday",

  @doc("The recurring bulk action can run on Saturday.")
  Saturday: "Saturday",

  @doc("The recurring bulk action can run on Sunday.")
  Sunday: "Sunday",

  @doc("Every day of the week.")
  All: "All",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("A month in which the recurring bulk action can run.")
union Month {
  @doc("The recurring bulk action can run in January.")
  January: "January",

  @doc("The recurring bulk action can run in February.")
  February: "February",

  @doc("The recurring bulk action can run in March.")
  March: "March",

  @doc("The recurring bulk action can run in April.")
  April: "April",

  @doc("The recurring bulk action can run in May.")
  May: "May",

  @doc("The recurring bulk action can run in June.")
  June: "June",

  @doc("The recurring bulk action can run in July.")
  July: "July",

  @doc("The recurring bulk action can run in August.")
  August: "August",

  @doc("The recurring bulk action can run in September.")
  September: "September",

  @doc("The recurring bulk action can run in October.")
  October: "October",

  @doc("The recurring bulk action can run in November.")
  November: "November",

  @doc("The recurring bulk action can run in December.")
  December: "December",

  @doc("Every month.")
  All: "All",

  string,
}

@added(Versions.`2026-07-06-preview`)
@minValue(1)
@maxValue(31)
@doc("A calendar day of the month, from 1 through 31.")
scalar DayOfTheMonth extends int32;

@added(Versions.`2026-07-06-preview`)
@doc("The current state of a recurring bulk action occurrence.")
union OccurrenceState {
  @doc("The occurrence has been created.")
  Created: "Created",

  @doc("The scheduled time for the occurrence is being updated.")
  Rescheduling: "Rescheduling",

  @doc("The occurrence has been scheduled.")
  Scheduled: "Scheduled",

  @doc("The occurrence operations completed successfully.")
  Succeeded: "Succeeded",

  @doc("One or more of the occurrence operations failed.")
  Failed: "Failed",

  @doc("Cancellation of the occurrence is in progress.")
  Cancelling: "Cancelling",

  @doc("The occurrence was canceled.")
  Canceled: "Canceled",

  string,
}

// The provisioning state of a resource within an occurrence.
@added(Versions.`2026-08-06-preview`)
@doc("The provisioning state of a recurring bulk action resource within an occurrence.")
union OccurrenceResourceProvisioningState {
  ResourceProvisioningState,

  @doc("The resource has been created")
  Created: "Created",

  @doc("The resource has been scheduled")
  Scheduled: "Scheduled",

  @doc("The resource is going through cancellation")
  Cancelling: "Cancelling",

  @doc("The resource is being rescheduled")
  Rescheduling: "Rescheduling",

  @doc("The resource is in an invalid state")
  InvalidState: "InvalidState",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The delivery method for recurring bulk action notifications.")
union NotificationType {
  @doc("Sends notifications by email.")
  Email: "Email",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The language used for recurring bulk action notifications.")
union Language {
  @doc("English (United States).")
  EnUs: "en-us",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("Current status of an operation for the specific occurrence and resource")
union ResourceOperationStatus {
  @doc("The operation completed successfully for the resource.")
  Succeeded: "Succeeded",

  @doc("The operation failed for the resource.")
  Failed: "Failed",

  string,
}

// NAMING NOTE: renamed from `ProvisioningState` to avoid colliding with the
// BulkActions LaunchBulkInstancesOperation `ProvisioningState`; takes the
// `ScheduledActions*` identity (see file header).
@added(Versions.`2026-07-06-preview`)
@renamedFrom(
  Versions.`2026-08-06-preview`,
  "RecurringScheduledActionsProvisioningState"
)
@doc("The provisioning state of the recurring bulk action.")
@lroStatus
union ScheduledActionsProvisioningState {
  ResourceProvisioningState,

  @doc("The recurring bulk action is being deleted.")
  Deleting: "Deleting",

  @added(Versions.`2026-09-06-preview`)
  @doc("The recurring bulk action is being updated.")
  Updating: "Updating",

  string,
}

@added(Versions.`2026-07-06-preview`)
@removed(Versions.`2026-09-06-preview`)
@doc("The preferred optimization goal for recurring bulk action operations.")
union OptimizationPreference {
  @doc("Prioritizes cost savings.")
  Cost: "Cost",

  @doc("Prioritizes resource availability.")
  Availability: "Availability",

  @doc("Balances cost savings and resource availability.")
  CostAvailabilityBalanced: "CostAvailabilityBalanced",

  string,
}

// ------------------ Shared models ------------------

@added(Versions.`2026-07-06-preview`)
@doc("Settings for notifications about upcoming recurring bulk action operations.")
model NotificationProperties {
  @doc("The notification destination. For email notifications, specify a valid email address.")
  destination: string;

  @doc("The notification delivery method.")
  type: NotificationType;

  @doc("The language used for the notification.")
  language: Language;

  @doc("If true, notifications to this destination are disabled.")
  disabled?: boolean;
}

@@identifiers(Azure.Core.Foundations.Error.details, #[]);

// ------------------ RBA-owned execution/retry types (forked, no BA coupling) ------------------
// Forked from the BulkActions shared `models.tsp` so the Recurring Bulk Actions surface does NOT
// couple to the BulkActions type pool: a BulkActions change to its shared types can no longer
// alter the RBA contract. Bulk-VM-specific leakage is intentionally dropped — `verifyVmAgentHealth`
// (an executeStart concept) and the `GetInstanceView` operation value. Names take the
// `ScheduledActions*` collision-rename prefix (see file header), since these coexist in
// the `Microsoft.Compute` namespace with the BulkActions originals.

@added(Versions.`2026-07-06-preview`)
@renamedFrom(
  Versions.`2026-08-06-preview`,
  "RecurringScheduledActionsDeadlineType"
)
@doc("How the scheduled time is interpreted for the resource operation.")
union ScheduledActionsDeadlineType {
  @removed(Versions.`2026-09-06-preview`)
  @doc("The deadline type is not specified.")
  Unknown: "Unknown",

  @doc("Starts the operation at the scheduled time.")
  InitiateAt: "InitiateAt",

  @doc("Completes the operation by the scheduled time.")
  CompleteBy: "CompleteBy",

  string,
}

@added(Versions.`2026-07-06-preview`)
@renamedFrom(
  Versions.`2026-08-06-preview`,
  "RecurringScheduledActionsResourceOperationType"
)
@doc("The operation to retry when a recurring bulk action fails.")
union ScheduledActionsResourceOperationType {
  @removed(Versions.`2026-09-06-preview`)
  @doc("The operation is not specified.")
  Unknown: "Unknown",

  @doc("Starts the resources.")
  Start: "Start",

  @doc("Deallocates the resources.")
  Deallocate: "Deallocate",

  @doc("Hibernates the resources.")
  Hibernate: "Hibernate",

  @doc("Creates the resources.")
  Create: "Create",

  @doc("Deletes the resources.")
  Delete: "Delete",

  string,
}

@added(Versions.`2026-07-06-preview`)
@renamedFrom(
  Versions.`2026-08-06-preview`,
  "RecurringScheduledActionsRetryPolicy"
)
@doc("Retry settings for a recurring bulk action operation.")
model ScheduledActionsRetryPolicy {
  @doc("The maximum number of retry attempts.")
  retryCount?: int32;

  @doc("The time window, in minutes, during which retries can occur.")
  retryWindowInMinutes?: int32;

  @doc("The resource operation to retry after a failure.")
  onFailureAction?: ScheduledActionsResourceOperationType;
}

@added(Versions.`2026-07-06-preview`)
@renamedFrom(
  Versions.`2026-08-06-preview`,
  "RecurringScheduledActionsExecutionParameters"
)
@doc("Settings that control how the recurring bulk action operation is executed.")
model ScheduledActionsExecutionParameters {
  @removed(Versions.`2026-09-06-preview`)
  @doc("The preferred optimization goal.")
  optimizationPreference?: OptimizationPreference;

  @doc("The retry settings for failed resource operations.")
  retryPolicy?: ScheduledActionsRetryPolicy;
}

// ------------------ Recurring bulk action resource + models ------------------

@added(Versions.`2026-07-06-preview`)
@doc("The recurring schedule for a recurring bulk action.")
model ScheduledActionsSchedule {
  @doc("The local time of day when the recurring bulk action runs.")
  scheduledTime: plainTime;

  @doc("The time zone used to interpret the scheduled time.")
  timeZone: string;

  @doc("The days of the week when the action runs. An empty array means every day of the week.")
  requestedWeekDays?: WeekDay[];

  @doc("The months when the action runs. An empty array means every month.")
  requestedMonths?: Month[];

  @doc("The calendar days when the action runs. An empty array means every day of the month.")
  requestedDaysOfTheMonth?: DayOfTheMonth[];

  @doc("Settings that control operation execution and retries.")
  executionParameters?: ScheduledActionsExecutionParameters;

  @doc("How the scheduled time is interpreted. The default is `InitiateAt`.")
  deadlineType?: ScheduledActionsDeadlineType;
}

@added(Versions.`2026-07-06-preview`)
@doc("Schedule changes for a recurring bulk action. Omitted properties keep their current values.")
model ScheduledActionsScheduleUpdate
  is OptionalProperties<ScheduledActionsSchedule>;

@added(Versions.`2026-07-06-preview`)
@doc("The Azure resource ID of a virtual machine attached to a recurring bulk action.")
scalar ValidScheduledActionResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines",
    },
    {
      type: "Microsoft.Compute/virtualMachineScaleSets",
    }
  ]>;

@added(Versions.`2026-07-06-preview`)
@parentResource(ScheduledAction)
@segment("resources")
@doc("A compute resource associated with a recurring bulk action.")
model ScheduledActionResource {
  @doc("Read-only. The name of the association resource.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Read-only. The Azure resource ID of the association resource.")
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("Read-only. The Azure resource type of the associated resource.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("The Azure resource ID of the targeted virtual machine.")
  resourceId: ValidScheduledActionResourceId;

  @doc("Notification settings that apply only to this resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;
}

@@identifiers(ResourceListResponse.value, #[]);

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("A paged list of compute resources associated with a recurring bulk action.")
model ResourceListResponse is Azure.Core.Page<ScheduledActionResource>;

@added(Versions.`2026-07-06-preview`)
@doc("A compute resource to add to or update in a recurring bulk action.")
model ScheduledActionResourceInput {
  @doc("The Azure resource ID of the targeted virtual machine.")
  resourceId: ValidScheduledActionResourceId;

  @doc("Notification settings that apply only to this resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Resources to attach to a recurring bulk action.")
model ResourceAttachRequest {
  @doc("The list of resources to attach to the recurring bulk action.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Resources to remove from a recurring bulk action.")
model ResourceDetachRequest {
  @doc("The Azure resource IDs of the resources to remove.")
  resources: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Resource-specific settings to update in a recurring bulk action.")
model ResourcePatchRequest {
  @doc("The resources and notification settings to update.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Request body for canceling a recurring bulk action occurrence.")
model CancelOccurrenceRequest {
  @doc("The resources for which operations should be canceled. An empty array cancels all operations for all resources for the occurrence.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Current status for a targeted resource in a recurring bulk action occurrence.")
model ResourceStatus {
  @doc("The Azure resource ID of the targeted resource.")
  resourceId: ValidScheduledActionResourceId;

  @doc("The result of the operation for the resource.")
  status: ResourceOperationStatus;

  @doc("Error details when the operation fails for the resource.")
  error?: Azure.Core.Foundations.Error;
}

@added(Versions.`2026-07-06-preview`)
@doc("Results of a recurring bulk action operation for targeted resources.")
model ResourceOperationResponse {
  @doc("The number of resources included in the operation.")
  totalResources: int32;

  @doc("The operation result for each resource.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Configuration and status of a recurring bulk action.")
model ScheduledActionProperties {
  @doc("The type of compute resource targeted by the action.")
  resourceType: ResourceType;

  @doc("The operation performed on the targeted resources.")
  actionType: ScheduledActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, when the schedule becomes active.")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, after which no new occurrences are scheduled.")
  endTime?: offsetDateTime;

  @doc("The recurring schedule.")
  schedule: ScheduledActionsSchedule;

  @doc("Notification settings that apply to the recurring bulk action.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Indicates whether new occurrences are disabled.")
  disabled?: boolean;

  @doc("Read-only. The provisioning state of the recurring bulk action.")
  @visibility(Lifecycle.Read)
  provisioningState?: ScheduledActionsProvisioningState;
}

@added(Versions.`2026-07-06-preview`)
@doc("Changes to a recurring bulk action. Omitted schedule properties keep their current values.")
model ScheduledActionPropertiesUpdate {
  @doc("The type of compute resource targeted by the action.")
  resourceType: ResourceType;

  @doc("The operation performed on the targeted resources.")
  actionType: ScheduledActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, when the schedule becomes active.")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, after which no new occurrences are scheduled.")
  endTime?: offsetDateTime;

  @doc("Changes to the recurring schedule.")
  schedule?: ScheduledActionsScheduleUpdate;

  @doc("Notification settings that apply to the recurring bulk action.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Indicates whether new occurrences are disabled.")
  disabled?: boolean;

  @doc("Read-only. The provisioning state of the recurring bulk action.")
  @visibility(Lifecycle.Read)
  provisioningState?: ScheduledActionsProvisioningState;
}

@added(Versions.`2026-07-06-preview`)
@doc("A recurring bulk action associated with a specific compute resource.")
model ScheduledActionsExtensionProperties {
  ...ScheduledActionProperties;

  @doc("Read-only. Notification settings that apply only to the specified compute resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  @visibility(Lifecycle.Read)
  resourceNotificationSettings?: Array<NotificationProperties>;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("Results of a recurring bulk action resource operation.")
model ScheduledActionResourceOperationResponse {
  @doc("The number of resources included in the operation.")
  totalResources: int32;

  @doc("The operation result for each resource.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Versions.`2026-07-06-preview`)
@doc("A recurring bulk action that operates on specified compute resources.")
model ScheduledAction is TrackedResource<ScheduledActionProperties> {
  ...ResourceNameParameter<ScheduledAction>;
}

@added(Versions.`2026-07-06-preview`)
@doc("A recurring bulk action associated with a specific compute resource.")
model ScheduledActionResources
  is ExtensionResource<ScheduledActionsExtensionProperties> {
  ...ResourceNameParameter<
    ScheduledActionResources,
    SegmentName = "associatedScheduledActions"
  >;
}

// ------------------ Occurrence resource + models ------------------

@added(Versions.`2026-07-06-preview`)
@doc("Summary of operation results across targeted resources.")
model ResourceResultSummary {
  @doc("The result code shared by the resources in this group. A successful result uses `Success`.")
  code: string;

  @doc("The number of resources with this result code.")
  count: int32;

  @doc("Error details for failed resources. This property is omitted for successful results.")
  errorDetails?: Azure.Core.Foundations.Error;
}

@added(Versions.`2026-07-06-preview`)
@doc("Summary of results for a recurring bulk action occurrence.")
model OccurrenceResultSummary {
  @doc("The number of resources targeted by the occurrence.")
  total: int32;

  @doc("Resource counts grouped by result code.")
  @Azure.ResourceManager.identifiers(#["code"])
  statuses: ResourceResultSummary[];
}

@added(Versions.`2026-07-06-preview`)
@doc("Properties of a recurring bulk action occurrence.")
model OccurrenceProperties {
  @doc("Read-only. The UTC date and time when the occurrence is scheduled to run.")
  @visibility(Lifecycle.Read)
  scheduledTime: utcDateTime;

  @doc("Read-only. The result summary after the occurrence reaches a final state.")
  @visibility(Lifecycle.Read)
  resultSummary: OccurrenceResultSummary;

  @doc("Read-only. The current state of the occurrence.")
  @visibility(Lifecycle.Read)
  provisioningState?: OccurrenceState;
}

@added(Versions.`2026-07-06-preview`)
@parentResource(ScheduledAction)
@doc("One scheduled execution of a recurring bulk action.")
model Occurrence is ProxyResource<OccurrenceProperties> {
  ...ResourceNameParameter<
    Occurrence,
    KeyName = "occurrenceId",
    NamePattern = "[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}"
  >;
}

@added(Versions.`2026-07-06-preview`)
@parentResource(Occurrence)
@doc("Scheduling and status details for a resource included in a recurring bulk action occurrence.")
model OccurrenceResource is ScheduledActionResource {
  @doc("Read-only. The UTC date and time when the operation is scheduled for this resource.")
  @visibility(Lifecycle.Read)
  scheduledTime: utcDateTime;

  @doc("Read-only. The current state of the operation for this resource.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Versions.`2026-08-06-preview`, ResourceProvisioningState)
  provisioningState?: OccurrenceResourceProvisioningState;

  @doc("Read-only. Error details when the operation fails for this resource.")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.Core.Foundations.Error;
}

@@identifiers(OccurrenceResourceListResponse.value, #[]);

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("Paged list of resources included in a recurring bulk action occurrence.")
model OccurrenceResourceListResponse is Azure.Core.Page<OccurrenceResource>;

@added(Versions.`2026-07-06-preview`)
@doc("Request body for delaying a recurring bulk action occurrence.")
model DelayRequest {
  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The new date and time for the occurrence, including the UTC offset.")
  delay: offsetDateTime;

  @doc("The resources to delay. An empty array delays all resources in the occurrence.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
@doc("The Azure resource ID of a recurring bulk action.")
scalar ScheduledActionsId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Compute/scheduledActions",
    }
  ]>;

@added(Versions.`2026-07-06-preview`)
@doc("An occurrence associated with a specific compute resource.")
model OccurrenceExtensionProperties {
  @doc("The Azure resource ID of the targeted virtual machine.")
  resourceId: ValidScheduledActionResourceId;

  @doc("Notification settings that apply only to this resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;

  @doc("Read-only. The UTC date and time when the operation is scheduled for this resource.")
  @visibility(Lifecycle.Read)
  scheduledTime: utcDateTime;

  @doc("Read-only. The current state of the operation for this resource.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Versions.`2026-08-06-preview`, ResourceProvisioningState)
  provisioningState?: OccurrenceResourceProvisioningState;

  @doc("Read-only. Error details when the operation fails for this resource.")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.Core.Foundations.Error;

  @doc("The Azure resource ID of the recurring bulk action that owns the occurrence.")
  scheduledActionId: ScheduledActionsId;
}

@added(Versions.`2026-07-06-preview`)
@doc("A recurring bulk action occurrence associated with a specific compute resource.")
model OccurrenceExtensionResource
  is ExtensionResource<OccurrenceExtensionProperties> {
  ...ResourceNameParameter<
    OccurrenceExtensionResource,
    SegmentName = "associatedOccurrences"
  >;
}

// ------------------ Recurring bulk action operations ------------------

// Keep Swagger tags stable for existing consumers; Learn groups use operation IDs.
@added(Versions.`2026-07-06-preview`)
@renamedFrom(Versions.`2026-09-06-preview`, "ScheduledActions")
@armResourceOperations
@tag("ScheduledActions")
interface RecurringBulkActions {
  @doc("Gets the specified recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  get is ArmResourceRead<ScheduledAction>;

  @doc("Creates or updates a recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScheduledAction>;

  @doc("Updates the specified recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  update is ArmCustomPatchAsync<
    ScheduledAction,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ScheduledAction,
      ScheduledActionPropertiesUpdate
    >,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Deletes the specified recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ScheduledAction,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Lists recurring bulk actions in the specified resource group.")
  @errorsDoc("The request failed. The response contains error details.")
  listByResourceGroup is ArmResourceListByParent<ScheduledAction>;

  @doc("Lists recurring bulk actions in the specified subscription.")
  @errorsDoc("The request failed. The response contains error details.")
  listBySubscription is ArmListBySubscription<ScheduledAction>;

  @autoRoute
  @listsResource(ScheduledActionResource)
  @armResourceList(ScheduledActionResource)
  @list
  @get
  @doc("Lists resources associated with the specified recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  listResources(...ResourceInstanceParameters<ScheduledActionResource>):
    | ArmResponse<ResourceListResponse>
    | ErrorResponse;

  /** Attach resources to the recurring bulk action so they are included in future occurrences. */
  @doc("Adds resources to the specified recurring bulk action.")
  @returnsDoc("The resources were added successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  attachResources is ArmResourceActionAsync<
    ScheduledAction,
    ResourceAttachRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Detach resources from the recurring bulk action so they are excluded from future occurrences. */
  @doc("Removes resources from the specified recurring bulk action.")
  @returnsDoc("The resources were removed successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  detachResources is ArmResourceActionAsync<
    ScheduledAction,
    ResourceDetachRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Updates resource-specific settings for the specified recurring bulk action.")
  @returnsDoc("The resource settings were updated successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  patchResources is ArmResourceActionSync<
    ScheduledAction,
    ResourcePatchRequest,
    ResourceOperationResponse
  >;

  /** Disable the recurring bulk action so its future occurrences do not run. */
  @doc("Disables the specified recurring bulk action so future occurrences do not run.")
  @errorsDoc("The request failed. The response contains error details.")
  disable is ArmResourceActionNoResponseContentAsync<
    ScheduledAction,
    void,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Enable a previously disabled recurring bulk action so its future occurrences run. */
  @doc("Enables the specified recurring bulk action so new occurrences run.")
  @errorsDoc("The request failed. The response contains error details.")
  enable is ArmResourceActionNoResponseContentAsync<
    ScheduledAction,
    void,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Cancel the next scheduled occurrence of the recurring bulk action. */
  @doc("Cancels the next occurrence of the specified recurring bulk action.")
  @returnsDoc("The next occurrence was canceled successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  cancelNextOccurrence is ArmResourceActionAsync<
    ScheduledAction,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Trigger a manual occurrence of the recurring bulk action immediately, outside its normal schedule. */
  @doc("Runs the specified recurring bulk action immediately.")
  @returnsDoc("The manual occurrence was started successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  triggerManualOccurrence is ArmResourceActionAsync<
    ScheduledAction,
    void,
    Occurrence,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Occurrence> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@added(Versions.`2026-07-06-preview`)
@renamedFrom(Versions.`2026-09-06-preview`, "ScheduledActionExtension")
@armResourceOperations
@tag("ScheduledActionExtension")
interface RecurringBulkActionExtension {
  @doc("Lists recurring bulk actions associated with the specified VM.")
  @errorsDoc("The request failed. The response contains error details.")
  listByVms is ArmResourceListByParent<ScheduledActionResources>;
}

@added(Versions.`2026-07-06-preview`)
@renamedFrom(Versions.`2026-09-06-preview`, "ScheduledActionOperationStatus")
@armResourceOperations(#{ allowStaticRoutes: true })
@tag("ScheduledActionOperationStatus")
interface RecurringBulkActionOperationStatus {
  @doc("Gets the status of the specified recurring bulk action operation.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/scheduledActionsOperationStatuses/{operationId}")
  @errorsDoc("The request failed. The response contains error details.")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("The Azure region where the operation is running.")
    @path
    @minLength(1)
    location: azureLocation,

    @doc("The operation ID in UUID format.")
    @path
    @minLength(1)
    @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
    operationId: string,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}

// ------------------ Occurrence operations ------------------

@added(Versions.`2026-07-06-preview`)
@armResourceOperations
interface Occurrences {
  @doc("Gets the specified occurrence.")
  @errorsDoc("The request failed. The response contains error details.")
  get is ArmResourceRead<Occurrence>;
  @doc("Lists occurrences for the specified recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  listByScheduledAction is ArmResourceListByParent<Occurrence>;

  @autoRoute
  @listsResource(OccurrenceResource)
  @armResourceList(OccurrenceResource)
  @list
  @get
  @doc("Lists resources for the specified occurrence.")
  @errorsDoc("The request failed. The response contains error details.")
  listResources(...ResourceInstanceParameters<OccurrenceResource>):
    | ArmResponse<OccurrenceResourceListResponse>
    | ErrorResponse;

  /** Cancel the occurrence so its pending operations do not run. */
  @doc("Cancels the specified occurrence for the specified resource IDs.")
  @returnsDoc("The occurrence cancellation completed successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  cancel is ArmResourceActionAsync<
    Occurrence,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Delay the occurrence to a later time. */
  @doc("Delays the specified occurrence for the specified resource IDs.")
  @returnsDoc("The occurrence delay completed successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  delay is ArmResourceActionAsync<
    Occurrence,
    DelayRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@added(Versions.`2026-07-06-preview`)
@armResourceOperations
interface OccurrenceExtension {
  @doc("Lists recurring bulk action occurrences associated with the specified VM.")
  @errorsDoc("The request failed. The response contains error details.")
  listOccurrenceByVms is ArmResourceListByParent<OccurrenceExtensionResource>;
}

@@doc(
  ResourceListResponse.value,
  "The compute resources associated with the recurring bulk action."
);

@@doc(
  ScheduledAction.name,
  "The name of the recurring bulk action. It must be 3 to 24 characters and can contain only letters, numbers, and hyphens."
);

@@doc(Occurrence.name, "The occurrence ID in UUID format.");

@@doc(
  RecurringBulkActions.createOrUpdate::parameters.resource,
  "The recurring bulk action to create or update."
);

@@doc(
  RecurringBulkActions.update::parameters.properties,
  "The recurring bulk action properties to update. Omitted properties keep their current values."
);

@@doc(
  RecurringBulkActions.attachResources::parameters.body,
  "The resources to add to the recurring bulk action."
);

@@doc(
  RecurringBulkActions.detachResources::parameters.body,
  "The resources to remove from the recurring bulk action."
);

@@doc(
  RecurringBulkActions.patchResources::parameters.body,
  "The resource-specific settings to update."
);

@@doc(
  RecurringBulkActions.cancelNextOccurrence::parameters.body,
  "The resources to cancel in the next occurrence. If no resource IDs are provided, the occurrence is canceled for all resources."
);

@@doc(
  Azure.ResourceManager.ResourceUriParameter.resourceUri,
  "The fully qualified Azure resource ID of the compute resource."
);

@@doc(
  Occurrences.cancel::parameters.body,
  "The resources to cancel in the occurrence. If no resource IDs are provided, the occurrence is canceled for all resources."
);

@@doc(
  Occurrences.delay::parameters.body,
  "The new scheduled time and resources to delay in the occurrence. If no resource IDs are provided, all resources are delayed."
);
