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
@doc("The type of resource the auto action is targeting.")
union ResourceType {
  @doc("Resources defined in the auto action are Virtual Machines")
  VirtualMachine: "VirtualMachine",

  @doc("Resources defined in the auto action are Virtual Machines Scale Sets")
  VirtualMachineScaleSet: "VirtualMachineScaleSet",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("Specify which action user wants to the auto action to perform on the resources")
union ActionType {
  @doc("Auto action should perform a start action on the specified resources")
  Start: "Start",

  @doc("Auto action should perform a deallocate action on the specified resources")
  Deallocate: "Deallocate",

  @doc("Auto action should perform hibernate and deallocate on the specified resources")
  Hibernate: "Hibernate",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("Representation of the possible selection of days in a week in a gregorian calendar for auto actions")
union WeekDay {

  @doc("Monday")
  Monday : "Monday",

  @doc("Tuesday")
  Tuesday : "Tuesday",

  @doc("Wednesday")
  Wednesday : "Wednesday",

  @doc("Thrusday")
  Thursday : "Thursday",

  @doc("Friday")
  Friday : "Friday",

  @doc("Saturday")
  Saturday : "Saturday",

  @doc("Sunday")
  Sunday : "Sunday",

  @doc("All week days")
  All : "All",
  
  string
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("Representation of the months available selection in a gregorian calendar for auto actions")
union Month {
  @doc("January")
  January : "January",

  @doc("February")
  February : "February",

  @doc("March")
  March : "March",

  @doc("April")
  April : "April",

  @doc("May")
  May : "May",

  @doc("June")
  June : "June",

  @doc("July")
  July : "July",

  @doc("August")
  August : "August",

  @doc("September")
  September : "September",

  @doc("October")
  October : "October",

  @doc("November")
  November : "November",

  @doc("December")
  December : "December",

  @doc("All months")
  All : "All",
  
  string
}

@minValue(1)
@maxValue(31)
@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("Represents the possible days in a month")
scalar DayOfTheMonth extends int32;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
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

@doc("The type of notification we want to send for auto actions operations.")
union NotificationType {
  @doc("Notify through e-mail")
  Email: "Email",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("The support notification languages by auto action")
union Laguage {
  @doc("American english language")
  EnUs : "en-us",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("The information about where notifications should be sent to about auto actions upcoming operations.")
model NotificationProperties {

  @doc("Where the notification should be sent. For email, it should follow email format.")
  destination : string;

  @doc("Type of notification to be sent.")
  type : NotificationType;

  @doc("The language the notification should be sent on.")
  language : Laguage;

  @doc("Additional optitional metadata regarding notification.")
  additionalMetadata? : Record<string>;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
scalar validAutoActionResourceId extends armResourceIdentifier<[
      {
        type: "Microsoft.Compute/virtualMachines"
      },
      {
        type: "Microsoft.Compute/virtualMachineScaleSets"
      }
    ]>;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@parentResource(AutoAction)
@doc("Represents an auto action resource metadata.")
model AutoActionResource
{
    @doc("The ARM Id of the resource.")
    resourceId : validAutoActionResourceId;

    @doc("The desired notification settings for the specified resource.")
    @OpenAPI.extension("x-ms-identifiers", ["destination"])
    @visibility("read")
    notificationSettings? : NotificationProperties[]
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
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

  @doc("The list of the resources the auto action is supposed to perform the actions on")
  @visibility("create", "update")
  @OpenAPI.extension("x-ms-identifiers", ["resourceId"])
  resources: AutoActionResource[];

  @doc("The schedule the auto action is supposed to follow")
  schedule: AutoActionSchedule;

  @doc("The notification settings for the auto action")
  @OpenAPI.extension("x-ms-identifiers", ["destination"])
  notificationSettings: NotificationProperties[];

  @doc("Tell if the auto action is disabled or not")
  @visibility("read")
  isDisabled: boolean;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("The auto action resource")
model AutoAction is TrackedResource<AutoActionProperties> {
  ...ResourceNameParameter<AutoAction>;
}

model AutoActionVmProperties is AutoActionProperties{};

model AutoActionVm is ExtensionResource<AutoActionVmProperties>{
  ...ResourceNameParameter<AutoActionVm, KeyName="autoActionName", SegmentName="autoActions">;
}