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
// ScheduledActions (SA) — the recurring `scheduledActions` resource
// family, folded into the BulkActions project.
//
// NAMING NOTE: SA collision-renames take the `ScheduledActions*` prefix to avoid
// colliding with BulkActions' bare shared types (e.g. `ProvisioningState`,
// `DeadlineType`, `ExecutionParameters`, `RetryPolicy`) that coexist in this shared
// `Microsoft.Compute` namespace. (These were named `RecurringScheduledActions*`
// through 2026-07-06-preview; renamed to `ScheduledActions*` in 2026-08-06-preview
// via `@renamedFrom`.)
// =====================================================================

// ------------------ Shared enums ------------------

@added(Versions.`2026-07-06-preview`)
@doc("The type of compute resource targeted by the scheduled action.")
union ResourceType {
  @doc("Azure virtual machines.")
  VirtualMachine: "VirtualMachine",

  @doc("Azure Virtual Machine Scale Sets.")
  VirtualMachineScaleSet: "VirtualMachineScaleSet",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The operation performed by the scheduled action.")
union ScheduledActionType {
  @doc("Starts the targeted resources.")
  Start: "Start",

  @doc("Deallocates the targeted resources.")
  Deallocate: "Deallocate",

  @doc("Hibernates and deallocates the targeted resources.")
  Hibernate: "Hibernate",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("A day of the week on which the scheduled action can run.")
union WeekDay {
  @doc("Monday.")
  Monday: "Monday",

  @doc("Tuesday.")
  Tuesday: "Tuesday",

  @doc("Wednesday.")
  Wednesday: "Wednesday",

  @doc("Thursday.")
  Thursday: "Thursday",

  @doc("Friday.")
  Friday: "Friday",

  @doc("Saturday.")
  Saturday: "Saturday",

  @doc("Sunday.")
  Sunday: "Sunday",

  @doc("Every day of the week.")
  All: "All",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("A month in which the scheduled action can run.")
union Month {
  @doc("January.")
  January: "January",

  @doc("February.")
  February: "February",

  @doc("March.")
  March: "March",

  @doc("April.")
  April: "April",

  @doc("May.")
  May: "May",

  @doc("June.")
  June: "June",

  @doc("July.")
  July: "July",

  @doc("August.")
  August: "August",

  @doc("September.")
  September: "September",

  @doc("October.")
  October: "October",

  @doc("November.")
  November: "November",

  @doc("December.")
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
@doc("The current state of a scheduled action occurrence.")
union OccurrenceState {
  @doc("The occurrence has been created.")
  Created: "Created",

  @doc("The scheduled time for the occurrence is being updated.")
  Rescheduling: "Rescheduling",

  @doc("The occurrence is waiting for its scheduled time.")
  Scheduled: "Scheduled",

  @doc("The occurrence completed successfully.")
  Succeeded: "Succeeded",

  @doc("The occurrence failed.")
  Failed: "Failed",

  @doc("Cancellation of the occurrence is in progress.")
  Cancelling: "Cancelling",

  @doc("The occurrence was canceled.")
  Canceled: "Canceled",

  string,
}

// The provisioning state of a resource within an occurrence.
@added(Versions.`2026-08-06-preview`)
@doc("The provisioning state of a scheduled-action resource within an occurrence.")
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
@doc("The delivery method for scheduled action notifications.")
union NotificationType {
  @doc("Sends notifications by email.")
  Email: "Email",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The language used for scheduled action notifications.")
union Language {
  @doc("English (United States).")
  EnUs: "en-us",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("Current status of a scheduled action operation for a targeted resource.")
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
@doc("The provisioning state of the scheduled action.")
@lroStatus
union ScheduledActionsProvisioningState {
  ResourceProvisioningState,

