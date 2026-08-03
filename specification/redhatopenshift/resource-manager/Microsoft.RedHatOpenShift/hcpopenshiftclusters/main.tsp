import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

import "./hcpCluster.tsp";
import "./hcpVersion.tsp";
import "./hcpOperatorIdentityRoleSet.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.RedHatOpenShift Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Azure Red Hat OpenShift Hosted Control Planes Service" })
@versioned(Microsoft.RedHatOpenShift.Versions)
namespace Microsoft.RedHatOpenShift;

interface Operations extends Azure.ResourceManager.Operations {}

/** The available API versions. */
enum Versions {
  /** 2024-06-10-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2024_06_10_preview: "2024-06-10-preview",

  /** 2025-12-23-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_12_23_preview: "2025-12-23-preview",

  /** 2026-06-30-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_06_30_preview: "2026-06-30-preview",
}
