import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

@doc("Extracts content, layout, and structured data from documents.")
@versioned(DocumentIntelligence.Versions)
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Document Intelligence (formerly Form Recognizer)" })
@server(
  "{endpoint}/documentintelligence",
  "Extracts content, layout, and structured data from documents.",
  {
    @doc("The Document Intelligence service endpoint.")
    endpoint: url,
  }
)
namespace DocumentIntelligence;

@doc("Service API versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-11-30 GA version of the DocumentIntelligence service.")
  v2024_11_30: "2024-11-30",
}
