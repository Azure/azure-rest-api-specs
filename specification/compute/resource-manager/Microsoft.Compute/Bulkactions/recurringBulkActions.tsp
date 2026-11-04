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
// family, folded into the BulkActions project. Resource types, REST paths,
// and serialized request/response shapes are unchanged. Models use
// RecurringBulkAction naming in every version that includes them. Operation
// groups and the occurrence-list method adopt that naming in 2026-11-06-preview;
// earlier operation names are preserved through @renamedFrom.
//
// NAMING NOTE: RBA-owned types take the `RecurringBulkAction*` prefix to avoid
// colliding with BulkActions' bare shared types (e.g. `ProvisioningState`,
// `DeadlineType`, `ExecutionParameters`, `RetryPolicy`) that coexist in this shared
// `Microsoft.Compute` namespace.
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
union RecurringBulkActionType {
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

// Separate from the BulkActions LaunchBulkInstancesOperation provisioning state.
@added(Versions.`2026-07-06-preview`)
@doc("The provisioning state of the latest create, update, or delete operation on the recurring bulk action. Other actions have their own operation status and do not change this value.")
@lroStatus
union RecurringBulkActionProvisioningState {
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
// `RecurringBulkAction*` prefix (see file header), since these coexist in
// the `Microsoft.Compute` namespace with the BulkActions originals.

@added(Versions.`2026-07-06-preview`)
@doc("How the scheduled time is interpreted for the resource operation.")
union RecurringBulkActionDeadlineType {
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
@doc("The operation to retry when a recurring bulk action fails.")
union RecurringBulkActionResourceOperationType {
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
@doc("Retry settings for a recurring bulk action operation.")
model RecurringBulkActionRetryPolicy {
  @doc("The maximum number of retry attempts.")
  retryCount?: int32;

  @doc("The time window, in minutes, during which retries can occur.")
  retryWindowInMinutes?: int32;

  @doc("The resource operation to retry after a failure.")
  onFailureAction?: RecurringBulkActionResourceOperationType;
}

@added(Versions.`2026-07-06-preview`)
@doc("Settings that control how the recurring bulk action operation is executed.")
model RecurringBulkActionExecutionParameters {
  @removed(Versions.`2026-09-06-preview`)
  @doc("The preferred optimization goal.")
  optimizationPreference?: OptimizationPreference;

  @doc("The retry settings for failed resource operations.")
  retryPolicy?: RecurringBulkActionRetryPolicy;
}

// ------------------ Recurring bulk action resource + models ------------------

@added(Versions.`2026-07-06-preview`)
@doc("The recurring schedule for a recurring bulk action.")
model RecurringBulkActionSchedule {
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
  executionParameters?: RecurringBulkActionExecutionParameters;

  @doc("How the scheduled time is interpreted. The default is `InitiateAt`.")
  deadlineType?: RecurringBulkActionDeadlineType;
}

@added(Versions.`2026-07-06-preview`)
@doc("Schedule changes for a recurring bulk action. Omitted properties keep their current values.")
model RecurringBulkActionScheduleUpdate
  is OptionalProperties<RecurringBulkActionSchedule>;

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
@parentResource(RecurringBulkAction)
@segment("resources")
@doc("A compute resource associated with a recurring bulk action.")
model RecurringBulkActionResource {
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
model ResourceListResponse is Azure.Core.Page<RecurringBulkActionResource>;

@added(Versions.`2026-07-06-preview`)
@doc("A compute resource to add to or update in a recurring bulk action.")
model RecurringBulkActionResourceInput {
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
  resources: Array<RecurringBulkActionResourceInput>;
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
  resources: Array<RecurringBulkActionResourceInput>;
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

  @doc("Per-resource results. For asynchronous attach, detach, cancel, and delay operations, only failed or canceled resources are returned, with status Failed; success is implicit from totalResources minus the number of returned failures. Synchronous resource-settings updates can also return Succeeded entries.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Configuration and status of a recurring bulk action.")
model RecurringBulkActionProperties {
  @doc("The type of compute resource targeted by the action.")
  resourceType: ResourceType;

  @doc("The operation performed on the targeted resources.")
  actionType: RecurringBulkActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, when the schedule becomes active.")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, after which no new occurrences are scheduled.")
  endTime?: offsetDateTime;

  @doc("The recurring schedule.")
  schedule: RecurringBulkActionSchedule;

  @doc("Notification settings that apply to the recurring bulk action.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Indicates whether new occurrences are disabled.")
  disabled?: boolean;

  @doc("Read-only. The provisioning state of the recurring bulk action.")
  @visibility(Lifecycle.Read)
  provisioningState?: RecurringBulkActionProvisioningState;
}

@added(Versions.`2026-07-06-preview`)
@doc("Changes to a recurring bulk action. Omitted schedule properties keep their current values.")
model RecurringBulkActionPropertiesUpdate {
  @doc("The type of compute resource targeted by the action.")
  resourceType: ResourceType;

  @doc("The operation performed on the targeted resources.")
  actionType: RecurringBulkActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, when the schedule becomes active.")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Recurring bulk actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, after which no new occurrences are scheduled.")
  endTime?: offsetDateTime;

  @doc("Changes to the recurring schedule.")
  schedule?: RecurringBulkActionScheduleUpdate;

  @doc("Notification settings that apply to the recurring bulk action.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Indicates whether new occurrences are disabled.")
  disabled?: boolean;

  @doc("Read-only. The provisioning state of the recurring bulk action.")
  @visibility(Lifecycle.Read)
  provisioningState?: RecurringBulkActionProvisioningState;
}

@added(Versions.`2026-07-06-preview`)
@doc("A recurring bulk action associated with a specific compute resource.")
model RecurringBulkActionExtensionProperties {
  ...RecurringBulkActionProperties;

  @doc("Read-only. Notification settings that apply only to the specified compute resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  @visibility(Lifecycle.Read)
  resourceNotificationSettings?: Array<NotificationProperties>;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("Results of a recurring bulk action resource operation.")
model RecurringBulkActionResourceOperationResponse {
  @doc("The number of resources included in the operation.")
  totalResources: int32;

  @doc("The operation result for each resource.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Versions.`2026-07-06-preview`)
@doc("A recurring bulk action that operates on specified compute resources.")
model RecurringBulkAction is TrackedResource<RecurringBulkActionProperties> {
  ...ResourceNameParameter<
    RecurringBulkAction,
    KeyName = "recurringBulkActionName",
    SegmentName = "scheduledActions"
  >;
}

@added(Versions.`2026-07-06-preview`)
@doc("A recurring bulk action associated with a specific compute resource.")
model RecurringBulkActionResources
  is ExtensionResource<RecurringBulkActionExtensionProperties> {
  ...ResourceNameParameter<
    RecurringBulkActionResources,
    KeyName = "scheduledActionResourcesName",
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

  @doc("Read-only. The total resource count and terminal results available so far. Resources that have not reached a terminal state are omitted from the summary statuses.")
  @visibility(Lifecycle.Read)
  resultSummary: OccurrenceResultSummary;

  @doc("Read-only. The current state of the occurrence.")
  @visibility(Lifecycle.Read)
  provisioningState?: OccurrenceState;
}

@added(Versions.`2026-07-06-preview`)
@parentResource(RecurringBulkAction)
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
model OccurrenceResource is RecurringBulkActionResource {
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

@added(Versions.`2026-07-06-preview`)
@doc("The replacement request was accepted. Poll Azure-AsyncOperation until the operation reaches a terminal state. The resource can report Updating while schedule reconciliation is pending.")
model RecurringBulkActionReplaceResponse {
  ...ArmResourceUpdatedResponse<RecurringBulkAction>;
  ...ArmAsyncOperationHeader<FinalResult = RecurringBulkAction>;
}

@@added(
  RecurringBulkActionReplaceResponse.azureAsyncOperation,
  Versions.`2026-11-06-preview`
);

@added(Versions.`2026-07-06-preview`)
@doc("The recurring bulk action was created. Poll Azure-AsyncOperation for operation status. Creation can complete immediately with provisioningState Succeeded; this does not mean its occurrences have run.")
model RecurringBulkActionCreateResponse is ArmResourceCreatedResponse<
  RecurringBulkAction,
  ArmAsyncOperationHeader<FinalResult = RecurringBulkAction> &
    Azure.Core.Foundations.RetryAfterHeader
>;

@doc("List filter options for recurring bulk action list operations.")
model RecurringBulkActionFilterParameters {
  @added(Versions.`2026-11-06-preview`)
  @query("$filter")
  @doc("The OData filter expression to apply to the list operation. Supported fields for recurring bulk action items are: name, id, type, location, properties/startTime, properties/endTime, properties/disabled, and properties/schedule/timeZone. Supports OData comparison and logical operators and string functions such as contains and startswith. Enum-typed properties, tags, and the cast and matchesPattern functions are not supported.")
  filter?: string;
}

@doc("List filter options for recurring bulk action resource list operations.")
model RecurringBulkActionResourceFilterParameters {
  @added(Versions.`2026-11-06-preview`)
  @query("$filter")
  @doc("The OData filter expression to apply to the list operation. Supported fields for recurring bulk action resource items are: name, id, type, and resourceId. Supports OData comparison and logical operators and string functions such as contains and startswith. Enum-typed properties, tags, and the cast and matchesPattern functions are not supported.")
  filter?: string;
}

@doc("List filter options for occurrence resource list operations.")
model OccurrenceResourceFilterParameters {
  @added(Versions.`2026-11-06-preview`)
  @query("$filter")
  @doc("The OData filter expression to apply to the list operation. Supported fields for OccurrenceResource items are: name, id, type, resourceId, scheduledTime, errorDetails/code, errorDetails/message, and errorDetails/target. Supports OData comparison and logical operators and string functions such as contains and startswith. Enum-typed properties, tags, and the cast and matchesPattern functions are not supported.")
  filter?: string;
}

@added(Versions.`2026-07-06-preview`)
@renamedFrom(Versions.`2026-11-06-preview`, "ScheduledActions")
@armResourceOperations
interface RecurringBulkActions {
  @doc("Gets the specified recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  get is ArmResourceRead<RecurringBulkAction>;

  @doc("Creates or replaces a recurring bulk action. Returns 201 for a new resource or 200 for a replacement, with an Azure-AsyncOperation polling URL. A replacement can report provisioningState Updating while existing occurrences are reconciled. Poll until the operation reaches a terminal state, then GET the resource. Creating the resource can complete immediately and does not wait for its scheduled operations to run.")
  @errorsDoc("The request failed. The response contains error details.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RecurringBulkAction,
    Response =
      | RecurringBulkActionReplaceResponse
      | RecurringBulkActionCreateResponse
  >;

  @doc("Updates the specified recurring bulk action asynchronously. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status and follow the Location URL unchanged for the final result. The final 200 response contains the updated resource, not a synchronous scheduling response.")
  @returnsDoc("The update completed. The updated resource is returned by the Location polling URL.")
  @errorsDoc("The request failed. The response contains error details.")
  update is ArmCustomPatchAsync<
    RecurringBulkAction,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      RecurringBulkAction,
      RecurringBulkActionPropertiesUpdate
    >,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Deletes the specified recurring bulk action asynchronously. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status; the Location polling URL returns 204 No Content when deletion completes. Deleting a resource that does not exist returns 204 No Content immediately.")
  @errorsDoc("The request failed. The response contains error details.")
  delete is ArmResourceDeleteWithoutOkAsync<
    RecurringBulkAction,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Lists recurring bulk actions in the specified resource group.")
  @errorsDoc("The request failed. The response contains error details.")
  listByResourceGroup is ArmResourceListByParent<
    RecurringBulkAction,
    Parameters = RecurringBulkActionFilterParameters
  >;

  @doc("Lists recurring bulk actions in the specified subscription.")
  @errorsDoc("The request failed. The response contains error details.")
  listBySubscription is ArmListBySubscription<
    RecurringBulkAction,
    Parameters = RecurringBulkActionFilterParameters
  >;

  @autoRoute
  @listsResource(RecurringBulkActionResource)
  @armResourceList(RecurringBulkActionResource)
  @list
  @get
  @doc("Lists resources associated with the specified recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  listResources(
    ...ResourceInstanceParameters<RecurringBulkActionResource>,
    ...RecurringBulkActionResourceFilterParameters,
  ): ArmResponse<ResourceListResponse> | ErrorResponse;

  /** Attach resources to the recurring bulk action so they are included in future occurrences. */
  @doc("Adds resources to the specified recurring bulk action asynchronously. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status and follow the Location URL unchanged for the final 200 result. Completion covers resource reconciliation, not execution of the scheduled virtual machine operations.")
  @returnsDoc("The final result from the Location polling URL. Only failed or canceled resources appear in resourcesStatuses; an empty array means all targeted resources succeeded. A 200 result can contain per-resource failures; check Azure-AsyncOperation for the overall operation status.")
  @errorsDoc("The request failed. The response contains error details.")
  attachResources is ArmResourceActionAsync<
    RecurringBulkAction,
    ResourceAttachRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Detach resources from the recurring bulk action so they are excluded from future occurrences. */
  @doc("Removes resources from the specified recurring bulk action asynchronously. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status and follow the Location URL unchanged for the final 200 result.")
  @returnsDoc("The final result from the Location polling URL. Only failed or canceled resources appear in resourcesStatuses; an empty array means all targeted resources succeeded. A 200 result can contain per-resource failures; check Azure-AsyncOperation for the overall operation status.")
  @errorsDoc("The request failed. The response contains error details.")
  detachResources is ArmResourceActionAsync<
    RecurringBulkAction,
    ResourceDetachRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Updates resource-specific notification settings synchronously without rescheduling occurrences. Returns 200 with per-resource validation results; this operation is not a long-running scheduling operation.")
  @returnsDoc("The resource-settings update completed. The response includes per-resource results and any validation failures.")
  @errorsDoc("The request failed. The response contains error details.")
  patchResources is ArmResourceActionSync<
    RecurringBulkAction,
    ResourcePatchRequest,
    ResourceOperationResponse
  >;

  /** Disable the recurring bulk action so its future occurrences do not run. */
  @doc("Disables the specified recurring bulk action asynchronously and requests best-effort cancellation of active occurrences. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status; the Location polling URL returns 204 No Content on successful completion. Already activated virtual machine operations might not be canceled.")
  @errorsDoc("The request failed. The response contains error details.")
  disable is ArmResourceActionNoResponseContentAsync<
    RecurringBulkAction,
    void,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Enable a previously disabled recurring bulk action so its future occurrences run. */
  @doc("Enables the specified recurring bulk action asynchronously so new occurrences can be scheduled. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status; the Location polling URL returns 204 No Content on successful completion. Completion does not mean the scheduled virtual machine operations have run.")
  @errorsDoc("The request failed. The response contains error details.")
  enable is ArmResourceActionNoResponseContentAsync<
    RecurringBulkAction,
    void,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Cancel the next scheduled occurrence of the recurring bulk action. */
  @doc("Requests cancellation of the next occurrence of the specified recurring bulk action asynchronously. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status and follow the Location URL unchanged for the final 200 result. Cancellation is best effort for operations that might already have been activated.")
  @returnsDoc("The final cancellation result from the Location polling URL. Only failed or canceled operation entries appear in resourcesStatuses with status Failed; successfully canceled resources are omitted. A 200 result can contain per-resource failures; check Azure-AsyncOperation for the overall operation status.")
  @errorsDoc("The request failed. The response contains error details.")
  cancelNextOccurrence is ArmResourceActionAsync<
    RecurringBulkAction,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Trigger a manual occurrence of the recurring bulk action immediately, outside its normal schedule. */
  @doc("Creates a manual occurrence of the specified recurring bulk action for immediate execution through a long-running operation. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status and follow the Location URL unchanged for the final 200 occurrence. The operation can complete immediately after creating the occurrence, before its resources are scheduled or executed. Read the occurrence and its resources to track execution.")
  @returnsDoc("The newly created occurrence returned by the Location polling URL. Its provisioningState can be Created; completion of this operation does not mean the virtual machine operations have run.")
  @errorsDoc("The request failed. The response contains error details.")
  triggerManualOccurrence is ArmResourceActionAsync<
    RecurringBulkAction,
    void,
    Occurrence,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Occurrence> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@added(Versions.`2026-07-06-preview`)
@renamedFrom(Versions.`2026-11-06-preview`, "ScheduledActionExtension")
@armResourceOperations
interface RecurringBulkActionExtension {
  @doc("Lists recurring bulk actions associated with the specified VM.")
  @errorsDoc("The request failed. The response contains error details.")
  listByVms is ArmResourceListByParent<RecurringBulkActionResources>;
}

@added(Versions.`2026-07-06-preview`)
@renamedFrom(Versions.`2026-11-06-preview`, "ScheduledActionOperationStatus")
@armResourceOperations(#{ allowStaticRoutes: true })
interface RecurringBulkActionOperationStatus {
  @doc("Gets the status of the specified recurring bulk action operation from its Azure-AsyncOperation URL. HTTP 200 means the status was retrieved, not that the operation succeeded; inspect status for NotStarted, Running, Succeeded, Failed, or Canceled. Per-resource operations include failures only. The separate Location URL returns 202 with no body while pending, then the final operation result or 204 for successful no-content actions. Follow polling URLs unchanged, including their query parameters.")
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
  @renamedFrom(Versions.`2026-11-06-preview`, "listByScheduledAction")
  @doc("Lists occurrences for the specified recurring bulk action.")
  @errorsDoc("The request failed. The response contains error details.")
  listByRecurringBulkAction is ArmResourceListByParent<Occurrence>;

  @autoRoute
  @listsResource(OccurrenceResource)
  @armResourceList(OccurrenceResource)
  @list
  @get
  @doc("Lists resources for the specified occurrence.")
  @errorsDoc("The request failed. The response contains error details.")
  listResources(
    ...ResourceInstanceParameters<OccurrenceResource>,
    ...OccurrenceResourceFilterParameters,
  ): ArmResponse<OccurrenceResourceListResponse> | ErrorResponse;

  /** Cancel the occurrence so its pending operations do not run. */
  @doc("Requests cancellation of the specified occurrence for the specified resource IDs asynchronously. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status and follow the Location URL unchanged for the final 200 result. Cancellation is best effort for operations that might already have been activated.")
  @returnsDoc("The final cancellation result from the Location polling URL. Only failed or canceled operation entries appear in resourcesStatuses with status Failed; successfully canceled resources are omitted. A 200 result can contain per-resource failures; check Azure-AsyncOperation for the overall operation status.")
  @errorsDoc("The request failed. The response contains error details.")
  cancel is ArmResourceActionAsync<
    Occurrence,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Delay the occurrence to a later time. */
  @doc("Delays the specified occurrence for the specified resource IDs asynchronously. The initial response is 202 Accepted with no body. Poll Azure-AsyncOperation for operation status and follow the Location URL unchanged for the final 200 result. Completion means the requested rescheduling was processed, not that the virtual machine operations have executed.")
  @returnsDoc("The final delay result from the Location polling URL. Only failed or canceled operation entries appear in resourcesStatuses with status Failed; successfully delayed resources are omitted. A 200 result can contain per-resource failures; check Azure-AsyncOperation for the overall operation status.")
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
  RecurringBulkAction.name,
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
