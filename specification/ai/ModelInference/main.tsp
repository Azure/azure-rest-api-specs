import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@useAuth(

    | ApiKeyAuth<ApiKeyLocation.header, "api-key">
    | BearerAuth
    | OAuth2Auth<[
        {
          type: OAuth2FlowType.implicit,
          authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
          scopes: ["https://cognitiveservices.azure.com/.default"],
        }
      ]>
)
@doc("""
  **Deprecated**: The Azure AI Model Inference API is deprecated and will be retired in the future.
  Migrate to the OpenAI API, which provides equivalent functionality with broader model support and
  unified SDK access. For migration guidance, see
  [How to migrate from Azure AI Inference SDK to OpenAI SDK](https://learn.microsoft.com/azure/foundry/how-to/model-inference-to-openai-migration).
  """)
@service(#{ title: "AI Model Inference" })
@server(
  "https://{resource}.services.ai.azure.com/models",
  "AI Model Inference",
  {
    @doc("The Azure AI Services resource name, for example 'my-resource'")
    resource: string,
  }
)
@versioned(ModelInference.Versions)
namespace ModelInference;

@doc("The AI.Model service versions.")
enum Versions {
  @doc("The 2024-05-01-preview version of the AI.Model service.")
  v2024_05_01_Preview: "2024-05-01-preview",
}
