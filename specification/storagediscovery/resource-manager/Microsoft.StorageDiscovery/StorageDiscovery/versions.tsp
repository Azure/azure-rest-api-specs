import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.StorageDiscovery;

enum ApiVersion {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_06_01_preview: "2025-06-01-preview",

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract."
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_09_01: "2025-09-01",

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract."
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @Azure.Core.previewVersion
  v2026_10_01_preview: "2026-10-01-preview",
}
