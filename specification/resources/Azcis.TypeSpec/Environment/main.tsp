import "./autopilotEnvironment.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@service({
  title: "Foundational ARM Client",
})
@versioned(Microsoft.AzureCIS.Versions)
@doc("Autopilot Environment Provider")
@armProviderNamespace
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Supported API versions for the Autopilot Environment resource provider.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Version 2023-08-22-preview")
  v2023_08_22_preview: "2023-08-22-preview",
}
