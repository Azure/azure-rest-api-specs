import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./routes.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Azure Speech Transcription API" })
@useAuth(
  ApiKeyAuth<
    ApiKeyLocation.header,
    "Ocp-Apim-Subscription-Key"
  > | AadOauth2Auth<["https://cognitiveservices.azure.com/.default"]>
)
@server(
  "{endpoint}/speechtotext",
  "Azure Speech Services APIs for speech-to-text",
  {
    @doc("Supported Cognitive Services endpoints (protocol and hostname, for example: https://westus.api.cognitive.microsoft.com).")
    endpoint: url,
  }
)
@versioned(ServiceApiVersions)
namespace Azure.Ai.Speech.Transcription;

@doc("Service API versions.")
enum ServiceApiVersions {
  V20251015: "2025-10-15",
}
