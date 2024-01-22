import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BatchAccount.tsp";
import "./DetectorResponse.tsp";
import "./ApplicationPackage.tsp";
import "./Application.tsp";
import "./Certificate.tsp";
import "./PrivateLinkResource.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Pool.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Batch Client
 */
@armProviderNamespace
@service({
  title: "BatchManagementClient",
})
@versioned(Versions)
namespace Microsoft.Batch;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-11-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_11_01: "2023-11-01",
}
