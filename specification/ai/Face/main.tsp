import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.common.tsp";
import "./routes.detection.tsp";
import "./routes.recognition.tsp";
import "./routes.facelist.tsp";
import "./routes.persondirectory.tsp";
import "./routes.persongroup.tsp";
import "./routes.session.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@useAuth(KeyAuth | AADToken)
@service({
  title: "Azure AI Face API",
})
@versioned(Versions)
@server(
  "{endpoint}",
  "Azure AI Face API",
  {
    @doc("""
Supported Cognitive Services endpoints (protocol and hostname, for example:
https://{resource-name}.cognitiveservices.azure.com).
""")
    endpoint: string,
  }
)
namespace Face;

@doc("The secret key for your Azure AI Face subscription.")
model KeyAuth is ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style for AAD"
@doc("The Azure Active Directory OAuth2 Flow")
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode;
      authorizationUrl: "https://api.example.com/oauth2/authorize";
      tokenUrl: "https://api.example.com/oauth2/token";
      scopes: ["https://cognitiveservices.azure.com/.default"];
    }
  ]>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v1_1_preview_1: "v1.1-preview.1",
}
