import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./agents/main.tsp";
import "./threads/main.tsp";
import "./messages/main.tsp";
import "./runs/main.tsp";
import "./run_steps/main.tsp";
import "./files/main.tsp";
import "./streaming/events.tsp";
import "./endpoints/routes.tsp";
import "./evaluations/routes.tsp";
import "./vector_stores/main.tsp";

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
  "{endpoint}/{subscriptionId}/{resourceGroupName}/{workspaceName}",  // This URL is a placeholder only. It is not used by emitted SDKs. SDKs have custom code to contruct conneciton URLs for different operations.
  "Azure AI",
  {
    @doc("The Azure AI Studio project endpoint, in the form `https://<azure-region>.api.azureml.ms` or `https://<private-link-guid>.<azure-region>.api.azureml.ms`, where <azure-region> is the Azure region where the project is deployed (e.g. westus) and <private-link-guid> is the GUID of the Enterprise private link.")
    endpoint: string,

    @doc("The Azure subscription ID.")
    subscriptionId: string,

    @doc("The name of the Azure Resource Group.")
    resourceGroupName: string,

    @doc("The name of the Azure AI Studio hub.")
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
