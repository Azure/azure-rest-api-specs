// Test: TSG checklist 8.1.4 - verify no Java section triggers "No sdk folder found"
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./capacity.tsp";
import "./back-compatible.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.Fabric Resource Provider management API. Test: TSG 8.1.4 */
@armProviderNamespace
@service(#{ title: "Microsoft.Fabric management service" })
@versioned(Microsoft.Fabric.Versions)
namespace Microsoft.Fabric;

/** The available API versions. */
enum Versions {
  /** 2023-11-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_11_01: "2023-11-01",

  /** 2025-01-15-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_01_15_preview: "2025-01-15-preview",
}
