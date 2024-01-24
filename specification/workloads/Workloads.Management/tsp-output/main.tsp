import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./SAPVirtualInstance.tsp";
import "./SAPCentralServerInstance.tsp";
import "./SAPDatabaseInstance.tsp";
import "./SAPApplicationServerInstance.tsp";
import "./Monitor.tsp";
import "./ProviderInstance.tsp";
import "./SapLandscapeMonitor.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Workloads client provides access to various workload operations.<br>Azure Center for SAP solutions is currently in PREVIEW. See the [Azure Center for SAP solutions - Legal Terms](https://learn.microsoft.com/legal/azure-center-for-sap-solutions/azure-center-for-sap-solutions-legal-terms) for legal notices applicable to Azure Center for SAP solutions.
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "Workloads Client",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.Workloads;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-04-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_04_01: "2023-04-01",
}