  @doc("The scheduled action is being deleted.")
  Deleting: "Deleting",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The preferred optimization goal for scheduled action operations.")
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
@doc("Settings for notifications about upcoming scheduled action operations.")
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

// ------------------ SA-owned execution/retry types (forked, no BA coupling) ------------------
// Forked from the BulkActions shared `models.tsp` so the ScheduledActions surface does NOT
// couple to the BulkActions type pool: a BulkActions change to its shared types can no longer
// alter the SA contract. Bulk-VM-specific leakage is intentionally dropped — `verifyVmAgentHealth`
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
@doc("The operation to retry when a scheduled action fails.")
union ScheduledActionsResourceOperationType {
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
@doc("Retry settings for a scheduled action operation.")
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
@doc("Settings that control how the scheduled action operation is executed.")
model ScheduledActionsExecutionParameters {
  @doc("The preferred optimization goal.")
  optimizationPreference?: OptimizationPreference;

  @doc("The retry settings for failed resource operations.")
  retryPolicy?: ScheduledActionsRetryPolicy;
}

// ------------------ ScheduledAction resource + models ------------------

@added(Versions.`2026-07-06-preview`)
@doc("The recurring schedule for a scheduled action.")
model ScheduledActionsSchedule {
  @doc("The local time of day when the scheduled action runs.")
  scheduledTime: plainTime;

  @doc("The time zone used to interpret the scheduled time.")
  timeZone: string;

  @doc("The days of the week when the action runs. An empty array means every day of the week.")
  requestedWeekDays?: WeekDay[];

  @doc("The months when the action runs. An empty array means every month.")
  requestedMonths?: Month[];

  @doc("The calendar days when the action runs. An empty array means every day of the month.")
  requestedDaysOfTheMonth?: DayOfTheMonth[];

  @doc("Settings that control execution and retries.")
  executionParameters?: ScheduledActionsExecutionParameters;

  @doc("How the scheduled time is interpreted. The default is `InitiateAt`.")
  deadlineType?: ScheduledActionsDeadlineType;
}

@added(Versions.`2026-07-06-preview`)
@doc("Schedule changes for a scheduled action. Omitted properties keep their current values.")
model ScheduledActionsScheduleUpdate
  is OptionalProperties<ScheduledActionsSchedule>;

@added(Versions.`2026-07-06-preview`)
@doc("The Azure resource ID of a virtual machine attached to a scheduled action.")
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
@doc("A compute resource associated with a scheduled action.")
model ScheduledActionResource {
  @doc("Read-only. The name of the association resource.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Read-only. The Azure resource ID of the association resource.")
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("Read-only. The Azure resource type of the association resource.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("The Azure resource ID of the targeted virtual machine.")
  resourceId: ValidScheduledActionResourceId;

  @doc("Notification settings that apply only to this resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;
}

@@identifiers(ResourceListResponse.value, #[]);
@@doc(
  ResourceListResponse.value,
  "The compute resources associated with the scheduled action."
);

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("A paged list of compute resources associated with a scheduled action.")
model ResourceListResponse is Azure.Core.Page<ScheduledActionResource>;

@added(Versions.`2026-07-06-preview`)
@doc("A compute resource to add to or update in a scheduled action.")
model ScheduledActionResourceInput {
  @doc("The Azure resource ID of the targeted virtual machine.")
  resourceId: ValidScheduledActionResourceId;

  @doc("Notification settings that apply only to this resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Resources to add to a scheduled action.")
model ResourceAttachRequest {
  @doc("The resources (VMs) to add.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Resources to remove from a scheduled action.")
model ResourceDetachRequest {
  @doc("The Azure resource IDs of the resources to remove.")
  resources: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Resource-specific settings to update in a scheduled action.")
model ResourcePatchRequest {
  @doc("The resources and notification settings to update.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Request body for canceling a scheduled action occurrence.")
model CancelOccurrenceRequest {
  @doc("The resources to cancel. An empty array cancels the occurrence for all resources.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Current status for a targeted resource in a scheduled action occurrence.")
model ResourceStatus {
  @doc("The Azure resource ID of the targeted resource.")
  resourceId: ValidScheduledActionResourceId;

  @doc("The result of the operation for the resource.")
  status: ResourceOperationStatus;

  @doc("Error details when the operation fails for the resource.")
  error?: Azure.Core.Foundations.Error;
}

@added(Versions.`2026-07-06-preview`)
@doc("Results of a scheduled action operation for targeted resources.")
model ResourceOperationResponse {
  @doc("The number of resources included in the operation.")
  totalResources: int32;

  @doc("The operation result for each resource.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Configuration and status of a scheduled action.")
model ScheduledActionProperties {
  @doc("The type of compute resource targeted by the action.")
  resourceType: ResourceType;

  @doc("The operation performed on the targeted resources.")
  actionType: ScheduledActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Scheduled actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, when the schedule becomes active.")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Scheduled actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, after which no new occurrences are scheduled.")
  endTime?: offsetDateTime;

  @doc("The recurring schedule.")
  schedule: ScheduledActionsSchedule;

  @doc("Notification settings that apply to the scheduled action.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Indicates whether new occurrences are disabled.")
  disabled?: boolean;

  @doc("Read-only. The provisioning state of the scheduled action.")
  @visibility(Lifecycle.Read)
  provisioningState?: ScheduledActionsProvisioningState;
}

@added(Versions.`2026-07-06-preview`)
@doc("Changes to a scheduled action. Omitted schedule properties keep their current values.")
model ScheduledActionPropertiesUpdate {
  @doc("The type of compute resource targeted by the action.")
  resourceType: ResourceType;

  @doc("The operation performed on the targeted resources.")
  actionType: ScheduledActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Scheduled actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, when the schedule becomes active.")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Scheduled actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The date and time, including UTC offset, after which no new occurrences are scheduled.")
  endTime?: offsetDateTime;

  @doc("Changes to the recurring schedule.")
  schedule?: ScheduledActionsScheduleUpdate;

  @doc("Notification settings that apply to the scheduled action.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Indicates whether new occurrences are disabled.")
  disabled?: boolean;

  @doc("Read-only. The provisioning state of the scheduled action.")
  @visibility(Lifecycle.Read)
  provisioningState?: ScheduledActionsProvisioningState;
}

@added(Versions.`2026-07-06-preview`)
@doc("A scheduled action associated with a specific compute resource.")
model ScheduledActionsExtensionProperties {
  ...ScheduledActionProperties;

  @doc("Read-only. Notification settings that apply only to the specified compute resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  @visibility(Lifecycle.Read)
  resourceNotificationSettings?: Array<NotificationProperties>;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("Results of a scheduled action resource operation.")
model ScheduledActionResourceOperationResponse {
  @doc("The number of resources included in the operation.")
  totalResources: int32;

  @doc("The operation result for each resource.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Versions.`2026-07-06-preview`)
@doc("A recurring action that operates on specified compute resources.")
model ScheduledAction is TrackedResource<ScheduledActionProperties> {
  ...ResourceNameParameter<ScheduledAction>;
}

@@doc(
  ScheduledAction.name,
  "The name of the scheduled action. It must be 3 to 24 characters and can contain only letters, numbers, and hyphens."
);

@added(Versions.`2026-07-06-preview`)
@doc("A scheduled action associated with a specific compute resource.")
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
@doc("Summary of results for a scheduled action occurrence.")
model OccurrenceResultSummary {
  @doc("The number of resources targeted by the occurrence.")
  total: int32;

  @doc("Resource counts grouped by result code.")
  @Azure.ResourceManager.identifiers(#["code"])
  statuses: ResourceResultSummary[];
}

@added(Versions.`2026-07-06-preview`)
@doc("Properties of a scheduled action occurrence.")
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
@doc("One scheduled execution of a scheduled action.")
@parentResource(ScheduledAction)
model Occurrence is ProxyResource<OccurrenceProperties> {
  ...ResourceNameParameter<
    Occurrence,
    KeyName = "occurrenceId",
    NamePattern = "[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}"
  >;
}

@@doc(Occurrence.name, "The occurrence ID in UUID format.");

@added(Versions.`2026-07-06-preview`)
@doc("Scheduling and status details for a resource included in a scheduled action occurrence.")
@parentResource(Occurrence)
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
@doc("Paged list of resources included in a scheduled action occurrence.")
model OccurrenceResourceListResponse is Azure.Core.Page<OccurrenceResource>;

@added(Versions.`2026-07-06-preview`)
@doc("Request body for delaying a scheduled action occurrence.")
model DelayRequest {
  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Scheduled actions execute at a customer-provided local (wall-clock) time; the UTC offset carries the caller's timezone and must be preserved, so offsetDateTime is required."
  @doc("The new date and time for the occurrence, including the UTC offset.")
  delay: offsetDateTime;

  @doc("The resources to delay. An empty array delays all resources in the occurrence.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
@doc("The occurrence was retrieved successfully.")
model OccurrenceGetResponse is ArmResponse<Occurrence>;

@added(Versions.`2026-07-06-preview`)
@doc("The occurrences were retrieved successfully.")
model OccurrenceListByScheduledActionResponse
  is ArmResponse<ResourceListResult<Occurrence>>;

@added(Versions.`2026-07-06-preview`)
@doc("The occurrence resources were retrieved successfully.")
model OccurrenceResourcesListResponse
  is ArmResponse<OccurrenceResourceListResponse>;

@added(Versions.`2026-07-06-preview`)
@doc("The Azure resource ID of a scheduled action.")
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

  @doc("The Azure resource ID of the scheduled action that owns the occurrence.")
  scheduledActionId: ScheduledActionsId;
}

@added(Versions.`2026-07-06-preview`)
@doc("A scheduled action occurrence associated with a specific compute resource.")
model OccurrenceExtensionResource
  is ExtensionResource<OccurrenceExtensionProperties> {
  ...ResourceNameParameter<
    OccurrenceExtensionResource,
    SegmentName = "associatedOccurrences"
  >;
}

// ------------------ ScheduledAction operations ------------------

@doc("The scheduled action was retrieved successfully.")
model ScheduledActionGetResponse is ArmResponse<ScheduledAction>;

@doc("The scheduled action was updated successfully.")
model ScheduledActionUpdatedResponse
  is ArmResourceUpdatedResponse<ScheduledAction>;

@doc("The scheduled action was created successfully.")
model ScheduledActionCreatedResponse
  is ArmResourceCreatedResponse<
    ScheduledAction,
    ArmAsyncOperationHeader<FinalResult = ScheduledAction> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

@doc("The scheduled action was updated successfully.")
model ScheduledActionPatchResponse is ArmResponse<ScheduledAction>;

@doc("The scheduled actions were retrieved successfully.")
model ScheduledActionListResponse
  is ArmResponse<ResourceListResult<ScheduledAction>>;

@doc("The associated resources were retrieved successfully.")
model ScheduledActionResourcesListResponse is ArmResponse<ResourceListResponse>;

@doc("The scheduled actions were retrieved successfully.")
model ScheduledActionExtensionListResponse
  is ArmResponse<ResourceListResult<ScheduledActionResources>>;

@doc("The operation status was retrieved successfully.")
model ScheduledActionOperationStatusResponse
  is ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>;

@doc("The associated occurrences were retrieved successfully.")
model OccurrenceExtensionListResponse
  is ArmResponse<ResourceListResult<OccurrenceExtensionResource>>;

op ResourceActionNoResponseAsyncWithAcceptedDoc<
  Resource extends Azure.ResourceManager.Foundations.SimpleResource,
  Request,
  AcceptedDescription extends valueof string,
  BaseParameters extends TypeSpec.Reflection.Model =
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    void,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse,
  OptionalRequestBody extends valueof boolean = false,
  Provider extends {} = ProviderNamespace<Resource>
> is ArmResourceActionAsyncBase<
  Resource,
  Request,
  ArmAcceptedLroResponse<AcceptedDescription, LroHeaders>,
  BaseParameters,
  Parameters,
  Error,
  OptionalRequestBody,
  Provider
>;

@added(Versions.`2026-07-06-preview`)
@armResourceOperations
interface ScheduledActions {
  @doc("Gets the specified scheduled action.")
  @errorsDoc("The request failed. The response contains error details.")
  get is ArmResourceRead<ScheduledAction, Response = ScheduledActionGetResponse>;

  @doc("Creates or updates a scheduled action.")
  @errorsDoc("The request failed. The response contains error details.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ScheduledAction,
    Response = ScheduledActionUpdatedResponse | ScheduledActionCreatedResponse
  >;

  @doc("Updates the specified scheduled action.")
  @errorsDoc("The request failed. The response contains error details.")
  update is ArmCustomPatchAsync<
    ScheduledAction,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ScheduledAction,
      ScheduledActionPropertiesUpdate
    >,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader,
    Response = ScheduledActionPatchResponse |
      ArmAcceptedLroResponse<
        "The update request was accepted and is being processed.",
        ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
      >
  >;

  @doc("Deletes the specified scheduled action.")
  @errorsDoc("The request failed. The response contains error details.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ScheduledAction,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader,
    Response = ArmAcceptedLroResponse<
      "The delete request was accepted and is being processed.",
      ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
    > | ArmNoContentResponse<"The scheduled action was deleted or did not exist.">
  >;

  @doc("Lists scheduled actions in the specified resource group.")
  @errorsDoc("The request failed. The response contains error details.")
  listByResourceGroup is ArmResourceListByParent<
    ScheduledAction,
    Response = ScheduledActionListResponse
  >;

  @doc("Lists scheduled actions in the specified subscription.")
  @errorsDoc("The request failed. The response contains error details.")
  listBySubscription is ArmListBySubscription<
    ScheduledAction,
    Response = ScheduledActionListResponse
  >;

  @autoRoute
  @listsResource(ScheduledActionResource)
  @armResourceList(ScheduledActionResource)
  @list
  @get
  @doc("Lists resources associated with the specified scheduled action.")
  @errorsDoc("The request failed. The response contains error details.")
  listResources(
    ...ResourceInstanceParameters<ScheduledActionResource>,
  ): ScheduledActionResourcesListResponse | ErrorResponse;

  @doc("Adds resources to the specified scheduled action.")
  @returnsDoc("The resources were added successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  attachResources is OccurrenceActionAsyncWithAcceptedDoc<
    ScheduledAction,
    ResourceAttachRequest,
    ResourceOperationResponse,
    "The request to add resources was accepted and is being processed.",
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Removes resources from the specified scheduled action.")
  @returnsDoc("The resources were removed successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  detachResources is OccurrenceActionAsyncWithAcceptedDoc<
    ScheduledAction,
    ResourceDetachRequest,
    ResourceOperationResponse,
    "The request to remove resources was accepted and is being processed.",
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Updates resource-specific settings for the specified scheduled action.")
  @returnsDoc("The resource settings were updated successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  patchResources is ArmResourceActionSync<
    ScheduledAction,
    ResourcePatchRequest,
    ResourceOperationResponse
  >;

  @doc("Disables the specified scheduled action so future occurrences do not run.")
  @errorsDoc("The request failed. The response contains error details.")
  disable is ResourceActionNoResponseAsyncWithAcceptedDoc<
    ScheduledAction,
    void,
    "The disable request was accepted and is being processed.",
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Enables the specified scheduled action so new occurrences run.")
  @errorsDoc("The request failed. The response contains error details.")
  enable is ResourceActionNoResponseAsyncWithAcceptedDoc<
    ScheduledAction,
    void,
    "The enable request was accepted and is being processed.",
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Cancels the next occurrence of the specified scheduled action.")
  @returnsDoc("The next occurrence was canceled successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  cancelNextOccurrence is OccurrenceActionAsyncWithAcceptedDoc<
    ScheduledAction,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    "The cancellation request was accepted and is being processed.",
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Runs the specified scheduled action immediately.")
  @returnsDoc("The manual occurrence was started successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  triggerManualOccurrence is OccurrenceActionAsyncWithAcceptedDoc<
    ScheduledAction,
    void,
    Occurrence,
    "The request to run the scheduled action was accepted and is being processed.",
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Occurrence> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(
  ScheduledActions.createOrUpdate::parameters.resource,
  "The scheduled action to create or update."
);

@@doc(
  ScheduledActions.update::parameters.properties,
  "The scheduled action properties to update. Omitted properties keep their current values."
);

@@doc(
  ScheduledActions.attachResources::parameters.body,
  "The resources to add to the scheduled action."
);

@@doc(
  ScheduledActions.detachResources::parameters.body,
  "The resources to remove from the scheduled action."
);

@@doc(
  ScheduledActions.patchResources::parameters.body,
  "The resource-specific settings to update."
);

@@doc(
  ScheduledActions.cancelNextOccurrence::parameters.body,
  "The resources to cancel in the next occurrence. If no resource IDs are provided, the occurrence is canceled for all resources."
);

@added(Versions.`2026-07-06-preview`)
@armResourceOperations(#{ omitTags: true })
@tag("ScheduledActions")
interface ScheduledActionExtension {
  @doc("Lists scheduled actions associated with the specified VM.")
  @errorsDoc("The request failed. The response contains error details.")
  listByVms is ArmResourceListByParent<
    ScheduledActionResources,
    Response = ScheduledActionExtensionListResponse
  >;
}

@@doc(
  Azure.ResourceManager.ResourceUriParameter.resourceUri,
  "The fully qualified Azure resource ID of the compute resource."
);

@added(Versions.`2026-07-06-preview`)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
@tag("ScheduledActions")
interface ScheduledActionOperationStatus {
  @doc("Gets the status of the specified scheduled action operation.")
  @errorsDoc("The request failed. The response contains error details.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/scheduledActionsOperationStatuses/{operationId}")
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
  ): ScheduledActionOperationStatusResponse | ErrorResponse;
}

// ------------------ Occurrence operations ------------------

op OccurrenceActionAsyncWithAcceptedDoc<
  Resource extends Azure.ResourceManager.Foundations.SimpleResource,
  Request,
  Response extends TypeSpec.Reflection.Model | unknown | void,
  AcceptedDescription extends valueof string,
  BaseParameters extends TypeSpec.Reflection.Model =
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    Response,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse,
  OptionalRequestBody extends valueof boolean = false,
  Provider extends {} = ProviderNamespace<Resource>
> is ArmResourceActionAsyncBase<
  Resource,
  Request,
  ArmAcceptedLroResponse<AcceptedDescription, LroHeaders> | Response,
  BaseParameters,
  Parameters,
  Error,
  OptionalRequestBody,
  Provider
>;

@added(Versions.`2026-07-06-preview`)
@armResourceOperations(#{ omitTags: true })
@tag("Scheduled Actions - Occurrence")
interface Occurrences {
  @doc("Gets the specified occurrence.")
  @errorsDoc("The request failed. The response contains error details.")
  get is ArmResourceRead<Occurrence, Response = OccurrenceGetResponse>;

  @doc("Lists occurrences for the specified scheduled action.")
  @errorsDoc("The request failed. The response contains error details.")
  listByScheduledAction is ArmResourceListByParent<
    Occurrence,
    Response = OccurrenceListByScheduledActionResponse
  >;

  @autoRoute
  @listsResource(OccurrenceResource)
  @armResourceList(OccurrenceResource)
  @list
  @get
  @doc("Lists resources for the specified occurrence.")
  @errorsDoc("The request failed. The response contains error details.")
  listResources(
    ...ResourceInstanceParameters<OccurrenceResource>,
  ): OccurrenceResourcesListResponse | ErrorResponse;

  @doc("Cancels the specified occurrence for the specified resource IDs.")
  @returnsDoc("The occurrence cancellation completed successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  cancel is OccurrenceActionAsyncWithAcceptedDoc<
    Occurrence,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    "The cancellation request was accepted and is being processed.",
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Delays the specified occurrence for the specified resource IDs.")
  @returnsDoc("The occurrence delay completed successfully.")
  @errorsDoc("The request failed. The response contains error details.")
  delay is OccurrenceActionAsyncWithAcceptedDoc<
    Occurrence,
    DelayRequest,
    ResourceOperationResponse,
    "The delay request was accepted and is being processed.",
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(
  Occurrences.cancel::parameters.body,
  "The resources to cancel in the occurrence. If no resource IDs are provided, the occurrence is canceled for all resources."
);

@@doc(
  Occurrences.delay::parameters.body,
  "The new scheduled time and resources to delay in the occurrence. If no resource IDs are provided, all resources are delayed."
);

@added(Versions.`2026-07-06-preview`)
@armResourceOperations
@tag("ScheduledActions")
interface OccurrenceExtension {
  @doc("Lists scheduled action occurrences associated with the specified VM.")
  @errorsDoc("The request failed. The response contains error details.")
  listOccurrenceByVms is ArmResourceListByParent<
    OccurrenceExtensionResource,
    Response = OccurrenceExtensionListResponse
  >;
}
