import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";
import "./FirewallRule.tsp";
import "./VirtualNetworkRule.tsp";
import "./TrustedIdProvider.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "DataLakeStoreAccountManagementClient",
})
@versioned(Versions)
@doc("Creates an Azure Data Lake Store account management client.")
namespace Microsoft.DataLakeStore;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2016-11-01 API version.")
  v2016_11_01: "2016-11-01",
}
