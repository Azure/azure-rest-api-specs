import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";

import "./routes/batch/transcriptions.tsp";
import "./routes/fast/transcriptions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

@service({
  title: "Azure Speech Services API",
})
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | ApiKeyAuth<
    ApiKeyLocation.header,
    "Authorization"
  >
)
@server(
  "{endpoint}/speechtotext",
  "Azure Speech Services APIs for speech-to-text",
  {
    @doc("Supported Cognitive Services endpoints (protocol and hostname, for example: https://westus.api.cognitive.microsoft.com.")
    endpoint: string,
  }
)
@versioned(ServiceApiVersions)
namespace Azure.Speech.SpeechToText;

enum ServiceApiVersions {
  V20240515PRE: "2024-05-15-preview",
  V20241115: "2024-11-15",
}

model Pageable<T> {
  @doc("A list of entities limited by either the passed query parameters 'skip' and 'top' or their default values.\r\n            \r\nWhen iterating through a list using pagination and deleting entities in parallel, some entities will be skipped in the results.\r\nIt's recommended to build a list on the client and delete after the fetching of the complete list.")
  @visibility("read")
  values?: Array<T>;

  @doc("A link to the next set of paginated results if there are more entities available; otherwise null.")
  @visibility("read")
  `@nextLink`?: url;
}
