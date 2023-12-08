import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BatchAccount.tsp";
import "./BatchAccountDetector.tsp";
import "./BatchApplicationPackage.tsp";
import "./BatchApplication.tsp";
import "./BatchAccountCertificate.tsp";
import "./BatchPrivateLinkResource.tsp";
import "./BatchPrivateEndpointConnection.tsp";
import "./BatchAccountPool.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "BatchManagementClient",
})
@versioned(Versions)
@doc("Batch Client")
namespace Azure.ResourceManager.Batch;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_05_01: "2023-05-01",
}
