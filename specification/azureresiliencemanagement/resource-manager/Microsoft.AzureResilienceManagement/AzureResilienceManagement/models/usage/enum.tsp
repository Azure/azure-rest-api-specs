import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;

namespace Microsoft.AzureResilienceManagement;

@doc("The type of usage plan.")
union UsagePlanType {
  string,

  @removed(Versions.v2026_09_30_preview)
  @doc("Basic usage plan with restricted functionality without any charges.")
  Basic: "Basic",

  @doc("Standard usage plan with comprehensive functionality and usage based charges.")
  Standard: "Standard",
}
