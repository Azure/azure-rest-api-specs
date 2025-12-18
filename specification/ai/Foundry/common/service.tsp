import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Versioning;

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
      Foundry Project endpoint in the form
      "https://{ai-services-account-name}.services.ai.azure.com/api/projects/{project-name}".
      If you only have one Project in your Foundry Hub, or to target the default Project
      in your Hub, use the form
      "https://{ai-services-account-name}.services.ai.azure.com/api/projects/_project"
      """)
    endpoint: url,
  }
)
@versioned(Versions)
namespace Azure.AI.Projects {
  @doc("Azure AI Projects API versions")
  enum Versions {
    @doc("Azure AI API version 2025-05-01.")
    v2025_05_01: "2025-05-01",

    @doc("Azure AI API version 2025-05-15-preview.")
    v2025_05_15_preview: "2025-05-15-preview",

    @doc("Azure AI API version 2025-11-15-preview.")
    v2025_11_15_preview: "2025-11-15-preview",

    @doc("Azure AI API version v1.")
    v1: "v1",
  }
}
