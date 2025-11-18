import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.PhysicalNetwork;

interface Operations extends Azure.ResourceManager.Operations {}

alias resourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{1,58}[a-zA-Z0-9]$";

enum Versions {
  /** 2024-06-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",

  /** 2024-09-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_09_01_preview: "2024-09-01-preview",

  /** 2025-01-01-preview version */
  @armCommonTypesVersion(CommonTypes.Versions.v5)
  v2025_01_01_preview: "2025-01-01-preview",

  /** 2025-04-01-preview version */
  @armCommonTypesVersion(CommonTypes.Versions.v5)
  v2025_04_01_preview: "2025-04-01-preview",

  /** 2025-06-01-preview version */
  @armCommonTypesVersion(CommonTypes.Versions.v5)
  v2025_06_01_preview: "2025-06-01-preview",
}
