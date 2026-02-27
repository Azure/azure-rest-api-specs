@doc("Trigger configuration for batch based channels")
@discriminator("triggerType")
model BatchTriggerProperties {
  @doc("The type of trigger.")
  triggerType: BatchTriggerType;

  @doc("Optional input to specify the start date time of the trigger in UTC timezone. By default, the trigger will start once the resource is successfully provisioned.")
  startDateTimeUtc?: utcDateTime;

  @doc("The state of the trigger.")
  state: TriggerState;
}

@doc("The batch trigger types.")
union BatchTriggerType {
  string,

  @doc("The adhoc trigger type.")
  AdhocTrigger: "AdhocTrigger",

  @doc("The recurring schedule trigger type.")
  RecurringScheduleTrigger: "RecurringScheduleTrigger",
}

@doc("The recurring schedule based trigger configuration.")
model RecurringScheduleTriggerConfiguration extends BatchTriggerProperties {
  @doc("The type of trigger.")
  triggerType: BatchTriggerType.RecurringScheduleTrigger;

  @doc("Optional input to specify the recurrence configuration for the schedule indicating the hours the schedule should run on. By default, the schedule will run at all hours.")
  activeHours?: Array<int32>;

  @doc("Optional input to specify the recurrence configuration for the schedule indicating the days the schedule should run on. By default, the schedule will run on all days.")
  activeDays?: Array<int32>;
}

@doc("The adhoc based trigger configuration.")
model AdhocTriggerConfiguration extends BatchTriggerProperties {
  @doc("The type of trigger.")
  triggerType: BatchTriggerType.AdhocTrigger;
}

@doc("The trigger state.")
union TriggerState {
  string,

  @doc("The trigger is enabled.")
  Enabled: "Enabled",

  @doc("The trigger is disabled.")
  Disabled: "Disabled",
}
