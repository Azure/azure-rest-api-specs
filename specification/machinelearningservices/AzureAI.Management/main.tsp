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
namespace Microsoft.MachineLearningServices;

@Autorest.useRef("workspaceRP.json#/definitions/WorkspaceProperties")
// interface Operations extends Azure.ResourceManager.Operations {}


@doc("Azure Machine Learning Services api versions.")
enum Versions {
  @doc("Azure Machine Learning Services api version 2024-01-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_01_01_preview: "2024-01-01-preview",
}
