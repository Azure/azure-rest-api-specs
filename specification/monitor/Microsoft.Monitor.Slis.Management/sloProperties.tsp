import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Monitor;

@doc("Defines the properties of an SLO.")
model SloProperties {
  @doc("Defines the SLO target, which is compared against the SLI value to determine compliance.")
  target: SloTarget;
}

@doc("Defines the target parameters for an SLO.")
model SloTarget {
  @doc("The user-defined or Azure-defined target value used for comparison against the SLI value.")
  @minValue(0)
  @maxValue(100)
  value: float32;

  @doc("The time frame (in days) used for SLI evaluation.")
  @minValue(1)
  @maxValue(90)
  compliancePeriodDays: int32;

  @doc("Specifies how compliance is calculated, either based on calendar days or a rolling window.")
  complianceCalculationType: ComplianceCalculationType;

  @doc("Defines the operator used to compare the SLI value against the target.")
  comparator: TargetComparator;
}

@doc("Specifies the method for compliance calculation.")
union ComplianceCalculationType {
  @doc("Calculates compliance based on a fixed calendar period.")
  "CalendarDays",

  @doc("Calculates compliance using a rolling time window.")
  "RollingDays",

  string,
}

@doc("Defines comparison operators for evaluating an SLI against an SLO target.")
union TargetComparator {
  @doc("Less than the target value.")
  `<`: "lt",

  @doc("Greater than the target value.")
  `>`: "gt",

  @doc("Less than or equal to the target value.")
  `<=`: "lte",

  @doc("Greater than or equal to the target value.")
  `>=`: "gte",

  string,
}