import "@typespec/http";
import "@typespec/versioning";

import "./routes/audio_transcription.tsp";
import "./routes/completions.tsp";
import "./routes/embeddings.tsp";
import "./routes/image_generation.tsp";
import "./routes/commons.tsp";
import "./service_versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure OpenAI API",
})
@server(
  "{endpoint}/openai",
  "Azure OpenAI APIs for completions and search",
  {
    @doc("""
Supported Cognitive Services endpoints (protocol and hostname, for example:
https://westus.api.cognitive.microsoft.com).
""")
    endpoint: string,
  }
)
@versioned(ServiceApiVersions)
@doc("Azure OpenAI APIs for completions and search")
namespace Azure.OpenAI;
