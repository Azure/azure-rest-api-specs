import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./GuestSubscription.tsp";
import "./SharedLimit.tsp";
import "./Feature.tsp";
import "./VmFamily.tsp";
import "./back-compat.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/** Microsoft Azure Compute Limit Resource Provider. */
@armProviderNamespace
@service(#{ title: "Azure Compute Limit API" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.ComputeLimit;

/** The available API versions. */
enum Versions {
  /** The 2025-08-15 API version. */
  v2025_08_15: "2025-08-15",

  /** The 2026-03-20 API version. */
  v2026_03_20: "2026-03-20",

  /** The 2026-04-30 API version. */
  v2026_04_30: "2026-04-30",
}

interface Operations extends Azure.ResourceManager.Operations {}
