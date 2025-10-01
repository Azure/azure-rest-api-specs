import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@versioned(Microsoft.Lionrock.Versions)
namespace Microsoft.Lionrock;

@doc("Supported versions.")
enum Versions {
  @doc("API version 2025-10-01")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_10_01: "2025-10-01",
}
