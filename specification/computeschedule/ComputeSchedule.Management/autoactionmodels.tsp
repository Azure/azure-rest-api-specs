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

@doc("The type of resource the auto action is targeting.")
union ResourceType {
  @doc("Resources defined in the auto action are Virtual Machines")
  VirtualMachine: "VirtualMachine",

  @doc("Resources defined in the auto action are Virtual Machines Scale Sets")
  VirtualMachineScaleSet: "VirtualMachineScaleSet",

  string,
}

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

@doc("Representation of the days in a week in a gregorian calendar")
union WeekDay {
  @doc("Monday weekday.")
  Monday: "Monday",

  @doc("Tuesda weekday.")
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

  string,
}

@doc("Representation of the months in a gregorian calendar")
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

  string,
}

@minValue(1)
@maxValue(31)
@doc("Represents the possible days in a month")
scalar DayOfTheMonth extends int32;

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

  @doc("The days of the month the auto action is supposed to run on")
  requestedDaysOfTheMonth: DayOfTheMonth[];

  @doc("The execution parameters the auto action is supposed to follow")
  executionParameters: ExecutionParameters;

  @doc("The type of deadline the auto action is supposed to follow for the schedule")
  deadlineType: DeadlineType;
}

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

@doc("The state of a occurrence")
model OccurrenceView {
  @doc("The identifier of the occurrence")
  occurrenceId: string;

  @doc("The time the occurrence was scheduled for")
  scheduledTime: utcDateTime;

  @doc("The list of resources the occurrence is targeting")
  resources: armResourceIdentifier[];

  @doc("The current state of the occurrence")
  state: OccurrenceState;

  @doc("Error details for the occurrence")
  @OpenAPI.extension("x-ms-identifiers", ["code"])
  errorDetails?: Azure.Core.Foundations.Error[];
}

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
  resources: armResourceIdentifier[];

  @doc("The schedule the auto action is supposed to follow")
  schedule: AutoActionSchedule;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("The list of upcoming occurrences for the auto action")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["occurrenceId"])
  upcomingOccurrences: OccurrenceView[];

  @doc("The list of upcoming occurrnces for the auto action")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["occurrenceId"])
  lastOccurrences: OccurrenceView[];

  @doc("Tell if the auto action is disabled or not")
  @visibility("read")
  isDisabled: boolean;
}

alias AutoActionParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...ProviderNamespace<AutoAction>;

  @path
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("virtualMachines")
  @doc("The virtualMachine name.")
  vmName: string;
};

@doc("The auto action resource")
model AutoAction is TrackedResource<AutoActionProperties> {
  ...ResourceNameParameter<AutoAction>;
}