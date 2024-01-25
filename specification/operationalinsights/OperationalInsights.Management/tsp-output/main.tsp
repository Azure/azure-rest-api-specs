import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./LogAnalyticsQueryPack.tsp";
import "./LogAnalyticsQueryPackQuery.tsp";
import "./DataExport.tsp";
import "./DataSource.tsp";
import "./LinkedService.tsp";
import "./LinkedStorageAccountsResource.tsp";
import "./StorageInsight.tsp";
import "./SavedSearch.tsp";
import "./Cluster.tsp";
import "./Workspace.tsp";
import "./Table.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Operational Insights Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "OperationalInsightsManagementClient",
})
@versioned(Versions)
// FIXME: Common type version v1 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v1)
namespace Microsoft.OperationalInsights;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2019-09-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_09_01: "2019-09-01",

  /**
   * The 2020-08-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_08_01: "2020-08-01",

  /**
   * The 2021-06-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_06_01: "2021-06-01",

  /**
   * The 2022-10-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_10_01: "2022-10-01",
}
