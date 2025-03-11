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
@service(#{ title: "Azure AI Face API" })
@versioned(Versions)
@server(
  "{endpoint}/face/{apiVersion}",
  "Azure AI Face API",
  {
    @doc("""
      Supported Cognitive Services endpoints (protocol and hostname, for example:
      https://{resource-name}.cognitiveservices.azure.com).
      """)
    endpoint: url,

    @doc("API Version")
    @path
    apiVersion: Versions,
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

@doc("API versions for Azure AI Face API.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("v1.1-preview.1")
  v1_1_preview_1: "v1.1-preview.1",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("v1.2-preview.1")
  v1_2_preview_1: "v1.2-preview.1",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("v1.2")
  v1_2: "v1.2",
}
