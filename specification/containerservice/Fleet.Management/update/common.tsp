import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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
  @extension("x-ms-identifiers", #[])
  beforeGates?: GateConfiguration[];

  @doc("A list of Gates that will be created after this Stage is executed.")
  @added(Versions.v2025_04_01_preview)
  @extension("x-ms-identifiers", #[])
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
  @extension("x-ms-identifiers", #[])
  beforeGates?: GateConfiguration[];

  @doc("A list of Gates that will be created after this Group is executed.")
  @added(Versions.v2025_04_01_preview)
  @extension("x-ms-identifiers", #[])
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
