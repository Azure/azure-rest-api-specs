import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.LoadTestService;

@added(APIVersions.v2024_07_01_preview)
@doc("Frequency of recurrence for a trigger.")
union Frequency {
  string,

  @doc("Recurrence defined by a cron expression.")
  Cron: "Cron",

  @doc("Recurrence defined on an hourly basis, as specified by HourlyRecurrence.")
  Hourly: "Hourly",

  @doc("Recurrence defined on a daily basis, as specified by DailyRecurrence.")
  Daily: "Daily",

  @doc("Recurrence defined on a weekly basis, as specified by WeeklyRecurrence.")
  Weekly: "Weekly",

  @doc("Recurrence defined monthly on specific days, as specified by MonthlyRecurrenceByWeekDays.")
  MonthlyByDays: "MonthlyByDays",

  @doc("Recurrence defined monthly on specific dates, as specified by MonthlyRecurrenceByDates.")
  MonthlyByDates: "MonthlyByDates",
}

@added(APIVersions.v2024_07_01_preview)
@doc("Current state of a trigger.")
union TriggerState {
  string,

  @doc("The trigger is active.")
  Active: "Active",

  @doc("The trigger is paused manually.")
  Paused: "Paused",

  @doc("The trigger is completed.")
  Completed: "Completed",

  @doc("The trigger is disabled due to error.")
  Disabled: "Disabled",
}

@added(APIVersions.v2024_07_01_preview)
@doc("Defines the days of the week.")
union WeekDays {
  string,

  @doc("Refers to Sunday.")
  Sunday: "Sunday",

  @doc("Refers to Monday.")
  Monday: "Monday",

  @doc("Refers to Tuesday.")
  Tuesday: "Tuesday",

  @doc("Refers to Wednesday.")
  Wednesday: "Wednesday",

  @doc("Refers to Thursday.")
  Thursday: "Thursday",

  @doc("Refers to Friday.")
  Friday: "Friday",

  @doc("Refers to Saturday.")
  Saturday: "Saturday",
}

@added(APIVersions.v2024_07_01_preview)
@doc("Type of a trigger.")
union TriggerType {
  string,

  @doc("Trigger is a Scheduled Trigger on a Test.")
  ScheduleTestsTrigger: "ScheduleTestsTrigger",
}

@added(APIVersions.v2024_07_01_preview)
@doc("ScheduleTestsTrigger model.")
model ScheduleTestsTrigger extends Trigger {
  @doc("The type of the trigger is ScheduleTestsTrigger.")
  kind: TriggerType.ScheduleTestsTrigger;

  @doc("The test id of test to be triggered by this schedule trigger. Currently only one test is supported for a trigger.")
  testIds: string[];

  @doc("Start date time of the trigger in UTC timezone. (RFC 3339 literal format)")
  startDateTime?: utcDateTime;

  @visibility("read")
  recurrenceStatus?: RecurrenceStatus;

  @doc("Recurrence details of the trigger. Null if schedule is not recurring.")
  recurrence?: Recurrence;
}

@added(APIVersions.v2024_07_01_preview)
@doc("Actual state of the recurrence for the trigger.")
model RecurrenceStatus {
  @doc("The number of occurrences remaining for the trigger. Null if recurrence end has end date instead of number of occurrences.")
  remainingOccurrences?: int32;

  @doc("The next three execution times of the trigger. (RFC 3339 literal format)")
  nextScheduledDateTimes?: utcDateTime[];
}

@added(APIVersions.v2024_07_01_preview)
@resource("triggers")
@discriminator("kind")
@doc("Trigger model.")
model Trigger {
  @key
  @maxLength(50)
  @minLength(2)
  @pattern("^[a-z0-9_-]*$")
  @doc("The unique identifier of the trigger.")
  @visibility("read")
  triggerId: string;

  @maxLength(50)
  @minLength(2)
  @doc("The name of the trigger.")
  displayName: string;

  @maxLength(100)
  @doc("The description of the trigger.")
  description?: string;

  @doc("The type of the trigger.")
  kind: TriggerType;

  @doc("The current state of the trigger.")
  state?: TriggerState;

  @doc("Details of current state of the trigger.")
  @visibility("read")
  stateDetails?: StateDetails;

  ...SystemMetaData;
}

@added(APIVersions.v2024_07_01_preview)
@doc("State details of the trigger.")
model StateDetails {
  @doc("The error message if the trigger is in disabled state.")
  message?: string;
}

@added(APIVersions.v2024_07_01_preview)
@doc("Recurrence model when frequency is set as Daily.")
model DailyRecurrence extends Recurrence {
  @doc("Frequency of the day recurrence.")
  frequency: Frequency.Daily;

  @doc("The interval at which the recurrence should repeat. It signifies the number of days between each recurrence.")
  interval: int32;
}

