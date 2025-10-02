import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@versioned(VoiceLive.Versions)
@service(#{ title: "VoiceLive"})
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | AadOauth2Auth<[
    "https://ai.azure.com/.default"
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

namespace VoiceLive;

/** API versioning. */
enum Versions {
  /** Version 2025-10-01. */
  v2025_10_01: "2025-10-01",
}