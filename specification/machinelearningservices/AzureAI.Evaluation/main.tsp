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
@service({
  title: "Azure Machine Learning Evaluation Data Plane Service",
})
@server(
  "{endpoint}/evaluation/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}",
  "Machinelearning Services Evaluation APIs",
  {
    @doc("""
      Supported Azure-AI Evaluation endpoints.
      """)
    endpoint: url,

    @doc("The ID of the target subscription.")
    subscriptionId: string,

    @doc("The name of the Resource Group.")
    resourceGroupName: string,

    @doc("The name of the AI project.")
    workspaceName: string,
  }
)
@versioned(Versions)
namespace Microsoft.MachineLearningServices;

@doc("Azure Machine Learning Evaluation Data Plane Service api versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-05-01-preview version of the Microsoft.MachineLearningServices service.")
  `2024-05-01-preview`,
}
