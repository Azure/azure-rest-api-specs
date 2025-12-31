import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@versioned(Microsoft.Monitor.Versions)
namespace Microsoft.Monitor;

@doc("Supported versions.")
enum Versions {
  @doc("API version 2025-11-04-preview")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_11_04_preview: "2025-11-04-preview",
}
