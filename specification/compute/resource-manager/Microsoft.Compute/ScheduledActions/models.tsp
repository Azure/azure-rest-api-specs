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

// ------------------ Shared enums ------------------

@doc("The type of resource being targeted")
union ResourceType {
  @doc("Resources defined are Virtual Machines")
  VirtualMachine: "VirtualMachine",

  @doc("Resources defined are Virtual Machines Scale Sets")
  VirtualMachineScaleSet: "VirtualMachineScaleSet",

  string,
}

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
@doc("Represents the possible days in a month")
scalar DayOfTheMonth extends int32;

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
union NotificationType {
  @doc("Notify through e-mail")
  Email: "Email",

  string,
}

@doc("The notification languages currently supported")
union Language {
  @doc("American english language")
  EnUs: "en-us",

  string,
}

@doc("The state the resource is on after the resource operation is applied")
union ResourceOperationStatus {
  @doc("The resource operation was successful")
  Succeeded: "Succeeded",

  @doc("The resource operation has failed.")
  Failed: "Failed",

  string,
}

@doc("Provisioning state of the scheduled action resource.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource is being deleted.")
  Deleting: "Deleting",

  string,
}

@doc("The types of deadlines supported by ScheduledActions")
union DeadlineType {
  @doc("Default value of Unknown.")
  Unknown: "Unknown",

  @doc("Initiate the operation at the given deadline.")
  InitiateAt: "InitiateAt",

  @doc("Complete the operation by the given deadline.")
  CompleteBy: "CompleteBy",

  string,
}

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

@doc("The retry policy for the user request")
model RetryPolicy {
  @doc("Retry count for user request")
  retryCount?: int32;

  @doc("Retry window in minutes for user request")
  retryWindowInMinutes?: int32;
}

@doc("Extra details needed to run the user's request")
model ExecutionParameters {
  @doc("Details that could optimize the user's request")
  optimizationPreference?: OptimizationPreference;

  @doc("Retry policy the user can pass")
  retryPolicy?: RetryPolicy;
}

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
