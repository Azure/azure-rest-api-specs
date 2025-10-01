import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";
import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "VoiceLive"})
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | AadOauth2Auth<[
    "https://cognitiveservices.azure.com/.default"
  ]>
)
@server(
  "{endpoint}/voice-agent/realtime",
  "VoiceLive Endpoint",
  {
    /** Azure AI VoiceLive endpoint. */
    endpoint: url,
  }
)

@versioned(VoiceLive.Versions)
namespace VoiceLive{}