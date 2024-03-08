import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./apis.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

@armProviderNamespace("Microsoft.Resources")
@service({
  title: "Azure Deployments deploymentScripts apis",
})
@doc("Azure Deployments deploymentScripts api client.")
@versioned(Versions)
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Microsoft.Resources.Deployments.DeploymentScripts;

@doc("Azure Deployments deploymentScripts api versions.")
enum Versions {
  @doc("Azure Deployments deploymentScripts api version 2019-10-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2019_10_01_preview: "2019-10-01-preview",

  @doc("Azure Deployments deploymentScripts api version 2020-10-01.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_10_01: "2020-10-01",

  @doc("Azure Deployments deploymentScripts api version 2023-08-01.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_08_01: "2023-08-01",
}
