import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";
import "./threads/routes.tsp";
import "./messages/routes.tsp";
import "./runs/routes.tsp";
import "./run_steps/routes.tsp";
import "./files/routes.tsp";
import "./streaming/events.tsp";
import "./vector_stores/routes.tsp";
import "./vector_stores/files/routes.tsp";
import "./vector_stores/file_batches/routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style"
namespace Azure.AI {

}

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@useAuth(
  BearerAuth | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      // 1DP uses Entra ID with cognitiveservices.azure.com scope, however, we are currently calling the old service.
      // scopes: ["https://cognitiveservices.azure.com/.default"],
      scopes: ["https://management.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure AI" })
@server(
  "{endpoint}/agents/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{projectName}",
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
namespace Azure.AI.Assistants {
  @doc("Azure AI Assistants API versions")
  enum Versions {
    @doc("Azure AI API version 2025-05-01-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `latest`,
  }
}
