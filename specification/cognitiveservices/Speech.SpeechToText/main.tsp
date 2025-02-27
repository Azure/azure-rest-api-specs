import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./routes/batch.tsp";
import "./routes/fast.tsp";

using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

@service({
  title: "Azure Speech Services SpeechToText API",
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
  @TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
  V20241115: "2024-11-15",
}
