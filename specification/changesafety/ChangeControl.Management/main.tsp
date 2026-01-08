import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./stagemap.tsp";
import "./changestate.tsp";
import "./stageprogression.tsp";
import "./changerecord.tsp";
import "./changerecordstageprogression.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.ChangeSafety Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.ChangeSafety management service" })
@versioned(Microsoft.ChangeSafety.Versions)
namespace Microsoft.ChangeSafety;

/** The available API versions. */
enum Versions {
  /** 2024-10-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_10_01_preview: "2024-10-01-preview",

  /** 2025-03-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_03_01_preview: "2025-03-01-preview",

  /** 2025-07-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_07_01_preview: "2025-07-01-preview",

  /** 2025-09-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_09_01_preview: "2025-09-01-preview",

  /** 2026-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01_preview: "2026-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
