import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Scaling;

@doc("Properties for Auto scaling.")
model AutoScalingProperties extends ScalingProperties {
  @doc("Type of the Scale type.")
  scalingType: ScalingType.AutoScaling;

  @doc("Max parallelism count.")
  maxParallelism: int32;

  @doc("Current parallelism count.")
  @visibility(Lifecycle.Read)
  currentParallelism?: int32;
}
