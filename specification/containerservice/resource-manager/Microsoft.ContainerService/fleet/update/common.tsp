import "@typespec/openapi";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@doc("""
  Defines the update sequence of the clusters via stages and groups.
  
  Stages within a run are executed sequentially one after another.
  Groups within a stage are executed in parallel.
  Member clusters within a group are updated sequentially one after another.
  
  A valid strategy contains no duplicate groups within or across stages.
  """)
model UpdateRunStrategy {
  @Azure.ResourceManager.identifiers(#["name"])
  @doc("The list of stages that compose this update run. Min size: 1.")
  stages: UpdateStage[];
}

@doc("Defines a stage which contains the groups to update and the steps to take (e.g., wait for a time period) before starting the next stage.")
model UpdateStage {
  @doc("The name of the stage. Must be unique within the UpdateRun.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  name: string;

  @Azure.ResourceManager.identifiers(#["name"])
  @doc("Defines the groups to be executed in parallel in this stage. Duplicate groups are not allowed. Min size: 1.")
  groups?: UpdateGroup[];

  @doc("The time in seconds to wait at the end of this stage before starting the next one. Defaults to 0 seconds if unspecified.")
  afterStageWaitInSeconds?: int32;

  @doc("A list of Gates that will be created before this Stage is executed.")
  @added(Versions.v2025_04_01_preview)
  @identifiers(#[])
  beforeGates?: GateConfiguration[];

  @doc("A list of Gates that will be created after this Stage is executed.")
  @added(Versions.v2025_04_01_preview)
  @identifiers(#[])
  afterGates?: GateConfiguration[];
}

@doc("A group to be updated.")
model UpdateGroup {
  @doc("""
    Name of the group.
    It must match a group name of an existing fleet member. 
    """)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  name: string;

  @doc("A list of Gates that will be created before this Group is executed.")
  @added(Versions.v2025_04_01_preview)
  @identifiers(#[])
  beforeGates?: GateConfiguration[];

  @doc("A list of Gates that will be created after this Group is executed.")
  @added(Versions.v2025_04_01_preview)
  @identifiers(#[])
  afterGates?: GateConfiguration[];
}

@doc("Day of week used to schedule a Gate start")
@added(Versions.v2026_01_01_scheduledstart)
union DayOfWeek {
  string,

  @doc("Monday")
  Monday: "Monday",

  @doc("Tuesday")
  Tuesday: "Tuesday",

  @doc("Wednesday")
  Wednesday: "Wednesday",

  @doc("Thursday")
  Thursday: "Thursday",

  @doc("Friday")
  Friday: "Friday",

  @doc("Saturday")
  Saturday: "Saturday",

  @doc("Sunday")
  Sunday: "Sunday",
}

@doc("Configuration for ScheduledStart gate")
@added(Versions.v2026_01_01_scheduledstart)
model ScheduledStartConfiguration {
  @doc("The day of the week when the scheduled start occurs.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  startDay: DayOfWeek;

  @doc("The local time of day when the scheduled start occurs in 24-hour (HH:mm) format.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @pattern("^([01][0-9]|2[0-3]):[0-5][0-9]$")
  startTime: string;

  @doc("The UTC offset for the scheduled time in HH:mm format, -14:00 to +14:00")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @pattern("^[+-]((0[0-9]|1[0-3]):[0-5][0-9]|14:00)$")
  UTCOffset: string;
}

@doc("GateConfiguration is used to define where Gates should be placed within the Update Run.")
@added(Versions.v2025_04_01_preview)
model GateConfiguration {
  @doc("The human-readable display name of the Gate.")
  @minLength(1)
  @maxLength(100)
  displayName?: string;

  @doc("The type of the Gate determines how it is completed.")
  type: GateType;

  @doc("Scheduled start configuration for gates of type ScheduledStart.")
  @added(Versions.v2026_01_01_scheduledstart)
  scheduledStartConfiguration?: ScheduledStartConfiguration;
}
