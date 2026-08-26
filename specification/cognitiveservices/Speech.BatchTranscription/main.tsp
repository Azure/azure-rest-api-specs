import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@service(#{ title: "Azure Speech BatchTranscription API" })
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
namespace Azure.Ai.Speech.BatchTranscription;

@doc("Service API versions.")
enum ServiceApiVersions {
  V20251015: "2025-10-15",
}
