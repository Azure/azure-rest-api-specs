import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

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
@service({
  title: "Batch Document Translation Client",
})
@server(
  "{endpoint}/translator/text/batch/v1.0",
  "Batch document translation service endpoint",
  {
    endpoint: string,
  }
)
@doc("Batch document translation service")
@versioned(DocumentTranslationClient.Versions)
namespace DocumentTranslationClient;

/** The Azure.AI.DocumentTranslation versions. */
enum Versions {
  /** DocumentTranslationClient versions. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `v1.0`,
}
