import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./assistants/routes.tsp";
import "./assistants/threads/routes.tsp";
import "./assistants/messages/routes.tsp";
import "./assistants/runs/routes.tsp";
import "./assistants/run_steps/routes.tsp";
import "./assistants/files/routes.tsp";
import "./assistants/streaming/events.tsp";
import "./assistants/vector_stores/routes.tsp";
import "./assistants/vector_stores/files/routes.tsp";
import "./assistants/vector_stores/file_batches/routes.tsp";
import "./connections/routes.tsp";
import "./evaluations/routes.tsp";
import "./datasets/routes.tsp";
import "./indexes/routes.tsp";
import "./deployments/routes.tsp";
import "./evaluation-results/routes.tsp";

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
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure AI" })
@server(
  "{endpoint}",
  "Azure AI",
  {
    @doc("""
      Project endpoint in the form of: https://<aiservices-id>.services.ai.azure.com/api/projects/<project-name>
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
