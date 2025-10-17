import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Operations Control Plane API" })
@doc("Provides operations for working with Azure Monitor")
@versioned(Microsoft.Monitor.Versions)
namespace Microsoft.Monitor;

@doc("Microsoft.Monitor Versions")
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("API Version 2024-10-01")
  v2024_10_01_preview: "2024-10-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("API Version 2025-05-03")
  v2025_05_03_preview: "2025-05-03-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
