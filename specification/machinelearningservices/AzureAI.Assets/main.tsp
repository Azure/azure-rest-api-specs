import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;


@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ml.azure.com/"],
    }
  ]>
)
@service({
  title: "Azure Machine Learning Services",
})
@server(
  "{endpoint}/assets/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}",
  "Machinelearning Services Asset APIs",
  {
    @doc("""
Supported Azure-AI asset endpoints.
""")
    endpoint: string,

    @doc("The ID of the target subscription.")
    subscriptionId: string,

    @doc("The name of the Resource Group.")
    resourceGroupName: string,
  }
)
@versioned(Versions)
namespace Microsoft.MachineLearningServices;

@doc("Azure Machine Learning Services api versions.")
enum Versions {
  @doc("Azure Machine Learning Services api version 2024-03-01-preview.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2024-03-01-preview`,
}