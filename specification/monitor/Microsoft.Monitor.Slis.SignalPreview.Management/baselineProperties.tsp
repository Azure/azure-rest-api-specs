import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Monitor;

@doc("Defines the properties of a baseline.")
model BaselineProperties {
  @doc("Defines the baseline target, which is compared against the SLI value to determine compliance.")
  baseline: Baseline;
}

@doc("Defines the target parameters for a Slo baseline.")
model Baseline {
  @doc("The user-defined or Azure-defined target value used for comparison against the SLI value.")
  @minValue(0)
  @maxValue(100)
  value: float32;

  @doc("The time frame (in days) used for SLI evaluation.")
  @minValue(1)
  @maxValue(90)
  evaluationPeriodDays: int32;

  @doc("Specifies how evaluation is calculated, either based on calendar days or a rolling window.")
  evaluationCalculationType: EvaluationCalculationType;
}

@doc("Specifies the method for evaluation calculation.")
union EvaluationCalculationType {
  @doc("Calculates evaluation based on a fixed calendar period.")
  "CalendarDays",

  @doc("Calculates evaluation using a rolling time window.")
  "RollingDays",

  string,
}
