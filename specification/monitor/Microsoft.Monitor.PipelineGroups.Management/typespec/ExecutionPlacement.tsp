/*
  Definitions of elements exclusively defined for pipeline group execution placement and scheduling.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;

@doc("Constraints for guiding the execution environment of the pipeline group.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ExecutionPlacement {
  @doc("A list of placement constraints to guide where pipelineGroup instances should run.")
  @Azure.ResourceManager.identifiers(#[])
  constraints?: PlacementConstraint[];

  @doc("Distribution policy for spreading instances across compute units (nodes/VMs).")
  distribution?: DistributionPolicy;
}

@doc("A placement constraint defines requirements for where pipeline group instances can be scheduled.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model PlacementConstraint {
  @doc("The capability or attribute key used to match compute unit properties.")
  capability: string;

  @doc("The match operator, e.g., In, NotIn, Exists, DoesNotExist.")
  operator: CapabilityOperator;

  @doc("The values to match against. Not required for Exists/DoesNotExist.")
  values?: string[];
}

@doc("Distribution policy for spreading instances across compute units.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model DistributionPolicy {
  @doc("Maximum number of instances allowed per compute unit (node/VM). If not specified, default scheduling applies.")
  maxInstancesPerHost?: int32;
}

@doc("The match operator for placement constraints.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
union CapabilityOperator {
  string,

  @doc("The capability value must be one of the specified values.")
  In: "In",

  @doc("The capability value must not be one of the specified values.")
  NotIn: "NotIn",

  @doc("The capability key must exist (value is ignored).")
  Exists: "Exists",

  @doc("The capability key must not exist.")
  DoesNotExist: "DoesNotExist",
}
