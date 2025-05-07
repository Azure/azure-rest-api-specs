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

#suppress "@azure-tools/typespec-azure-core/casing-style"
namespace Azure.AI {

}

/* This is what I'm trying to do:
curl -X POST -v "https://management.azure.com/subscriptions/%AZURE_SUBSCRIPTION%/resourceGroups/%AZURE_RESOURCE_GROUP%/providers/Microsoft.MachineLearningServices/workspaces/%AI_STUDIO_HUB%/connections/%AI_STUDIO_CONNECTION%/listsecrets?api-version=%API_VERSION%" ^
-H "Content-Type: application/json" ^
-H "Authorization: Bearer %ENTRA_ID_TOKEN%" ^
-d "{\"subscriptionId\":\"%AZURE_SUBSCRIPTION%\",\"resourceGroupName\":\"%AZURE_RESOURCE_GROUP%\",\"workspaceName\":\"%AI_STUDIO_HUB%\",\"connectionName\":\"%AI_STUDIO_CONNECTION%\",\"api-version\":\"%API_VERSION%\"}"
*/
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
namespace Azure.AI.Client {
  @doc("Azure AI API versions")
  enum Versions {
    @doc("Azure AI API version 2024-07-01-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `2024-07-01-preview`,
  }
}
