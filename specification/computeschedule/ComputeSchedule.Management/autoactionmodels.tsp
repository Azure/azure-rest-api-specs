import "./models.tsp";

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

namespace Microsoft.ComputeSchedule;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The type of resource being targeted")
union ResourceType {
  @doc("Resources defined are Virtual Machines")
  VirtualMachine: "VirtualMachine",

  @doc("Resources defined are Virtual Machines Scale Sets")
  VirtualMachineScaleSet: "VirtualMachineScaleSet",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("Specify which action user wants to be performed on the resources")
union ActionType {
  @doc("Perform a start action on the specified resources")
  Start: "Start",

  @doc("Perform a deallocate action on the specified resources")
  Deallocate: "Deallocate",

  @doc("Perform hibernate and deallocate on the specified resources")
  Hibernate: "Hibernate",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
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

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
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

@minValue(1)
@maxValue(31)
@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Represents the possible days in a month")
scalar DayOfTheMonth extends int32;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Specify the schedule in which the auto action is supposed to follow")
model AutoActionSchedule {
  @doc("The time the auto action is supposed to run on")
  scheduledTime: plainTime;

  @doc("The timezone the scheduled time is specified on")
  timeZone: string;

  @doc("The week days the auto action is supposed to run on")
  requestedWeekDays: WeekDay[];

  @doc("The months the auto action is supposed to run on")
  requestedMonths: Month[];

  @doc("The days of the month the auto action is supposed to run on. If empty, it means it will run on every day of the month.")
  requestedDaysOfTheMonth: DayOfTheMonth[];

  @doc("The execution parameters the auto action is supposed to follow")
  executionParameters: ExecutionParameters;

  @doc("The type of deadline the auto action is supposed to follow for the schedule")
  deadlineType: DeadlineType;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
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

@doc("The type of notification supported")
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
union NotificationType {
  @doc("Notify through e-mail")
  Email: "Email",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The notification languages currently supported")
union Language {
  @doc("American english language")
  EnUs: "en-us",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
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

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
scalar ValidAutoActionResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines",
    },
    {
      type: "Microsoft.Compute/virtualMachineScaleSets",
    }
  ]>;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@parentResource(AutoAction)
@doc("Represents an auto action resource metadata.")
model AutoActionResource {
  @doc("The ARM Id of the resource.")
  resourceId: ValidAutoActionResourceId;

  @doc("The desired notification settings for the specified resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;
}

@doc("Provisioning state")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource is being deleted.")
  Deleting: "Deleting",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Auto action properties")
model AutoActionProperties {
  @doc("The type of resource the auto action is targeting")
  resourceType: ResourceType;

  @doc("The action the auto action should perform in the resources")
  actionType: ActionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The time which the auto action is supposed to start running")
  startTime: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The time when the auto action is supposed to stop scheduling")
  endTime?: offsetDateTime;

  @doc("The schedule the auto action is supposed to follow")
  schedule: AutoActionSchedule;

  @doc("The notification settings for the auto action")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings: Array<NotificationProperties>;

  @doc("Tell if the auto action is disabled or not")
  disabled?: boolean = false;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@@identifiers(AutoActionResourceListResponse.value, #[]);
@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
model AutoActionResourceListResponse is Azure.Core.Page<AutoActionResource>;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request model to attach a list of auto action resources.")
model AutoActionResourceAttachRequest {
  @doc("List of resources to be attached/patched")
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  resources: Array<AutoActionResource>;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request model to detach a list of auto action resources.")
model AutoActionResourceDetachRequest {
  @doc("List of resources to be detached")
  resources: Array<ValidAutoActionResourceId>;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request model perform a resource operation in a list of resources")
model AutoActionResourcePatchRequest {
  @doc("The list of resources we watch to patch")
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  resources: Array<AutoActionResource>;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The state the resource is on after the resource operation is applied")
union ResourceOperationStatus {
  @doc("The resource operation was successful")
  Succeeded: "Succeeded",

  @doc("The resource operation has failed.")
  Failed: "Failed",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The response from auto action resource requests, which contains the status of each resource")
model AutoActionResourceOperationResponse {
  @doc("The total number of resources operated on")
  totalResources: int32;

  @doc("The resource status of for each resource")
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  resourcesStatuses: Array<ResourceStatus>;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The auto action resource")
model AutoAction is TrackedResource<AutoActionProperties> {
  ...ResourceNameParameter<AutoAction>;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The auto action extension")
model AutoActionResources is ExtensionResource<AutoActionProperties> {
  ...ResourceNameParameter<AutoActionResources>;
}
