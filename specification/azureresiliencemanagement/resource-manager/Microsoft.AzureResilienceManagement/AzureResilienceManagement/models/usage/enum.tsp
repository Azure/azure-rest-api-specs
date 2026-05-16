import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;

namespace Microsoft.AzureResilienceManagement;

@added(Versions.v2026_03_01_preview)
@doc("The type of usage plan.")
union UsagePlanType {
  string,

  @added(Versions.v2026_03_01_preview)
  @doc("Basic usage plan with restricted functionality without any charges.")
  Basic: "Basic",

  @added(Versions.v2026_03_01_preview)
  @doc("Standard usage plan with comprehensive functionality and usage based charges.")
  Standard: "Standard",
}
