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
namespace Azure.AI.Agents {
  @doc("Azure AI Agents API versions")
  enum Versions {
    @doc("Azure AI API version 2025-05-15-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `2025-05-15-preview`,
  }
}
