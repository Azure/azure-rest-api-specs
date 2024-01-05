import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./index.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Azure Machine Learning Services",
  description: "Azure AI Management API.",
})

@doc("Azure AI api client.")
@versioned(Versions)
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "ref:workspaceRP.json#Microsoft.MachineLearningServices/operations"
namespace Microsoft.MachineLearningServices;

@doc("Azure Machine Learning Services api versions.")
enum Versions {
  @doc("Azure Machine Learning Services api version 2021-10-01-dataplanepreview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2021_10_01_dataplanepreview: "2021-10-01-dataplanepreview",
}
