import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

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
  title: "Azure Machine Learning Data Plane Services",
})
@server(
  "{endpoint}/raisvc/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}",
  "Machinelearning Services RAISvc APIs",
  {
    @doc("""
      Supported Azure-AI endpoints.
      """)
    endpoint: url,

    @doc("The ID of the target subscription.")
    subscriptionId: string,

    @doc("The name of the Resource Group.")
    resourceGroupName: string,

    @doc("The name of the AzureML workspace or AI project.")
    workspaceName: string,
  }
)
@versioned(Microsoft.MachineLearningServices.Versions)
namespace Microsoft.MachineLearningServices;

@doc("The  Microsoft.MachineLearningServices service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2022-11-01-preview version of the  Microsoft.MachineLearningServices service.")
  `2022-11-01-preview`,
}
