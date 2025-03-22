import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./agents/routes.tsp";
import "./connections/routes.tsp";
import "./evaluations/routes.tsp";
import "./datasets/routes.tsp";
import "./indexes/routes.tsp";
import "./deployments/routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
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
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure AI",
})
@server(
  "{endpoint}",
  "Azure AI",
  {
    @doc("""
      Project endpoint in the form of: https://<aiservices-id>.services.ai.azure.com/projects/<project-name>
      """)
    endpoint: url,
  }
)
@versioned(Versions)
namespace Azure.AI.Projects {
  @doc("Azure AI API versions")
  enum Versions {
    @doc("Azure AI API version 2025-05-01-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `2025-05-01-preview`,
  }
}
