import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@service(#{ title: "Azure Speech Transcription API" })
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@server(
  "{endpoint}",
  "Azure Speech Services APIs for speech-to-text",
  {
    @doc("Supported Cognitive Services endpoints including the service path (for example: https://westus.api.cognitive.microsoft.com/speechtotext). Note: The endpoint should include the '/speechtotext' path.")
    endpoint: url,
  }
)
@versioned(ServiceApiVersions)
namespace Azure.Ai.Speech.Transcription;

@doc("Service API versions.")
enum ServiceApiVersions {
  @TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
  V20251015: "2024-11-15",
}
