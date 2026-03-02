import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * Custom voice API to create and deploy your voice.
 */
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Custom voice API" })
@versioned(Versions)
@server(
  "{endpoint}/customvoice",
  "Custom voice API to create and deploy your voice.",
  {
    /**
     * Supported Cognitive Services endpoints (protocol and hostname, for example:
     * https://eastus.api.cognitive.microsoft.com).
     */
    endpoint: url,
  }
)
namespace CustomvoiceAPI;

/** The available API versions. */
enum Versions {
  /** The 2026-01-01 API version. */
  v2026_01_01: "2026-01-01",
}
