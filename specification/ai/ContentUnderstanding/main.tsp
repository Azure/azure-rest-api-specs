import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";
import "./personDirectoryRoutes.tsp";
import "./models.tsp";
import "./documentContent.tsp";
import "./audioVisualContent.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@doc("The Content Understanding service extracts content and fields from multimodal input.")
@useAuth(AzureKey | EntraIdToken)
@service(#{ title: "Content Understanding" })
@server(
  "{endpoint}/contentunderstanding",
  "The Content Understanding service extracts content and fields from multimodal input.",
  {
    @doc("Content Understanding service endpoint.")
    endpoint: url,
  }
)
@versioned(ContentUnderstanding.Versions)
namespace ContentUnderstanding;

@doc("Key-based authentication using the access key of the Azure resource.")
model AzureKey
  is ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

@doc("Microsoft Entra ID OAuth2 authentication using an access token.")
model EntraIdToken
  is Azure.Core.AadOauth2Auth<["https://cognitiveservices.azure.com/.default"]>;

@doc("Service API versions.")
enum Versions {
  // @doc("The 2024-12-01-preview version of the Content Understanding service.")
  // v2024_12_01_preview: "2024-12-01-preview",

  // @doc("The 2025-05-01-preview version of the Content Understanding service.")
  // v2025_05_01_preview: "2025-05-01-preview",

  @doc("The 2025-11-01 version of the Content Understanding service.")
  v2025_11_01: "2025-11-01",
}
