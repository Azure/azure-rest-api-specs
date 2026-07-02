import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

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
// NAMING NOTE: SA collision-renames take the `AutoActions*`
// prefix because BulkActions already claimed
// `ScheduledAction*` for its own shared Kronox types.
// =====================================================================

// ------------------ Shared enums ------------------

@added(Versions.`2026-07-06-preview`)
@doc("The type of resource being targeted")
union ResourceType {
  @doc("Resources defined are Virtual Machines")
  VirtualMachine: "VirtualMachine",

  @doc("Resources defined are Virtual Machines Scale Sets")
  VirtualMachineScaleSet: "VirtualMachineScaleSet",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("Specify which action user wants to be performed on the resources")
union ScheduledActionType {
  @doc("Perform a start action on the specified resources")
  Start: "Start",

  @doc("Perform a deallocate action on the specified resources")
  Deallocate: "Deallocate",

  @doc("Perform hibernate and deallocate on the specified resources")
  Hibernate: "Hibernate",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("Representation of the possible selection of days in a week in a gregorian calendar")
union WeekDay {
  @doc("Monday weekday.")
  Monday: "Monday",

  @doc("Tuesday weekday.")
  Tuesday: "Tuesday",

  @doc("Wednesday weekday.")
  Wednesday: "Wednesday",

  @doc("Thursday weekday.")
  Thursday: "Thursday",

  @doc("Friday weekday.")
  Friday: "Friday",

  @doc("Saturday weekday.")
  Saturday: "Saturday",

  @doc("Sunday weekday.")
  Sunday: "Sunday",

  @doc("All week days")
  All: "All",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("Representation of the months available selection in a gregorian calendar")
union Month {
  @doc("The January month.")
  January: "January",

  @doc("The February month.")
  February: "February",

  @doc("The March month.")
  March: "March",

  @doc("The April month.")
  April: "April",

  @doc("The May month.")
  May: "May",

  @doc("The June month.")
  June: "June",

  @doc("The July month.")
  July: "July",

  @doc("The August month.")
  August: "August",

  @doc("The September month.")
  September: "September",

  @doc("The October month.")
  October: "October",

  @doc("The November month.")
  November: "November",

  @doc("The December month.")
  December: "December",

  @doc("All months")
  All: "All",

  string,
}

@added(Versions.`2026-07-06-preview`)
@minValue(1)
@maxValue(31)
@doc("Represents the possible days in a month")
scalar DayOfTheMonth extends int32;

@added(Versions.`2026-07-06-preview`)
@doc("The state the occurrence is at a given time")
union OccurrenceState {
  @doc("The occurrence was created")
  Created: "Created",

  @doc("The occurrence is being rescheduled")
  Rescheduling: "Rescheduling",

  @doc("The occurrence has been scheduled")
  Scheduled: "Scheduled",

  @doc("The occurrence has successfully ran")
  Succeeded: "Succeeded",

  @doc("The occurrence has failed during its scheduling")
  Failed: "Failed",

  @doc("The occurrence is going through cancellation")
  Cancelling: "Cancelling",

  @doc("The occurrence has been canceled")
  Canceled: "Canceled",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The type of notification supported")
union NotificationType {
  @doc("Notify through e-mail")
  Email: "Email",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The notification languages currently supported")
union Language {
  @doc("American english language")
  EnUs: "en-us",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The state the resource is on after the resource operation is applied")
union ResourceOperationStatus {
  @doc("The resource operation was successful")
  Succeeded: "Succeeded",

  @doc("The resource operation has failed.")
  Failed: "Failed",

  string,
}

// NAMING NOTE: renamed from `ProvisioningState` to avoid colliding with the
// BulkActions LaunchBulkInstancesOperation `ProvisioningState`; takes the
// `AutoActions*` identity (see file header).
@added(Versions.`2026-07-06-preview`)
@doc("Provisioning state of the scheduled action resource.")
@lroStatus
union AutoActionsProvisioningState {
  ResourceProvisioningState,

  @doc("Resource is being deleted.")
  Deleting: "Deleting",

  string,
}

@added(Versions.`2026-07-06-preview`)
@doc("The preferences customers can select to optimize their requests to ScheduledActions")
union OptimizationPreference {
  @doc("Optimize while considering cost savings")
  Cost: "Cost",

  @doc("Optimize while considering availability of resources")
  Availability: "Availability",

  @doc("Optimize while considering a balance of cost and availability")
  CostAvailabilityBalanced: "CostAvailabilityBalanced",

