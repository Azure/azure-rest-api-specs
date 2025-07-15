import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Scaling;

@doc("Properties for Static scaling.")
model StaticScalingProperties extends ScalingProperties {
  @doc("Type of the Scale type.")
  scalingType: ScalingType.StaticScaling;

  @doc("Parallelism count.")
  parallelism: int32;
}
