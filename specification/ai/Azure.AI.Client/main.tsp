import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";

import "./agents/routes.tsp";
import "./assistants/routes.tsp";
import "./endpoints/routes.tsp";
import "./evaluations/routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

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

@versioned(ServiceApiVersions)
@doc("Azure APIs for Agents.")
namespace Azure.AI.Client.Agents {
  @doc("The known set of supported API versions.")
  enum ServiceApiVersions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The initial version of Azure OpenAI Assistants that corresponds to functionality in OpenAI's first beta release.")
    v2024_02_15_preview: "2024-02-15-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The May 2024 preview release for Azure OpenAI, including the first availability of assistants V2.")
    v2024_05_01_preview: "2024-05-01-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The July 2024 preview release for Azure OpenAI.")
    v2024_07_01_preview: "2024-07-01-preview",
  }
}