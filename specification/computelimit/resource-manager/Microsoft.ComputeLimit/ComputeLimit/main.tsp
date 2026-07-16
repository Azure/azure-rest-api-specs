import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./GuestSubscription.tsp";
import "./TrustedHostSubscription.tsp";
import "./SharedLimit.tsp";
import "./Feature.tsp";
import "./VmFamily.tsp";
import "./SharedLimitCap.tsp";
import "./MemberCapOverride.tsp";
import "./back-compat.tsp";
import "./client.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/** Microsoft Azure Compute Limit Resource Provider. */
@armProviderNamespace
@service(#{ title: "Azure Compute Limit API" })
@versioned(Versions)
namespace Microsoft.ComputeLimit;

/** The available API versions. */
enum Versions {
  /** The 2025-08-15 API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_08_15: "2025-08-15",

  /** The 2026-03-20 API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_03_20: "2026-03-20",

  /** The 2026-04-30 API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_04_30: "2026-04-30",

  /** The 2026-06-01 API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_06_01: "2026-06-01",

  /** The 2026-07-01 API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_07_01: "2026-07-01",

  /** The 2026-07-31 API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_07_31: "2026-07-31",
}

interface Operations extends Azure.ResourceManager.Operations {}
