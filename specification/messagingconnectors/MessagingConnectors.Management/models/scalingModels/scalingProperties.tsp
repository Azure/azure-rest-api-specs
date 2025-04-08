import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Base properties for scaling.")
@discriminator("scalingType")
model ScalingProperties {
  @doc("Type of the Scale type.")
  scalingType: ScalingType;
}

@doc("Scale types")
union ScalingType {
  @doc("Static scaling type.")
  StaticScaling: "StaticScaling",

  @doc("AutoHorizontal scaling type.")
  AutoScaling: "AutoScaling",

  string,
}
