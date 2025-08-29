import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Schedule provisioning status.")
@added(Versions.v2025_09_15_preview)
union ScheduleProvisioningStatus {
  string,

  @doc("Represents the creation status of the schedule.")
  Created: "Created",

  @doc("Represents the running status of the schedule.")
  Running: "Running",

  @doc("Represents the paused status of the schedule.")
  Paused: "Paused",

  @doc("Represents the completed status of the schedule.")
  Completed: "Completed"
}

@doc("Type of the trigger.")
@added(Versions.v2025_09_15_preview)
union TriggerType {
  string,

  @doc("Cron based trigger.")
  Cron: "Cron",

  @doc("Recurrence based trigger.")
  Recurrence: "Recurrence",

  @doc("One-time trigger.")
  OneTime: "OneTime"
}

@doc("Base model for Trigger of the schedule.")
@added(Versions.v2025_09_15_preview)
model Trigger {
  @doc("Type of the trigger.")
  type: TriggerType;
}

@doc("Cron based trigger.")
@added(Versions.v2025_09_15_preview)
model CronTrigger extends Trigger {
  type: TriggerType.Cron;

  @doc("Cron expression that defines the schedule frequency.")
  cronExpression: string;

  @doc("Time zone for the cron schedule.")
  timeZone: string;
}

@doc("Recurrence pattern type.")
@added(Versions.v2025_09_15_preview)
union RecurrencePatternType {
  string,

  @doc("Hourly recurrence pattern.")
  Hourly: "Hourly",

  @doc("Daily recurrence pattern.")
  Daily: "Daily",

  @doc("Weekly recurrence pattern.")
  Weekly: "Weekly",

  @doc("Monthly recurrence pattern.")
  Monthly: "Monthly"
}

@doc("Recurrence pattern for the schedule.")
@added(Versions.v2025_09_15_preview)
model HourlyRecurrencePattern {
  type: RecurrencePatternType.Hourly;

  @doc("Interval in hours for the hourly recurrence.")
  interval: int32;
}

@doc("Recurrence pattern for the schedule.")
@added(Versions.v2025_09_15_preview)
model DailyRecurrencePattern {
  type: RecurrencePatternType.Daily;

  @doc("Interval in days for the daily recurrence.")
  interval: int32;

  @doc("Hour of the day for the daily recurrence.")
  hour: int32;
}

@doc("Recurrence pattern for the schedule.")
@added(Versions.v2025_09_15_preview)
model WeeklyRecurrencePattern {
  type: RecurrencePatternType.Weekly;

  @doc("Interval in weeks for the weekly recurrence. Possible values: 1-3")
  interval: int32;

  @doc("Day of the week for the weekly recurrence. Possible values: 0-6, 0 - Mon, 1 - Tue, 2 - Wed, 3 - Thu, 4 - Fri, 5 - Sat, 6 - Sun")
  dayOfWeek: int32 = 0;

  @doc("Hour of the day for the weekly recurrence. Possible values: 0-23")
  hourOfDay: int32 = 0;
}

@doc("Recurrence pattern for the schedule.")
@added(Versions.v2025_09_15_preview)
model MonthlyRecurrencePattern {
  type: RecurrencePatternType.Monthly;

  @doc("Interval in months for the monthly recurrence. Possible values: 1-12")
  interval: int32;

  @doc("Day of the month for the monthly recurrence. Possible values: 1-31. Values outside of the month's days will be adjusted with the nearest valid day.")
  dayOfMonth: int32 = 1;

  @doc("Hour of the day for the monthly recurrence. Possible values: 0-23")
  hourOfDay: int32 = 0;
}

@doc("Recurrence based trigger.")
@added(Versions.v2025_09_15_preview)
model RecurrenceTrigger extends Trigger {
  type: TriggerType.Recurrence;

  @doc("Recurrence pattern for the schedule.")
  recurrencePattern: HourlyRecurrencePattern | DailyRecurrencePattern | WeeklyRecurrencePattern | MonthlyRecurrencePattern;

  @doc("Time zone for the recurrence schedule.")
  timeZone: string;
}

@doc("One-time trigger.")
@added(Versions.v2025_09_15_preview)
model OneTimeTrigger extends Trigger {
  type: TriggerType.OneTime;

  @doc("Date and time for the one-time trigger.")
  triggerAt: string;

  @doc("Time zone for the one-time trigger.")
  timeZone: string;
}

@doc("Type of the task.")
@added(Versions.v2025_09_15_preview)
union ScheduleTaskType {
  string,

  Evaluation: "Evaluation",

  AgentRunAnalysis: "AgentAnalysis"
}

@doc("Schedule task model.")
@added(Versions.v2025_09_15_preview)
model ScheduleTask {
  @doc("Identifier of the task.")
  @encodedName("application/json", "id")
  id: string;

  @doc("Name of the task.")
  displayName?: string;

  @doc("Type of the task.")
  type: ScheduleTaskType;

  @doc("Configuration for the task.")
  configuration: Record<string>;

  @doc("Definition of the task. JSON payload that will be used by task execution provider.")
  definition: unknown;
}

@doc("Schedule model.")
@added(Versions.v2025_09_15_preview)
model Schedule {
  @doc("Identifier of the schedule.")
  @key("id")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Name of the schedule.")
  displayName?: string;

  @doc("Provisioning status of the schedule.")
  @visibility(Lifecycle.Read)
  provisioningStatus?: ScheduleProvisioningStatus;

  @doc("Trigger for the schedule.")
  trigger: Trigger;

  @doc("Task for the schedule.")
  task: ScheduleTask;

  @visibility(Lifecycle.Read)
  @doc("Schedule's runs.")
  runs?: ScheduleRun[];

  @doc("Schedule's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Schedule's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @visibility(Lifecycle.Read)
  @doc("System metadata for the resource.")
  systemData: Record<string>;
}

@doc("Trigger status of the schedule run.")
@added(Versions.v2025_09_15_preview)
union ScheduleRunTriggerStatus {
  string,

  @doc("NotTriggered status of the schedule run.")
  NotTriggered: "NotTriggered",

  @doc("Triggered status of the schedule run.")
  Triggered: "Triggered",

  @doc("Skipped status of the schedule run.")
  Skipped: "Skipped",

  @doc("Failed status of the schedule run.")
  Failed: "Failed"
}

@doc("Schedule run model.")
@added(Versions.v2025_09_15_preview)
model ScheduleRun {
  @doc("Identifier of the schedule run.")
  @key("id")
  @encodedName("application/json", "id")
  id: string;

  @doc("Identifier of the schedule.")
  scheduleId?: string;

  @doc("Trigger status of the schedule run.")
  @visibility(Lifecycle.Read)
  triggerStatus: ScheduleRunTriggerStatus;

  @doc("Trigger time of the schedule run.")
  triggerTime?: string;

  @doc("Error information for the schedule run.")
  error?: string;
}

@doc("Type of action for schedule run event.")
@added(Versions.v2025_09_15_preview)
union ScheduleRunEventAction {
  string,

  Skip: "Skip"
}

@doc("Event model for schedule run actions.")
@added(Versions.v2025_09_15_preview)
model ScheduleRunEvent {
  @doc("Identifier of the schedule.")
  scheduleId: string;

  @doc("Index of the schedule run to be acted upon from the last triggered run. Possible values 1-5.")
  scheduleRunIndex: int32;

  @doc("Action to be taken on the schedule run.")
  action: ScheduleRunEventAction;
}