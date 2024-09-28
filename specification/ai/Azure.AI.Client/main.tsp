import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./endpoints/routes.tsp";
import "./agents/routes.tsp";
import "./evaluations/routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://management.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure AI",
})
@server(
  "https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}",
  "Azure AI",
  {
    @doc("The ID of the target subscription.")
    subscriptionId: string,

    @doc("The name of the Resource Group.")
    resourceGroupName: string,

    @doc("The name of the workspace (Azure AI Studio hub).")
    workspaceName: string,
  }
)
@versioned(Versions)
namespace AzureAI {
  @doc("Azure AI API versions")
  enum Versions {
    @doc("Azure AI API version 2024-07-01-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `2024-07-01-preview`,
  }
}

@server(
  "https://{region}.api.azureml.ms/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}",
  "Azure AI",
  {
    @doc("The region of the workspace.")
    region: string,

    @doc("The ID of the target subscription.")
    subscriptionId: string,

    @doc("The name of the Resource Group.")
    resourceGroupName: string,

    @doc("The name of the workspace (Azure AI Studio hub).")
    workspaceName: string,
  }
)
@versioned(Versions)
namespace AzureAI.Evaluations {
  @doc("Azure AI API versions")
  enum Versions {
    @doc("Azure AI API version 2024-07-01-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `2024-07-01-preview`,
  }
}

