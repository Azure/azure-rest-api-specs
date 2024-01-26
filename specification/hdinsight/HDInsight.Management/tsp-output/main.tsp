import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Application.tsp";
import "./Cluster.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * HDInsight Management Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["https://management.azure.com/.default"]>)
@service({
  title: "HDInsightManagementClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.HDInsight;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-04-15-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_04_15_preview: "2023-04-15-preview",
}
