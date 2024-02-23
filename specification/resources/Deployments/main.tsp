import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./bicep.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

@armProviderNamespace("Microsoft.Resources")
@service({
  title: "Microsoft.Resources Azure Deployments apis",
})
@doc("Microsoft.Resources Azure Deployments api client.")
@versioned(Versions)
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Microsoft.Resources.Deployments;

@doc("Microsoft.Resources Azure Deployments api versions.")
enum Versions {
  @doc("Microsoft.Resources Azure Deployments api version 2023-11-01.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_11_01: "2023-11-01",
}
