import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./scheduledactionmodels.tsp";
import "./occurrencemodels.tsp";
import "./occurrenceroutes.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ComputeSchedule;

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Specify the schedule in which the scheduled action is supposed to follow")
model ScheduledActionsSchedule {
  @doc("The time the scheduled action is supposed to run on")
  scheduledTime: plainTime;

  @doc("The timezone the scheduled time is specified on")
  timeZone: string;

  @doc("The week days the scheduled action is supposed to run on")
  requestedWeekDays: WeekDay[];

  @doc("The months the scheduled action is supposed to run on")
  requestedMonths: Month[];

  @doc("The days of the month the scheduled action is supposed to run on. If empty, it means it will run on every day of the month.")
  requestedDaysOfTheMonth: DayOfTheMonth[];

  @doc("The execution parameters the scheduled action is supposed to follow")
  executionParameters?: ExecutionParameters;

  @doc("The type of deadline the scheduled action is supposed to follow for the schedule. If no value is passed, it will default to InitiateAt.")
  deadlineType?: DeadlineType;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
scalar ValidScheduledActionResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines",
    },
    {
      type: "Microsoft.Compute/virtualMachineScaleSets",
    }
  ]>;

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@parentResource(ScheduledAction)
@segment("resources")
@doc("Represents an scheduled action resource metadata.")
model ScheduledActionResource {
  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  @doc("The name of the resource")
  @visibility(Lifecycle.Read)
  name: string;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  @doc("""
    The compute RP resource id of the resource in the scheduled actions scope. 
    """)
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
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
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
model ResourceListResponse is Azure.Core.Page<ScheduledActionResource>;

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request model to attach a list of scheduled action resources.")
model ResourceAttachRequest {
  @doc("List of resources to be attached/patched")
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  resources: Array<ScheduledActionResource>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request model to detach a list of scheduled action resources.")
model ResourceDetachRequest {
  @doc("List of resources to be detached")
  resources: Array<ValidScheduledActionResourceId>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request model perform a resource operation in a list of resources")
model ResourcePatchRequest {
  @doc("The list of resources we watch to patch")
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  resources: Array<ScheduledActionResource>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The request to cancel an occurrence.")
model CancelOccurrenceRequest {
  @doc("The resources the cancellation should act on. If no resource is passed in the list, Scheduled Action will cancel the occurrence for all resources.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The status of a resource after a resource level operation was performed")
model ResourceStatus {
  @doc("The arm identifier of the resource")
  resourceId: ValidScheduledActionResourceId;

  @doc("The state the resource is currently on")
  status: ResourceOperationStatus;

  @doc("Errors encountered while trying to perform")
  error?: Azure.Core.Foundations.Error;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The response from scheduled action resource requests, which contains the status of each resource")
model ResourceOperationResponse {
  @doc("The total number of resources operated on")
  totalResources: int32;

  @doc("The resource status of for each resource")
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Scheduled action properties")
model ScheduledActionProperties {
  @doc("The type of resource the scheduled action is targeting")
  resourceType: ResourceType;

  @doc("The action the scheduled action should perform in the resources")
  actionType: ActionType;

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

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The response from scheduled action resource requests, which contains the status of each resource")
model ScheduledActionResourceOperationResponse {
  @doc("The total number of resources operated on")
  totalResources: int32;

  @doc("The resource status of for each resource")
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The scheduled action resource")
model ScheduledAction is TrackedResource<ScheduledActionProperties> {
  ...ResourceNameParameter<ScheduledAction>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The scheduled action extension")
model ScheduledActionResources is ExtensionResource<ScheduledActionProperties> {
  ...ResourceNameParameter<
    ScheduledActionResources,
    SegmentName = "associatedScheduledActions"
  >;
}
