import "@typespec/http";
import "@typespec/versioning";

import "./routes/common.tsp";
import "./routes/audio_speech.tsp";
import "./routes/audio_transcription.tsp";
import "./routes/audio_translation.tsp";
import "./routes/completions.tsp";
import "./routes/images.tsp";
import "./routes/embeddings.tsp";

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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum ServiceApiVersions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_12_01: "2022-12-01",

  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_05_15: "2023-05-15",

  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_06_01_Preview: "2023-06-01-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_07_01_Preview: "2023-07-01-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_15_Preview: "2024-02-15-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_03_01_Preview: "2024-03-01-preview",
}
