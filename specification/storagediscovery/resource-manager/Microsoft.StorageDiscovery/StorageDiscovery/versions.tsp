import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.StorageDiscovery;

#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
enum ApiVersion {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_06_01_preview: "2025-06-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_09_01: "2025-09-01",
}
