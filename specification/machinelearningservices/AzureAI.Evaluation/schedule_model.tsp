namespace Microsoft.MachineLearningServices;

enum Frequency {
    Month,
    Week,
    Day,
    Hour,
    Minute
}

enum WeekDays {
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
    Sunday
}

@doc("Recurrence Definition")
model Recurrence {
    @doc("The frequency to trigger schedule.")
    frequency: Frequency;

    @doc("Specifies schedule interval in conjunction with frequency")
    interval: int32;

    @doc("The recurrence schedule.")
    schedule: RecurrenceSchedule;
}

@doc("RecurrenceSchedule Definition")
model RecurrenceSchedule {
    @doc("List of hours for the schedule.")
    hours: int32[];

    @doc("List of minutes for the schedule.")
    minutes: int32[];

    @doc("List of days for the schedule.")
    weekDays: WeekDays[];

    @doc("List of month days for the schedule")
    monthDays: int32[];
}

@doc("SamplingStrategy Definition")
model SamplingStrategy {
    @doc(Sampling rate)
    rate: float32;
}
