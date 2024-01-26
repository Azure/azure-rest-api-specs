import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataLakeAnalyticsAccount.tsp";
import "./DataLakeStoreAccountInformation.tsp";
import "./StorageAccountInformation.tsp";
import "./StorageContainer.tsp";
import "./ComputePolicy.tsp";
import "./FirewallRule.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Creates an Azure Data Lake Analytics account management client.
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "DataLakeAnalyticsAccountManagementClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.DataLakeAnalytics;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2016-11-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2016_11_01: "2016-11-01",
}
