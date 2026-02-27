import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./SAP/sap-discovery-models.tsp";
import "./SAP/SAP_CentralServices_Default.tsp";
import "./SAP/SAP_ApplicationServer_Default.tsp";
import "./SAP/SAP_DatabaseServer_Default.tsp";
import "./VirtualInstance.tsp";
import "./WorkloadComponent.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Workloads client provides access to various workload operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
@armProviderNamespace
@service(#{ title: "Workloads Client" })
@versioned(Versions)
namespace Microsoft.Workloads;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-12-01-preview API version.
   */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_01_preview: "2024-12-01-preview",

  /**
   * The 2025-06-01-preview API version.
   */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_06_01_preview: "2025-06-01-preview",

  /**
   * The 2026-02-01-preview API version.
   */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_02_01_preview: "2026-02-01-preview",
}
