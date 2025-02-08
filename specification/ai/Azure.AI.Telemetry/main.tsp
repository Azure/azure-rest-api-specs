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
  "{endpoint}/agents/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{projectName}",  // This URL is for the Agents API.
  "Azure AI",
  {
    @doc("The Azure AI Foundry project endpoint, in the form `https://<azure-region>.api.azureml.ms` or `https://<private-link-guid>.<azure-region>.api.azureml.ms`, where <azure-region> is the Azure region where the project is deployed (e.g. westus) and <private-link-guid> is the GUID of the Enterprise private link.")
    endpoint: string,

    @doc("The Azure subscription ID.")
    subscriptionId: string,

    @doc("The name of the Azure Resource Group.")
    resourceGroupName: string,

    @doc("The Azure AI Foundry project name.")
    projectName: string,
  }
)
@versioned(Versions)
namespace Azure.AI.Telemetry {
  @doc("Azure AI API versions")
  enum Versions {
    @doc("Azure AI API version 2024-07-01-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `2024-07-01-preview`,
  }
}