  string,
}

// ------------------ Shared models ------------------

@added(Versions.`2026-07-06-preview`)
@doc("The information about notifications to be send to about upcoming operations.")
model NotificationProperties {
  @doc("Where the notification should be sent. For email, it should follow email format.")
  destination: string;

  @doc("Type of notification to be sent.")
  type: NotificationType;

  @doc("The language the notification should be sent on.")
  language: Language;

  @doc("Tells if the notification is enabled or not.")
  disabled?: boolean = false;
}

@@identifiers(Azure.Core.Foundations.Error.details, #[]);

// ------------------ ScheduledAction resource + models ------------------

@added(Versions.`2026-07-06-preview`)
@doc("Specify the schedule in which the scheduled action is supposed to follow")
model ScheduledActionsSchedule {
  @doc("The time the scheduled action is supposed to run on")
  scheduledTime: plainTime;

  @doc("The timezone the scheduled time is specified on")
  timeZone: string;

  @doc("The week days the scheduled action is supposed to run on. If empty, it means it will run on every week day.")
  requestedWeekDays?: WeekDay[];

  @doc("The months the scheduled action is supposed to run on. If empty, it means it will run on every month.")
  requestedMonths?: Month[];

  @doc("The days of the month the scheduled action is supposed to run on. If empty, it means it will run on every day of the month.")
  requestedDaysOfTheMonth?: DayOfTheMonth[];

  @doc("The execution parameters the scheduled action is supposed to follow")
  executionParameters?: ExecutionParameters;

  @doc("The type of deadline the scheduled action is supposed to follow for the schedule. If no value is passed, it will default to InitiateAt.")
  deadlineType?: DeadlineType;
}

@added(Versions.`2026-07-06-preview`)
@doc("Schedule properties for update (PATCH). All properties are optional so individual fields can be patched (merge semantics); omitting a property preserves the current value.")
model ScheduledActionsScheduleUpdate
  is OptionalProperties<ScheduledActionsSchedule>;

@added(Versions.`2026-07-06-preview`)
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
@doc("Represents an scheduled action resource metadata.")
model ScheduledActionResource {
  @doc("The name of the resource")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("""
    The compute RP resource id of the resource in the scheduled actions scope. 
    """)
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("The type of resource")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("""
    The ARM Id of the resource.
    "subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}"
    """)
  resourceId: ValidScheduledActionResourceId;

  @doc("The desired notification settings for the specified resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;
}

@@identifiers(ResourceListResponse.value, #[]);

@added(Versions.`2026-07-06-preview`)
model ResourceListResponse is Azure.Core.Page<ScheduledActionResource>;

@added(Versions.`2026-07-06-preview`)
@doc("Represents the writable fields of a scheduled action resource used in attach and patch requests.")
model ScheduledActionResourceInput {
  @doc("""
    The ARM Id of the resource.
    "subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}"
    """)
  resourceId: ValidScheduledActionResourceId;

  @doc("The desired notification settings for the specified resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Request model to attach a list of scheduled action resources.")
model ResourceAttachRequest {
  @doc("List of resources to be attached/patched")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Request model to detach a list of scheduled action resources.")
model ResourceDetachRequest {
  @doc("List of resources to be detached")
  resources: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Request model perform a resource operation in a list of resources")
model ResourcePatchRequest {
  @doc("The list of resources we watch to patch")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@added(Versions.`2026-07-06-preview`)
@doc("The request to cancel an occurrence.")
model CancelOccurrenceRequest {
  @doc("The resources the cancellation should act on. If no resource is passed in the list, Scheduled Action will cancel the occurrence for all resources.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
@doc("The status of a resource after a resource level operation was performed")
model ResourceStatus {
  @doc("The arm identifier of the resource")
  resourceId: ValidScheduledActionResourceId;

  @doc("The state the resource is currently on")
  status: ResourceOperationStatus;

  @doc("Errors encountered while trying to perform")
  error?: Azure.Core.Foundations.Error;
}

@added(Versions.`2026-07-06-preview`)
@doc("The response from scheduled action resource requests, which contains the status of each resource")
model ResourceOperationResponse {
  @doc("The total number of resources operated on")
  totalResources: int32;

  @doc("The resource status of for each resource")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Versions.`2026-07-06-preview`)
@doc("Scheduled action properties")
model ScheduledActionProperties {
  @doc("The type of resource the scheduled action is targeting")
  resourceType: ResourceType;

  @doc("The action the scheduled action should perform in the resources")
  actionType: ScheduledActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The time which the scheduled action is supposed to start running")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The time when the scheduled action is supposed to stop scheduling")
  endTime?: offsetDateTime;

  @doc("The schedule the scheduled action is supposed to follow")
  schedule: ScheduledActionsSchedule;

  @doc("The notification settings for the scheduled action")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Tell if the scheduled action is disabled or not")
  disabled?: boolean = false;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: AutoActionsProvisioningState;
}

@added(Versions.`2026-07-06-preview`)
@doc("Scheduled action properties for update (PATCH). Mirrors ScheduledActionProperties but the schedule uses an all-optional model so individual schedule fields can be patched (merge semantics); omitting a field preserves the current value.")
model ScheduledActionPropertiesUpdate {
  @doc("The type of resource the scheduled action is targeting")
  resourceType: ResourceType;

  @doc("The action the scheduled action should perform in the resources")
  actionType: ScheduledActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The time which the scheduled action is supposed to start running")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The time when the scheduled action is supposed to stop scheduling")
  endTime?: offsetDateTime;

  @doc("The schedule the scheduled action is supposed to follow")
  schedule?: ScheduledActionsScheduleUpdate;

  @doc("The notification settings for the scheduled action")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Tell if the scheduled action is disabled or not")
  disabled?: boolean = false;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: AutoActionsProvisioningState;
}

@added(Versions.`2026-07-06-preview`)
@doc("Scheduled action extension properties")
model ScheduledActionsExtensionProperties {
  ...ScheduledActionProperties;

  @doc("The notification settings for the scheduled action at a resource level. Resource level notification settings are scope to specific resources only and submitted through attach requests.")
  @Azure.ResourceManager.identifiers(#["destination"])
  @visibility(Lifecycle.Read)
  resourceNotificationSettings?: Array<NotificationProperties>;
}

@added(Versions.`2026-07-06-preview`)
@doc("The response from scheduled action resource requests, which contains the status of each resource")
model ScheduledActionResourceOperationResponse {
  @doc("The total number of resources operated on")
  totalResources: int32;

  @doc("The resource status of for each resource")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Versions.`2026-07-06-preview`)
@doc("The scheduled action resource")
model ScheduledAction is TrackedResource<ScheduledActionProperties> {
  ...ResourceNameParameter<ScheduledAction>;
}

@added(Versions.`2026-07-06-preview`)
@doc("The scheduled action extension")
model ScheduledActionResources
  is ExtensionResource<ScheduledActionsExtensionProperties> {
  ...ResourceNameParameter<
    ScheduledActionResources,
    SegmentName = "associatedScheduledActions"
  >;
}

// ------------------ Occurrence resource + models ------------------

@added(Versions.`2026-07-06-preview`)
@doc("The status of the resources")
model ResourceResultSummary {
  @doc("The error code for those resources. In case of success, code is populated with Success.")
  code: string;

  @doc("The number of resources that the code applies to.")
  count: int32;

  @doc("The error details for the resources. Not populated on success cases.")
  errorDetails?: Azure.Core.Foundations.Error;
}

@added(Versions.`2026-07-06-preview`)
@doc("The summarized provisioning result of an occurrence")
model OccurrenceResultSummary {
  @doc("The total number of resources that the occurrence was supposed to act on.")
  total: int32;

  @doc("The summarized status of the resources.")
  @Azure.ResourceManager.identifiers(#["code"])
  statuses: ResourceResultSummary[];
}

@added(Versions.`2026-07-06-preview`)
@doc("Properties for an occurrence")
model OccurrenceProperties {
  @doc("The time the occurrence is scheduled for. This value can be changed by calling the delay API")
  @visibility(Lifecycle.Read)
  scheduledTime: utcDateTime;

  @doc("The result for occurrences that achieved a terminal state")
  @visibility(Lifecycle.Read)
  resultSummary: OccurrenceResultSummary;

  @doc("The aggregated provisioning state of the occurrence")
  @visibility(Lifecycle.Read)
  provisioningState?: OccurrenceState;
}

@added(Versions.`2026-07-06-preview`)
@parentResource(ScheduledAction)
model Occurrence is ProxyResource<OccurrenceProperties> {
  ...ResourceNameParameter<
    Occurrence,
    KeyName = "occurrenceId",
    NamePattern = "[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}"
  >;
}

@added(Versions.`2026-07-06-preview`)
@parentResource(Occurrence)
model OccurrenceResource is ScheduledActionResource {
  @doc("The time the occurrence is scheduled for the resource.")
  @visibility(Lifecycle.Read)
  scheduledTime: utcDateTime;

  @doc("The current state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Error details for the resource. Only populated if resource is in failed state.")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.Core.Foundations.Error;
}

@@identifiers(OccurrenceResourceListResponse.value, #[]);

@added(Versions.`2026-07-06-preview`)
model OccurrenceResourceListResponse is Azure.Core.Page<OccurrenceResource>;

@added(Versions.`2026-07-06-preview`)
@doc("Request to ask for a delay in an occurrence, delay should be set to client local time eg (PST) 2025-05-30T06:35:00-07:00")
model DelayRequest {
  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The exact time to delay the operations to")
  delay: offsetDateTime;

  @doc("The resources that should be delayed. If empty, the delay will apply to the all resources in the occurrence.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@added(Versions.`2026-07-06-preview`)
scalar ScheduledActionsId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Compute/scheduledActions",
    }
  ]>;

@added(Versions.`2026-07-06-preview`)
@doc("The properties of the occurrence extension")
model OccurrenceExtensionProperties {
  @doc("""
    The ARM Id of the resource.
    "subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}"
    """)
  resourceId: ValidScheduledActionResourceId;

  @doc("The desired notification settings for the specified resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;

  @doc("The time the occurrence is scheduled for the resource. Specified in UTC.")
  @visibility(Lifecycle.Read)
  scheduledTime: utcDateTime;

  @doc("The current state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Error details for the resource. Only populated if resource is in failed state.")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.Core.Foundations.Error;

  @doc("The arm identifier of the scheduled action the occurrence belongs to")
  scheduledActionId: ScheduledActionsId;
}

@added(Versions.`2026-07-06-preview`)
@doc("The scheduled action extension")
model OccurrenceExtensionResource
  is ExtensionResource<OccurrenceExtensionProperties> {
  ...ResourceNameParameter<
    OccurrenceProperties,
    SegmentName = "associatedOccurrences"
  >;
}

// ------------------ ScheduledAction operations ------------------

@added(Versions.`2026-07-06-preview`)
@armResourceOperations
interface ScheduledActions {
  get is ArmResourceRead<ScheduledAction>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScheduledAction>;

  update is ArmCustomPatchAsync<
    ScheduledAction,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ScheduledAction,
      ScheduledActionPropertiesUpdate
    >,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    ScheduledAction,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  listByResourceGroup is ArmResourceListByParent<ScheduledAction>;

  listBySubscription is ArmListBySubscription<ScheduledAction>;

  @autoRoute
  @listsResource(ScheduledActionResource)
  @armResourceList(ScheduledActionResource)
  @list
  @get
  @doc("List resources attached to Scheduled Actions")
  listResources(...ResourceInstanceParameters<ScheduledActionResource>):
    | ArmResponse<ResourceListResponse>
    | ErrorResponse;

  attachResources is ArmResourceActionAsync<
    ScheduledAction,
    ResourceAttachRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  detachResources is ArmResourceActionAsync<
    ScheduledAction,
    ResourceDetachRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  patchResources is ArmResourceActionSync<
    ScheduledAction,
    ResourcePatchRequest,
    ResourceOperationResponse
  >;

  disable is ArmResourceActionNoResponseContentAsync<
    ScheduledAction,
    void,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  enable is ArmResourceActionNoResponseContentAsync<
    ScheduledAction,
    void,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  cancelNextOccurrence is ArmResourceActionAsync<
    ScheduledAction,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  triggerManualOccurrence is ArmResourceActionAsync<
    ScheduledAction,
    void,
    Occurrence,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Occurrence> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@added(Versions.`2026-07-06-preview`)
@armResourceOperations
interface ScheduledActionExtension {
  listByVms is ArmResourceListByParent<ScheduledActionResources>;
}

@added(Versions.`2026-07-06-preview`)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ScheduledActionOperationStatus {
  @doc("Get the status of a ScheduledActions asynchronous operation. Both the `Azure-AsyncOperation` and `Location` headers returned by long-running operations point at this endpoint.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/operationStatuses/{operationId}")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("The location name.")
    @path
    @minLength(1)
    location: azureLocation,

    @doc("The operation id.")
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
  get is ArmResourceRead<Occurrence>;
  listByScheduledAction is ArmResourceListByParent<Occurrence>;

  @autoRoute
  @listsResource(OccurrenceResource)
  @armResourceList(OccurrenceResource)
  @list
  @get
  @doc("List resources attached to Scheduled Actions for the given occurrence")
  listResources(...ResourceInstanceParameters<OccurrenceResource>):
    | ArmResponse<OccurrenceResourceListResponse>
    | ErrorResponse;

  cancel is ArmResourceActionAsync<
    Occurrence,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

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
  listOccurrenceByVms is ArmResourceListByParent<OccurrenceExtensionResource>;
}
