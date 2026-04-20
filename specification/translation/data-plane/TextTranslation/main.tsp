import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-autorest/unsupported-auth" "NoAuth is supported"
@service(#{ title: "Text Translation" })
@useAuth(
  NoAuth | ApiKeyAuth<
    ApiKeyLocation.header,
    "Ocp-Apim-Subscription-Key"
  > | OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@server(
  "{Endpoint}",
  "Text translation is a cloud-based REST API feature of the Translator service that uses neural machine translation technology to enable quick and accurate source-to-target text translation in real time across all supported languages.",
  {
    @doc("""
      Supported Text Translation endpoints (protocol and hostname, for example:
          https://api.cognitive.microsofttranslator.com).
      """)
    Endpoint: url,
  }
)
@doc("""
  Azure Translator is a cloud-based, multilingual, neural machine translation service. The Text Translation API enables robust and scalable translation capabilities suitable for diverse applications.
  """)
@versioned(APIVersion)
namespace TextTranslation;

@doc("Text Translation supported versions")
enum APIVersion {
  @doc("Version 3.0")
  v3_0: "3.0",

  @doc("Version 2025-10-01")
  v2025_10_01_preview: "2025-10-01-preview",

  @doc("Version 2026-06-06")
  v2026_06_06: "2026-06-06",
}
