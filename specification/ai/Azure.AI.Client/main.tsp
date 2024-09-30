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
namespace Azure.AI {

}

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
  ""{endpoint}/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}",
  "Azure AI",
  {
    @doc("Azure AI Project endpoint.")
    endpoint: url = "https://management.azure.com",

    @doc("Azure AI Project subscription ID.")
    subscriptionId: string,

    @doc("Azure AI Project resource group name.")
    resourceGroupName: string,

    @doc("Azure AI Project workspace name.")
    workspaceName: string,
  }
)
@versioned(Versions)
namespace Azure.AI.Client {
  @doc("Azure AI API versions")
  enum Versions {
    @doc("Azure AI API version 2024-07-01-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `2024-07-01-preview`,
  }
}
