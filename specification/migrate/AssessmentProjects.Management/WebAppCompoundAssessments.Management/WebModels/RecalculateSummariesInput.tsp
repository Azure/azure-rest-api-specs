import "../WACAApiVersions.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("Recalculate summaries input.")
@added(WACAApiVersions.v2025_09_09_preview)
model RecalculateSummariesInput {
  @doc("Recalculate summaries properties.")
  properties?: RecalculateSummariesProperties;
}

@doc("Recalculate summaries properties.")
@added(WACAApiVersions.v2025_09_09_preview)
model RecalculateSummariesProperties {
  @doc("Recalculate summaries type.")
  type?: RecalculateSummariesTypeEnum;

  @doc("Assessment status.")
  assessmentStatus?: AssessmentStatus;
}

@doc("Recalculate summaries type enum.")
@added(WACAApiVersions.v2025_09_09_preview)
union RecalculateSummariesTypeEnum {
  @doc("None")
  None: "None",

  @doc("App aware")
  AppAware: "AppAware",

  @doc("State change")
  StateChange: "StateChange",

  string,
}
