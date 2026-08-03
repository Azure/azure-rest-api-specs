import "@typespec/openapi";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

const GroupMaxConcurrencyDefault = "1";

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

  @doc("""
    The max number of upgrades that can run concurrently across all groups in this stage.
    Acts as a ceiling (and not a quota) for the number of concurrent upgrades within the stage you want to tolerate at a time.
    Actual concurrency may be lower depending on group-level concurrency limits or individual member conditions.
    Stage maxConcurrency has a min value of "1".
    Accepts either:
        • A fixed count, e.g., "3"
        • A percentage, e.g., "25%" (range 1–100). Percentage is of the total number of clusters across all groups in the stage.
          Fractional results are rounded down. A minimum of 1 upgrade is enforced.
    Examples:
        • "3"     --> up to 3 clusters from this stage upgrade at once (across all groups).
        • "100%"  --> “all at once”; up to all clusters in this stage upgrade at the same time.
        • "25%"   --> up to 25% of the stage’s total clusters upgrade at the same time.
    """)
  @pattern("^(?:([1-9]\\d*)|([1-9]\\d?|100)%)$")
  @added(Versions.v2026_02_01_preview)
  maxConcurrency?: string;

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

  @doc("""
    The max number of upgrades that can run concurrently in this specific group.
    Acts as a ceiling (and not a quota) for the number of concurrent upgrades within the group you want to tolerate at a time.
    Actual concurrency may be lower depending on stage-level concurrency limits or individual member conditions.
    Group maxConcurrency has a min value of "1". The max value is min(number of clusters in the group, the stage maxConcurrency).
    If no value is provided, defaults to ${GroupMaxConcurrencyDefault}.
    Accepts either:
        • A fixed count, e.g. "3"
        • A percentage, e.g. "25%" (range 1–100). Percentage is of the number of clusters in the group. 
          Fractional results are rounded down. A minimum of 1 upgrade is enforced.
    Examples:
        • "3" --> up to 3 members from this group upgrade at once.
        • "100%" --> “all at once”, up to all members for this group upgrade at the same time.
        • "25%" --> up to 25% of the members in the group will be upgraded at the same time.
    """)
  @pattern("^(?:([1-9]\\d*)|([1-9]\\d?|100)%)$")
  @added(Versions.v2026_02_01_preview)
  maxConcurrency?: string;

  @doc("A list of Gates that will be created before this Group is executed.")
  @added(Versions.v2025_04_01_preview)
  @identifiers(#[])
  beforeGates?: GateConfiguration[];

  @doc("A list of Gates that will be created after this Group is executed.")
  @added(Versions.v2025_04_01_preview)
  @identifiers(#[])
  afterGates?: GateConfiguration[];
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
}
