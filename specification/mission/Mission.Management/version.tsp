import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Mission;

@doc("Supported API versions for the Microsoft.Mission resource provider.")
enum Versions {
  @doc("The 2023-02-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_02_01_preview: "2023-02-01-preview",

  @doc("The 2023-08-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_08_01_preview: "2023-08-01-preview",

  @doc("The 2023-11-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_11_01_preview: "2023-11-01-preview",

  @doc("The 2024-01-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_01_01_preview: "2024-01-01-preview",
}
