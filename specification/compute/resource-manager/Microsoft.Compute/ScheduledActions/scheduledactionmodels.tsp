import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./occurrencemodels.tsp";
import "./occurrenceroutes.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.Compute;

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

@doc("Schedule properties for update (PATCH). All properties are optional so individual fields can be patched (merge semantics); omitting a property preserves the current value.")
model ScheduledActionsScheduleUpdate is OptionalProperties<ScheduledActionsSchedule>;

scalar ValidScheduledActionResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines",
    },
    {
      type: "Microsoft.Compute/virtualMachineScaleSets",
    }
  ]>;

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
model ResourceListResponse is Azure.Core.Page<ScheduledActionResource>;

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

@doc("Request model to attach a list of scheduled action resources.")
model ResourceAttachRequest {
  @doc("List of resources to be attached/patched")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@doc("Request model to detach a list of scheduled action resources.")
model ResourceDetachRequest {
  @doc("List of resources to be detached")
  resources: Array<ValidScheduledActionResourceId>;
}

@doc("Request model perform a resource operation in a list of resources")
model ResourcePatchRequest {
  @doc("The list of resources we watch to patch")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@doc("The request to cancel an occurrence.")
model CancelOccurrenceRequest {
  @doc("The resources the cancellation should act on. If no resource is passed in the list, Scheduled Action will cancel the occurrence for all resources.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@doc("The status of a resource after a resource level operation was performed")
model ResourceStatus {
  @doc("The arm identifier of the resource")
  resourceId: ValidScheduledActionResourceId;

  @doc("The state the resource is currently on")
  status: ResourceOperationStatus;

  @doc("Errors encountered while trying to perform")
  error?: Azure.Core.Foundations.Error;
}

@doc("The response from scheduled action resource requests, which contains the status of each resource")
model ResourceOperationResponse {
  @doc("The total number of resources operated on")
  totalResources: int32;

  @doc("The resource status of for each resource")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

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
  provisioningState?: ProvisioningState;
}

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
  provisioningState?: ProvisioningState;
}

@doc("Scheduled action extension properties")
model ScheduledActionsExtensionProperties {
  ...ScheduledActionProperties;

  @doc("The notification settings for the scheduled action at a resource level. Resource level notification settings are scope to specific resources only and submitted through attach requests.")
  @Azure.ResourceManager.identifiers(#["destination"])
  @visibility(Lifecycle.Read)
  resourceNotificationSettings?: Array<NotificationProperties>;
}

@doc("The response from scheduled action resource requests, which contains the status of each resource")
model ScheduledActionResourceOperationResponse {
  @doc("The total number of resources operated on")
  totalResources: int32;

  @doc("The resource status of for each resource")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@doc("The scheduled action resource")
model ScheduledAction is TrackedResource<ScheduledActionProperties> {
  ...ResourceNameParameter<ScheduledAction>;
}

@doc("The scheduled action extension")
model ScheduledActionResources
  is ExtensionResource<ScheduledActionsExtensionProperties> {
  ...ResourceNameParameter<
    ScheduledActionResources,
    SegmentName = "associatedScheduledActions"
  >;
}
