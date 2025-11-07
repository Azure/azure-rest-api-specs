import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "../common/models.tsp";
import "../insights/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Schedule provisioning status.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union ScheduleProvisioningStatus {
  string,

  @doc("Represents the creation status of the schedule.")
  Creating: "Creating",

  @doc("Represents the updating status of the schedule.")
  Updating: "Updating",

  @doc("Represents the deleting status of the schedule.")
  Deleting: "Deleting",

  @doc("Represents the succeeded status of the schedule.")
  Succeeded: "Succeeded",

  @doc("Represents the failed status of the schedule.")
  Failed: "Failed",
}

@doc("Type of the trigger.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union TriggerType {
  string,

  @doc("Cron based trigger.")
  Cron: "Cron",

  @doc("Recurrence based trigger.")
  Recurrence: "Recurrence",

  @doc("One-time trigger.")
  OneTime: "OneTime",
}

@doc("Base model for Trigger of the schedule.")
@discriminator("type")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model Trigger {
  @doc("Type of the trigger.")
  type: TriggerType;
}

@doc("Cron based trigger.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model CronTrigger extends Trigger {
  type: TriggerType.Cron;

  @doc("Cron expression that defines the schedule frequency.")
  expression: string;

  @doc("Time zone for the cron schedule.")
  timeZone?: string = "UTC";

  @doc("Start time for the cron schedule in ISO 8601 format.")
  startTime?: string;

  @doc("End time for the cron schedule in ISO 8601 format.")
  endTime?: string;
}

@doc("Recurrence type.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union RecurrenceType {
  string,

  @doc("Hourly recurrence pattern.")
  Hourly: "Hourly",

  @doc("Daily recurrence pattern.")
  Daily: "Daily",

  @doc("Weekly recurrence pattern.")
  Weekly: "Weekly",

  @doc("Monthly recurrence pattern.")
  Monthly: "Monthly",
}

@doc("Days of the week for recurrence schedule.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union DayOfWeek {
  string,

  @doc("Sunday.")
  Sunday: "Sunday",

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
}

@doc("Recurrence schedule model.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@discriminator("type")
model RecurrenceSchedule {
  @doc("Recurrence type for the recurrence schedule.")
  type: RecurrenceType;
}

@doc("Hourly recurrence schedule.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model HourlyRecurrenceSchedule extends RecurrenceSchedule {
  type: RecurrenceType.Hourly;
}

@doc("Daily recurrence schedule.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model DailyRecurrenceSchedule extends RecurrenceSchedule {
  @doc("Daily recurrence type.")
  type: RecurrenceType.Daily;

  @doc("Hours for the recurrence schedule.")
  hours: int32[];
}

@doc("Weekly recurrence schedule.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model WeeklyRecurrenceSchedule extends RecurrenceSchedule {
  @doc("Weekly recurrence type.")
  type: RecurrenceType.Weekly;

  @doc("Days of the week for the recurrence schedule.")
  daysOfWeek: DayOfWeek[];
}

@doc("Monthly recurrence schedule.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model MonthlyRecurrenceSchedule extends RecurrenceSchedule {
  @doc("Monthly recurrence type.")
  type: RecurrenceType.Monthly;

  @doc("Days of the month for the recurrence schedule.")
  daysOfMonth: int32[];
}

@doc("Recurrence based trigger.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model RecurrenceTrigger extends Trigger {
  @doc("Type of the trigger.")
  type: TriggerType.Recurrence;

  @doc("Start time for the recurrence schedule in ISO 8601 format.")
  startTime?: string;

  @doc("End time for the recurrence schedule in ISO 8601 format.")
  endTime?: string;

  @doc("Time zone for the recurrence schedule.")
  timeZone?: string = "UTC";

  @doc("Interval for the recurrence schedule.")
  interval: int32;

  @doc("Recurrence schedule for the recurrence trigger.")
  schedule: RecurrenceSchedule;
}

@doc("One-time trigger.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model OneTimeTrigger extends Trigger {
  type: TriggerType.OneTime;

  @doc("Date and time for the one-time trigger in ISO 8601 format.")
  triggerAt: string;

  @doc("Time zone for the one-time trigger.")
  timeZone?: string = "UTC";
}

@doc("Type of the task.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union ScheduleTaskType {
  string,

  @doc("Evaluation task.")
  Evaluation: "Evaluation",

  @doc("Insight task.")
  Insight: "Insight",
}

@doc("Schedule task model.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@discriminator("type")
model ScheduleTask {
  @doc("Type of the task.")
  type: ScheduleTaskType;

  @doc("Configuration for the task.")
  configuration?: Record<string>;
}

@doc("Evaluation task for the schedule.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model EvaluationScheduleTask extends ScheduleTask {
  type: ScheduleTaskType.Evaluation;

  @doc("Identifier of the evaluation group.")
  evalId: string;

  @doc("The evaluation run payload.")
  evalRun: {};
}

@doc("Insight task for the schedule.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model InsightScheduleTask extends ScheduleTask {
  type: ScheduleTaskType.Insight;

  @doc("The insight payload.")
  insight: Insight;
}

@resource("schedules")
@doc("Schedule model.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model Schedule {
  @doc("Identifier of the schedule.")
  @key("id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Name of the schedule.")
  displayName?: string;

  @doc("Description of the schedule.")
  description?: string;

  #suppress "@azure-tools/typespec-autorest/union-unsupported"
  @doc("Enabled status of the schedule.")
  enabled: boolean;

  @doc("Provisioning status of the schedule.")
  @visibility(Lifecycle.Read)
  provisioningStatus?: ScheduleProvisioningStatus;

  @doc("Trigger for the schedule.")
  trigger: Trigger;

  @doc("Task for the schedule.")
  task: ScheduleTask;

  @doc("Schedule's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Schedule's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @visibility(Lifecycle.Read)
  @doc("System metadata for the resource.")
  systemData: Record<string>;
}

@doc("Schedule run model.")
@resource("schedules/{scheduleId}/runs")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model ScheduleRun {
  @doc("Identifier of the schedule run.")
  @key("id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Identifier of the schedule.")
  scheduleId: string;

  #suppress "@azure-tools/typespec-autorest/union-unsupported"
  @doc("Trigger success status of the schedule run.")
  @visibility(Lifecycle.Read)
  success: boolean;

  @doc("Trigger time of the schedule run.")
  triggerTime?: string;

  @doc("Error information for the schedule run.")
  @visibility(Lifecycle.Read)
  error?: string;

  @doc("Properties of the schedule run.")
  @visibility(Lifecycle.Read)
  properties: Record<string>;
}
