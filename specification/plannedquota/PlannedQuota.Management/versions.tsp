import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@versioned(Microsoft.PlannedQuota.Versions)
namespace Microsoft.PlannedQuota;

@doc("Supported versions.")
enum Versions {
  @doc("API version 2025-10-01-preview")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_10_01_preview: "2025-10-01-preview",
}
