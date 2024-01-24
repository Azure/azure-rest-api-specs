import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ClusterPool.tsp";
import "./Cluster.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * HDInsight Containers Management Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["https://management.azure.com/.default"]>)
@service({
  title: "HDInsightContainersManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.HDInsight;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-06-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_06_01_preview: "2023-06-01-preview",
}
