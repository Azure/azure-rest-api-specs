import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Function.tsp";
import "./Input.tsp";
import "./Output.tsp";
import "./StreamingJob.tsp";
import "./Transformation.tsp";
import "./Cluster.tsp";
import "./PrivateEndpoint.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Stream Analytics Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "Stream Analytics Management Client",
})
@versioned(Versions)
namespace Microsoft.StreamAnalytics;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-10-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_10_01_preview: "2021-10-01-preview",

  /**
   * The 2020-03-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_03_01_preview: "2020-03-01-preview",
}
