import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./connections/routes.tsp";
import "./evaluations/routes.tsp";
import "./datasets/routes.tsp";
import "./indexes/routes.tsp";
import "./deployments/routes.tsp";
import "./red-teams/routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style"
namespace Azure.AI {

}

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ai.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure AI" })
@server(
  "{endpoint}",
  "Azure AI",
  {
    @doc("""
      Project endpoint. In the form "https://your-ai-services-account-name.services.ai.azure.com/api/projects/_project"
      if your Foundry Hub has only one Project, or to use the default Project in your Hub. Or in the form 
      "https://your-ai-services-account-name.services.ai.azure.com/api/projects/your-project-name" if you want to explicitly
      specify the Foundry Project name.
      """)
    endpoint: url,
  }
)
@versioned(Versions)
namespace Azure.AI.Projects {
  @doc("Azure AI Projects API versions")
  enum Versions {
    @doc("Azure AI API version 2025-05-01.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v2025_05_01: "2025-05-01",

    @doc("Azure AI API version 2025-05-15-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v2025_05_15_preview: "2025-05-15-preview",

    @doc("Azure AI API version v1.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v1: "v1",
  }
}
