import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BatchPricings.tsp";
import "./back-compatible.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/**
 * API spec for Microsoft.Security batch pricing operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations are defined by the Microsoft.Security provider."
#suppress "@azure-tools/typespec-azure-core/casing-style" "The API suffix matches the existing Microsoft.Security TypeSpec project naming convention."
@armProviderNamespace("Microsoft.Security")
@service(#{ title: "Microsoft Defender for Cloud" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace BatchPricingsAPI;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-07-01 API version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract; tracked by Azure/typespec-azure#5977."
  v2026_07_01: "2026-07-01",
}
