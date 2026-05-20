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
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ml.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure Machine Learning Data Plane Services" })
@server(
  "{endpoint}/genericasset/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices",
  "Machinelearning Services Asset APIs",
  {
    @doc("""
      Supported Azure-AI asset endpoints.
      """)
    endpoint: url,

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
  @doc("Azure Machine Learning Services api version 2024-04-01-preview.")
  `2024-04-01-preview`,

  @doc("Azure Machine Learning Services api version 2024-05-01-preview.")
  `2024-05-01-preview`,
}
