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
      scopes: ["https://management.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure AI Runtime Service",
})
@server(
  "{endpoint}/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}",
  "Machinelearning AI Runtime APIs",
  {
    @doc("""
      Supported Azure AI Runtime endpoint.
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
@versioned(Versions)
namespace Azure.Ai.Runtime;

@doc("Azure AI Runtime Services api versions.")
enum Versions {
  @doc("Azure AI Runtime Service api version 2024-07-01-preview.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_07_01_preview: "2024-07-01-preview",
}
