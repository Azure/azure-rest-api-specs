import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ManagedGrafana.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";
import "./ManagedPrivateEndpointModel.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "DashboardManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("The Microsoft.Dashboard Rest API spec.")
namespace Microsoft.Dashboard;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-09-01 API version.")
  v2023_09_01: "2023-09-01",
}