@added(APIVersions.v2024_07_01_preview)
@doc("Recurrence model when frequency is set as Hourly.")
model HourlyRecurrence extends Recurrence {
  @doc("Frequency of the hour recurrence.")
  frequency: Frequency.Hourly;

  @doc("The interval at which the recurrence should repeat. It signifies the number of hours between each recurrence.")
  interval: int32;
}

@added(APIVersions.v2024_07_01_preview)
@doc("Recurrence model when frequency is set as MonthlyByDays .")
model MonthlyRecurrenceByWeekDays extends Recurrence {
  @doc("Frequency of the month recurrence.")
  frequency: Frequency.MonthlyByDays;

  @doc("Specific days of the week when the recurrence should repeat.")
  weekDaysInMonth?: WeekDays[];

  @doc("Index of the week in a month at which the recurrence should repeat. For example, if the index is '2', weekDay is 'Monday', interval is 3 and frequency is 'Month', the recurrence will run every second Monday of the month and repeat every 3 months. Value of index can be 1 to 5.")
  @minValue(1)
  @maxValue(5)
  index: int32;

  @doc("The interval at which the recurrence should repeat. It signifies the number of months between each recurrence.")
  interval: int32;
}

@added(APIVersions.v2024_07_01_preview)
@doc("Recurrence model when frequency is set as MonthlyByDates.")
model MonthlyRecurrenceByDates extends Recurrence {
  @doc("Frequency of the month recurrence.")
  frequency: Frequency.MonthlyByDates;

  @doc("Recurrence set to repeat on the specified dates of the month. Value of dates can be 1 to 31 and -1. -1 represents the last day of the month.")
  datesInMonth?: int32[];

  @doc("The interval at which the recurrence should repeat. It signifies the number of months between each recurrence.")
  interval?: int32;
}

@added(APIVersions.v2024_07_01_preview)
@doc("Recurrence is set based on cron expression.")
model RecurrenceWithCron extends Recurrence {
  @doc("Specify frequency using a cron expression.")
  frequency: Frequency.Cron;

  @doc("Cron expression for the recurrence.")
  cronExpression: string;
}

@added(APIVersions.v2024_07_01_preview)
@doc("Recurrence model when frequency is set as weekly.")
model WeeklyRecurrence extends Recurrence {
  @doc("Frequency of the week recurrence.")
  frequency: Frequency.Weekly;

  @doc("Recurrence set to repeat on the specified days of the week.")
  daysOfWeek?: WeekDays[];

  @doc("The interval at which the recurrence should repeat. It signifies the number of weeks between each recurrence.")
  interval?: int32;
}

@doc("Recurrence end model. Either provide numberOfOccurrences if you want recurrence to end after a specified number of occurrences or provide endDate if you want recurrence to end after a specified end date. If both values are provided, a validation error will be thrown indicating that only one field should be provided. If neither value is provided, the recurrence will end when manually ended.")
@added(APIVersions.v2024_07_01_preview)
model RecurrenceEnd {
  @doc("Number of occurrences after which the recurrence will end.")
  numberOfOccurrences?: int32;

  @doc("The date after which the recurrence will end. (RFC 3339 literal format)")
  endDateTime?: utcDateTime;
}

@added(APIVersions.v2024_07_01_preview)
@discriminator("frequency")
@doc("Recurrence model.")
model Recurrence {
  @doc("Frequency of the recurrence.")
  frequency: Frequency;

  @doc("Recurrence end model. You can specify the end either by providing a numberOfOccurrences (which will end the recurrence after the specified number of occurrences) or by providing an endDateTime (which will end the recurrence after the specified date). If neither value is provided, the recurrence will continue until it is manually ended. However, if both values are provided, an error will be thrown.")
  recurrenceEnd?: RecurrenceEnd;
}

@added(APIVersions.v2024_07_01_preview)
@doc("Parameters for list trigger operation")
model ListTriggerQueryParams {
  @doc("Search based on triggers associated with the provided test ids.")
  @query
  testIds?: string;

  @doc("Filter triggers based on a comma separated list of states.")
  @query
  states?: TriggerState;

  @doc("""
    Start DateTime(RFC 3339 literal format) of the last updated time range to filter triggers.
    """)
  @query
  lastModifiedStartTime?: utcDateTime;

  @doc("""
    End DateTime(RFC 3339 literal format) of the last updated time range to filter triggers.
    """)
  @query
  lastModifiedEndTime?: utcDateTime;

  @doc("Number of results in response. Default page size is 50.")
  @query
  maxpagesize?: int32 = 50;
}
