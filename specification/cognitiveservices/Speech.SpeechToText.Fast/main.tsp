import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";

import "./routes/fast/transcriptions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

@service({
  title: "Azure Speech Services API",
})
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@server(
  "{endpoint}/speechtotext",
  "Azure Speech Services APIs for speech-to-text",
  {
    @doc("Supported Cognitive Services endpoints (protocol and hostname, for example: https://westus.api.cognitive.microsoft.com.")
    endpoint: string,
  }
)
@versioned(ServiceApiVersions)
namespace SpeechToText;

@doc("Service API versions.")
enum ServiceApiVersions {
  V20240515PRE: "2024-05-15-preview", // Preview versions are only generated, if the newest version is also a preview version.
  V20241115: "2024-11-15",
}
